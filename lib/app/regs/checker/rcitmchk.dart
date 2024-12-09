/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rcfncchk.dart';
import 'rcky_rfdopr.dart';
import 'rcsyschk.dart';

class RcItmChk {
  static List<int> mbrList0 = [
    FncCode.KY_REG.keyId, FncCode.KY_ENT.keyId, FncCode.KY_PSET.keyId,
    FuncKey.KY_CARD.keyId, 0];
  static List<int> mbrList1 = [0];
  static List<int> mbrList2 = [0];
  static List<int> mbrList3 = [0];
  static List<int> mbrList4 = [
    FuncKey.KY_PRC.keyId, FuncKey.KY_MBR.keyId, FuncKey.KY_TEL.keyId, 0];

  static List<int> crdtInMbrList0 = [
    FncCode.KY_REG.keyId, FncCode.KY_ENT.keyId, FncCode.KY_PSET.keyId,
    FuncKey.KY_CARD.keyId, FuncKey.KY_CRDTIN.keyId, 0];
  static List<int> crdtInMbrList1 = [0];
  static List<int> crdtInMbrList2 = [
    FncCode.KY_FNAL.keyId, FuncKey.KY_CASH.keyId, FuncKey.KY_CHA1.keyId,
    FuncKey.KY_CHA2.keyId, FuncKey.KY_CHA3.keyId, FuncKey.KY_CHA4.keyId,
    FuncKey.KY_CHA5.keyId, FuncKey.KY_CHA6.keyId, FuncKey.KY_CHA7.keyId,
    FuncKey.KY_CHA8.keyId, FuncKey.KY_CHA9.keyId, FuncKey.KY_CHA10.keyId,
    FuncKey.KY_CHK1.keyId, FuncKey.KY_CHK2.keyId, FuncKey.KY_CHK3.keyId,
    FuncKey.KY_CHK4.keyId, FuncKey.KY_CHK5.keyId,
    FuncKey.KY_CHA11.keyId, FuncKey.KY_CHA12.keyId, FuncKey.KY_CHA13.keyId,
    FuncKey.KY_CHA14.keyId, FuncKey.KY_CHA15.keyId, FuncKey.KY_CHA16.keyId,
    FuncKey.KY_CHA17.keyId, FuncKey.KY_CHA18.keyId, FuncKey.KY_CHA19.keyId,
    FuncKey.KY_CHA20.keyId, FuncKey.KY_CHA21.keyId, FuncKey.KY_CHA22.keyId,
    FuncKey.KY_CHA23.keyId, FuncKey.KY_CHA24.keyId, FuncKey.KY_CHA25.keyId,
    FuncKey.KY_CHA26.keyId, FuncKey.KY_CHA27.keyId, FuncKey.KY_CHA28.keyId,
    FuncKey.KY_CHA29.keyId, FuncKey.KY_CHA30.keyId, 0];
  static List<int> crdtInMbrList3 = [0];
  static List<int> crdtInMbrList4 = [
    FuncKey.KY_PRC.keyId, FuncKey.KY_MBR.keyId, FuncKey.KY_TEL.keyId,
    FuncKey.KY_CRDTIN.keyId, FuncKey.KY_CRDTIN.keyId, 0];

  /// 関連tprxソース: rcitmchk.c - rcCheck_NoteItmRec
  static bool rcCheckNoteItmRec(int recMthdFlg) {
    return(((recMthdFlg >= (REC_MTHD_FLG_LIST.NOTE_REC_CHA1.typeCd) )
        && (recMthdFlg <= (REC_MTHD_FLG_LIST.NOTE_REC_CHK5.typeCd)))
        || ((recMthdFlg >= (REC_MTHD_FLG_LIST.NOTE_REC_CHA11.typeCd))
            && (recMthdFlg <= (REC_MTHD_FLG_LIST.NOTE_REC_CHA30.typeCd))));
  }

  /// 関連tprxソース: rcitmchk.c - rcCheck_BenefitBar_Item
  static Future<bool> rcCheckBenefitBarItem() async {
    AcMem cMem = SystemFunc.readAcMem();
    if (await CmCksys.cmSpecialCouponSystem() != 0) {
      return (cMem.benefitBar!.couponBarFlg == '1');
    } else {
      return false;
    }
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcitmchk.c - rc_Chk_dPoint_MedicinePos_ItemKind
  static int rcChkdPointMedicinePosItemKind(int chk_kind) {
    return 0;
  }

  /// 顧客仕様で押下したファンクションキーをチェックする
  /// 戻り値: ファンクションキーNo
  /// 関連tprxソース: rcitmchk.c - rcCheck_Ky_Mbr
  static Future<int> rcCheckKyMbr() async {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.keyChkb = List.filled(cMem.keyChkb.length, 0xff);
    if (await rcCheckCrdtinMbr()) {
      for (int i = 0; i < crdtInMbrList0.length; i++) {
        if (crdtInMbrList0[i] == 0) {
          break;
        }
        RcRegs.kyStR0(cMem.keyChkb, crdtInMbrList0[i]);
      }
      for (int i = 0; i < crdtInMbrList1.length; i++) {
        if (crdtInMbrList1[i] == 0) {
          break;
        }
        RcRegs.kyStR1(cMem.keyChkb, crdtInMbrList1[i]);
      }
      for (int i = 0; i < crdtInMbrList2.length; i++) {
        if (crdtInMbrList2[i] == 0) {
          break;
        }
        RcRegs.kyStR2(cMem.keyChkb, crdtInMbrList2[i]);
      }
      for (int i = 0; i < crdtInMbrList3.length; i++) {
        if (crdtInMbrList3[i] == 0) {
          break;
        }
        RcRegs.kyStR3(cMem.keyChkb, crdtInMbrList3[i]);
      }
      for (int i = 0; i < crdtInMbrList4.length; i++) {
        if (crdtInMbrList4[i] == 0) {
          break;
        }
        RcRegs.kyStR4(cMem.keyChkb, crdtInMbrList4[i]);
      }
    } else {
      for (int i = 0; i < mbrList0.length; i++) {
        if (mbrList0[i] == 0) {
          break;
        }
        RcRegs.kyStR0(cMem.keyChkb, mbrList0[i]);
      }
      for (int i = 0; i < mbrList1.length; i++) {
        if (mbrList1[i] == 0) {
          break;
        }
        RcRegs.kyStR1(cMem.keyChkb, mbrList1[i]);
      }
      for (int i = 0; i < mbrList2.length; i++) {
        if (mbrList2[i] == 0) {
          break;
        }
        RcRegs.kyStR2(cMem.keyChkb, mbrList2[i]);
      }
      for (int i = 0; i < mbrList3.length; i++) {
        if (mbrList3[i] == 0) {
          break;
        }
        RcRegs.kyStR3(cMem.keyChkb, mbrList3[i]);
      }
      for (int i = 0; i < mbrList4.length; i++) {
        if (mbrList4[i] == 0) {
          break;
        }
        RcRegs.kyStR4(cMem.keyChkb, mbrList4[i]);
      }
    }

    if (await RcSysChk.rcCheckOutSider()) {
      RcRegs.kyStR7(cMem.keyChkb, FuncKey.KY_PRC.keyId);
      RcRegs.kyStR6(cMem.keyChkb, FuncKey.KY_PRC.keyId);
    }
    if (await CmCksys.cmSpecialCouponSystem() != 0) {
      if (await CmCksys.cmPalcoopCardForgotCheck() != 0) {
        return RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO1 + RcRegs.MACRO3);
      } else {
        RegsMem mem = SystemFunc.readRegsMem();
        if (((mem.tTtllog.t100001Sts.cardForgotFlg != 0) &&
                RcFncChk.rcCheckRegistration()) ||
            (RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO1 + RcRegs.MACRO3) != 0)) {
          return 1;
        } else {
          return 0;
        }
      }
    } else {
      return RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO1 + RcRegs.MACRO3);
    }
  }

  /// 顧客仕様かつクレジット入金ありかチェックする
  /// 戻り値: true=上記仕様  false=上記仕様でない
  /// 関連tprxソース: rcitmchk.c - rcCheck_Crdtin_Mbr
  static Future<bool> rcCheckCrdtinMbr() async {
    if (!((await RcSysChk.rcChkCapsCafisStandardSystem()) ||
          (await CmCksys.cmIchiyamaMartSystem() != 0))) {
      return false;
    }
    if (!RcSysChk.rcCheckCrdtStat()) {
      return false;
    }
    RegsMem mem = SystemFunc.readRegsMem();
    if (mem.tTtllog.t100002Sts.prgMbrStldscPer != 0 ) {
      /* 会員小計割引 */
      return false;
    }

    return true;
  }

  /// キャッシャーが未登録状態かチェックする
  /// 戻り値: true=未登録  false=未登録でない
  /// 関連tprxソース: rcitmchk.c - rcCheck_Cshr_NotReg
  static Future<bool> rcCheckCshrNotReg() async {
    if (!RcFncChk.rcCheckScanCheck() &&
        !RckyRfdopr.rcRfdOprCheckOperateRefundMode()) {
      AcMem cMem = SystemFunc.readAcMem();
      if (await RcSysChk.rcChkDesktopCashier()) {
        if (await RcSysChk.rcChkSpoolExist()) {
          return ((await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) &&
              (!RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId])) &&
              !(await RcSysChk.rcCheckQCJCSystem()));
        } else {
          return ((await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) &&
              (!RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId]) &&
                  (cMem.stat.cashintFlag == 0)) &&
              !(await RcSysChk.rcCheckQCJCSystem()));
        }
      } else {
        return ((await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) &&
            (!RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId]) &&
                (cMem.stat.cashintFlag == 0)) &&
            !(await RcSysChk.rcCheckQCJCSystem()));
      }
    } else {
      return false;
    }
  }

  /// 単品値引中かチェックする
  /// 戻り値: true=単品値引  false=単品値引でない
  /// 関連tprxソース: rcitmchk.c - rcCheck_Ky_Dsc
  static bool rcCheckKyDsc() {
    AcMem cMem = SystemFunc.readAcMem();

    return (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC1.keyId]) ||
        RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC2.keyId]) ||
        RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC3.keyId]) ||
        RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC4.keyId]) ||
        RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_DSC5.keyId]) );
  }

  /// 単品割引中かチェックする
  /// 戻り値: true=単品割引  false=単品割引でない
  /// 関連tprxソース: rcitmchk.c - rcCheck_Ky_Pm
  static bool rcCheckKyPm() {
    AcMem cMem = SystemFunc.readAcMem();

    return (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PM1.keyId]) ||
        RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PM2.keyId]) ||
        RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PM3.keyId]) ||
        RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PM4.keyId]) ||
        RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PM5.keyId]) );
  }

  /// 関連tprxソース: rcitmchk.c - rcCheck_Gs1Bar_Item
  static Future<bool> rcCheckGs1BarItem() async {
    AcMem cMem = SystemFunc.readAcMem();
    return ((await RcSysChk.rcChkGs1BarSystem()) &&
            (cMem.gs1Bar?.gs1barFlg == 1));
  }

  /// 関連tprxソース: rcitmchk.c - rcCheck_Ky_DscPm
  static bool rcCheckKyDscPm() {
    return ((rcCheckKyDsc()) || (rcCheckKyPm()));
  }

  /// 関連tprxソース: rcitmchk.c - rcCheck_Ky_Prc
  static bool rcCheckKyPrc() {
    AcMem cMem = SystemFunc.readAcMem();
    return (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_PRC.keyId]));
  }

  /// 関連tprxソース: rcitmchk.c - rcCheck_Item_Reduct_Coupon
  static Future<bool> rcCheckItemReductCoupon() async {
    AcMem cMem = SystemFunc.readAcMem();
    if ((await CmCksys.cmItemPrcReductionCouponSystem() != 0) &&
        (cMem.dscBar?.itemReductCoupon == 1)) {
      return (true);
    } else {
      return (false);
    }
  }

  /// 関連tprxソース: rcitmchk.c - rcCheck_Magazine_Bar_Item
  static bool rcCheckMagazineBarItem() {
    AcMem cMem = SystemFunc.readAcMem();
    return (cMem.magazineBar?.mgznBarFlg == "");
  }

  /// 関連tprxソース: rcitmchk.c - rcCheck_Prod2St_Item
  static bool rcCheckProd2StItem() {
    AcMem cMem = SystemFunc.readAcMem();
    return (cMem.prodBar?.prodBarFlg == "");
  }

  /// 関連tprxソース: rcitmchk.c - rcCheck_Card_ForgetBar1_Flg
  static Future<bool> rcCheckCardForgetBar1Flg() async {
    if (await CmCksys.cmSpecialCouponSystem() != 0) {
      AcMem cMem = SystemFunc.readAcMem();
      return (cMem.cardforgetBar?.forgetBar1Flg == "1");
    }
    return false;
  }

  /// 関連tprxソース: rcitmchk.c - rcCheck_Card_ForgetBar2_Flg
  static Future<bool> rcCheckCardForgetBar2Flg() async {
    if (await CmCksys.cmSpecialCouponSystem() != 0) {
      AcMem cMem = SystemFunc.readAcMem();
      return (cMem.cardforgetBar?.forgetBar2Flg == "1");
    }
    return false;
  }

  /// 機能：生産者2段バーコードメモリクリア
  /// 関連tprxソース: rcitmchk.c - rcClear_ProdBar_2St
  static void rcClearProdBar2St() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.prodBar = ProducerBar();
    cMem.prodBar!.prodBarFlg = "";
    cMem.prodBar!.prodBar1Flg = "";
    cMem.prodBar!.prodBar2Flg = "";
    cMem.prodBar!.prodBarPrc = 0;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcitmchk.c - rcitmchk_ayaha_gift_point_barcode 
  static int rcitmchkAyahaGiftPointBarcode(){
    return 0;
  }

}