/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter_pos/app/common/environment.dart';
import 'package:flutter_pos/app/inc/lib/apllib.dart';
import 'package:flutter_pos/app/lib/apllib/apllib_strutf.dart';
import 'package:flutter_pos/app/lib/apllib/mm_reptlib.dart';
import 'package:flutter_pos/app/lib/cm_ej/cm_ejlib.dart';
import 'package:sprintf/sprintf.dart';

import '../../../inc/sys/tpr_log.dart';

/// 関連tprxソース: fcl_setup_sub.c
class FclSetupSub {

  /// 関連tprxソース: fcl_setup_sub.c - fcls_ejtxt_make
  static Future<void> fclsEjTxtMake(String ejLine, int type) async {
    String txtPath = '';
    String ejBuf = '';
    String ejTemp = sprintf("%s", [ejLine]);
    int rtn = 0;
    int size = 0;
    EucAdj adj = EucAdj();

    txtPath = sprintf("%s/%s%s", [
      EnvironmentData().sysHomeDir,
      CmEj.EJ_WORK_DIR,
      CmEj.EJ_WORK_FILE]);
    File fp = File(txtPath);
    
    try {
      var sink = fp.openWrite(mode: FileMode.append);
      if (type == 1) {
        ejBuf = List.filled(54, '-').join();
        sink.writeln(ejBuf);

        ejBuf = List.filled(54, ' ').join();
        sink.writeln(ejBuf);

        sink.close();

        rtn = await EjLib().cmEjOther();
        if (rtn == 0) {
          MmReptlib.countUp();
          TprLog().logAdd(Tpraid.TPRAID_FCLSETUP, LogLevelDefine.normal,
              "fcls_ejtxt_make end");
        }
        else {
          TprLog().logAdd(Tpraid.TPRAID_FCLSETUP, LogLevelDefine.error,
              "fcls_ejtxt_make failed !!!");
        }
        return;
      }

      (adj, ejTemp) = AplLibStrUtf.aplLibEucAdjust(ejTemp, ejTemp.length, 54);
      if (adj.count < 54) {
        (size, ejBuf) = AplLibStrUtf.aplLibEucCopy(ejTemp, 54);
        (adj, ejBuf) = AplLibStrUtf.aplLibEucAdjust(ejBuf, size, 54);
        ejBuf += '\n';
      }
      else {
        (size, ejBuf) = AplLibStrUtf.aplLibEucCopy(ejLine, 54);
        ejBuf += '\n';
        ejBuf += '0';
      }
      sink.writeln(ejBuf);
      sink.close();
      return;
    }
    on FileSystemException {
      TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
          "fcls_ejtxt_make: file error");
      return;
    }
    catch(e) {
      TprLog().logAdd(Tpraid.TPRAID_FCLSETUP, LogLevelDefine.error,
          "fcls_ejtxt_make failed !!!");
      return;
    }
  }
}