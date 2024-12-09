/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/inc/apl/fnc_code.dart';
import 'package:flutter_pos/app/inc/apl/rx_cnt_list.dart';

import '../../inc/apl/rxregmem_define.dart';

class RxLogCalc {

  ///関連tprxソース: rxlogcalc.c - rxCalc_Stl_Tax_Amt
  static int rxCalcStlTaxAmt(RegsMem regsmem) {
    return regsmem.tTtllog.calcData.stlTaxAmt;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース: rxlogcalc.c - rxCalc_Suica_Amt
  static int rxCalcSuicaAmt(RegsMem regsmem) {
    return 0;
  }

  /// 税込み小計金額(おまけ除く)を返す
  /// 関連tprxソース: rxlogcalc.c - rxCalc_Stl_Tax_Out_Amt(REGSMEM *regsmem)
  static int rxCalcStlTaxOutAmt(RegsMem regsmem){
    return (RegsMem().tTtllog.calcData.stlTaxOutAmt);
  }

  /// 税込み小計金額(おまけ含む)を返す
  /// 関連tprxソース: rxlogcalc.c - rxCalc_Stl_Tax_In_Amt(REGSMEM *regsmem)
  static int rxCalcStlTaxInAmt(RegsMem regsmem){
    return (RegsMem().tTtllog.t100001.stlTaxInAmt);
  }

  ///	外税額の合計値(すべての外税コード)を返す
  /// 関連tprxソース: rxlogcalc.c - rxCalc_Ex_Tax_Amt(REGSMEM *regsmem)
  static int rxCalcExTaxAmt(RegsMem regsmem) {
    int ret = 0;

    for (int i = 0; i < CntList.taxMax; i++) {
      if (regsmem.tTtllog.t100300[i].taxTyp == 0) {
        ret += regsmem.tTtllog.t100300[i].taxAmt;
      }
    }
    return ret;
  }
  /// 内税額の合計値(すべての内税コード)を返す
  /// 関連tprxソース: rxlogcalc.c - rxCalc_In_Tax_Amt(REGSMEM *regsmem)
  static int rxCalcInTaxAmt(RegsMem regsmem) {
    int ret = 0;

    for (int i = 0; i < CntList.taxMax; i++) {
      if (regsmem.tTtllog.t100300[i].taxTyp == 1) {
        ret += regsmem.tTtllog.t100300[i].taxAmt;
      }
    }
    return ret;
  }

  /// 関連tprxソース: rxlogcalc.c - rxCalc_Suica_Tran(REGSMEM *regsmem)
  int rxCalcSuicaTran(RegsMem regsmem) {
    //SUICA取引のsptend_cnt 但しSuica取引でないときも0を返すので注意
    return (rxCalcSuicaTranChk(regsmem, 0));
  }

  /// 関連tprxソース: rxlogcalc.c - rxCalc_Suica_Tran_Chk(REGSMEM *regsmem)
  static int rxCalcSuicaTranChk(RegsMem regsmem, int flg) {
    int i;

    for (i = 0; i < CntList.sptendMax; i++) {
      if ((regsmem.tTtllog.t100100[i].trafficCardNo).isNotEmpty) {
        //SUICA取引のsptend_cnt
        return (i);
      }
    }
    return (flg);
  }

  ///関数：rcCheck_Func_AmtTyp(void)
  ///機能：ファンクションキーより売上／在高実績の配列位置を返す
  ///引数：なし
  ///戻値：結果
  /// 関連tprxソース: rxlogcalc.c - rcCheck_Func_AmtTyp(short fnc_code)
  static int rcCheckFuncAmtTyp(int fncCode) {
    int typ = -1;

    switch(FuncKey.getKeyDefine(fncCode)) {
      case FuncKey.KY_CASH:  typ = AmtKind.amtCash.index;
        break;
      case FuncKey.KY_CHA1:  typ = AmtKind.amtCha1.index;
        break;
      case FuncKey.KY_CHA2:  typ = AmtKind.amtCha2.index;
        break;
      case FuncKey.KY_CHA3:  typ = AmtKind.amtCha3.index;
        break;
      case FuncKey.KY_CHA4:  typ = AmtKind.amtCha4.index;
        break;
      case FuncKey.KY_CHA5:  typ = AmtKind.amtCha5.index;
        break;
      case FuncKey.KY_CHA6:  typ = AmtKind.amtCha6.index;
        break;
      case FuncKey.KY_CHA7:  typ = AmtKind.amtCha7.index;
        break;
      case FuncKey.KY_CHA8:  typ = AmtKind.amtCha8.index;
        break;
      case FuncKey.KY_CHA9:  typ = AmtKind.amtCha9.index;
        break;
      case FuncKey.KY_CHA10: typ = AmtKind.amtCha10.index;
        break;
      case FuncKey.KY_CHA11: typ = AmtKind.amtCha11.index;
        break;
      case FuncKey.KY_CHA12: typ = AmtKind.amtCha12.index;
        break;
      case FuncKey.KY_CHA13: typ = AmtKind.amtCha13.index;
        break;
      case FuncKey.KY_CHA14: typ = AmtKind.amtCha14.index;
        break;
      case FuncKey.KY_CHA15: typ = AmtKind.amtCha15.index;
        break;
      case FuncKey.KY_CHA16: typ = AmtKind.amtCha16.index;
        break;
      case FuncKey.KY_CHA17: typ = AmtKind.amtCha17.index;
        break;
      case FuncKey.KY_CHA18: typ = AmtKind.amtCha18.index;
        break;
      case FuncKey.KY_CHA19: typ = AmtKind.amtCha19.index;
        break;
      case FuncKey.KY_CHA20: typ = AmtKind.amtCha20.index;
        break;
      case FuncKey.KY_CHA21: typ = AmtKind.amtCha21.index;
        break;
      case FuncKey.KY_CHA22: typ = AmtKind.amtCha22.index;
        break;
      case FuncKey.KY_CHA23: typ = AmtKind.amtCha23.index;
        break;
      case FuncKey.KY_CHA24: typ = AmtKind.amtCha24.index;
        break;
      case FuncKey.KY_CHA25: typ = AmtKind.amtCha25.index;
        break;
      case FuncKey.KY_CHA26: typ = AmtKind.amtCha26.index;
        break;
      case FuncKey.KY_CHA27: typ = AmtKind.amtCha27.index;
        break;
      case FuncKey.KY_CHA28: typ = AmtKind.amtCha28.index;
        break;
      case FuncKey.KY_CHA29: typ = AmtKind.amtCha29.index;
        break;
      case FuncKey.KY_CHA30: typ = AmtKind.amtCha30.index;
        break;
      case FuncKey.KY_CHK1: typ = AmtKind.amtChk1.index;
        break;
      case FuncKey.KY_CHK2: typ = AmtKind.amtChk2.index;
        break;
      case FuncKey.KY_CHK3: typ = AmtKind.amtChk3.index;
        break;
      case FuncKey.KY_CHK4: typ = AmtKind.amtChk4.index;
        break;
      case FuncKey.KY_CHK5: typ = AmtKind.amtChk5.index;
        break;
      default: typ = AmtKind.amtCash.index;
        break;
    }
    return typ;
  }

  /// 手動小計値引の合計値を返す(dsc)
  /// 関連tprxソース: rxlogcalc.c - rxCalc_StlDsc_AllAmt()
  static int rxCalcStlDscAllAmt(RegsMem regsmem) {
    int ret = 0;

    for (int i = 0; i < regsmem.tTtllog.t100001Sts.itemlogCnt; i++) {
      FuncKey define =
          FuncKey.getKeyDefine(regsmem.tItemLog[i].t50100.stldscCd);
      switch (define) {
        case FuncKey.KY_DSC1:
        case FuncKey.KY_DSC2:
        case FuncKey.KY_DSC3:
        case FuncKey.KY_DSC4:
        case FuncKey.KY_DSC5:
          if ((regsmem.tItemLog[i].t50100Sts!.nonEffectFlg == 0) &&
              (regsmem.tItemLog[i].t10002.scrvoidFlg)) {
            ret += regsmem.tItemLog[i].t50100.stldscAmt;
          }
          break;
        default:
          ret += 0;
          break;
      }
    }
    return ret;
  }

  /// 手動小計値引の合計値を返す(per)
  /// 関連tprxソース: rxlogcalc.c - rxCalc_StlPdsc_AllAmt
  static int rxCalcStlPdscAllAmt(RegsMem regsmem) {
    int ret = 0;

    for (int i = 0; i < regsmem.tTtllog.t100001Sts.itemlogCnt; i++) {
      FuncKey define =
          FuncKey.getKeyDefine(regsmem.tItemLog[i].t50100.stldscCd);
      switch (define) {
        case FuncKey.KY_PM1:
        case FuncKey.KY_PM2:
        case FuncKey.KY_PM3:
        case FuncKey.KY_PM4:
        case FuncKey.KY_PM5:
          if ((regsmem.tItemLog[i].t50100Sts!.nonEffectFlg == 0) &&
              (regsmem.tItemLog[i].t10002.scrvoidFlg)) {
            ret += regsmem.tItemLog[i].t50100.stldscAmt;
          }
          break;
        default:
          ret += 0;
          break;
      }
    }
    return ret;
  }
}