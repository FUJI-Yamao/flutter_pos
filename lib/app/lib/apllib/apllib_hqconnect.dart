/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../common/date_util.dart';
import '../../inc/apl/rxmem.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/cm_sys.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_type.dart';
import '../cm_sys/cm_cksys.dart';
import '../../inc/sys/tpr_log.dart';

/// 関連tprxソース:AplLib_HqConnect.c
class AplLibHqConnect{
  ///	Values
  static const TASK_REQ_WAIT = 60;

  ///	機能:	上位からマスタ受信する仕様かチェックする関数
  ///	戻値:	0: 違う  1: マスタ受信する
  /// 関連tprxソース:AplLib_HqConnect.c - AplLib_HqConnect_Hqhist_Recv_Check_System
  static Future<int> aplLibHqConnectHqHistRecvCheckSystem(TprTID tid) async {
    int mmType = 0;
    mmType = CmCksys.cmMmType();
    if (mmType == CmSys.MacM1 || mmType == CmSys.MacMOnly) {
      if (await CmCksys.cmNetDoASystem() != 0 // netDoA
              || await CmCksys.cmCSSSystem() != 0 // CSS
          ) {
        return 1;
      }
    }
    return 0;
  }

  /// 機能:	上位へ実績などを送信する仕様かチェックする関数
  /// 戻値:	0: 違う  1: 送信する
  /// 関連tprxソース:AplLib_HqConnect.c - AplLib_HqConnect_Hqftp_Send_Check_System
  static Future<int> aplLibHqConnectHqftpSendCheckSystem(TprTID tid) async {
    int mmType = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    mmType = CmCksys.cmMmType();
    if (mmType == CmSys.MacM1 || mmType == CmSys.MacMOnly) {
      if (await CmCksys.cmNetDoASystem() != 0 // netDoA
              || await CmCksys.cmCSSSystem() != 0){ // CSS
        return 1;
      }
    } else if (mmType == CmSys.MacERR) {
      if (cBuf.dbTrm.tsLgyoumuSend == 1) {
        return 1;
      }
    }

    return 0;
  }

  /// 機能:	hqftpタスクにtype(HQFTP_REQUEST_TYP)の実行要求を行う.
  /// 本部通信系以外は何もしない
  /// 関連tprxソース: AplLib_HqConnect.c - AplLib_HqConnect_Hqftp_Request_Start
  static Future<int> aplLibHqConnectHqftpRequestStart(
      TprTID tid, int type, String? reqBuf) async {
    String log = '';
    String callFunc = 'aplLibHqConnectHqftpRequestStart';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      log = "$callFunc : rxMemPtr error [$type]";
      TprLog().logAdd(tid, LogLevelDefine.error, log);
      return DlgConfirmMsgKind.MSG_SYSERR_RETRY.dlgId;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    int count = 0;
    String saleDate = '';
    int error = 0;
    String buf = "";
    int max;
    int cmpLen = 8;

    if (await aplLibHqConnectHqftpSendCheckSystem(tid) == 0) {
      return 0;
    }

    if (type == HqftpRequestTyp.HQFTP_REQ_RESEND.type ||
        type == HqftpRequestTyp.HQFTP_REQ_ODR.type ||
        type == HqftpRequestTyp.HQFTP_REQ_PAST_CREATE.type) {
      if (type == HqftpRequestTyp.HQFTP_REQ_ODR.type) {
        cmpLen = 14;
      }

      if (reqBuf == null ||
          reqBuf.length < cmpLen ||
          reqBuf.length > tsBuf.hqftp.requestBuf.length - 1) {
        log = "$callFunc : Argument error [$type]";
        TprLog().logAdd(tid, LogLevelDefine.error, log);
        return DlgConfirmMsgKind.MSG_SYSERR_RETRY.dlgId;
      }

      buf = reqBuf;
    }

    if (type == HqftpRequestTyp.HQFTP_REQ_PAST_CREATE.type) {
      // 現在営業日の取得
      (error, saleDate) = await DateUtil.dateTimeChange(
          null,
          DateTimeChangeType.DATE_TIME_CHANGE_SALE_DATE,
          DateTimeFormatKind.FT_YYYYMMDD,
          DateTimeFormatWay.DATE_TIME_FORMAT_ZERO);
      if (reqBuf!.substring(0, saleDate.length).compareTo(saleDate) == 0) {
        log = "$callFunc : Recreate today is skip [$saleDate]";
        TprLog().logAdd(tid, LogLevelDefine.normal, log);
        return DlgConfirmMsgKind.MSG_SYSERR_RETRY.dlgId;
      }
    }

    if (type == HqftpRequestTyp.HQFTP_REQ_CSSMSTCREATE.type) {
      buf = reqBuf!;
    }

    log = "$callFunc : Start [$type] [$buf] ";
    TprLog().logAdd(tid, LogLevelDefine.normal, log);

    count = 0;
    while (true) {
      if (tsBuf.hqftp.running == 0) {
        break;
      }
      count++;
      await Future.delayed(const Duration(seconds: 1));

      if (count > TASK_REQ_WAIT) {
        log =
            "$callFunc : Request Wait Over [$type] [${tsBuf.hqftp.requestStart}]";
        TprLog().logAdd(tid, LogLevelDefine.error, log);
        break;
      }
    }

    max = 0;

    // 要求処理
    tsBuf.hqftp.hqftpEnd = 0; // 要求状態  0:開始  1:終了(定期時刻での受信モード)
    tsBuf.hqftp.requestBuf = buf; // その他要求情報
    tsBuf.hqftp.requestStart = type; // 別タスクからの要求  HQFTP_REQUEST_TYPの値

    count = 0;
    while (true) {
      count++;
      if (tsBuf.hqftp.hqftpEnd == 1) {
        break;
      }

      if (count / 20 != 0) {
        log = "$callFunc : Wait ";
        TprLog().logAdd(tid, LogLevelDefine.normal, log);
        count = 0;
      }
      await Future.delayed(const Duration(seconds: 1));
    }

    log = "$callFunc : End [${tsBuf.hqftp.requestResult}]";
    TprLog().logAdd(tid, LogLevelDefine.normal, log);

    return tsBuf.hqftp.requestResult;
  }

  ///	機能:	hqhistタスクに対して, マスタ受信要求を行う.
  ///	注意:	hqftpタスクが動作中の時, 最大TASK_REQ_WAIT待つ.
  /// 関連tprxソース: AplLib_HqConnect.c - AplLib_HqConnect_Hqhist_Request_Start
  static Future<int> aplLibHqConnectHqHistRequestStart(
      TprTID tid, int type) async {
    String log = '';
    String callFunc = 'aplLibHqConnectHqHistRequestStart';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      log = "$callFunc : rxMemPtr error [$type]";
      TprLog().logAdd(tid, LogLevelDefine.error, log);
      return -1;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    int num = 0;

    if (await aplLibHqConnectHqHistRecvCheckSystem(tid) == 0) {
      if (tsBuf.hqhist.invalid != 1) {
        // 一括ダウンロードは承認キーが立っていなくても許可
        return 0;
      }
    }

    log = "$callFunc : Start [$type]";
    TprLog().logAdd(tid, LogLevelDefine.normal, log);

    num = 0;
    while (true) {
      if (tsBuf.hqhist.running == 0) {
        break;
      }
      num++;
      await Future.delayed(const Duration(seconds: 1));

      if (num > TASK_REQ_WAIT) {
        log =
            "$callFunc : Request Wait Over [$type] [${tsBuf.hqhist.requestStart}]";
        TprLog().logAdd(tid, LogLevelDefine.error, log);
        break;
      }
    }

    tsBuf.hqhist.mode = 0; // 動作状態  0:正常  1:強制ストップ
    tsBuf.hqhist.hqHistEnd = 0; // 要求状態  0:開始  1:終了(定期時刻での受信モード)
    tsBuf.hqhist.requestCount = 0; // 要求受信件数  取得した件数
    tsBuf.hqhist.requestStart = type; // 別タスクからの要求  HQHIST_REQUEST_TYPの値

    return 0;
  }

  ///	機能:	NGファイルを開設時に送信するかチェック
  ///	戻値:	0: しない  1: する
  /// 関連tprxソース: AplLib_HqConnect.c - AplLib_HqConnect_Chk_NG_Resend
  static Future<int> aplLibHqConnectChkNGResend(TprTID tid) async {
    String callFunc = 'aplLibHqConnectChkNGResend';
    String log = '';
    bool ret = true;
    String tempBuf = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      log = "$callFunc : rxMemPtr error";
      TprLog().logAdd(tid, LogLevelDefine.error, log);
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    if (await AplLibHqConnect.aplLibHqConnectHqftpSendCheckSystem(tid) == 0) {
      return 0;
    }

    if (await CmCksys.cmCSSSystem() != 0) {
      // TODO:10152 履歴ログ 保留
      // (ret, tempBuf) = AplLib_IniFile(tid, INI_GET, 0, "hq_set.ini", "hq_cmn_option", "gyoumu_date_set", tempBuf);
      if (ret == false) {
        return 0;
      }

      if (int.tryParse(tempBuf) == 0) {
        // 作成日時付きファイルでなければ自動送信しない
        return 0;
      }
    }

    // TODO:10152 履歴ログ 保留
    // (ret, tempBuf) = AplLib_IniFile(tid, INI_GET, 0, "hq_set.ini", "hq_cmn_option", "open_resend", tempBuf);
    if (ret == false) {
      return 0;
    }

    if (int.tryParse(tempBuf) == 1) {
      return 1;
    }

    return 0;
  }

  ///	機能:	AplLibProcScanDirBetaで使用し, そのファイルが送信NGのバックアップファイルの場合,
  ///	ngDataにファイル名称を格納する. 1件でも取得したらチェックは終了する.
  /// 関連tprxソース: AplLib_HqConnect.c - AplLib_HqConnect_Get_NGFile
  static Future<int> aplLibHqConnectGetNGFile(
      TprTID tid, String fileName, String path, String? ngData) async {
    if (fileName.length <= 8 ||
        fileName.compareTo(".zip") == -1 ||
        fileName.compareTo("_NG") == -1 ||
        await aplLibHqConnectChkBackupName(fileName) == 0) {
      return ScanDirResult.SCAN_DIR_CONTINUE.value; // 次のファイルチェックへ
    }

    ngData = fileName;

    return ScanDirResult.SCAN_DIR_BREAK.value; // ファイルチェック終了
  }

  ///	機能:	引数のファイル名が現在の仕様と合致しているチェックする関数
  ///		再送信などで不要なファイルを送信しないための制御
  ///	引数:	fileName: チェックするファイル名称
  ///	戻値:	0: 違う  1: 仕様と合致している
  /// 関連tprxソース: AplLib_HqConnect.c - AplLib_HqConnect_Chk_BackupName
  static Future<int> aplLibHqConnectChkBackupName(String fileName) async {
    if (await CmCksys.cmNetDoASystem() != 0) {
      // netDoA
      if (fileName.compareTo(AplLib.BKUP_ADD_NAME_NETDOA_CLS) != -1 ||
          fileName.compareTo(AplLib.BKUP_ADD_NAME_NETDOA_EJ) != -1) {
        return 1;
      }
    } else if (CmCksys.cmMmType() == CmSys.MacERR) {
      if (fileName.compareTo(AplLib.BKUP_ADD_NAME_TS_LGYOUMU) != -1) {
        return 1;
      }
    } else if (await CmCksys.cmCSSSystem() != 0) {
      // CSS
      if (fileName.compareTo(AplLib.BKUP_ADD_NAME_CSS_GYOUMU) != -1) {
        return 1;
      }
    }
    return 0;
  }
}