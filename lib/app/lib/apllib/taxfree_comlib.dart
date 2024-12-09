/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter_pos/app/common/environment.dart';
import 'package:intl/intl.dart';

import 'package:sprintf/sprintf.dart';

import '../../common/cls_conf/taxfreeJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';

class TaxfreeComlibFileName{
  late String name;
}

class TaxfreeComlib {
  // TODO:00011 周 checker関数実装のため、定義のみ追加
  static int TaxfreeCommStatChk(int tid) {
    return 0;
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  static int TaxfreeCommStatChk2(int tid, int stat) {
    return 0;
  }
  /// 関連tprxソース: taxfree_comlib.c - TaxFree_Read_Rest
  /// ファイル数を取得
  /// 引数: int typ  取得タイプ  GETTYPE_NOTSEND:未送信ファイル(/pj/tprx/tmp/taxfree)　
  ///		                      GETTYPE_ERR:送信異常ファイル(/pj/tprx/tmp/taxfree/err)
  ///      int srv  接続サーバータイプ 0：商用　1：デモ
  static Future<int> taxFreeReadRest(int tid, int typ, int svr) async {
    String log = '';
    String path = '';
    String name = '';
    String head = '';
    String rhead = '';
    int len = 0;
    int rlen = 0;
    int cnt = 0;

    if (typ == 0) {
      path =
          sprintf("%s%s", [EnvironmentData().sysHomeDir, AplLib.TAXFREE_DIR]);
    }
    else {
      path = sprintf(
          "%s%s", [EnvironmentData().sysHomeDir, AplLib.TAXFREE_ERR_DIR]);
    }

    var dir = Directory(path);
    if (!await dir.exists()) {
      log = sprintf("taxFreeReadRest:[%s]error", [path]);
      TprLog().logAdd(tid, LogLevelDefine.error, log);
      return 0;
    }

    if (svr == 1) {
      // デモサーバー接続
      head = AplLib.TAXFREE_SND_HEADER_DEMO;
      rhead = AplLib.TAXFREE_RIREKI_HEADER_DEMO;
    }
    else {
      head = AplLib.TAXFREE_SND_HEADER;
      rhead = AplLib.TAXFREE_RIREKI_HEADER;
    }

    await for (var ent in dir.list()) {
      name = ent.path
          .split('/')
          .last;
      if (name.startsWith(head)) {
        if (name.startsWith(head + AplLib.TAXFREE_REREKI_CNCL)) {
          cnt++;
        }
        else if (typ == AplLib.GETTYPE_NOTSEND //未送信件数はtaxfree_*ファイル件数をチェック
            && name.startsWith(head + AplLib.TAXFREE_REREKI_REGS)) {
          cnt ++;
        }
      }
      //エラー件数の場合は、taxfree_*作成されない事があるため、Rireki_**ファイル件数をチェック
      else if (typ == AplLib.GETTYPE_ERR
          && name.startsWith(rhead + AplLib.TAXFREE_REREKI_REGS)) {
        cnt++;
      }
    }
    return cnt;
  }

  /// 機能：免税バックアップファイル名取得
  /// 引数：zip_name ファイル名
  ///      file_typ	0：閉設バックアップ　1：メンテエラーファイルバックアップ
  /// 関連tprxソース: taxfree_comlib.c - taxfree_bkup_zip_name
  static int taxfreeBkupZipName(int tid, TaxfreeComlibFileName zipName,int fileTyp) {

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error, "taxfreeBkupZipName rxMemRead error");
      return DlgConfirmMsgKind.MSG_MEMORYERR.dlgId;
    }

    // TPRX_HOME/taxfree.iniのカテゴリーterm_infoのterm_codeを取得
    TaxfreeJsonFile taxJson = TaxfreeJsonFile();
    var teamCode = taxJson.term_info.term_code;
    if (teamCode.isEmpty) {
      if (fileTyp == 0) {
        //ログバックアップの場合デモ設定を取得
        teamCode = taxJson.term_info_demo.term_code;
      }
      if (teamCode.isEmpty) {
        TprLog().logAdd(tid, LogLevelDefine.error, "taxfreeBkupZipName term_code error");
        return DlgConfirmMsgKind.MSG_TAXFREE_CHK.dlgId;
      }
      TprLog().logAdd(tid, LogLevelDefine.normal, "taxfreeBkupZipName:term_code_demo[$teamCode]");
    }

    String head;
    if (fileTyp == 1) {
      head = AplLib.TAXFREE_BKUP_ERR_FILE_H;
    } else {
      head = AplLib.TAXFREE_BKUP_FILE_H;
    }

    String date = DateFormat('yyyyMMddHHmm').format(DateTime.now());


    zipName.name = sprintf(
        "%s%s_%06ld_%s.zip",
        [head, teamCode, cBuf.iniMacInfo.mac_no, date]);

    TprLog().logAdd(tid, LogLevelDefine.normal, "taxfreeBkupZipName:file[$zipName]");

    return 0;
  }
}