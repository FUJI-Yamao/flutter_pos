/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../common/rx_log_calc.dart';
import '../inc/rc_mem.dart';
import 'rcitmchk.dart';
import 'rcsyschk.dart';

class RcNotePlu {
  static List<String> tmpPluCd = List.generate(16, (_) => ""); // [16]
  static int tmpInstore = 0;
  static int impWay = 0;

  /// 関連tprxソース:rcnoteplu.c - rcCheck_NotePlu
  static Future<bool> rcCheckNotePlu() async {
    AcMem cMem = SystemFunc.readAcMem();
    return((await RcSysChk.rcsyschkNotePluStlModeOnly())
        && (RcItmChk.rcCheckNoteItmRec(cMem.working.pluReg.t10003.recMthdFlg)));
  }

  /// 関連tprxソース:rcnoteplu.c - rcChkSptendNotePlu
  static bool rcChkSptendNotePlu(int sptendCnt, int fncCd, int sptendData) {
    AtSingl atSing = SystemFunc.readAtSingl();
    RegsMem mem = SystemFunc.readRegsMem();
    int cFncCd1 = atSing.notePluKind;

    if ((sptendCnt < 4) &&
        (mem.tmpbuf.notepluTtlamt == sptendData) &&
        (fncCd == cFncCd1)) {
      return true;
    }
    return false;
  }

  /// 関連tprxソース:rcnoteplu.c - rcNotePluNonPrcSalesTrans
  static void rcNotePluNonPrcSalesTrans(int fncNo, int qty) {
    int typ = RxLogCalc.rcCheckFuncAmtTyp(fncNo);
    if (typ == AmtKind.amtCash.index) {
      return;
    }

    RegsMem mem = SystemFunc.readRegsMem();
    mem.tTtllog.t100200[typ].cnt++;
    mem.tTtllog.t100200[typ].sht += qty;
  }

  /// 関連tprxソース:rcnoteplu.c - rcChk_NotePluItemDsp
  static Future<bool> rcChkNotePluItemDsp() async {
    if ((await RcSysChk.rcsyschkNotePluStlModeOnly()) ||
        (await RcSysChk.rcChkNotePluSale())) {
      return (false);
    } else {
      return (true);
    }
  }

  /// 機能：小計以上の金種商品を登録したときの確認ダイアログが出ている否かを判断
  /// 引数：void
  /// 戻値：0:出ていない  1:出ている（金種商品を値数+PLUで登録）  2:出ている（金種商品をバーコードで登録）
  /// 関連tprxソース:rcnoteplu.c - rcNotePlu_ConfDlgDspFlgChk
  static int rcNotePluConfDlgDspFlgChk() {
    return (impWay);
  }
}