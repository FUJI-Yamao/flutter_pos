/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:io';

import 'package:sprintf/sprintf.dart';

import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../inc/apl/counter.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../lib/apllib/apllib_strutf.dart';
import '../../lib/apllib/chkopen.dart';
import '../../lib/cm_ary/cm_ary.dart';
import '../apllib/competition_ini.dart';

/// EJヘッダファイル書式設定（位置）
/// 関連tprxソース:cm_ej.h - write_position
enum writePosi {
  EJ_LEFT,
  EJ_CENTER,
  EJ_RIGHT,
  EJ_DIRECTLY
}

/// EJヘッダファイルパラメタ
/// 関連tprxソース:cm_ej.h
class CmEj {
  static const EJ_WORK_DIR = "tmp/";
  static const EJ_WORK_FILE = "ejdata.txt";
  static const EJ_WORK_FILE2 = "ejdata2.txt";
  static const EJ_LINE_SIZE = 54;
  static const EJ_PSENSOR_FILE = "psensor_ej.txt";
}

/// EJ関連
/// 関連tprxソース:ejlib.c, ejother.c
class EjLib {
  static const SEND_UPD_RETRY = 20;
  static const SEND_UPD_DELAY = 500000;
  static const RES_WAIT_CNT = 100;
  static const RES_WAIT_TIME = 200000;

  /// 書き込み位置を指定し、EJデータをファイルに書き込む
  /// 関連tprxソース:ejlib.c - cm_ej_write_string()
  /// 引数:[writeFile] 電子ジャーナル用テキストファイル
  /// 引数:[position] 書き込み位置
  /// 引数:[ejData] 書き込む文字列
  /// 戻り値:なし
  void cmEjWriteString(File writeFile, int position, String ejData) {
    final (EucAdj adj, String data)  = AplLibStrUtf.aplLibEucAdjust(
        ejData, (CmEj.EJ_LINE_SIZE * 4)+1+1+1, CmEj.EJ_LINE_SIZE);
    ejData = data;
    int posi = 0;
    String outBuf = '';

    posi = CmEj.EJ_LINE_SIZE - adj.count;
    if (posi < 0) {
      posi = 0;
    }

    if (  (position ==  writePosi.EJ_RIGHT.index)
    ) {
      // そのまま
    } else if (position ==  writePosi.EJ_CENTER.index) {
      posi = posi ~/ 2;
    }else{
      posi = 0;
    }

    if (posi > 0) {
      for (int i = 0; i < posi; i++) {
        outBuf += ' ';
      }
      outBuf += '$ejData\n';
    } else {
      outBuf = '$ejData\n';
    }


    writeFile.writeAsStringSync(outBuf, mode: FileMode.append, encoding: utf8, flush: false);
  }

  /// ２つの文字列を、EJデータをファイルに書き込む（左側・右側の指定あり）
  /// 関連tprxソース:ejlib.c - cm_ej_write_string_lr()
  /// 引数:[writeFile] 電子ジャーナル用テキストファイル
  /// 引数:[left] 書き込む文字列（左側）
  /// 引数:[right] 書き込む文字列（右側）
  /// 戻り値:true = Normal End
  ///       false = Error
  bool cmEjWriteStringLr(File writeFile, String left, String right) {
    EucAdj adj = EucAdj();
    int kanaCntL = 0;
    int kanaCntR = 0;
    String outBuf = '';

    if (left.isEmpty || right.isEmpty) {
      return false;
    }
    if (left.isNotEmpty) {
      adj = (AplLibStrUtf.aplLibEucAdjust(left, left.length, CmEj.EJ_LINE_SIZE)).$1;
      kanaCntL = adj.count;
    }
    if (right.isNotEmpty) {
      adj = (AplLibStrUtf.aplLibEucAdjust(right, right.length, CmEj.EJ_LINE_SIZE)).$1;
      kanaCntR = adj.count;
    }

    if ((kanaCntL + kanaCntR) >= CmEj.EJ_LINE_SIZE) {
      outBuf = '$left\n';
      kanaCntR = CmEj.EJ_LINE_SIZE - kanaCntR;
      if (kanaCntR > 0) {
        outBuf += '${' '.padLeft(kanaCntR)}$right\n';
      } else {
        outBuf += '$right\n';
      }
    } else {
      kanaCntR = CmEj.EJ_LINE_SIZE - (kanaCntL + kanaCntR);
      outBuf += '$left${' '.padLeft(kanaCntR)}$right\n';
    }
    writeFile.writeAsStringSync(outBuf, mode:FileMode.append, encoding: utf8, flush: false);

    return true;
  }

  /// EJファイルを作成する
  /// 関連tprxソース:ejother.c - cm_ejother()
  /// 引数:なし
  /// 戻り値:ローカル実績上げステータスのエラーコード
  Future<int> cmEjOther() async {
    return await cmEjOtherDt(null);
  }

  /// アップデートディレクトリにEJファイルを作成する
  /// 関連tprxソース:ejother.c - cm_ejother_dt()
  /// 引数:ポインタ変数（タイマーを設定する）
  /// 戻り値:ローカル実績上げステータスのエラーコード
  Future<int> cmEjOtherDt(void pDt) async {
    int res = 0;

    if (!(await ChkOpen().chkOpen(0, null))) {
      TprLog().logAdd(0, LogLevelDefine.normal, 'cm_ejother() store close');
      return 0;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "cm_ejother() rxMemRead error\n");
      return DlgConfirmMsgKind.MSG_SYSERR.dlgId;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    // TODO:10096 デバドラ連携 プリンタ（rxmem.c - STAT_print_get()）

    // TODO:10070 タイマータスク（UpdUtil.c - Upd_CreateOther()）

    return res;
  }

  /// EJファイルを削除する
  /// 関連tprxソース:ejother.c - cm_ejremove()
  static Future<void> cmEjRemove() async {
    File ejFile = File("${EnvironmentData().sysHomeDir}/${CmEj.EJ_WORK_DIR}${CmEj
        .EJ_WORK_FILE}");
    if (ejFile.existsSync()) {
      await ejFile.delete();
    }
  }

  /// 関連tprxソース:ejother.c - cm_ej_countup()
  Future<void> cmEjCountup() async {
    int printNo = await Counter.competitionGetPrintNo(Tpraid.TPRAID_SYSTEM);

    printNo += 1;
    if (printNo > 9999) {
      printNo = 1;
    }

    // competition_ini( TPRAID_SYSTEM, COMPETITION_INI_PRINT_NO, COMPETITION_INI_SETMEM, &print_no, sizeof(print_no) );
    // competition_ini( TPRAID_SYSTEM, COMPETITION_INI_PRINT_NO, COMPETITION_INI_SETSYS, &print_no, sizeof(print_no) );
    await CompetitionIni.competitionIniSetPrintNo(Tpraid.TPRAID_STR, printNo);

    return;
  }
}
