/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/environment.dart';
import '../../inc/lib/cm_getpath.dart';

const String DNAME_SANRIKU_SHOP = "sanriku/";
const String FNAME_DRWCHK_CASH_LOG = "drawchk_cash_log";

/// 関連tprxソース: cm_getpath.c
class CmGetpath {

  static String sysHomeDirp = EnvironmentData().sysHomeDir;

  /// /pj/tprx/tran_backup
  /// 関連tprxソース: cm_getpath.c   cm_getdir_Tran_Backup()
  static String cmGetdirTranBackup() {
    // TPRX_HOME/tran_backup
    return "$sysHomeDirp/${CmGetPathDefine.DNAME_TRAN_BACKUP}";
  }

  /// /home/web2100/CustomMade/
  /// 関連tprxソース: cm_getpath.c   cm_getdir_CustomMade()
  static String cmGetdirCustomMade() {
    return CmGetPathDefine.DNAME_CUSTOMMADE;
  }

  /// /home/web2100/CustomMade/sanriku/
  /// 関連tprxソース: cm_getpath.c   cm_getdir_SanrikuSend()
  static String cmGetdirSanrikuSend() {
    return CmGetPathDefine.DNAME_CUSTOMMADE + CmGetPathDefine.DNAME_SANRIKU_SHOP;
  }

  /// drawchk_cash_log00YYYYMMDD.NNNNNN
  /// 関連tprxソース: cm_getpath.c   cm_getfile_SanrikuLog()
  static String cmGetfileSanrikuLog(String saleDate, int macNo) {
    String macNoStr = macNo.toString().padLeft(6,"0");
    return "${CmGetPathDefine.FNAME_DRWCHK_CASH_LOG}00${saleDate}.${macNoStr}";
  }

  /// /pj/tprx/tmp/drawchk_cash_logCCCCCCYYYYMMDD.txt
  /// 関連tprxソース: cm_getpath.c   cm_getpath_SanrikuSummaryLog()
  static String cmGetpathSanrikuSummaryLog(int storeCode, String saleDate) {
    String dir = cmGetdirPJTmp();
    String scStr = storeCode.toString().padLeft(6,"0");
    return "${dir}${CmGetPathDefine.FNAME_DRWCHK_CASH_LOG}${scStr}${saleDate}.txt";
  }

  /// /pj/tprx/tmp/
  /// 関連tprxソース: cm_getpath.c   cm_getdir_PJ_Tmp()
  static String cmGetdirPJTmp() {
    return "$sysHomeDirp/${CmGetPathDefine.DNAME_PJ_TMP}";
  }

}
