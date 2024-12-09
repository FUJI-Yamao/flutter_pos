/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../regs/inc/rc_mem.dart';

/// 関連tprxソース: rcregs.hの一部（Machine Type部分）
enum MachineType {
  kySingle(0x00), /* I'm TPR Machine Single     */
  kyChecker(0x01), /* I'm TPR Machine Checker    */
  kyCashier(0x02), /* I'm TPR Machine Cashier    */
  desktopType(0x03), /* I'm TPR Machine Desk Top   */
  kyDualCshr(0x04); /* I'm TPR Machine DualCashier*/

  final int value;
  const MachineType(@required this.value);
}

///  関連tprxソース: rcregs.h - enum RESERV_FLG
enum RESERV_FLG {
  RESERV_FLG_NON(0),         /* 通常   */
  RESERV_FLG_RESERV(1),      /* 予約   */
  RESERV_FLG_CREDIT(2),      /* 掛売   */
  RESERV_FLG_DELIVERY(3),    /* 配達   */
  RESERV_FLG_ESTIMATE(4),    /* 見積り */
  RESERV_FLG_MAX(5);

  final int value;
  const RESERV_FLG(@required this.value);
}

/// #define masr orders
///  関連tprxソース: rcregs.h - enum MASR_ORDER_CK
enum MasrOrderCk {
  MASR_NONE,
  MASR_ERR,
  MASR_IDOL,
  READ_START,
  READ_WAITING,
  READ_END,
  CNCL_START,
  CNCL_END,
  RETREEP_START,
  RETREEP_END,
}

///  関連tprxソース: rcregs.h
class RcRegs {
  /************************************************************************/
  /*                              Status data                             */
  /************************************************************************/
  static const PRN_ERROR = 0x40;           /* Printer Error             */
  static const STAT_RegNearEnd = 0x00400000;    /* Warn REG.NearEnd          */
  static const VDTR_CTRL = 0x04000000;    /* Error VD&TR Status        */
  static const ERR_1TIME = 0x08000000;    /* Error One Time Status     */
  static const STAT_SvrOffLine = 0x00200000;   /* Error Server Offline Stat */
  static const MSDSP_CustTrmChg = 0x00020000;    /* 顧客ターミナル変更メッセージ表示 stat */
  static const FILCHECK_TomoLib_Reg = 0x00040000;    /* 友の会ライブラリチェック(各取引開始時)   */

  /************************************************************************/
  /*                             #define data                             */
  /************************************************************************/

  static const CLK_CL = 0;        /* CLK stat : close               */
  static const MACRO0 = 0x01;        /* Macro0_List for rcfncchk.c     */
  static const MACRO1 = 0x02;        /* Macro1_List for rcfncchk.c     */
  static const MACRO2 = 0x04;        /* Macro2_List for rcfncchk.c     */
  static const MACRO3 = 0x08;        /* Macro3_List for rcfncchk.c     */
  static const MACRO4 = 0x10;        /* Macro4_List for rcfncchk.c     */

  static const ENTRY_SEN = 3;        /* Ten Key Digit Senken Max       */
  static const ENTRY5SEN = 3;        /* Ten Key Digit 5Senken Max      */
  static const ENTRY_MAN = 4;        /* Ten Key Digit Manken Max       */
  static const ENTRY_CIN = 8;        /* Ten Key Digit In/Out Max       */

  static const PRIME      = 1;
  static const PRIMETOWER = 2;
  /************************************************************************/
  /*                            extern memorys                            */
  /************************************************************************/
  ///  関連tprxソース: rcregs.h - RC_INFO_MEM
  static RcInfoMemLists rcInfoMem = RcInfoMemLists();
  /// 関連tprxソース: rcregs.h - AT_SINGL
  static AtSingl atSing = AtSingl();
  /// 関連tprxソース: rcregs.h - OT
  static Onetime ot = Onetime();
  /// 関連tprxソース: rcregs.h - IFWAIT_SAVE
  static IfWaitSave ifSave = IfWaitSave();

  static const int RESERV_NON = 0;   /* 通常     */
  static const int RESERV_SET = 1;   /* 予約設定 */
  static const int RESERV_CALL = 2;   /* 予約呼出 */
  static const int RESERV_CNCL = 3;   /* 予約取消 */
  static const int RESERV_CONF = 4;   /* 予約確認 */
  static const int RESERV_ITEMADD = 12;  /* 商品追加 */
  static List<int>? kFncCd = List.generate(2, (index) => 0);

  /************************************************************************/
  /*                     #define datas FIP Display No.                    */
  /************************************************************************/
  static const int FIP_BOTH = 0;
  static const int FIP_NO1  = 1;
  static const int FIP_NO2  = 2;
  static const int FIP_NO3  = 3;

  static const int FIPLINE1 = 1;
  static const int FIPLINE2 = 2;
  static const int FIPLINE3 = 3;

  /*                        ScrMode use #define Data                      */
  /************************************************************************/
  static const PSP_DSP = 0x0490;           /* Psp Input Display          */

  static const EJCONF_DSP = 0x0070;           /* EjConf Display             */
  static const RG_EJCONF = (EJCONF_DSP + RG); /* Reg. EjConf Display        */
  static const VD_EJCONF = (EJCONF_DSP + VD); /* Cor. EjConf Display        */
  static const TR_EJCONF = (EJCONF_DSP + TR); /* Tra. EjConf Display        */
  static const SR_EJCONF = (EJCONF_DSP + SR); /* Scr. EjConf Display        */
  static const OD_EJCONF = (EJCONF_DSP + OD); /* Odr. EjConf Display        */
  static const IV_EJCONF = (EJCONF_DSP + IV); /* Inv. EjConf Display        */
  static const PD_EJCONF = (EJCONF_DSP + PD); /* Pro. EjConf Display        */

  static const int EVOID_DSP = 0x0080;           /* EVoid Display       */
  static const int RG_EVOID = (EVOID_DSP + RG);  /* Reg. EVoid Display  */
  static const int VD_EVOID = (EVOID_DSP + VD);  /* Cor. EVoid Display  */
  static const int TR_EVOID = (EVOID_DSP + TR);  /* Tra. EVoid Display  */
  static const int SR_EVOID = (EVOID_DSP + SR);  /* Scr. EVoid Display  */
  static const int CL_EVOID = (EVOID_DSP + CL);  /* Can. EVoid Display  */

  static const EREF_DSP =   0x00a0;            /* ERef Display               */
  static const RG_EREF  =  (EREF_DSP + RG);    /* Reg. ERef Display          */
  static const VD_EREF  =  (EREF_DSP + VD);    /* Cor. ERef Display          */
  static const TR_EREF  =  (EREF_DSP + TR);    /* Tra. ERef Display          */
  static const SR_EREF  =  (EREF_DSP + SR);    /* Scr. ERef Display          */

  static const EREFS_DSP = 0x00b0;           /* ERef Subtotal Display      */
  static const RG_EREFS = (EREFS_DSP + RG);  /* Reg. ERef Subtotal Display */
  static const VD_EREFS = (EREFS_DSP + VD);  /* Cor. ERef Subtotal Display */
  static const TR_EREFS = (EREFS_DSP + TR);  /* Tra. ERef Subtotal Display */
  static const SR_EREFS = (EREFS_DSP + SR);  /* Scr. ERef Subtotal Display */

  static const EREFI_DSP =  0x00c0;           /* ERef SubItem Display       */
  static const RG_EREFI  = (EREFI_DSP + RG);  /* Reg. ERef SubItem Display  */
  static const VD_EREFI  = (EREFI_DSP + VD);  /* Cor. ERef SubItem Display  */
  static const TR_EREFI  = (EREFI_DSP + TR);  /* Tra. ERef SubItem Display  */
  static const SR_EREFI  = (EREFI_DSP + SR);  /* Scr. ERef SubItem Display  */

  static const EREFR_DSP =  0x00d0;           /* ERef KyRef Display         */
  static const RG_EREFR  = (EREFR_DSP + RG);  /* Reg. ERef KyRef Display    */
  static const VD_EREFR  = (EREFR_DSP + VD);  /* Cor. ERef KyRef Display    */
  static const TR_EREFR  = (EREFR_DSP + TR);  /* Tra. ERef KyRef Display    */
  static const SR_EREFR  = (EREFR_DSP + SR);  /* Scr. ERef KyRef Display    */

  static const ESVOID_DSP =   0x01f0;             /* ERef Display               */
  static const RG_ESVOID  =  (ESVOID_DSP + RG);   /* Reg. ERef Display          */
  static const VD_ESVOID  =  (ESVOID_DSP + VD);   /* Cor. ERef Display          */
  static const TR_ESVOID  =  (ESVOID_DSP + TR);   /* Tra. ERef Display          */
  static const SR_ESVOID  =  (ESVOID_DSP + SR);   /* Scr. ERef Display          */

  static const ESVOIDS_DSP = 0x0200;             /* ERef Subtotal Display      */
  static const RG_ESVOIDS = (ESVOIDS_DSP + RG);  /* Reg. ERef Subtotal Display */
  static const VD_ESVOIDS = (ESVOIDS_DSP + VD);  /* Cor. ERef Subtotal Display */
  static const TR_ESVOIDS = (ESVOIDS_DSP + TR);  /* Tra. ERef Subtotal Display */
  static const SR_ESVOIDS = (ESVOIDS_DSP + SR);  /* Scr. ERef Subtotal Display */

  static const int ESVOIDI_DSP = 0x0210;             /* ERef SubItem Display       */
  static const int RG_ESVOIDI = (ESVOIDI_DSP + RG);  /* Reg. ERef SubItem Display  */
  static const int VD_ESVOIDI = (ESVOIDI_DSP + VD);  /* Cor. ERef SubItem Display  */
  static const int TR_ESVOIDI = (ESVOIDI_DSP + TR);  /* Tra. ERef SubItem Display  */
  static const int SR_ESVOIDI = (ESVOIDI_DSP + SR);  /* Scr. ERef SubItem Display  */

  static const ESVOIDV_DSP =  0x0220;             /* ERef SubItem Display       */
  static const RG_ESVOIDV  = (ESVOIDV_DSP + RG);  /* Reg. ERef SubItem Display  */
  static const VD_ESVOIDV  = (ESVOIDV_DSP + VD);  /* Cor. ERef SubItem Display  */
  static const TR_ESVOIDV  = (ESVOIDV_DSP + TR);  /* Tra. ERef SubItem Display  */
  static const SR_ESVOIDV  = (ESVOIDV_DSP + SR);  /* Scr. ERef SubItem Display  */

  static const ESVOIDSD_DSP =  0x0230;            /* ERef SubItem Display       */
  static const RG_ESVOIDSD  = (ESVOIDSD_DSP + RG); /* Reg. ERef SubItem Display  */
  static const VD_ESVOIDSD  = (ESVOIDSD_DSP + VD); /* Cor. ERef SubItem Display  */
  static const TR_ESVOIDSD  = (ESVOIDSD_DSP + TR); /* Tra. ERef SubItem Display  */
  static const SR_ESVOIDSD  = (ESVOIDSD_DSP + SR); /* Scr. ERef SubItem Display  */

  static const ESVOIDC_DSP  =  0x0240;            /* ERef SubItem Display       */
  static const RG_ESVOIDC   = (ESVOIDC_DSP + RG);  /* Reg. ERef SubItem Display  */
  static const VD_ESVOIDC   = (ESVOIDC_DSP + VD);  /* Cor. ERef SubItem Display  */
  static const TR_ESVOIDC   = (ESVOIDC_DSP + TR);  /* Tra. ERef SubItem Display  */
  static const SR_ESVOIDC   = (ESVOIDC_DSP + SR);  /* Scr. ERef SubItem Display  */

  static const CLSCNCL_DSP = 0x0270;            /* class cancel select Display  */
  static const RG_CLSCNCL = (CLSCNCL_DSP + RG); /* Reg. class cansel Display  */
  static const VD_CLSCNCL = (CLSCNCL_DSP + VD); /* Cor. class cansel Display  */
  static const TR_CLSCNCL = (CLSCNCL_DSP + TR); /* Tra. class cansel Display  */
  static const SR_CLSCNCL = (CLSCNCL_DSP + SR); /* Scr. class cansel Display  */

  static const ERCTFM_DSP = 0x0280;             /* ERef Display               */
  static const RG_ERCTFM = (ERCTFM_DSP + RG);   /* Reg. ERef Display          */
  static const VD_ERCTFM = (ERCTFM_DSP + VD);   /* Cor. ERef Display          */
  static const TR_ERCTFM = (ERCTFM_DSP + TR);   /* Tra. ERef Display          */
  static const SR_ERCTFM = (ERCTFM_DSP + SR);   /* Scr. ERef Display          */

  static const EJFIND_DSP = 0x0290;             /* ejconf_find Display        */
  static const RG_EJFIND = (EJFIND_DSP + RG);   /* Reg. ejconf_find Display   */
  static const VD_EJFIND = (EJFIND_DSP + VD);   /* Cor. ejconf_find Display   */
  static const TR_EJFIND = (EJFIND_DSP + TR);   /* Tra. ejconf_find Display   */
  static const SR_EJFIND = (EJFIND_DSP + SR);   /* Scr. ejconf_find Display   */
  static const OD_EJFIND = (EJFIND_DSP + OD);   /* Odr. ejconf_find Display   */
  static const IV_EJFIND = (EJFIND_DSP + IV);   /* Inv. ejconf_find Display   */
  static const PD_EJFIND = (EJFIND_DSP + PD);   /* Pro. ejconf_find Display   */

  static const CPWR_DSP = 0x02d0;                 /* CPWR Display             */
  static const RG_CPWR = (CPWR_DSP + RG);         /* Reg. CPWR Display        */
  static const VD_CPWR = (CPWR_DSP + VD);         /* Cor. CPWR Display        */
  static const TR_CPWR = (CPWR_DSP + TR);         /* Tra. CPWR Display        */
  static const SR_CPWR = (CPWR_DSP + SR);         /* Scr. CPWR Display        */

  // DUAL_SCNDSP, DUAL_SCNMBR は FB2GTK = true時に有効
  static const DUAL_SCNDSP = 0x0300;             /* ScnPrcMode DualCshr Display*/
  static const RG_DUALSCNPRC = (DUAL_SCNDSP + RG); /* Reg. ScnPrcMode Display    */
  static const VD_DUALSCNPRC = (DUAL_SCNDSP + VD); /* Cor. ScnPrcMode Display    */
  static const TR_DUALSCNPRC = (DUAL_SCNDSP + TR); /* Tra. ScnPrcMode Display    */
  static const SR_DUALSCNPRC = (DUAL_SCNDSP + SR); /* Scr. ScnPrcMode Display    */
  static const OD_DUALSCNPRC = (DUAL_SCNDSP + OD); /* Odr. ScnPrcMode Display    */
  static const IV_DUALSCNPRC = (DUAL_SCNDSP + IV); /* Inv. ScnPrcMode Display    */
  static const PD_DUALSCNPRC = (DUAL_SCNDSP + PD); /* Pro. ScnPrcMode Display    */
  static const DUAL_SCNMBR = 0x0310;             /* ScnMbrMode DualCshr Display*/
  static const RG_DUALSCNMBR = (DUAL_SCNMBR + RG); /* Reg. ScnPrcMode Display    */
  static const VD_DUALSCNMBR = (DUAL_SCNMBR + VD); /* Cor. ScnPrcMode Display    */
  static const TR_DUALSCNMBR = (DUAL_SCNMBR + TR); /* Tra. ScnPrcMode Display    */
  static const SR_DUALSCNMBR = (DUAL_SCNMBR + SR); /* Scr. ScnPrcMode Display    */
  static const OD_DUALSCNMBR = (DUAL_SCNMBR + OD); /* Odr. ScnPrcMode Display    */
  static const IV_DUALSCNMBR = (DUAL_SCNMBR + IV); /* Inv. ScnPrcMode Display    */
  static const PD_DUALSCNMBR = (DUAL_SCNMBR + PD); /* Pro. ScnPrcMode Display    */

  static const CRDTVOID_DSP = 0x0320;             /* CrdtVoid Display       */
  static const RG_CRDTVOID = (CRDTVOID_DSP + RG); /* Reg. CrdtVoid Display */
  static const VD_CRDTVOID = (CRDTVOID_DSP + VD); /* Cor. CrdtVoid Display */
  static const TR_CRDTVOID = (CRDTVOID_DSP + TR); /* Tra. CrdtVoid Display */
  static const SR_CRDTVOID = (CRDTVOID_DSP + SR); /* Scr. CrdtVoid Display */

  static const CRDTVOIDS_DSP = 0x0330;             /* CrdtVoid Subtotal Display       */
  static const RG_CRDTVOIDS = (CRDTVOIDS_DSP + RG); /* Reg. CrdtVoid Subtotal Display */
  static const VD_CRDTVOIDS = (CRDTVOIDS_DSP + VD); /* Cor. CrdtVoid Subtotal Display */
  static const TR_CRDTVOIDS = (CRDTVOIDS_DSP + TR); /* Tra. CrdtVoid Subtotal Display */
  static const SR_CRDTVOIDS = (CRDTVOIDS_DSP + SR); /* Scr. CrdtVoid Subtotal Display */

  static const CRDTVOIDI_DSP = 0x0340;             /* CrdtVoid SubItem Display       */
  static const RG_CRDTVOIDI = (CRDTVOIDI_DSP + RG); /* Reg. CrdtVoid SubItem Display */
  static const VD_CRDTVOIDI = (CRDTVOIDI_DSP + VD); /* Cor. CrdtVoid SubItem Display */
  static const TR_CRDTVOIDI = (CRDTVOIDI_DSP + TR); /* Tra. CrdtVoid SubItem Display */
  static const SR_CRDTVOIDI = (CRDTVOIDI_DSP + SR); /* Scr. CrdtVoid SubItem Display */

  static const CRDTVOIDA_DSP = 0x0350;             /* CrdtVoid Approve Display       */
  static const RG_CRDTVOIDA = (CRDTVOIDA_DSP + RG); /* Reg. CrdtVoid Approve Display */
  static const VD_CRDTVOIDA = (CRDTVOIDA_DSP + VD); /* Cor. CrdtVoid Approve Display */
  static const TR_CRDTVOIDA = (CRDTVOIDA_DSP + TR); /* Tra. CrdtVoid Approve Display */
  static const SR_CRDTVOIDA = (CRDTVOIDA_DSP + SR); /* Scr. CrdtVoid Approve Display */

  static const STLDSCCNCL_DSP = 0x04f0;        /* subttl disc cancel select Display */
  static const RG_STLDSCCNCL = (STLDSCCNCL_DSP + RG); /* Reg. subttl disc cansel Display */
  static const VD_STLDSCCNCL = (STLDSCCNCL_DSP + VD); /* Cor. subttl disc cansel Display */
  static const TR_STLDSCCNCL = (STLDSCCNCL_DSP + TR); /* Tra. subttl disc cansel Display */
  static const SR_STLDSCCNCL = (STLDSCCNCL_DSP + SR); /* Scr. subttl disc cansel Display */

  static const GODUTCH_DSP = 0x0500;        /* subttl disc cancel select Display */
  static const RG_GODUTCH = (GODUTCH_DSP + RG); /* Reg. subttl disc cansel Display */
  static const VD_GODUTCH = (GODUTCH_DSP + VD); /* Cor. subttl disc cansel Display */
  static const TR_GODUTCH = (GODUTCH_DSP + TR); /* Tra. subttl disc cansel Display */
  static const SR_GODUTCH = (GODUTCH_DSP + SR); /* Scr. subttl disc cansel Display */

  static const RBTCNCL_DSP = 0x0520;        /* subttl disc cancel select Display */
  static const RG_RBTCNCL = (RBTCNCL_DSP + RG); /* Reg. subttl disc cansel Display */
  static const VD_RBTCNCL = (RBTCNCL_DSP + VD); /* Cor. subttl disc cansel Display */
  static const TR_RBTCNCL = (RBTCNCL_DSP + TR); /* Tra. subttl disc cansel Display */
  static const SR_RBTCNCL = (RBTCNCL_DSP + SR); /* Scr. subttl disc cansel Display */

  static const PLUSCNCL_DSP = 0x0530;        /* subttl disc cancel select Display */
  static const RG_PLUSCNCL = (PLUSCNCL_DSP + RG); /* Reg. subttl disc cansel Display */
  static const VD_PLUSCNCL = (PLUSCNCL_DSP + VD); /* Cor. subttl disc cansel Display */
  static const TR_PLUSCNCL = (PLUSCNCL_DSP + TR); /* Tra. subttl disc cansel Display */
  static const SR_PLUSCNCL = (PLUSCNCL_DSP + SR); /* Scr. subttl disc cansel Display */

  static const SG_CHK_DSP = 0x0560;           /* Self Check display         */
  static const RG_SG_CHK = (SG_CHK_DSP + RG); /* Reg. Self Check Display    */
  static const TR_SG_CHK = (SG_CHK_DSP + TR); /* Tra. Self Check Display    */

  static const MANUALMM_DSP = 0x05C0;            /* Manual Mixmach Info Display  */
  static const RG_MANUALMM = (MANUALMM_DSP + RG); /* Reg. Manual Mixmach Display  */
  static const VD_MANUALMM = (MANUALMM_DSP + VD); /* Cor. Manual Mixmact Display  */
  static const TR_MANUALMM = (MANUALMM_DSP + TR); /* Tra. Manual Mixmach Display  */
  static const SR_MANUALMM = (MANUALMM_DSP + SR); /* Scr. Manual Mixmach Display  */

  static const CHGINOUT_DSP = 0x05D0;            /* Change InOut Info Display  */
  static const RG_CHGINOUT = (CHGINOUT_DSP + RG); /* Reg. Change InOut Display  */
  static const VD_CHGINOUT = (CHGINOUT_DSP + VD); /* Cor. Change InOut Display  */
  static const TR_CHGINOUT = (CHGINOUT_DSP + TR); /* Tra. Change InOut Display  */
  static const SR_CHGINOUT = (CHGINOUT_DSP + SR); /* Scr. Change InOut Display  */

  static const MONEYCONF_DSP = 0x05E0;            /* Manual Mixmach Info Display  */
  static const RG_MONEYCONF = (MONEYCONF_DSP + RG); /* Reg. Manual Mixmach Display  */
  static const VD_MONEYCONF = (MONEYCONF_DSP + VD); /* Cor. Manual Mixmact Display  */
  static const TR_MONEYCONF = (MONEYCONF_DSP + TR); /* Tra. Manual Mixmach Display  */
  static const SR_MONEYCONF = (MONEYCONF_DSP + SR); /* Scr. Manual Mixmach Display  */

  static const CHGQTY_DSP = 0x05F0;            /* Manual Mixmach Info Display  */
  static const RG_CHGQTY = (CHGQTY_DSP + RG); /* Reg. Manual Mixmach Display  */
  static const VD_CHGQTY = (CHGQTY_DSP + VD); /* Cor. Manual Mixmact Display  */
  static const TR_CHGQTY = (CHGQTY_DSP + TR); /* Tra. Manual Mixmach Display  */
  static const SR_CHGQTY = (CHGQTY_DSP + SR); /* Scr. Manual Mixmach Display  */

  static const SPRIT_DSP = 0x0600;                /* Sprit Display      */
  static const RG_SPRIT_DSP = (SPRIT_DSP + RG);   /* Reg. Sprit Display */
  static const VD_SPRIT_DSP = (SPRIT_DSP + VD);   /* Cor. Sprit Display */
  static const TR_SPRIT_DSP = (SPRIT_DSP + TR);   /* Tra. Sprit Display */
  static const SR_SPRIT_DSP = (SPRIT_DSP + SR);   /* Scr. Sprit Display */
  static const OD_SPRIT_DSP = (SPRIT_DSP + OD);   /* Odr. Sprit Display */
  static const IV_SPRIT_DSP = (SPRIT_DSP + IV);   /* Inv. Sprit Display */
  static const PD_SPRIT_DSP = (SPRIT_DSP + PD);   /* Pro. Sprit Display */

  static const CHGLOAN_DSP = 0x06A0;         /* Change Loan Display      */
  static const RG_CHGLOAN = (CHGLOAN_DSP + RG);   /* Reg. Change Loan Display */
  static const VD_CHGLOAN = (CHGLOAN_DSP + VD);   /* Cor. Change Loan Display */
  static const TR_CHGLOAN = (CHGLOAN_DSP + TR);   /* Tra. Change Loan Display */
  static const SR_CHGLOAN = (CHGLOAN_DSP + SR);   /* Scr. Change Loan Display */

  static const HCARD_DSP = 0x06B0;         /* House Card Display      */
  static const RG_HCARD = (HCARD_DSP + RG);    /* Reg. House Card Display */
  static const VD_HCARD = (HCARD_DSP + VD);    /* Cor. House Card Display */
  static const TR_HCARD = (HCARD_DSP + TR);    /* Tra. House Card Display */
  static const SR_HCARD = (HCARD_DSP + SR);    /* Scr. House Card Display */

  static const TPNTRATE_DSP = 0x06D0;         /* today point rate Display  */
  static const RG_TPNTRATE = (TPNTRATE_DSP + RG);   /* Reg. Change Loan Display */
  static const VD_TPNTRATE = (TPNTRATE_DSP + VD);   /* Cor. Change Loan Display */
  static const TR_TPNTRATE = (TPNTRATE_DSP + TR);   /* Tra. Change Loan Display */
  static const SR_TPNTRATE = (TPNTRATE_DSP + SR);   /* Scr. Change Loan Display */

  static const EDY_SETERRCONF_DSP = 0x0700;          /* Edy Set Err Confirm Display   */
  static const RG_EDY_SETERRCONF = (EDY_SETERRCONF_DSP + RG);  /* Reg. Edy Set Err Conf Display */
  static const VD_EDY_SETERRCONF = (EDY_SETERRCONF_DSP + VD);  /* Cor. Edy Set Err Conf Display */
  static const TR_EDY_SETERRCONF = (EDY_SETERRCONF_DSP + TR);  /* Tra. Edy Set Err Conf Display */
  static const SR_EDY_SETERRCONF = (EDY_SETERRCONF_DSP + SR);  /* Scr. Edy Set Err Conf Display */

  static const int POINTMOV_DSP = 0x0720;         // Point Move Display
  static const int RG_POINTMOV = POINTMOV_DSP + RG; // Reg. Point Move Display
  static const int VD_POINTMOV = POINTMOV_DSP + VD; // Cor. Point Move Display
  static const int TR_POINTMOV = POINTMOV_DSP + TR; // Tra. Point Move Display
  static const int SR_POINTMOV = POINTMOV_DSP + SR; // Scr. Point Move Display

  static const TUO_DSP = 0x0740;         /* Change Loan Display      */
  static const RG_TUO_DSP = (TUO_DSP + RG);   /* Reg. Change Loan Display */
  static const VD_TUO_DSP = (TUO_DSP + VD);   /* Cor. Change Loan Display */
  static const TR_TUO_DSP = (TUO_DSP + TR);   /* Tra. Change Loan Display */
  static const SR_TUO_DSP = (TUO_DSP + SR);   /* Scr. Change Loan Display */

  static const CHGPTN_DSP = 0x0750;        /* Change Patern Display  */
  static const RG_CHGPTN = (CHGPTN_DSP + RG);  /* Reg. Change Patern Display */
  static const VD_CHGPTN = (CHGPTN_DSP + VD);  /* Cor. Change Patern Display */
  static const TR_CHGPTN = (CHGPTN_DSP + TR);  /* Tra. Change Patern Display */
  static const SR_CHGPTN = (CHGPTN_DSP + SR);  /* Scr. Change Patern Display */

  static const TUOCARD_DSP = 0x0760;         /* Change Loan Display      */
  static const RG_TUOCARD_DSP = (TUOCARD_DSP + RG);   /* Reg. Change Loan Display */
  static const VD_TUOCARD_DSP = (TUOCARD_DSP + VD);   /* Cor. Change Loan Display */
  static const TR_TUOCARD_DSP = (TUOCARD_DSP + TR);   /* Tra. Change Loan Display */
  static const SR_TUOCARD_DSP = (TUOCARD_DSP + SR);   /* Scr. Change Loan Display */

  static const SG_PANAMBR_DSP = 0x0850;                  /* Self Pana Member Card Read Mode Display      */
  static const RG_SG_PANAMBR_DSP = (SG_PANAMBR_DSP + RG);    /* Reg. Self Pana Member Card Read Mode Display */
  static const TR_SG_PANAMBR_DSP = (SG_PANAMBR_DSP + TR);    /* Tra. Self Pana Member Card Read Mode Display */

  static const MDA_CRDT_DSP = 0x08B0;         /* Media Credit Info Display      */
  static const RG_MDA_CRDT_DSP = (MDA_CRDT_DSP + RG); /* Reg. Media Credit Info Display */
  static const VD_MDA_CRDT_DSP = (MDA_CRDT_DSP + VD); /* Cor. Media Credit Info Display */
  static const TR_MDA_CRDT_DSP = (MDA_CRDT_DSP + TR); /* Tra. Media Credit Info Display */
  static const SR_MDA_CRDT_DSP = (MDA_CRDT_DSP + SR); /* Scr. Media Credit Info Display */

  static const SG_WRT_WGT_DSP = 0x0960;                 /* SSPS Write Weight Display        */
  static const RG_SG_WRT_WGT_DSP = (SG_WRT_WGT_DSP + RG);  /* Reg. SSPS Write Weight Display   */
  static const TR_SG_WRT_WGT_DSP = (SG_WRT_WGT_DSP + TR);  /* Tra. SSPS Write Weight Display   */

  static const CHGITM_DSP = 0x0970;                 /* Item Change Display      */
  static const RG_CHGITM = (CHGITM_DSP + RG);       /* Reg. Item Change Display */
  static const VD_CHGITM = (CHGITM_DSP + VD);       /* Cor. Item Change Display */
  static const TR_CHGITM = (CHGITM_DSP + TR);       /* Tra. Item Change Display */
  static const SR_CHGITM = (CHGITM_DSP + SR);       /* Scr. Item Change Display */

  static const SG_MBRINPUT_DSP =  0x0980;                 /* Member Input display        */
  static const RG_SG_MBRINPUT  = (SG_MBRINPUT_DSP + RG);  /* Reg. SG MbrInput Display  */
  static const TR_SG_MBRINPUT  = (SG_MBRINPUT_DSP + TR);  /* Tra. SG MbrInput Display  */

  static const int QC_START_DSP =  0x0990; /* QCashier Start display        */
  static const int RG_QC_START = (QC_START_DSP + RG); /* Reg. SG QCashier Start Display  */
  static const int TR_QC_START = (QC_START_DSP + TR); /* Tra. SG QCashier Start Display  */

  static const HT_DSP = 0x09D0;                 // Ht2980 R/W Display
  static const RG_HT = HT_DSP + RG;             // Reg. Ht2980 R/W Display
  static const VD_HT = HT_DSP + VD;             // Cor. Ht2980 R/W Display
  static const TR_HT = HT_DSP + TR;             // Tra. Ht2980 R/W Display
  static const SR_HT = HT_DSP + SR;             // Scr. Ht2980 R/W Display

  static const int QC_CALL_DSP = 0x09F0;                 /* QCashier Staff Call? display        */
  static const int RG_QC_CALL  = (QC_CALL_DSP + RG);     /* Reg. SG QCashier Staff Call Display  */
  static const int TR_QC_CALL  = (QC_CALL_DSP + TR);     /* Tra. SG QCashier Staff Call Display  */

  static const int QC_STAFF_DSP = 0x0A00;                 /* QCashier Staff Calling display        */
  static const int RG_QC_STAFF = (QC_STAFF_DSP + RG);     /* Reg. SG QCashier Staff Calling Display  */
  static const int TR_QC_STAFF = (QC_STAFF_DSP + TR);     /* Tra. SG QCashier Staff Calling Display  */

  static const QC_PASWD_DSP = 0x0A10;                 /* QCashier Pass Ward display        */
  static const RG_QC_PASWD = (QC_PASWD_DSP + RG);     /* Reg. SG QCashier Pass Ward Display  */
  static const TR_QC_PASWD = (QC_PASWD_DSP + TR);     /* Tra. SG QCashier Pass Ward Display  */

  static const int QC_MENTE_DSP = 0x0A20; /* QCashier Mentenance display        */
  static const int RG_QC_MENTE = (QC_MENTE_DSP + RG); /* Reg. SG QCashier Mentenance Display  */
  static const int TR_QC_MENTE = (QC_MENTE_DSP + TR); /* Tra. SG QCashier Mentenance Display  */

  static const int PBCHG_DSP = 0x0A30;                 // PBCHG Display
  static const int RG_PBCHG_DSP = PBCHG_DSP + RG;          // Reg. PBCHG R/W Display
  static const int VD_PBCHG_DSP = PBCHG_DSP + VD;          // Cor. PBCHG Display
  static const int TR_PBCHG_DSP = PBCHG_DSP + TR;          // Tra. PBCHG Display
  static const int SR_PBCHG_DSP = PBCHG_DSP + SR;          // Scr. PBCHG Display

  static const SG_HT2980_DSP = 0x0A60;              /* SG Ht2980 R/W Display       */
  static const RG_SG_HT2980 = (SG_HT2980_DSP + RG); /* Reg. SG Ht2980 R/W Display  */
  static const TR_SG_HT2980 = (SG_HT2980_DSP + TR); /* Tra. SG Ht2980 R/W Display  */

  static const QC_SUSDSP = 0x0A70;              /* QCashier Suspend display       */
  static const RG_QC_SUSDSP = (QC_SUSDSP + RG);     /* Reg. QCashier Suspend display  */
  static const TR_QC_SUSDSP = (QC_SUSDSP + TR);     /* Tra. QCashier Suspend display  */

  static const ACCOUNT_OFFSET_DSP = 0x0A90;         /* specialDepartment OrgReceipt input Display      */
  static const RG_ACCOUNT_OFFSET_DSP = (ACCOUNT_OFFSET_DSP + RG); /* Reg. specialDepartment Input Display */
  static const VD_ACCOUNT_OFFSET_DSP = (ACCOUNT_OFFSET_DSP + VD); /* Cor. specialDepartment Input Display */
  static const TR_ACCOUNT_OFFSET_DSP = (ACCOUNT_OFFSET_DSP + TR); /* Tra. specialDepartment Input Display */
  static const SR_ACCOUNT_OFFSET_DSP = (ACCOUNT_OFFSET_DSP + SR); /* Scr. specialDepartment Input Display */

  static const CHGPTN_COOP_DSP = 0x0AA0;        /* CoopA Change Display  */
  static const RG_CHGPTN_COOP_DSP = (CHGPTN_COOP_DSP + RG);  /* Reg. CoopA Change Display */
  static const VD_CHGPTN_COOP_DSP = (CHGPTN_COOP_DSP + VD);  /* Cor. CoopA Change Display */
  static const TR_CHGPTN_COOP_DSP = (CHGPTN_COOP_DSP + TR);  /* Tra. CoopA Change Display */
  static const SR_CHGPTN_COOP_DSP = (CHGPTN_COOP_DSP + SR);  /* Scr. CoopA Change Display */

  static const SRCH_REG_DSP = 0x0AB0;			/* Search Registration Display  */
  static const RG_SRCH_REG_DSP = (SRCH_REG_DSP + RG);	/* Reg. Search Registration Display  */
  static const VD_SRCH_REG_DSP = (SRCH_REG_DSP + VD);	/* Cor. Search Registration Display  */
  static const TR_SRCH_REG_DSP = (SRCH_REG_DSP + TR);	/* Tra. Search Registration Display  */
  static const SR_SRCH_REG_DSP = (SRCH_REG_DSP + SR);	/* Scr. Search Registration Display  */

  static const QC_CRDTUSE_DSP = 0x0B10;                 /* QCashier Crdt display        */
  static const RG_QC_CRDTUSE = (QC_CRDTUSE_DSP + RG);  /* Reg. SG QCashier Crdt Display  */
  static const TR_QC_CRDTUSE = (QC_CRDTUSE_DSP + TR);  /* Tra. SG QCashier Crdt Display  */

  static const int QC_CRDTPAYEND_DSP = 0x0B20;                /* QCashier Crdt display        */
  static const int RG_QC_CRDTEND = (QC_CRDTPAYEND_DSP + RG);  /* Reg. SG QCashier Crdt Display  */
  static const int TR_QC_CRDTEND = (QC_CRDTPAYEND_DSP + TR);  /* Tra. SG QCashier Crdt Display  */

  static const QC_EDY_DSP = 0x0B30;             /* QCashier Edy display      */
  static const RG_QC_EDY = (QC_EDY_DSP + RG);   /* Reg. QCashier Edy Display */
  static const TR_QC_EDY = (QC_EDY_DSP + TR);   /* Tra. QCashier Edy Display */
  //
  // #define    QC_EDYUSE_DSP    0x0B40                /* QCashier Edy Use display      */
  // #define    RG_QC_EDYUSE    (QC_EDYUSE_DSP + RG)   /* Reg. QCashier Edy Use Display */
  // #define    TR_QC_EDYUSE    (QC_EDYUSE_DSP + TR)   /* Tra. QCashier Edy Use Display */
  //
  // #define    QC_EDYEND_DSP    0x0B50                /* QCashier Edy End display      */
  // #define    RG_QC_EDYEND    (QC_EDYEND_DSP + RG)   /* Reg. QCashier Edy End Display */
  // #define    TR_QC_EDYEND    (QC_EDYEND_DSP + TR)   /* Tra. QCashier Edy End Display */
  //
  // #define    WEBREAL_DSP     0x0B60         /* today point rate Display  */
  // #define    RG_WEBREAL (WEBREAL_DSP + RG)   /* Reg. Change Loan Display */
  // #define    VD_WEBREAL (WEBREAL_DSP + VD)   /* Cor. Change Loan Display */
  // #define    TR_WEBREAL (WEBREAL_DSP + TR)   /* Tra. Change Loan Display */
  // #define    SR_WEBREAL (WEBREAL_DSP + SR)   /* Scr. Change Loan Display */
  //
  static const int QC_EMNY_SLCT_DSP = 0x0B70;                  /* QCashier Electronic Money Select display      */
  static const int RG_QC_EMNY_SLCT = (QC_EMNY_SLCT_DSP + RG);  /* Reg. QCashier Electronic Money Select Display */
  static const int TR_QC_EMNY_SLCT = (QC_EMNY_SLCT_DSP + TR);  /* Tra. QCashier Electronic Money Select Display */

  static const int QC_EMNY_EDY_DSP = 0x0B80;                  /* QCashier Electronic Money Edy display      */
  static const int RG_QC_EMNY_EDY = (QC_EMNY_EDY_DSP + RG);   /* Reg. QCashier Electronic Money Edy Display */
  static const int TR_QC_EMNY_EDY = (QC_EMNY_EDY_DSP + TR);   /* Tra. QCashier Electronic Money Edy Display */

  static const int QC_EMNY_EDYEND_DSP = 0x0B90;                     /* QCashier Electronic Money Edy End display      */
  static const int RG_QC_EMNY_EDYEND = (QC_EMNY_EDYEND_DSP + RG);   /* Reg. QCashier Electronic Money Edy End Display */
  static const int TR_QC_EMNY_EDYEND = (QC_EMNY_EDYEND_DSP + TR);   /* Tra. QCashier Electronic Money Edy End Display */

  static const int ADVANCE_OUT_DSP = 0x0BA0;         /* Advance Input Display      */
  static const int RG_ADVANCE_OUT_DSP = (ADVANCE_OUT_DSP + RG); /* Reg. Advance Input Display */
  static const int VD_ADVANCE_OUT_DSP = (ADVANCE_OUT_DSP + VD); /* Cor. Advance Input Display */
  static const int TR_ADVANCE_OUT_DSP = (ADVANCE_OUT_DSP + TR); /* Tra. Advance Input Display */
  static const int SR_ADVANCE_OUT_DSP = (ADVANCE_OUT_DSP + SR); /* Scr. Advance Input Display */
  //
  // #define    CHGDRW_DSP    0x0BB0         /* Changer Drawer Display      */
  // #define    RG_CHGDRW_DSP (CHGDRW_DSP + RG) /* Reg. Changer Drawer Display */
  // #define    VD_CHGDRW_DSP (CHGDRW_DSP + VD) /* Cor. Changer Drawer Display */
  // #define    TR_CHGDRW_DSP (CHGDRW_DSP + TR) /* Tra. Changer Drawer Display */
  // #define    SR_CHGDRW_DSP (CHGDRW_DSP + SR) /* Scr. Changer Drawer Display */
  //
  // #define    QC_SUICA_TRAN_TIME     0x0BC0          /* QCashier Suica Tran Time Display      */
  // #define    RG_QC_SUICA_TRAN_TIME (QC_SUICA_TRAN_TIME + RG)   /* Reg. QCashier Cancel Display */
  // #define    TR_QC_SUICA_TRAN_TIME (QC_SUICA_TRAN_TIME + TR)   /* Tra. QCashier Cancel Display */

  static const QC_SUICA_TCH = 0x0BD0;                    /* QCashier Suica Touch Mode Display          */
  static const RG_QC_SUICA_TCH = (QC_SUICA_TCH + RG);    /* Reg. QCashier Suica Touch Mode Display     */
  static const TR_QC_SUICA_TCH = (QC_SUICA_TCH + TR);    /* Tra. QCashier Suica Touch Mode Display     */

  // #define    QC_SUICA_USE     0x0BE0                   /* QCashier Suica Use Mode Display            */
  // #define    RG_QC_SUICA_USE    (QC_SUICA_USE + RG)    /* Reg. QCashier Suica Use Mode Mode Display  */
  // #define    TR_QC_SUICA_USE    (QC_SUICA_USE + TR)    /* Tra. QCashier Suica USe Mode Mode Display  */
  //
  // #define    QC_SUICA_BAL     0x0BF0                   /* QCashier Suica All Use Mode Display        */
  // #define    RG_QC_SUICA_BAL    (QC_SUICA_BAL + RG)    /* Reg. QCashier Suica Bal Use Mode Display   */
  // #define    TR_QC_SUICA_BAL    (QC_SUICA_BAL + TR)    /* Tra. QCashier Suica Bal Use Mode Display   */
  //
  // #define    QC_SUICA_END     0x0C00                   /* QCashier Suica End Mode Display            */
  // #define    RG_QC_SUICA_END    (QC_SUICA_END + RG)    /* Reg. QCashier Suica End Mode Mode Display  */
  // #define    TR_QC_SUICA_END    (QC_SUICA_END + TR)    /* Tra. QCashier Suica End Mode Mode Display  */

  static const QC_SUICA_CHK = 0x0C10;                   /* QCashier Suica Ckeck Bal Mode Display      */
  static const RG_QC_SUICA_CHK = (QC_SUICA_CHK + RG);    /* Reg. QCashier Suica Ckeck Bal Mode Display */
  static const TR_QC_SUICA_CHK = (QC_SUICA_CHK + TR);    /* Tra. QCashier Suica Ckeck Bal Mode Display */

  // #define    QC_SUICA_CHKAF   0x0C20                     /* QCashier Suica Bal Ckeck After Mode Display      */
  // #define    RG_QC_SUICA_CHKAF    (QC_SUICA_CHKAF + RG)  /* Reg. QCashier Suica Ckeck Bal After Mode Display */
  // #define    TR_QC_SUICA_CHKAF    (QC_SUICA_CHKAF + TR)  /* Tra. QCashier Suica Ckeck Bal After Mode Display */
  //
  // #define    QC_SUICA_ALL     0x0C30                   /* Pay All Edy display             */
  // #define    RG_QC_SUICA_ALL    (QC_SUICA_ALL + RG)    /* Reg. QC Pay All Edy display     */
  // #define    TR_QC_SUICA_ALL    (QC_SUICA_ALL + TR)    /* Tra. QC Pay All Edy display     */
  //
  // #define    CONFDLG_DSP    0x0C40         /* Changer Drawer Display      */
  // #define    RG_CONFDLG_DSP (CONFDLG_DSP + RG) /* Reg. Changer Drawer Display */
  // #define    VD_CONFDLG_DSP (CONFDLG_DSP + VD) /* Cor. Changer Drawer Display */
  // #define    TR_CONFDLG_DSP (CONFDLG_DSP + TR) /* Tra. Changer Drawer Display */
  // #define    SR_CONFDLG_DSP (CONFDLG_DSP + SR) /* Scr. Changer Drawer Display */

  static const CHGTRAN_DSP = 0x0C50;              /* Changer Tran Display      */
  static const RG_CHGTRAN_DSP = (CHGTRAN_DSP + RG); /* Reg. Changer Tran Display */
  static const VD_CHGTRAN_DSP = (CHGTRAN_DSP + VD); /* Cor. Changer Tran Display */
  static const TR_CHGTRAN_DSP = (CHGTRAN_DSP + TR); /* Tra. Changer Tran Display */
  static const SR_CHGTRAN_DSP = (CHGTRAN_DSP + SR); /* Scr. Changer Tran Display */

  // #define    CUSTOMERBAR_DSP 0x0C60                    /* Changer Customer BarCode Display */
  // #define    RG_CUSTOMERBAR_DSP (CUSTOMERBAR_DSP + RG) /* Reg. Customer BarCode Display    */
  // #define    VD_CUSTOMERBAR_DSP (CUSTOMERBAR_DSP + VD) /* Cor. Customer BarCode Display    */
  // #define    TR_CUSTOMERBAR_DSP (CUSTOMERBAR_DSP + TR) /* Tra. Customer BarCode Display    */
  // #define    SR_CUSTOMERBAR_DSP (CUSTOMERBAR_DSP + SR) /* Scr. Customer BarCode Display    */
  //
  static const UTCNCTWORK_DSP = 0x0C70; // UTcnct Work Display
  static const RG_UTCNCTWORK_DSP = (UTCNCTWORK_DSP + RG); // Reg. UTcnct Work Display
  static const VD_UTCNCTWORK_DSP = (UTCNCTWORK_DSP + VD); // Cor. UTcnct Work Display
  static const TR_UTCNCTWORK_DSP = (UTCNCTWORK_DSP + TR); // Tra. UTcnct Work Display
  static const SR_UTCNCTWORK_DSP = (UTCNCTWORK_DSP + SR); // Scr. UTcnct Work Display

  static const QC_USBCAMERA_DSP = 0x0C80;                 /*  UsbCamera Play Display      */
  static const RG_QC_USBCAMERADSP = (QC_USBCAMERA_DSP + RG); /* Reg. UsbCamera Play Display */
  static const TR_QC_USBCAMERADSP = (QC_USBCAMERA_DSP + TR); /* Tra. UsbCamera Play Display */
  static const VD_QC_USBCAMERADSP = (QC_USBCAMERA_DSP + VD); /* Cor. UsbCamera Play Display */
  static const SR_QC_USBCAMERADSP = (QC_USBCAMERA_DSP + SR); /* Scr. UsbCamera Play Display */
  static const OD_QC_USBCAMERADSP = (QC_USBCAMERA_DSP + OD); /* Ord. UsbCamera Play Display */
  static const IV_QC_USBCAMERADSP = (QC_USBCAMERA_DSP + IV); /* Inv. UsbCamera Play Display */
  static const PD_QC_USBCAMERADSP = (QC_USBCAMERA_DSP + PD); /* Pro. UsbCamera Play Display */
  //
  // #define    QC_USBCAMERA_LISTDSP    0x0C90                 /*  UsbCamera List Display      */
  // #define    RG_QC_USBCAMERALISTDSP (QC_USBCAMERA_LISTDSP + RG) /* Reg. UsbCamera List Display */
  // #define    TR_QC_USBCAMERALISTDSP (QC_USBCAMERA_LISTDSP + TR) /* Tra. UsbCamera List Display */
  // #define    VD_QC_USBCAMERALISTDSP (QC_USBCAMERA_LISTDSP + VD) /* Cor. UsbCamera List Display */
  // #define    SR_QC_USBCAMERALISTDSP (QC_USBCAMERA_LISTDSP + SR) /* Scr. UsbCamera List Display */
  // #define    OD_QC_USBCAMERALISTDSP (QC_USBCAMERA_LISTDSP + OD) /* Ord. UsbCamera List Display */
  // #define    IV_QC_USBCAMERALISTDSP (QC_USBCAMERA_LISTDSP + IV) /* Inv. UsbCamera List Display */
  // #define    PD_QC_USBCAMERALISTDSP (QC_USBCAMERA_LISTDSP + PD) /* Pro. UsbCamera List Display */

  static const QC_PLUADD_DSP = 0x0CA0;                  /* QCashier Plu Add display        */
  static const RG_QC_PLUADD = (QC_PLUADD_DSP + RG);     /* Reg. SG QCashier Plu Add Display  */
  static const TR_QC_PLUADD = (QC_PLUADD_DSP + TR);     /* Tra. SG QCashier Plu Add Display  */

  // #define    JIS1JIS2GT_DSP   0x0CB0
  // #define    RG_JIS1JIS2GT (JIS1JIS2GT_DSP + RG)   /* Reg.  Display */
  // #define    VD_JIS1JIS2GT (JIS1JIS2GT_DSP + VD)   /* Cor.  Display */
  // #define    TR_JIS1JIS2GT (JIS1JIS2GT_DSP + TR)   /* Tra.  Display */
  // #define    SR_JIS1JIS2GT (JIS1JIS2GT_DSP + SR)   /* Scr.  Display */
  //
  // #define    SPCL128BARINP_DSP     0x0CC0         /* Special Disc Bar input Display      */
  // #define    RG_SPCL128BARINP_DSP (SPCL128BARINP_DSP + RG) /* Reg. Special Disc Bar Input Display */
  // #define    VD_SPCL128BARINP_DSP (SPCL128BARINP_DSP + VD) /* Cor. Special Disc Bar Input Display */
  // #define    TR_SPCL128BARINP_DSP (SPCL128BARINP_DSP + TR) /* Tra. Special Disc Bar Input Display */
  // #define    SR_SPCL128BARINP_DSP (SPCL128BARINP_DSP + SR) /* Scr. Special Disc Bar Input Display */
  //
  // #define    MBR_CUSTBMP_DSP 0x0CD0                    /* Mbr Cust bmp Display */
  // #define    RG_MBR_CUSTBMP_DSP (MBR_CUSTBMP_DSP + RG) /* Reg. Mbr Cust bmp Display    */
  // #define    VD_MBR_CUSTBMP_DSP (MBR_CUSTBMP_DSP + VD) /* Cor. Mbr Cust bmp Display    */
  // #define    TR_MBR_CUSTBMP_DSP (MBR_CUSTBMP_DSP + TR) /* Tra. Mbr Cust bmp Display    */
  // #define    SR_MBR_CUSTBMP_DSP (MBR_CUSTBMP_DSP + SR) /* Scr. Mbr Cust bmp Display    */
  //
  static const ACB_STOP_DSP = 0x0CE0;                    /* Acb Stop Display */
  static const RG_ACB_STOP_DSP = (ACB_STOP_DSP + RG); /* Reg. Acb Stop Display    */
  static const VD_ACB_STOP_DSP = (ACB_STOP_DSP + VD); /* Cor. Acb Stop Display    */
  static const TR_ACB_STOP_DSP = (ACB_STOP_DSP + TR); /* Tra. Acb Stop Display    */
  static const SR_ACB_STOP_DSP = (ACB_STOP_DSP + SR); /* Scr. Acb Stop Display    */

  static const QC_PREPAID_READ_DSP = 0x0CF0;                        /* QCashier PrePaid Read Display */
  static const RG_QC_PREPAID_READ = (QC_PREPAID_READ_DSP + RG);     /* Reg. QCashier PrePaid Read Display */
  static const TR_QC_PREPAID_READ = (QC_PREPAID_READ_DSP + TR);     /* Cor. QCashier PrePaid Read Display */

  static const QC_PREPAID_PAY_DSP = 0x0D00;                         /* QCashier PrePaid Pay Display */
  static const RG_QC_PREPAID_PAY = (QC_PREPAID_PAY_DSP + RG);       /* Reg. QCashier PrePaid Pay Display */
  static const TR_QC_PREPAID_PAY = (QC_PREPAID_PAY_DSP + TR);       /* Cor. QCashier PrePaid Pay Display */
  //
  // #define    QC_PREPAID_END_DSP 0x0D10                         /* QCashier PrePaid End Display */
  // #define    RG_QC_PREPAID_END (QC_PREPAID_END_DSP + RG)       /* Reg. QCashier PrePaid End Display */
  // #define    TR_QC_PREPAID_END (QC_PREPAID_END_DSP + TR)       /* Cor. QCashier PrePaid End Display */
  //
  // #define    QC_PREPAID_BAL_DSP 0x0D20                         /* QCashier PrePaid Chage Item Display */
  // #define    RG_QC_PREPAID_BAL (QC_PREPAID_BAL_DSP + RG)       /* Reg. QCashier PrePaid End Display */
  // #define    TR_QC_PREPAID_BAL (QC_PREPAID_BAL_DSP + TR)       /* Cor. QCashier PrePaid End Display */
  //
  // #define    QC_PRECHARGE_ITEM_DSP 0x0D30                      /* QCashier PrePaid Chage Item Display */
  // #define    RG_QC_PRECHARGE_ITEM (QC_PRECHARGE_ITEM_DSP + RG) /* Reg. QCashier PrePaid End Display */
  // #define    TR_QC_PRECHARGE_ITEM (QC_PRECHARGE_ITEM_DSP + TR) /* Cor. QCashier PrePaid End Display */
  //
  // #define    QC_PRECHARGE_READ_DSP 0x0D40                      /* QCashier PrePaid CHARGE Read Display */
  // #define    RG_QC_PRECHARGE_READ (QC_PRECHARGE_READ_DSP + RG) /* Reg. QCashier PrePaid Read Display */
  // #define    TR_QC_PRECHARGE_READ (QC_PRECHARGE_READ_DSP + TR) /* Cor. QCashier PrePaid Read Display */
  //
  // #define    QC_PRECHARGE_PAY_DSP 0x0D50                       /* QCashier PrePaid Chage Pay Display */
  // #define    RG_QC_PRECHARGE_PAY (QC_PRECHARGE_PAY_DSP + RG)   /* Reg. QCashier PrePaid Pay Display */
  // #define    TR_QC_PRECHARGE_PAY (QC_PRECHARGE_PAY_DSP + TR)   /* Cor. QCashier PrePaid Pay Display */
  //
  // #define    QC_PRECHARGE_END_DSP 0x0D60                       /* QCashier PrePaid Chage End Display */
  // #define    RG_QC_PRECHARGE_END (QC_PRECHARGE_END_DSP + RG)   /* Reg. QCashier PrePaid End Display */
  // #define    TR_QC_PRECHARGE_END (QC_PRECHARGE_END_DSP + TR)   /* Cor. QCashier PrePaid End Display */
  //
  // #define    REF_LIST_DSP 0x0D70                    /* Refund List Display */
  // #define    RG_REF_LIST_DSP (REF_LIST_DSP + RG) /* Reg. Refund List Display    */
  // #define    VD_REF_LIST_DSP (REF_LIST_DSP + VD) /* Cor. Refund List Display    */
  // #define    TR_REF_LIST_DSP (REF_LIST_DSP + TR) /* Tra. Refund List Display    */
  // #define    SR_REF_LIST_DSP (REF_LIST_DSP + SR) /* Scr. Refund List Display    */
  //
  static const CASHRECYCLE_DSP = 0x0D80;
  static const RG_CASHRECYCLE = (CASHRECYCLE_DSP + RG);   /* Reg. CashRecycle Display */
  static const VD_CASHRECYCLE = (CASHRECYCLE_DSP + VD);   /* Cor. CashRecycle Display */
  static const TR_CASHRECYCLE = (CASHRECYCLE_DSP + TR);   /* Tra. CashRecycle Display */
  static const SR_CASHRECYCLE = (CASHRECYCLE_DSP + SR);   /* Scr. CashRecycle Display */

  static const CHG_ASSORT_PLU_DSP = 0x0D90;                    /* Chang Assort Plu Display */
  static const RG_CHG_ASSORT_PLU_DSP = (CHG_ASSORT_PLU_DSP + RG); /* Reg. Chang Assort Plu Display */
  static const VD_CHG_ASSORT_PLU_DSP = (CHG_ASSORT_PLU_DSP + VD); /* Cor. Chang Assort Plu Display */
  static const TR_CHG_ASSORT_PLU_DSP = (CHG_ASSORT_PLU_DSP + TR); /* Tra. Chang Assort Plu Display */
  static const SR_CHG_ASSORT_PLU_DSP = (CHG_ASSORT_PLU_DSP + SR); /* Scr. Chang Assort Plu Display */

  static const PITAPA_DSP = 0x0DA0;            /* PiTaPa R/W Display      */
  static const RG_PITAPA = (PITAPA_DSP + RG);  /* Reg. PiTaPa R/W Display */
  static const VD_PITAPA = (PITAPA_DSP + VD);  /* Cor. PiTaPa R/W Display */
  static const TR_PITAPA = (PITAPA_DSP + TR);  /* Tra. PiTaPa R/W Display */
  static const SR_PITAPA = (PITAPA_DSP + SR);  /* Scr. PiTaPa R/W Display */

  static const QR_RPR_DSP = 0x0DB0;                /* QR Re Print Display      */
  static const RG_QR_RPR = (QR_RPR_DSP + RG);      /* Reg. QR Re Print Display */
  static const VD_QR_RPR = (QR_RPR_DSP + VD);      /* Cor. QR Re Print Display */
  static const TR_QR_RPR = (QR_RPR_DSP + TR);      /* Tra. QR Re Print Display */
  static const SR_QR_RPR = (QR_RPR_DSP + SR);      /* Scr. QR Re Print Display */

  static const MBR_PRN_DSP = 0x0DC0;               /* Member Print Display      */
  static const RG_MBR_PRN = (MBR_PRN_DSP + RG);    /* Reg. Member Print Display */
  static const VD_MBR_PRN = (MBR_PRN_DSP + VD);    /* Cor. Member Print Display */
  static const TR_MBR_PRN = (MBR_PRN_DSP + TR);    /* Tra. Member Print Display */
  static const SR_MBR_PRN = (MBR_PRN_DSP + SR);    /* Scr. Member Print Display */

  static const SQRC_STAFF_DSP = 0x0DD0;                 /* SQRC Staff Calling display       */
  static const RG_SQRC_STAFF = (SQRC_STAFF_DSP + RG);   /* Reg. SQRC Staff Calling Display  */
  static const TR_SQRC_STAFF = (SQRC_STAFF_DSP + TR);   /* Tra. SQRC Staff Calling Display  */

  static const SQRC_PASWD_DSP = 0x0DE0;                 /* SQRC Pass Ward display       */
  static const RG_SQRC_PASWD = (SQRC_PASWD_DSP + RG);   /* Reg. SQRC Pass Ward Display  */
  static const TR_SQRC_PASWD = (SQRC_PASWD_DSP + TR);   /* Tra. SQRC Pass Ward Display  */

  static const CHGCHK_DSP = 0x0DF0;			/* Changer Check Display      */
  static const RG_CHGCHK_DSP = (CHGCHK_DSP + RG);	/* Reg. Changer Check Display */
  static const VD_CHGCHK_DSP = (CHGCHK_DSP + VD);	/* Cor. Changer Check Display */
  static const TR_CHGCHK_DSP = (CHGCHK_DSP + TR);	/* Tra. Changer Check Display */
  static const SR_CHGCHK_DSP = (CHGCHK_DSP + SR);	/* Scr. Changer Check Display */

  static const PRECA_DSP = 0x0E00;		/* Preca Card Scan Display      */
  static const RG_PRECA_DSP = (PRECA_DSP + RG);	/* Reg. Preca Card Scan Display */
  static const VD_PRECA_DSP = (PRECA_DSP + VD);	/* Cor. Preca Card Scan Display */
  static const TR_PRECA_DSP = (PRECA_DSP + TR);	/* Tra. Preca Card Scan Display */
  static const SR_PRECA_DSP = (PRECA_DSP + SR);	/* Scr. Preca Card Scan Display */
  static const PRECAVOID_DSP = 0x0E10;		/* Preca Void Display      */
  static const RG_PRECAVOID = (PRECAVOID_DSP + RG);	/* Reg. Preca Void Display */
  static const VD_PRECAVOID = (PRECAVOID_DSP + VD);	/* Cor. Preca Void Display */
  static const TR_PRECAVOID = (PRECAVOID_DSP + TR);	/* Tra. Preca Void Display */
  static const SR_PRECAVOID = (PRECAVOID_DSP + SR);	/* Scr. Preca Void Display */
  static const int PRECAVOIDS_DSP = 0x0E20;		/* PrecaVoid Subtotal Display       */
  static const int RG_PRECAVOIDS = (PRECAVOIDS_DSP + RG);	/* Reg. PrecaVoid Subtotal Display */
  static const int VD_PRECAVOIDS = (PRECAVOIDS_DSP + VD);	/* Cor. PrecaVoid Subtotal Display */
  static const int TR_PRECAVOIDS = (PRECAVOIDS_DSP + TR);	/* Tra. PrecaVoid Subtotal Display */
  static const int SR_PRECAVOIDS = (PRECAVOIDS_DSP + SR);	/* Scr. PrecaVoid Subtotal Display */
  static const int PRECAVOIDI_DSP = 0x0E30;		/* PrecaVoid SubItem Display       */
  static const int RG_PRECAVOIDI = (PRECAVOIDI_DSP + RG);	/* Reg. PrecaVoid SubItem Display  */
  static const int VD_PRECAVOIDI = (PRECAVOIDI_DSP + VD);	/* Cor. PrecaVoid SubItem Display  */
  static const int TR_PRECAVOIDI = (PRECAVOIDI_DSP + TR);	/* Tra. PrecaVoid SubItem Display  */
  static const int SR_PRECAVOIDI = (PRECAVOIDI_DSP + SR);	/* Scr. PrecaVoid SubItem Display  */

//   #define    STL_COUPON_DSP 0x0E40                   /* Subtotal Coupon Display */
//   #define    RG_STL_COUPON_DSP (STL_COUPON_DSP + RG) /* Reg. Subtotal Coupon Display    */
//   #define    VD_STL_COUPON_DSP (STL_COUPON_DSP + VD) /* Cor. Subtotal Coupon Display    */
//   #define    TR_STL_COUPON_DSP (STL_COUPON_DSP + TR) /* Tra. Subtotal Coupon Display    */
//   #define    SR_STL_COUPON_DSP (STL_COUPON_DSP + SR) /* Scr. Subtotal Coupon Display    */

  static const SUICA_DSP = 0x0E50;           /* Suica Input Display        */
  static const RG_SUICA = (SUICA_DSP + RG);  /* Reg. Suica Input Display   */
  static const VD_SUICA = (SUICA_DSP + VD);  /* Cor. Suica Input Display   */
  static const TR_SUICA = (SUICA_DSP + TR);  /* Tra. Suica Input Display   */
  static const SR_SUICA = (SUICA_DSP + SR);  /* Scr. Suica Input Display   */

//   #define    PLUQTYCONF_DSP 0x0E60
//   #define    RG_PLUQTYCONF (PLUQTYCONF_DSP + RG)  /* Reg. Suica Input Display   */
//   #define    VD_PLUQTYCONF (PLUQTYCONF_DSP + VD)  /* Cor. Suica Input Display   */
//   #define    TR_PLUQTYCONF (PLUQTYCONF_DSP + TR)  /* Tra. Suica Input Display   */
//   #define    SR_PLUQTYCONF (PLUQTYCONF_DSP + SR)  /* Scr. Suica Input Display   */
//
//   #define    REPICA_DSP      0x0E70		/* Repica Card Scan Display      */
//   #define    RG_REPICA_DSP  (REPICA_DSP + RG)	/* Reg. Repica Card Scan Display */
//   #define    VD_REPICA_DSP  (REPICA_DSP + VD)	/* Cor. Repica Card Scan Display */
//   #define    TR_REPICA_DSP  (REPICA_DSP + TR)	/* Tra. Repica Card Scan Display */
//   #define    SR_REPICA_DSP  (REPICA_DSP + SR)	/* Scr. Repica Card Scan Display */
//   #define    REPICA_TC_DSP      0x0E80			/* Repica Transfer Card Display      */
//   #define    RG_REPICA_TC_DSP  (REPICA_TC_DSP + RG)	/* Reg. Repica Transfer Card Display */
//   #define    VD_REPICA_TC_DSP  (REPICA_TC_DSP + VD)	/* Cor. Repica Transfer Card Display */
//   #define    TR_REPICA_TC_DSP  (REPICA_TC_DSP + TR)	/* Tra. Repica Transfer Card Display */
//   #define    SR_REPICA_TC_DSP  (REPICA_TC_DSP + SR)	/* Scr. Repica Transfer Card Display */
//
//   #define    MARUTOSLIT_DSP       0x0E90			/* Maruto Input Slitcd Input Display        */
//   #define    RG_MARUTOSLIT_DSP (MARUTOSLIT_DSP + RG)	/* Reg. Maruto Input Slitcd Input Display   */
//   #define    VD_MARUTOSLIT_DSP (MARUTOSLIT_DSP + VD)	/* Cor. Maruto Input Slitcd Input Display   */
//   #define    TR_MARUTOSLIT_DSP (MARUTOSLIT_DSP + TR)	/* Tra. Maruto Input Slitcd Input Display   */
//   #define    SR_MARUTOSLIT_DSP (MARUTOSLIT_DSP + SR)	/* Scr. Maruto Input Slitcd Input Display   */
//
//   #define    CHK_STF_DSP		0x0EA0		/* Check Staff No. Input Display */
//   #define    RG_CHK_STF_DSP  (CHK_STF_DSP + RG)	/* Reg. Check Staff No. Input Display */
//   #define    VD_CHK_STF_DSP  (CHK_STF_DSP + VD)	/* Cor. Check Staff No. Input Display */
//   #define    TR_CHK_STF_DSP  (CHK_STF_DSP + TR)	/* Tra. Check Staff No. Input Display */
//   #define    SR_CHK_STF_DSP  (CHK_STF_DSP + SR)	/* Scr. Check Staff No. Input Display */
//
//   #define    COGCA_DSP      0x0EB0		/* Cogca Card Scan Display      */
//   #define    RG_COGCA_DSP  (COGCA_DSP + RG)	/* Reg. Cogca Card Scan Display */
//   #define    VD_COGCA_DSP  (COGCA_DSP + VD)	/* Cor. Cogca Card Scan Display */
//   #define    TR_COGCA_DSP  (COGCA_DSP + TR)	/* Tra. Cogca Card Scan Display */
//   #define    SR_COGCA_DSP  (COGCA_DSP + SR)	/* Scr. Cogca Card Scan Display */
//
//   #define    TCARD_CHK_DSP	0x0EC0			/* Tpoint Card Check Display */
//   #define    RG_TCARD_CHK_DSP  (TCARD_CHK_DSP + RG)	/* Reg. Tpoint Card Check Display */
//   #define    VD_TCARD_CHK_DSP  (TCARD_CHK_DSP + VD)	/* Cor. Tpoint Card Check Display */
//   #define    TR_TCARD_CHK_DSP  (TCARD_CHK_DSP + TR)	/* Tra. Tpoint Card Check Display */
//   #define    SR_TCARD_CHK_DSP  (TCARD_CHK_DSP + SR)	/* Scr. Tpoint Card Check Display */
//
//   #define    COGCA_MI_DSP      0x0ED0		/* Cogca Card Manual Input Display      */
//   #define    RG_COGCA_MI_DSP  (COGCA_MI_DSP + RG)	/* Reg. Cogca Card Manual Input Display */
//   #define    VD_COGCA_MI_DSP  (COGCA_MI_DSP + VD)	/* Cor. Cogca Card Manual Input Display */
//   #define    TR_COGCA_MI_DSP  (COGCA_MI_DSP + TR)	/* Tra. Cogca Card Manual Input Display */
//   #define    SR_COGCA_MI_DSP  (COGCA_MI_DSP + SR)	/* Scr. Cogca Card Manual Input Display */
//
  static const CHARGESLIP_CHK_DSP	= 0x0EE0;				//売掛伝票印字確認画面 アヤハディオ様売掛伝票対応
  static const RG_CHARGESLIP_CHK_DSP = (CHARGESLIP_CHK_DSP + RG);	//登録：売掛伝票印字確認画面
  static const VD_CHARGESLIP_CHK_DSP = (CHARGESLIP_CHK_DSP + VD);	//訂正：売掛伝票印字確認画面
  static const TR_CHARGESLIP_CHK_DSP = (CHARGESLIP_CHK_DSP + TR);	//訓練：売掛伝票印字確認画面
  static const SR_CHARGESLIP_CHK_DSP = (CHARGESLIP_CHK_DSP + SR);	//廃棄：売掛伝票印字確認画面
//
  static const DELIV_SVC_DSP = 0x0EF0;					/* 宅配発行キー 画面モード *//* アヤハディオ様宅配発行対応 */
  static const RG_DELIV_SVC_DSP	= (DELIV_SVC_DSP + RG);	/* 登録 宅配発行キー 画面モード */
  static const VD_DELIV_SVC_DSP	= (DELIV_SVC_DSP + VD);	/* 訂正 宅配発行キー 画面モード */
  static const TR_DELIV_SVC_DSP	= (DELIV_SVC_DSP + TR);	/* 訓練 宅配発行キー 画面モード */
  static const SR_DELIV_SVC_DSP	= (DELIV_SVC_DSP + SR);	/* 廃棄 宅配発行キー 画面モード */

  /* 宅配発行キー関連項目 */
  static const DELIV_SVCS_DSP	= 0x0F00;					/* 宅配発行キー 画面モード 小計画面 *//* アヤハディオ様宅配発行対応 */
  static const RG_DELIV_SVCS_DSP = DELIV_SVCS_DSP + RG;	/* 登録 宅配発行キー 小計画面モード */
  static const VD_DELIV_SVCS_DSP = DELIV_SVCS_DSP + VD;	/* 訂正 宅配発行キー 小計画面モード */
  static const TR_DELIV_SVCS_DSP = DELIV_SVCS_DSP + TR;	/* 訓練 宅配発行キー 小計画面モード */
  static const SR_DELIV_SVCS_DSP = DELIV_SVCS_DSP + SR;	/* 廃棄 宅配発行キー 小計画面モード */

  static const QC_CHARGE_ITEM_SLECT_DSP = 0x0F30; /* QCashier チャージ商品選択画面 */
  static const RG_QC_CHARGE_ITEM_SLECT_DSP = (QC_CHARGE_ITEM_SLECT_DSP + RG); /* 登録モード：QCashier チャージ商品選択画面 */
  static const TR_QC_CHARGE_ITEM_SLECT_DSP = (QC_CHARGE_ITEM_SLECT_DSP + TR); /* 訓練モード：QCashier チャージ商品選択画面 */

  static const YUMECA_POL_DSP = 0x0F10;           /* yumeca_pol Card Scan Display      */
  static const RG_YUMECA_POL_DSP = (YUMECA_POL_DSP + RG);     /* Reg. yumeca_pol Card Scan Display */
  static const VD_YUMECA_POL_DSP = (YUMECA_POL_DSP + VD);     /* Cor. yumeca_pol Card Scan Display */
  static const TR_YUMECA_POL_DSP = (YUMECA_POL_DSP + TR);     /* Tra. yumeca_pol Card Scan Display */
  static const SR_YUMECA_POL_DSP = (YUMECA_POL_DSP + SR);     /* Scr. yumeca_pol Card Scan Display */

//
//   #define QC_NIMOCA_YES_NO_DSP 0x0F40 /* QCashier ★ニモカ、クレニモカ所有確認画面 */
//   #define RG_QC_NIMOCA_YES_NO_DSP (QC_NIMOCA_YES_NO_DSP + RG) /* 登録モード：QCashier ★ニモカ、クレニモカ所有確認画面 */
//   #define TR_QC_NIMOCA_YES_NO_DSP (QC_NIMOCA_YES_NO_DSP + TR) /* 訓練モード：QCashier ★ニモカ、クレニモカ所有確認画面 */
//
//   #define QC_CHARGE_YES_NO_DSP 0x0F50 /* QCashier チャージする、しない確認画面 */
//   #define RG_QC_CHARGE_YES_NO_DSP (QC_CHARGE_YES_NO_DSP + RG) /* 登録モード：QCashier チャージする、しない確認画面 */
//   #define TR_QC_CHARGE_YES_NO_DSP (QC_CHARGE_YES_NO_DSP + TR) /* 訓練モード：QCashier チャージする、しない確認画面 */
//
//   #define QC_PAYLACK_YES_NO_DSP 0x0F60 /* QCashier 残額不足時、不足額を現金で支払うかどうか確認画面 */
//   #define RG_QC_PAYLACK_YES_NO_DSP (QC_PAYLACK_YES_NO_DSP + RG) /* 登録モード：QCashier 残額不足時、不足額を現金で支払うかどうか確認画面 */
//   #define TR_QC_PAYLACK_YES_NO_DSP (QC_PAYLACK_YES_NO_DSP + TR) /* 訓練モード：QCashier 残額不足時、不足額を現金で支払うかどうか確認画面 */
//
//   #define QC_RECEIPT_SELECT_DSP 0x0F70 /* QCashier 取引レシートまたは、領収書のどちらを発行するか確認する画面 */
//   #define RG_QC_RECEIPT_SELECT_DSP (QC_RECEIPT_SELECT_DSP + RG) /* 登録モード：QCashier 取引レシートまたは、領収書のどちらを発行するか確認する画面 */
//   #define TR_QC_RECEIPT_SELECT_DSP (QC_RECEIPT_SELECT_DSP + TR) /* 訓練モード：QCashier 取引レシートまたは、領収書のどちらを発行するか確認する画面 */
//
//   #define QC_NOT_NIMOCA_DSP 0x0F80 /* QCashier ニモカカードではありません画面 */
//   #define RG_QC_NOT_NIMOCA_DSP (QC_NOT_NIMOCA_DSP + RG) /* 登録モード：QCashier ニモカカードではありません画面 */
//   #define TR_QC_NOT_NIMOCA_DSP (QC_NOT_NIMOCA_DSP + TR) /* 訓練モード：QCashier ニモカカードではありません画面 */
//
//   #define    QC_LANG_SLCT_DSP 0x0FA0	 /* 言語選択画面 */
//   #define    RG_QC_LANG_SLCT_DSP  (QC_LANG_SLCT_DSP + RG)       /* 登録モード : 言語選択画面 */
//   #define    TR_QC_LANG_SLCT_DSP  (QC_LANG_SLCT_DSP + TR)       /* 訓練モード : 言語選択画面 */
//
//   #define    VALUECARD_DSP      0x0FB0		/* ValueCard Card Scan Display      */
//   #define    RG_VALUECARD_DSP  (VALUECARD_DSP + RG)	/* Reg. ValueCard Card Scan Display */
//   #define    VD_VALUECARD_DSP  (VALUECARD_DSP + VD)	/* Cor. ValueCard Card Scan Display */
//   #define    TR_VALUECARD_DSP  (VALUECARD_DSP + TR)	/* Tra. ValueCard Card Scan Display */
//   #define    SR_VALUECARD_DSP  (VALUECARD_DSP + SR)	/* Scr. ValueCard Card Scan Display */
//
//   #define    VALUECARD_MI_DSP      0x0FC0		/* ValueCard Card Manual Input Display      */
//   #define    RG_VALUECARD_MI_DSP  (VALUECARD_MI_DSP + RG)	/* Reg. ValueCard Card Manual Input Display */
//   #define    VD_VALUECARD_MI_DSP  (VALUECARD_MI_DSP + VD)	/* Cor. ValueCard Card Manual Input Display */
//   #define    TR_VALUECARD_MI_DSP  (VALUECARD_MI_DSP + TR)	/* Tra. ValueCard Card Manual Input Display */
//   #define    SR_VALUECARD_MI_DSP  (VALUECARD_MI_DSP + SR)	/* Scr. ValueCard Card Manual Input Display */
//
//   #define    L22DSCBAR_DSP      0x0FE0		/* 22桁値下バーコード入力画面 */
//   #define    RG_L22DSCBAR_DSP  (L22DSCBAR_DSP + RG)       /* 登録モード 22桁値下バーコード入力画面 */
//   #define    VD_L22DSCBAR_DSP  (L22DSCBAR_DSP + VD)       /* 訂正モード 22桁値下バーコード入力画面 */
//   #define    TR_L22DSCBAR_DSP  (L22DSCBAR_DSP + TR)       /* 訓練モード 22桁値下バーコード入力画面 */
//   #define    SR_L22DSCBAR_DSP  (L22DSCBAR_DSP + SR)	/* 廃棄モード 22桁値下バーコード入力画面 */
//
//   #define    COMPOINT_ENT_DSP      0x1030				/* ポイント利用画面[共通ポイント向け] */
//   #define    RG_COMPOINT_ENT_DSP  (COMPOINT_ENT_DSP + RG)		/* 登録モード ポイント利用画面 */
//   #define    TR_COMPOINT_ENT_DSP  (COMPOINT_ENT_DSP + TR)		/* 訓練モード ポイント利用画面 */
//
//   #define    CHGGOODS_DSP        0x1040				/* 指定商品データ変更画面 */
//   #define    RG_CHGGOODS        (CHGGOODS_DSP + RG)		/* 登録モード 指定商品データ変更画面 */
//   #define    VD_CHGGOODS        (CHGGOODS_DSP + VD)		/* 訂正モード 指定商品データ変更画面 */
//   #define    TR_CHGGOODS        (CHGGOODS_DSP + TR)		/* 訓練モード 指定商品データ変更画面 */
//   #define    SR_CHGGOODS        (CHGGOODS_DSP + SR)		/* 廃棄モード 指定商品データ変更画面 */
//
//   #if 0	// 15Ver.専用の画面番号へ移動
//   #define    AJS_EMONEY_DSP      0x1050		/* AJS_EMONEY Card Scan Display      */
//   #define    RG_AJS_EMONEY_DSP  (AJS_EMONEY_DSP + RG)	/* Reg. AJS_EMONEY Card Scan Display */
//   #define    VD_AJS_EMONEY_DSP  (AJS_EMONEY_DSP + VD)	/* Cor. AJS_EMONEY Card Scan Display */
//   #define    TR_AJS_EMONEY_DSP  (AJS_EMONEY_DSP + TR)	/* Tra. AJS_EMONEY Card Scan Display */
//   #define    SR_AJS_EMONEY_DSP  (AJS_EMONEY_DSP + SR)	/* Scr. AJS_EMONEY Card Scan Display */
//
//   #define    AJS_EMONEY_MI_DSP      0x1060		/* AJS_EMONEY Card Manual Input Display      */
//   #define    RG_AJS_EMONEY_MI_DSP  (AJS_EMONEY_MI_DSP + RG)	/* Reg. AJS_EMONEY Card Manual Input Display */
//   #define    VD_AJS_EMONEY_MI_DSP  (AJS_EMONEY_MI_DSP + VD)	/* Cor. AJS_EMONEY Card Manual Input Display */
//   #define    TR_AJS_EMONEY_MI_DSP  (AJS_EMONEY_MI_DSP + TR)	/* Tra. AJS_EMONEY Card Manual Input Display */
//   #define    SR_AJS_EMONEY_MI_DSP  (AJS_EMONEY_MI_DSP + SR)	/* Scr. AJS_EMONEY Card Manual Input Display */
//   #endif	// 15Ver.専用の画面番号へ移動
//
//   #define    LANGCHG_SLCT_DSP      0x1080				/* 対面セルフ用言語選択画面 */
//   #define    RG_LANGCHG_SLCT_DSP   (LANGCHG_SLCT_DSP + RG)	/* 登録モード 対面セルフ用言語選択画面 */
//   #define    TR_LANGCHG_SLCT_DSP   (LANGCHG_SLCT_DSP + TR)	/* 訓練モード 対面セルフ用言語選択画面 */
//

  static const NEC_EMONEY_DSP = 0x10B0;			/* NEC電子マネー カードスキャン画面 */
  static const RG_NEC_EMONEY_DSP = (NEC_EMONEY_DSP + RG);	/* 登録モード NEC電子マネー カードスキャン画面 */
  static const VD_NEC_EMONEY_DSP = (NEC_EMONEY_DSP + VD);	/* 訂正モード NEC電子マネー カードスキャン画面 */
  static const TR_NEC_EMONEY_DSP = (NEC_EMONEY_DSP + TR);	/* 訓練モード NEC電子マネー カードスキャン画面 */
  static const SR_NEC_EMONEY_DSP = (NEC_EMONEY_DSP + SR);	/* 廃棄モード NEC電子マネー カードスキャン画面 */

  static const CHGSELECTITEMS_DSP = 0x10C0;			/* 指定商品データ変更画面      */
  static const RG_CHGSELECTITEMS = (CHGSELECTITEMS_DSP + RG);	/* 登録モード 指定商品データ変更画面 */
  static const VD_CHGSELECTITEMS = (CHGSELECTITEMS_DSP + VD);	/* 訂正モード 指定商品データ変更画面 */
  static const TR_CHGSELECTITEMS = (CHGSELECTITEMS_DSP + TR);	/* 訓練モード 指定商品データ変更画面 */
  static const SR_CHGSELECTITEMS = (CHGSELECTITEMS_DSP + SR);	/* 廃棄モード 指定商品データ変更画面 */

  static const QC_NEC_EMONEY_DSP =	0x1130;				/* QCashier NEC Emoney Display */
  static const RG_QC_NEC_EMONEY	= (QC_NEC_EMONEY_DSP + RG);	/* Reg. SG QCashier NEC Emoney Display  */
  static const TR_QC_NEC_EMONEY	= (QC_NEC_EMONEY_DSP + TR);	/* Tra. SG QCashier NEC Emoney Display  */

  static const QC_NEC_EMONEY_USE_DSP = 0x1140;				/* QCashier NEC Emoney Use Display */
  static const RG_QC_NEC_EMONEY_USE = (QC_NEC_EMONEY_USE_DSP + RG);	/* Reg. SG QCashier NEC Emoney Use Display  */
  static const TR_QC_NEC_EMONEY_USE = (QC_NEC_EMONEY_USE_DSP + TR);	/* Tra. SG QCashier NEC Emoney Use Display  */

  static const QC_NEC_EMONEY_PAY_END_DSP = 0x1150;					/* QCashier NEC Emoney Pay End Display */
  static const RG_QC_NEC_EMONEY_PAY_END = (QC_NEC_EMONEY_PAY_END_DSP + RG);	/* Reg. SG QCashier NEC Emoney Pay End Display  */
  static const TR_QC_NEC_EMONEY_PAY_END = (QC_NEC_EMONEY_PAY_END_DSP + TR);	/* Tra. SG QCashier NEC Emoney Pay End Display  */

//   #define    CRDTVOID_VEGADATE_DSP 0x1160			          /* CrdtVoid VEGA3000 Void_Date Display       */
//   #define    RG_CRDTVOID_VEGADATE_DSP  (CRDTVOID_VEGADATE_DSP + RG) /* Reg. CrdtVoid VEGA3000 Void_Date Display  */
//   #define    VD_CRDTVOID_VEGADATE_DSP  (CRDTVOID_VEGADATE_DSP + VD) /* Cor. CrdtVoid VEGA3000 Void_Date Display  */
//   #define    TR_CRDTVOID_VEGADATE_DSP  (CRDTVOID_VEGADATE_DSP + TR) /* Tra. CrdtVoid VEGA3000 Void_Date Display  */
//   #define    SR_CRDTVOID_VEGADATE_DSP  (CRDTVOID_VEGADATE_DSP + SR) /* Scr. CrdtVoid VEGA3000 Void_Date Display  */
//
  static const CAT_CARDREAD_DSP = 0x1170;				/* 端末カード読込キー カード読込画面 */
  static const RG_CAT_CARDREAD_DSP = (CAT_CARDREAD_DSP + RG);		/* 登録モード 端末カード読込キー カード読込画面 */
  static const VD_CAT_CARDREAD_DSP = (CAT_CARDREAD_DSP + VD);		/* 訂正モード 端末カード読込キー カード読込画面 */
  static const TR_CAT_CARDREAD_DSP = (CAT_CARDREAD_DSP + TR);		/* 訓練モード 端末カード読込キー カード読込画面 */
  static const SR_CAT_CARDREAD_DSP = (CAT_CARDREAD_DSP + SR);		/* 廃棄モード 端末カード読込キー カード読込画面 */

  static const QC_PREPAID_BALANCESHORT_DSP = 0x1180;					/* QCashier PrePaid BalanceShort Display */
  static const RG_QC_PREPAID_BALANCESHORT = (QC_PREPAID_BALANCESHORT_DSP + RG);	/* Reg. QCashier PrePaid BalanceShort Display */
  static const TR_QC_PREPAID_BALANCESHORT = (QC_PREPAID_BALANCESHORT_DSP + TR);	/* Tra. QCashier PrePaid BalanceShort Display */

  static const QC_PREPAID_ENTRY_DSP = 0x1190;						/* QCashier PrePaid Entry Display */
  static const RG_QC_PREPAID_ENTRY = (QC_PREPAID_ENTRY_DSP + RG);			/* Reg. QCashier PrePaid Entry Display */
  static const TR_QC_PREPAID_ENTRY = (QC_PREPAID_ENTRY_DSP + TR);			/* Tra. QCashier PrePaid Entry Display */
//
//   #define    BCDPAY_DSP      0x11B0		/* Barcode Pay Scan Display      */
//   #define    RG_BCDPAY_DSP  (BCDPAY_DSP + RG)	/* Reg. Barcode Pay Scan Display */
//   #define    VD_BCDPAY_DSP  (BCDPAY_DSP + VD)	/* Cor. Barcode Pay Scan Display */
//   #define    TR_BCDPAY_DSP  (BCDPAY_DSP + TR)	/* Tra. Barcode Pay Scan Display */
//   #define    SR_BCDPAY_DSP  (BCDPAY_DSP + SR)	/* Scr. Barcode Pay Scan Display */
//
//   #define    BCDPAY_MI_DSP      0x11C0		/* Barcode Pay Manual Input Display      */
//   #define    RG_BCDPAY_MI_DSP  (BCDPAY_MI_DSP + RG)	/* Reg. Barcode Pay Manual Input Display */
//   #define    VD_BCDPAY_MI_DSP  (BCDPAY_MI_DSP + VD)	/* Cor. Barcode Pay Manual Input Display */
//   #define    TR_BCDPAY_MI_DSP  (BCDPAY_MI_DSP + TR)	/* Tra. Barcode Pay Manual Input Display */
//   #define    SR_BCDPAY_MI_DSP  (BCDPAY_MI_DSP + SR)	/* Scr. Barcode Pay Manual Input Display */
//
  static const WIZ_RENT_DSP = 0x1250;			/* Wiz Rental Display      */
  static const RG_WIZ_RENT_DSP = (WIZ_RENT_DSP + RG);		/* Reg. Wiz Rental Display */
  static const VD_WIZ_RENT_DSP = (WIZ_RENT_DSP + VD);		/* Cor. Wiz Rental Display */
  static const TR_WIZ_RENT_DSP = (WIZ_RENT_DSP + TR);		/* Tra. Wiz Rental Display */
  static const SR_WIZ_RENT_DSP = (WIZ_RENT_DSP + SR);		/* Scr. Wiz Rental Display */

  static const BCDPAY_QR_DSP = 0x1260;		/* Barcode Pay QR Display      */
  static const RG_BCDPAY_QR_DSP = (BCDPAY_QR_DSP  + RG);	/* Reg. Barcode Pay QR Display */
  static const VD_BCDPAY_QR_DSP = (BCDPAY_QR_DSP + VD);	/* Cor. Barcode Pay QR Display */
  static const TR_BCDPAY_QR_DSP = (BCDPAY_QR_DSP + TR);	/* Tra. Barcode Pay QR Display */
  static const SR_BCDPAY_QR_DSP = (BCDPAY_QR_DSP + SR);	/* Scr. Barcode Pay QR Display */

  static const QC_BCDPAY_READ_DSP = 0x1320;                        /* QCashier Barcode Read Display */
  static const RG_QC_BCDPAY_READ = (QC_BCDPAY_READ_DSP + RG);     /* Reg. QCashier Barcode Read Display */
  static const TR_QC_BCDPAY_READ = (QC_BCDPAY_READ_DSP + TR);     /* Tra. QCashier Barcode Read Display */

  static const QC_BCDPAY_END_DSP = 0x1330;                     /* QCashier Pay End Display */
  static const RG_QC_BCDPAY_END = (QC_BCDPAY_END_DSP + RG);       /* Reg. QCashier Pay End Display */
  static const TR_QC_BCDPAY_END = (QC_BCDPAY_END_DSP + TR);       /* Tar. QCashier Pay End Display */

  static const QC_BCDPAY_QR_READ_DSP = 0x1340;                   /* QCashier QR Read Display */
  static const RG_QC_BCDPAY_QR_READ = (QC_BCDPAY_QR_READ_DSP + RG);     /* Reg. QCashier QR Read Display */
  static const TR_QC_BCDPAY_QR_READ = (QC_BCDPAY_QR_READ_DSP + TR);     /* Tar. QCashier QR Read Display */

  static const QC_BCDPAY_BALANCESHORT_DSP = 0x1350;                          /* QCashier Pay BalanceShort Display */
  static const RG_QC_BCDPAY_BALANCESHORT = (QC_BCDPAY_BALANCESHORT_DSP + RG);        /* Reg. QCashier Pay BalanceShort Display */
  static const TR_QC_BCDPAY_BALANCESHORT = (QC_BCDPAY_BALANCESHORT_DSP + TR);        /* Tar. QCashier Pay BalanceShort Display */

//   #define    QC_ANYCUST_CARDSELECT_DSP	0x1360					/* QCashier ポイントカード種類選択画面 */
//   #define    RG_QC_ANYCUST_CARDSELECT_DSP (QC_ANYCUST_CARDSELECT_DSP + RG)	/* 登録モード QCashier ポイントカード種類選択画面 */
//   #define    TR_QC_ANYCUST_CARDSELECT_DSP (QC_ANYCUST_CARDSELECT_DSP + TR)	/* 訓練モード QCashier ポイントカード種類選択画面 */
//
  static const QC_ANYCUST_CARDREAD_DSP = 0x1370;					/* QCashier ポイントカード読込画面 */
  static const RG_QC_ANYCUST_CARDREAD_DSP = (QC_ANYCUST_CARDREAD_DSP + RG);	/* 登録モード QCashier ポイントカード読込画面 */
  static const TR_QC_ANYCUST_CARDREAD_DSP = (QC_ANYCUST_CARDREAD_DSP + TR);	/* 訓練モード QCashier ポイントカード読込画面 */

  static const SG_PRECA_NONMBR_DSP = 0x13A0;					/* SG CoGCa NonMbr Display      */
  static const RG_SG_PRECA_NONMBR = (SG_PRECA_NONMBR_DSP + RG);		/* Reg. SG CoGCa NonMbr Display */
  static const TR_SG_PRECA_NONMBR = (SG_PRECA_NONMBR_DSP + TR);		/* Tra. SG CoGCa NonMbr Display */
//
//   #define    BCDPAY_CONF_DSP      0x13D0		/* Barcode Pay Conf Display      */
//   #define    RG_BCDPAY_CONF_DSP  (BCDPAY_CONF_DSP + RG)	/* Reg. Barcode Pay Conf Display */
//   #define    VD_BCDPAY_CONF_DSP  (BCDPAY_CONF_DSP + VD)	/* Cor. Barcode Pay Conf Display */
//   #define    TR_BCDPAY_CONF_DSP  (BCDPAY_CONF_DSP + TR)	/* Tra. Barcode Pay Conf Display */
//   #define    SR_BCDPAY_CONF_DSP  (BCDPAY_CONF_DSP + SR)	/* Scr. Barcode Pay Conf Display */
//
  static const PASSPORTINFO_DSP = 0x1460; /* 旅券情報入力画面 */
  static const RG_PASSPORTINFO_DSP = (PASSPORTINFO_DSP + RG); /* 登録モード 旅券情報入力画面 */
  static const TR_PASSPORTINFO_DSP = (PASSPORTINFO_DSP + TR); /* 訓練モード 旅券情報入力画面 */
//
//   #define    QC_MBR_N_SLCT_DSP 0x14B0				/* Shop&Go仕様　ニシムタ様　会員カード有無画面      */
//   #define    RG_QC_MBR_N_SLCT (QC_MBR_N_SLCT_DSP + RG)		/* 登録モード Shop&Go仕様　ニシムタ様　会員カード有無画面      */
//   #define    TR_QC_MBR_N_SLCT (QC_MBR_N_SLCT_DSP + TR)		/* 訓練モード Shop&Go仕様　ニシムタ様　会員カード有無画面      */

  static const QC_MBR_N_READ_DSP = 0x14C0;				/* Shop&Go仕様　ニシムタ様　会員カードリード画面      */
  static const RG_QC_MBR_N_READ = (QC_MBR_N_READ_DSP + RG);		/* 登録モード Shop&Go仕様　ニシムタ様　会員カードリード画面      */
  static const TR_QC_MBR_N_READ = (QC_MBR_N_READ_DSP + TR);		/* 訓練モード Shop&Go仕様　ニシムタ様　会員カードリード画面      */

//   #define	TPOINT_MOBILE_READ_DSP	0x14F0			/* モバイルTカード読取画面 */
//   #define	RG_TPOINT_MOBILE_READ_DSP	(TPOINT_MOBILE_READ_DSP + RG)	/* 登録モード モバイルTカード読取画面 */
//   #define	VD_TPOINT_MOBILE_READ_DSP	(TPOINT_MOBILE_READ_DSP + VD)	/* 訂正モード モバイルTカード読取画面 */
//   #define	TR_TPOINT_MOBILE_READ_DSP	(TPOINT_MOBILE_READ_DSP + TR)	/* 訓練モード モバイルTカード読取画面 */
//
  static const DPTS_ORGTRAN_DSP	= 0x1510;			/* dポイント前回取引情報入力画面 */
  static const RG_DPTS_ORGTRAN_DSP = (DPTS_ORGTRAN_DSP + RG);	/* 登録モード dポイント前回取引情報入力画面 */
  static const VD_DPTS_ORGTRAN_DSP = (DPTS_ORGTRAN_DSP + VD);	/* 訂正モード dポイント前回取引情報入力画面 */
  static const TR_DPTS_ORGTRAN_DSP = (DPTS_ORGTRAN_DSP + TR);	/* 訓練モード dポイント前回取引情報入力画面 */


  static const DPTS_MODIFY_DSP = 0x1520;			/* dポイント修正画面 */
  static const RG_DPTS_MODIFY_DSP = (DPTS_MODIFY_DSP + RG);	/* 登録モード dポイント修正画面 */
  static const TR_DPTS_MODIFY_DSP = (DPTS_MODIFY_DSP + TR);	/* 訓練モード dポイント修正画面 */

//   #define	SG_DPTSMBRCHK		0x1530			/* dポイント用会員カード確認画面 */
//   #define	RG_SG_DPTSMBRCHK	(SG_DPTSMBRCHK + RG)	/* 登録モード dポイント用会員カード確認画面 */
//   #define	TR_SG_DPTSMBRCHK	(SG_DPTSMBRCHK + TR)	/* 訓練モード dポイント用会員カード確認画面 */
//
//   #define	SG_DPTSCHK		0x1540			/* dポイントカード確認画面 */
//   #define	RG_SG_DPTSCHK		(SG_DPTSCHK + RG)	/* 登録モード dポイントカード確認画面 */
//   #define	TR_SG_DPTSCHK		(SG_DPTSCHK + TR)	/* 訓練モード dポイントカード確認画面 */
//
//   #define	SG_DPTSSCN		0x1550			/* dポイントカード読取画面 */
//   #define	RG_SG_DPTSSCN		(SG_DPTSSCN + RG)	/* 登録モード dポイントカード読取画面 */
//   #define	TR_SG_DPTSSCN		(SG_DPTSSCN + TR)	/* 訓練モード dポイントカード読取画面 */

  static const QC_DPTS_ENTDSP = 0x1560;			/* セルフ用dポイント利用画面 */
  static const RG_QC_DPTS_ENTDSP = (QC_DPTS_ENTDSP + RG);	/* 登録モード セルフ用dポイント利用画面 */
  static const TR_QC_DPTS_ENTDSP = (QC_DPTS_ENTDSP + TR);	/* 訓練モード セルフ用dポイント利用画面 */

//   #define	QC_DPTS_USE		0x1570			/* セルフ用dポイント利用確認画面 */
//   #define	RG_QC_DPTS_USE		(QC_DPTS_USE + RG)	/* 登録モード セルフ用dポイント利用確認画面 */
//   #define	TR_QC_DPTS_USE		(QC_DPTS_USE + TR)	/* 訓練モード セルフ用dポイント利用確認画面 */
//
//   #define	QC_DPTS_END		0x1580			/* セルフ用dポイント利用完了画面 */
//   #define	RG_QC_DPTS_END		(QC_DPTS_END + RG)	/* 登録モード セルフ用dポイント利用完了画面 */
//   #define	TR_QC_DPTS_END		(QC_DPTS_END + TR)	/* 訓練モード セルフ用dポイント利用完了画面 */
//
  static const OVERFLOW_MOVE_DSP = 0x1590;			/* ｵｰﾊﾞｰﾌﾛｰ庫移動画面 */
  static const RG_OVERFLOW_MOVE_DSP	= (OVERFLOW_MOVE_DSP + RG); /* 登録モード ｵｰﾊﾞｰﾌﾛｰ庫移動画面 */
  static const VD_OVERFLOW_MOVE_DSP	= (OVERFLOW_MOVE_DSP + VD); /* 訂正モード ｵｰﾊﾞｰﾌﾛｰ庫移動画面 */
  static const TR_OVERFLOW_MOVE_DSP	= (OVERFLOW_MOVE_DSP + TR); /* 訓練モード ｵｰﾊﾞｰﾌﾛｰ庫移動画面 */
  static const SR_OVERFLOW_MOVE_DSP	= (OVERFLOW_MOVE_DSP + SR); /* 廃棄モード ｵｰﾊﾞｰﾌﾛｰ庫移動画面 */
//
  static const OVERFLOW_MENTE_DSP	= 0x15A0;			/* ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ画面 */
  static const RG_OVERFLOW_MENTE_DSP = (OVERFLOW_MENTE_DSP + RG); /* 登録モード ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ画面 */
  static const VD_OVERFLOW_MENTE_DSP = (OVERFLOW_MENTE_DSP + VD); /* 訂正モード ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ画面 */
  static const TR_OVERFLOW_MENTE_DSP = (OVERFLOW_MENTE_DSP + TR); /* 訓練モード ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ画面 */
  static const SR_OVERFLOW_MENTE_DSP = (OVERFLOW_MENTE_DSP + SR); /* 廃棄モード ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ画面 */
//
//   #define	READ_MNY_DSP		0x15F0			/* 金額読込キー押下画面 */
//   #define	RG_READ_MNY_DSP		(READ_MNY_DSP + RG)	/* 登録モード 金額読込キー押下画面 */
//   #define	TR_READ_MNY_DSP		(READ_MNY_DSP + TR)	/* 訓練モード 金額読込キー押下画面 */
//

  static const QC_ID_DSP = 0x1610;        /* ID支払画面 */
  static const RG_QC_ID_DSP = (QC_ID_DSP + RG);        /* 登録モード */
  static const VD_QC_ID_DSP = (QC_ID_DSP + VD);        /* 訂正モード */
  static const TR_QC_ID_DSP = (QC_ID_DSP + TR);        /* 訓練モード */
  static const SR_QC_ID_DSP = (QC_ID_DSP + SR);        /* 廃棄モード */

  static const QC_QP_DSP = 0x1620;               /* QP支払画面 */
  static const RG_QC_QP_DSP = (QC_QP_DSP + RG);  /* 登録モード */
  static const VD_QC_QP_DSP = (QC_QP_DSP + VD);  /* 訂正モード */
  static const TR_QC_QP_DSP = (QC_QP_DSP + TR);  /* 訓練モード */
  static const SR_QC_QP_DSP = (QC_QP_DSP + SR);  /* 廃棄モード */

  static const QC_ID_END_DSP = 0x1630;                     /* ID支払完了画面 */
  static const RG_QC_ID_END_DSP = (QC_ID_END_DSP + RG);    /* 登録モード */
  static const VD_QC_ID_END_DSP = (QC_ID_END_DSP + VD);    /* 訂正モード */
  static const TR_QC_ID_END_DSP = (QC_ID_END_DSP + TR);    /* 訓練モード */
  static const SR_QC_ID_END_DSP = (QC_ID_END_DSP + SR);    /* 廃棄モード */
//
//   #define               QC_QP_END_DSP   0x1640                          /* QP支払完了画面 */
//   #define               RG_QC_QP_END_DSP        (QC_QP_END_DSP + RG)    /* 登録モード */
//   #define               VD_QC_QP_END_DSP        (QC_QP_END_DSP + VD)    /* 訂正モード */
//   #define               TR_QC_QP_END_DSP        (QC_QP_END_DSP + TR)    /* 訓練モード */
//   #define               SR_QC_QP_END_DSP        (QC_QP_END_DSP + SR)    /* 廃棄モード */
//
  static const RARA_MBRREAD_DSP = 0x1650;			/* 端末カード読込キー RARAスマホ画面 [12ver] */
  static const RG_RARA_MBRREAD_DSP = (RARA_MBRREAD_DSP + RG);	/* 登録モード [12ver] */
  static const VD_RARA_MBRREAD_DSP = (RARA_MBRREAD_DSP + VD);	/* 訂正モード [12ver] */
  static const TR_RARA_MBRREAD_DSP = (RARA_MBRREAD_DSP + TR);	/* 訓練モード [12ver] */
  static const SR_RARA_MBRREAD_DSP = (RARA_MBRREAD_DSP + SR);	/* 廃棄モード [12ver] */
//
//   #define		QC_PRECA_DSP	0x1650			/* プリカ支払画面 */
//   #define		RG_QC_PRECA_DSP	(QC_PRECA_DSP + RG)	/* 登録モード */
//   #define		VD_QC_PRECA_DSP	(QC_PRECA_DSP + VD)	/* 訂正モード */
//   #define		TR_QC_PRECA_DSP	(QC_PRECA_DSP + TR)	/* 訓練モード */
//   #define		SR_QC_PRECA_DSP	(QC_PRECA_DSP + SR)	/* 廃棄モード */
//
//   #define		QC_PRECA_END_DSP	0x1660			/* プリカ支払完了画面 */
//   #define		RG_QC_PRECA_END_DSP	(QC_PRECA_END_DSP + RG)	/* 登録モード */
//   #define		VD_QC_PRECA_END_DSP	(QC_PRECA_END_DSP + VD)	/* 訂正モード */
//   #define		TR_QC_PRECA_END_DSP	(QC_PRECA_END_DSP + TR)	/* 訓練モード */
//   #define		SR_QC_PRECA_END_DSP	(QC_PRECA_END_DSP + SR)	/* 廃棄モード */
//
//   #define	QC_SAG_BAG_INP_DSP	0x16A0			/* Shop&Goレジ袋登録画面 */
//   #define	RG_QC_SAG_BAG_INP_DSP	(QC_SAG_BAG_INP_DSP + RG)
//   #define	TR_QC_SAG_BAG_INP_DSP	(QC_SAG_BAG_INP_DSP + TR)

  static const QC_REPICAPNT_ENTDSP = 0x16D0;			/* セルフ用レピカポイント利用画面 */
  static const RG_QC_REPICAPNT_ENTDSP =	( QC_REPICAPNT_ENTDSP + RG );	/* 登録モード */
  static const TR_QC_REPICAPNT_ENTDSP	= ( QC_REPICAPNT_ENTDSP + TR );	/* 訓練モード */

  static const QC_REPICAPNT_USEDSP = 0x16E0;			/* セルフ用レピカポイント利用確認画面 */
  static const RG_QC_REPICAPNT_USEDSP = ( QC_REPICAPNT_USEDSP + RG );	/* 登録モード */
  static const TR_QC_REPICAPNT_USEDSP = ( QC_REPICAPNT_USEDSP + TR );	/* 訓練モード */

  static const QC_REPICAPNT_ENDDSP = 0x16F0;			/* セルフ用レピカポイント支払完了画面 */
  static const RG_QC_REPICAPNT_ENDDSP = ( QC_REPICAPNT_ENDDSP + RG );	/* 登録モード */
  static const TR_QC_REPICAPNT_ENDDSP = ( QC_REPICAPNT_ENDDSP + TR );	/* 訓練モード */

  static const REPICAPNT_MODIFY_DSP	= 0x1700;			/* ﾌﾟﾘｶﾎﾟｲﾝﾄ訂正画面 */
  static const RG_REPICAPNT_MODIFY_DSP = ( REPICAPNT_MODIFY_DSP + RG );	/* 登録モード */
  static const TR_REPICAPNT_MODIFY_DSP = ( REPICAPNT_MODIFY_DSP + TR );	/* 訓練モード */
//
//   #define	QC_EMPLOYEECARD_PAYDSP	0x1710				/* 社員証決済画面 */
//   #define	RG_QC_EMPLOYEECARD_PAYDSP	(QC_EMPLOYEECARD_PAYDSP + RG)		/* 登録モード 社員証決済画面 */
//   #define	TR_QC_EMPLOYEECARD_PAYDSP	(QC_EMPLOYEECARD_PAYDSP + TR)		/* 訓練モード 社員証決済画面 */
//
//   #define	QC_EMPLOYEECARD_PAYEND_DSP	0x1720				/* 社員証決済完了画面 */
//   #define	RG_QC_EMPLOYEECARD_PAYEND_DSP	(QC_EMPLOYEECARD_PAYEND_DSP + RG)	/* 登録モード 社員証決済完了画面 */
//   #define	TR_QC_EMPLOYEECARD_PAYEND_DSP	(QC_EMPLOYEECARD_PAYEND_DSP + TR)	/* 訓練モード 社員証決済完了画面 */
//
  static const QC_COGCAPNT_ENTDSP =	0x1750;			/* セルフ用ポイント利用画面 */
  static const RG_QC_COGCAPNT_ENTDSP = ( QC_COGCAPNT_ENTDSP + RG );	/* 登録モード */
  static const TR_QC_COGCAPNT_ENTDSP = ( QC_COGCAPNT_ENTDSP + TR );	/* 訓練モード */

  static const QC_COGCAPNT_USEDSP =	0x1760;			/* セルフ用ポイント利用確認画面 */
  static const RG_QC_COGCAPNT_USEDSP = ( QC_COGCAPNT_USEDSP + RG );	/* 登録モード */
  static const TR_QC_COGCAPNT_USEDSP = ( QC_COGCAPNT_USEDSP + TR );	/* 訓練モード */

  static const QC_COGCAPNT_ENDDSP	= 0x1770;			/* セルフ用ポイント支払完了画面 */
  static const RG_QC_COGCAPNT_ENDDSP = ( QC_COGCAPNT_ENDDSP + RG );	/* 登録モード */
  static const TR_QC_COGCAPNT_ENDDSP = ( QC_COGCAPNT_ENDDSP + TR );	/* 訓練モード */

  static const QC_REPICAPNT_READ_DSP = 0x17C0;			/* セルフ用 レピカポイント読込画面 */
  static const RG_QC_REPICAPNT_READ = ( QC_REPICAPNT_READ_DSP + RG );	/* 登録モード */
  static const TR_QC_REPICAPNT_READ = ( QC_REPICAPNT_READ_DSP + TR );	/* 訓練モード */
//
//   #define		CAT_MBRREAD_DSP		0x1840				/* 端末カード読込キー 会員バーコード画面 */
//   #define		RG_CAT_MBRREAD_DSP	(CAT_MBRREAD_DSP + RG)		/* 登録モード */
//   #define		VD_CAT_MBRREAD_DSP	(CAT_MBRREAD_DSP + VD)		/* 訂正モード */
//   #define		TR_CAT_MBRREAD_DSP	(CAT_MBRREAD_DSP + TR)		/* 訓練モード */
//   #define		SR_CAT_MBRREAD_DSP	(CAT_MBRREAD_DSP + SR)		/* 廃棄モード */

  static const QC_EMNY_PRECA_DSP = 0x1850;	/* QCashier ハウスプリカ残高照会画面 */
  static const RG_QC_EMNY_PRECA_DSP = (QC_EMNY_PRECA_DSP + RG);	/* 登録モード QCashier ハウスプリカ残高照会画面 */
  static const TR_QC_EMNY_PRECA_DSP = (QC_EMNY_PRECA_DSP + TR);	/* 訓練モード QCashier ハウスプリカ残高照会画面 */

  static const QC_EMNY_PRECAEND_DSP = 0x1860;	/* QCashier ハウスプリカ残高照会終了画面 */
  static const RG_QC_EMNY_PRECAEND_DSP = (QC_EMNY_PRECAEND_DSP + RG);	/* 登録モード QCashier ハウスプリカ残高照会終了画面 */
  static const TR_QC_EMNY_PRECAEND_DSP = (QC_EMNY_PRECAEND_DSP + TR);	/* 訓練モード QCashier ハウスプリカ残高照会終了画面 */
//
//   #define		FIP_BAR_EMONEY_DSP		0x1870				/* 富士通FIP電子マネー(標準)バーコード読込画面 */
//   #define		RG_FIP_BAR_EMONEY_DSP (FIP_BAR_EMONEY_DSP + RG)	/* 登録モード 富士通FIP電子マネー(標準)バーコード読込画面 */
//   #define		VD_FIP_BAR_EMONEY_DSP (FIP_BAR_EMONEY_DSP + VD)	/* 訂正モード 富士通FIP電子マネー(標準)バーコード読込画面 */
//   #define		TR_FIP_BAR_EMONEY_DSP (FIP_BAR_EMONEY_DSP + TR)	/* 訓練モード 富士通FIP電子マネー(標準)バーコード読込画面 */
//   #define		SR_FIP_BAR_EMONEY_DSP (FIP_BAR_EMONEY_DSP + SR)	/* 廃棄モード 富士通FIP電子マネー(標準)バーコード読込画面 */
//
//   #define	QC_NIMOCA_CANCEL_YES_NO_DSP	0x1980 					/* QCashier ニモカ宣言、会員売価解除確認画面 */
//   #define RG_QC_NIMOCA_CANCEL_YES_NO_DSP	(QC_NIMOCA_CANCEL_YES_NO_DSP + RG)	/* 登録モード：QCashier ニモカ宣言、会員売価解除確認画面 */
//   #define TR_QC_NIMOCA_CANCEL_YES_NO_DSP	(QC_NIMOCA_CANCEL_YES_NO_DSP + TR)	/* 訓練モード：QCashier ニモカ宣言、会員売価解除確認画面 */
//
// /* ----------               for 15Ver. only                ---------- */
//

  static const QC_ARCS_MBR_CHK_DSP = 0x19A0;				/* 新規アークス 会員読込確認画面 */
  static const RG_QC_ARCS_MBRCHKDSP = (QC_ARCS_MBR_CHK_DSP + RG);	/* 登録モード */
  static const TR_QC_ARCS_MBRCHKDSP = (QC_ARCS_MBR_CHK_DSP + TR);	/* 訓練モード */

  static const QC_ARCS_MBR_DSP = 0x19B0;				/* 新規アークス 会員読込画面 */
  static const RG_QC_ARCS_MBRDSP = (QC_ARCS_MBR_DSP + RG);	/* 登録モード */
  static const TR_QC_ARCS_MBRDSP = (QC_ARCS_MBR_DSP + TR);	/* 訓練モード */

  static const TRANING_DATE_DSP = 0x2000; /* 訓練日変更画面 */
  static const RG_TRANING_DATE_DSP = (TRANING_DATE_DSP + RG); /* 登録 訓練日変更画面 */
  static const VD_TRANING_DATE_DSP = (TRANING_DATE_DSP + VD); /* 訂正 訓練日変更画面 */
  static const TR_TRANING_DATE_DSP = (TRANING_DATE_DSP + TR); /* 訓練 訓練日変更画面 */
  static const SR_TRANING_DATE_DSP = (TRANING_DATE_DSP + SR); /* 廃棄 訓練日変更画面 */
//
//   #define    CPNPRN_DSP     0x2010         /* お得情報再発行画面 */
//   #define    RG_CPNPRN_DSP (CPNPRN_DSP + RG) /* 登録 お得情報再発行画面 */
//   #define    VD_CPNPRN_DSP (CPNPRN_DSP + VD) /* 訂正 お得情報再発行画面 */
//   #define    TR_CPNPRN_DSP (CPNPRN_DSP + TR) /* 訓練 お得情報再発行画面 */
//   #define    SR_CPNPRN_DSP (CPNPRN_DSP + SR) /* 廃棄 お得情報再発行画面 */
//
//   #define    PAYMENT_DSP     0x2020         /* 決済キー画面 */
//   #define    RG_PAYMENT_DSP (PAYMENT_DSP + RG) /* 登録 決済キー画面 */
//   #define    VD_PAYMENT_DSP (PAYMENT_DSP + VD) /* 訂正 決済キー画面 */
//   #define    TR_PAYMENT_DSP (PAYMENT_DSP + TR) /* 訓練 決済キー画面 */
//   #define    SR_PAYMENT_DSP (PAYMENT_DSP + SR) /* 廃棄 決済キー画面 */
//
//   #define    PORTAL_DSP     0x2030         /* ポータルサイト認証発行画面 */
//   #define    RG_PORTAL_DSP (PORTAL_DSP + RG) /* 登録 ポータルサイト認証発行画面 */
//   #define    VD_PORTAL_DSP (PORTAL_DSP + VD) /* 訂正 ポータルサイト認証発行画面 */
//   #define    TR_PORTAL_DSP (PORTAL_DSP + TR) /* 訓練 ポータルサイト認証発行画面 */
//   #define    SR_PORTAL_DSP (PORTAL_DSP + SR) /* 廃棄 ポータルサイト認証発行画面 */
//
//   #define    MEMO_DSP     0x2040         /* 常駐メモ確認画面 */
//   #define    RG_MEMO_DSP	(MEMO_DSP + RG) /* 登録 常駐メモ確認画面 */
//   #define    VD_MEMO_DSP	(MEMO_DSP + VD) /* 訂正 常駐メモ確認画面 */
//   #define    TR_MEMO_DSP	(MEMO_DSP + TR) /* 訓練 常駐メモ確認画面 */
//   #define    SR_MEMO_DSP	(MEMO_DSP + SR) /* 廃棄 常駐メモ確認画面 */
//
//   #define    TMEMO_REL_DSP     0x2050         /* 連絡関連画面 */
//   #define    RG_TMEMO_REL_DSP	(TMEMO_REL_DSP + RG) /* 登録 連絡関連画面 */
//   #define    VD_TMEMO_REL_DSP	(TMEMO_REL_DSP + VD) /* 訂正 連絡関連画面 */
//   #define    TR_TMEMO_REL_DSP	(TMEMO_REL_DSP + TR) /* 訓練 連絡関連画面 */
//   #define    SR_TMEMO_REL_DSP	(TMEMO_REL_DSP + SR) /* 廃棄 連絡関連画面 */
//
//   #define    QC_SEL_EXPAND_DSP	0x2060		/* QC指定キー拡大表示画面 */
//   #define	   RG_QC_SEL_EXPAND_DSP	(QC_SEL_EXPAND_DSP + RG) /* 登録 QC指定キー拡大表示画面 */
//   #define	   TR_QC_SEL_EXPAND_DSP (QC_SEL_EXPAND_DSP + TR) /* 訓練 QC指定キー拡大表示画面 */
//
//   #define    REGASSIST_REG_DSP		0x2070         /* 登録補助：商品登録画面 */
//   #define    RG_REGASSIST_REG_DSP		(REGASSIST_REG_DSP + RG) /* 登録 商品登録画面 */
//   #define    VD_REGASSIST_REG_DSP		(REGASSIST_REG_DSP + VD) /* 訂正 商品登録画面 */
//   #define    TR_REGASSIST_REG_DSP		(REGASSIST_REG_DSP + TR) /* 訓練 商品登録画面 */
//   #define    SR_REGASSIST_REG_DSP		(REGASSIST_REG_DSP + SR) /* 廃棄 商品登録画面 */

  static const REGASSIST_PCHG_DSP = 0x2080;         /* 登録補助：商品登録時売価０自動売変画面 */
  static const RG_REGASSIST_PCHG_DSP = (REGASSIST_PCHG_DSP + RG); /* 登録 商品登録時売価０自動売変画面 */
  static const VD_REGASSIST_PCHG_DSP = (REGASSIST_PCHG_DSP + VD); /* 訂正 商品登録時売価０自動売変画面 */
  static const TR_REGASSIST_PCHG_DSP = (REGASSIST_PCHG_DSP + TR); /* 訓練 商品登録時売価０自動売変画面 */
  static const SR_REGASSIST_PCHG_DSP = (REGASSIST_PCHG_DSP + SR); /* 廃棄 商品登録時売価０自動売変画面 */

//   #define    REGASSIST_PAYMENT_DSP	0x2090         /* 登録補助：締め登録画面 */
//   #define    RG_REGASSIST_PAYMENT_DSP	(REGASSIST_PAYMENT_DSP + RG) /* 登録 締め登録画面 */
//   #define    VD_REGASSIST_PAYMENT_DSP	(REGASSIST_PAYMENT_DSP + VD) /* 訂正 締め登録画面 */
//   #define    TR_REGASSIST_PAYMENT_DSP	(REGASSIST_PAYMENT_DSP + TR) /* 訓練 締め登録画面 */
//   #define    SR_REGASSIST_PAYMENT_DSP	(REGASSIST_PAYMENT_DSP + SR) /* 廃棄 締め登録画面 */
//
  static const REGASSIST_CASH_DSP	= 0x20A0;         /* 登録補助：現金入力画面 */
  static const RG_REGASSIST_CASH_DSP = (REGASSIST_CASH_DSP + RG); /* 登録 現金入力画面 */
  static const VD_REGASSIST_CASH_DSP = (REGASSIST_CASH_DSP + VD); /* 訂正 現金入力画面 */
  static const TR_REGASSIST_CASH_DSP = (REGASSIST_CASH_DSP + TR); /* 訓練 現金入力画面 */
  static const SR_REGASSIST_CASH_DSP = (REGASSIST_CASH_DSP + SR); /* 廃棄 現金入力画面 */

  static const PRCCHK_DSP = 0x20B0;         /* 価格確認画面 */
  static const RG_PRCCHK_DSP = (PRCCHK_DSP + RG); /* 登録 価格確認画面 */
  static const VD_PRCCHK_DSP = (PRCCHK_DSP + VD); /* 訂正 価格確認画面 */
  static const TR_PRCCHK_DSP = (PRCCHK_DSP + TR); /* 訓練 価格確認画面 */
  static const SR_PRCCHK_DSP = (PRCCHK_DSP + SR); /* 廃棄 価格確認画面 */

  static const BUYHIST_DSP = 0x20C0;         /* 購買履歴画面 */
  static const RG_BUYHIST_DSP = (BUYHIST_DSP + RG); /* 登録 購買履歴画面 */
  static const VD_BUYHIST_DSP = (BUYHIST_DSP + VD); /* 訂正 購買履歴画面 */
  static const TR_BUYHIST_DSP = (BUYHIST_DSP + TR); /* 訓練 購買履歴画面 */
  static const SR_BUYHIST_DSP = (BUYHIST_DSP + SR); /* 廃棄 購買履歴画面 */
//
  static const MCARD_DSP = 0x20D0;    	/* 特定DS2仕様 会員読込画面 */
  static const RG_MCARD_DSP = (MCARD_DSP + RG); 	/* 登録 特定DS2仕様 会員読込画面 */
  static const VD_MCARD_DSP = (MCARD_DSP + VD); 	/* 訂正 特定DS2仕様 会員読込画面 */
  static const TR_MCARD_DSP = (MCARD_DSP + TR); 	/* 訓練 特定DS2仕様 会員読込画面 */
  static const SR_MCARD_DSP = (MCARD_DSP + SR); 	/* 廃棄 特定DS2仕様 会員読込画面 */
//
//   #define    SVSTCKTBAR_DSP		0x20E0         /* サービス券バーコード画面 */
//   #define    RG_SVSTCKTBAR_DSP	(SVSTCKTBAR_DSP + RG) /* 登録 サービス券バーコード画面 */
//   #define    VD_SVSTCKTBAR_DSP	(SVSTCKTBAR_DSP + VD) /* 訂正 サービス券バーコード画面 */
//   #define    TR_SVSTCKTBAR_DSP	(SVSTCKTBAR_DSP + TR) /* 訓練 サービス券バーコード画面 */
//   #define    SR_SVSTCKTBAR_DSP	(SVSTCKTBAR_DSP + SR) /* 廃棄 サービス券バーコード画面 */
//
//   #define    ZIPCODE_DSP		0x20F0             /* ZIPコード */
//   #define    RG_ZIPCODE_DSP	(ZIPCODE_DSP + RG) /* 登録 ZIPコード画面 */
//   #define    VD_ZIPCODE_DSP	(ZIPCODE_DSP + VD) /* 訂正 ZIPコード画面 */
//   #define    TR_ZIPCODE_DSP	(ZIPCODE_DSP + TR) /* 訓練 ZIPコード画面 */
//   #define    SR_ZIPCODE_DSP	(ZIPCODE_DSP + SR) /* 廃棄 ZIPコード画面 */
//
//   #define    CPN_INPUT_DSP	0x2100             /* クーポン手入力 */
//   #define    RG_CPN_INPUT_DSP	(CPN_INPUT_DSP + RG) /* 登録 クーポン手入力画面 */
//   #define    VD_CPN_INPUT_DSP	(CPN_INPUT_DSP + VD) /* 訂正 クーポン手入力画面 */
//   #define    TR_CPN_INPUT_DSP	(CPN_INPUT_DSP + TR) /* 訓練 クーポン手入力画面 */
//   #define    SR_CPN_INPUT_DSP	(CPN_INPUT_DSP + SR) /* 廃棄 クーポン手入力画面 */
//
//   #define    INTEGRATED_DSP	0x2120			/* 会員統合画面 */
//   #define    RG_INTEGRATED_DSP	(INTEGRATED_DSP + RG)	/* 登録 会員統合画面 */
//   #define    VD_INTEGRATED_DSP	(INTEGRATED_DSP + VD)	/* 訂正 会員統合画面 */
//   #define    TR_INTEGRATED_DSP	(INTEGRATED_DSP + TR)	/* 訓練 会員統合画面 */
//   #define    SR_INTEGRATED_DSP	(INTEGRATED_DSP + SR)	/* 廃棄 会員統合画面 */
//
//   #define    OMNICHANNEL_DSP	0x2130			/* オムニチャンネル画面 */
//   #define    RG_OMNICHANNEL_DSP	(OMNICHANNEL_DSP + RG)	/* 登録 オムニチャンネル画面 */
//   #define    VD_OMNICHANNEL_DSP	(OMNICHANNEL_DSP + VD)	/* 訂正 オムニチャンネル画面 */
//   #define    TR_OMNICHANNEL_DSP	(OMNICHANNEL_DSP + TR)	/* 訓練 オムニチャンネル画面 */
//   #define    SR_OMNICHANNEL_DSP	(OMNICHANNEL_DSP + SR)	/* 廃棄 オムニチャンネル画面 */
//
//   #define    MDLLIST_DSP		0x2140			/* 中分類一覧画面 */
//   #define    RG_MDLLIST_DSP	(MDLLIST_DSP + RG)	/* 登録 中分類一覧画面 */
//   #define    VD_MDLLIST_DSP	(MDLLIST_DSP + VD)	/* 訂正 中分類一覧画面 */
//   #define    TR_MDLLIST_DSP	(MDLLIST_DSP + TR)	/* 訓練 中分類一覧画面 */
//   #define    SR_MDLLIST_DSP	(MDLLIST_DSP + SR)	/* 廃棄 中分類一覧画面 */
//
//   #define    COUPON_REISSUE_DSP		0x2150			/* クーポン再発行画面 */
//   #define    RG_COUPON_REISSUE_DSP	(COUPON_REISSUE_DSP + RG)	/* 登録 クーポン再発行画面 */
//   #define    VD_COUPON_REISSUE_DSP	(COUPON_REISSUE_DSP + VD)	/* 訂正 クーポン再発行画面 */
//   #define    TR_COUPON_REISSUE_DSP	(COUPON_REISSUE_DSP + TR)	/* 訓練 クーポン再発行画面 */
//   #define    SR_COUPON_REISSUE_DSP	(COUPON_REISSUE_DSP + SR)	/* 廃棄 クーポン再発行画面 */
//
//   #define    MDMBRCLSCHG_DSP	0x2160			/* 会員分類変更画面 */
//   #define    RG_MBRCLSCHG_DSP	(MDMBRCLSCHG_DSP + RG)	/* 登録 会員分類変更画面 */
//   #define    VD_MBRCLSCHG_DSP	(MDMBRCLSCHG_DSP + VD)	/* 訂正 会員分類変更画面 */
//   #define    TR_MBRCLSCHG_DSP	(MDMBRCLSCHG_DSP + TR)	/* 訓練 会員分類変更画面 */
//   #define    SR_MBRCLSCHG_DSP	(MDMBRCLSCHG_DSP + SR)	/* 廃棄 会員分類変更画面 */
//
//   #define    LOTOTCKT_SUM_DSP	0x2170			/* 抽選券集計画面 */
//   #define    RG_LOTOTCKT_SUM_DSP	(LOTOTCKT_SUM_DSP + RG)	/* 登録 抽選券集計画面 */
//   #define    VD_LOTOTCKT_SUM_DSP	(LOTOTCKT_SUM_DSP + VD)	/* 訂正 抽選券集計画面 */
//   #define    TR_LOTOTCKT_SUM_DSP	(LOTOTCKT_SUM_DSP + TR)	/* 訓練 抽選券集計画面 */
//   #define    SR_LOTOTCKT_SUM_DSP	(LOTOTCKT_SUM_DSP + SR)	/* 廃棄 抽選券集計画面 */
//
//   #define    AJS_EMONEY_DSP      0x2180		/* AJS_EMONEY Card Scan Display      */
//   #define    RG_AJS_EMONEY_DSP  (AJS_EMONEY_DSP + RG)	/* Reg. AJS_EMONEY Card Scan Display */
//   #define    VD_AJS_EMONEY_DSP  (AJS_EMONEY_DSP + VD)	/* Cor. AJS_EMONEY Card Scan Display */
//   #define    TR_AJS_EMONEY_DSP  (AJS_EMONEY_DSP + TR)	/* Tra. AJS_EMONEY Card Scan Display */
//   #define    SR_AJS_EMONEY_DSP  (AJS_EMONEY_DSP + SR)	/* Scr. AJS_EMONEY Card Scan Display */
//
//   #define    AJS_EMONEY_MI_DSP      0x2190		/* AJS_EMONEY Card Manual Input Display      */
//   #define    RG_AJS_EMONEY_MI_DSP  (AJS_EMONEY_MI_DSP + RG)	/* Reg. AJS_EMONEY Card Manual Input Display */
//   #define    VD_AJS_EMONEY_MI_DSP  (AJS_EMONEY_MI_DSP + VD)	/* Cor. AJS_EMONEY Card Manual Input Display */
//   #define    TR_AJS_EMONEY_MI_DSP  (AJS_EMONEY_MI_DSP + TR)	/* Tra. AJS_EMONEY Card Manual Input Display */
//   #define    SR_AJS_EMONEY_MI_DSP  (AJS_EMONEY_MI_DSP + SR)	/* Scr. AJS_EMONEY Card Manual Input Display */
//
//   #define    FIP_BAR_MEMBER_DSP	0x21A0				/* 富士通FIP会員バーコード読込画面 */
//   #define    RG_FIP_BAR_MEMBER_DSP (FIP_BAR_MEMBER_DSP + RG)	/* 登録モード 富士通FIP会員バーコード読込画面 */
//   #define    VD_FIP_BAR_MEMBER_DSP (FIP_BAR_MEMBER_DSP + VD)	/* 訂正モード 富士通FIP会員バーコード読込画面 */
//   #define    TR_FIP_BAR_MEMBER_DSP (FIP_BAR_MEMBER_DSP + TR)	/* 訓練モード 富士通FIP会員バーコード読込画面 */
//   #define    SR_FIP_BAR_MEMBER_DSP (FIP_BAR_MEMBER_DSP + SR)	/* 廃棄モード 富士通FIP会員バーコード読込画面 */
//
//   #define    COUPON_REF_DSP	0x21B0				/* クーポン照会画面 */
//   #define    RG_COUPON_REF_DSP	(COUPON_REF_DSP + RG)	/* 登録モード クーポン照会画面 */
//   #define    VD_COUPON_REF_DSP	(COUPON_REF_DSP + VD)	/* 訂正モード クーポン照会画面 */
//   #define    TR_COUPON_REF_DSP	(COUPON_REF_DSP + TR)	/* 訓練モード クーポン照会画面 */
//   #define    SR_COUPON_REF_DSP	(COUPON_REF_DSP + SR)	/* 廃棄モード クーポン照会画面 */
//
  static const CREDIT_SIGN_ERR_DSP = 0x21C0;				/* クレジットサイン要求エラー画面 */
  static const RG_CREDIT_SIGN_ERR_DSP = (CREDIT_SIGN_ERR_DSP + RG);	/* 登録モード */
  static const TR_CREDIT_SIGN_ERR_DSP = (CREDIT_SIGN_ERR_DSP + TR);	/* 訓練モード */
  static const VD_CREDIT_SIGN_ERR_DSP = (CREDIT_SIGN_ERR_DSP + VD);	/* 訂正モード */
  static const SR_CREDIT_SIGN_ERR_DSP = (CREDIT_SIGN_ERR_DSP + SR);	/* 廃棄モード */
//
//   #define		QC_VESCA_USE		0x21D0			/* Verifone利用確認画面 */
//   #define		RG_QC_VESCA_USE	(QC_VESCA_USE + RG)		/* 登録モード Verifone利用確認画面 */
//   #define		TR_QC_VESCA_USE	(QC_VESCA_USE + TR)		/* 訓練モード Verifone利用確認画面 */
//
//   #define		QC_VESCA_END		0x21E0			/* Verifone利用完了画面 */
//   #define		RG_QC_VESCA_END	(QC_VESCA_END + RG)		/* 登録モード Verifone利用完了画面 */
//   #define		TR_QC_VESCA_END	(QC_VESCA_END + TR)		/* 訓練モード Verifone利用完了画面 */

  static const SG_AGECHECK_SELECT_DSP		= 0x21F0;	/* 年齢確認方法選択画面 */
  static const RG_SG_AGECHECK_SELECT_DSP	= SG_AGECHECK_SELECT_DSP + RG;
  static const TR_SG_AGECHECK_SELECT_DSP	= SG_AGECHECK_SELECT_DSP + TR;

  static const SG_AGECHECK_DEVICE_DSP		= 0x2200;	/* 端末年齢確認画面 */
  static const RG_SG_AGECHECK_DEVICE_DSP	= SG_AGECHECK_DEVICE_DSP + RG;
  static const TR_SG_AGECHECK_DEVICE_DSP	= SG_AGECHECK_DEVICE_DSP + TR;

  static const SG_RPTSMBRCHK	= 0x2210;			/* 楽天ポイント用会員カード確認画面 */
  static const RG_SG_RPTSMBRCHK = (SG_RPTSMBRCHK + RG);	/* 登録モード 楽天ポイント用会員カード確認画面 */
  static const TR_SG_RPTSMBRCHK = (SG_RPTSMBRCHK + TR);	/* 訓練モード 楽天ポイント用会員カード確認画面 */

//   #define    RPTS_MBR_READ_DSP	0x2220             /* 楽天ポイントカード読込 */
//   #define    RG_RPTS_MBR_READ_DSP	(RPTS_MBR_READ_DSP + RG) /* 登録 楽天ポイントカード読込画面 */
//   #define    TR_RPTS_MBR_READ_DSP	(RPTS_MBR_READ_DSP + TR) /* 訓練 楽天ポイントカード読込画面 */
//
//   #define    QC_RPTS_MBR_YES_NO_DSP	0x2230             /* 精算機楽天ポイントカード確認画面 */
//   #define    RG_QC_RPTS_MBR_YES_NO_DSP	(QC_RPTS_MBR_YES_NO_DSP + RG) /* 登録 精算機楽天ポイントカード確認画面 */
//   #define    TR_QC_RPTS_MBR_YES_NO_DSP	(QC_RPTS_MBR_YES_NO_DSP + TR) /* 訓練 精算機楽天ポイントカード確認画面 */
//
//   #define    QC_RPTS_MBR_READ_DSP	0x2240             /* 精算機楽天ポイントカード読込画面 */
//   #define    RG_QC_RPTS_MBR_READ_DSP	(QC_RPTS_MBR_READ_DSP + RG) /* 登録 精算機楽天ポイントカード読込画面 */
//   #define    TR_QC_RPTS_MBR_READ_DSP	(QC_RPTS_MBR_READ_DSP + TR) /* 訓練 精算機楽天ポイントカード読込画面 */
//
//   #define	TPOINT_MAG_CARD_MI_DSP	0x2250			/* 磁気Tカード手入力画面 */
//   #define	RG_TPOINT_MAG_CARD_MI_DSP	(TPOINT_MAG_CARD_MI_DSP + RG)	/* 登録モード 磁気Tカード手入力画面 */
//   #define	VD_TPOINT_MAG_CARD_MI_DSP	(TPOINT_MAG_CARD_MI_DSP + VD)	/* 訂正モード 磁気Tカード手入力画面 */
//   #define	TR_TPOINT_MAG_CARD_MI_DSP	(TPOINT_MAG_CARD_MI_DSP + TR)	/* 訓練モード 磁気Tカード手入力画面 */
//
//   #define	ACCOUNT_RECEIVABLE_DSP	0x2260			/* 売掛宣言：売掛コード入力画面 */
//   #define	RG_ACCOUNT_RECEIVABLE_DSP	(ACCOUNT_RECEIVABLE_DSP + RG)
//   #define	VD_ACCOUNT_RECEIVABLE_DSP	(ACCOUNT_RECEIVABLE_DSP + VD)
//   #define	TR_ACCOUNT_RECEIVABLE_DSP	(ACCOUNT_RECEIVABLE_DSP + TR)
//
  static const UNREAD_CASH_AMT_DSP = 0x2270;         /* 登録補助：未読現金金種枚数 */
  static const RG_UNREAD_CASH_AMT_DSP =	(UNREAD_CASH_AMT_DSP + RG); /* 登録 未読現金金種枚数 */
  static const VD_UNREAD_CASH_AMT_DSP	= (UNREAD_CASH_AMT_DSP + VD); /* 訂正 未読現金金種枚数 */
  static const TR_UNREAD_CASH_AMT_DSP	= (UNREAD_CASH_AMT_DSP + TR); /* 訓練 未読現金金種枚数 */
  static const SR_UNREAD_CASH_AMT_DSP	= (UNREAD_CASH_AMT_DSP + SR); /* 廃棄 未読現金金種枚数 */
//
//   #define    TOMO_USE_DSP      	0x2280			/* 友の会カード利用画面     */
//   #define    RG_TOMO_USE_DSP  (TOMO_USE_DSP + RG)			/* 登録 */
//   #define    TR_TOMO_USE_DSP  (TOMO_USE_DSP + TR)			/* 訓練 */
//   // 支払選択画面で"全額友の会支払"選択後の画面
//   #define	   QC_TOMO_USE		0x2290			/* 友の会利用確認画面 */
//   #define	   RG_QC_TOMO_USE	(QC_TOMO_USE + RG)		/* 登録モード 利用確認画面 */
//   #define	   TR_QC_TOMO_USE	(QC_TOMO_USE + TR)		/* 訓練モード 利用確認画面 */
//
//   #define	   QC_TOMO_END		0x22A0			/* 友の会利用完了画面 */
//   #define	   RG_QC_TOMO_END	(QC_TOMO_END + RG)		/* 登録モード 利用完了画面 */
//   #define	   TR_QC_TOMO_END	(QC_TOMO_END + TR)		/* 訓練モード 利用完了画面 */
//
//   #if TOMO_MBRCHK_DISP_MULBTN
//   #define	   SG_TOMOMBRCHK	0x22B0			/* 友の会用会員カード確認画面 */
//   #define	   RG_SG_TOMOMBRCHK	(SG_TOMOMBRCHK + RG)		/* 登録モード 友の会用会員カード確認画面 */
//   #define	   TR_SG_TOMOMBRCHK	(SG_TOMOMBRCHK + TR)		/* 訓練モード 友の会用会員カード確認画面 */
//   #endif
//
//   #define		QC_STDCPN_SLCT_DSP	0x22C0				/* セルフ用 OneToOneクーポン所持確認画面 */
//   #define		RG_QC_STDCPN_SLCT_DSP	(QC_STDCPN_SLCT_DSP + RG)	/* 登録モード */
//   #define		TR_QC_STDCPN_SLCT_DSP	(QC_STDCPN_SLCT_DSP + TR)	/* 訓練モード */
//
//   #define		QC_STDCPN_READ_DSP	0x22D0				/* セルフ用 OneToOneクーポン読込画面 */
//   #define		RG_QC_STDCPN_READ_DSP	(QC_STDCPN_READ_DSP + RG)	/* 登録モード */
//   #define		TR_QC_STDCPN_READ_DSP	(QC_STDCPN_READ_DSP + TR)	/* 訓練モード */
//
  static const QC_CRINOUT_READ_DSP = 0x22E0;				/* セルフ用キャッシュリサイクル入出金バーコード読込画面 */
  static const RG_QC_CRINOUT_READ_DSP = (QC_CRINOUT_READ_DSP + RG);	/* 登録モード */
//
//   #define    CAMPAIGN_DSCNT_DSP   0x22F0         /* 登録補助：キャンペーン値引き登録画面 */
//   #define    RG_CAMPAIGN_DSCNT_DSP        (CAMPAIGN_DSCNT_DSP + RG) /* 登録 キャンペーン値引き登録画面 */
//   #define    VD_CAMPAIGN_DSCNT_DSP        (CAMPAIGN_DSCNT_DSP + VD) /* 訂正 キャンペーン値引き登録画面 */
//   #define    TR_CAMPAIGN_DSCNT_DSP        (CAMPAIGN_DSCNT_DSP + TR) /* 訓練 キャンペーン値引き登録画面 */
//   #define    SR_CAMPAIGN_DSCNT_DSP        (CAMPAIGN_DSCNT_DSP + SR) /* 廃棄 キャンペーン値引き登録画面 */
//
//   #define    PLULIST_DSP          0x2300                  /* PLU一覧画面 */
//   #define    RG_PLULIST_DSP       (PLULIST_DSP + RG)      /* 登録 PLU一覧画面 */
//   #define    VD_PLULIST_DSP       (PLULIST_DSP + VD)      /* 訂正 PLU一覧画面 */
//   #define    TR_PLULIST_DSP       (PLULIST_DSP + TR)      /* 訓練 PLU一覧画面 */
//
//   #define    QC_RPTS_PAY_CONF_DSP	0x2310             /* 楽天ポイント利用確認画面 */
//   #define    RG_QC_RPTS_PAY_CONF_DSP	(QC_RPTS_PAY_CONF_DSP + RG) /* 登録 楽天ポイント利用確認画面 */
//   #define    TR_QC_RPTS_PAY_CONF_DSP	(QC_RPTS_PAY_CONF_DSP + TR) /* 訓練 楽天ポイント利用確認画面 */
//
  static const FRESTA_SPBAR_DSP = 0x2320;				/* 特殊ﾊﾞｰｺｰﾄﾞ読取画面 */
  static const RG_FRESTA_SPBAR_DSP = (FRESTA_SPBAR_DSP + RG);		/* 登録 特殊ﾊﾞｰｺｰﾄﾞ読取画面 */
  static const TR_FRESTA_SPBAR_DSP = (FRESTA_SPBAR_DSP + TR);		/* 訓練 特殊ﾊﾞｰｺｰﾄﾞ読取画面 */
//
//   #define		FRESTA_PAYCONF_DSP	0x2330		/* フレスタ様：会計確認画面 */
//   #define		RG_FRESTA_PAYCONF_DSP	(FRESTA_PAYCONF_DSP + RG) /* 登録 */
//   #define		VD_FRESTA_PAYCONF_DSP	(FRESTA_PAYCONF_DSP + VD) /* 訂正 */
//   #define		TR_FRESTA_PAYCONF_DSP	(FRESTA_PAYCONF_DSP + TR) /* 訓練 */
//   #define		SR_FRESTA_PAYCONF_DSP	(FRESTA_PAYCONF_DSP + SR) /* 廃棄 */
  static const int SG_BAG_SCAN_DSP = 0x2340;      /* レジ袋スキャン登録画面 */
  static const int RG_SG_BAG_SCAN_DSP = SG_BAG_SCAN_DSP + RG;  /* 登録 レジ袋スキャン登録画面 */
  static const int TR_SG_BAG_SCAN_DSP = SG_BAG_SCAN_DSP + TR;  /* 訓練 レジ袋スキャン登録画面 */
//
//   #define		QC_BCDPAY_WAIT_DSP	0x2350			/* コード決済確認画面 */
//   #define		RG_QC_BCDPAY_WAIT (QC_BCDPAY_WAIT_DSP + RG)
//   #define		TR_QC_BCDPAY_WAIT (QC_BCDPAY_WAIT_DSP + TR)
//
//   #define	QCASHIER_MEMBER_READ_SELECT_DSP	0x2360						/* 精算機会員カード選択画面 */
//   #define	RG_QCASHIER_MEMBER_READ_SELECT_DSP	(QCASHIER_MEMBER_READ_SELECT_DSP + RG)	/* 登録 精算機会員カード選択画面 */
//   #define	TR_QCASHIER_MEMBER_READ_SELECT_DSP	(QCASHIER_MEMBER_READ_SELECT_DSP + TR)	/* 訓練 精算機会員カード選択画面 */
//
  static const QCASHIER_MEMBER_READ_ENTRY_DSP = 0x2370;						/* 精算機会員カード読取画面 */
  static const RG_QCASHIER_MEMBER_READ_ENTRY_DSP = (QCASHIER_MEMBER_READ_ENTRY_DSP + RG);	/* 登録 精算機会員カード読取画面 */
  static const TR_QCASHIER_MEMBER_READ_ENTRY_DSP = (QCASHIER_MEMBER_READ_ENTRY_DSP + TR);	/* 訓練 精算機会員カード読取画面 */

  static const CASHBACK_START_DSP	= 0x2380;		/* オオゼキ様：キャッシュバックスタート画面 */
  static const RG_CASHBACK_START_DSP = (CASHBACK_START_DSP + RG);
  static const TR_CASHBACK_START_DSP = (CASHBACK_START_DSP + TR);

  static const CASHBACK_POINTENTRY_DSP = 0x2390;		/* オオゼキ様：キャッシュバックポイント利用画面 */
  static const RG_CASHBACK_POINTENTRY_DSP = (CASHBACK_POINTENTRY_DSP + RG);
  static const TR_CASHBACK_POINTENTRY_DSP = (CASHBACK_POINTENTRY_DSP + TR);

  /************************************************************************/
  /*                     #define Event Datas                              */
  /************************************************************************/
  static const int NORMAL_EVENT = 1;
  static const int ITMSTL_EVENT = 300;
  static const int WARN_EVENT = 1000;
  static const int WARN_EVENT1 = 100;
  static const int WARN_EVENT2 = (WARN_EVENT - WARN_EVENT1);

  static const RESERV_DSP = 0x08C0;                /* Reserv input Display      */
  static const RG_RESERV_DSP = (RESERV_DSP + RG);  /* Reg. Reserv Input Display */
  static const VD_RESERV_DSP = (RESERV_DSP + VD);  /* Cor. Reserv Input Display */
  static const TR_RESERV_DSP = (RESERV_DSP + TR);  /* Tra. Reserv Input Display */
  static const SR_RESERV_DSP = (RESERV_DSP + SR);  /* Scr. Reserv Input Display */

  static const ADVANCE_IN_DSP = 0x0AF0;         /* Advance Input Display      */
  static const RG_ADVANCE_IN_DSP = (ADVANCE_IN_DSP + RG); /* Reg. Advance Input Display */
  static const VD_ADVANCE_IN_DSP = (ADVANCE_IN_DSP + VD); /* Cor. Advance Input Display */
  static const TR_ADVANCE_IN_DSP = (ADVANCE_IN_DSP + TR); /* Tra. Advance Input Display */
  static const SR_ADVANCE_IN_DSP = (ADVANCE_IN_DSP + SR); /* Scr. Advance Input Display */

  /************************************************************************/
  /*                Bit flag "wCtrl" in StlItemCalc_Main()                */
  /************************************************************************/
  static const STLCALC_NORMAL = 0x0000;         /* normal                     */
  static const STLCALC_INC_MBRRBT = 0x0001;     /* include Member Auto-Rebate */
  static const STLCALC_EXC_CUST = 0x0002;       /* Exclude Cust               */
  static const STLCALC_INC_CUST = 0x0003;       /* Include Cust(Dept,Mg,Plu)  */

  ///  関連tprxソース: rcregs.h - Ky_St_C0(ky) ((ky &  0x01) != 0)
  static bool kyStC0(int ky) {
    /* Check Key Status Bit0 */
    return ((ky &  0x01) != 0);
  }

  ///  関連tprxソース: rcregs.h - Ky_St_C1(ky) ((ky &  0x02) != 0)
  static bool kyStC1(int ky) {
    /* Check Key Status Bit1 */
    return ((ky &  0x02) != 0);
  }

  ///  関連tprxソース: rcregs.h - Ky_St_C2(ky)   ((ky &  0x04) != 0)
  static bool kyStC2(int ky) {
    /* Check Key Status Bit2 */
    return ((ky &  0x04) != 0);
  }

  ///  関連tprxソース: rcregs.h - Ky_St_C3(ky) ((ky &  0x08) != 0)
  static bool kyStC3(int ky) {
    /* Check Key Status Bit3 */
    return ((ky & 0x08) != 0);
  }

  ///  関連tprxソース: rcregs.h - Ky_St_C4(ky) ((ky &  0x10) != 0)
  static bool kyStC4(int ky) {
    /* Check Key Status Bit4 */
    return ((ky & 0x10) != 0);
  }

  ///  関連tprxソース: rcregs.h - Ky_St_C5(ky) ((ky &  0x20) != 0)
  static bool kyStC5(int ky) {
    /* Check Key Status Bit5 */
    return ((ky & 0x20) != 0);
  }

  ///  関連tprxソース: rcregs.h - Ky_St_C6(ky) ((ky &  0x40) != 0)
  static bool kyStC6(int ky) {
    /* Check Key Status Bit6 */
    return ((ky & 0x40) != 0);
  }

  ///  関連tprxソース: rcregs.h - Ky_St_C7(ky) ((ky &  0x80) != 0)
  static bool kyStC7(int ky) {
    /* Check Key Status Bit7 */
    return ((ky & 0x80) != 0);
  }

  ///  関連tprxソース: rcregs.h - Ky_St_R0(ky)    (ky &= 0xFE)
  static void kyStR0(List ky, int index) {
    /* Reset Key Status Bit0 */
    ky[index] &= 0xFE;
  }

  ///  関連tprxソース: rcregs.h - Ky_St_R1(ky)    (ky &= 0xFD)
  static void kyStR1(List ky, int index) {
    /* Reset Key Status Bit1 */
    ky[index] &= 0xFD;
  }

  ///  関連tprxソース: rcregs.h - Ky_St_R2(ky)    (ky &= 0xFB)
  static void kyStR2(List ky, int index) {
    /* Reset Key Status Bit2 */
    ky[index] &= 0xFB;
  }

  ///  関連tprxソース: rcregs.h - Ky_St_R3(ky)    (ky &= 0xF7)
  static void kyStR3(List ky, int index) {
    /* Reset Key Status Bit3 */
    ky[index] &= 0xF7;
  }

  ///  関連tprxソース: rcregs.h - Ky_St_R4(ky) (ky &= 0xEF)
  static void kyStR4(List ky, int index) {
    /* Reset Key Status Bit4 */
    ky[index] &= 0xEF;
  }

  ///  関連tprxソース: rcregs.h - Ky_St_R5(ky) (ky &= 0xDF)
  static void kyStR5(List ky, int index) {
    /* Reset Key Status Bit5 */
    ky[index] &= 0xDF;
  }

  ///  関連tprxソース: rcregs.h - Ky_St_R6(ky) (ky &= 0xBF)
  static void kyStR6(List ky, int index) {
    /* Reset Key Status Bit6 */
    ky[index] &= 0xBF;
  }

  ///  関連tprxソース: rcregs.h - Ky_St_R7(ky) (ky &= 0x7F)
  static void kyStR7(List ky, int index) {
    /* Reset Key Status Bit7 */
    ky[index] &= 0x7F;
  }

  ///  関連tprxソース: rcregs.h - Ky_St_S0(ky)    (ky |= 0x01)
  static void kyStS0(List ky, int index) {
    /* Set Key Status Bit0 */
    ky[index] |= 0x01;
  }

  ///  関連tprxソース: rcregs.h - Ky_St_S1(ky)    (ky |= 0x02)
  static void kyStS1(List ky, int index) {
    /* Set Key Status Bit1 */
    ky[index] |= 0x02;
  }

  ///  関連tprxソース: rcregs.h - Ky_St_S2(ky)    (ky |= 0x04)
  static void kyStS2(List ky, int index) {
    /* Set Key Status Bit2 */
    ky[index] |= 0x04;
  }

  ///  関連tprxソース: rcregs.h - Ky_St_S3(ky)    (ky |= 0x08)
  static void kyStS3(List ky, int index) {
    /* Set Key Status Bit3 */
    ky[index] |= 0x08;
  }

  ///  関連tprxソース: rcregs.h - Ky_St_S4(ky)    (ky |= 0x10)
  static void kyStS4(List ky, int index) {
    /* Set Key Status Bit4 */
    ky[index] |= 0x10;
  }

  ///  関連tprxソース: rcregs.h - Ky_St_S5(ky)    (ky |= 0x20)
  static void kyStS5(List ky, int index) {
    /* Set Key Status Bit5 */
    ky[index] |= 0x20;
  }

  ///  関連tprxソース: rcregs.h - Ky_St_S6(ky)    (ky |= 0x40)
  static void kyStS6(List ky, int index) {
    /* Set Key Status Bit6 */
    ky[index] |= 0x40;
  }

  ///  関連tprxソース: rcregs.h - Ky_St_S7(ky)    (ky |= 0x80)
  static void kyStS7(List ky, int index) {
    /* Set Key Status Bit7 */
    ky[index] |= 0x80;
  }

  /************************************************************************/
  /*                       #define data Machine Type                      */
  /************************************************************************/

  static const KY_SINGLE = 0x00;            /* I'm TPR Machine Single     */
  static const KY_CHECKER = 0x01;            /* I'm TPR Machine Checker    */
  static const KY_CASHIER = 0x02;            /* I'm TPR Machine Cashier    */
  static const DESKTOPTYPE = 0x03;            /* I'm TPR Machine Desk Top   */
  static const KY_DUALCSHR = 0x04;            /* I'm TPR Machine DualCashier*/

/************************************************************************/
/*                        ScrMode use #define Data                      */
/************************************************************************/

/* TPR use CMEM->stat.OpeMode #define */
  static const RG = 0x0000;           /* Registration Mode          */
  static const VD = 0x0001;           /* Correction Mode            */
  static const TR = 0x0002;           /* Traning Mode               */
  static const SR = 0x0004;           /* Scrap Mode                 */
  static const OD = 0x0003;           /* Order Mode                 */
  static const IV = 0x0005;           /* Inventry Mode              */
  static const PD = 0x0006;           /* Production Mode            */
  static const IN = 0x0007;           /* InOutMode In Mode          */
  static const OU = 0x0008;           /* InOutMode Out Mode         */
  static const CL = 0x0009;           /* InOutMode Cancel Mode      */

  //使用している変数以外はコメントアウト
  /* TPR use CMEM->stat.ScrMode #define */
  static const ITM_DSP = 0x0000;           /* Item Display               */
  static const STL_DSP = 0x0010;           /* Subtotal Display           */
  static const INOUT_DSP = 0x0020;           /* In/Out Display             */
  static const SITM_DSP = 0x0030;           /* Sub Item Display           */
  static const CREF_DSP = 0x0040;           /* ACR/ACB ChgRef Display     */
  static const AUTO_DSP = 0x0050;           /* AutoChecker Display        */
  static const BADD_DSP = 0x0060;           /* AutoChecker Display        */
  static const TELST_DSP = 0x0090;           /* Member's Tellephone List   */
  static const CRDT_DSP = 0x00e0;           /* Credit Input Display       */
  static const CCIN_DSP = 0x0100;           /* ACB ChgCin Display         */
  static const STAFF_DSP = 0x0110;           /* Simple Staff Entry Display */
  static const TKISSU_DSP = 0x0120;           /* Ticket issue display       */
  static const EDY_DSP = 0x01b0;           /* Edy Input Display          */
  static const OFF_DSP = 0x01c0;           /* OffMode Display            */
  static const SCNMBR_DSP = 0x01d0;           /* ScnMbrMode Display         */
  static const SCNPRC_DSP = 0x01e0;           /* ScnPrcMode Display         */
  static const RFM_DSP = 0x0260;           /* Rfm Print Display          */

  static const    SG_STR_DSP =   0x0130   ;        /* Starting Display           */
  static const  RG_SG_STR  =  (SG_STR_DSP + RG) ;/* Reg. SG Starting Display   */
  static const   TR_SG_STR  =  (SG_STR_DSP + TR); /* Tra. SG Starting Display   */
  static const SG_INST_DSP = 0x0140;           /* Instruction Display        */
  static const RG_SG_INST = (SG_INST_DSP + RG);/* Reg. SG Instruction Display*/
  static const TR_SG_INST = (SG_INST_DSP + TR);/* Tra. SG Instruction Display*/

  static const SG_ITEM_DSP = 0x0150;           /* Item Display               */
  static const RG_SG_ITEM = (SG_ITEM_DSP + RG);/* Reg. SG Item Display       */
  static const TR_SG_ITEM = (SG_ITEM_DSP + TR);/* Tra. SG Item Display       */
  static const SG_OPE_DSP = 0x0160;           /* Operation Display          */
  static const RG_SG_OPE = (SG_OPE_DSP + RG);/* Reg. SG Operation Display  */
  static const TR_SG_OPE = (SG_OPE_DSP + TR);/* Tra. SG Operation Display  */
  static const SG_LIST_DSP = 0x0170;           /* Cash Display               */
  static const RG_SG_LIST = (SG_LIST_DSP + RG);/* Reg. SG Cash Display       */
  static const TR_SG_LIST = (SG_LIST_DSP + TR);/* Tra. SG Cash Display       */

  static const SG_PRE_DSP = 0x0180;           /* Preset Display             */
  static const RG_SG_PRE = (SG_PRE_DSP + RG); /* Reg. SG Preset Display     */
  static const TR_SG_PRE = (SG_PRE_DSP + TR); /* Tra. SG Preset Display     */
  static const SG_MNT_DSP = 0x0190;           /* Mentenanse display         */
  static const RG_SG_MNT = (SG_MNT_DSP + RG); /* Reg. SG Mnt Display        */
  static const TR_SG_MNT = (SG_MNT_DSP + TR); /* Tra. SG Mnt Display        */
  static const SG_END_DSP =  0x01a0;           /* End display                */
  static const  RG_SG_END  =  (SG_END_DSP + RG); /* Reg. SG End Display        */
  static const  TR_SG_END  = (SG_END_DSP + TR); /* Tra. SG End Display        */
  static const SG_MBRCHK_DSP = 0x02e0;           /* Member Check display       */
  static const RG_SG_MBRCHK = (SG_MBRCHK_DSP + RG); /* Reg. SG MbrChk Display  */
  static const TR_SG_MBRCHK = (SG_MBRCHK_DSP + TR); /* Tra. SG MbrChk Display  */
  static const SG_MBRSCN_DSP = 0x02f0;              /* Member Scan display        */
  static const RG_SG_MBRSCN = (SG_MBRSCN_DSP + RG); /* Reg. SG MbrScn Display  */
  static const TR_SG_MBRSCN = (SG_MBRSCN_DSP + TR); /* Tra. SG MbrScn Display  */
  static const SG_SLCT_DSP  =  0x03c0;                /* Select Cash or Crdt display  */
  static const  RG_SG_SLCT  = (SG_SLCT_DSP + RG);     /* Reg. SG Select Display       */
  static const  TR_SG_SLCT  = (SG_SLCT_DSP + TR);     /* Tra. SG Select Display       */
  static const SG_CRDTRD_DSP = 0x03d0 ;                /* Credit Card Read display     */
  static const  RG_SG_CRDTRD = (SG_CRDTRD_DSP + RG);   /* Reg. SG Crdt Read Display    */
  static const  TR_SG_CRDTRD = (SG_CRDTRD_DSP + TR);   /* Tra. SG Crdt Read Display    */
  static const  SG_ENDCRDT_DSP = 0x03e0;                /* End Credit display           */
  static const  RG_SG_ENDCRDT = (SG_ENDCRDT_DSP + RG);  /* Reg. SG End Credit Display   */
  static const  TR_SG_ENDCRDT = (SG_ENDCRDT_DSP + TR);  /* Tra. SG End Credit Display   */
  // #define    SG_USECRDT_DSP   0x03f0                /* Use Credit display           */
  // #define    RG_SG_USECRDT   (SG_USECRDT_DSP + RG)  /* Reg. SG Use Crdt Display     */
  // #define    TR_SG_USECRDT   (SG_USECRDT_DSP + TR)  /* Tra. SG Use Crdt Display     */
  // #define    SG_CRDTRENO_DSP  0x0400                /* Use Credit display           */
  // #define    RG_SG_CRDTRENO  (SG_CRDTRENO_DSP + RG) /* Reg. SG Use Crdt Display     */
  // #define    TR_SG_CRDTRENO  (SG_CRDTRENO_DSP + TR) /* Tra. SG Use Crdt Display     */
  static const   NEWSG_MDSLCT_DSP = 0x0410   ;              /* Mode Select Display         */
  static const    RG_NEWSG_MDSLCT = (NEWSG_MDSLCT_DSP + RG) ;/* Reg. SG Mode Select Display */
  static const  TR_NEWSG_MDSLCT = (NEWSG_MDSLCT_DSP + TR); /* Tra. SG Mode Select Display */
  // #define    NEWSG_POP_DSP    0x0420                 /* Pop Display                 */
  // #define    RG_NEWSG_POP    (NEWSG_POP_DSP + RG)    /* Reg. SG Pop Display         */
  // #define    TR_NEWSG_POP    (NEWSG_POP_DSP + TR)    /* Tra. SG Pop Display         */
  static const NEWSG_STRBTN_DSP = 0x0430;                 /* Start Button Display        */
  static const RG_NEWSG_STRBTN = (NEWSG_STRBTN_DSP + RG); /* Reg. SG StrBtn Display      */
  static const TR_NEWSG_STRBTN = (NEWSG_STRBTN_DSP + TR); /* Tra. SG StrBtn Display      */
  static const NEWSG_EXP_DSP  = 0x0440;                 /* Explain Display             */
  static const  RG_NEWSG_EXP = (NEWSG_EXP_DSP + RG);    /* Reg. SG Explain Display     */
  static const  TR_NEWSG_EXP = (NEWSG_EXP_DSP + TR);    /* Tra. SG Explain Display     */
  static const QC_SLCT_DSP = 0x09B0;             /* QCashier Select Input display    */
  static const RG_QC_SLCT = (QC_SLCT_DSP + RG);  /* Reg. SG QCashier Select Display  */
  static const TR_QC_SLCT = (QC_SLCT_DSP + TR);  /* Tra. SG QCashier Select Display  */
  static const QC_CASH_DSP = 0x09C0;                 /* QCashier Cash display        */
  static const RG_QC_CASH = (QC_CASH_DSP + RG);  /* Reg. SG QCashier Cash Display  */
  static const TR_QC_CASH = (QC_CASH_DSP + TR);  /* Tra. SG QCashier Cash Display  */
  static const SPD_DSP = 0x0360; /* Sapporo Drug Display */
  static const RG_SPD = (SPD_DSP + RG); /* Reg. Sapporo Drug Display */
  static const VD_SPD = (SPD_DSP + VD); /* Cor. Sapporo Drug Display */
  static const TR_SPD = (SPD_DSP + TR); /* Tra. Sapporo Drug Display */
  static const SR_SPD = (SPD_DSP + SR); /* Scr. Sapporo Drug Display */
  static const SG_EDYTCH_DSP = 0x0450;                /* Touch Edy display            */
  static const RG_SG_EDYTCH = (SG_EDYTCH_DSP + RG);   /* Reg. SG Touch Edy display    */
  static const TR_SG_EDYTCH = (SG_EDYTCH_DSP + TR);   /* Tra. SG Touch Edy display    */

  // #define    SG_USEEDY_DSP    0x0460                /* Use Edy display              */
  // #define    RG_SG_USEEDY    (SG_USEEDY_DSP + RG)   /* Reg. SG Use Edy display      */
  // #define    TR_SG_USEEDY    (SG_USEEDY_DSP + TR)   /* Tra. SG Use Edy display      */
  // #define    SG_ENDEDY_DSP    0x0470                /* End Edy display              */
  // #define    RG_SG_ENDEDY    (SG_ENDEDY_DSP + RG)   /* Reg. SG End Edy display      */
  // #define    TR_SG_ENDEDY    (SG_ENDEDY_DSP + TR)   /* Tra. SG End Edy display      */
  static const SG_EDYBAL_DSP = 0x04a0;                /* Balance Edy display             */
  static const RG_SG_EDYBAL = (SG_EDYBAL_DSP + RG);   /* Reg. SG Balance Edy display     */
  static const TR_SG_EDYBAL = (SG_EDYBAL_DSP + TR);   /* Tra. SG Balance Edy display     */

  static const SG_BALSLCT_DSP = 0x04b0;                /* Balance Display display         */
  static const RG_SG_BALSLCT = (SG_BALSLCT_DSP + RG);  /* Reg. SG Balance Display display */
  static const TR_SG_BALSLCT = (SG_BALSLCT_DSP + TR);  /* Tra. SG Balance Display display */

  static const SG_EDYALL_DSP = 0x04c0;                /* Pay All Edy display             */
  static const RG_SG_EDYALL = (SG_EDYALL_DSP + RG);   /* Reg. SG Pay All Edy display     */
  static const TR_SG_EDYALL = (SG_EDYALL_DSP + TR);   /* Tra. SG Pay All Edy display     */
  // #if MC_SYSTEM
  // #define    SG_MCRD_DSP      0x04e0                /* M&C system card read display    */
  // #define    RG_SG_MCRD      (SG_MCRD_DSP + RG)     /* Reg. M&C card read Edy display  */
  // #define    TR_SG_MCRD      (SG_MCRD_DSP + TR)     /* Tra. M&C card read Edy display  */
  // #endif
  static const SG_RWRD_DSP = 0x0550;                /* RWCard Read display        */
  static const RG_SG_RWRD = (SG_RWRD_DSP + RG);     /* Reg. SG RWRead Display  */
  static const TR_SG_RWRD = (SG_RWRD_DSP + TR);     /* Tra. SG RWRead Display  */
  static const SG_FLRD_DSP = 0x0570;                /* Felica Card Read display        */
  static const RG_SG_FLRD = (SG_FLRD_DSP + RG);     /* Reg. SG Felica Read Display     */
  static const TR_SG_FLRD = (SG_FLRD_DSP + TR);     /* Tra. SG Felica Read Display     */
  // #define    SG_FLWT_DSP      0x0580                /* Felica Card Write display       */
  // #define    RG_SG_FLWT      (SG_FLWT_DSP + RG)     /* Reg. SG Felica Write Display    */
  // #define    TR_SG_FLWT      (SG_FLWT_DSP + TR)     /* Tra. SG Felica Write Display    */

  static const SG_NPW_DSP = 0x0590;           /* Self Need Pass Word Display  */
  static const RG_SG_NPW = (SG_NPW_DSP + RG); /* Reg. Self NdPsWd Display     */
  static const TR_SG_NPW = (SG_NPW_DSP + TR); /* Tra. Self NdPsWd Display     */

  static const SG_EDY_BAL = 0x05A0;           /* Self Edy Balance Display  */
  static const RG_SG_EDY_BAL = (SG_EDY_BAL + RG); /* Reg. Self Edy Balance Display     */
  static const TR_SG_EDY_BAL = (SG_EDY_BAL + TR); /* Tra. Self Edy Balance Display     */
  static const SG_EDY_BALAF = 0x05B0;           /* Self Edy Balance After Display  */
  static const RG_SG_EDY_BALAF = (SG_EDY_BALAF + RG); /* Reg. Self Edy Balance After Display     */
  static const TR_SG_EDY_BALAF = (SG_EDY_BALAF + TR); /* Tra. Self Edy Balance After Display     */

  static const SG_SUICA_TCH = 0x0770;                   /* Self Suica Touch Mode Display          */
  static const RG_SG_SUICA_TCH = (SG_SUICA_TCH + RG);    /* Reg. Self Suica Touch Mode Display     */
  static const TR_SG_SUICA_TCH = (SG_SUICA_TCH + TR);    /* Tra. Self Suica Touch Mode Display     */
  static const SG_SUICA_CHK = 0x07B0;                   /* Self Suica Ckeck Bal Mode Display      */
  static const RG_SG_SUICA_CHK = (SG_SUICA_CHK + RG);    /* Reg. Self Suica Ckeck Bal Mode Display */
  static const TR_SG_SUICA_CHK = (SG_SUICA_CHK + TR);    /* Tra. Self Suica Ckeck Bal Mode Display */
  static const SG_SUICA_CHKAF = 0x07C0;                     /* Self Suica Bal Ckeck After Mode Display      */
  static const RG_SG_SUICA_CHKAF = (SG_SUICA_CHKAF + RG);  /* Reg. Self Suica Ckeck Bal After Mode Display */
  static const TR_SG_SUICA_CHKAF = (SG_SUICA_CHKAF + TR);  /* Tra. Self Suica Ckeck Bal After Mode Display */
  static const SG_MCP200_DSP = 0x0870;                 /* Self Mcp200 Card Read Mode Display      */
  static const RG_SG_MCP200_DSP = (SG_MCP200_DSP + RG);    /* Reg. Self Mcp200 Card Read Mode Display */
  static const TR_SG_MCP200_DSP = (SG_MCP200_DSP + TR);    /* Tra. Self Mcp200 Card Read Mode Display */
  static const SG_BAG_INP_DSP = 0x0910;                 /* SSPS Bag Input Display        */
  static const RG_SG_BAG_INP_DSP = (SG_BAG_INP_DSP + RG);  /* Reg. SSPS Bag Input Display   */
  static const TR_SG_BAG_INP_DSP = (SG_BAG_INP_DSP + TR);  /* Tra. SSPS Bag Input Display   */
  static const SG_DMC_SLCT_DSP = 0x0920;                /* DAIKI Mbr Card Select Display         */
  static const RG_SG_DMC_SLCT = (SG_DMC_SLCT_DSP + RG); /* Reg. SG DAIKI Mbr Card Select Display */
  static const TR_SG_DMC_SLCT = (SG_DMC_SLCT_DSP + TR); /* Tra. SG DAIKI Mbr Card Select Display */
  static const SG_MCP200_DSP_2 = 0x0930;                /* Mcp200 Card Read Mode Display         */
  static const RG_SG_MCP200_2 = (SG_MCP200_DSP_2 + RG); /* Reg. SG Mcp200 Card Read Mode Display */
  static const TR_SG_MCP200_2 = (SG_MCP200_DSP_2 + TR); /* Tra. SG Mcp200 Card Read Mode Display */
  static const SG_MBRSCN_DSP_2 = 0x0940;                /* Member Scan display                   */
  static const RG_SG_MBRSCN_2 = (SG_MBRSCN_DSP_2 + RG); /* Reg. SG MbrScn Display                */
  static const TR_SG_MBRSCN_2 = (SG_MBRSCN_DSP_2 + TR); /* Tra. SG MbrScn Display                */

  static const RG_ITM = ITM_DSP + RG;    /* Reg. Item Display          */
  static const RG_STL = (STL_DSP + RG);    /* Reg. Subtotal Display      */
  static const RG_INOUT = (INOUT_DSP + RG);  /* Reg. In/Out Display        */
  static const RG_SITM = (SITM_DSP + RG);   /* Reg. Sub Item Display      */
  static const RG_CREF = (CREF_DSP + RG);   /* Reg. ACR/ACB ChgRef Display*/
  static const RG_AUTO = (AUTO_DSP + RG);   /* Reg. AutoChecker Display   */
  static const RG_BADD = (BADD_DSP + RG);   /* Reg. AutoChecker Display   */
  static const RG_TELST = (TELST_DSP + RG);  /* Reg. Member's Tel List     */
  static const RG_CRDT = (CRDT_DSP + RG);   /* Reg. Credit Input Display  */
  static const RG_CCIN = (CCIN_DSP + RG);   /* Reg. ACB ChgCin Display    */
  static const RG_TKISSU = (TKISSU_DSP + RG); /* Reg. Ticket issue display  */
  static const RG_EDY = (EDY_DSP + RG);    /* Reg. Edy Input Display     */
  static const RG_OFF = (OFF_DSP + RG);    /* Reg. OffMode Display       */
  static const RG_SCNMBR = (SCNMBR_DSP + RG); /* Reg. ScnMbrMode Display    */
  static const RG_SCNPRC = (SCNPRC_DSP + RG); /* Reg. ScnPrcMode Display    */
  static const RG_PSP = (PSP_DSP + RG);    /* Reg. Psp Input Display     */
  static const RG_RFM = (RFM_DSP + RG);    /* Reg. Rfm print Display     */
  static const VD_ITM = ITM_DSP + VD;    /* Cor. Item Display          */
  static const VD_STL = STL_DSP + VD;    /* Cor. Subtotal Display      */
  static const VD_INOUT = (INOUT_DSP + VD);  /* Cor. In/Out Display        */
  static const VD_SITM = (SITM_DSP + VD);   /* Cor. Sub Item Display      */
  static const VD_CREF = (CREF_DSP + VD);   /* Cor. ACR/ACB ChgRef Display*/
  static const VD_AUTO = (AUTO_DSP + VD);   /* Cor. AutoChecker Display   */
  static const VD_BADD = (BADD_DSP + VD);   /* Cor. AutoChecker Display   */
  static const VD_TELST = (TELST_DSP + VD);  /* Cor. Member's Tel List     */
  static const VD_CRDT = (CRDT_DSP + VD);   /* Cor. Credit Input Display  */
  static const VD_CCIN = (CCIN_DSP + VD);   /* Cor. ACB ChgCin Display    */
  static const VD_TKISSU = (TKISSU_DSP + VD); /* Cor. Ticket issue display  */
  static const VD_EDY = (EDY_DSP + VD);    /* Cor. Edy Input Display     */
  static const VD_OFF = (OFF_DSP + VD);    /* Cor. OffMode Display       */
  static const VD_SCNMBR = (SCNMBR_DSP + VD); /* Cor. ScnMbrMode Display    */
  static const VD_SCNPRC = (SCNPRC_DSP + VD); /* Cor. ScnPrcMode Display    */
  static const VD_PSP = (PSP_DSP + VD);    /* Cor. Psp Input Display     */
  static const VD_RFM = (RFM_DSP + VD);    /* Reg. Rfm print Display     */
  static const TR_ITM = ITM_DSP + TR;    /* Tra. Item Display          */
  static const TR_STL = STL_DSP + TR;    /* Tra. Subtotal Display      */
  static const TR_INOUT = (INOUT_DSP + TR);  /* Tra. In/Out Display        */
  static const TR_SITM  = (SITM_DSP + TR);   /* Tra. Sub Item Display      */
  static const TR_CREF = (CREF_DSP + TR);   /* Tra. ACR/ACB ChgRef Display*/
  static const TR_AUTO = (AUTO_DSP + TR);   /* Tra. AutoChecker Display   */
  static const TR_BADD = (BADD_DSP + TR);   /* Tra. AutoChecker Display   */
  static const TR_TELST = (TELST_DSP + TR);  /* Tra. Member's Tel List     */
  static const TR_CRDT = (CRDT_DSP + TR);   /* Tra. Credit Input Display  */
  static const TR_CCIN = (CCIN_DSP + TR);   /* Tra. ACB ChgCin Display    */
  static const TR_TKISSU = (TKISSU_DSP + TR); /* Tra. Ticket issue display  */
  static const TR_EDY = (EDY_DSP + TR);    /* Tra. Edy Input Display     */
  static const TR_OFF = (OFF_DSP + TR);    /* Tra. OffMode Display       */
  static const TR_SCNMBR = (SCNMBR_DSP + TR); /* Tra. ScnMbrMode Display    */
  static const TR_SCNPRC = (SCNPRC_DSP + TR); /* Tra. ScnPrcMode Display    */
  static const TR_PSP = (PSP_DSP + TR);    /* Tra. Psp Input Display     */
  static const TR_RFM = (RFM_DSP + TR);    /* Reg. Rfm print Display     */
  static const SR_ITM = ITM_DSP + SR;    /* Scr. Item Display          */
  static const SR_STL = STL_DSP + SR;    /* Scr. Subtotal Display      */
  static const SR_INOUT = (INOUT_DSP + SR);  /* Scr. In/Out Display        */
  static const SR_SITM = (SITM_DSP + SR);  /* Scr. Sub Item Display      */
  static const SR_CREF = (CREF_DSP + SR);   /* Scr. ACR/ACB ChgRef Display*/
  static const SR_AUTO = (AUTO_DSP + SR);   /* Scr. AutoChecker Display   */
  static const SR_BADD = (BADD_DSP + SR);   /* Scr. AutoChecker Display   */
  static const SR_TELST = (TELST_DSP + SR);  /* Scr. Member's Tel List     */
  static const SR_CRDT = (CRDT_DSP + SR);   /* Scr. Credit Input Display  */
  static const SR_CCIN = (CCIN_DSP + SR);   /* Scr. ACB ChgCin Display    */
  static const SR_TKISSU = (TKISSU_DSP + SR); /* Scr. Ticket issue display  */
  static const SR_EDY = (EDY_DSP + SR);    /* Scr. Edy Input Display     */
  static const SR_OFF = (OFF_DSP + SR);    /* Scr. OffMode Display       */
  static const SR_SCNMBR = (SCNMBR_DSP + SR); /* Scr. ScnMbrMode Display    */
  static const SR_SCNPRC = (SCNPRC_DSP + SR); /* Scr. ScnPrcMode Display    */
  static const SR_PSP = (PSP_DSP + SR);    /* Scr. Psp Input Display     */
  static const SR_RFM = (RFM_DSP + SR);    /* Reg. Rfm print Display     */
  //
  static const OD_ITM = ITM_DSP + OD;    /* Odr. Item Display          */
  static const OD_STL = STL_DSP + OD;    /* Odr. Subtotal Display      */
  static const OD_SITM = (SITM_DSP + OD);   /* Odr. Sub Item Display      */
  static const OD_AUTO = (AUTO_DSP + OD);   /* Odr. AutoChecker Display   */
  // #define    OD_SCNMBR    (SCNMBR_DSP + OD) /* Odr. ScnMbrMode Display    */
  // #define    OD_SCNPRC    (SCNPRC_DSP + OD) /* Odr. ScnPrcMode Display    */
  static const IV_ITM = ITM_DSP + IV;    /* Inv. Item Display          */
  static const IV_STL = STL_DSP + IV;    /* Inv. Subtotal Display      */
  static const IV_SITM = (SITM_DSP + IV);   /* Inv. Sub Item Display      */
  static const IV_AUTO = (AUTO_DSP + IV);   /* Inv. AutoChecker Display   */
  // #define    IV_SCNMBR    (SCNMBR_DSP + IV) /* Inv. ScnMbrMode Display    */
  // #define    IV_SCNPRC    (SCNPRC_DSP + IV) /* Inv. ScnPrcMode Display    */
  static const PD_ITM = ITM_DSP + PD;    /* Pro. Item Display          */
  static const PD_STL = STL_DSP + PD;    /* Pro. Subtotal Display      */
  static const PD_SITM = (SITM_DSP + PD);   /* Pro. Sub Item Display      */
  static const PD_AUTO = (AUTO_DSP + PD);   /* Pro. AutoChecker Display   */
  // #define    PD_SCNMBR    (SCNMBR_DSP + PD) /* Pro. ScnMbrMode Display    */
  // #define    PD_SCNPRC    (SCNPRC_DSP + PD) /* Pro. ScnPrcMode Display    */

  static const QC_ITEM_DSP = 0x09A0;             /* QCashier Item Input display        */
  static const RG_QC_ITEM = (QC_ITEM_DSP + RG);  /* Reg. SG QCashier Item Display  */
  static const TR_QC_ITEM = (QC_ITEM_DSP + TR);  /* Tra. SG QCashier Item Display  */

  static const QP_DSP = 0x08F0;               /* QUICPay R/W Display      */
  static const RG_QP = (QP_DSP + RG);         /* Reg. QUICPay R/W Display */
  static const VD_QP = (QP_DSP + VD);         /* Cor. QUICPay R/W Display */
  static const TR_QP = (QP_DSP + TR);         /* Tra. QUICPay R/W Display */
  static const SR_QP = (QP_DSP + SR);         /* Scr. QUICPay R/W Display */

  static const ID_DSP = 0x0900;                /* QUICPay R/W Display      */
  static const RG_ID = (ID_DSP + RG);          /* Reg. iD R/W Display      */
  static const VD_ID = (ID_DSP + VD);          /* Cor. iD R/W Display      */
  static const TR_ID = (ID_DSP + TR);          /* Tra. iD R/W Display      */
  static const SR_ID = (ID_DSP + SR);          /* Scr. iD R/W Display      */

  static const QC_CRDT_DSP =  0x09E0;             /* QCashier Crdt display        */
  static const RG_QC_CRDT  = (QC_CRDT_DSP + RG);  /* Reg. SG QCashier Crdt Display  */
  static const TR_QC_CRDT  = (QC_CRDT_DSP + TR);  /* Tra. SG QCashier Crdt Display  */

  /************************************************************************/
  /*               Display Type [CMEM->stat.ScrType]                      */
  /************************************************************************/
  static const LCD_104Inch = 0x01;
  static const LCD_57Inch = 0x02;
  /************************************************************************/
  /*                       #define Check Digit Calc                       */
  /************************************************************************/
  static const CHKDGT_CALC = 1;

  /************************************************************************/
  /*                  "rcATCTProcCheckPassSet()" の引数                    */
  /************************************************************************/
  static const PASS_CHECK_ON = 1;
  static const PASS_CHECK_OFF	= 0;

  /* 予約関連項目 */
  /* 予約の種類 */
  static const RESERV_MODE_NON = 0;     /* 通常      */
  static const RESERV_MODE_RESERV = 1;  /* 予約      */
  static const RESERV_MODE_NET = 2;     /* ネット予約 */

  static const IN_STL = STL_DSP + IN;  /* In   Subtotal Display      */
  static const OU_STL = STL_DSP + OU;  /* Out  Subtotal Display      */

  /************************************************************************/
  /*                  #define datas Max Change Amount                     */
  /************************************************************************/
  static const maxChgAmt = 9999;

  /***********************************************************************/
  /*  アイテムログの商品種別(item_kind)                                      */
  /***********************************************************************/
  static const ITEM_KIND_FREEPRODUCT = 2;       //無償商品
  static const ITEM_KIND_COUPON	= 6;            //クーポン商品
  static const ITEM_KIND_LENDING = 7;           //貸出商品
  static const ITEM_KIND_MANAGE_LENDING = 8;    //管理貸出商品
  static const ITEM_KIND_WEIGHT_ITEM2 = 9;      //重量商品 (重量算出)
  static const ITEM_KIND_VOLUME = 10;           //体積算出
  static const ITEM_KIND_Z_TAX_EXEMPTION = 11;  //免税事業者

  /************************************************************************/
  /*               Bit flag "ACR_MODE" [CMEM->stat.acr_mode]              */
  /************************************************************************/
  static const GET_MODE = 0x01;  //Answer Get Mode
  static const POP_MODE = 0x02;  //Pop Window Mode

  /************************************************************************/
  /*                  #define datas Item Display Type2                    */
  /************************************************************************/
  static const OPE_START = 0;
  static const OPE_END = 1;

  /************************************************************************/
  /*                /// 関連tprxソース: L_rcregs.h                         */
  /************************************************************************/
  static const HALF_MSG_DISBURSE = "出  納";
  static const HALF_MSG_SELPLUADJ = "個別精算中";
}

/************************************************************************/
/*                      プリペイド仕様種類判定                              */
/* rcsyschk.dart                                                        */
/* rcChkPrecaTyp(), rcChkEntryPrecaTyp()の戻り値として使用                 */
/************************************************************************/
enum PRECA_TYPE{
  PRECA_COGCA(1),/* 1: CoGCa */
  PRECA_TRK(2),      /* 2: TRK Preca */
  PRECA_REPICA(3),   /* 3: Repica */
  PRECA_YUMECA(4),   /* 4: Yumeca */
  PRECA_VALUE(5),    /* 5: Value */
  PRECA_AJS(6),      /* 6: AJS(FujitsuFIP) */
  PRECA_NMONEY(7),           /* 7: NEC Money SM19 */
  PRECA_NMONEY_STD(8);        /* 8: NEC Money 標準 */

  final int precaTypeCd;
  const PRECA_TYPE(this.precaTypeCd);
}

// フラグ切替リスト
enum RC_FLG_TYPE {
  RC_FLG_SWITCH ,	// 現在とは異なるフラグにする
  RC_FLG_OFF,		  // フラグ OFF
  RC_FLG_ON;		  // フラグ ON
}