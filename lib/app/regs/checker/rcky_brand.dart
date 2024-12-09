/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:get/get.dart';

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/image.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmem_tmp.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/mcd.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/ex/L_tprdlg.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_img_read.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/page/workin/p_workin.dart';
import '../common/rxkoptcmncom.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_nttd_preca.dart';
import '../inc/rc_regs.dart';
import 'rc_apldlg.dart';
import 'liblary.dart';
import 'rc_crdt_fnc.dart';
import 'rc_ext.dart';
import 'rc_flrda.dart';
import 'rc_itm_dsp.dart';
import 'rc_obr.dart';
import 'rc_preca.dart';
import 'rc_qc_dsp.dart';
import 'rc_trk_preca.dart';
import 'rcdetect.dart';
import 'rcfncchk.dart';
import 'rckyccin.dart';
import 'rcqc_com.dart';
import 'rcqc_vfhd_dsp.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';
import 'regs.dart';

class RcKyBrand {
  static String brnd1Name = "";
  static String brnd2Name = "";
  static String brnd3Name = "";
  static String brnd4Name = "";
  static String brnd5Name = "";
  static String brnd6Name = "";
  static String labelBuf = "";

  ///  関連tprxソース: rcky_brand.c - FncCode1~6
  static FuncKey fncCode1 = FuncKey.KY_NONE;
  static FuncKey fncCode2 = FuncKey.KY_NONE;
  static FuncKey fncCode3 = FuncKey.KY_NONE;
  static FuncKey fncCode4 = FuncKey.KY_NONE;
  static FuncKey fncCode5 = FuncKey.KY_NONE;
  static FuncKey fncCode6 = FuncKey.KY_NONE;

  ///  関連tprxソース: rcky_brand.c - rcKy_Brnd
  static Future<void> rcKyBrnd(FuncKey fncCode) async {
    int errNo = 0;
    RcInfoMemLists rcInfoMem = RcInfoMemLists();

    errNo = await rcChkKyBrnd(fncCode);
    if (errNo == Typ.OK) {
      await RcKyccin.rcOthConnectAcrAcbStop();
      switch (fncCode) {
        case FuncKey.KY_BRND_CHA:
          rcPrgKyBrndCha();
          break;
        case FuncKey.KY_BRND_REF:
          rcPrgKyBrndRef();
          break;
        case FuncKey.KY_WORKIN:
          if (RcSysChk.rcChkRalseCardSystem()) {
            await rcPrgKyWorkIn();
          } else if (rcInfoMem.rcRecog.recogTrkPreca != 0) {
            rcPrgKyWorkInTRKPreca();
          } else if (rcInfoMem.rcRecog.recogRepicaSystem != 0) {
            rcPrgKyWorkInRepica();
          } else if (rcInfoMem.rcRecog.recogCogcaSystem != 0) {
            rcPrgKyWorkInCogca();
          } else if (rcInfoMem.rcRecog.recogValuecardSystem != 0) {
            rcPrgKyWorkInValueCard();
          } else if (rcInfoMem.rcRecog.recogAjsEmoneySystem != 0) {
            rcPrgKyWorkInAjsEmoney();
          }
          break;
        default:
          break;
      }
    } else {
      await RcExt.rcErr("rcKyBrnd", errNo);
      MsgDialog.show(MsgDialog.singleButtonDlgId(type: MsgDialogType.error, dialogId: errNo));
    }
  }

  ///  関連tprxソース: rcky_brand.c - rcDetect_Preca_Ref
  static Future<void> rcDetectPrecaRef() async {
    String callFunc = "RckyBrand.rcDetectPrecaRef()";
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "$callFunc: rxMemPtr() error");
      return;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();

    TprLog().logAdd(
        await RcSysChk.getTid(), LogLevelDefine.error, "$callFunc: touched");
    RcApldlg.rcAplDlgClear();

    if (tsBuf.nttdPreca.stat == NttdPrecaResultRx.NTTD_PRECA_KEY_NG.cd) {
      cMem.ent.errNo = DlgConfirmMsgKind.MSG_PRECA_KEY_NG.dlgId;
      await RcExt.rcErr(callFunc, cMem.ent.errNo);
      return;
    }

    if (RcSysChk.rcVDOpeModeChk()) {
      cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPEMERR_CUSTOMERCARD.dlgId;
      await RcExt.rcErr(callFunc, cMem.ent.errNo);
    }
    else {
      mem.tmpbuf.workInType = 3;
      await RcPreca.rcKyPrecaRef();
      await rcWorkInMbrTypRedisp();
    }
  }

  ///  関連tprxソース: rcky_brand.c - rcWorkIn_MbrTyp_Redisp
  static Future<void> rcWorkInMbrTypRedisp() async {
    if (await RcFncChk.rcCheckStlMode()) {
      switch (await RcSysChk.rcKySelf()) {
        case RcRegs.DESKTOPTYPE:
        case RcRegs.KY_CHECKER:
        case RcRegs.KY_DUALCSHR:
          await RcStlLcd.rcStlLcdMbrInfo(RegsDef.subttl);
          break;
        case RcRegs.KY_SINGLE:
          await RcStlLcd.rcStlLcdMbrInfo(RegsDef.subttl);
          if (FbInit.subinitMainSingleSpecialChk()) {
            await RcStlLcd.rcStlLcdMbrInfo(RegsDef.dualSubttl);
          }
          break;
        default:
          break;
      }
    }
    else if (await RcFncChk.rcCheckItmMode()) {
      await RcItmDsp.rcDspMbrmkLCD();
      if ((await RcSysChk.rcKySelf() == RcRegs.KY_SINGLE) &&
          FbInit.subinitMainSingleSpecialChk()) {
        await RcStlLcd.rcStlLcdMbrInfo(RegsDef.dualSubttl);
      }
    }
  }

  ///  関連tprxソース: rcky_brand.c - rcPrg_Arcs_Vega_Ky_Work_In
  static Future<void> rcPrgArcsVegaKyWorkIn() async {
    DlgParamMem workIn = DlgParamMem();
    String titleName = "";
    String crbtnName = "";

    brnd3Name = "";

    await RcObr.rcScanDisable();

    if ((await RcSysChk.rcChkShopAndGoSystem()) &&
        (RcQcCom.qc_now_lang_typ != QcLang.QC_LANG_JP.index)) {
      /* 他言語用INI移し変え */
      RcQcVfhdDsp.rcQcSagFontLangChg(RcQcCom.qc_now_lang_typ);
      /* INIから文言を取得 */
      labelBuf = RcQcVfhdDsp.rcQcSagGetIniLabel(
          RcQcVfhdDsp.VFHD_WORD_SECTION_ARCSPAYDSP, VfhdArcsPayDspWordElement.VFHD_ARCSTPAYDSP_WORD_TITLE.index);
      titleName = labelBuf;
    }
    else {
      AplLibImgRead.aplLibImgRead(FuncKey.KY_WORKIN.keyId, titleName, 16);
    }
    workIn.dialogPtn = 1;
    workIn.titlInfo.title = titleName;
    workIn.titlInfo.titleColor = "SB";  //SB: Sky Blue = const Color(0xff9999ff).value;
    workIn.titlInfo.charColor = "BG";  //BG: Black Gray = const Color(0xff333333).value;
    _rcSetWorkInBtn(workIn, 1);
    _rcSetWorkInBtn(workIn, 2);

    if ((await RcSysChk.rcChkShopAndGoSystem()) &&
        (RcQcCom.qc_now_lang_typ != QcLang.QC_LANG_JP.index)) {
      /* INIから文言を取得 */
      labelBuf = RcQcVfhdDsp.rcQcSagGetIniLabel(
          RcQcVfhdDsp.VFHD_WORD_SECTION_ARCSPAYDSP, VfhdArcsPayDspWordElement.VFHD_ARCSPAYDSP_WORD_CASH_PAY.index);
      brnd3Name = labelBuf;
    }
    else {
      brnd3Name = LTprDlg.BTN_CASH_PAYMENT;
    }
    workIn.botnInfo[2].func = _rcClrKyBrndDlg;
    workIn.botnInfo[2].msg = brnd3Name;
    workIn.botnInfo[2].btnColor  = "MG";  //MG Midium Gray = const Color(0xff999999).value;
    workIn.botnInfo[2].charColor = "WH";  //WH: White = const Color(0xffffffff).value;
    RcApldlg.rcAplDlg(workIn);
  }

  ///  関連tprxソース: rcky_brand.c - rcSet_WorkIn_Btn
  static void _rcSetWorkInBtn(DlgParamMem workIn, int workInType) {
    switch (workInType) {
      case 1:
        brnd1Name = "";
        AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_PRECA_IN, brnd1Name, 10);
        workIn.botnInfo[0].func = _rcDetectPrecaIn;
        workIn.botnInfo[0].msg = brnd1Name;
        workIn.botnInfo[0].btnColor = "MG";  //MG Midium Gray = const Color(0xff999999).value;
        workIn.botnInfo[0].charColor = "WH";  //WH: White = const Color(0xffffffff).value;
        break;
      case 2:
        brnd2Name = "";
        AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_HOUSE_IN, brnd2Name, 10);
        workIn.botnInfo[1].func = _rcDetectHouseIn;
        workIn.botnInfo[1].msg = brnd2Name;
        workIn.botnInfo[1].btnColor = "MG";  //MG Midium Gray = const Color(0xff999999).value;
        workIn.botnInfo[1].charColor = "WH";  //WH: White = const Color(0xffffffff).value;
        break;
      case 3:
        brnd3Name = "";
        AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_HOUSE_IN, brnd3Name, 10);
        workIn.botnInfo[2].func = rcDetectPrecaRef;
        workIn.botnInfo[2].msg = brnd3Name;
        workIn.botnInfo[2].btnColor = "MG";  //MG Midium Gray = const Color(0xff999999).value;
        workIn.botnInfo[2].charColor = "WH";  //WH: White = const Color(0xffffffff).value;
        break;
      default:
        break;
    }
  }

  ///  関連tprxソース: rcky_brand.c - rcDetect_Preca_In
  static Future<void> _rcDetectPrecaIn() async {
    String callFunc = "RckyBrand._rcDetectPrecaIn()";
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "$callFunc: rxMemPtr() error");
      return;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    RegsMem mem = SystemFunc.readRegsMem();

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "$callFunc touched");
    RcApldlg.rcAplDlgClear();

    if (tsBuf.nttdPreca.stat == NttdPrecaResultRx.NTTD_PRECA_KEY_NG.cd) {
      cMem.ent.errNo = DlgConfirmMsgKind.MSG_PRECA_KEY_NG.dlgId;
      await RcExt.rcErr(callFunc, cMem.ent.errNo);
      return;
    }
    if (atSing.limitAmount != 0) {
      if (atSing.mbrCdBkup == mem.tmpbuf.rcarddata.chkcd) {
        cMem.ent.errNo = DlgConfirmMsgKind.MSG_CARD_NOT_SAME.dlgId;
        await RcExt.rcErr(callFunc, cMem.ent.errNo);
        return;
      }
    }
    if (RcSysChk.rcVDOpeModeChk()) {
      cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPEMERR_CUSTOMERCARD.dlgId;
      await RcExt.rcErr(callFunc, cMem.ent.errNo);
    }
    else {
      mem.tmpbuf.workInType = 1;
      await rcWorkInMbrTypRedisp();
    }
  }

  ///  関連tprxソース: rcky_brand.c - rcDetect_House_In
  static Future<void> _rcDetectHouseIn() async {
    String callFunc = "RckyBrand._rcDetectHouseIn()";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "$callFunc touched");

    RegsMem mem = SystemFunc.readRegsMem();

    mem.tmpbuf.workInType = 2;
    RcApldlg.rcAplDlgClear();
    await rcWorkInMbrTypRedisp();
  }

  ///  関連tprxソース: rcky_brand.c - rcClr_Ky_Brnd_Dlg
  static Future<void> _rcClrKyBrndDlg() async {
    String callFunc = "RckyBrand._rcClrKyBrndDlg()";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "$callFunc touched");
    RegsMem mem = SystemFunc.readRegsMem();

    RcApldlg.rcAplDlgClear();
    if (RcSysChk.rcChkRalseCardSystem()) {
      mem.tmpbuf.workInType = 0;
      await rcWorkInMbrTypRedisp();
    }
    if (RcRegs.rcInfoMem.rcRecog.recogRepicaSystem != 0) {
      mem.tmpbuf.workInType = 0;
      mem.tmpbuf.repica.card = RxMemRepicaCard();
    }
    if ((RcRegs.rcInfoMem.rcRecog.recogTrkPreca != 0)
        || (RcRegs.rcInfoMem.rcRecog.recogRepicaSystem != 0)
        || (RcRegs.rcInfoMem.rcRecog.recogCogcaSystem != 0)
        || (RcRegs.rcInfoMem.rcRecog.recogValuecardSystem != 0)
        || (RcRegs.rcInfoMem.rcRecog.recogAjsEmoneySystem != 0) ) {
      RcTrkPreca.rcSusRegEtcRedisp();
    }
  }

  /// 関連tprxソース: rcky_brand.c - rcChk_Ky_Brnd
  static Future<int> rcChkKyBrnd(FuncKey fncCode) async {
    int errNo = Typ.OK;
    RcInfoMemLists rcInfoMem = RcRegs.rcInfoMem;
    AcMem cMem = SystemFunc.readAcMem();

    if (fncCode == FuncKey.KY_WORKIN) {
      if (RcSysChk.rcChkRalseCardSystem()) {
        errNo = await rcChkKyWorkIn();
        return errNo;
      } else if (rcInfoMem.rcRecog.recogTrkPreca != 0) {
        errNo = await rcChkKyWorkInTrkPreca();
        return errNo;
      } else if (rcInfoMem.rcRecog.recogRepicaSystem != 0) {
        errNo = await rcChkKyWorkInRepica();
        return errNo;
      } else if (rcInfoMem.rcRecog.recogCogcaSystem != 0) {
        errNo = await rcChkKyWorkInCogca();
        return errNo;
      } else if (rcInfoMem.rcRecog.recogValuecardSystem != 0) {
        errNo = await rcChkKyWorkInValueCard();
        return errNo;
      } else if (rcInfoMem.rcRecog.recogAjsEmoneySystem != 0) {
        errNo = await rcChkKyWorkInAjsEmoney();
        return errNo;
      }
    }

    if ((fncCode != FuncKey.KY_BRND_CHA) && (fncCode != FuncKey.KY_BRND_REF)) {
      errNo = DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }
    if ((errNo == 0) && (!await rcChkMultiRwConnect(fncCode))) {
      errNo = DlgConfirmMsgKind.MSG_EXPLOIT_CONDITION_NG.dlgId;
    }
    if ((errNo == 0) &&
        (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) &&
        (!await RcSysChk.rcCheckQCJCSystem())) {
      errNo = DlgConfirmMsgKind.MSG_OPEMISS.dlgId;
    }
    if ((errNo == 0) &&
        (!(RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk()))) {
      errNo = DlgConfirmMsgKind.MSG_OPEMERR_REGI.dlgId;
    }
    if ((errNo == 0) && (RcSysChk.rcCheckKyIntIn(true))) {
      errNo = DlgConfirmMsgKind.MSG_OPEINTERERR.dlgId;
    }
    if (await RcKyccin.rcChkAcbCinAct() != 0) {
      errNo = DlgConfirmMsgKind.MSG_ACBACT.dlgId;
    }
    if (errNo == 0) {
      Liblary.cmFil(cMem.keyChkb, 0xff, cMem.keyChkb.length);
      if (fncCode == FuncKey.KY_BRND_CHA) {
        if (!RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId])) {
          errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
        }
        if ((errNo == 0) && (RcCrdtFnc.payPrice() <= 0)) {
          errNo = DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
        }
        RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_RMOD.keyId);
      } else {
        if ((RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId])) &&
            (!await RcFncChk.rcCheckStlMode())) {
          errNo = DlgConfirmMsgKind.MSG_SUBTTLFCE.dlgId;
        }
      }
      if (errNo == 0) {
        RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_CLR.keyId);
        RcRegs.kyStR1(cMem.keyChkb, FncCode.KY_REG.keyId);
        if (await RcFncChk.rcCheckStlMode()) {
          RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_STL.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FncCode.KY_FNAL.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHK1.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHK2.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHK3.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHK4.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHK5.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CASH.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA1.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA2.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA3.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA4.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA5.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA6.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA7.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA8.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA9.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA10.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA11.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA12.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA13.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA14.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA15.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA16.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA17.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA18.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA19.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA20.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA21.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA22.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA23.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA24.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA25.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA26.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA27.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA28.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA29.keyId);
          RcRegs.kyStR2(cMem.keyChkb, FuncKey.KY_CHA30.keyId);
        }
      }
      if (RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3) != 0) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }
    return errNo;
  }

  /// 関連tprxソース: rcky_brand.c - rcChk_Ky_Work_In
  static Future<int> rcChkKyWorkIn() async {
    int errNo = Typ.OK;
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = RegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    // 全タスク共通メモリが読み込めない場合はエラー
    if (xRet.isInvalid()) {
      return Typ.NG;
    }
    RxCommonBuf cBuf = xRet.object;

    if (!RcFncChk.rcCheckRegistration()) {
      errNo = DlgConfirmMsgKind.MSG_EXPLOIT_CONDITION_NG.dlgId;
    }

    if (mem.tTtllog.t100700.mbrInput == MbrInputType.mbrprcKeyInput.index) {
      errNo = DlgConfirmMsgKind.MSG_EXPLOIT_CONDITION_NG.dlgId;
    }

    if (mem.tTtllog.t100700Sts.mbrTyp != Mcd.MCD_RLSCARD) {
      errNo = DlgConfirmMsgKind.MSG_EXPLOIT_CONDITION_NG.dlgId;
    }
    if (mem.tmpbuf.rcarddata.jis2.isNotEmpty) {
      if ((mem.tmpbuf.rcarddata.jis2[28] != '8') &&
          (cBuf.dbTrm.arksNewCardChk != 0)) {
        errNo = DlgConfirmMsgKind.MSG_USERTYPE_ERR.dlgId;
      }
    } else {
      errNo = DlgConfirmMsgKind.MSG_EXPLOIT_CONDITION_NG.dlgId;
    }

    if (errNo == 0) {
      Liblary.cmFil(cMem.keyChkb, 0xff, cMem.keyChkb.length);
      RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_CLR.keyId);
      RcRegs.kyStR1(cMem.keyChkb, FncCode.KY_REG.keyId);
      RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_STL.keyId);
      RcRegs.kyStR1(cMem.keyStat, FuncKey.KY_RMOD.keyId);
      if (RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3) != 0) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }

    if (await RcKyccin.rcChkAcbCinAct() != 0) {
      errNo = DlgConfirmMsgKind.MSG_ACBACT.dlgId;
    }

    return errNo;
  }

  /// 関連tprxソース: rcky_brand.c - rcChk_Ky_Work_In_TRK_Preca
  static Future<int> rcChkKyWorkInTrkPreca() async {
    int errNo = Typ.OK;
    AcMem cMem = SystemFunc.readAcMem();

    if (errNo == 0 &&
        (!(RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk()))) {
      errNo = DlgConfirmMsgKind.MSG_OPEMERR_REGI.dlgId;
    }

    if (errNo == 0) {
      Liblary.cmFil(cMem.keyChkb, 0xff, cMem.keyChkb.length);
      RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_CLR.keyId);
      RcRegs.kyStR1(cMem.keyChkb, FncCode.KY_REG.keyId);
      RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_STL.keyId);
      RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_RMOD.keyId);
      if (RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3) != 0) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }

    if (await RcKyccin.rcChkAcbCinAct() != 0) {
      errNo = DlgConfirmMsgKind.MSG_ACBACT.dlgId;
    }

    return errNo;
  }

  /// 関連tprxソース: rcky_brand.c - rcChk_Ky_Work_In_Repica
  static Future<int> rcChkKyWorkInRepica() async {
    int errNo = Typ.OK;
    AcMem cMem = SystemFunc.readAcMem();

    if (errNo == 0 &&
        (!(RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk()))) {
      errNo = DlgConfirmMsgKind.MSG_OPEMERR_REGI.dlgId;
    }

    if (errNo == 0) {
      Liblary.cmFil(cMem.keyChkb, 0xff, cMem.keyChkb.length);
      RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_CLR.keyId);
      RcRegs.kyStR1(cMem.keyChkb, FncCode.KY_REG.keyId);
      RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_STL.keyId);
      RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_RMOD.keyId);
      if (RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3) != 0) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }

    if (await RcKyccin.rcChkAcbCinAct() != 0) {
      errNo = DlgConfirmMsgKind.MSG_ACBACT.dlgId;
    }

    return errNo;
  }

  /// 関連tprxソース: rcky_brand.c - rcChk_Ky_Work_In_Cogca
  static Future<int> rcChkKyWorkInCogca() async {
    int errNo = Typ.OK;
    AcMem cMem = SystemFunc.readAcMem();

    if (errNo == 0 &&
        (!(RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk()))) {
      errNo = DlgConfirmMsgKind.MSG_OPEMERR_REGI.dlgId;
    }

    if (errNo == 0) {
      Liblary.cmFil(cMem.keyChkb, 0xff, cMem.keyChkb.length);
      RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_CLR.keyId);
      RcRegs.kyStR1(cMem.keyChkb, FncCode.KY_REG.keyId);
      RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_STL.keyId);
      RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_RMOD.keyId);
      if (RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3) != 0) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }

    if (await RcKyccin.rcChkAcbCinAct() != 0) {
      errNo = DlgConfirmMsgKind.MSG_ACBACT.dlgId;
    }

    return errNo;
  }

  /// 関連tprxソース: rcky_brand.c - rcChk_Ky_Work_In_ValueCard
  static Future<int> rcChkKyWorkInValueCard() async {
    int errNo = Typ.OK;
    AcMem cMem = SystemFunc.readAcMem();

    if (errNo == 0 &&
        (!(RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk()))) {
      errNo = DlgConfirmMsgKind.MSG_OPEMERR_REGI.dlgId;
    }

    if (errNo == 0) {
      Liblary.cmFil(cMem.keyChkb, 0xff, cMem.keyChkb.length);
      RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_CLR.keyId);
      RcRegs.kyStR1(cMem.keyChkb, FncCode.KY_REG.keyId);
      RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_STL.keyId);
      RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_RMOD.keyId);
      if (RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3) != 0) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }

    if (await RcKyccin.rcChkAcbCinAct() != 0) {
      errNo = DlgConfirmMsgKind.MSG_ACBACT.dlgId;
    }

    return errNo;
  }

  /// 関連tprxソース: rcky_brand.c - rcChk_Ky_Work_In_Ajs_Emoney
  static Future<int> rcChkKyWorkInAjsEmoney() async {
    int errNo = Typ.OK;
    AcMem cMem = SystemFunc.readAcMem();

    if (errNo == 0 &&
        (!(RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk()))) {
      errNo = DlgConfirmMsgKind.MSG_OPEMERR_REGI.dlgId;
    }

    if (errNo == 0) {
      Liblary.cmFil(cMem.keyChkb, 0xff, cMem.keyChkb.length);
      RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_CLR.keyId);
      RcRegs.kyStR1(cMem.keyChkb, FncCode.KY_REG.keyId);
      RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_STL.keyId);
      RcRegs.kyStR1(cMem.keyChkb, FuncKey.KY_RMOD.keyId);
      if (RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3) != 0) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }

    if (await RcKyccin.rcChkAcbCinAct() != 0) {
      errNo = DlgConfirmMsgKind.MSG_ACBACT.dlgId;
    }

    return errNo;
  }

  /// 関連tprxソース: rcky_brand.c - rcChk_Multi_RW_Connect
  static Future<bool> rcChkMultiRwConnect(FuncKey fncCode) async {
    int count = 0;
    if (fncCode == FuncKey.KY_BRND_CHA) {
      count = await rcGetMultiBrndCha();
    } else {
      count = await rcGetMultiBrndRef();
    }

    if (count > 1) {
      return true;
    } else {
      return false;
    }
  }

  /// 関連tprxソース: rcky_brand.c - rcGet_Multi_Brnd_Cha
  static Future<int> rcGetMultiBrndCha() async {
    int count;

    count = 0;
    if (await RcSysChk.rcChkMultiEdySystem() != 0) {
      count++;
    }
    if (await RcSysChk.rcChkMultiQPSystem() != 0) {
      count++;
    }
    if (await RcSysChk.rcChkMultiiDSystem() != 0) {
      count++;
    }
    if (await RcSysChk.rcChkSPVTSystem()) {
      count++;
    }
    return count;
  }

  /// 関連tprxソース: rcky_brand.c - rcGet_Multi_Brnd_Ref
  static Future<int> rcGetMultiBrndRef() async {
    int count;

    count = 0;
    if (await RcSysChk.rcChkMultiEdySystem() != 0) {
      count += 2;
    }
    return count;
  }

  // TODO: 松岡 フロント処理のため、定義のみ追加
  /// 会計1~30, 品券1~5, 支払い方法選択の種別選択画面
  /// 関連tprxソース: rcky_brand.c - rcPrg_Ky_Brnd_Cha
  static void rcPrgKyBrndCha() {
    return;
  }

  // TODO: 松岡 フロント処理のため、定義のみ追加
  /// 会計1~30, 品券1~5, 支払い方法選択の電子マネーの残高照会画面
  /// 関連tprxソース: rcky_brand.c - rcPrg_Ky_Brnd_Ref
  static void rcPrgKyBrndRef() {
    return;
  }

  /// 業務宣言画面に遷移
  /// 関連tprxソース: rcky_brand.c - rcPrg_Ky_Work_In
  static Future<void> rcPrgKyWorkIn() async {
    bool inPrecaRef = false;
    if ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
        (await RcSysChk.rcCheckQCJCSystem())) {
      inPrecaRef = true;
    }
    Get.to(() => WorkInScreen(inPrecaRef: inPrecaRef));
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcPrg_Ky_Work_In_TRK_Preca
  static void rcPrgKyWorkInTRKPreca() {
    MsgDialog.showNotImplDialog();
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcPrg_Ky_Work_In_Repica
  static void rcPrgKyWorkInRepica() {
    MsgDialog.showNotImplDialog();
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcPrg_Ky_Work_In_Cogca
  static void rcPrgKyWorkInCogca() {
    MsgDialog.showNotImplDialog();
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcPrg_Ky_Work_In_ValueCard
  static void rcPrgKyWorkInValueCard() {
    MsgDialog.showNotImplDialog();
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcPrg_Ky_Work_In_Ajs_Emoney
  static void rcPrgKyWorkInAjsEmoney() {
    MsgDialog.showNotImplDialog();
    return;
  }

  /// 業務宣言画面のプリカ宣言ボタン押下時
  /// カードのタイプをプリカに設定する
  /// 関連tprxソース: rcky_brand.c - rcDetect_Preca_In
  static Future<void> rcDetectPrecaIn() async {
    const String funcName = "rcDetectPrecaIn";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.warning,
        "rcDetectPrecaIn() touched\n");
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = RegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    // 全タスク共通メモリが読み込めない場合はエラー
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcDetectPrecaIn: rxMemRead is invalid.\n");
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AtSingl atSing = SystemFunc.readAtSingl();

    // ダイアログのクリアはフロントで行っているためコメントアウト
    // RcApldlg.rcAplDlgClear();

    if (tsBuf.nttdPreca.stat == NttdPrecaResultRx.NTTD_PRECA_KEY_NG.cd) {
      cMem.ent.errNo = DlgConfirmMsgKind.MSG_PRECA_KEY_NG.dlgId;
      await RcExt.rcErr(funcName, cMem.ent.errNo);
      return;
    }

    if (atSing.limitAmount != 0) {
      if (atSing.mbrCdBkup == mem.tmpbuf.rcarddata.chkcd) {
        cMem.ent.errNo = DlgConfirmMsgKind.MSG_CARD_NOT_SAME.dlgId;
        await RcExt.rcErr(funcName, cMem.ent.errNo);
        return;
      }
    }

    if (RcSysChk.rcVDOpeModeChk()) {
      cMem.ent.errNo = DlgConfirmMsgKind.MSG_OPEMERR_CUSTOMERCARD.dlgId;
      await RcExt.rcErr(funcName, cMem.ent.errNo);
    } else {
      mem.tmpbuf.workInType = 1;
      await rcWorkInMbrTypRedisp();
    }

    return;
  }

  /// 業務宣言画面のハウス宣言ボタン押下時、
  /// カードのタイプをハウスクレジットに設定する
  /// 関連tprxソース: rcky_brand.c - rcDetect_House_In
  static Future<void> rcDetectHouseIn() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.warning,
        "rcDetectHouseIn() touched\n");
    RegsMem mem = RegsMem();

    mem.tmpbuf.workInType = 2;
    // ダイアログのクリアはフロントで行っているためコメントアウト
    // RcApldlg.rcAplDlgClear();
    await rcWorkInMbrTypRedisp();
  }

  /// 関連tprxソース: rcky_brand.c - rcDetect_Brnd_Key1
  static Future<void> rcDetectBrndKey1() async {
    // ダイアログのクリア処理
    RcApldlg.rcAplDlgClear();

    if (fncCode1 != FuncKey.KY_NONE) {
      await RcDetect.rcAplDlgDetect(fncCode1);
    }
  }

  /// 関連tprxソース: rcky_brand.c - rcDetect_Brnd_Key2
  static Future<void> rcDetectBrndKey2() async {
    // ダイアログのクリア処理
    RcApldlg.rcAplDlgClear();

    if (fncCode2 != FuncKey.KY_NONE) {
      await RcDetect.rcAplDlgDetect(fncCode2);
    }
  }

  /// 関連tprxソース: rcky_brand.c - rcDetect_Brnd_Key3
  static Future<void> rcDetectBrndKey3() async {
    // ダイアログのクリア処理
    RcApldlg.rcAplDlgClear();

    if (fncCode3 != FuncKey.KY_NONE) {
      await RcDetect.rcAplDlgDetect(fncCode3);
    }
  }

  /// 関連tprxソース: rcky_brand.c - rcDetect_Brnd_Key4
  static Future<void> rcDetectBrndKey4() async {
    // ダイアログのクリア処理
    RcApldlg.rcAplDlgClear();

    if (fncCode4 != FuncKey.KY_NONE) {
      await RcDetect.rcAplDlgDetect(fncCode4);
    }
  }

  /// 関連tprxソース: rcky_brand.c - rcDetect_Brnd_Key5
  static Future<void> rcDetectBrndKey5() async {
    // ダイアログのクリア処理
    RcApldlg.rcAplDlgClear();

    if (fncCode1 != FuncKey.KY_NONE) {
      await RcDetect.rcAplDlgDetect(fncCode5);
    }
  }

  /// 関連tprxソース: rcky_brand.c - rcDetect_Brnd_Key6
  static Future<void> rcDetectBrndKey6() async {
    // ダイアログのクリア処理
    RcApldlg.rcAplDlgClear();

    if (fncCode6 != FuncKey.KY_NONE) {
      await RcDetect.rcAplDlgDetect(fncCode6);
    }
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcSet_WorkIn_Btn_TRK_Preca
  static void rcSetWorkInBtnTRKPreca() {
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcDetect_TRK_Preca_In
  static void rcDetectTRKPrecaIn() {
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcDetect_TRK_Preca_Ref
  static void rcDetectTRKPrecaRef() {
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcSet_WorkIn_Btn_Repica
  static void rcSetWorkInBtnRepica(DlgParamMem workIn, int workInType) {
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcDetect_Repica_In
  static void rcDetectRepicaIn() {
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcDetect_Repica_Ref
  static void rcDetectRepicaRef() {
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcDetect_Repica_TC
  static void rcDetectRepicaTC() {
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcSet_WorkIn_Btn_Cogca
  static void rcSetWorkInBtnCogca(DlgParamMem workIn, int workInType) {
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcDetect_Cogca_In
  static void rcDetectCogcaIn() {
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcDetect_Cogca_Ref
  static void rcDetectCogcaRef() {
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcSet_WorkIn_Btn_ValueCard
  static void rcSetWorkInBtnValueCard(DlgParamMem workIn, int workInType) {
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcDetect_ValueCard_In
  static void rcDetectValueCardIn() {
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcDetect_ValueCard_Ref
  static void rcDetectValueCardRef() {
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcSet_WorkIn_Btn_Ajs_Emoney
  static void rcSetWorkInBtnAjsEmoney(DlgParamMem workIn, int workInType) {
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcDetect_Ajs_Emoney_In
  static void rcDetectAjsEmoneyIn() {
    return;
  }

  // TODO: 松岡 実装は必要だがARKS様対応では除外のため、定義のみ追加
  /// 関連tprxソース: rcky_brand.c - rcDetect_Ajs_Emoney_Ref
  static void rcDetectAjsEmoneyRef() {
    return;
  }

  /// 関連tprxソース: rcky_brand.c - rcSet_Multi_RW_Apl
  static Future<int> rcSetMultiRWApl(FuncKey fncCode) async {
    int i = 0;
    int cnt = 0;
    KopttranBuff kopttran = KopttranBuff();

    if (fncCode == FuncKey.KY_BRND_CHA) {
      /* Rxkoptcmncom.rxkindChaList[] = { 会計1~30, 品券1~5, -1 } */
      for (i = 0; Rxkoptcmncom.rxkindChaList[i] != -1; i++) {
        if (RcSysChk.rcChkKYCHA(Rxkoptcmncom.rxkindChaList[i])) {
          await RcFlrda.rcReadKopttran(Rxkoptcmncom.rxkindChaList[i], kopttran);
          if ((await RcSysChk.rcChkMultiEdySystem() != 0) &&
              (kopttran.crdtEnbleFlg == 1) &&
              (kopttran.crdtTyp ==
                  SPTEND_STATUS_LISTS.SPTEND_STATUS_MULTI_EDY.typeCd)) {
            cnt++;
            if (fncCode1 == FuncKey.KY_NONE) {
              fncCode1 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode2 == FuncKey.KY_NONE) {
              fncCode2 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode3 == FuncKey.KY_NONE) {
              fncCode3 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode4 == FuncKey.KY_NONE) {
              fncCode4 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode5 == FuncKey.KY_NONE) {
              fncCode5 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode6 == FuncKey.KY_NONE) {
              fncCode6 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            }
          }
          if ((await RcSysChk.rcChkMultiQPSystem() != 0) &&
              (kopttran.crdtEnbleFlg == 1) &&
              (kopttran.crdtTyp ==
                  SPTEND_STATUS_LISTS.SPTEND_STATUS_MULTI_QUICPAY.typeCd)) {
            cnt++;
            if (fncCode1 == FuncKey.KY_NONE) {
              fncCode1 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode2 == FuncKey.KY_NONE) {
              fncCode2 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode3 == FuncKey.KY_NONE) {
              fncCode3 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode4 == FuncKey.KY_NONE) {
              fncCode4 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode5 == FuncKey.KY_NONE) {
              fncCode5 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode6 == FuncKey.KY_NONE) {
              fncCode6 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            }
          }
          if ((await RcSysChk.rcChkMultiiDSystem() != 0) &&
              (kopttran.crdtEnbleFlg == 1) &&
              (kopttran.crdtTyp ==
                  SPTEND_STATUS_LISTS.SPTEND_STATUS_MULTI_ID.typeCd)) {
            cnt++;
            if (fncCode1 == FuncKey.KY_NONE) {
              fncCode1 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode2 == FuncKey.KY_NONE) {
              fncCode2 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode3 == FuncKey.KY_NONE) {
              fncCode3 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode4 == FuncKey.KY_NONE) {
              fncCode4 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode5 == FuncKey.KY_NONE) {
              fncCode5 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode6 == FuncKey.KY_NONE) {
              fncCode6 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            }
          }
          if ((await RcSysChk.rcChkSPVTSystem()) &&
              (kopttran.crdtEnbleFlg == 1) &&
              (kopttran.crdtTyp ==
                  SPTEND_STATUS_LISTS.SPTEND_STATUS_FCL_VISA.typeCd)) {
            cnt++;
            if (fncCode1 == FuncKey.KY_NONE) {
              fncCode1 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode2 == FuncKey.KY_NONE) {
              fncCode2 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode3 == FuncKey.KY_NONE) {
              fncCode3 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode4 == FuncKey.KY_NONE) {
              fncCode4 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode5 == FuncKey.KY_NONE) {
              fncCode5 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            } else if (fncCode6 == FuncKey.KY_NONE) {
              fncCode6 = FuncKey.values.firstWhere(
                  (element) => element.keyId == Rxkoptcmncom.rxkindChaList[i]);
            }
          }
        }
      }
    } else {
      if (await RcSysChk.rcChkMultiEdySystem() != 0) {
        cnt += 2;
        fncCode1 = FuncKey.KY_EDYREF;
        fncCode2 = FuncKey.KY_EDYHIST;
      }
    }
    return (cnt);
  }
}
