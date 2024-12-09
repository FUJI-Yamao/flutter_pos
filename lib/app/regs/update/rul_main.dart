/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../lib/apllib/competition_ini.dart';
import '../../inc/sys/tpr_log.dart';
import '../../ui/enum/e_screen_kind.dart';

///  MainIsolate側の実績上げ制御クラス
class RulMupdConsole {
  ///  定数：営業日の初期値
  static const String defaultSaleDate = '0000-00-00';
  ///  実績上げ（ローカル）Isolateとの通信ポート
  ///  補足説明：実績上げ（マスタ）Isolateとの通信ポートは別のクラスで管理
  SendPort? comPort;
  ///  実績上げ（ローカル・マスタ）Isolateの中断フラグ
  ///  true：実績上げ処理繰り返して実行、false：実績上げ処理一時中止
  bool _stopRulIsolate = false;

  static final RulMupdConsole _instance = RulMupdConsole._internal();
  factory RulMupdConsole() {
    return _instance;
  }
  RulMupdConsole._internal();

  ///  現在の営業日を取得する処理
  ///  '0000-00-00'を返す場合、実績上げ（ローカル・マスタ）両方のIsolateともに一時中止となる
  Future<String> getSaleDate() async {
    if (_stopRulIsolate) {
      return defaultSaleDate;
    } else {
      CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
          0, CompetitionIniLists.COMPETITION_INI_SALE_DATE,
          CompetitionIniType.COMPETITION_INI_GETSYS);
      return ret.value.substring(0, 10);
    }
  }

  ///  実績上げ（ローカル）Isolateに最新の営業日情報を送信する処理
  void sendNewestSaleDate() async {
    if (comPort == null) {
      return;
    }
    comPort!.send(await getSaleDate());
  }

  /// stopRul()：実績上げ処理を中断させたい場合、MainIsolateの中で使う
  void stopRul() async {
    if (comPort == null) {
      return;
    }
    _stopRulIsolate = true;
  }

  /// resumeRul()：一度手動で中断させた実績上げ処理を再開する際、MainIsolateの中で使う
  void resumeRul() async {
    if (comPort == null) {
      return;
    }
    _stopRulIsolate = false;
  }
}

///　「実績上げ（ローカル）」処理
/// 関連tprxソース:なし、新作処理（既存のrul_main.cとの関連性が低い）
class RulMainIsolate {
  ///  実績上げ（ローカル）が管理している営業日情報
  String _presSaleDate = RulMupdConsole.defaultSaleDate;
  ///  改行マーク
  static const String lineBreaker = r'\n';
  ///  シングルバックスラッシュ
  static const String singleBackslash = r'\';
  ///  ダブルバックスラッシュ
  static const String doubleBackslash = r'\\';
  ///  MainIsolateとの通信用ポート
  SendPort? _appSendPort;

  /// 「実績上げ」メイン処理関数
  void rulMain (List<dynamic> args) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(args[1] as RootIsolateToken);
    var db = DbManipulationPs();
    await db.openDB();
    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;
    SendPort parentSendPort = args[0] as SendPort;
    parentSendPort.send(sendPort);
    _appSendPort = await receivePort.first as SendPort;
    // ログ設定
    TprLog().setIsolateName("RulMain", args[3] as ScreenKind);
    TprLog().logPort = args[2] as SendPort;
    TprLog().sendWaitListLog();
    bool startFlg = true;

    /// 実績上げのメインとなるループ処理
    while (true) {
      if (RulMupdConsole.defaultSaleDate == _presSaleDate) {
        // 営業日未確定、5sでリトライ
        await Future.delayed(const Duration(seconds: 5));
        _presSaleDate = await receiveNew(_appSendPort!);
        continue;
      }

      if (startFlg) {
        // 実績上げ（ローカル）の始動、ログの出力は一回のみ
        TprLog().logAdd(Tpraid.TPRAID_MUPD, LogLevelDefine.normal, "***********************[RulMain(実績上げ・ローカル)] start***********************");
        startFlg = false;
      }

      // 対象データをp_sales_logから取得
      String sqlPLogQuery = "SELECT * FROM p_sales_log WHERE sale_date = @p1 AND tran_flg IN (0,2) ORDER BY tran_flg LIMIT 1";
      Map<String, dynamic>? subValues = {
        "p1": _presSaleDate
      };
      Result pLogRes = await db.dbCon.execute(
        Sql.named(sqlPLogQuery), parameters: subValues);
      if (pLogRes.isEmpty) {
        // p_sales_logから取得したデータが0件の場合、3s間のsleepで再び営業日取得からやり直す
        _presSaleDate = RulMupdConsole.defaultSaleDate;
        await Future.delayed(const Duration(seconds: 3));
        continue;
      }

      // 対象データの実績上げを実行する
      Map<String, dynamic> orgData = pLogRes[0].toColumnMap();
      String serialNo = orgData["serial_no"];
      String cartId = orgData["cart_id"].toString();
      Map<String, dynamic>? saleJsonLog;
      bool errFlg = false;
      if (orgData["sale_json_log"] != null) {
        saleJsonLog = orgData["sale_json_log"];
        if (saleJsonLog!.isEmpty) {
          // p_sales_logにデータがあっても対象項目の中身がない場合でも営業日取得からやり直す
          _presSaleDate = RulMupdConsole.defaultSaleDate;
          await Future.delayed(const Duration(seconds: 3));
          continue;
        }
        // sale_json_logからそれぞれのinsert文を取り出す
        List<String>? rStatusLogSqlList;
        List<String>? rDataLogSqlList;
        List<String>? rEjLogSqlList;
        List<String>? rHeaderLogSqlList;
        List<String>? rVoidLogSqlList;
        if (saleJsonLog['rStatusLog'] != null) {
          if (saleJsonLog['rStatusLog'] is Iterable) {
            rStatusLogSqlList = List<String>.from(saleJsonLog['rStatusLog']);
          } else {
            rStatusLogSqlList = List<String>.filled(1, saleJsonLog['rStatusLog']);
          }
        }
        if (saleJsonLog['rDataLog'] != null) {
          if (saleJsonLog['rDataLog'] is Iterable) {
            rDataLogSqlList = List<String>.from(saleJsonLog['rDataLog']);
          } else {
            rDataLogSqlList = List<String>.filled(1, saleJsonLog['rDataLog']);
          }
        }
        if (saleJsonLog['rEjLog'] != null) {
          if (saleJsonLog['rEjLog'] is Iterable) {
            rEjLogSqlList = List<String>.from(saleJsonLog['rEjLog']);
          } else {
            rEjLogSqlList = List<String>.filled(1, saleJsonLog['rEjLog']);
          }
        }
        if (saleJsonLog['rHeaderLog'] != null) {
          if (saleJsonLog['rHeaderLog'] is Iterable) {
            rHeaderLogSqlList = List<String>.from(saleJsonLog['rHeaderLog']);
          } else {
            rHeaderLogSqlList = List<String>.filled(1, saleJsonLog['rHeaderLog']);
          }
        }
        if (saleJsonLog['rVoidLog'] != null) {
          if (saleJsonLog['rVoidLog'] is Iterable) {
            rVoidLogSqlList = List<String>.from(saleJsonLog['rVoidLog']);
          } else {
            rVoidLogSqlList = List<String>.filled(1, saleJsonLog['rVoidLog']);
          }
        }

        try {
          await db.dbCon.runTx((txn) async {
            if (rStatusLogSqlList != null) {
              for (String singleSql in rStatusLogSqlList) {
                if (singleSql.isNotEmpty) {
                  if (singleSql.endsWith(lineBreaker)) {
                    await txn.execute(Sql.named(singleSql.substring(0, singleSql.length - lineBreaker.length)));
                  } else {
                    await txn.execute(Sql.named(singleSql));
                  }
                }
              }
            }
            if (!errFlg && (rDataLogSqlList != null)) {
              for (String singleSql in rDataLogSqlList) {
                if (singleSql.isNotEmpty) {
                  if (singleSql.endsWith(lineBreaker)) {
                    await txn.execute(Sql.named(singleSql.substring(0, singleSql.length - lineBreaker.length)));
                  } else {
                    await txn.execute(Sql.named(singleSql));
                  }
                }
              }
            }
            if (!errFlg && (rEjLogSqlList != null)) {
              for (String singleSql in rEjLogSqlList) {
                // c_ej_log系テーブルのinsert文に対する特別措置
                List<String> lines = List<String>.from(LineSplitter.split(singleSql));
                // insert文が不意に複数行までに分割された場合、ここで再び連結
                if (lines.length > 1) {
                  StringBuffer nonLineBreakSql = StringBuffer();
                  // 生文字列リテラル「\\」が「\」になってしまった場合の復元処理
                  lines.asMap().forEach((int idx, String val) => (lines[idx] = val.replaceAll(singleBackslash,doubleBackslash)));
                  nonLineBreakSql.writeAll(lines, lineBreaker);
                  String revisedSql = nonLineBreakSql.toString();
                  if (revisedSql.endsWith(lineBreaker)) {
                    await txn.execute(Sql.named(revisedSql.substring(0, revisedSql.length - lineBreaker.length)));
                  } else {
                    await txn.execute(Sql.named(revisedSql));
                  }
                } else {
                  if (singleSql.isNotEmpty) {
                    if (singleSql.endsWith(lineBreaker)) {
                      await txn.execute(Sql.named(singleSql.substring(0, singleSql.length - lineBreaker.length)));
                    } else {
                      await txn.execute(Sql.named(singleSql));
                    }
                  }
                }
              }
            }
            if (!errFlg && (rHeaderLogSqlList != null)) {
              for (String singleSql in rHeaderLogSqlList) {
                if (singleSql.isNotEmpty) {
                  if (singleSql.endsWith(lineBreaker)) {
                    await txn.execute(Sql.named(singleSql.substring(0, singleSql.length - lineBreaker.length)));
                  } else {
                    await txn.execute(Sql.named(singleSql));
                  }
                }
              }
            }
            if (!errFlg && (rVoidLogSqlList != null)) {
              for (String singleSql in rVoidLogSqlList) {
                if (singleSql.isNotEmpty) {
                  if (singleSql.endsWith(lineBreaker)) {
                    await txn.execute(Sql.named(singleSql.substring(0, singleSql.length - lineBreaker.length)));
                  } else {
                    await txn.execute(Sql.named(singleSql));
                  }
                }
              }
            }
          });
        } catch (e, s) {
          // 「sale_json_log」に格納されているSQLテキスト自体に不備がある、予想外のDBエラーなどの場合
          errFlg = true;
          debugPrint('[RulMainIsolate.rulMain()] Error occurred while executing SQL : ${e.toString()} ${s.toString()}');
          TprLog().logAdd(Tpraid.TPRAID_MUPD, LogLevelDefine.error, "[RulMain] local error : ${e.toString()} ${s.toString()}");
        }
      }
      // 対象データのsale_json_logの処理が一通り完了後、当該データ自体のtran_flgを更新する
      try {
        String sqlPLogUpd = "UPDATE p_sales_log SET tran_flg = @p1, upd_datetime = LOCALTIMESTAMP(0) WHERE serial_no = cast(@p2 as numeric) AND cart_id = @p3";
        Map<String, dynamic>? updValues = {
          // SQL文のどれか一つでもエラーになった場合、tran_flgを「2」にする（全件正常終了か、最初からsale_json_logの値がnullの場合のみ「1」に更新）
          "p1": errFlg ? 2 : 1,
          // PK (serial_no)
          "p2": serialNo,
          // PK (cart_id)
          "p3": cartId
        };

        await db.dbCon.execute(Sql.named(sqlPLogUpd), parameters: updValues);
      } catch (e, s) {
        debugPrint('[RulMainIsolate.rulMain()] Error occurred while update p_sales_log : ${e.toString()} ${s.toString()}');
        TprLog().logAdd(Tpraid.TPRAID_MUPD, LogLevelDefine.error, "[RulMain] update p_sales_log failed : ${e.toString()} ${s.toString()}");
      }
      // 対象データの実績上げが行われて500msのsleepで再び最初から実行する
      await Future.delayed(const Duration(milliseconds: 500));
      _presSaleDate = RulMupdConsole.defaultSaleDate;
      continue;
    }
  }

  // MainIsolateと通信用
  Future receiveNew(SendPort sendPort) async {
    ReceivePort resp = ReceivePort();
    sendPort.send(resp.sendPort);
    return resp.first;
  }
}