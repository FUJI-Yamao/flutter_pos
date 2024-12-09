/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:io';


import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sprintf/sprintf.dart';

import '../../../app/common/cmn_sysfunc.dart';
import '../../../app/inc/apl/rxmem_define.dart';
import '../../../type_extension/pos_file.dart';
import '../../common/cls_conf/configJsonFile.dart';
import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/cls_conf/qcashierJsonFile.dart';
import '../../common/cls_conf/sysJsonFile.dart';
import '../../common/cls_conf/sys_paramJsonFile.dart';
import '../../common/date_util.dart';
import '../../common/environment.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../regs/checker/rc_acracbdsp.dart';
import '../cm_sys/cm_cksys.dart';
import '../if_acx/acx_com.dart';
import 'cmd_func.dart';
import 'cnct.dart';

///  関連tprxソース: AplLib_Other.c
  enum APL_ACTION_TYPE
  {
    APL_ACTION_REMOVE,	// 削除処理
    APL_ACTION_COUNT,	// カウント処理
    APL_ACTION_CONNECT,	// ファイル連結処理
  }

class AplLibOther {
  static int acbSelect = 0;
  static int acrCnct = 0;
  static int startPosi = 0;
  static int cPickResvMethod = 0;
  static int cPickKind = 0;
  static int calcSht = 0;	//代替可能な枚数
  static int exchgRsltPrc = 0;	//代替計算後の超過金額もしくは不足金額
  static List<int> limit = List.generate(ChgInoutNum.CHGINOUT_MAX.num, (_) => 0);
  static List<int> acr = List.generate(ChgInoutNum.CHGINOUT_MAX.num, (_) => 0);
  static List<int> resv = List.generate(ChgInoutNum.CHGINOUT_MAX.num, (_) => 0);
  static List<int> resvDrw = List.generate(ChgInoutNum.CHGINOUT_MAX.num, (_) => 0);
  static List<int> drw = List.generate(ChgInoutNum.CHGINOUT_MAX.num, (_) => 0);
  static List<int> sht = List.generate(ChgInoutNum.CHGINOUT_MAX.num, (_) => 0);
  static List<int> shtDrw = List.generate(ChgInoutNum.CHGINOUT_MAX.num, (_) => 0);
  static List<int> errSht = List.generate(ChgInoutNum.CHGINOUT_MAX.num, (_) => 0);
  static List<int> errShtDrw = List.generate(ChgInoutNum.CHGINOUT_MAX.num, (_) => 0);
  static List<int> kind = [10000, 5000, 2000, 1000, 500, 100, 50, 10, 5, 1];

  /****************************************************************************
      改行セット
   *****************************************************************************/

  ///  関連tprxソース: AplLib_Other.c - prg_preset_set_return2()
  static String prgPresetSetReturn2(String str) {
    // TODO:10057 ボタンサイズに合わせて文字列に改行を入れる
    // Flutterの機能で対応するなら不要.
    return str;
  }

  ///  関連tprxソース: AplLib_Other.c - Apllib_PowerON_Make_Log()
  static Future<String> aplLibPowerONMakeLog() async {
    // 現在の設定ファイルをlogファイルフォルダへコピー.
    // lsコマンドでフォルダの状況をログファイルへ出力.
    DateFormat outputFormat = DateFormat(DateUtil.formatForLogAddTime);
    String addName = outputFormat.format(DateTime.now());
    if (CompileFlag.DEBUG_TEST) {
      // 開発中にファイルが大量に生成されてしまうのを防ぐ.
      addName = "debug";
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    late SysJsonFile sys;
    late Mac_infoJsonFile macInfo;
    RxCommonBuf pCom = xRet.object;
    if (xRet.isInvalid()) {
      macInfo = Mac_infoJsonFile();
      await macInfo.load(); // 一番初めの起動時はロードしないとファイルが作成されないため、ロードしておく.
    } else {
      macInfo = pCom.iniMacInfo;
    }
    File(await macInfo.getFilePath()).copy4Pos(
        "${EnvironmentData().sysHomeDir}/log/${macInfo
            .getFileName()}.$addName");
    if (xRet.isInvalid()) {
      sys = SysJsonFile();
      await sys.load(); // 一番初めの起動時はロードしないとファイルが作成されないため、ロードしておく.
    } else {
      sys = pCom.iniSys;
    }
    File(await sys.getFilePath()).copy4Pos(
        "${EnvironmentData().sysHomeDir}/log/${sys.getFileName()}.$addName");

    Sys_paramJsonFile sysParam = Sys_paramJsonFile();
    File(await sysParam.getFilePath()).copy4Pos(
        "${EnvironmentData().sysHomeDir}/log/${sysParam
            .getFileName()}.$addName");

    QcashierJsonFile qc = QcashierJsonFile();
    await qc.load(); // 一番初めの起動時はロードしないとファイルが作成されないため、ロードしておく.
    File(await qc.getFilePath()).copy4Pos(
        "${EnvironmentData().sysHomeDir}/log/${qc.getFileName()}.$addName");

    // ls コマンドの結果をファイルへ出力.
    File dev = await TprxPlatform.getFile(
        "${EnvironmentData().sysHomeDir}/log/dir_device_$addName.txt");
    dev.createSync();
    dev.writeAsString(CmdFunc.getLsResult("/dev/"));
    File web2100 = await TprxPlatform.getFile(
        "${EnvironmentData().sysHomeDir}/log/dir_home_web2100_$addName.txt");
    web2100.createSync();
    web2100.writeAsString(CmdFunc.getLsResult("/home/web2100/"));

    File tmp = await TprxPlatform.getFile(
        "${EnvironmentData().sysHomeDir}/log/dir_pj_tprx_tmp_$addName.txt");
    tmp.createSync();
    tmp.writeAsString(
        CmdFunc.getLsResult("${EnvironmentData().sysHomeDir}/tmp/"));
    return "";
  }

  /// ディレクトリ内の特定ファイルに対して動作する関数
  /// 引数:[dirName]	ディレクトリ名(絶対パス)
  ///	[pre]		ファイル名称の接頭語	(NULLでチェックなし. ファイル名称の先頭部分とpreを比較)
  ///	[suf]		ファイル名称の接尾語	(NULLでチェックなし. ファイル名称の末尾部分とsufを比較)
  ///	[word]		ファイル名称の文字	(NULLでチェックなし. ファイル名称のwordPosiからの部分の文字列とwordを比較)
  ///	[wordPosi]	ファイル名称の文字位置	(wordに依存)
  ///	[match]		PROCESS_MATCH: 一致したものを対象  PROCESS_UNMATCH: 一致しないものを対象
  ///	[action]	APL_ACTION_REMOVE: 削除
  ///			APL_ACTION_COUNT: カウントのみ
  ///			APL_ACTION_CONNECT: ファイル連結 (対象ファイルに追記していく)
  ///	[param]		FileActParam構造体のメンバを使用する
  /// 戻値: 対象へ動作したファイル数を返す (-1:失敗  0以上:成功)
  /// 制限: wordPosi は正の値のみ対象
  ///   例: [pre = NULL, suf = NULL, word = NULL] の場合は, dirNameの全てのファイルが対象 (match, unmatch に関らず )
  ///	 [pre = log, suf = tar.gz, match = 0]  の場合は, log*tar.gz のファイルが対象
  ///	 [word = log, wordPosi = 5, match = 1] の場合は, ?????log* 以外のファイルが対象
  ///  関連tprxソース: AplLib_Other.c - dirFileAction()
  static int dirFileAction(
                TprMID tid, String dirName, String pre, String suf, String word, int wordPosi
              , APL_MATCH_PROC_TYPE match, APL_ACTION_TYPE action, String connectPath) {

    if (dirName.isEmpty || wordPosi < 0) {
      TprLog().logAdd(
          tid, LogLevelDefine.error, 'dirFileAction: Error argument\n');
      return -1;
    }

    if (action == APL_ACTION_TYPE.APL_ACTION_CONNECT) {
      if (connectPath.isEmpty) {
        TprLog().logAdd(
            tid, LogLevelDefine.error, 'dirFileAction: Error argument. connectPath\n');
        return -1;
      }
    }

    Directory dirp = TprxPlatform.getDirectory(dirName);

    if (!dirp.existsSync()) {
      TprLog().logAdd(
          tid, LogLevelDefine.error, 'dirFileAction: Error return. $dirName\n');
      return -1;
    }

    int count = 0;
    List<FileSystemEntity> entities = dirp.listSync();
    Iterable<FileSystemEntity> files = entities.whereType<File>();
    for (FileSystemEntity file in files) {
      if (basename(file.path).length < wordPosi + word.length) {
        continue;
      }
      if (basename(file.path).length < [pre.length, suf.length, word.length].max) {
        continue;
      }
      if (pre.isNotEmpty) {
        if ((match == APL_MATCH_PROC_TYPE.PROCESS_MATCH   && !basename(file.path).startsWith(pre)) ||
            (match == APL_MATCH_PROC_TYPE.PROCESS_UNMATCH &&  basename(file.path).startsWith(pre))) {
          continue;
        }
      }
      if (suf.isNotEmpty) {
        if ((match == APL_MATCH_PROC_TYPE.PROCESS_MATCH   && !basename(file.path).endsWith(suf)) ||
            (match == APL_MATCH_PROC_TYPE.PROCESS_UNMATCH &&  basename(file.path).endsWith(suf))) {
          continue;
        }
      }
      if (word.isNotEmpty) {
        if ((match == APL_MATCH_PROC_TYPE.PROCESS_MATCH   && !basename(file.path).substring(wordPosi).startsWith(word)) ||
            (match == APL_MATCH_PROC_TYPE.PROCESS_UNMATCH &&  basename(file.path).substring(wordPosi).startsWith(word))) {
          continue;
        }
      }

      switch (action) {

        case APL_ACTION_TYPE.APL_ACTION_REMOVE:
          file.deleteSync();
          break;
        case APL_ACTION_TYPE.APL_ACTION_COUNT:
          count++;
          break;
        case APL_ACTION_TYPE.APL_ACTION_CONNECT:
          try {
            TprxPlatform.getFile(connectPath).writeAsBytesSync(
                  (file as File).readAsBytesSync(), mode: FileMode.append);
          } catch (e) {
            TprLog().logAdd(
                tid, LogLevelDefine.error, 'dirFileAction: Error connect. $e\n');
            TprxPlatform.getFile(connectPath).deleteSync();
            return -1;
          }
          count++;
        break;
      }
    }

    return count;
  }

  /// 現在の友の会ライブラリが「本番用/テスト用」どちらが利用されているかのチェック
  /// ※チェックは、友の会ライブラリリンクのリンク先ファイルで判断する
  ///
  ///	return 0:本番 1:テスト -1:ファイル無し
  ///  関連tprxソース: AplLib_Other.c - AplLib_Chk_tomoIFLibFile()
  static Future<int> aplLibChkTomoIFLibFile() async {
    int ret = -1;
    String buf = '';
    String target = '/pj/tprx/tool/libR21TOMOPL_LNK.so'; // シンボリックリンクファイル名
    String realLibName = '/pj/tprx/tool/libR21TOMOPL.so'; // 本番用ライブラリ名
    String testLibName = '/pj/tprx/tool/libR21TOMOPL_TEST.so'; // テスト用ライブラリ名

    // シンボリックリンクからリンク先取得
    // if(readlink(target, buf, sizeof(buf)) > 0) {
    // TODO:00013 三浦 リンク取得以下の書き方で良いか
    if (TprxPlatform.getFile(target).existsSync()) {
      if (buf.compareTo(realLibName) == 0) {
        // 本番ライブラリ名 と一致
        ret = 0;
      } else if (buf.compareTo(testLibName) == 0) {
        // テストライブラリ名 と一致
        ret = 1;
      }
    }
    return ret;
  }

  /// 機能：引数で指定したテーブルが、「comp_cdが c_comp_mst.rtr_idであった場合に自店/自企業コードで書き換え」
  ///     : の対象であるかをチェックする
  /// 戻り値：0:対象外
  /// 　　　：3:comp_cdのみ、stre_cd=自店舗コードのまま
  ///  関連tprxソース: AplLib_Other.c - dbChk_CompcdEqRtrid()
  static Future<int> dbChkComPcdEqRtrId(TprMID tid, String tableName) async {
    if (CmCksys.cmMmType() != CmSys.MacERR) {
      /* TS接続タイプでない */
      return 0;
    }

    if (await CmCksys.cmDs2GodaiSystem() != 0) {
      // ゴダイ様仕様は対象外。 ゴダイ様以外では、TSのデータは企業コード分レコードをもつのではなく、
      // 企業コードにリテイラーIDをもつ1レコードのみ保持するため
      return 0;
    }

    if (await CmCksys.cmWsSystem() != 0) {
      // WS仕様も対象外 (ゴダイ仕様と同じデータの持ち方のため)
      return 0;
    }

    if (await CmCksys.cmZHQSystem() == 0) {
      // 全日食様では対象外のもの
      if (tableName.compareTo("c_loystre_mst") == 0) {
        // comp,自店舗
        return 3;
      }
    }

    if (tableName.compareTo("c_acct_mst") == 0) {
      // comp,stre
      // comp_cd,stre_cd ありのテーブル
      return 1;
    } else if (tableName.compareTo("c_cpn_ctrl_mst") == 0 ||
        tableName.compareTo("c_cpnbdy_mst") == 0 ||
        tableName.compareTo("c_loypln_mst") == 0 ||
        tableName.compareTo("c_loyplu_mst") == 0 ||
        tableName.compareTo("c_loytgt_mst") == 0) {
      // comp_cd のみのテーブル
      return 2;
    }

    return 0;
  }

  /// TS接続時マスターテーブル名変換
  /// 引数：
  ///    src: 変換テーブル名
  /// 　 mstname：変換後のテーブル名
  /// 　 date：年月（月別実績の場合詰める）
  ///    part_type：パーティションタイプ
  /// 		0:企業コード,店舗コードあり
  /// 		1:年_月 (企業コード,店舗コードなし)
  /// 戻り値：
  /// 　　０：正常　　ー１：異常
  ///  関連tprxソース: AplLib_Other.c - AplLib_Get_MstName()
  static Future<int> aplLibGetMstName(String src, String mstName, String date,
      int partType) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    int i = 0;
    List<String?> chgTableName = [
      "c_plu_mst",
      "c_tmp_log",
      "c_header_log",
      "c_data_log",
      "c_status_log",
      "c_ej_log",
      "c_pbchg_log",
      "c_cust_header_log",
      "c_cust_data_log",
      "c_reserv_log",
      "c_header_log_reserv_01",
      "c_data_log_reserv_01",
      "s_daybook_log",
      "c_histlog_mst",
      "s_brgn_mst",
      "s_bdlsch_mst",
      "s_bdlitem_mst",
      "s_stmsch_mst",
      "s_stmitem_mst",
      "s_clssch_mst",
      "s_subtsch_mst",
      "s_plu_point_mst",
      "s_trade_mst",
      "s_rsrv_trade_mst",
      "s_rsrvplu_mst",
      "s_cust_loy_tbl",
      "s_cust_cpn_tbl",
      "c_staffopen_mst",
      "c_plan_mst",
      "c_linkage_log",
      null
    ];

    if (CmCksys.cmMmType() == CmSys.MacERR) {
      if (await CmCksys.cmSm66FrestaSystem() != 0 /* フレスタ様仕様 */
          &&
          (src.compareTo("s_cust_loy_tbl") == 0 ||
              src.compareTo("s_cust_cpn_tbl") == 0)) {
        // フレスタ様仕様で上記のテーブル名の場合はパーティション追加処理を行わない。
      } else {
        for (i = 0; chgTableName[i] != null; i++) {
          if (src.compareTo(chgTableName[i]!) == 0) {
            PartitionType def = PartitionType.getDefine(partType);
            switch (def) {
              case PartitionType.PART_TYPE_YEAR_MONTH:
                if (date.isNotEmpty) {
                  mstName = "${src}_$date";
                } else {
                  mstName = src;
                }
                break;
              case PartitionType.PART_TYPE_NORMAL:
              default:
                if (date.isNotEmpty) {
                  mstName = sprintf("%s_%s_%09i_%09i", [
                    src,
                    date,
                    pCom.dbRegCtrl.compCd,
                    pCom.dbRegCtrl.streCd
                  ]);
                } else {
                  mstName = sprintf("%s_%09i_%09i",
                      [src, pCom.dbRegCtrl.compCd, pCom.dbRegCtrl.streCd]);
                }
                break;
            }
            return 0;
          }
        }
      }
    }

    mstName = src;

    return 0;
  }

  // TODO: 中間 釣機関数実装のため、定義のみ追加
  ///  関連tprxソース: AplLib_Other.c - DirChk
  static int dirChk(String dirName) {
    return 1;
  }

  ///  関連tprxソース: AplLib_Other.c - system_cmd_chk()
  static int systemCmdChk(TprMID tid, String cmd) {
    ProcessResult ret;
    String erLog = '';
    String callFunc = 'systemCmdChk';

    ret = Process.runSync(cmd, []);
    if (ret.exitCode != 0) {
      erLog = "$callFunc error[$ret][${ret.exitCode}]\n";
      TprLog().logAdd(tid, LogLevelDefine.error, erLog);
      erLog = "$callFunc cmd[$cmd]\n";
      TprLog().logAdd(tid, LogLevelDefine.error, erLog);
      return Typ.NG;
    }
    return Typ.OK;
  }

  ///  関連tprxソース: AplLib_Other.c - AplLib_ChgPick_ReserveCalc()
  static Future<int> aplLibChgPickReserveCalc(TprMID tid, CBillKind? pickData, int? rsltPrc, int menteFlg) async {
    String log = '';
    int errNo = 0;
    String callFunc = 'aplLibChgPickReserveCalc';

    RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetS.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRetS.object;
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRetC.object;

    if (menteFlg != 1) {
      //mente_acxinfo_make2からのコールではないのでacr_cnctが作成されていないのでここで作成
      acrCnct = Cnct.cnctMemGet(tid, CnctLists.CNCT_ACR_CNCT);
    }
    chgPickReserveDataReset();
    startPosi = ChgInOutDisp.CHGINOUT_Y10000.value;

    if (acrCnct != 2) {
      startPosi = ChgInOutDisp.CHGINOUT_Y500.value;
    }

    /* 収納庫内金額 */
    if (acrCnct == 2) {
      if (tsBuf.acx.coinStock.holder == null) {
        acr[ChgInOutDisp.CHGINOUT_Y10000.value] = 0;
        acr[ChgInOutDisp.CHGINOUT_Y5000.value] = 0;
        acr[ChgInOutDisp.CHGINOUT_Y2000.value] = 0;
        acr[ChgInOutDisp.CHGINOUT_Y1000.value] = 0;
      } else {
        acr[ChgInOutDisp.CHGINOUT_Y10000.value] = tsBuf.acx.coinStock.holder!.bill10000;
        acr[ChgInOutDisp.CHGINOUT_Y5000.value] = tsBuf.acx.coinStock.holder!.bill5000;
        acr[ChgInOutDisp.CHGINOUT_Y2000.value] = tsBuf.acx.coinStock.holder!.bill2000;
        acr[ChgInOutDisp.CHGINOUT_Y1000.value] = tsBuf.acx.coinStock.holder!.bill1000;
      }
    }

    if (tsBuf.acx.coinStock.holder == null) {
      acr[ChgInOutDisp.CHGINOUT_Y500.value] = 0;
      acr[ChgInOutDisp.CHGINOUT_Y100.value] = 0;
      acr[ChgInOutDisp.CHGINOUT_Y50.value] = 0;
      acr[ChgInOutDisp.CHGINOUT_Y10.value] = 0;
      acr[ChgInOutDisp.CHGINOUT_Y5.value] = 0;
      acr[ChgInOutDisp.CHGINOUT_Y1.value] = 0;
    } else {
      acr[ChgInOutDisp.CHGINOUT_Y500.value] = tsBuf.acx.coinStock.holder!.coin500;
      acr[ChgInOutDisp.CHGINOUT_Y100.value] = tsBuf.acx.coinStock.holder!.coin100;
      acr[ChgInOutDisp.CHGINOUT_Y50.value] = tsBuf.acx.coinStock.holder!.coin50;
      acr[ChgInOutDisp.CHGINOUT_Y10.value] = tsBuf.acx.coinStock.holder!.coin10;
      acr[ChgInOutDisp.CHGINOUT_Y5.value] = tsBuf.acx.coinStock.holder!.coin5;
      acr[ChgInOutDisp.CHGINOUT_Y1.value] = tsBuf.acx.coinStock.holder!.coin1;
    }

    log = sprintf(
        "%s() acr    [%03i, %03i, %03i, %03i, %03i, %03i, %03i, %03i, %03i, %03i]\n",
        [
          callFunc,
          acr[ChgInOutDisp.CHGINOUT_Y10000.value],
          acr[ChgInOutDisp.CHGINOUT_Y5000.value],
          acr[ChgInOutDisp.CHGINOUT_Y2000.value],
          acr[ChgInOutDisp.CHGINOUT_Y1000.value],
          acr[ChgInOutDisp.CHGINOUT_Y500.value],
          acr[ChgInOutDisp.CHGINOUT_Y100.value],
          acr[ChgInOutDisp.CHGINOUT_Y50.value],
          acr[ChgInOutDisp.CHGINOUT_Y10.value],
          acr[ChgInOutDisp.CHGINOUT_Y5.value],
          acr[ChgInOutDisp.CHGINOUT_Y1.value]
        ]);
    TprLog().logAdd(tid, LogLevelDefine.normal, log);

    /* 棒金ドロア内金額 */
    if (await CmCksys.cmAcxChgdrwSystem() != 0) {
      if (tsBuf.acx.coinStock.drawData == null) {
        drw[ChgInOutDisp.CHGINOUT_Y500.value] = 0;
        drw[ChgInOutDisp.CHGINOUT_Y100.value] = 0;
        drw[ChgInOutDisp.CHGINOUT_Y50.value] = 0;
        drw[ChgInOutDisp.CHGINOUT_Y10.value] = 0;
        drw[ChgInOutDisp.CHGINOUT_Y5.value] = 0;
        drw[ChgInOutDisp.CHGINOUT_Y1.value] = 0;
      } else {
        drw[ChgInOutDisp.CHGINOUT_Y500.value] = tsBuf.acx.coinStock.drawData!.coin500;
        drw[ChgInOutDisp.CHGINOUT_Y100.value] = tsBuf.acx.coinStock.drawData!.coin100;
        drw[ChgInOutDisp.CHGINOUT_Y50.value] = tsBuf.acx.coinStock.drawData!.coin50;
        drw[ChgInOutDisp.CHGINOUT_Y10.value] = tsBuf.acx.coinStock.drawData!.coin10;
        drw[ChgInOutDisp.CHGINOUT_Y5.value] = tsBuf.acx.coinStock.drawData!.coin5;
        drw[ChgInOutDisp.CHGINOUT_Y1.value] = tsBuf.acx.coinStock.drawData!.coin1;
      }

      log = sprintf(
          "%s() Drw    [                    %03i, %03i, %03i, %03i, %03i, %03i]\n",
          [
            callFunc,
            drw[ChgInOutDisp.CHGINOUT_Y500.value],
            drw[ChgInOutDisp.CHGINOUT_Y100.value],
            drw[ChgInOutDisp.CHGINOUT_Y50.value],
            drw[ChgInOutDisp.CHGINOUT_Y10.value],
            drw[ChgInOutDisp.CHGINOUT_Y5.value],
            drw[ChgInOutDisp.CHGINOUT_Y1.value]
          ]);
      TprLog().logAdd(tid, LogLevelDefine.normal, log);
    }

    /* 補充基準値 */
    if (acrCnct == 2) {
      resv[ChgInOutDisp.CHGINOUT_Y10000.value] = 0;
      resv[ChgInOutDisp.CHGINOUT_Y5000.value] = cBuf.dbTrm.acxS5000;
      resv[ChgInOutDisp.CHGINOUT_Y2000.value] = cBuf.dbTrm.acxS2000;
      resv[ChgInOutDisp.CHGINOUT_Y1000.value] = cBuf.dbTrm.acxS1000;
    }
    resv[ChgInOutDisp.CHGINOUT_Y500.value] = cBuf.dbTrm.acxS500;
    resv[ChgInOutDisp.CHGINOUT_Y100.value] = cBuf.dbTrm.acxS100;
    resv[ChgInOutDisp.CHGINOUT_Y50.value] = cBuf.dbTrm.acxS50;
    resv[ChgInOutDisp.CHGINOUT_Y10.value] = cBuf.dbTrm.acxS10;
    resv[ChgInOutDisp.CHGINOUT_Y5.value] = cBuf.dbTrm.acxS5;
    resv[ChgInOutDisp.CHGINOUT_Y1.value] = cBuf.dbTrm.acxS1;

    log = sprintf(
        "%s() resv   [%03i, %03i, %03i, %03i, %03i, %03i, %03i, %03i, %03i, %03i]\n",
        [
          callFunc,
          resv[ChgInOutDisp.CHGINOUT_Y10000.value],
          resv[ChgInOutDisp.CHGINOUT_Y5000.value],
          resv[ChgInOutDisp.CHGINOUT_Y2000.value],
          resv[ChgInOutDisp.CHGINOUT_Y1000.value],
          resv[ChgInOutDisp.CHGINOUT_Y500.value],
          resv[ChgInOutDisp.CHGINOUT_Y100.value],
          resv[ChgInOutDisp.CHGINOUT_Y50.value],
          resv[ChgInOutDisp.CHGINOUT_Y10.value],
          resv[ChgInOutDisp.CHGINOUT_Y5.value],
          resv[ChgInOutDisp.CHGINOUT_Y1.value]
        ]);
    TprLog().logAdd(tid, LogLevelDefine.normal, log);

    /* 補充基準値(棒金ドロア) */
    if (await CmCksys.cmAcxChgdrwSystem() != 0) {
      resvDrw[ChgInOutDisp.CHGINOUT_Y500.value] =
          cBuf.iniMacInfo.acx_flg.acx_resv_drw500;
      resvDrw[ChgInOutDisp.CHGINOUT_Y100.value] =
          cBuf.iniMacInfo.acx_flg.acx_resv_drw100;
      resvDrw[ChgInOutDisp.CHGINOUT_Y50.value] =
          cBuf.iniMacInfo.acx_flg.acx_resv_drw50;
      resvDrw[ChgInOutDisp.CHGINOUT_Y10.value] =
          cBuf.iniMacInfo.acx_flg.acx_resv_drw10;
      resvDrw[ChgInOutDisp.CHGINOUT_Y5.value] =
          cBuf.iniMacInfo.acx_flg.acx_resv_drw5;
      resvDrw[ChgInOutDisp.CHGINOUT_Y1.value] =
          cBuf.iniMacInfo.acx_flg.acx_resv_drw1;

      log = sprintf(
          "%s() resvDrw[                    %03i, %03i, %03i, %03i, %03i, %03i]\n",
          [
            callFunc,
            resvDrw[ChgInOutDisp.CHGINOUT_Y500.value],
            resvDrw[ChgInOutDisp.CHGINOUT_Y100.value],
            resvDrw[ChgInOutDisp.CHGINOUT_Y50.value],
            resvDrw[ChgInOutDisp.CHGINOUT_Y10.value],
            resvDrw[ChgInOutDisp.CHGINOUT_Y5.value],
            resvDrw[ChgInOutDisp.CHGINOUT_Y1.value]
          ]);
      TprLog().logAdd(tid, LogLevelDefine.normal, log);
    }

    /* 必要最低枚数 */
    if (acrCnct == 2) {
      limit[ChgInOutDisp.CHGINOUT_Y10000.value] = 0;
      limit[ChgInOutDisp.CHGINOUT_Y5000.value] =
          cBuf.iniMacInfo.acx_flg.acx_resv_min5000;
      limit[ChgInOutDisp.CHGINOUT_Y2000.value] =
          cBuf.iniMacInfo.acx_flg.acx_resv_min2000;
      limit[ChgInOutDisp.CHGINOUT_Y1000.value] =
          cBuf.iniMacInfo.acx_flg.acx_resv_min1000;
    }
    limit[ChgInOutDisp.CHGINOUT_Y500.value] =
        cBuf.iniMacInfo.acx_flg.acx_resv_min500;
    limit[ChgInOutDisp.CHGINOUT_Y100.value] =
        cBuf.iniMacInfo.acx_flg.acx_resv_min100;
    limit[ChgInOutDisp.CHGINOUT_Y50.value] =
        cBuf.iniMacInfo.acx_flg.acx_resv_min50;
    limit[ChgInOutDisp.CHGINOUT_Y10.value] =
        cBuf.iniMacInfo.acx_flg.acx_resv_min10;
    limit[ChgInOutDisp.CHGINOUT_Y5.value] =
        cBuf.iniMacInfo.acx_flg.acx_resv_min5;
    limit[ChgInOutDisp.CHGINOUT_Y1.value] =
        cBuf.iniMacInfo.acx_flg.acx_resv_min1;

    log = sprintf(
        "%s() limit  [%03i, %03i, %03i, %03i, %03i, %03i, %03i, %03i, %03i, %03i]\n",
        [
          callFunc,
          limit[ChgInOutDisp.CHGINOUT_Y10000.value],
          limit[ChgInOutDisp.CHGINOUT_Y5000.value],
          limit[ChgInOutDisp.CHGINOUT_Y2000.value],
          limit[ChgInOutDisp.CHGINOUT_Y1000.value],
          limit[ChgInOutDisp.CHGINOUT_Y500.value],
          limit[ChgInOutDisp.CHGINOUT_Y100.value],
          limit[ChgInOutDisp.CHGINOUT_Y50.value],
          limit[ChgInOutDisp.CHGINOUT_Y10.value],
          limit[ChgInOutDisp.CHGINOUT_Y5.value],
          limit[ChgInOutDisp.CHGINOUT_Y1.value]
        ]);
    TprLog().logAdd(tid, LogLevelDefine.normal, log);

    acbSelect = AcxCom.ifAcbSelect();
    cPickResvMethod = CmCksys.cmAcxCpickResvMethod();
    log = sprintf(
        "%s() acb_select[%i] cPickResvMethod[%i] both_acr_flg[%i] acx_resv_drw[%i]\n",
        [
          callFunc,
          Cnct.cnctMemGet(tid, CnctLists.CNCT_ACB_SELECT),
          cPickResvMethod,
          cBuf.dbTrm.bothAcrClrFlg,
          cBuf.iniMacInfo.acx_flg.acx_resv_drw
        ]);
    TprLog().logAdd(tid, LogLevelDefine.normal, log);

    switch (cPickResvMethod) {
      //回収方法変更設定
      case 1: //硬貨優先残置(硬貨回収最小)
        errNo = await chgPickReserveDataSetCoinMinimum(tid);
        break;
      case 5: //金種指定残置
        errNo = await chgPickReserveDataSetCBillKind(tid);
        break;
      case 0: //通常残置
        errNo = await chgPickReserveDataSetNormal(tid);
        break;
      case 2: //硬貨全残置(紙幣回収)
      case 3: //万券以外残置(万券回収)
      case 4: //全残置(カセット回収)
      default: //これらは残置回収でなくrcChgPick_ResvPick_ModeChgによりそれぞれの処理へ進むのでここは通らない
        log = "$callFunc() default case\n";
        TprLog().logAdd(tid, LogLevelDefine.normal, log);
        break;
    }
    if (pickData != null) {
      //回収枚数データ作成
      pickData.bill10000 = sht[ChgInOutDisp.CHGINOUT_Y10000.value];
      pickData.bill5000 = sht[ChgInOutDisp.CHGINOUT_Y5000.value];
      pickData.bill2000 = sht[ChgInOutDisp.CHGINOUT_Y2000.value];
      pickData.bill1000 = sht[ChgInOutDisp.CHGINOUT_Y1000.value];
      pickData.coin500 = sht[ChgInOutDisp.CHGINOUT_Y500.value];
      pickData.coin100 = sht[ChgInOutDisp.CHGINOUT_Y100.value];
      pickData.coin50 = sht[ChgInOutDisp.CHGINOUT_Y50.value];
      pickData.coin10 = sht[ChgInOutDisp.CHGINOUT_Y10.value];
      pickData.coin5 = sht[ChgInOutDisp.CHGINOUT_Y5.value];
      pickData.coin1 = sht[ChgInOutDisp.CHGINOUT_Y1.value];
    }
    if (rsltPrc != null) {
      //代替計算後の結果作成
      rsltPrc = exchgRsltPrc;
    }
    return (errNo);
  }

  /// 関連tprxソース: AplLib_Other.c - ChgPickReserve_DataReset()
  static void chgPickReserveDataReset() {
    int i = 0;
    for (i = 0; i < ChgInoutNum.CHGINOUT_MAX.num; i++) {
      sht[i] = 0;
      shtDrw[i] = 0;
      errSht[i] = 0;
      errShtDrw[i] = 0;
      acr[i] = 0;
      drw[i] = 0;
      resv[i] = 0;
      resvDrw[i] = 0;
      limit[i] = 0;
    }
  }

  /// 関連tprxソース: AplLib_Other.c - ChgPickReserve_DataSet_Normal()
  static Future<int> chgPickReserveDataSetNormal(TprMID tid) async {
    String log = '';
    int i = 0;
    int j = 0;
    int errNo = Typ.OK;
    int chkFlg = -1;
    int pickPrc = 0;
    int exchgPrc = 0;
    int overPrc = 0;
    int shortPrc = 0;
    int calcPrc = 0;
    int shtCnt = 0;
    int ttlPrc = 0;
    int resvPrc = 0;
    int resvDrwPrc = 0;
    int drwPrc = 0;
    String callFunc = 'chgPickReserveDataSetNormal';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    log = "$callFunc()\n";
    TprLog().logAdd(tid, LogLevelDefine.normal, log);

    if (cBuf.dbTrm.acxRecoverLessError == 0 &&
        cBuf.dbTrm.acrSubstituteRecover != 0) {
      chkFlg = ChgInoutNum.CHGINOUT_RESV_PRC.num;
    } else {
      chkFlg = ChgInoutNum.CHGINOUT_MAX.num;
    }
    /* 棒金過剰 */
    errNo = await chgPickReserveDrwOverErrChk(tid, chkFlg);
    if (errNo != Typ.OK) {
      return errNo;
    }
    /* 必要最低枚数不足 */
    errNo = chgPickReserveLimitErrChk(tid);
    if (errNo != Typ.OK) {
      return errNo;
    }

    await chgPickReserveShtDataSet(tid, 0);

    if (cBuf.dbTrm.acrSubstituteRecover != 0) {
      /* 残置回収タイプ：不足時、代替回収 */
      log = "$callFunc() Lack Substitution (user_cd10 & 1)\n";
      TprLog().logAdd(tid, LogLevelDefine.normal, log);

      //収納庫内金額合計
      //残置金額合計
      for (i = 0; i < ChgInoutNum.CHGINOUT_MAX.num; i++) {
        ttlPrc += acr[i] * kind[i];
        resvPrc += resv[i] * kind[i];
        if (await CmCksys.cmAcxChgdrwSystem() != 0 &&
            cBuf.iniMacInfo.acx_flg.acx_resv_drw != 0) {
          drwPrc += drw[i] * kind[i];
          resvDrwPrc += resvDrw[i] * kind[i];
        }
      }

      //回収金額合計(いくら回収すれば残置金額が残るか)
      pickPrc = (ttlPrc + drwPrc) - (resvPrc + resvDrwPrc);

      log =
          "$callFunc() pickPrc[$pickPrc] = (ttlPrc[$ttlPrc] + drwPrc[$drwPrc]) - (resvPrc[$resvPrc] + resvDrwPrc[$resvDrwPrc])\n";
      TprLog().logAdd(tid, LogLevelDefine.normal, log);

      //収納庫金額=残置金額であれば、そのまま残置するしかないので残置計算しない
      if (pickPrc == 0) {
        log = "$callFunc() pickPrc[$pickPrc] Reserve Calc Return\n";
        TprLog().logAdd(tid, LogLevelDefine.normal, log);
        AplLibOther.chgPickReserveDataReset();
        return errNo;
      }

      overPrc = await chgPickReserveDrwOverCalc(
          tid, ChgInoutNum.CHGINOUT_MAX.num); //棒金超過金額
      shortPrc = await chgPickReserveShortCalc(tid); //不足金額
      log = "$callFunc() overPrc[$overPrc] shortPrc[$shortPrc]\n";
      TprLog().logAdd(tid, LogLevelDefine.normal, log);
      exchgPrc = shortPrc - overPrc;
      //超過分と不足分を比較し計算
      if (exchgPrc > 0) {
        //不足が上回っている-> 残置不足分積み立て計算
        for (i = 0; i < 10; i++) {
          if (exchgPrc <= 0) {
            log = "$callFunc() exchgPrc[$exchgPrc] ExChange OK End1\n";
            TprLog().logAdd(tid, LogLevelDefine.normal, log);
            break;
          }
          log = "$callFunc() exchgPrc[$exchgPrc]\n";
          TprLog().logAdd(tid, LogLevelDefine.normal, log);
          calcPrc = chgPickReserveCalcPrcSet(tid, exchgPrc);
          for (j = 0; j < 100; j++) {
            if (calcPrc <= 0) {
              log =
                  "$callFunc() exchgPrc[$exchgPrc] ExChange calcPrc nothing End1\n";
              TprLog().logAdd(tid, LogLevelDefine.normal, log);
              break;
            }
            // TODO:00013 三浦 整数で良いか？
            shtCnt = exchgPrc ~/ calcPrc;
            if (shtCnt > calcSht) {
              //代替要求枚数が代替可能枚数を超えている
              shtCnt = calcSht;
            }
            exchgPrc -= calcPrc * shtCnt;
            chgPickReserveCntSet(shtCnt); //代替計算後の新しい回収枚数を作成
            exchgPrc += await chgPickReserveShortCalc(
                tid); //代替計算にて収納枚数以上の回収となり不足が発生していたら加算
            log =
                "$callFunc() calc after exchgPrc[$exchgPrc] calcPrc[$calcPrc] shtCnt[$shtCnt]\n";
            TprLog().logAdd(tid, LogLevelDefine.normal, log);
            if (exchgPrc <= 0) {
              log = "$callFunc() exchgPrc[$exchgPrc] ExChange OK End2\n";
              TprLog().logAdd(tid, LogLevelDefine.normal, log);
              break;
            }
            calcPrc = chgPickReserveCalcPrcSet(tid, exchgPrc);
            if (calcPrc <= 0) {
              log =
                  "$callFunc() exchgPrc[$exchgPrc] ExChange calcPrc nothing End2\n";
              TprLog().logAdd(tid, LogLevelDefine.normal, log);
              break;
            }
          }
          if (((exchgPrc > 0) && (calcPrc <= 0)) || (j >= 100)) {
            //代替完了しなかった
            if (chgPickReserveExchange(tid, exchgPrc)) {
              //大きな金種へ代替
              log =
                  "$callFunc() exchgPrc[$exchgPrc],calcPrc[$calcPrc] NotExchange\n";
              TprLog().logAdd(tid, LogLevelDefine.normal, log);
              exchgRsltPrc = -exchgPrc;
              return DlgConfirmMsgKind.MSG_CPICK_CALC_NG.dlgId;
            }
          }
        }
        if ((i >= 10) && (exchgPrc > 0)) {
          log = "$callFunc() exchgPrc[$exchgPrc] Retry Over\n";
          TprLog().logAdd(tid, LogLevelDefine.normal, log);
          exchgRsltPrc = -exchgPrc;
          return DlgConfirmMsgKind.MSG_CPICK_CALC_NG.dlgId;
        }
      } else if (exchgPrc < 0) {
        //過剰が上回っている-> 過剰分を最小構成枚数で収納庫回収
        exchgPrc = exchgPrc.abs();
        log = "$callFunc() exchgPrc[$exchgPrc]\n";
        TprLog().logAdd(tid, LogLevelDefine.normal, log);
        for (i = startPosi; i < ChgInoutNum.CHGINOUT_MAX.num; i++) {
          if (exchgPrc <= 0) {
            log = "$callFunc() exchgPrc[$exchgPrc] ExChange OK End1\n";
            TprLog().logAdd(tid, LogLevelDefine.normal, log);
            break;
          }
          calcSht = (acr[i] - sht[i]) - limit[i]; //余剰枚数(収納枚数-回収枚数-必要最低枚数)
          if (calcSht > 0) {
            log =
                "$callFunc() Kind[$i] calcSht[$calcSht] = (acr[${acr[i]}] - sht[${sht[i]}]) - limit[${limit[i]}]\n";
            TprLog().logAdd(tid, LogLevelDefine.normal, log);
            shtCnt = exchgPrc ~/ kind[i];
            if (shtCnt <= 0) {
              continue;
            }
            if (shtCnt > calcSht) {
              shtCnt = calcSht;
            }
            exchgPrc -= kind[i] * shtCnt;
            sht[i] += shtCnt;
            log =
                "$callFunc() calc after Kind[$i] exchgPrc[$exchgPrc] shtCnt[$shtCnt]\n";
            TprLog().logAdd(tid, LogLevelDefine.normal, log);
            if (exchgPrc <= 0) {
              log = "$callFunc() exchgPrc[$exchgPrc] ExChange OK End2\n";
              TprLog().logAdd(tid, LogLevelDefine.normal, log);
              break;
            }
          }
        }
        if (i >= ChgInoutNum.CHGINOUT_MAX.num && exchgPrc > 0) {
          //棒金過剰分を釣機側で代替できなかった
          log = "$callFunc() exchgPrc[$exchgPrc] Retry Over\n";
          TprLog().logAdd(tid, LogLevelDefine.normal, log);
          exchgRsltPrc = exchgPrc;
          return DlgConfirmMsgKind.MSG_CPICK_DRW_OVER.dlgId;
        }
      }
    } else if (cBuf.dbTrm.acxRecoverLessError != 0) {
      log = "$callFunc() Lack Prohibition (user_cd25 & 8192)\n";
      TprLog().logAdd(tid, LogLevelDefine.normal, log);
      /* 残置回収タイプ：不足時、回収禁止 */
      errNo = await chgPickReserveShortErrChk(tid);
      if (errNo != Typ.OK) {
        return errNo;
      }
    }
    return 0;
  }

  /// 関連tprxソース: AplLib_Other.c - ChgPickReserve_DrwOverErrChk()
  static Future<int> chgPickReserveDrwOverErrChk(TprMID tid, int chkFlg) async {
    //chkFlg : CHGINOUT_RESV_PRC=金額残置 CHGINOUT_MAX=全金種 それ以外=指定した金種
    String log = '';
    int overFlg = 0;
    int i = 0;
    int resvPrc = 0;
    int drwPrc = 0;
    String callFunc = 'chgPickReserveDrwOverErrChk';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    overFlg = 0;
    if (await CmCksys.cmAcxChgdrwSystem() != 0 &&
        cBuf.iniMacInfo.acx_flg.acx_resv_drw != 0) {
      if (chkFlg == ChgInoutNum.CHGINOUT_RESV_PRC.num) {
        //代替仕様のため金額で確認：棒金が残置金額を超えている(棒金の回収は行わない仕様のために棒金超過=回収不可)
        for (i = 0; i < ChgInoutNum.CHGINOUT_MAX.num; i++) {
          resvPrc += (resv[i] + resvDrw[i]) * kind[i]; //残置金額
          drwPrc += drw[i] * kind[i]; //棒金ドロア金額
        }
        if (drwPrc > resvPrc) {
          log =
              "$callFunc() ChgDrw Stock Over drwPrc[$drwPrc] resvPrc[$resvPrc]\n";
          TprLog().logAdd(tid, LogLevelDefine.normal, log);
          overFlg = 1;
        }
      } else {
        //棒金枚数が残置枚数を超えている(棒金の回収は行わない仕様のために棒金超過=回収不可)
        if ((drw[ChgInOutDisp.CHGINOUT_Y500.value] >
                (resv[ChgInOutDisp.CHGINOUT_Y500.value] +
                    resvDrw[ChgInOutDisp.CHGINOUT_Y500.value])) &&
            ((chkFlg == ChgInoutNum.CHGINOUT_MAX.num) ||
                (chkFlg == ChgInOutDisp.CHGINOUT_Y500.value))) {
          log =
              "$callFunc() ChgDrw 500 Stock Over drw[${drw[ChgInOutDisp.CHGINOUT_Y500.value]}] > resv[${resv[ChgInOutDisp.CHGINOUT_Y500.value]}] + resvDrw[${resvDrw[ChgInOutDisp.CHGINOUT_Y500.value]}]\n";
          TprLog().logAdd(tid, LogLevelDefine.normal, log);
          overFlg = 1;
        }
        if ((drw[ChgInOutDisp.CHGINOUT_Y100.value] >
                (resv[ChgInOutDisp.CHGINOUT_Y100.value] +
                    resvDrw[ChgInOutDisp.CHGINOUT_Y100.value])) &&
            ((chkFlg == ChgInoutNum.CHGINOUT_MAX.num) ||
                (chkFlg == ChgInOutDisp.CHGINOUT_Y100.value))) {
          log =
              "$callFunc() ChgDrw 100 Stock Over drw[${drw[ChgInOutDisp.CHGINOUT_Y100.value]}] > resv[${resv[ChgInOutDisp.CHGINOUT_Y100.value]}] + resvDrw[${resvDrw[ChgInOutDisp.CHGINOUT_Y100.value]}]\n";
          TprLog().logAdd(tid, LogLevelDefine.normal, log);
          overFlg = 1;
        }
        if ((drw[ChgInOutDisp.CHGINOUT_Y50.value] >
                (resv[ChgInOutDisp.CHGINOUT_Y50.value] +
                    resvDrw[ChgInOutDisp.CHGINOUT_Y50.value])) &&
            ((chkFlg == ChgInoutNum.CHGINOUT_MAX.num) ||
                (chkFlg == ChgInOutDisp.CHGINOUT_Y50.value))) {
          log =
              "$callFunc() ChgDrw 50 Stock Over drw[${drw[ChgInOutDisp.CHGINOUT_Y50.value]}] > resv[${resv[ChgInOutDisp.CHGINOUT_Y50.value]}] + resvDrw[${resvDrw[ChgInOutDisp.CHGINOUT_Y50.value]}]\n";
          TprLog().logAdd(tid, LogLevelDefine.normal, log);
          overFlg = 1;
        }
        if ((drw[ChgInOutDisp.CHGINOUT_Y10.value] >
                (resv[ChgInOutDisp.CHGINOUT_Y10.value] +
                    resvDrw[ChgInOutDisp.CHGINOUT_Y10.value])) &&
            ((chkFlg == ChgInoutNum.CHGINOUT_MAX.num) ||
                (chkFlg == ChgInOutDisp.CHGINOUT_Y10.value))) {
          log =
              "$callFunc() ChgDrw 10 Stock Over drw[${drw[ChgInOutDisp.CHGINOUT_Y10.value]}] > resv[${resv[ChgInOutDisp.CHGINOUT_Y10.value]}] + resvDrw[${resvDrw[ChgInOutDisp.CHGINOUT_Y10.value]}]\n";
          TprLog().logAdd(tid, LogLevelDefine.normal, log);
          overFlg = 1;
        }
        if ((drw[ChgInOutDisp.CHGINOUT_Y5.value] >
                (resv[ChgInOutDisp.CHGINOUT_Y5.value] +
                    resvDrw[ChgInOutDisp.CHGINOUT_Y5.value])) &&
            ((chkFlg == ChgInoutNum.CHGINOUT_MAX.num) ||
                (chkFlg == ChgInOutDisp.CHGINOUT_Y5.value))) {
          log =
              "$callFunc() ChgDrw 5 Stock Over drw[${drw[ChgInOutDisp.CHGINOUT_Y5.value]}] > resv[${resv[ChgInOutDisp.CHGINOUT_Y5.value]}] + resvDrw[${resvDrw[ChgInOutDisp.CHGINOUT_Y5.value]}]\n";
          TprLog().logAdd(tid, LogLevelDefine.normal, log);
          overFlg = 1;
        }
        if ((drw[ChgInOutDisp.CHGINOUT_Y1.value] >
                (resv[ChgInOutDisp.CHGINOUT_Y1.value] +
                    resvDrw[ChgInOutDisp.CHGINOUT_Y1.value])) &&
            ((chkFlg == ChgInoutNum.CHGINOUT_MAX.num) ||
                (chkFlg == ChgInOutDisp.CHGINOUT_Y1.value))) {
          log =
              "$callFunc() ChgDrw 1 Stock Over drw[${drw[ChgInOutDisp.CHGINOUT_Y1.value]}] > resv[${resv[ChgInOutDisp.CHGINOUT_Y1.value]}] + resvDrw[${resvDrw[ChgInOutDisp.CHGINOUT_Y1.value]}]\n";
          TprLog().logAdd(tid, LogLevelDefine.normal, log);
          overFlg = 1;
        }
      }
    }
    if (overFlg == 1) {
      return DlgConfirmMsgKind.MSG_CPICK_DRW_OVER.dlgId;
    }
    return Typ.OK;
  }

  /// 関連tprxソース: AplLib_Other.c - ChgPickReserve_LimitErrChk()
  static int chgPickReserveLimitErrChk(TprMID tid) {
    //必要最低枚数不足があるかチェック(回収枚数を計算前に行い、その時点で下回っていればエラー)
    String log = '';
    int i = 0;
    int shortFlg = 0;
    String callFunc = 'chgPickReserveLimitErrChk';

    shortFlg = 0;
    for (i = startPosi; i < ChgInoutNum.CHGINOUT_MAX.num; i++) {
      if (acr[i] < limit[i]) {
        log =
            "$callFunc() ReserveLimit[$i] acr_cnt[${acr[i]}], limit_cnt[${limit[i]}] Error\n";
        TprLog().logAdd(tid, LogLevelDefine.normal, log);
        errSht[i] = (acr[i] - limit[i]).abs(); //今後、印字データに用いる予定
        shortFlg = 1;
      }
    }
    if (shortFlg == 1) {
      return DlgConfirmMsgKind.MSG_CPICK_LIMIT_NG.dlgId;
    }
    return Typ.OK;
  }

  /// 関連tprxソース: AplLib_Other.c - ChgPickReserve_shtDataSet()
  static Future<void> chgPickReserveShtDataSet(TprMID tid, int chkFlg) async {
    //枚数指定残置計算
    String log = '';
    String iniName = '';
    String pickCBillKind = '';
    int trmSSht = 0;
    int drwSSht = 0;
    int i = 0;
    String callFunc = 'chgPickReserveShtDataSet';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    if (chkFlg == 1) {
      //金種指定残置
      iniName = sprintf("%s/conf/mac_info.ini", [EnvironmentData().sysHomeDir]);
      JsonRet ret = await getJsonValue(iniName, "acx_flg", "acx_pickCBillKind");
      if (ret.result) {
        pickCBillKind = '';
      }

      log = sprintf("%s() pick_flg[%i, %i, %i, %i, %i, %i, %i, %i, %i, %i]\n", [
        callFunc,
        pickCBillKind[ChgInOutDisp.CHGINOUT_Y10000.value],
        pickCBillKind[ChgInOutDisp.CHGINOUT_Y5000.value],
        pickCBillKind[ChgInOutDisp.CHGINOUT_Y2000.value],
        pickCBillKind[ChgInOutDisp.CHGINOUT_Y1000.value],
        pickCBillKind[ChgInOutDisp.CHGINOUT_Y500.value],
        pickCBillKind[ChgInOutDisp.CHGINOUT_Y100.value],
        pickCBillKind[ChgInOutDisp.CHGINOUT_Y50.value],
        pickCBillKind[ChgInOutDisp.CHGINOUT_Y10.value],
        pickCBillKind[ChgInOutDisp.CHGINOUT_Y5.value],
        pickCBillKind[ChgInOutDisp.CHGINOUT_Y1.value]
      ]);
      TprLog().logAdd(tid, LogLevelDefine.normal, log);
    }

    for (i = startPosi; i < ChgInoutNum.CHGINOUT_MAX.num; i++) {
      ChgInOutDisp value = ChgInOutDisp.getDefine(i);
      switch (value) {
        case ChgInOutDisp.CHGINOUT_Y10000:
          trmSSht = resv[ChgInOutDisp.CHGINOUT_Y10000.value];
          drwSSht = resvDrw[ChgInOutDisp.CHGINOUT_Y10000.value];
          break;
        case ChgInOutDisp.CHGINOUT_Y5000:
          if ((acbSelect & CoinChanger.ECS_X) != 0 ||
              ((acbSelect & CoinChanger.ACB_50_X) != 0 &&
                  (cBuf.dbTrm.bothAcrClrFlg == 0))) {
            trmSSht = resv[ChgInOutDisp.CHGINOUT_Y5000.value];
          } else {
            trmSSht = 0;
          }
          drwSSht = resvDrw[ChgInOutDisp.CHGINOUT_Y5000.value];
          break;
        case ChgInOutDisp.CHGINOUT_Y2000:
          if ((acbSelect & CoinChanger.ECS_X) != 0 ||
              ((acbSelect & CoinChanger.ACB_50_X) != 0 &&
                  (cBuf.dbTrm.bothAcrClrFlg == 1))) {
            trmSSht = resv[ChgInOutDisp.CHGINOUT_Y2000.value];
          } else {
            trmSSht = 0;
          }
          drwSSht = resvDrw[ChgInOutDisp.CHGINOUT_Y2000.value];
          break;
        case ChgInOutDisp.CHGINOUT_Y1000:
          trmSSht = resv[ChgInOutDisp.CHGINOUT_Y1000.value];
          drwSSht = resvDrw[ChgInOutDisp.CHGINOUT_Y1000.value];
          break;
        case ChgInOutDisp.CHGINOUT_Y500:
          trmSSht = resv[ChgInOutDisp.CHGINOUT_Y500.value];
          drwSSht = resvDrw[ChgInOutDisp.CHGINOUT_Y500.value];
          break;
        case ChgInOutDisp.CHGINOUT_Y100:
          trmSSht = resv[ChgInOutDisp.CHGINOUT_Y100.value];
          drwSSht = resvDrw[ChgInOutDisp.CHGINOUT_Y100.value];
          break;
        case ChgInOutDisp.CHGINOUT_Y50:
          trmSSht = resv[ChgInOutDisp.CHGINOUT_Y50.value];
          drwSSht = resvDrw[ChgInOutDisp.CHGINOUT_Y50.value];
          break;
        case ChgInOutDisp.CHGINOUT_Y10:
          trmSSht = resv[ChgInOutDisp.CHGINOUT_Y10.value];
          drwSSht = resvDrw[ChgInOutDisp.CHGINOUT_Y10.value];
          break;
        case ChgInOutDisp.CHGINOUT_Y5:
          trmSSht = resv[ChgInOutDisp.CHGINOUT_Y5.value];
          drwSSht = resvDrw[ChgInOutDisp.CHGINOUT_Y5.value];
          break;
        case ChgInOutDisp.CHGINOUT_Y1:
          trmSSht = resv[ChgInOutDisp.CHGINOUT_Y1.value];
          drwSSht = resvDrw[ChgInOutDisp.CHGINOUT_Y1.value];
          break;
        default:
          break;
      }
      if (chkFlg == 1) {
        //金種指定残置
        if (pickCBillKind[i] == '1') {
          //残置（補充基準値）
          sht[i] = acr[i] - trmSSht;
          if (await CmCksys.cmAcxChgdrwSystem() != 0 &&
              cBuf.iniMacInfo.acx_flg.acx_resv_drw != 0) {
            shtDrw[i] = drw[i] - drwSSht;
          }
        } else if (pickCBillKind[i] == '2') {
          //残置なし
          sht[i] = acr[i];
          if (await CmCksys.cmAcxChgdrwSystem() != 0 &&
              cBuf.iniMacInfo.acx_flg.acx_resv_drw != 0) {
            shtDrw[i] = drw[i];
          }
        } else {
          //全残置
          sht[i] = 0;
          if (await CmCksys.cmAcxChgdrwSystem() != 0 &&
              cBuf.iniMacInfo.acx_flg.acx_resv_drw != 0) {
            shtDrw[i] = 0;
          }
        }
      } else {
        //残置（補充基準値）
        sht[i] = acr[i] - trmSSht;
        if (await CmCksys.cmAcxChgdrwSystem() != 0 &&
            cBuf.iniMacInfo.acx_flg.acx_resv_drw != 0) {
          shtDrw[i] = drw[i] - drwSSht;
        }
      }
    }
    log = sprintf(
        "%s()  sht    [%3i, %3i, %3i, %3i, %3i, %3i, %3i, %3i, %3i, %3i]\n", [
      callFunc,
      sht[ChgInOutDisp.CHGINOUT_Y10000.value],
      sht[ChgInOutDisp.CHGINOUT_Y5000.value],
      sht[ChgInOutDisp.CHGINOUT_Y2000.value],
      sht[ChgInOutDisp.CHGINOUT_Y1000.value],
      sht[ChgInOutDisp.CHGINOUT_Y500.value],
      sht[ChgInOutDisp.CHGINOUT_Y100.value],
      sht[ChgInOutDisp.CHGINOUT_Y50.value],
      sht[ChgInOutDisp.CHGINOUT_Y10.value],
      sht[ChgInOutDisp.CHGINOUT_Y5.value],
      sht[ChgInOutDisp.CHGINOUT_Y1.value]
    ]);
    TprLog().logAdd(tid, LogLevelDefine.normal, log);
    log = sprintf(
        "%s()  acr    [%3i, %3i, %3i, %3i, %3i, %3i, %3i, %3i, %3i, %3i]\n",
        [
          callFunc,
          acr[ChgInOutDisp.CHGINOUT_Y10000.value],
          acr[ChgInOutDisp.CHGINOUT_Y5000.value],
          acr[ChgInOutDisp.CHGINOUT_Y2000.value],
          acr[ChgInOutDisp.CHGINOUT_Y1000.value],
          acr[ChgInOutDisp.CHGINOUT_Y500.value],
          acr[ChgInOutDisp.CHGINOUT_Y100.value],
          acr[ChgInOutDisp.CHGINOUT_Y50.value],
          acr[ChgInOutDisp.CHGINOUT_Y10.value],
          acr[ChgInOutDisp.CHGINOUT_Y5.value],
          acr[ChgInOutDisp.CHGINOUT_Y1.value]
        ]);
    TprLog().logAdd(tid, LogLevelDefine.normal, log);
    if (await CmCksys.cmAcxChgdrwSystem() != 0 &&
        cBuf.iniMacInfo.acx_flg.acx_resv_drw != 0) {
      log = sprintf(
          "%s()  shtDrw [%3i, %3i, %3i, %3i, %3i, %3i, %3i, %3i, %3i, %3i]\n", [
        callFunc,
        shtDrw[ChgInOutDisp.CHGINOUT_Y10000.value],
        shtDrw[ChgInOutDisp.CHGINOUT_Y5000.value],
        shtDrw[ChgInOutDisp.CHGINOUT_Y2000.value],
        shtDrw[ChgInOutDisp.CHGINOUT_Y1000.value],
        shtDrw[ChgInOutDisp.CHGINOUT_Y500.value],
        shtDrw[ChgInOutDisp.CHGINOUT_Y100.value],
        shtDrw[ChgInOutDisp.CHGINOUT_Y50.value],
        shtDrw[ChgInOutDisp.CHGINOUT_Y10.value],
        shtDrw[ChgInOutDisp.CHGINOUT_Y5.value],
        shtDrw[ChgInOutDisp.CHGINOUT_Y1.value]
      ]);
      TprLog().logAdd(tid, LogLevelDefine.normal, log);
      log = sprintf(
          "%s()  drw    [%3i, %3i, %3i, %3i, %3i, %3i, %3i, %3i, %3i, %3i]\n",
          [
            callFunc,
            drw[ChgInOutDisp.CHGINOUT_Y10000.value],
            drw[ChgInOutDisp.CHGINOUT_Y5000.value],
            drw[ChgInOutDisp.CHGINOUT_Y2000.value],
            drw[ChgInOutDisp.CHGINOUT_Y1000.value],
            drw[ChgInOutDisp.CHGINOUT_Y500.value],
            drw[ChgInOutDisp.CHGINOUT_Y100.value],
            drw[ChgInOutDisp.CHGINOUT_Y50.value],
            drw[ChgInOutDisp.CHGINOUT_Y10.value],
            drw[ChgInOutDisp.CHGINOUT_Y5.value],
            drw[ChgInOutDisp.CHGINOUT_Y1.value]
          ]);
      TprLog().logAdd(tid, LogLevelDefine.normal, log);
    }
  }

  /// 関連tprxソース: AplLib_Other.c - ChgPickReserve_DrwOverCalc()
  static Future<int> chgPickReserveDrwOverCalc(TprMID tid, int chkFlg) async {
    /* 棒金超過金額計算（棒金開での要回収金額） */
    String log = '';
    int i = 0;
    int price = 0;
    int calc = 0;
    String callFunc = 'chgPickReserveDrwOverCalc';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if (await CmCksys.cmAcxChgdrwSystem() != 0 &&
        cBuf.iniMacInfo.acx_flg.acx_resv_drw != 0) {
      for (i = startPosi; i < ChgInoutNum.CHGINOUT_MAX.num; i++) {
        if (chkFlg != ChgInoutNum.CHGINOUT_MAX.num && chkFlg != i) {
          //全金種でも指定した金種でもない
          continue;
        }
        calc = drw[i] - resvDrw[i]; //棒金回収枚数 = 棒金収納枚数 - 残置枚数
        if (calc > 0) {
          log = "$callFunc() DrwKind[$i] OverCount = $calc\n";
          TprLog().logAdd(tid, LogLevelDefine.normal, log);
          price += calc * kind[i];
        }
      }
    }
    return price;
  }

  /// 関連tprxソース: AplLib_Other.c - ChgPickReserve_ShortCalc()
  static Future<int> chgPickReserveShortCalc(TprMID tid) async {
    /* 不足金額計算（代替対象金額） */
    String log = '';
    int i = 0;
    int price = 0;
    String callFunc = 'chgPickReserveShortCalc';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    for (i = startPosi; i < ChgInoutNum.CHGINOUT_MAX.num; i++) {
      if (sht[i] < 0) {
        log = "$callFunc() Kind[$i] CPickCount = ${sht[i]}\n";
        TprLog().logAdd(tid, LogLevelDefine.normal, log);
        price += -sht[i] * kind[i];
        sht[i] = 0;
      }
    }
    if (await CmCksys.cmAcxChgdrwSystem() != 0 &&
        cBuf.iniMacInfo.acx_flg.acx_resv_drw != 0) {
      for (i = startPosi; i < ChgInoutNum.CHGINOUT_MAX.num; i++) {
        if (shtDrw[i] < 0) {
          log = "$callFunc() DrwKind[$i] CPickCount = ${shtDrw[i]}\n";
          TprLog().logAdd(tid, LogLevelDefine.normal, log);
          price += -shtDrw[i] * kind[i];
          shtDrw[i] = 0;
        }
      }
    }
    return price;
  }

  /// 関連tprxソース: AplLib_Other.c - ChgPickReserve_CalcPrcSet()
  static int chgPickReserveCalcPrcSet(TprMID tid, int exChgPrc) {
    /* 代替(残置積立)使用金種セット（各金種１枚ずつ 6666円 - 1円） */
    String log = '';
    int i = 0;
    int tmpBuf = 0;
    int price = 0;

    calcSht = 0;
    cPickKind = 0;
    for (i = startPosi; i < ChgInoutNum.CHGINOUT_MAX.num; i++) {
      if (i == ChgInOutDisp.CHGINOUT_Y10000.value ||
          i == ChgInOutDisp.CHGINOUT_Y2000.value) {
        continue;
      }

      if (sht[i] > 0) {
        tmpBuf = price;
        tmpBuf += kind[i];
        if (tmpBuf > exChgPrc) {
          continue;
        } else {
          price += kind[i];
          /* 代替使用金種セット */
          cPickKind |= 1 << (i + 1);
          if (calcSht == 0 || sht[i] < calcSht) {
            calcSht = sht[i];
          }
        }
      }
    }
    log = "%s() calc_prc[$price]\n";
    TprLog().logAdd(tid, LogLevelDefine.normal, log);
    return price;
  }

  /// 関連tprxソース: AplLib_Other.c - ChgPickReserve_CntSet()
  static void chgPickReserveCntSet(int shtCnt) {
    /* 回収枚数セット（残置金を除外） */
    int i = 0;

    for (i = startPosi; i < ChgInoutNum.CHGINOUT_MAX.num; i++) {
      /* 代替使用金種チェック */
      if ((cPickKind & (1 << (i + 1))) == 0) {
        continue;
      }
      sht[i] -= shtCnt;
    }
  }

  /// 関連tprxソース: AplLib_Other.c - ChgPickReserve_Exchange()
  static bool chgPickReserveExchange(TprMID tid, int exChgPrc) {
    /* 小さい金種から大きい金種へ変更 */
    String log = '';
    int i = 0;
    int j = 0;
    int acbResvLimit = 0;
    int shtCnt;
    int addCnt;
    int exChgKind;
    int price = 0;
    int retryFlg = 0;
    int tmpBuf = 0;
    String callFunc = 'chgPickReserveExchange';

    for (i = 0; i < 100; i++) {
      if (exChgPrc >= 10000) {
        sht[ChgInOutDisp.CHGINOUT_Y10000.value] -= exChgPrc ~/ 10000;
        if (sht[ChgInOutDisp.CHGINOUT_Y10000.value] < 0) {
          return true;
        }
        exChgPrc = exChgPrc % 10000;
      }

      if (exChgPrc >= 5000) {
        price = 10000;
        exChgKind = ChgInOutDisp.CHGINOUT_Y10000.value;
      } else if (exChgPrc >= 2000) {
        price = 5000;
        exChgKind = ChgInOutDisp.CHGINOUT_Y5000.value;
      } else if (exChgPrc >= 1000) {
        price = 2000;
        exChgKind = ChgInOutDisp.CHGINOUT_Y2000.value;
      } else if (exChgPrc >= 500) {
        price = 1000;
        exChgKind = ChgInOutDisp.CHGINOUT_Y1000.value;
      } else if (exChgPrc >= 100) {
        price = 500;
        exChgKind = ChgInOutDisp.CHGINOUT_Y500.value;
      } else if (exChgPrc >= 50) {
        price = 100;
        exChgKind = ChgInOutDisp.CHGINOUT_Y100.value;
      } else if (exChgPrc >= 10) {
        price = 50;
        exChgKind = ChgInOutDisp.CHGINOUT_Y50.value;
      } else if (exChgPrc >= 5) {
        price = 10;
        exChgKind = ChgInOutDisp.CHGINOUT_Y10.value;
      } else if (exChgPrc >= 1) {
        price = 5;
        exChgKind = ChgInOutDisp.CHGINOUT_Y5.value;
      } else {
        price = 0;
        exChgKind = -1;
      }

      if (exChgKind != -1) {
        if (sht[exChgKind] <= 0) {
          if (price == 10000) {
            return true;
          } else {
            retryFlg = 1;
          }
        }
      }

      log = "$callFunc() Price[$exChgPrc] -> [$price]\n";
      TprLog().logAdd(tid, LogLevelDefine.normal, log);
      /* １単位上の金種と代替対象金額との差 */
      tmpBuf = price - exChgPrc;

      for (j = startPosi; j < ChgInoutNum.CHGINOUT_MAX.num; j++) {
        if (tmpBuf < kind[j]) {
          continue;
        }
        /* 残置最低枚数(残置基準値設定) */
        acbResvLimit = limit[j];
        /* 残置積立枚数 = 回収前枚数-回収枚数 */
        shtCnt = acr[j] - sht[j];
        if (shtCnt <= acbResvLimit) {
          continue;
        }
        /* 使用可能枚数 */
        shtCnt -= acbResvLimit;
        /* 残置から回収へ戻したい枚数 */
        addCnt = tmpBuf ~/ kind[j];
        /* 残置最低枚数を下回らないかチェックし、下回る場合は使用可能枚数にする */
        if (addCnt > shtCnt) {
          addCnt = shtCnt;
        }

        /* 残置積立から回収へ戻す */
        exChgPrc += kind[j] * addCnt;
        sht[j] += addCnt;
        tmpBuf -= kind[j] * addCnt;
        if (tmpBuf <= 0) {
          break;
        }
      }

      if (tmpBuf == 0) {
        if (retryFlg == 1) {
          /* もう１単位上の金種へ変更 */
          retryFlg = 0;
          continue;
        } else {
          if (exChgKind != -1) {
            sht[exChgKind] -= 1;
            exChgPrc -= kind[exChgKind];
          }
          return false;
        }
      } else {
        retryFlg = 0;
        return true;
      }
    }
    return true;
  }

  /// 残置不足があるかチェック
  /// 関連tprxソース: AplLib_Other.c - ChgPickReserve_ShortErrChk()
  static Future<int> chgPickReserveShortErrChk(TprMID tid) async {
    String log = '';
    int i = 0;
    int shortFlg = 0;
    String callFunc = 'chgPickReserveShortErrChk';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    shortFlg = 0;
    for (i = startPosi; i < ChgInoutNum.CHGINOUT_MAX.num; i++) {
      if (sht[i] < 0) {
        log = "$callFunc() ReserveShort[$i] short_cnt[${sht[i]}] Error\n";
        TprLog().logAdd(tid, LogLevelDefine.normal, log);
        errSht[i] = sht[i].abs(); //今後、印字データに用いる予定
        shortFlg = 1;
      }
    }

    if (await CmCksys.cmAcxChgdrwSystem() != 0 &&
        cBuf.iniMacInfo.acx_flg.acx_resv_drw != 0) {
      for (i = startPosi; i < ChgInoutNum.CHGINOUT_MAX.num; i++) {
        if (shtDrw[i] < 0) {
          log =
              "$callFunc() ReserveShortDrw[$i] short_cnt[${shtDrw[i]}] Error\n";
          TprLog().logAdd(tid, LogLevelDefine.normal, log);
          errShtDrw[i] = shtDrw[i].abs(); //今後、印字データに用いる予定
          shortFlg = 1;
        }
      }
    }

    if (shortFlg == 1) {
      return DlgConfirmMsgKind.MSG_MONEY_SUPPLEMENT.dlgId;
    }

    return Typ.OK;
  }

  /// 関連tprxソース: AplLib_Other.c - ChgPickReserve_DataSet_CBillKind()
  static Future<int> chgPickReserveDataSetCBillKind(TprMID tid) async {
    String log = '';
    int errNo = Typ.OK;
    String callFunc = 'chgPickReserveDataSetCBillKind';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    log = "$callFunc()\n";
    TprLog().logAdd(tid, LogLevelDefine.normal, log);

    /* 必要最低枚数不足 */
    errNo = chgPickReserveLimitErrChk(tid);
    if (errNo != Typ.OK) {
      return errNo;
    }

    await chgPickReserveShtDataSet(tid, 1);
    if (cBuf.dbTrm.acxRecoverLessError != 0) {
      /* 残置回収タイプ：不足時、回収禁止 */
      log = "$callFunc() Lack Prohibition (user_cd25 & 8192)\n";
      TprLog().logAdd(tid, LogLevelDefine.normal, log);
      errNo = await chgPickReserveShortErrChk(tid);
      if (errNo != Typ.OK) {
        return errNo;
      }
    }

    return 0;
  }

  /// 関連tprxソース: AplLib_Other.c - ChgPickReserve_DataSet_CoinMinimum()
  static Future<int> chgPickReserveDataSetCoinMinimum(TprMID tid) async {
    String log = '';
    int shtCnt = 0;
    int setCnt = 0;
    int ttlPrc = 0;
    int resvPrc = 0;
    int resvDrwPrc = 0;
    int drwPrc = 0;
    int pickPrc = 0;
    int errNo = Typ.OK;
    int tempSht = 0;
    int tempSht2 = 0;
    int i = 0;
    String callFunc = 'chgPickReserveDataSetCoinMinimum';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    log = "$callFunc()\n";
    TprLog().logAdd(tid, LogLevelDefine.normal, log);

    /* 棒金過剰 */
    errNo = await chgPickReserveDrwOverErrChk(
        tid, ChgInoutNum.CHGINOUT_RESV_PRC.num);
    if (errNo != Typ.OK) {
      return errNo;
    }

    /* 必要最低枚数不足 */
    errNo = chgPickReserveLimitErrChk(tid);
    if (errNo != Typ.OK) {
      return errNo;
    }

    //収納庫内金額合計
    //残置金額合計
    for (i = 0; i < ChgInoutNum.CHGINOUT_MAX.num; i++) {
      ttlPrc += acr[i] * kind[i];
      resvPrc += resv[i] * kind[i];
      if (await CmCksys.cmAcxChgdrwSystem() != 0 &&
          cBuf.iniMacInfo.acx_flg.acx_resv_drw != 0) {
        drwPrc += drw[i] * kind[i];
        resvDrwPrc += resvDrw[i] * kind[i];
      }
    }

    //回収金額合計(いくら回収すれば残置金額が残るか)
    pickPrc = (ttlPrc + drwPrc) - (resvPrc + resvDrwPrc);

    log =
        "$callFunc() pickPrc[$pickPrc] = (ttlPrc[$ttlPrc] + drwPrc[$drwPrc]) - (resvPrc[$resvPrc] + resvDrwPrc[$resvDrwPrc])\n";
    TprLog().logAdd(tid, LogLevelDefine.normal, log);

    if (pickPrc < 0) {
      return DlgConfirmMsgKind.MSG_MONEY_SUPPLEMENT.dlgId;
    }

    //各金種毎に回収枚数計算
    shtCnt = pickPrc ~/ 10000;
    tempSht = acr[ChgInOutDisp.CHGINOUT_Y10000.value];
    if (shtCnt > tempSht) {
      sht[ChgInOutDisp.CHGINOUT_Y10000.value] = tempSht;
    } else {
      sht[ChgInOutDisp.CHGINOUT_Y10000.value] = shtCnt;
    }
    pickPrc -= (sht[ChgInOutDisp.CHGINOUT_Y10000.value] * 10000);

    shtCnt = pickPrc ~/ 2000;
    tempSht = acr[ChgInOutDisp.CHGINOUT_Y2000.value] -
        limit[ChgInOutDisp.CHGINOUT_Y2000.value];
    if (shtCnt > tempSht) {
      sht[ChgInOutDisp.CHGINOUT_Y2000.value] = tempSht;
    } else {
      sht[ChgInOutDisp.CHGINOUT_Y2000.value] = shtCnt;
    }
    pickPrc -= (sht[ChgInOutDisp.CHGINOUT_Y2000.value] * 2000);

    //必要最低枚数を除いた排出可能枚数(5000円と1000円の回収枚数を同数で計算することにより偏りが出ないようになるのを期待)
    tempSht = acr[ChgInOutDisp.CHGINOUT_Y5000.value] -
        limit[ChgInOutDisp.CHGINOUT_Y5000.value];
    tempSht2 = acr[ChgInOutDisp.CHGINOUT_Y1000.value] -
        limit[ChgInOutDisp.CHGINOUT_Y1000.value];
    if (tempSht > tempSht2) {
      setCnt = tempSht2;
    } else {
      setCnt = tempSht;
    }

    shtCnt = pickPrc ~/ 6000;
    if (shtCnt > setCnt) {
      sht[ChgInOutDisp.CHGINOUT_Y5000.value] = setCnt;
      sht[ChgInOutDisp.CHGINOUT_Y1000.value] = setCnt;
    } else {
      sht[ChgInOutDisp.CHGINOUT_Y5000.value] = shtCnt;
      sht[ChgInOutDisp.CHGINOUT_Y1000.value] = shtCnt;
    }
    pickPrc -= ((sht[ChgInOutDisp.CHGINOUT_Y5000.value] * 5000) +
        (sht[ChgInOutDisp.CHGINOUT_Y1000.value] * 1000));
    if (tempSht > tempSht2) {
      //同数で回収したがまだ余力がある金種の回収
      shtCnt = pickPrc ~/ 5000;
      tempSht = acr[ChgInOutDisp.CHGINOUT_Y5000.value] -
          sht[ChgInOutDisp.CHGINOUT_Y5000.value] -
          limit[ChgInOutDisp.CHGINOUT_Y5000.value];
      if (shtCnt > tempSht) {
        sht[ChgInOutDisp.CHGINOUT_Y5000.value] += tempSht; //先程の計算結果に加算
        pickPrc -= (tempSht * 5000);
      } else {
        sht[ChgInOutDisp.CHGINOUT_Y5000.value] += shtCnt; //先程の計算結果に加算
        pickPrc -= (shtCnt * 5000);
      }
    } else {
      shtCnt = pickPrc ~/ 1000;
      tempSht = acr[ChgInOutDisp.CHGINOUT_Y1000.value] -
          sht[ChgInOutDisp.CHGINOUT_Y1000.value] -
          limit[ChgInOutDisp.CHGINOUT_Y1000.value];
      if (shtCnt > tempSht) {
        sht[ChgInOutDisp.CHGINOUT_Y1000.value] += tempSht; //先程の計算結果に加算
        pickPrc -= (tempSht * 1000);
      } else {
        sht[ChgInOutDisp.CHGINOUT_Y1000.value] += shtCnt; //先程の計算結果に加算
        pickPrc -= (shtCnt * 1000);
      }
    }

    for (i = ChgInOutDisp.CHGINOUT_Y500.value;
        i < ChgInoutNum.CHGINOUT_MAX.num;
        i++) {
      shtCnt = pickPrc ~/ kind[i]; //回収したい最大値
      tempSht = acr[i] - limit[i]; //回収可能枚数
      if (shtCnt > tempSht) {
        sht[i] = tempSht;
      } else {
        sht[i] = shtCnt;
      }
      pickPrc -= (sht[i] * kind[i]);
    }
    if (pickPrc != 0) {
      log = sprintf("%s() pickPrc[%i] : [%i,%i,%i,%i,%i,%i,%i,%i,%i,%i]\n", [
        callFunc,
        pickPrc,
        acr[ChgInOutDisp.CHGINOUT_Y10000.value],
        acr[ChgInOutDisp.CHGINOUT_Y5000.value],
        acr[ChgInOutDisp.CHGINOUT_Y2000.value],
        acr[ChgInOutDisp.CHGINOUT_Y1000.value],
        acr[ChgInOutDisp.CHGINOUT_Y500.value],
        acr[ChgInOutDisp.CHGINOUT_Y100.value],
        acr[ChgInOutDisp.CHGINOUT_Y50.value],
        acr[ChgInOutDisp.CHGINOUT_Y10.value],
        acr[ChgInOutDisp.CHGINOUT_Y5.value],
        acr[ChgInOutDisp.CHGINOUT_Y1.value]
      ]);
      TprLog().logAdd(tid, LogLevelDefine.normal, log);
      return DlgConfirmMsgKind.MSG_MONEY_SUPPLEMENT.dlgId;
    }

    return 0;
  }
}

/// 関連tprxソース: AplLib_Other.c - CHGINOUT_NUM()
enum ChgInoutNum {
  CHGINOUT_Y10000(0),
  CHGINOUT_Y5000(1),
  CHGINOUT_Y2000(2),
  CHGINOUT_Y1000(3),
  CHGINOUT_Y500(4),
  CHGINOUT_Y100(5),
  CHGINOUT_Y50(6),
  CHGINOUT_Y10(7),
  CHGINOUT_Y5(8),
  CHGINOUT_Y1(9),
  CHGINOUT_MAX(10),
  CHGINOUT_RESV_PRC(99);

  final int num;

  const ChgInoutNum(this.num);
}