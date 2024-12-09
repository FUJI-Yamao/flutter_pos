/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/apl/t_item_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_mbr_com.dart';
import 'rc_stl.dart';
import 'rcmbrpmanual.dart';

/// 小計の計算方式.
/// Bit flag "wCtrl" in StlItemCalc_Main()
/// 関連tprxソース: rcregs.h

enum StlCalc {
  normal,
  incMbrRbt,
  excCust,
  incCust,
}

/// 関連tprxソース: rcstlcal.c rcStlItemCalc_Main
class StlItemCalcMain {
  /// 合計値の計算.
  static void rcStlItemCalcMain(int wCtrl) {
    // rcStlItemCalc_Proc(wCtrl,STLCALC_EXC_CUST);
    rcStlItemCalcProc(wCtrl, RcStl.STLCALC_EXC_CUST);
  }

  static void rcStlItemCalcProc(int wCtrl1, int wCtrl2) {
    // TODO:10138 再発行、領収書対応 の為コメントアウト
    // RegsMem mem = RegsMem();
    // int sumPrice = 0;
    // for (int p = 0; p < mem.tTtllog.t100001Sts.itemlogCnt; p++) {
    //   var item = mem.tItemLog[p];
    //   if (item == null || item.itemData == null) {
    //     continue;
    //   }
    //   //   rcStlItemCalc0(p, wCtrl2, 1);
    //   {
    //     // nomi：名目上の価格.
    //     //rcNominalPriceSet
    //     item.calcData.nomiPrc = item.t10003.uusePrc * item.t10000.itemTtlQty;
    //
    //     // MEMO: 本来は小計値はこういう計算ではないが、プロトタイプ用に簡易計算.
    //     if (!item.isDeletedItem()) {
    //       sumPrice += item.calcData.nomiPrc;
    //     }
    //   }
    // }
    //
    // {
    //   // rcStlTotalAfterCalc
    //   // MEMO: 本来は小計値はこういう計算ではないが、プロトタイプ用に簡易計算.
    //   mem.tTtllog.t100001.stlTaxInAmt = sumPrice;
    // }
  }

  // TODO:10121 QUICPay、iD 202404実装対象外
  /// スタンプカード実績の再計算を行う
  /// 関連tprxソース: rcstlcal.c - rcmbr_Set_StnCardReCal
  static void rcmbrSetStnCardReCal(){}

  // TODO:10121 QUICPay、iD 202404実装対象外
  /// 税情報のセット
  /// 関連tprxソース: rcstlcal.c - rcstlcal_Rbt_Tax_Data(TPRMID tid, REGSMEM *MEM)
  static void rcstlcalRbtTaxData(TprMID tid, RegsMem mem ){}
}

class CalcMMSTMSchDBRd {
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース:C:rcstlcal.c - rcCalc_MMSTM_SchDBRd_Stop()
  static void rcCalcMMSTMSchDBRdStop(){
    return;
  }

  /// 関連tprxソース: rcstlcal.c - rcStlItemBitCheck()
  static Future<bool> rcStlItemBitCheck(int p) async {
    if (p < 0) {
      return false;
    }
    if ((await RcMbrCom.rcmbrChkStat() & RcMbr.RCMBR_STAT_POINT) > 0) {
      return((RcStl.rcChkItmRBufStlDsc(p)) || /* Subtotal Discount Record ?  */
          (RcStl.rcChkItmRBufStlPm(p)) || /* Subtotal %Discount Record ? */
          (RcStl.rcChkItmRBufCatalinaStlDsc(p)) || /* Catalina Subtotal Discount Record ?  */
          (RcStl.rcChkItmRBufCatalinaStlPm(p))|| /* Catalina Subtotal %Discount Record ? */
          (RcStl.rcChkItmRBufBarStlDsc(p)) ||
          (RcStl.rcChkItmRBufBarStlPm(p)) ||
          (RcMbrpManual.rcmbrChkItmRBufRbt(p)));  /* Subtotal Rbt Discount Record */
    } else {
      return((RcStl.rcChkItmRBufStlDsc(p)) ||  /* Subtotal Discount Record ?  */
          (RcStl.rcChkItmRBufCatalinaStlDsc(p)) || /* Catalina Subtotal Discount Record ?  */
          (RcStl.rcChkItmRBufCatalinaStlPm(p)) || /* Catalina Subtotal %Discount Record ? */
          (RcStl.rcChkItmRBufBarStlDsc(p)) ||
          (RcStl.rcChkItmRBufBarStlPm(p)) ||
          (RcStl.rcChkItmRBufStlPm(p)));  /* Subtotal %Discount Record ? */
    }
  }

  /// 関連tprxソース: rcstlcal.c - rcManualStampCodeCheck()
  static bool rcManualStampCodeCheck(int p) {
    RegsMem mem = RegsMem();
    if (p < 0) {
      return false;
    }
    return (mem.tItemLog[p].t10003.recMthdFlg == REC_MTHD_FLG_LIST.STAMP_REC.typeCd);    /* STAMP ?  */
  }

  /// 関連tprxソース: rcstlcal.c - rcWeightItemCheck()
  static bool rcWeightItemCheck(int p) {
    RegsMem mem = SystemFunc.readRegsMem();
    if (p < 0) {
      return false;
    }
    return ( (mem.tItemLog[p].t10003.itemKind == 1)
            || (mem.tItemLog[p].t10003.itemKind == RcRegs.ITEM_KIND_WEIGHT_ITEM2) );
  }

  /// 関連tprxソース: rcstlcal.c - rcDecimalItemCheck()
  static bool rcDecimalItemCheck(int p) {
    RegsMem mem = SystemFunc.readRegsMem();
    if (p < 0) {
      return false;
    }
    return (mem.tItemLog[p].t10001Sts.decPntItem != 0);
  }

  /// 関連tprxソース: rcstlcal.c - rcVolumeItemCheck()
  static bool rcVolumeItemCheck(int p) {
    RegsMem mem = SystemFunc.readRegsMem();
    if (p < 0) {
      return false;
    }
    return (mem.tItemLog[p].t10003.itemKind != RcRegs.ITEM_KIND_VOLUME);
  }

  /// 関連tprxソース: rcstlcal.c - rcStlPlusItemBitCheck()
  static bool rcStlPlusItemBitCheck(int p) {
    return (RcStl.rcChkItmRBufStlPlus(p));     /* Subtotal Plus Record ?  */
  }
}

///	関連tprxソース: rcstlcal.c
class RcStlCal {
  /// ロイヤリティ無効フラグ
  static int loyUnvldFlg = 0;
  /// ロイヤリティ読込フラグ
  static int loyUnvldChk = 0;

  // TODO:00002 佐野 checker関数実装のため、定義のみ追加
  /// c_ttllog, c_itemlogからc_ttl3_log, c_item3_logのデータを作成する.
  ///	関連tprxソース: rcstlcal.c - rcstlcal_Set_ttl3_Data()
  static void	rcstlcalSetTtl3Data(TprMID tid) {}

  /// Subtotal calculation clear data
  ///	関連tprxソース: rcstlcal.c - rcStlInitilaizeBuf()
  static void rcStlInitilaizeBuf() {
    RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_STL); /* Total Receipt Buffer */
    // TODO:00013 三浦 後回し
    // rcstlcal_OT_Clear();
    rcStlInitilaizeSTLLCDITEM();
  }

  ///	関連tprxソース: rcstlcal.c - rcStlInitilaizeSTLLCDITEM()
  static void rcStlInitilaizeSTLLCDITEM() {
    int p = 0;
    AtSingl atSingl = SystemFunc.readAtSingl();
    // TODO:00013 三浦 後回し
    // atSingl.tStlLcdItem.PageMax = 1;
    // atSingl.tStlsubLcdItem.PageMax = 1;
    // atSingl.tStlLcdItem.ItemMax = 0;
    // atSingl.tStlsubLcdItem.ItemMax = 0;

    // TODO:00013 三浦 後回し
    // for (p = 0; p < ITEM_MAX; p++) {
    //   atSingl.tStlLcdItem.aiI[p] = -1;
    //   atSingl.tStlsubLcdItem.aiI[p] = -1;
    // }

    atSingl.colorfipitemsCtrl = 0;
  }

  /// ロイヤリティ無効フラグのチェック
  /// 戻り値: ロイヤリティ無効フラグの値
  ///	関連tprxソース: rcstlcal.c - rcstlcal_LoyUnvldFlg_Chk()
  static int rcStlCalLoyUnvldFlgChk() {
    return loyUnvldFlg;
  }

  /// ロイヤリティ無効チェック状態にする
  /// 引数: 1=会員読込 / 2=プロモーションバーコード読込 / 3=商品読込
  ///	関連tprxソース: rcstlcal.c - rcstlcal_LoyUnvldChk_On()
  static void rcstlcalLoyUnvldChkOn(int flg) {
    loyUnvldChk = flg;
    loyUnvldFlg = 0;
  }

  /// ロイヤリティ無効チェック状態を解除する
  ///	関連tprxソース: rcstlcal.c - rcstlcal_LoyUnvldChk_Off()
  static void rcstlcalLoyUnvldChkOff() {
    loyUnvldChk = 0;
  }

  /// タワータイプ1人制キャッシャー機の表示中アイテムをクリアする
  ///	関連tprxソース: rcstlcal.c - DualT_Single_Itmrbp_Clea()
  static void dualTSingleItmrbpClear() {
    RegsMem mem = SystemFunc.readRegsMem();
    if (mem.tTtllog.t100001Sts.itemlogCnt == 0) {
      mem.tItemLog = List.generate(CntList.itemMax, (_) => TItemLog());
      rcStlInitilaizeSTLLCDITEM();
    }
  }

  ///	関連tprxソース: rcstlcal.c - rcStlItemCalc_Main()
  /// TODO:00010 長田 定義のみ追加
  static void rcStlItemCalcMain(int wCtrl) {
    return ;
  }

  // 実装は必要だがARKS対応では除外
  ///	関連tprxソース: rcstlcal.c - rcChk_Assort_StmItm
  static Future<bool> rcChkAssortStmItm(int p) async {
    bool ret = false;

    if (await RcSysChk.rcChkAssortSystem() && (p >= 0)) {
      RegsMem mem = SystemFunc.readRegsMem();
      if ((mem.tmpbuf.assort[p].flg != 0) &&
          (mem.tItemLog[p].t10900Sts.stmTyp == 5)) {
        ret = true;
      }
    }

    return (ret);
  }
}
