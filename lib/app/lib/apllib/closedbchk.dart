/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:io';

import 'package:sprintf/sprintf.dart';

import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_log.dart';

/// 関連tprxソース: closedbchk.c
class CloseDbChk {
  static const CLOSEDBANS_FILE = "CloseDBAns.txt";

  /// 関連tprxソース: closedbchk.c - rmStoreCloseDBAnsChk
  static int rmStoreCloseDBAnsChk() {
    File fp;
    String fnm = '';
    String cAns = '';
    RandomAccessFile rFile;
    // 共有メモリの取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf pCom = xRet.object;

    makeDBAnsFileName();

    if (pCom.dbTrm.dispErrScheduleRead != 0) {
      fp = TprxPlatform.getFile(fnm);
      try {
        rFile = fp.openSync(mode: FileMode.read);
        cAns = utf8.decode(fp.readAsBytesSync());
        rFile.closeSync();
      } catch (e) {
        TprLog().logAdd(
            0, LogLevelDefine.normal, "rmStoreCloseAnsChk: file read error");
      }
    }
    return int.tryParse(cAns) ?? 0;
  }

  /// 関連tprxソース: closedbchk.c - MakeDBAnsFileName
  static String makeDBAnsFileName() {
    return sprintf(
        "%s/tmp/%s", [EnvironmentData().sysHomeDir, CLOSEDBANS_FILE]);
  }
}
