/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as ioc;
import 'package:sprintf/sprintf.dart';

import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cls_conf/configJsonFile.dart';
import '../../common/cls_conf/sys_paramJsonFile.dart';
import '../../common/environment.dart';
import '../../inc/sys/tpr_log.dart';
import '../../regs/update/rul_main.dart';
import '../../ui/enum/e_screen_kind.dart';

///  MainIsolate側の実績上げ（マスタ）専用の制御クラス
class MupdCConsole {
  ///  実績上げ（マスタ）Isolateとの通信ポート
  ///  補足説明：実績上げ（ローカル）Isolateとの通信ポートは別のクラスで管理
  SendPort? comPort;

  /// TSサーバーとの接続がオンラインかのフラグ
  bool _isTsServerOnline = true;

  /// ステータス通知のコールバック関数
  Function(bool)? _onStatusCallback;

  static final MupdCConsole _instance = MupdCConsole._internal();
  factory MupdCConsole() {
    return _instance;
  }
  MupdCConsole._internal();

  ///  実績上げ（マスタ）Isolateに最新の営業日情報を送信する処理
  void sendNewestSaleDate() async {
    if (comPort == null) {
      return;
    }
    comPort!.send(await RulMupdConsole().getSaleDate());
  }

  /// 実績上げのステータス通知のコールバック
  void onStatusCallback(bool isOnline) {
    // 保持している状態と異なる時にコールバックを実行する
    if (_isTsServerOnline != isOnline) {
      _isTsServerOnline = isOnline;
      _onStatusCallback?.call(_isTsServerOnline);
    }
  }

  /// 実績上げのステータス通知のコールバック登録
  void registerStatusCallback(Function(bool) callback) {
    _onStatusCallback = callback;
    // 現在の状態をコールバックで通知する
    _onStatusCallback?.call(_isTsServerOnline);
  }

  /// 実績上げのステータス通知のコールバック登録
  void removeStatusCallback() {
    _onStatusCallback = null;
  }
}

///　「実績上げ（マスタ）」処理
///  関連tprxソース:なし、新作処理（既存のmupdC.cとの関連性が低い）
class MupdCIsolate {

  static const UPDERRLOG_SINGLE_DATA = "%04d-%02d-%02d %02d:%02d:%02d\tError occured.SQL text dumped as below:\n%s\n";

  ///  実績上げ（マスタ）が管理している営業日情報
  String _presSaleDate = RulMupdConsole.defaultSaleDate;

  ///  webAPIサーバーにログインするためのユーザー名
  static const String authUsername = 't800001';

  ///  webAPIサーバーにログインするためのパスワード
  static const String authPassword = 'teraoka';

  ///  webAPIサーバーと通信用のrealm
  // TODO:00011 周 暫定、要QA
  static const String realmMupdC = 'realmForMupdC';

  ///  正常終了の戻り値
  static const SUCCESS_RETURNED_BY_SERVER = '0';

  ///  webAPIサーバーのURL
  static Uri uriMupdC = Uri();

  ///  ローカルにある対象ログファイルのフルパス
  static const String logFile = '/ts2100/appl/htdocs/cxs/json/logfull_OC1.json';

  ///  MainIsolateとの通信用ポート
  SendPort? _appSendPort;

  /// 「実績上げ」メイン処理関数
  void mupdCMain(List<dynamic> args) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(
        args[1] as RootIsolateToken);
    var db = DbManipulationPs();
    await db.openDB();
    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;
    SendPort parentSendPort = args[0] as SendPort;
    parentSendPort.send(sendPort);
    _appSendPort = await receivePort.first as SendPort;
    HttpClient authenticatingClient = HttpClient();
    uriMupdC = await getUrl();
    authenticatingClient.addCredentials(uriMupdC, realmMupdC,
        HttpClientDigestCredentials(authUsername, authPassword));
    http.Client client = ioc.IOClient(authenticatingClient);
    Map<String, dynamic>? targetLog = {};
    // ログ設定
    TprLog().setIsolateName("MupdC", args[3] as ScreenKind);
    TprLog().logPort = args[2] as SendPort;
    TprLog().sendWaitListLog();
    bool startFlg = true;

    while (true) {
      targetLog.clear();
      int tranFlg = 1;
      if (RulMupdConsole.defaultSaleDate == _presSaleDate) {
        // 営業日未確定、5sでリトライ
        await Future.delayed(const Duration(seconds: 5));
        _presSaleDate = await receiveNew(_appSendPort!);
        continue;
      }

      if (startFlg) {
        // 実績上げ（マスタ）の始動、ログの出力は一回のみ
        TprLog().logAdd(Tpraid.TPRAID_MUPD, LogLevelDefine.normal, "***********************[MupdC(実績上げ・マスタ)] start***********************");
        startFlg = false;
      }

      // 対象データをc_header_logから取得
      String sqlQuery = "SELECT * FROM c_header_log_${_presSaleDate.substring(
          8)} WHERE sale_date = @p1 AND tran_flg IN (0,2) ORDER BY tran_flg LIMIT 1";
      Map<String, dynamic>? subValues = {
        "p1": _presSaleDate
      };
      Result pLogRes = await db.dbCon.execute(
          Sql.named(sqlQuery), parameters: subValues);
      if (pLogRes.isEmpty) {
        // c_header_logから取得したデータが0件の場合、3s間のsleepで再び営業日取得からやり直す
        TprLog().logAdd(Tpraid.TPRAID_MUPD, LogLevelDefine.normal, "***********************営業日$_presSaleDate　NO DATA***********************");
        _presSaleDate = RulMupdConsole.defaultSaleDate;
        await Future.delayed(const Duration(seconds: 3));
        continue;
      }
      Map<String, dynamic> orgData = pLogRes[0].toColumnMap();
      String serialNo = orgData["serial_no"];
      String rCompCd = orgData["comp_cd"];
      String rStreCd = orgData["stre_cd"];
      targetLog["rCompCd"] = rCompCd;
      targetLog["rStreCd"] = rStreCd;
      targetLog["rMacNo"] = orgData["mac_no"];
      targetLog["rSaleDate"] = _presSaleDate.replaceAll('-', '');

      // 対象データをp_sales_logから取得
      String sqlPLogQuery = "SELECT * FROM p_sales_log WHERE serial_no = cast(@p1 as numeric) LIMIT 1";
      Map<String, dynamic>? subValuesP = {
        "p1": serialNo
      };
      Result pLogResP = await db.dbCon.execute(
          Sql.named(sqlPLogQuery), parameters: subValuesP);
      if (pLogResP.isEmpty) {
        // p_sales_logから取得したデータが0件の場合、3s間のsleepで再び営業日取得からやり直す
        TprLog().logAdd(Tpraid.TPRAID_MUPD, LogLevelDefine.normal, "***********************【c_header_log DATA〇、p_sales_log NO DATA】***********************");
        _presSaleDate = RulMupdConsole.defaultSaleDate;
        await Future.delayed(const Duration(seconds: 3));
        continue;
      }

      // 対象データの実績上げ対象データを作成する
      Map<String, dynamic> orgDataP = pLogResP[0].toColumnMap();
      String serialNoP = orgDataP["serial_no"];
      String cartId = orgDataP["cart_id"].toString();
      Map<String, dynamic>? saleJsonLog;
      if (orgDataP["sale_json_log"] != null) {
        saleJsonLog = orgDataP["sale_json_log"];
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
        List<String>? rLinkageLogSqlList;
        List<String>? rStatusLogBody = List.filled(0,'',growable: true);
        List<String>? rDataLogBody = List.filled(0,'',growable: true);
        List<String>? rEjLogBody = List.filled(0,'',growable: true);
        List<String>? rHeaderLogBody = List.filled(0,'',growable: true);
        List<String>? rVoidLogBody = List.filled(0,'',growable: true);
        List<String>? rLinkageLogBody = List.filled(0,'',growable: true);
        if (saleJsonLog['rStatusLog'] != null) {
          if (saleJsonLog['rStatusLog'] is Iterable) {
            rStatusLogSqlList = List<String>.from(saleJsonLog['rStatusLog']);
          } else {
            rStatusLogSqlList =
            List<String>.filled(1, saleJsonLog['rStatusLog']);
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
            rHeaderLogSqlList =
            List<String>.filled(1, saleJsonLog['rHeaderLog']);
          }
        }
        if (saleJsonLog['rVoidLog'] != null) {
          if (saleJsonLog['rVoidLog'] is Iterable) {
            rVoidLogSqlList = List<String>.from(saleJsonLog['rVoidLog']);
          } else {
            rVoidLogSqlList = List<String>.filled(1, saleJsonLog['rVoidLog']);
          }
        }
        if (saleJsonLog['rLinkageLog'] != null) {
          if (saleJsonLog['rLinkageLog'] is Iterable) {
            rLinkageLogSqlList = List<String>.from(saleJsonLog['rLinkageLog']);
          } else {
            rLinkageLogSqlList = List<String>.filled(1, saleJsonLog['rLinkageLog']);
          }
        }

          if (rStatusLogSqlList != null) {
            for (String singleSql in rStatusLogSqlList) {
              if (singleSql.isNotEmpty) {
                if (singleSql.endsWith(RulMainIsolate.lineBreaker)) {
                  rStatusLogBody.add(singleSql.substring(0,
                      singleSql.length - RulMainIsolate.lineBreaker.length));
                } else {
                  rStatusLogBody.add(singleSql);
                }
              }
            }
          }
          if (rDataLogSqlList != null) {
            for (String singleSql in rDataLogSqlList) {
              if (singleSql.isNotEmpty) {
                if (singleSql.endsWith(RulMainIsolate.lineBreaker)) {
                  rDataLogBody.add(singleSql.substring(0,
                      singleSql.length - RulMainIsolate.lineBreaker.length));
                } else {
                  rDataLogBody.add(singleSql);
                }
              }
            }
          }
          if (rEjLogSqlList != null) {
            for (String singleSql in rEjLogSqlList) {
              // c_ej_log系テーブルのinsert文に対する特別措置
              List<String> lines = List<String>.from(
                  LineSplitter.split(singleSql));
              // insert文が不意に複数行までに分割された場合、ここで再び連結
              if (lines.length > 1) {
                StringBuffer nonLineBreakSql = StringBuffer();
                // 生文字列リテラル「\\」が「\」になってしまった場合の復元処理
                lines.asMap().forEach((int idx, String val) =>
                (lines[idx] =
                    val.replaceAll(RulMainIsolate.singleBackslash,
                        RulMainIsolate.doubleBackslash)));
                nonLineBreakSql.writeAll(lines, RulMainIsolate.lineBreaker);
                String revisedSql = nonLineBreakSql.toString();
                if (revisedSql.endsWith(RulMainIsolate.lineBreaker)) {
                  rEjLogBody.add(revisedSql.substring(0,
                      revisedSql.length - RulMainIsolate.lineBreaker.length));
                } else {
                  rEjLogBody.add(revisedSql);
                }
              } else {
                if (singleSql.isNotEmpty) {
                  if (singleSql.endsWith(RulMainIsolate.lineBreaker)) {
                    rEjLogBody.add(singleSql.substring(0,
                        singleSql.length - RulMainIsolate.lineBreaker.length));
                  } else {
                    rEjLogBody.add(singleSql);
                  }
                }
              }
            }
          }
          if (rHeaderLogSqlList != null) {
            for (String singleSql in rHeaderLogSqlList) {
              if (singleSql.isNotEmpty) {
                if (singleSql.endsWith(RulMainIsolate.lineBreaker)) {
                  rHeaderLogBody.add(singleSql.substring(0,
                      singleSql.length - RulMainIsolate.lineBreaker.length));
                } else {
                  rHeaderLogBody.add(singleSql);
                }
              }
            }
          }
          if (rVoidLogSqlList != null) {
            for (String singleSql in rVoidLogSqlList) {
              if (singleSql.isNotEmpty) {
                if (singleSql.endsWith(RulMainIsolate.lineBreaker)) {
                  rVoidLogBody.add(singleSql.substring(0,
                      singleSql.length - RulMainIsolate.lineBreaker.length));
                } else {
                  rVoidLogBody.add(singleSql);
                }
              }
            }
          }
        if (rLinkageLogSqlList != null) {
          for (String singleSql in rLinkageLogSqlList) {
            if (singleSql.isNotEmpty) {
              if (singleSql.endsWith(RulMainIsolate.lineBreaker)) {
                rLinkageLogBody.add(singleSql.substring(0,
                    singleSql.length - RulMainIsolate.lineBreaker.length));
              } else {
                rLinkageLogBody.add(singleSql);
              }
            }
          }
        }

        if (rDataLogBody.isEmpty) {
          targetLog["rDataLog"] = "";
        } else {
          targetLog["rDataLog"] = rDataLogBody;
        }
        if (rStatusLogBody.isEmpty) {
          targetLog["rStatusLog"] = "";
        } else {
          targetLog["rStatusLog"] = rStatusLogBody;
        }
        if (rEjLogBody.isEmpty) {
          targetLog["rEjLog"] = "";
        } else {
          targetLog["rEjLog"] = rEjLogBody;
        }
        if (rHeaderLogBody.isEmpty) {
          targetLog["rHeaderLog"] = "";
        } else if (rHeaderLogBody.length == 1) {
          targetLog["rHeaderLog"] = rHeaderLogBody[0];
        } else {
          targetLog["rHeaderLog"] = rHeaderLogBody;
        }
        if (rVoidLogBody.isEmpty) {
          targetLog["rVoidLog"] = "";
        } else if (rVoidLogBody.length == 1) {
          targetLog["rVoidLog"] = rVoidLogBody[0];
        } else {
          targetLog["rVoidLog"] = rVoidLogBody;
        }
        if (rLinkageLogBody.isEmpty) {
          targetLog["rLinkageLog"] = "";
        } else {
          targetLog["rLinkageLog"] = rLinkageLogBody;
        }

        try {
          String bodyWithTableNameToBeDone = jsonEncode(targetLog).replaceAll(RulMainIsolate.doubleBackslash, RulMainIsolate.singleBackslash);
          final reg = RegExp(r' (c_[a-z]{1,}_log_[0-9][0-9]) ');
          final bodyWithCorrectTableName = bodyWithTableNameToBeDone.replaceAllMapped(reg, (match) {
            return ' ${match.group(1)}_${rCompCd.padLeft(9, '0')}_${rStreCd.padLeft(9, '0')} ';
          });
          final bodyToBeSent = ((bodyWithCorrectTableName.replaceAll(r';\n','')).replaceAll(r';','')).replaceAll(r', E'',r', '');
          final response = await client.post(
            uriMupdC,
            headers: {'Content-Type': 'application/json'},
            body: bodyToBeSent
          );

          // ステータスコードの確認
          if (response.statusCode == 200) {
            // main に オンライン状態を送信
            _appSendPort?.send(true);

            String resUtf8 = utf8.decode(response.bodyBytes);
            String responseRefined = resUtf8.substring(
                resUtf8.indexOf('{'), resUtf8.lastIndexOf('}') + 1);
            Map<String, dynamic> resData = json.decode(responseRefined);
            if (resData['RetSts'] != SUCCESS_RETURNED_BY_SERVER) {
              // ここでログアウトプットでも〇
              tranFlg = 2;
              TprLog().logAdd(Tpraid.TPRAID_MUPD, LogLevelDefine.error, "[MupdCIsolate.mupdCMain()] Error returned by server : ${resData['RetSts']}-${resData['ErrMsg']}");
              TprLog().logAdd(Tpraid.TPRAID_MUPD, LogLevelDefine.error, "                    SerialNo of failed record above : $serialNo");
              try {
                String errLogFileFullPath = '${TprxPlatform.getPlatformPath(EnvironmentData.HOME)}/log/ts_update_error_$serialNo.log';
                var file = File(errLogFileFullPath);
                var now = DateTime.now();
                var buf = sprintf(UPDERRLOG_SINGLE_DATA, [
                  now.year,
                  now.month,
                  now.day,
                  now.hour,
                  now.minute,
                  now.second,
                  bodyToBeSent
                ]);
                file.writeAsStringSync(buf, mode: FileMode.append);
                TprLog().logAdd(Tpraid.TPRAID_MUPD, LogLevelDefine.error, "SQL body has been dumped into: $errLogFileFullPath");
              } catch (e) {
                TprLog().logAdd(Tpraid.TPRAID_MUPD, LogLevelDefine.error, "Error log file Open Failed");
              }
            }
          } else {
            tranFlg = 2;
            // main に オフライン状態を送信
            _appSendPort?.send(false);
            TprLog().logAdd(Tpraid.TPRAID_MUPD, LogLevelDefine.error, "[MupdCIsolate.mupdCMain()] Error occured (statusCode): ${response.statusCode}");
          }
        } catch (e, s) {
          // WebAPIとの通信エラー、jsonファイルに不備があるなどの場合
          tranFlg = 2;
          // main に オフライン状態を送信
          _appSendPort?.send(false);
          TprLog().logAdd(Tpraid.TPRAID_MUPD, LogLevelDefine.error, "[MupdCIsolate.mupdCMain()] Error occured (local client): ${e.toString()}-${s.toString()}");
        }
        // WebAPIの処理結果次第、tran_flgの値を更新する
        try {
          String sqlUpd = "UPDATE c_header_log_${_presSaleDate.substring(
              8)} SET tran_flg = @p1 WHERE serial_no = cast(@p2 as numeric)";
          Map<String, dynamic>? updValues = {
            // 0以外の場合、失敗（値：2）で更新
            "p1": tranFlg,
            // serial_no
            "p2": serialNo
          };
          await db.dbCon.execute(Sql.named(sqlUpd), parameters: updValues);
          if (tranFlg == 1) {
            TprLog().logAdd(Tpraid.TPRAID_MUPD, LogLevelDefine.normal, "[MupdCIsolate.mupdCMain()] SUCCESS : SerialNo-$serialNo");
          }
        } catch (e, s) {
          TprLog().logAdd(Tpraid.TPRAID_MUPD, LogLevelDefine.error, "[MupdCIsolate.mupdCMain()] c_header_log_xx update failure : ${e.toString()} ${s.toString()}");
        }
        // 対象データの実績上げが行われて500msのsleepで再び最初から実行する
        await Future.delayed(const Duration(milliseconds: 500));
        _presSaleDate = RulMupdConsole.defaultSaleDate;
        continue;
      }
    }
  }

  // MainIsolateと通信用
  Future receiveNew(SendPort sendPort) async {
    ReceivePort resp = ReceivePort();
    sendPort.send(resp.sendPort);
    return resp.first;
  }

    Future<Uri> getUrl() async {
      Sys_paramJsonFile sysParamFiles = Sys_paramJsonFile();
      String filePath = await sysParamFiles.getFilePath();
      JsonRet jsonRet = await getJsonValue(filePath, 'server', 'url');
      String tsServerDomain = "";
      bool https = true;
      Uri uri;

      if(jsonRet.value.toString().contains("https://")) {
        https = true;
        tsServerDomain = jsonRet.value.toString().replaceAll("https://", "");
      }else if(jsonRet.value.toString().contains("http://")){
        https = false;
        tsServerDomain = jsonRet.value.toString().replaceAll("http://", "");
      }

      TprLog().logAdd(Tpraid.TPRAID_MUPD, LogLevelDefine.normal,"filePath: $filePath");

      if(https) {
        uri = Uri.https(tsServerDomain, '/tapi/poslogentry');
        TprLog().logAdd(Tpraid.TPRAID_MUPD, LogLevelDefine.normal,"URL: ${Uri.https(jsonRet.value.toString().replaceAll("https://", ""), '/tapi/poslogentry')}");
      }else{
        uri = Uri.http(tsServerDomain, '/tapi/poslogentry');
        TprLog().logAdd(Tpraid.TPRAID_MUPD, LogLevelDefine.normal,"URL: ${Uri.http(jsonRet.value.toString().replaceAll("http://", ""), '/tapi/poslogentry')}");
      }

      return uri;
    }
  }
