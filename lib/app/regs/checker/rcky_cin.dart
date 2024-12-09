/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/drv/ffi/library.dart';
import 'package:flutter_pos/app/inc/apl/compflag.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/lib/if_acx.dart';
import 'package:flutter_pos/app/inc/lib/typ.dart';
import 'package:flutter_pos/app/regs/checker/rc_acracb.dart';
import 'package:flutter_pos/app/regs/checker/rc_advancein.dart';
import 'package:flutter_pos/app/regs/checker/rc_clxos_changer.dart';
import 'package:flutter_pos/app/regs/checker/rc_ewdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rc_flrda.dart';
import 'package:flutter_pos/app/regs/checker/rc_ifevent.dart';
import 'package:flutter_pos/app/regs/checker/rc_ifprint.dart';
import 'package:flutter_pos/app/regs/checker/rc_inout.dart';
import 'package:flutter_pos/app/regs/checker/rc_itm_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_recno.dart';
import 'package:flutter_pos/app/regs/checker/rc_set.dart';
import 'package:flutter_pos/app/regs/checker/rc_setdate.dart';
import 'package:flutter_pos/app/regs/checker/rc_stl.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcinoutdsp.dart';
import 'package:flutter_pos/app/regs/checker/rcky_pick.dart';
import 'package:flutter_pos/app/regs/checker/rcky_prc.dart';
import 'package:flutter_pos/app/regs/checker/rcky_rfm.dart';
import 'package:flutter_pos/app/regs/checker/rcky_rpr.dart';
import 'package:flutter_pos/app/regs/checker/rckyccin.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:flutter_pos/app/lib/cm_chg/bcdtol.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:get/get.dart';
import 'package:flutter_pos/app/inc/lib/if_th.dart';
import 'package:flutter_pos/app/lib/apllib/apllib_auto.dart';
import 'package:flutter_pos/app/lib/cm_ary/chk_spc.dart';
import 'package:flutter_pos/app/lib/if_acx/acx_cend.dart';
import 'package:flutter_pos/app/lib/if_acx/ecs_cend.dart';
import 'package:flutter_pos/app/lib/if_acx/acx_cread.dart';
import 'package:flutter_pos/app/lib/if_acx/acx_csta.dart';
import 'package:flutter_pos/app/lib/if_acx/ecs_creadg.dart';

import '../../../clxos/calc_api_result_data.dart';
import '../../common/cmn_sysfunc.dart';
import '../../if/if_changer_isolate.dart';
import '../../if/if_drv_control.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff_keyopt.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/if_acx/acx_cend.dart';
import '../../lib/if_acx/acx_coin.dart';
import '../../lib/if_acx/acx_com.dart';
import '../../lib/if_acx/acx_cstp.dart';
import '../../sys/sale_com_mm/rept_ejconf.dart';
import '../acx/rc_acx.dart';
import '../common/rxkoptcmncom.dart';
import '../../ui/page/change_coin/controller/c_changecoinin_controller.dart';
import '../inc/rc_if.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_reserv.dart';
import 'rckyccin_acb.dart';

class RckyCin {
/*----------------------------------------------------------------------*
 * Constant Values
 *----------------------------------------------------------------------*/
  static List<int> lumpCin0 = [
    FncCode.KY_REG.keyId,
    FncCode.KY_ENT.keyId,
    FuncKey.KY_MAN.keyId,
    FuncKey.KY_SEN.keyId,
    FuncKey.KY_5SEN.keyId,
    // 以下は釣機入金からコピー
    FuncKey.KY_CHGPOST.keyId,
    FuncKey.KY_CULAY1.keyId,
    FuncKey.KY_CULAY2.keyId,
    FuncKey.KY_CULAY3.keyId,
    FuncKey.KY_CULAY4.keyId,
    FuncKey.KY_CULAY5.keyId,
    FuncKey.KY_CULAY6.keyId,
    FuncKey.KY_CULAY7.keyId,
    FuncKey.KY_CULAY8.keyId,
    FuncKey.KY_CULAY9.keyId,
    FuncKey.KY_CULAY10.keyId,
    0
  ];
  static const List<int> lumpCin1 = [0];
  static const List<int> lumpCin2 = [0];
  static const List<int> lumpCin3 = [0];
  static const List<int> lumpCin4 = [0];
  static List<int> diffCin0 = [
    FncCode.KY_REG.keyId,
    FncCode.KY_ENT.keyId,
    FuncKey.KY_PLU.keyId,
    0
  ];
  static const List<int> diffCin1 = [0];
  static const List<int> diffCin2 = [0];
  static const List<int> diffCin3 = [0];
  static const List<int> diffCin4 = [0];
  static List<int> rsvCin0 = [
    FncCode.KY_REG.keyId,
    0
  ];
  static const List<int> rsvCin1 = [0];
  static const List<int> rsvCin2 = [0];
  static const List<int> rsvCin3 = [0];
  static const List<int> rsvCin4 = [0];

  static InOutInfo inOut = InOutInfo();
  static KoptinoutBuff koptInOut = KoptinoutBuff();
  static TprLog myLog = TprLog();

//static ChangeCoinInInputController? changeCoinInCtrl;

  static get changerIsolateCtrl => null;

  static int amount = 0;
  static int changerRet = 0;
  static int cinAmount = 0;
  static CinData cinData = CinData();

  static bool isDecideCinAmount = false;
  static bool isCancel = false;

  static Timer? timer;

  ///  関連tprxソース: rcky_cin.c - rcKyCin
  static Future<void> rcKyCin() async {
    isDecideCinAmount = false;
    isCancel = false;

    if (CompileFlag.RESERV_SYSTEM) {
      if (await rcReservCinChk() ||  await RcAdvanceIn.rcChkAdvanceIn()) {
        await rcReservCin();
        return;
      }
    }
    if (await rcDrwChgCinChk()) {
      await rcDrwChgCin();
      return;
    }
    AcMem cMem = SystemFunc.readAcMem();

    if ((await CmCksys.cmNetDoAreservSystem() != 0) &&
        (cMem.stat.fncCode == FuncKey.KY_CIN15.keyId)) {
      cMem.ent.errNo = await rcCheckKynetDoARsvCin(0);
      if (cMem.ent.errNo != 0) {
        await ReptEjConf.rcErr("rcKyCin", cMem.ent.errNo);
      } else {
        await RcAdvanceIn.rcAdvanceInAdj();
      }
      return;
    }

    cMem.ent.errNo = await rcCheckKyCin(0);
    if (cMem.ent.errNo == 0) {
      await RcFlrda.rcReadKoptinout(cMem.stat.fncCode, koptInOut);
      cMem.ent.errNo = await rcKyLumpCin();
    }
    if (cMem.ent.errNo != 0) {
      await ReptEjConf.rcErr("_decideCinAmount", cMem.ent.errNo);
    }
    cinAmount = 0;
    // 入金開始!
    int startType = 0;
    if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_777) != 0) {
      startType = 3;
    }
    await RcAcracb.rcAcrAcbCinStartDtl(startType);
    // タイマーセット（入金状態更新）
    timer = Timer.periodic(const Duration(milliseconds: 1000), _onTimer);
  }

  /// 関数名     :
  /// 機能概要   :キーステータスのチェック関数
  /// 呼出方法   :
  /// パラメータ :
  /// 戻り値     : short chkCtrlFlg
  ///            : 0以外で特定のチェック処理を除外する
  ///            : 除外対象はチェックではない箇所（実績等メモリ作成部分）や通信関連、周辺機へのアクション等時間を要するもの
  ///            : 0:標準のキー押下時のチェック  0以外:キー押下前の動作可能かのチェック
  ///  関連tprxソース: rcky_cin.c - rcCheck_Ky_Cin
  static Future<int> rcCheckKyCin(int chkCtrlFlg) async {
    int ret;

    if ((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) && (!await RcSysChk.rcCheckQCJCSystem())) {
      return (DlgConfirmMsgKind.MSG_DO_DESKTOPSIDE.dlgId);
    }

    AcMem cMem = SystemFunc.readAcMem();

    //釣銭機が動作するキーのチェック
    switch (FuncKey.getKeyDefine(cMem.stat.fncCode)) {
      case FuncKey.KY_CHGCIN: //釣機入金は入金確定必須。よって釣銭釣札機接続でないと動作しない。
        if (await RcAcracb.rcCheckAcrAcbON(1) != CoinChanger.ACR_COINBILL) {
          // 釣札機接続でない
          return (RcAcracb.rcCheckAcrAcbOFFType(1));
        }
        if ((!await RcSysChk.rcChkAutoDecisionSystem()) && (!await RcSysChk.rcChkManuDecisionSystem())) {
          return (DlgConfirmMsgKind.MSG_ACB_DECCIN_NEED.dlgId);
        }
        break;
      default:
        break;
    }
    if (RcSysChk.rcChkTRDrwAcxNotUse()) {
      return (DlgConfirmMsgKind.MSG_TR_ACX_NOTUSE.dlgId); //練習モードでの釣銭機「禁止」に設定されています
    }

    cMem.keyChkb = List.filled(cMem.keyChkb.length, 0xff);
    List<int> p = [];
    int i;
    p = lumpCin0; i = 0; while(p[0+i] != 0) { RcRegs.kyStR0(cMem.keyChkb, i); i++; }
    p = lumpCin1; i = 0; while(p[0+i] != 0) { RcRegs.kyStR1(cMem.keyChkb, i); i++; }
    p = lumpCin2; i = 0; while(p[0+i] != 0) { RcRegs.kyStR2(cMem.keyChkb, i); i++; }
    p = lumpCin3; i = 0; while(p[0+i] != 0) { RcRegs.kyStR3(cMem.keyChkb, i); i++; }
    p = lumpCin4; i = 0; while(p[0+i] != 0) { RcRegs.kyStR4(cMem.keyChkb, i); i++; }
    p = diffCin0; i = 0; while(p[0+i] != 0) { RcRegs.kyStR0(cMem.keyChkb, i); i++; }
    p = diffCin1; i = 0; while(p[0+i] != 0) { RcRegs.kyStR1(cMem.keyChkb, i); i++; }
    p = diffCin2; i = 0; while(p[0+i] != 0) { RcRegs.kyStR2(cMem.keyChkb, i); i++; }
    p = diffCin3; i = 0; while(p[0+i] != 0) { RcRegs.kyStR3(cMem.keyChkb, i); i++; }
    p = diffCin4; i = 0; while(p[0+i] != 0) { RcRegs.kyStR4(cMem.keyChkb, i); i++; }
    ret = RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3);
    if (ret != 0) {
      return (RcEwdsp.rcSetDlgAddDataKeyStatusResult(ret));
    }
    return(Typ.OK);
  }

  /// 関数名     :
  /// 機能概要   : 画面表示チェックし画面表示を行う
  /// 呼出方法   :
  /// パラメータ :
  /// 戻り値     :
  ///  関連tprxソース: rcky_cin.c - rcKy_LumpCin
  static Future<int> rcKyLumpCin() async {
    int errNo = rcChkLumpCin(0);

    if (errNo == 0) {
      AcMem cMem = SystemFunc.readAcMem();
      AtSingl atSingle = SystemFunc.readAtSingl();

      if ((!await RcFncChk.rcCheckStlMode()) && (!RcFncChk.rcCheckSItmMode())) {
        if (!ChkSpc.cmChkSpc(cMem.scrData.subibuf, cMem.scrData.subibuf.length)) {
          await RcItmDsp.rcDspEntLCD();
          await RcItmDsp.rcQtyClr();
        }
      }
      if ((await RcFncChk.rcCheckStlMode())
          && (!(RcFncChk.rcCheckRegistration()))) {
        atSingle.fselfInoutChk = 1; // 常時入金仕様時、このタイミングで釣銭機をIN状態にさせない為
        RcItmDsp.rcItemScreen();
      }
      rcEditKeyData();
      await rcPrgLumpCin();
      RcRegs.kyStS0(cMem.keyStat, inOut.fncCode); // Set Bit 0 of KY_CIN?
      RcRegs.kyStS0(cMem.keyStat, FncCode.KY_REG.keyId); // Set Bit 0 of FncCode.KY_REG.keyId
      if (koptInOut.frcSelectFlg == 1 &&
          (cMem.stat.fncCode != FuncKey.KY_CHGCIN.keyId)) {
        // 金種別登録する
        await Rcinoutdsp.rcInOutDifferentDisp(Inout_Disp_Type.INOUT_DISP_NOMAL);
      } else {
        // 金種別登録する以外
        await Rcinoutdsp.rcInOutDifferentDisp(Inout_Disp_Type.INOUT_DISP_NEW_IN);
      }
    }

    return (errNo);
  }

  /// 関数名     :
  /// 機能概要   : 登録画面の表示チェック
  /// 呼出方法   :
  /// パラメータ :
  /// 戻り値     : short chkCtrlFlg
  ///            : 0以外で特定のチェック処理を除外する
  ///            : 除外対象はチェックではない箇所（実績等メモリ作成部分）や通信関連、周辺機へのアクション等時間を要するもの
  ///            : 0:標準のキー押下時のチェック  0以外:キー押下前の動作可能かのチェック
  ///  関連tprxソース: rcky_cin.c - rcChk_LumpCin()
  static int rcChkLumpCin(int chkCtrlFlg) {
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSingle = SystemFunc.readAtSingl();
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRetC.object;

    // マミーマート様向け仕様
    if (RcSysChk.rcChkMammyMartSystem()) {
      // 桁解除が無効な場合
      if (atSingle.beamReleaseFlg == 0) {
        // Put on Over ?
        if ((cMem.ent.tencnt > 8) || (cMem.ent.tencnt > koptInOut.digit)) {
          return (DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
        }
        // 金額制限確認
        if (RcKyPrc.rcKyPriceLimitChk(
            Bcdtol.cmBcdToL(cMem.ent.entry.sublist(3)),
            Rxkoptcmncom.rxChkKoptPrcAmtLimit(cBuf)) != 0) {
          return (DlgConfirmMsgKind.MSG_PRICEOVER.dlgId);
        }
      }
    }
    else {
      if ((cMem.ent.tencnt > koptInOut.digit)) {
        // Put on Over ?
        return (DlgConfirmMsgKind.MSG_INPUTOVER.dlgId);
      }

      // 金種別登録する かつ 置数中
      if ((koptInOut.frcSelectFlg == 1) && (cMem.ent.tencnt != 0)) {
        return (DlgConfirmMsgKind.MSG_OPEERR.dlgId);
      }
    }

    return (Typ.OK);
  }

  /// 関数名     :
  /// 機能概要   : ドロアオープン
  /// 呼出方法   :
  /// パラメータ :
  /// 戻り値     :
  ///  関連tprxソース: rcky_cin.c - rcPrg_LumpCin()
  static Future<int> rcPrgLumpCin() async {
    if (koptInOut.frcSelectFlg == 1) {
      //金種別登録する->ドロア開けて入金
      await Rcinoutdsp.rcInoutDrawOpen(0);
    }
    await RcExt.cashStatSet("rcPrgLumpCin");

    RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetS.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRetS.object;
    tsBuf.cash.inout_flg = 1;

    return(0);
  }

  ///  関連tprxソース: rcky_cin.c - rcPrc_LumpCin()
  static void rcPrcLumpCin(int type) {
    Uint8List entry = Uint8List(4);

    rcEditKeyData();

    AcMem cMem = SystemFunc.readAcMem();

    if (type == 0) {
      entry = cMem.ent.entry.sublist(3);
      inOut.Pdata.TotalPrice = Bcdtol.cmBcdToL(entry);
    }
    else {
      inOut.Pdata.TotalPrice = cMem.acbData.totalPrice;
    }
    cMem.scrData.price = inOut.Pdata.TotalPrice;
    RcSet.rcClearEntry();
  }

  ///  関連tprxソース: rcky_cin.c - rcEnd_LumpCin()
  static Future<int> rcEndLumpCin() async {
    int errNo = Typ.OK;
    int errStat = 0;
    String callFunc = 'rcEndLumpCin';

    RegsMem regsMem = SystemFunc.readRegsMem();
    AtSingl atSingle = SystemFunc.readAtSingl();
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
    }
    RxCommonBuf cBuf = xRetC.object;

    if (regsMem.tTtllog.t100001.qty != 0) {
      switch (await RcSysChk.rcKySelf()) {
        case RcRegs.DESKTOPTYPE :
        case RcRegs.KY_CHECKER :
        case RcRegs.KY_DUALCSHR :
        case RcRegs.KY_SINGLE :
          await RcItmDsp.rcQtyClr();
          break;
      }
    }

    await rcInputTotalDsp();
    await rcUpdateLumpCin();
    errNo = await RcFncChk.rcChkRPrinter();
    if (errNo != Typ.OK) {
      await ReptEjConf.rcErr("rcEndLumpCin", errNo);
      RcIfEvent.rcSendUpdate();
      rcEndKyCin();
    }
    else {
      atSingle.rctChkCnt = 0;
      await RcExt.rxChkModeSet("rcEndLumpCin");
      CalcResultChanger retData = await RcClxosChanger.changerIn(cBuf);
      errNo = retData.retSts!;
      if (0 != retData.retSts) {
        await ReptEjConf.rcErr("rcEndLumpCin", errNo);
        errNo = Typ.OK;
        errStat = 1;
      }
      else {
        // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
        await IfTh.printReceipt(await RcSysChk.getTid(), retData.digitalReceipt, callFunc);
      }
      errNo = RcIfEvent.rcSendUpdate();
      if ((errNo != 0) || (errStat != 0)) {
        rcEndKyCin();
        await RcExt.rxChkModeReset("rcEndLumpCin");
      }
      else {
        RckyRpr.rcWaitResponce(inOut.fncCode);
      }
    }
    // マミーマート様向け仕様
    if (RcSysChk.rcChkMammyMartSystem()) {
      if (atSingle.beamReleaseFlg == 1) {
        // 入金終了毎に桁解除を無効にする。
        atSingle.beamReleaseFlg = 0;
        await RcItmDsp.rcDspSusmkLCD(); // 桁解除表示消去
      }
    }
    return (errNo);
  }

  ///  関連tprxソース: rcky_cin.c - rcUpdate_LumpCin()
  static Future<void> rcUpdateLumpCin() async {
    await rcUpdateLumpEdit();
    if (await RcAcracb.rcCheckAcrAcbON(1) != 0) {
      await RcAcracb.rcAcrAcbStockUpdate(1);
    }
  }

  ///  関連tprxソース: rcky_cin.c - rcUpdate_LumpEdit()
  static Future<void> rcUpdateLumpEdit() async {
    CBillKind cCinSht = CBillKind();
    RegsMem regsMem = SystemFunc.readRegsMem();
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRetC.object;

    RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL); // Ttl Buffer All Clear
    regsMem.tHeader.inout_flg = RcInOut.TTLLOG_IN_FLAG; // IN flag
    regsMem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_CIN.index;
    await RcRecno.rcSetRctJnlNo();
    await RcSetDate.rcSetDate();
    regsMem.tTtllog.t105200.inCd = inOut.fncCode;
    regsMem.tTtllog.t105200Sts.chgInoutAmt = inOut.Pdata.TotalPrice;
    if ((await CmCksys.cmMarutoSystem() != 0) && (FuncKey.getKeyDefine(inOut.fncCode) == FuncKey.KY_CIN15)) {
      RcKyccin.rcAcrAcbCcinShtSet(cCinSht);
      regsMem.tTtllog.t105200Sts.mny10000Sht = cCinSht.bill10000;
      regsMem.tTtllog.t105200Sts.mny5000Sht = cCinSht.bill5000;
      regsMem.tTtllog.t105200Sts.mny2000Sht = cCinSht.bill2000;
      regsMem.tTtllog.t105200Sts.mny1000Sht = cCinSht.bill1000;
      regsMem.tTtllog.t105200Sts.mny500Sht = cCinSht.coin500;
      regsMem.tTtllog.t105200Sts.mny100Sht = cCinSht.coin100;
      regsMem.tTtllog.t105200Sts.mny50Sht = cCinSht.coin50;
      regsMem.tTtllog.t105200Sts.mny10Sht = cCinSht.coin10;
      regsMem.tTtllog.t105200Sts.mny5Sht = cCinSht.coin5;
      regsMem.tTtllog.t105200Sts.mny1Sht = cCinSht.coin1;
    }

    rcUpdateDiffEditCin();

    if ((await CmCksys.cmMarutoSystem() != 0) && (FuncKey.getKeyDefine(inOut.fncCode) == FuncKey.KY_CIN15)) {
      regsMem.tTtllog.t105200.sht10000 = regsMem.tTtllog.t105200Sts.mny10000Sht;
      regsMem.tTtllog.t105200.sht5000 = regsMem.tTtllog.t105200Sts.mny5000Sht;
      regsMem.tTtllog.t105200.sht2000 = regsMem.tTtllog.t105200Sts.mny2000Sht;
      regsMem.tTtllog.t105200.sht1000 = regsMem.tTtllog.t105200Sts.mny1000Sht;
      regsMem.tTtllog.t105200.sht500 = regsMem.tTtllog.t105200Sts.mny500Sht;
      regsMem.tTtllog.t105200.sht100 = regsMem.tTtllog.t105200Sts.mny100Sht;
      regsMem.tTtllog.t105200.sht50 = regsMem.tTtllog.t105200Sts.mny50Sht;
      regsMem.tTtllog.t105200.sht10 = regsMem.tTtllog.t105200Sts.mny10Sht;
      regsMem.tTtllog.t105200.sht5 = regsMem.tTtllog.t105200Sts.mny5Sht;
      regsMem.tTtllog.t105200.sht1 = regsMem.tTtllog.t105200Sts.mny1Sht;
    }

    //何か手動で作成する在高がある場合はこの処理以前に行うこと。この処理で在高に対するky_cd等を自動割振しています。
    await Rcinoutdsp.rcInOutLumpAmtSetCmn(1, koptInOut, inOut.Pdata.TotalPrice, 0);

    if ((cBuf.dbTrm.revenueStampPayFlg == 0) && (koptInOut.restmpFlg != 0)) {
      rcRfmData();
    }
  }

  static Future<int> rcEndCin() async {
    int changerRet = 0;
    AcMem cMem = SystemFunc.readAcMem();
    debugPrint("call rcAcrAcbCinStop");
    changerRet = await RcAcracb.rcAcrAcbCinStopDtl();
    if (changerRet == 0) {
      changerRet = await RckyccinAcb.rcAcrAcbStopWait2(0);
    }
    debugPrint("call rcAcrAcbCinEnd");
    changerRet = await RcAcracb.rcAcrAcbCinEndDtl();
    if (changerRet == 0) {
      changerRet = await RckyccinAcb.rcAcrAcbStopWait2(1);
    }
    cMem.keyStat[cMem.stat.fncCode] = 0;
    return changerRet;
  }

  ///  関連tprxソース: rcky_cin.c - rcEnd_DifferentCin
  static Future<(int, int)> rcEndDifferentCin(int type, int step, int chgData0) async {
    int errNo = Typ.OK;
    int errStat = 0;
    int chgData = 0; //INOUT_DISP_NEW_INのお釣り
    int totalDspChk = 0;
    String callFunc = 'rcEndDifferentCin';

    step = 0;

    Rcinoutdsp.rcCalDifferentTtl();

    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSingle = SystemFunc.readAtSingl();
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
    }
    RxCommonBuf cBuf = xRetC.object;

    if ((cMem.scrData.price == 0) && (cMem.acbData.ccinPrice == 0)) {
     return (DlgConfirmMsgKind.MSG_TRC_TTL_ZERO.dlgId, step);
    }

    //金種別登録以外であれば
    if (koptInOut.frcSelectFlg != 1) {
      chgData = inOut.InOutBtn[InoutDisp.INOUT_Y2000].Amount;
      if (chgData < 0) {
        return (DlgConfirmMsgKind.MSG_NOMINUSERR.dlgId, step); //お釣りがマイナスは禁止
      }
    }

    //釣銭機が接続されており、金種別登録以外であればお釣りEntryの値を出金
    if ((await RcAcracb.rcCheckAcrAcbON(1) != 0) && (koptInOut.frcSelectFlg != 1)) {
      //お釣り出金
      errNo = await RcAcracb.rcPrgAcrAcbChangeOut(chgData0);
      if (errNo != Typ.OK) {
        return (errNo, step);
      }
      await RcKyccin.rcEndKeyChgCinDecision("rcEndDifferentCin");
    }

    if (await RcSysChk.rcKySelf() != RcRegs.KY_DUALCSHR) {
      totalDspChk = 1;
    }
    else {
      if (await RcSysChk.rcChkDesktopCashier()) {
        totalDspChk = 1;
      }
    }

    if (totalDspChk == 1) {
      await rcInputTotalDsp();
    }

    await rcUpdateDiffCin(type); //実績メモリ作成

    step = 1; //これ以降、エラー発生後も入出金画面は消去

    RegsMem regsMem = SystemFunc.readRegsMem();
    regsMem.tTtllog.t105200Sts.chgInoutAmt = cinAmount - chgData0;  // 釣銭機投入額 - おつり = 最終入金額

    errNo = await RcFncChk.rcChkRPrinter();
    if (errNo != Typ.OK) {
      await ReptEjConf.rcErr("rcEndDifferentCin", errNo);
      RcKyPick.rcChkKopttranUpdateDiff();
      rcEndKyCin();
    }
    else {
      atSingle.rctChkCnt = 0;
      await RcExt.rxChkModeSet("rcEndDifferentCin");
      CalcResultChanger retData = await RcClxosChanger.changerIn(cBuf);
      errNo = retData.retSts!;
      if (0 != errNo) {
        await ReptEjConf.rcErr("rcEndDifferentCin", errNo);
        errNo = Typ.OK;
        errStat = 1;
      } else {
        // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
        await IfTh.printReceipt(await RcSysChk.getTid(), retData.digitalReceipt, callFunc);
      }
      errNo = RcKyPick.rcChkKopttranUpdateDiff();
      if ((errNo != 0) || (errStat != 0)) {
        rcEndKyCin();
        await RcExt.rxChkModeReset("rcEndDifferentCin");
      }
      else {
        if (inOut.fncCode != 0) {
          RckyRpr.rcWaitResponce(inOut.fncCode);
        }
        else {
          RckyRpr.rcWaitResponce(FuncKey.KY_CIN1.keyId);
        }
      }
    }
    return (errNo, step);
  }

  ///  関連tprxソース: rcky_cin.c - rcUpdate_DiffCin()
  static Future<void> rcUpdateDiffCin(int type) async {
    rcUpdateDiffEdit(type);
    if (await RcAcracb.rcCheckAcrAcbON(1) != 0) {
      await RcAcracb.rcAcrAcbStockUpdate(1);
    }
  }

  ///  関連tprxソース: rcky_cin.c - rcUpdate_PrnTypeEdit()
  static void rcUpdatePrnTypeEdit(int type) {
    RegsMem regsMem = SystemFunc.readRegsMem();
    PrnterControlTypeIdx enumValue = PrnterControlTypeIdx.values[type];
    switch (enumValue) {
      case PrnterControlTypeIdx.TYPE_RCPT: //指定なし
        regsMem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_CIN.index;
        break;
      case PrnterControlTypeIdx.TYPE_CCHG:
        regsMem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_CCIN.index;
        break;
      default: //指定あり
        regsMem.tHeader.prn_typ = type;
        break;
    }
  }

  ///  関連tprxソース: rcky_cin.c - rcUpdate_DiffEdit()
  static Future<void> rcUpdateDiffEdit(int type) async {
    int tendData = 0; //INOUT_DISP_NEW_INのお預り
    int chgData = 0; //INOUT_DISP_NEW_INのお釣り
    int amtData = 0;
    String log = "";
    CBillKind cCinSht = CBillKind();
    PrnterControlTypeIdx enumValue = PrnterControlTypeIdx.values[type];

    if (inOut.dispType >= Inout_Disp_Type.INOUT_DISP_NEW_IN) {
      tendData = inOut.InOutBtn[InoutDisp.INOUT_Y5000].Amount;
      chgData = inOut.InOutBtn[InoutDisp.INOUT_Y2000].Amount;
      inOut.InOutBtn[InoutDisp.INOUT_Y10000].Amount = inOut.InOutBtn[InoutDisp.INOUT_Y10000].Count = 0;
      inOut.InOutBtn[InoutDisp.INOUT_Y5000].Amount = inOut.InOutBtn[InoutDisp.INOUT_Y5000].Count = 0;
      inOut.InOutBtn[InoutDisp.INOUT_Y2000].Amount = inOut.InOutBtn[InoutDisp.INOUT_Y2000].Count = 0;
    }
    RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL); // Ttl Buffer All Clear

    RegsMem regsMem = SystemFunc.readRegsMem();
    regsMem.tHeader.inout_flg = RcInOut.TTLLOG_IN_FLAG; // IN flag

    rcUpdatePrnTypeEdit(type);
    await RcRecno.rcSetRctJnlNo();
    await RcSetDate.rcSetDate();
    //入金実績(t105200)
    switch (enumValue) {
      case PrnterControlTypeIdx.TYPE_CASHRECYCLE_IN:
        regsMem.tTtllog.t105200.inCd = FuncKey.KY_CASHRECYCLE_IN.keyId;
        //キャッシュリサイクル時、キーオプション設定が存在しないが問題ないか注意
        break;
      default:
        regsMem.tTtllog.t105200.inCd = inOut.fncCode;
        break;
    }
    log = "rcUpdateDiffEdit Cin key_cd(${regsMem.tTtllog.t105200.inCd})";
    myLog.logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    regsMem.tTtllog.t105200.divCd = inOut.divCd;
    regsMem.tTtllog.t105200Sts.divName = "";
    regsMem.tTtllog.t105200Sts.divName = inOut.divName;

    AcMem cMem = SystemFunc.readAcMem();

    if (inOut.dispType >= Inout_Disp_Type.INOUT_DISP_NEW_IN) {
      regsMem.tTtllog.t105200Sts.chgInoutAmt = inOut.Pdata.TotalPrice;
      regsMem.tTtllog.t105200Sts.tendData = tendData;
      regsMem.tTtllog.t105200Sts.chgData = chgData;
    }
    else if (enumValue == PrnterControlTypeIdx.TYPE_CASHRECYCLE_IN) {
      cCinSht = CashRecycleData().cin_data; //退避していたデータをロード
      regsMem.tTtllog.t105200Sts.chgInoutAmt = rcChgCinCashRecycleInPrcSet(cCinSht) - rcChgCinReturnOutPrcSet();
      regsMem.tTtllog.t105200Sts.mny10000Sht = cCinSht.bill10000 - AcbInfo().outdata.bill10000;
      regsMem.tTtllog.t105200Sts.mny5000Sht = cCinSht.bill5000 - AcbInfo().outdata.bill5000;
      regsMem.tTtllog.t105200Sts.mny2000Sht = cCinSht.bill2000 - AcbInfo().outdata.bill2000;
      regsMem.tTtllog.t105200Sts.mny1000Sht = cCinSht.bill1000 - AcbInfo().outdata.bill1000;
      regsMem.tTtllog.t105200Sts.mny500Sht = cCinSht.coin500 - AcbInfo().outdata.coin500;
      regsMem.tTtllog.t105200Sts.mny100Sht = cCinSht.coin100 - AcbInfo().outdata.coin100;
      regsMem.tTtllog.t105200Sts.mny50Sht = cCinSht.coin50 - AcbInfo().outdata.coin50;
      regsMem.tTtllog.t105200Sts.mny10Sht = cCinSht.coin10 - AcbInfo().outdata.coin10;
      regsMem.tTtllog.t105200Sts.mny5Sht = cCinSht.coin5 - AcbInfo().outdata.coin5;
      regsMem.tTtllog.t105200Sts.mny1Sht = cCinSht.coin1 - AcbInfo().outdata.coin1;
    }
    else if(enumValue == PrnterControlTypeIdx.TYPE_CCHG) {
      regsMem.tTtllog.t105200Sts.chgInoutAmt = regsMem.tTtllog.t105400.exchgAmt;
      regsMem.tTtllog.t105200Sts.mny10000Sht = regsMem.tTtllog.t105400Sts.bfreSht10000;
      regsMem.tTtllog.t105200Sts.mny5000Sht = regsMem.tTtllog.t105400Sts.bfreSht5000;
      regsMem.tTtllog.t105200Sts.mny2000Sht = regsMem.tTtllog.t105400Sts.bfreSht2000;
      regsMem.tTtllog.t105200Sts.mny1000Sht = regsMem.tTtllog.t105400Sts.bfreSht1000;
      regsMem.tTtllog.t105200Sts.mny500Sht = regsMem.tTtllog.t105400Sts.bfreSht500;
      regsMem.tTtllog.t105200Sts.mny100Sht = regsMem.tTtllog.t105400Sts.bfreSht10;
      regsMem.tTtllog.t105200Sts.mny50Sht = regsMem.tTtllog.t105400Sts.bfreSht50;
      regsMem.tTtllog.t105200Sts.mny10Sht = regsMem.tTtllog.t105400Sts.bfreSht10;
      regsMem.tTtllog.t105200Sts.mny5Sht = regsMem.tTtllog.t105400Sts.bfreSht5;
      regsMem.tTtllog.t105200Sts.mny1Sht = regsMem.tTtllog.t105400Sts.bfreSht1;
    }
    else {
      regsMem.tTtllog.t105200Sts.chgInoutAmt = inOut.Pdata.TotalPrice;

      //金種別枚数データセット
      if(cMem.acbData.totalPrice > 0) {
      }
      else {
        regsMem.tTtllog.t105200Sts.mny10000Sht = inOut.InOutBtn[InoutDisp.INOUT_Y10000].Count;
        regsMem.tTtllog.t105200Sts.mny5000Sht = inOut.InOutBtn[InoutDisp.INOUT_Y5000].Count;
        regsMem.tTtllog.t105200Sts.mny2000Sht = inOut.InOutBtn[InoutDisp.INOUT_Y2000].Count;
        regsMem.tTtllog.t105200Sts.mny1000Sht = inOut.InOutBtn[InoutDisp.INOUT_Y1000].Count;
        regsMem.tTtllog.t105200Sts.mny500Sht = inOut.InOutBtn[InoutDisp.INOUT_Y500].Count;
        regsMem.tTtllog.t105200Sts.mny100Sht = inOut.InOutBtn[InoutDisp.INOUT_Y100].Count;
        regsMem.tTtllog.t105200Sts.mny50Sht = inOut.InOutBtn[InoutDisp.INOUT_Y50].Count;
        regsMem.tTtllog.t105200Sts.mny10Sht = inOut.InOutBtn[InoutDisp.INOUT_Y10].Count;
        regsMem.tTtllog.t105200Sts.mny5Sht = inOut.InOutBtn[InoutDisp.INOUT_Y5].Count;
        regsMem.tTtllog.t105200Sts.mny1Sht = inOut.InOutBtn[InoutDisp.INOUT_Y1].Count;
      }
    }

    rcUpdateDiffEditCin();
    regsMem.tTtllog.t105200.sht10000 = regsMem.tTtllog.t105200Sts.mny10000Sht;
    regsMem.tTtllog.t105200.sht5000 = regsMem.tTtllog.t105200Sts.mny5000Sht;
    regsMem.tTtllog.t105200.sht2000 = regsMem.tTtllog.t105200Sts.mny2000Sht;
    regsMem.tTtllog.t105200.sht1000 = regsMem.tTtllog.t105200Sts.mny1000Sht;
    regsMem.tTtllog.t105200.sht500 = regsMem.tTtllog.t105200Sts.mny500Sht;
    regsMem.tTtllog.t105200.sht100 = regsMem.tTtllog.t105200Sts.mny100Sht;
    regsMem.tTtllog.t105200.sht50 = regsMem.tTtllog.t105200Sts.mny50Sht;
    regsMem.tTtllog.t105200.sht10 = regsMem.tTtllog.t105200Sts.mny10Sht;
    regsMem.tTtllog.t105200.sht5 = regsMem.tTtllog.t105200Sts.mny5Sht;
    regsMem.tTtllog.t105200.sht1 = regsMem.tTtllog.t105200Sts.mny1Sht;

    //在高実績
    if((enumValue == PrnterControlTypeIdx.TYPE_CCIN) ||
        (enumValue == PrnterControlTypeIdx.TYPE_CASHRECYCLE_IN) ||
        (enumValue == PrnterControlTypeIdx.TYPE_CCHG) ||
        (inOut.dispType >= Inout_Disp_Type.INOUT_DISP_NEW_IN)) {
      //釣機入金、キャッシュリサイクル、釣機両替、金種別登録しない
      if (inOut.dispType >= Inout_Disp_Type.INOUT_DISP_NEW_IN) {
        amtData = tendData;
      }
      else {
        amtData = regsMem.tTtllog.t105200Sts.chgInoutAmt;
      }

      //何か手動で作成する在高がある場合はこの処理以前に行うこと。この処理で在高に対するky_cd等を自動割振しています。
      await Rcinoutdsp.rcInOutLumpAmtSetCmn(1, koptInOut, amtData, chgData);
    }
    else {
      //何か手動で作成する在高がある場合はこの処理以前に行うこと。この処理で在高に対するky_cd等を自動割振しています。
      await Rcinoutdsp.rcInOutDiffAmtSetCmn(1, koptInOut, 0, 0);
    }
//#if CASH_RECYCLE
    if (enumValue == PrnterControlTypeIdx.TYPE_CASHRECYCLE_IN) {
      regsMem.tTtllog.t100011.errcd = "";
      regsMem.tTtllog.t100011.errcd = CashRecycleData().inout_no
          .toString(); //発行番号(発行レジ番号＋発行日時YYYYMMDDHHDDSS)
      if (CashRecycleData().chgout != 0) {
        regsMem.tTtllog.t111000.exchgFlg = 1; //両替
      }
      regsMem.prnrBuf.crinfo.chgout_amt =
          CashRecycleData().chgout_amt; //事務所一括両替出金金額
      if (AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) != 0) {
        rcAutoStrclsCashRecycleShortSht();
      }
    }
    else{
//#endif
      if (enumValue == PrnterControlTypeIdx.TYPE_CCHG) {
        cMem.ent.errNo = RcIfEvent.rcSendUpdate();
        return;
      }
//#if CASH_RECYCLE
    }
//#endif
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRetC.object;
    if ((cBuf.dbTrm.revenueStampPayFlg == 0) && (koptInOut.restmpFlg != 0)) {
      rcRfmData();
    }
  }

  ///  関連tprxソース: rcky_cin.c - rc_AutoStrcls_CashRecycle_ShortSht()
  static void rcAutoStrclsCashRecycleShortSht() {
    // 未使用
  }

  ///  関連tprxソース: rcky_cin.c - rcUpdate_DiffEdit_Cin()
  static void rcUpdateDiffEditCin() {
    RegsMem regsMem = SystemFunc.readRegsMem();
    regsMem.tTtllog.t105200.inCnt = 1;
    regsMem.tTtllog.t105200.inAmt = regsMem.tTtllog.t105200Sts.chgInoutAmt;
  }

  ///  関連tprxソース: rcky_cin.c - rcChgCin_CashRecycleInPrc_Set()
  static int rcChgCinCashRecycleInPrcSet(CBillKind cCinSht) {
    int prc =
    ((cCinSht.bill10000 * 10000) +
        (cCinSht.bill5000 * 5000) +
        (cCinSht.bill2000 * 2000) +
        (cCinSht.bill1000 * 1000) +
        (cCinSht.coin500 * 500) +
        (cCinSht.coin100 * 100) +
        (cCinSht.coin50 * 50) +
        (cCinSht.coin10 * 10) +
        (cCinSht.coin5 * 5) +
        (cCinSht.coin1 * 1));
    return (prc);
  }

  ///  関連tprxソース: rcky_cin.c - rcChgCin_ReturnOutPrc_Set()
  static int rcChgCinReturnOutPrcSet() {
    int prc =
    ((AcbInfo().outdata.bill10000 * 10000) +
        (AcbInfo().outdata.bill5000 * 5000) +
        (AcbInfo().outdata.bill2000 * 2000) +
        (AcbInfo().outdata.bill1000 * 1000) +
        (AcbInfo().outdata.coin500 * 500) +
        (AcbInfo().outdata.coin100 * 100) +
        (AcbInfo().outdata.coin50 * 50) +
        (AcbInfo().outdata.coin10 * 10) +
        (AcbInfo().outdata.coin5 * 5) +
        (AcbInfo().outdata.coin1 * 1));
    return (prc);
  }

/*----------------------------------------------------------------------*
 * KY_CIN 1 -> 16 Management Functions
 *----------------------------------------------------------------------*/
  ///  関連tprxソース: rcky_cin.c - rcEdit_KeyData()
  static void rcEditKeyData() {
    AcMem cMem = SystemFunc.readAcMem();
    inOut.fncCode = cMem.stat.fncCode;
  }

  ///  関連tprxソース: rcky_cin.c - rcInputTotalDisp()
  static Future<void> rcInputTotalDsp() async {
    switch (FuncKey.getKeyDefine(inOut.fncCode)) {
      case FuncKey.KY_CIN1 :await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_CIN1.keyId);break;
      case FuncKey.KY_CIN2 :await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_CIN2.keyId);break;
      case FuncKey.KY_CIN3 :await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_CIN3.keyId);break;
      case FuncKey.KY_CIN4 :await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_CIN4.keyId);break;
      case FuncKey.KY_CIN5 :await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_CIN5.keyId);break;
      case FuncKey.KY_CIN6 :await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_CIN6.keyId);break;
      case FuncKey.KY_CIN7 :await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_CIN7.keyId);break;
      case FuncKey.KY_CIN8 :await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_CIN8.keyId);break;
      case FuncKey.KY_CIN9 :await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_CIN9.keyId);break;
      case FuncKey.KY_CIN10:await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_CIN10.keyId);break;
      case FuncKey.KY_CIN11:await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_CIN11.keyId);break;
      case FuncKey.KY_CIN12:await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_CIN12.keyId);break;
      case FuncKey.KY_CIN13:await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_CIN13.keyId);break;
      case FuncKey.KY_CIN14:await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_CIN14.keyId);break;
      case FuncKey.KY_CIN15:await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_CIN15.keyId);break;
      case FuncKey.KY_CIN16:await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_CIN16.keyId);break;
      case FuncKey.KY_CHGCIN:await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_CHGCIN.keyId);break;
      default:break;
    }
  }

  ///  関連tprxソース: rcky_cin.c - rcEnd_Ky_Cin
  static Future<void> rcEndKyCin() async {
    await RcRecno.rcIncRctJnlNo(true);
    await RcSet.rcClearDataReg();
//#if RESERV_SYSTEM
    if (!await RcAdvanceIn.rcChkAdvanceIn()) {
//#endif
      RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL);
    }
    AcMem cMem = SystemFunc.readAcMem();
    // Total Receipt Clear
    cMem.postReg = PostReg();
    RcSet.rcErr1timeSet();
    await RcSet.cashStatReset2("rcEndKyCin");
    if (await RcSysChk.rcCheckQCJCChecker()) {
      await RcSet.rcClearDualChkReg();
    }
    RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetS.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRetS.object;
    tsBuf.cash.inout_flg = 0;
    RcFncChk.rcKyResetStat(cMem.keyStat, RcRegs.MACRO0);
    RcRegs.kyStR0(cMem.keyStat, inOut.fncCode); // Reset Bit 0 of KY_CIN?
    RcRegs.kyStS3(cMem.keyStat, FncCode.KY_FNAL.keyId); // Set   Bit 3 of KY_FNAL

    if( koptInOut.frcSelectFlg == 2) {
      await RcKyccin.rcEndKeyChgCinDecision("rcAutoDecision");
    }
//#if RESERV_SYSTEM
    if (await RcAdvanceIn.rcChkAdvanceIn()) {
      // TODO:いらなそう
      //rc_AdvanceIn_EndBtn(NULL, 0);
    }
//#endif
  }

  ///  関連tprxソース: rcky_cin.c - rcRfmData()
  static void rcRfmData() {
    int realAmt = 0;
    int sign = 1;

    RegsMem regsMem = SystemFunc.readRegsMem();
    realAmt = regsMem.tTtllog.t100200[AmtKind.amtCash.index].drwAmt;

    if (realAmt < 0) {
      sign = -1;
    }
    else {
      sign = 1;
    }

    realAmt = realAmt * sign;

    if (realAmt < 0) {
      realAmt = 0;
    }
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRetC.object;
    if (cBuf.revenueExclusion != 0) {
      realAmt = 0;
    }

    RckyRfm.rcSetReceiptQpTran(realAmt, sign); // 領収書実績セット
  }

//#if RESERV_SYSTEM
  ///  関連tprxソース: rcky_cin.c - rcDrwChgCinChk()
  static Future<bool> rcReservCinChk() async {
    AcMem cMem = SystemFunc.readAcMem();
    return ((await CmCksys.cmReservSystem() != 0) &&
        (cMem.stat.fncCode == FuncKey.KY_CIN15.keyId) &&
        (RcReserv.rcReservPrnSkipChk()));
  }

  ///  関連tprxソース: rcky_cin.c - rcReservCin()
  static Future<void> rcReservCin() async {
    Uint8List entry = Uint8List(4);
    String log = "";
    int errNo = Typ.OK;
    int errStat = 0;
    String callFunc = 'rcReservCin';

    myLog.logAdd(
        await RcSysChk.getTid(), LogLevelDefine.normal, "rcReservCin Start");

    AcMem cMem = SystemFunc.readAcMem();
    RegsMem regsMem = SystemFunc.readRegsMem();
    AtSingl atSingle = SystemFunc.readAtSingl();
    RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetS.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRetS.object;

    if (!await RcAdvanceIn.rcChkAdvanceIn()) {
      await RcIfPrint.rcDrwopen(); // Drawer Open !!
      cMem.stat.clkStatus |= RcIf.OPEN_DRW;
      RxTaskStatDrw taskStatDrw = (await SystemFunc.statDrwGet(tsBuf));
      taskStatDrw.prnStatus |= RcIf.OPEN_DRW;
    }
    await RcExt.cashStatSet("rcReservCin");
    tsBuf.cash.inout_flg = 1;

    rcEditKeyData();
    entry = cMem.ent.entry.sublist(3);
    inOut.Pdata.TotalPrice = Bcdtol.cmBcdToL(entry);
    cMem.scrData.price = inOut.Pdata.TotalPrice;
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRetC.object;
    if (cBuf.dbTrm.cashKindSelectReserveope != 0) {
      await RcFlrda.rcReadKoptinout(cMem.stat.fncCode, koptInOut);
      koptInOut.kyTyp = regsMem.tTtllog.t100100[0].sptendCd;
    }
    else if (await RcAdvanceIn.rcChkAdvanceIn()) {
      await RcFlrda.rcReadKoptinout(cMem.stat.fncCode, koptInOut);
      koptInOut.kyTyp = FuncKey.KY_CASH.keyId;
      if (await RcAcracb.rcCheckAcrAcbON(1) ==
          CoinChanger.ACR_COINBILL) { // Coin/Bill-Changer ON ?*/
        if (koptInOut.acbDrwFlg != 0) {
          await RcIfPrint.rcDrwopen(); // Drawer Open !!
          cMem.stat.clkStatus |= RcIf.OPEN_DRW;
          RxTaskStatDrw taskStatDrw = (await SystemFunc.statDrwGet(tsBuf));
          taskStatDrw.prnStatus |= RcIf.OPEN_DRW;
        }
        else {
          cMem.stat.clkStatus &= ~RcIf.OPEN_DRW;
        }
      }
      else {
        await RcIfPrint.rcDrwopen(); // Drawer Open !!
        cMem.stat.clkStatus |= RcIf.OPEN_DRW;
        RxTaskStatDrw taskStatDrw = (await SystemFunc.statDrwGet(tsBuf));
        taskStatDrw.prnStatus |= RcIf.OPEN_DRW;
      }
    }
    RcRegs.kyStS0(cMem.keyStat, inOut.fncCode); // Set Bit 0 of KY_CIN?
    RcRegs.kyStS0(cMem.keyStat, FncCode.KY_REG.keyId); // Set Bit 0 of FncCode.KY_REG.keyId

    log = "rcReservCin price ${cMem.scrData.price} ";
    myLog.logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    await rcUpdateLumpCin();
    if (await RcAdvanceIn.rcChkAdvanceIn()) {
      errNo = await RcFncChk.rcChkRPrinter();
      if (errNo != Typ.OK) {
        await ReptEjConf.rcErr("rcReservCin", errNo);
        RcIfEvent.rcSendUpdate();
        rcEndKyCin();
      }
      else {
        atSingle.rctChkCnt = 0;
        await RcExt.rxChkModeSet("rcReservCin");
        CalcResultChanger retData = await RcClxosChanger.changerIn(cBuf);
        errNo = retData.retSts!;
        if (0 != errNo) {
          await ReptEjConf.rcErr("rcReservCin", errNo);
          errNo = Typ.OK;
          errStat = 1;
        }
        else {
          // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
          await IfTh.printReceipt(await RcSysChk.getTid(), retData.digitalReceipt, callFunc);
        }
        errNo = RcIfEvent.rcSendUpdate();
        if ((errNo != 0) || (errStat != 0)) {
          rcEndKyCin();
          await RcExt.rxChkModeReset("rcReservCin");
        }
        else {
          RckyRpr.rcWaitResponce(inOut.fncCode);
        }
      }
    }
    else {
      RcIfEvent.rcSendUpdate();
      rcEndKyCin();
    }
  }
//#endif

  ///  関連tprxソース: rcky_cin.c - rcDrwChgCinChk()
  static Future<bool> rcDrwChgCinChk() async {
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
    }
    RxCommonBuf cBuf = xRetC.object;
    return ((cBuf.dbTrm.coopaizuFunc1 != 0) && (await RcFncChk.rcCheckAccountOffsetMode()));
  }

  ///  関連tprxソース: rcky_cin.c - rcDrwChgCin()
  static Future<void> rcDrwChgCin() async {
    int errNo = Typ.OK;
    int errStat = 0;
    String log = "";
    String callFunc = 'rcDrwChgCin';

    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSingle = SystemFunc.readAtSingl();
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
    }
    RxCommonBuf cBuf = xRetC.object;

    cMem.scrData.price = inOut.Pdata.TotalPrice;

    log = "rcDrwChgCin price ${cMem.scrData.price} ";
    myLog.logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    RcRegs.kyStS0(cMem.keyStat, inOut.fncCode);
    RcRegs.kyStS0(cMem.keyStat, FncCode.KY_REG.keyId);

    RcSet.rcClearEntry();

    RegsMem regsMem = SystemFunc.readRegsMem();
    regsMem.tHeader.inout_flg = RcInOut.TTLLOG_IN_FLAG; // IN flag
    regsMem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_CIN.index;

    await RcRecno.rcSetRctJnlNo();
    await RcSetDate.rcSetDate();
    regsMem.tTtllog.t105200Sts.chgInoutAmt = inOut.Pdata.TotalPrice;
    rcUpdateDiffEditCin();

    errNo = await RcFncChk.rcChkRPrinter();
    if (errNo != Typ.OK) {
      await ReptEjConf.rcErr("rcDrwChgCin", errNo);
      RcIfEvent.rcSendUpdate();
      rcEndKyCin();
    }
    else {
      atSingle.rctChkCnt = 0;
      await RcExt.rxChkModeSet("rcDrwChgCin");
      CalcResultChanger retData = await RcClxosChanger.changerIn(cBuf);
      errNo = retData.retSts!;
      if (0 != errNo) {
        await ReptEjConf.rcErr("rcDrwChgCin", errNo);
        errNo = Typ.OK;
        errStat = 1;
      }
      else {
        // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
        await IfTh.printReceipt(await RcSysChk.getTid(), retData.digitalReceipt, callFunc);
      }

      errNo = RcIfEvent.rcSendUpdate();
      if ((errNo != 0) || (errStat != 0)) {
        rcEndKyCin();
        await RcExt.rxChkModeReset("rcDrwChgCin");
      }
      else {
        RckyRpr.rcWaitResponce(inOut.fncCode);
      }
    }
    cMem.ent.errNo = errNo;
  }

  //chkCtrlFlg : 0以外で特定のチェック処理を除外する
  // 除外対象はチェックではない箇所（実績等メモリ作成部分）や通信関連、周辺機へのアクション等時間を要するもの
  // 0:標準のキー押下時のチェック  0以外:キー押下前の動作可能かのチェック
  static Future<int> rcCheckKynetDoARsvCin(int chkCtrlFlg) async {
    if ((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) &&
        (!await RcSysChk.rcCheckQCJCSystem())) {
      return (DlgConfirmMsgKind.MSG_OPEERR.dlgId);
    }
    AcMem cMem = SystemFunc.readAcMem();
    cMem.keyChkb = List.filled(cMem.keyChkb.length, 0xff);

    List<int> p = [];
    int i;
    p = rsvCin0; i = 0; while (p[0+i] != 0) { RcRegs.kyStR0(cMem.keyChkb, i); i++; }
    p = rsvCin1; i = 0; while (p[0+i] != 0) { RcRegs.kyStR1(cMem.keyChkb, i); i++; }
    p = rsvCin2; i = 0; while (p[0+i] != 0) { RcRegs.kyStR2(cMem.keyChkb, i); i++; }
    p = rsvCin3; i = 0; while (p[0+i] != 0) { RcRegs.kyStR3(cMem.keyChkb, i); i++; }
    p = rsvCin4; i = 0; while (p[0+i] != 0) { RcRegs.kyStR4(cMem.keyChkb, i); i++; }
    if (RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3) != 0) {
      return (DlgConfirmMsgKind.MSG_OPEERR.dlgId);
    }
    return (Typ.OK);
  }

  //キー使用不可確認関数
  ///  関連tprxソース: rcky_cin.c - rcChk_rcKyCin_MechaKeysCheck
  static Future<int> rcChkrcKyCinMechaKeysCheck() async {
    int errNo = 0;

    if (CompileFlag.RESERV_SYSTEM) {
      if (await rcReservCinChk() || await RcAdvanceIn.rcChkAdvanceIn()) {
        myLog.logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "rcChkrcKyCinMechaKeysCheck : RESERV_SYSTEM Non Check");
        return errNo; //チェック未対応
      }
    }
    if (await rcDrwChgCinChk()) {
      myLog.logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcChkrcKyCinMechaKeysCheck : rcDrwChgCinChk Non Check");
      return errNo; //チェック未対応
    }

    AcMem cMem = SystemFunc.readAcMem();
    if ((await CmCksys.cmNetDoAreservSystem() != 0) &&
        (cMem.stat.fncCode == FuncKey.KY_CIN15.keyId)) {
      errNo = await rcCheckKynetDoARsvCin(1);
      return errNo;
    }

    errNo = await rcCheckKyCin(1);
    if (errNo == 0) {
      errNo = rcChkLumpCin(1);
    }

    return errNo;
  }

  /// 釣銭機からのデータを受信する.
  static Future<void> _onTimer(Timer timer) async {
    if (!(isCancel || isDecideCinAmount)) {
      await RcAcracb.rcAcrAcbCinReadDtl();
      AcMem cMem = SystemFunc.readAcMem();
      cinAmount = cMem.acbData.ccinPrice;
    }
  }

  static void rckyCinClose() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
  }

  /// 釣銭機に入金したお金を吐き出させる。
  static Future<int> cancelCharger() async {
    int changerRet = 0;
    AcMem cMem = SystemFunc.readAcMem();
    ChangeCoinInInputController changeCoinInCtrl = Get.find();
    debugPrint("cancel");
    // 以下のグローリー(RT-300)は暫定処理。
    // 最終的には「await RcAcracb.rcChgCinCancelDtl()」だけを共通処理として残す。
    if((AcxCom.ifAcbSelect() == CoinChanger.ECS_777) ||
       (AcxCom.ifAcbSelect() == CoinChanger.RT_300)) {
      debugPrint("call ifAcxCinStop");
      changerRet = await AcxCstp.ifAcxCinStop(
          TprDidDef.TPRTIDCHANGER, CoinChanger.ACR_COINBILL);
      await Future.delayed( const Duration(seconds: 1));
      debugPrint("call ifAcxCinEnd");
      changerRet = await AcxCend.ifAcxCinEnd(
          TprDidDef.TPRTIDCHANGER, CoinChanger.ACR_COINBILL);
      if (changeCoinInCtrl.receivePrc.value != 0) {
        // 入金額を返金
        await Future.delayed( const Duration(milliseconds: 500));
        debugPrint("call ifAcxChangeOut");
        changerRet = await AcxCoin.ifAcxChangeOut(
            TprDidDef.TPRTIDCHANGER, CoinChanger.ACR_COINBILL, cinAmount);
      }
    }
    changeCoinInCtrl.receivePrc.value = 0;
    changeCoinInCtrl.coinInPrc.value = 0;
    changeCoinInCtrl.currentCoinInPrc.value = 0;
    changeCoinInCtrl.change.value = 0;
    await RcExt.rxChkModeReset("cancelCharger");
    cMem.keyStat[cMem.stat.fncCode] = 0;
    cMem.stat.fncCode = 0;
    return changerRet;
  }

  /// 関数名     : isNotFrcSelect
  /// 機能概要   : 金種別登録しないか否か判定する
  /// 呼出方法   : -
  /// パラメータ : -
  /// 戻り値     : 金種別登録しない場合はtrue, それ以外はfalseを返却する
  ///  関連tprxソース: -
  static bool isNotFrcSelect() {
    const int isFalse = 0;
    return koptInOut.frcSelectFlg == isFalse;
  }
}
