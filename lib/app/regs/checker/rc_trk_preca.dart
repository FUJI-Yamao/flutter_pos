/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../fb/fb_init.dart';
import '../inc/rc_regs.dart';
import 'rc_itm_dsp.dart';
import 'rcfncchk.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';
import 'regs.dart';

class RcTrkPreca {
  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_trk_preca.c - rcKy_TRK_Preca_Deposit()
  static void rcKyTRKPrecaDeposit() {
    return;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rc_trk_preca.c - rcCheck_TRK_Preca_Deposit_Item(short flg)
  static int rcCheckTRKPrecaDepositItem(int flg) {
    return 0;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rcky_cha.c - rcKy_TRK_Preca_In()
  static void rcKyTRKPrecaIn() {
    return;
  }

  /// 関連tprxソース:C:rc_trk_preca.c - rcSusReg_Etc_Redisp()
  static Future<void> rcSusRegEtcRedisp() async {
    await RcItmDsp.rcDspSusmkLCD();

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.KY_SINGLE:
        if (FbInit.subinitMainSingleSpecialChk()) {
          await RcStlLcd.rcStlLcdSusReg(RegsDef.dualSubttl);
        }
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        if (await RcFncChk.rcCheckStlMode()) {
          await RcStlLcd.rcStlLcdSusReg(RegsDef.subttl);
        }
        break;
      default:
        break;
    }
  }

  // TODO: checker関数実装のため、定義のみ追加
  /// 関連tprxソース:C:rc_trk_preca.c - rcKy_TRK_Preca_Ref()
  static void rcKyTRKPrecaRef() {
    return;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rc_trk_preca.c - rcKy_TRK_Preca_Sales()
  static void rcKyTRKPrecaSales() {
    return;
  }
}
