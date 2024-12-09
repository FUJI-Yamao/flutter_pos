/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../common/cls_conf/mac_infoJsonFile.dart';
import '../common/cls_conf/sysJsonFile.dart';
import '../common/cmn_sysfunc.dart';
import '../inc/apl/compflag.dart';
import '../inc/apl/rxmem_define.dart';
import '../lib/apllib/cmd_func.dart';

/// 関連tprxソース: TprLibLog.c
class TprLibLog {
  static const PROC_LOG_MAX = 100;

  static List<TLog> logInf = List.generate(PROC_LOG_MAX, (_) => TLog());
  static int threadPid = -1;
  static int threadEnd = 0;
  static int writePosi = 0;
  static int readPosi = 0;
  static int tprLibLogMax = (4 * 1024);
  static int tprLibLogLv = 1;
  static String sysHomeDisp = "";  // projects home directory

  /// ログパラメタを設定ファイルの値に戻す
  /// 関連tprxソース: TprLibLog.c - TprLibLogInit
  static void tprLibLogInit() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    SysJsonFile sysInfo = pCom.iniSys;
    Mac_infoJsonFile macInfo = pCom.iniMacInfo;

    if (macInfo.logging.UnlimitSize == "yes") {
      tprLibLogMax = -1;
    }
    else {
      if (sysInfo.logging.maxsize != 0) {
        tprLibLogMax = sysInfo.logging.maxsize;
      }
    }
    if (sysInfo.logging.level != 0) {
      tprLibLogLv = sysInfo.logging.level;
    }
    if (CompileFlag.LOG_THREAD) {
      tprLibLogStart();
    }
  }

  /// ログパラメタを設定ファイルの値に戻す
  /// 関連tprxソース: TprLibLog.c - TprLibLogStart
  static void tprLibLogStart() {
    if (CompileFlag.CENTOS) {
      if (threadPid == CmdFunc().getPid()) {
        return;
      }
    }
    else {
      if (threadPid != -1) {
        return;
      }
    }
    //pthread_mutex_init(&mutex, NULL);
    threadPid = CmdFunc().getPid();
    logInf = List.generate(PROC_LOG_MAX, (_) => TLog());
    threadEnd = 0;
    writePosi = 0;
    readPosi = 0;
    // TODO:00002 佐野 - スレッド処理
    //pthread_create(&p_thread, NULL, logwrite, (void *)getpid());
  }
}

/// 関連tprxソース: TprLibLog.c - t_Log
class TLog {
  int typ = 0;  /* 0=LogWrite  1=RS232C_LOG */
  String fName = "";
  String log = "";
}