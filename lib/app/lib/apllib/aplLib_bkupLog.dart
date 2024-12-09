/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_log_define.dart';
import '../../inc/sys/tpr_type.dart';

///　関連tprxソース: AplLib_BkupLog.c
class AplLibBkupLog {

  /// 機能 : 免税電子化で送信エラーの圧縮ファイルを作成
  ///　関連tprxソース: AplLib_BkupLog.c - AplLib_BkupLog_TaxFree_MakeZip
  static int aplLibBkupLogTaxFreeMakeZip(TprMID tid, String zipName, String target, String password) {

  List<String> param;
    if (password.isEmpty) {
      param = ['-qr', zipName, target];
    } else {
      param = ['-qr', '-p', password, zipName, target];
    }

    TprLog().logAdd(
          tid, LogLevelDefine.normal, 'cmd: zip ${param.join(' ')}');

    try {
      Process.runSync('zip', param);

      TprLog().logAdd(
          tid, LogLevelDefine.normal, 'aplLibBkupLogTaxFreeMakeZip : file is zip compress\n');

      return 0;
    } catch (e) {
      TprLog().logAdd(
          tid, LogLevelDefine.error, 'aplLibBkupLogTaxFreeMakeZip : file is not zip compress\n');
      return 1;
    }
  }

}