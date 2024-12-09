/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter_pos/app/common/environment.dart';
import 'package:flutter_pos/app/inc/sys/tpr_log.dart';
import 'package:sprintf/sprintf.dart';

import '../../inc/lib/apllib.dart';
import '../../inc/sys/tpr_type.dart';

///関連tprxソース: file_cpy.c
class FileCpy {
  static const UT_LOG_DIR = "log/tmn";

  ///関連tprxソース: file_cpy.c - rxUT_FileWrite
  static int rxUTFileWrite(TprTID tid, String data, int tranType, int kind) {
    String filename = '';
    String filepath = '';
    String erlog = '';

    switch (tranType) {
      case 0:
        filename = kind == 1 ? "ng_Re_QP.txt":"Re_QP.txt";
        break;
      case 1:
        filename = kind == 1 ? "ng_Re_iD.txt":"Re_iD.txt";
        break;
      default:
        erlog = "rxUTFileWrite : tran_type error !!\n";
        TprLog().logAdd(tid, LogLevelDefine.error, erlog);
        return AplLib.RXFILE_NG;
    }
    filepath = sprintf("%s/%s/%s", [
      EnvironmentData().sysHomeDir,
      UT_LOG_DIR,
      filename
    ]);

    try {
      final file = File(filepath);
      final sink = file.openWrite(mode: FileMode.append);
      sink.write(data);
      sink.close;

      erlog = "rxUTFileWrite : OK !!\n";
      TprLog().logAdd(tid, LogLevelDefine.normal, erlog);
      return AplLib.RXFILE_OK;
    }
    catch (e) {
      erlog = "rxUTFileWrite : file.openWrite error !!\n";
      TprLog().logAdd(tid, LogLevelDefine.error, erlog);
      return AplLib.RXFILE_NG;
    }
  }
}