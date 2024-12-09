/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/image.dart';
import '../../inc/apl/rxmem_ajsemoney.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/db/c_ttllog.dart';
import '../../inc/lib/mcd.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_img_read.dart';
import '../../lib/apllib/image_label_dbcall.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../sys/sale_com_mm/rept_ejconf.dart';
import '../../ui/controller/c_common_controller.dart';
import '../../ui/menu/register/m_menu.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/page/register/controller/c_registerbody_controller.dart';
import '../common/rxmbrcom.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_ext.dart';
import 'rc_itm_dsp.dart';
import 'rc_key_tab.dart';
import 'rc_mbr_com.dart';
import 'rc_point_infinity.dart';
import 'rc_set.dart';
import 'rc_stl.dart';
import 'rc_stl_cal.dart';
import 'rc_trk_preca.dart';
import 'rc28stllcd.dart';
import 'rcabs_v31.dart';
import 'rccrwp_com.dart';
import 'rcfncchk.dart';
import 'rcht2980_com.dart';
import 'rcky_clr.dart';
import 'rcky_cpnprn.dart';
import 'rckycncl.dart';
import 'rckyrmod.dart';
import 'rcmbr_ZHQflrd.dart';
import 'rcmbrflrd.dart';
import 'rcmbrkymbr.dart';
import 'rcmbrrealsvr2.dart';
import 'rcmcp200_com.dart';
import 'rcorc_com.dart';
import 'rcsapporo_pana_com.dart';
import 'rcstlfip.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';
import 'rctrc_com.dart';
import 'rcvmc_com.dart';
import 'regs.dart';

///  関連tprxソース: rckymbre.c
class RckyMbre {
  static List<int> mbrRemoveList0 = [FncCode.KY_REG.keyId, FuncKey.KY_MBRCLR.keyId, 0];
  static List<int> mbrRemoveList1 = [0];
  static List<int> mbrRemoveList2 = [0];
  static List<int> mbrRemoveList3 = [0];
  static List<int> mbrRemoveList4 = [FuncKey.KY_WORKIN.keyId, 0];
  /// フロント連携のためのデータ
  static int outDlgId = 0;  //確認ダイアログID

  /// 会員取消キー押下時の処理
  /// 関連tprxソース:rckymbre.c - rcKy_Mbr_Removed
  static Future<void> rcKyMbrRemoved() async {
    debugPrint('********** 実機調査ログ（会員取消）1: RckyMbre.rcKyMbrRemoved() Start');
    String callFunc = "RckyMbre.rcKyMbrRemoved()";

    CommonController commonCtrl = Get.find();

    if (RcSysChk.rcCheckKyIntIn(true)) {
      if (commonCtrl.onSubtotalRoute.value) {  //小計画面から実行
        await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_OPEINTERERR.dlgId);
      } else { //登録画面から実行
        await RcExt.rcErrToRegister(callFunc, DlgConfirmMsgKind.MSG_OPEINTERERR.dlgId);
      }
      return;
    }
    debugPrint('********** 実機調査ログ（会員取消）2: RcSysChk.rcCheckKyIntIn(true) = false');

    RegsMem mem = SystemFunc.readRegsMem();
    AcMem cMem = SystemFunc.readAcMem();

    if (CompileFlag.RALSE_CREDIT) {
      if (RcSysChk.rcChkRalseCardSystem()) {
        if (((mem.tTtllog.t100700.mbrInput == MbrInputType.nonInput.index) &&
            (mem.tTtllog.t100700Sts.mbrTyp == 0) &&
            (mem.tmpbuf.rcarddata.typ == 0))
            || RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
          if (commonCtrl.onSubtotalRoute.value) {  //小計画面から実行
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_OPEERR.dlgId);
          } else { //登録画面から実行
            await RcExt.rcErrToRegister(callFunc, DlgConfirmMsgKind.MSG_OPEERR.dlgId);
          }
          debugPrint('********** 実機調査ログ（会員取消）2Err-a: RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_OPEERR.dlgId)');
          return;
        }
      }
      else {
        if ((mem.tTtllog.t100700.mbrInput == MbrInputType.nonInput.index)
            || RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
          if (commonCtrl.onSubtotalRoute.value) {  //小計画面から実行
            await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_OPEERR.dlgId);
          } else { //登録画面から実行
            await RcExt.rcErrToRegister(callFunc, DlgConfirmMsgKind.MSG_OPEERR.dlgId);
          }
          debugPrint('********** 実機調査ログ（会員取消）2Err-b: RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_OPEERR.dlgId)');
          return;
        }
      }
    }
    else {
      if ((mem.tTtllog.t100700.mbrInput == MbrInputType.nonInput.index)
          || RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
        if (commonCtrl.onSubtotalRoute.value) {  //小計画面から実行
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_OPEERR.dlgId);
        } else { //登録画面から実行
          await RcExt.rcErrToRegister(callFunc, DlgConfirmMsgKind.MSG_OPEERR.dlgId);
        }
        debugPrint('********** 実機調査ログ（会員取消）2Err-c: RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_OPEERR.dlgId)');
        return;
      }
    }
    debugPrint('********** 実機調査ログ（会員取消）3: mbrInput != nonInput');

    int errNo = await _rcCheckKyMbrRemove();			 /* 入力キーチェック     */
    if (errNo != Typ.OK) {
      if (commonCtrl.onSubtotalRoute.value) {  //小計画面から実行
        await RcExt.rcErr(callFunc, errNo);
      } else { //登録画面から実行
        await RcExt.rcErrToRegister(callFunc, errNo);
      }
      debugPrint('********** 実機調査ログ（会員取消）4Err: _rcCheckKyMbrRemove() != OK');
      return;
    }
    debugPrint('********** 実機調査ログ（会員取消）4: _rcCheckKyMbrRemove() = OK');
    outDlgId = await _rcPrgKyMbrClr();  //戻り値がTyp.OK固定

    // 処理完了ダイアログを表示
    MsgDialog.show(
      MsgDialog.singleButtonDlgId(
        type: MsgDialogType.info,
        dialogId: DlgConfirmMsgKind.MSG_FREE_MESSAGE.dlgId,
        replacements: [ImageDefinitions.IMG_CNCLCONF_MBR2.imageData],
        btnFnc: () async {
          CommonController commonCtrl = Get.find();
          if (commonCtrl.onSubtotalRoute.value) {  //小計画面から端末読込画面を起動
            SetMenu1.navigateToPaymentSelectPage();
          } else {  //登録画面から端末読込画面を起動
            SetMenu1.navigateToRegisterPage();
          }
        },
      ),
    );
  }

  /// 表示用パラメタを初期化する
  static void rcClearCustParam() {
    AcMem cMem = SystemFunc.readAcMem();
    // AcMemクラスに入っている会員情報をクリアする
    debugPrint('********** 実機調査ログ（会員取消）22a: before code=${cMem.working.janInf.code}  cnt=${cMem.ent.tencnt}');
    cMem.working.janInf.code = "";
    cMem.ent.tencnt = 0;
    debugPrint('********** 実機調査ログ（会員取消）22a: after code=${cMem.working.janInf.code}  cnt=${cMem.ent.tencnt}');
    // サーバーから取得した会員番号、累積ポイントもクリアする
    debugPrint('********** 実機調査ログ（会員取消）22b: before custNo=${RcMbrFlrd.cust.cust_no}  ttlPoint=${RcMbrFlrd.ttlPoint}');
    RcMbrFlrd.cust.cust_no = "";
    RcMbrFlrd.ttlPoint = 0;
    debugPrint('********** 実機調査ログ（会員取消）22b: after custNo=${RcMbrFlrd.cust.cust_no}  ttlPoint=${RcMbrFlrd.ttlPoint}');
    // コントローラー部が受け持つ顧客情報データをクリアする
    final RegisterBodyController regBodyCtrl = Get.find();
    regBodyCtrl.clearMemberInfo();
    debugPrint('********** 実機調査ログ（会員取消）23: regBodyCtrl.clearMemberInfo() end');
  }

  /// キーステータスをチェックする
  /// 戻り値: エラーNo (0=エラーなし)
  /// 関連tprxソース:rckymbre.c - rcCheck_Ky_MbrRemove
  static Future<int> _rcCheckKyMbrRemove() async {
    if ((await RcFncChk.rcCheckESVoidSMode())
        || (await RcFncChk.rcCheckESVoidIMode())) {
      return Typ.OK;
    }

    if (!RcFncChk.rcCheckRegistration()) {
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }

    AcMem cMem = SystemFunc.readAcMem();
    cMem.keyChkb = List.filled(cMem.keyChkb.length, 0xff);
    for (int i = 0; i < mbrRemoveList0.length; i++) {
      if (mbrRemoveList0[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, mbrRemoveList0[i]);
    }
    for (int i = 0; i < mbrRemoveList1.length; i++) {
      if (mbrRemoveList1[i] == 0) {
        break;
      }
      RcRegs.kyStR1(cMem.keyChkb, mbrRemoveList1[i]);
    }
    for (int i = 0; i < mbrRemoveList2.length; i++) {
      if (mbrRemoveList2[i] == 0) {
        break;
      }
      RcRegs.kyStR2(cMem.keyChkb, mbrRemoveList2[i]);
    }
    for (int i = 0; i < mbrRemoveList3.length; i++) {
      if (mbrRemoveList3[i] == 0) {
        break;
      }
      RcRegs.kyStR3(cMem.keyChkb, mbrRemoveList3[i]);
    }
    for (int i = 0; i < mbrRemoveList4.length; i++) {
      if (mbrRemoveList4[i] == 0) {
        break;
      }
      RcRegs.kyStR4(cMem.keyChkb, mbrRemoveList4[i]);
    }

    if (RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO1 + RcRegs.MACRO3) != 0) {
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    RegsMem mem = SystemFunc.readRegsMem();
    if (CompileFlag.POINT_CARD) {
      if ((await RcSysChk.rcChkPointCardSystem())
          && ((mem.tTtllog.t100700.mbrInput == MbrInputType.pcardmngKeyInput.index) ||
              (mem.tTtllog.t100700.mbrInput == MbrInputType.pcarduseKeyInput.index)) ) {
        return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }
    if (CompileFlag.RALSE_MBRSYSTEM) {
      if (!RcSysChk.rcChkRalseCardSystem()
          && (mem.tTtllog.t100700.mbrInput == MbrInputType.mbrprcKeyInput.index)) {
        return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }
    else {
      if (mem.tTtllog.t100700.mbrInput == MbrInputType.mbrprcKeyInput.index) {
        return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }
    if (await RcFncChk.rcChkSpzRwcAlreadyWrite()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RckyMbre.rcCheckKyMbrRemove(): Already write card");
      return DlgConfirmMsgKind.MSG_RWC_MBR_REMOVE_ERR.dlgId;
    }
    if (RcSysChk.rcsyschkAyahaSystem()) {
      return DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }
    if ((await CmCksys.cmZHQSystem() != 0)
        && (RcKyCpnprn.rccpnprnPrintResCheck() == -1)) {
      return DlgConfirmMsgKind.MSG_PRINT_WAITING.dlgId;
    }
    if (RcFncChk.rcCheckRcptvoidLoadOrgTran() && (await RcSysChk.rcChkStdCust())) {
      return DlgConfirmMsgKind.MSG_RCPTVOID_FORBIDDEN.dlgId;
    }
    if ((RcSysChk.rcChkCustrealPointTactixSystem() != 0)
        && RcMbrCom.rcmbrChkCust()
        && (Rcmbrrealsvr2.rcCustReal2PTactixProcChk(4) == 0)) {
      return DlgConfirmMsgKind.MSG_POINTS_ERROR_FORBIDDEN.dlgId;
    }

    return Typ.OK;
  }

  /// キーステータスをチェックし、会員情報を含むパラメタを初期化する
  /// 戻り値: エラーNo (0=エラーなし)
  /// 関連tprxソース:rckymbre.c - rcPrg_Ky_MBRCLR
  static Future<int> _rcPrgKyMbrClr() async {
    int	errNo = Typ.OK;

    // TODO:10155 顧客呼出_実装対象外
    // 拡張小計のUI関連
    // rcKyExtKey_LeftMove();

    debugPrint('********** 実機調査ログ（会員取消）5: RckyMbre.rcPrgKyMbrClr() Start');

    AcMem cMem = SystemFunc.readAcMem();
    debugPrint('********** 実機調査ログ（会員取消）6: RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_MBRCLR.keyId]) = ${RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_MBRCLR.keyId])}');

    // TODO:10155 顧客呼出 - 既存のボタン2度押し処理を削除するに伴い、処理の区分けを削除
    // （cMem.keyStat[FuncKey.KY_MBRCLR.keyId] のパラメタ判定を削除し、続けて実行する）
    //if (!RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_MBRCLR.keyId])) {
    if ((await CmCksys.cmDs2GodaiSystem() != 0)
        && (await RcFncChk.rcCheckStlMode())) {
      if ((await RcSysChk.rcKySelf() != RcRegs.KY_DUALCSHR)
          || (await RcSysChk.rcChkDesktopCashier())) {
        await RcKyRmod.rcKyRmod();
      }
    }
    errNo = await _rcPrc1stMbrClr();  //戻り値がTyp.OK固定
    debugPrint('********** 実機調査ログ（会員取消）7: _rcPrc1stMbrClr() end');
    // TODO:10155 顧客呼出 - ボタン1回押し時の確認メッセージ設定を削除
    /*
    if (errNo == Typ.OK) {
      // エラーなし
      int code = 0;
      RegsMem mem = SystemFunc.readRegsMem();
      if (CompileFlag.RALSE_MBRSYSTEM) {
        if (RcSysChk.rcChkRalseCardSystem()) {
          if (await Rxmbrcom.rcChkMemberTyp(Mcd.MCD_RLSSTAFF, mem)) {
            code = DlgConfirmMsgKind.MSG_STAFF_CANCEL_CONF.dlgId;
          }
          else if (CompileFlag.RALSE_CREDIT
              && (await Rxmbrcom.rcChkMemberTyp(Mcd.MCD_RLSOTHER, mem) )) {
            code = DlgConfirmMsgKind.MSG_OTHCARD_CANCEL_CONF.dlgId;
          }
          else {
            code = DlgConfirmMsgKind.MSG_MBR_CANCEL_CONF.dlgId;
          }
        }
        else {
          code = DlgConfirmMsgKind.MSG_MBR_CANCEL_CONF.dlgId;
        }
      }
      else {
        code = DlgConfirmMsgKind.MSG_MBR_CANCEL_CONF.dlgId;
      }
      if ((RcSysChk.rcsyschkYunaitoHdSystem != 0)
          && (mem.tTtllog.t100700.mbrInput == MbrInputType.barReceivInput.index)) {
        if (code == DlgConfirmMsgKind.MSG_MBR_CANCEL_CONF) {
          code = DlgConfirmMsgKind.MSG_RECEIV_CANCEL_CONF.dlgId;
        }
      }
      // 確認ダイアログを表示する
      // TODO:10155 顧客呼出（確認ダイアログ出力はフロント側で行うため、ダイアログNoのみ返す）
      //await RcKyCncl.rcPrgKyCnclConfirm(code);
      errNo = code;
    }
     */
    //}
    //else {
    if (errNo == Typ.OK) {
      await rcClr2ndMbrClr();
      debugPrint('********** 実機調査ログ（会員取消）21: RckyMbre.rcClr2ndMbrClr() end');
      // 会員情報を収めるバックエンド＆フロントエンドのパラメタをクリアする
      rcClearCustParam();
    }
    //}

    return errNo;
  }

  /// 会員取消ボタン押下（1回目）＝会員呼出状態を解除する
  /// 戻り値: 0固定
  /// 関連tprxソース:rckymbre.c - rcPrc_1st_MBRCLR()
  static Future<int> _rcPrc1stMbrClr() async {
    RegsMem mem = SystemFunc.readRegsMem();
    if (await RcFncChk.rcCheckStlMode()) {
      if (CompileFlag.RALSE_MBRSYSTEM && RcSysChk.rcChkRalseCardSystem()) {
        if (await Rxmbrcom.rcChkMemberTyp(Mcd.MCD_RLSSTAFF, mem)) {
          await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_STAFF);
        }
        else if (CompileFlag.RALSE_CREDIT
            && (await Rxmbrcom.rcChkMemberTyp(Mcd.MCD_RLSOTHER, mem))) {
          await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_OTHCARD);
        }
        else {
          await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_MBR);
        }
      }
      else {
        await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_MBR);  /* Stl Mode [Cancel ?] Display	*/
      }
    }
    else {
      if (CompileFlag.RALSE_MBRSYSTEM && RcSysChk.rcChkRalseCardSystem()) {
        if (await Rxmbrcom.rcChkMemberTyp(Mcd.MCD_RLSSTAFF, mem)) {
          await _rcMbrCnclDisp(ImageDefinitions.IMG_CNCLCONF_STAFF);
        }
        else if (CompileFlag.RALSE_CREDIT
            && (await Rxmbrcom.rcChkMemberTyp(Mcd.MCD_RLSOTHER, mem))) {
          await _rcMbrCnclDisp(ImageDefinitions.IMG_CNCLCONF_OTHCARD);
        }
        else {
          await _rcMbrCnclDisp(ImageDefinitions.IMG_CNCLCONF_MBR);
        }
      }
      else {
        await _rcMbrCnclDisp(ImageDefinitions.IMG_CNCLCONF_MBR);  /* Itm Mode [Cancel ?] Display	*/
      }
    }
    _rcEnd1stMbrClr();

    if (await RcFncChk.rcCheckStlMode()) {  // 小計画面
      // "取消しますか" ラベルの再設定
      await RcKyCncl.rcPrgKyCnclResetLabel(1);
    }
    else {  // 登録画面
      // "取消しますか" ラベルの再設定
      await RcKyCncl.rcPrgKyCnclResetLabel(0);
    }

    return Typ.OK;
  }

  /// 関連tprxソース:rckymbre.c - _rcEnd_1st_MBRCLR()
  static void _rcEnd1stMbrClr() {
    AcMem cMem = SystemFunc.readAcMem();
    RcRegs.kyStS0(cMem.keyStat, FuncKey.KY_MBRCLR.keyId);  /* Set Bit 0 of KY_MBRCLR	*/
  }

  /// 会員取消ボタン押下（2回目）＝会員呼出状態を解除する
  /// 関連tprxソース:rckymbre.c - rcClr_2nd_MBRCLR()
  static Future<void> rcClr2ndMbrClr() async {
    RegsMem mem = SystemFunc.readRegsMem();
    int mbrInput = mem.tTtllog.t100700.mbrInput;
    int mbrTyp = 0;

    debugPrint('********** 実機調査ログ（会員取消）8: RcKyCncl.rcClr2ndMbrClr() Start');

    debugPrint('********** 実機調査ログ（会員取消）9: RcSysChk.rcChkCustrealPointInfinitySystem() = ${RcSysChk.rcChkCustrealPointInfinitySystem()}');
    if (RcSysChk.rcChkCustrealPointInfinitySystem())	{
      /* サーバへポイント利用取消を要求する */
      if (await RcKyCncl.rcCnclCustRealPiSprit() != 0) {
        // エラーが発生した場合
        // エラーメッセージを表示して再度"rcClr_2nd_MBRCLR()"を実行する。
        mem.tTtllog.t100700.realCustsrvFlg = 1;
        RcExt.rxChkModeSet("RckyMbre.rcClr2ndMbrClr()");
        RcPointInfinity.rcPointInfinityErrMsgDlg(
            DlgConfirmMsgKind.MSG_MBR_COMMERR_PLEASE_BUYADD.dlgId,
            _pointInfinityContinue, "続行", null, "", "エラー");
        return;
      }
      mem.tTtllog.t100760 = T100760();    /* 領域をクリア */
    }

    debugPrint('********** 実機調査ログ（会員取消）10: CmCksys.cmWsSystem() = ${(await CmCksys.cmWsSystem())}');
    if (await CmCksys.cmWsSystem() != 0) {
      await RckyClr.rcChkWScouponBarInfoClear(FuncKey.KY_MBRCLR);
    }

    RcMbrZHQFlrd.rcmbrZHQCustUnlock(mem.tHeader.mac_no);
    RcMbrFlrd.rcmbrStdCustUnlock(mem.tHeader.mac_no, mem.tHeader.cust_no, mem.tHeader.ope_mode_flg, mem.tTtllog.t100700.realCustsrvFlg, mem.tTtllog.t100700.mbrInput);

    debugPrint('********** 実機調査ログ（会員取消）11: RcFncChk.rcCheckStlMode() = ${(await RcFncChk.rcCheckStlMode())}');
    AcMem cMem = SystemFunc.readAcMem();
    if (await RcFncChk.rcCheckStlMode()) {
      if (CompileFlag.RALSE_MBRSYSTEM) {
        mbrTyp = mem.tTtllog.t100700Sts.mbrTyp;
      }
      RcStl.rcClrTtlRBufMbr(ClrTtlRBufMbr.NCLR_TTLRBUF_MBR_ALL);  /* MEMBER DATA ALL CLEAR */
      if (CompileFlag.VISMAC) {
        if (await RcSysChk.rcChkVMCSystem()) {
          _rcVmcAchievFlgReset();
        }
      }
      RcStl.rcClrItmMbrData(0);  /* Stamp & Rbt & Dsc Set */
      StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_INC_MBRRBT);  /* 小計再計算  */

      await RcItmDsp.dualTSingleCshrDspClr();
      if (!((await RcFncChk.rcCheckESVoidSMode()) ||
          (await RcFncChk.rcCheckESVoidIMode()))) {
        await RcItmDsp.rcDspMbrmkLCD();  /* MEMBER MAKE LCD CLEAR */
      }
      RcMbrCom.rcmbrClearModeStlDisp();    /* MEMBER LCD MK  CLEAR  */
      await _rcStlDspMemberClr();

      if (CompileFlag.POINT_CARD) {
        if (!((await RcSysChk.rcChkPointCardSystem()) &&
            ((mem.tTtllog.t100700.mbrInput == MbrInputType.pcardmngKeyInput.index) ||
                (mem.tTtllog.t100700.mbrInput == MbrInputType.pcarduseKeyInput.index)))) {
          if (CompileFlag.RALSE_MBRSYSTEM) {
            if (RcSysChk.rcChkRalseCardSystem()) {
              if (mbrTyp == Mcd.MCD_RLSSTAFF) {
                await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_STAFF2);
              }
              else if (CompileFlag.RALSE_CREDIT && (mbrTyp == Mcd.MCD_RLSOTHER)) {
                await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_OTHCARD2);
              }
              else {
                await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_MBR2);
              }
            }
            else {
              if ((RcSysChk.rcsyschkYunaitoHdSystem() == 1)
                  && (mbrInput == MbrInputType.barReceivInput.index)) {
                await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_RECEIV);
              }
              else {
                await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_MBR2);  /* Cancel OK Display	 */
              }
            }
          }
          else {
            if ((RcSysChk.rcsyschkYunaitoHdSystem() == 1)
                && (mbrInput == MbrInputType.barReceivInput.index)) {
              await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_RECEIV);
            }
            else {
              await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_MBR2);  /* Cancel OK Display	 */
            }
          }
        }
      }
      else {
        if (CompileFlag.RALSE_MBRSYSTEM) {
          if (RcSysChk.rcChkRalseCardSystem()) {
            if (mbrTyp == Mcd.MCD_RLSSTAFF) {
              await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_STAFF2);
            }
            else if (CompileFlag.RALSE_CREDIT && (mbrTyp == Mcd.MCD_RLSOTHER)) {
              await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_OTHCARD2);
            }
            else {
              await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_MBR2);
            }
          } else {
            if ((RcSysChk.rcsyschkYunaitoHdSystem() == 1)
                && (mbrInput == MbrInputType.barReceivInput.index)) {
              await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_RECEIV);
            }
            else {
              await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_MBR2);  /* Cancel OK Display	 */
            }
          }
        }
        else {
          if ((RcSysChk.rcsyschkYunaitoHdSystem() == 1)
              && (mbrInput == MbrInputType.barReceivInput.index)) {
            await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_RECEIV);
          }
          else {
            await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_MBR2);  /* Cancel OK Display	 */
          }
        }
      }
    }
    else {
      if (CompileFlag.RALSE_MBRSYSTEM) {
        mbrTyp = mem.tTtllog.t100700Sts.mbrTyp;
      }
      RcStl.rcClrTtlRBufMbr(ClrTtlRBufMbr.NCLR_TTLRBUF_MBR_ALL);  /* MEMBER DATA ALL CLEAR */
      if (FbInit.subinitMainSingleSpecialChk()) {
        if (CompileFlag.VISMAC) {
          if (await RcSysChk.rcChkVMCSystem()) {
            _rcVmcAchievFlgReset();
          }
        }
      }
      RcStl.rcClrItmMbrData(0);    /* Stamp & Rbt & Dsc Set */
      StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_INC_MBRRBT);  /* 小計再計算  */
      if ((await RcFncChk.rcCheckESVoidSMode())
          || (await RcFncChk.rcCheckESVoidIMode())) {
        if (FbInit.subinitMainSingleSpecialChk() && (cMem.stat.dualTSingle == 1)) {
          await RcItmDsp.dualTSingleCshrDspClr();
        }
        else {
          RcMbrCom.rcmbrClearModeStlDisp();    /* MEMBER LCD MK  CLEAR  */
        }
      }
      else {
        await RcItmDsp.dualTSingleCshrDspClr();
      }
      await RcItmDsp.rcDspMbrmkLCD();  /* MEMBER MAKE LCD CLEAR */
      RcMbrCom.rcmbrClearModeDisp();  /* MEMBER LCD MK  CLEAR  */
      if (!RcSysChk.rcChkMbrprcSystem()) {
        RcMbrCom.rcmbrClearModeDisp();			        /* MEMBER LCD MK  CLEAR  */
      }
      if (!RcSysChk.rcChkMbrprcSystem()) {
        RcMbrCom.rcmbrClearModeDisp(); /* MEMBER LCD MK  CLEAR  */
      }
      /* フルセルフレジかつSM61仕様の場合はrcMbrCncl_Disp()を実行しない */
      if (((await RcSysChk.rcSGChkSelfGateSystem()) &&
          RcSysChk.rcChkSm61FujifilmSystem())
          || (RcSysChk.rcChkSm71SelectionSystem() &&
              ((await RcSysChk.rcChkShopAndGoSystem()) ||
                  (((await RcSysChk.rcSGChkSelfGateSystem()) ||
                      (await RcSysChk.rcQCChkQcashierSystem())) &&
                  !(await RcSysChk.rcSysChkHappySmile())) ) ) ) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
            "RckyMbre.rcClr2ndMbrClr(): Not run rcMbrCncl_Disp()");
      } else {
        if (CompileFlag.POINT_CARD) {
          if (!((await RcSysChk.rcChkPointCardSystem()) &&
              ((mem.tTtllog.t100700.mbrInput == MbrInputType.pcardmngKeyInput.index) ||
                  (mem.tTtllog.t100700.mbrInput == MbrInputType.pcarduseKeyInput.index)))) {
            if (CompileFlag.RALSE_MBRSYSTEM) {
              if (RcSysChk.rcChkRalseCardSystem()) {
                if (mbrTyp == Mcd.MCD_RLSSTAFF) {
                  await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_STAFF2);
                }
                else if (CompileFlag.RALSE_CREDIT && (mbrTyp == Mcd.MCD_RLSOTHER)) {
                  await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_OTHCARD2);
                }
                else {
                  await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_MBR2);
                }
              }
              else {
                if ((RcSysChk.rcsyschkYunaitoHdSystem() == 1)
                    && (mbrInput == MbrInputType.barReceivInput.index)) {
                  await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_RECEIV);
                }
                else {
                  await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_MBR2);  /* Cancel OK Display	 */
                }
              }
            }
            else {
              if ((RcSysChk.rcsyschkYunaitoHdSystem() == 1)
                  && (mbrInput == MbrInputType.barReceivInput.index)) {
                await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_RECEIV);
              }
              else {
                await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_MBR2);  /* Cancel OK Display	 */
              }
            }
          }
          else if (CompileFlag.RALSE_MBRSYSTEM
              && (RcSysChk.rcChkRalseCardSystem() &&
                  (mbrInput == MbrInputType.mbrprcKeyInput.index))) {
            if (mbrTyp == Mcd.MCD_RLSSTAFF) {
              await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_STAFF2);
            }
            else if (CompileFlag.RALSE_CREDIT && (mbrTyp == Mcd.MCD_RLSOTHER)) {
              await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_OTHCARD2);
            }
            else {
              await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_MBR2);
            }
          }
          else if (mbrInput == MbrInputType.mbrprcKeyInput.index) {
            Rcmbrkymbr.rcmbrDispFIP(await RcSysChk.rcKySelf());
          }
        }
        else {
          if (CompileFlag.RALSE_MBRSYSTEM) {
            if (RcSysChk.rcChkRalseCardSystem()) {
              if (mbrTyp == Mcd.MCD_RLSSTAFF) {
                await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_STAFF2);
              }
              else if (CompileFlag.RALSE_CREDIT && (mbrTyp == Mcd.MCD_RLSOTHER)) {
                await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_OTHCARD2);
              }
              else {
                await RcStl.rcSpritCncl(ImageDefinitions.IMG_CNCLCONF_MBR2);
              }
            }
            else {
              await _rcMbrCnclDisp(ImageDefinitions.IMG_CNCLCONF_MBR2);
            }
          }
          else {
            await _rcMbrCnclDisp(ImageDefinitions.IMG_CNCLCONF_MBR2);
          }
        }
      }
    }
    RcRegs.kyStR0(cMem.keyStat, FuncKey.KY_MBRCLR.keyId);  /* Reset Bit 1 of KY_MBRCLR	*/
    mem.tTtllog.t100001Sts.mbrcnclFlg = 0;    /* Mbrcncl flg Reset */

    debugPrint('********** 実機調査ログ（会員取消）12: CmCksys.cmZHQSystem() = ${CmCksys.cmZHQSystem()}');
    /* アイテム登録がある・プリカ宣言されていた場合はリセットしない */
    if (await CmCksys.cmZHQSystem() == 0) {
      /* 「会員取消」（もしくは標準仕様「会員売価」）以外登録ステータスがあるかチェック */
      if ( (await RcFncChk.rcCheckOtherRegistration() == 0)
          && ( !( (mem.tmpbuf.workInType == 1) &&
               RcSysChk.rcChkCogcaSystem() ||
               RcSysChk.rcChkRepicaSystem() ||
               RcSysChk.rcChkValueCardSystem() ||
               (RcSysChk.rcChkAjsEmoneySystem() &&
                   (await CmCksys.cmDs2GodaiSystem() == 0)) ) ) ) {
        cMem.postReg = PostReg();
        RcRegs.kyStR1(cMem.keyStat, FncCode.KY_REG.keyId);  /* Reset Bit 1 of KY_REG	*/
      }
    }
    else {
      if ( (mem.tTtllog.t100001Sts.itemlogCnt == 0)
          && ( (mem.tmpbuf.workInType == 1) &&
              (RcSysChk.rcChkCogcaSystem() ||
                  RcSysChk.rcChkRepicaSystem() ||
                  RcSysChk.rcChkAjsEmoneySystem()) ) ) {
        cMem.postReg = PostReg();
        RcRegs.kyStR1(cMem.keyStat, FncCode.KY_REG.keyId);  /* Reset Bit 1 of KY_REG	*/
      }
    }
    await RcSet.rcClearKyItem();					/* Set Bit 3 of KY_FNAL		*/
    await RcKyTab.rcTabClearDisp();

    if (CompileFlag.REWRITE_CARD) {
      if ((await RcSysChk.rcChkTRCSystem())
          && ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
              RcSysChk.rcChkRewriteCheckerCnct() ||
              (await RcSysChk.rcCheckQCJCSystem()) ) ) {
        debugPrint('********** 実機調査ログ（会員取消）13-1a: CompileFlag.REWRITE_CARD - RcTrcCom.rcTrcEjectProc()');
        RcTrcCom.rcTrcEjectProc();
      }
      if ((await RcSysChk.rcChkMcp200System())
          && ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
              (await RcSysChk.rcCheckQCJCSystem()) ) ) {
        debugPrint('********** 実機調査ログ（会員取消）13-1b: CompileFlag.REWRITE_CARD - RcMcp200Com.rcMcp200ResetProc()');
        RcMcp200Com.rcMcp200ResetProc();
      }
    }
    if (CompileFlag.IWAI) {
      if ((await RcSysChk.rcChkORCSystem())
          && ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
              (await RcSysChk.rcCheckQCJCSystem()) ) ) {
        debugPrint('********** 実機調査ログ（会員取消）13-2: CompileFlag.IWAI - RcOrcCom.rcOrcEjectProc()');
        RcOrcCom.rcOrcEjectProc();
      }
    }
    if (CompileFlag.VISMAC) {
      if ((await RcSysChk.rcChkVMCSystem())
          && ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
              (await RcSysChk.rcCheckQCJCSystem()) ) ) {
        debugPrint('********** 実機調査ログ（会員取消）13-3: CompileFlag.VISMAC - RcVmcCom.rcVmcEjectProc()');
        RcVmcCom.rcVmcEjectProc();
      }
    }
    if (CompileFlag.POINT_CARD) {
      if ((await RcSysChk.rcChkPointCardSystem())
          && ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
              (await RcSysChk.rcCheckQCJCSystem()) ) ) {
        debugPrint('********** 実機調査ログ（会員取消）13-4: CompileFlag.POINT_CARD - RcCrwpCom.rcCrwpResetProc()');
        RcCrwpCom.rcCrwpResetProc();
      }
    }
    if (CompileFlag.SAPPORO) {
      if (((await RcSysChk.rcChkSapporoPanaSystem()) ||
          (await RcSysChk.rcChkJklPanaSystem()) ||
          (await CmCksys.cmRainbowCardSystem() != 0) ||
          (await CmCksys.cmPanaMemberSystem() != 0) ||
          (await CmCksys.cmMoriyaMemberSystem() != 0))
          && ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
              (await RcSysChk.rcCheckQCJCSystem()) ) ) {
        debugPrint('********** 実機調査ログ（会員取消）13-5: CompileFlag.SAPPORO - RcSapporoPanaCom.rcSapporoPanaResetProc()');
        RcSapporoPanaCom.rcSapporoPanaResetProc();
      }
    }

    if ((mem.tTtllog.t100001Sts.itemlogCnt == 0) &&
        (!ReptEjConf.rcCheckRegistration())) {
      if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
        debugPrint('********** 実機調査ログ（会員取消）14-1: RcSet.cashStatReset2()');
        RcSet.cashStatReset2("RckyMbre.rcClr2ndMbrClr()");
      }
      else if ((CmCksys.cmFbDualSystem() == 2)
          && (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER)) {
        debugPrint('********** 実機調査ログ（会員取消）14-2: RcSet.rcClearDualChkReg()');
        await RcSet.rcClearDualChkReg();
      }
    }
    if ((await RcSysChk.rcChkHt2980System())
        && ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
            (await RcSysChk.rcCheckQCJCSystem()))
        && (mbrInput != MbrInputType.mbrprcKeyInput.index)) {
      debugPrint('********** 実機調査ログ（会員取消）15: RcHt2980Com.rcHt2980ResetProc()');
      RcHt2980Com.rcHt2980ResetProc();
    }
    if ((await RcSysChk.rcChkAbsV31System())
        && ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
            (await RcSysChk.rcCheckQCJCSystem()))
        && (mbrInput == MbrInputType.absV31Input.index)) {
      debugPrint('********** 実機調査ログ（会員取消）16: RcAbsV31.rcAbsV31ResetProc()');
      RcAbsV31.rcAbsV31ResetProc();
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RckyMbre.rcClr2ndMbrClr(): rxMemRead error");
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    AtSingl atSing = SystemFunc.readAtSingl();
    if ((cBuf.dbTrm.originalCardOpe != 0) && (atSing.limitFlg != 0)) {
      atSing.limitFlg = 0;
    }

    if ((CompileFlag.ARCS_MBR && (await RcSysChk.rcChkNTTDPrecaSystem()) )
        || RcSysChk.rcChkTRKPrecaSystem()
        || (await RcSysChk.rcChkEntryPrecaTyp() != 0)) {
      if (mem.tTtllog.calcData.suspendFlg == 1) {
        debugPrint('********** 実機調査ログ（会員取消）17-1: mem.tTtllog.calcData.suspendFlg == 1');
        atSing.limitAmount = 0;
        atSing.mbrCdBkup = "";
        mem.tmpbuf.autoCallReceiptNo = 0;
        mem.tmpbuf.autoCallMacNo = 0;
      }
      if ((mem.tmpbuf.autoCallReceiptNo != 0)
          && (mem.tmpbuf.autoCallMacNo == 0)) {
        debugPrint('********** 実機調査ログ（会員取消）17-2: mem.tmpbuf.autoCallReceiptNo = 0');
        mem.tmpbuf.autoCallReceiptNo = 0;
      }
    }
    if (await CmCksys.cmIchiyamaMartSystem() != 0) {
      debugPrint('********** 実機調査ログ（会員取消）18: CmCksys.cmIchiyamaMartSystem() != 0');
      cMem.jis1TmpBuf = "";
      cMem.jis2TmpBuf = "";
    }

    if (!((RcRegs.rcInfoMem.rcRecog.recogTrkPreca != 0) ||
        (RcRegs.rcInfoMem.rcRecog.recogRepicaSystem != 0) ||
        (RcRegs.rcInfoMem.rcRecog.recogValuecardSystem != 0) ||
        (RcRegs.rcInfoMem.rcRecog.recogCogcaSystem != 0) ||
        (RcRegs.rcInfoMem.rcRecog.recogAjsEmoneySystem != 0))) {
      debugPrint('********** 実機調査ログ（会員取消）19: mem.tmpbuf.workInType = 0');
      mem.tmpbuf.workInType = 0;
      RcTrkPreca.rcSusRegEtcRedisp();
    }

    if ((RcRegs.rcInfoMem.rcRecog.recogAjsEmoneySystem != 0)
        && (await CmCksys.cmDs2GodaiSystem() != 0)) {
      debugPrint('********** 実機調査ログ（会員取消）20: mem.tmpbuf.ajsEmoneyCard = RxMemAjsEmoneyCard()');
      mem.tmpbuf.workInType = 0;
      mem.tmpbuf.ajsEmoneyCard = RxMemAjsEmoneyCard();
      RcTrkPreca.rcSusRegEtcRedisp();
    }

    mem.tmpbuf.prombmpNonfile = 0;
  }

  /// キャンセル画面を表示する
  /// 引数: 画像No
  /// 関連tprxソース:rckymbre.c - rcMbrCncl_Disp
  static Future<void> _rcMbrCnclDisp(int imgNo) async {
    AcMem cMem = SystemFunc.readAcMem();
    AplLibImgRead.aplLibImgRead(imgNo);  //AplLib_ImgRead(imgNo, cMem.scrData.msgLcd, 24);

    if ((await RcFncChk.rcCheckESVoidSMode())
        || (await RcFncChk.rcCheckESVoidIMode())) {
      return;
    }
    if ((RcSysChk.rcChkCustrealUIDSystem() != 0)
        && (cMem.stat.fncCode != FuncKey.KY_MBRCLR.keyId)
        && (imgNo == ImageDefinitions.IMG_CNCLCONF_MBR2)) {
      return;
    }
    if (await RcFncChk.rcCheckBuyHistMode()) {  // 購買履歴画面
      return;
    }

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_DUALCSHR:
        await RcItmDsp.rcLcdPrice();
        RcItmDsp.rcFipCnclKey(RcRegs.FIP_NO1);
        if ((await RcFncChk.rcCheckItmMode())
            && RcSysChk.rcChkItemDisplayType()) {
          await RcItmDsp.rcDspTtlPrcLCD(RcRegs.OPE_END);
        }
        if (CompileFlag.PRESET_ITEM) {
          await RcItmDsp.presetItemDsp();
        }
        break;
      case RcRegs.KY_SINGLE:
        await RcItmDsp.rcLcdPrice();
        RcItmDsp.rcFipCnclKey(RcRegs.FIP_BOTH);
        if ((await RcFncChk.rcCheckItmMode())
            && RcSysChk.rcChkItemDisplayType()) {
          await RcItmDsp.rcDspTtlPrcLCD(RcRegs.OPE_END);
        }
        if (FbInit.subinitMainSingleSpecialChk()) {
          RcStlLcd.rcStlLcdSpritCncl(imgNo, RegsDef.dualSubttl);
        }
        break;
      case RcRegs.KY_CHECKER:
        await RcItmDsp.rcLcdPrice();
        RcItmDsp.rcFipCnclKey(RcRegs.FIP_NO2);
        if ((await RcFncChk.rcCheckItmMode())
            && RcSysChk.rcChkItemDisplayType()) {
          await RcItmDsp.rcDspTtlPrcLCD(RcRegs.OPE_END);
        }
        if (CompileFlag.PRESET_ITEM) {
          await RcItmDsp.presetItemDsp();
        }
        break;
      default:
        break;
    }
  }

  /// 関連tprxソース:rckymbre.c - rcStlDsp_MemberClr
  static Future<void> _rcStlDspMemberClr() async {
    if ((await RcFncChk.rcCheckESVoidSMode())
        || (await RcFncChk.rcCheckESVoidIMode())) {
      return;
    }

    AcMem cMem = SystemFunc.readAcMem();
    if ((RcSysChk.rcChkCustrealUIDSystem() != 0)
        && (cMem.stat.fncCode != FuncKey.KY_MBRCLR.keyId)) {
      return;
    }

    int wCtrl = 0;
    if ((cMem.stat.scrMode == RcRegs.RG_ITM) ||
        (cMem.stat.scrMode == RcRegs.VD_ITM) ||
        (cMem.stat.scrMode == RcRegs.TR_ITM)) {
      wCtrl = RcStlLcd.FSTLLCD_RESET_ITEMINDEX;
    } else {
      wCtrl = RcStlLcd.FSTLLCD_NOT_LCDINIT;
    }

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_DUALCSHR:
        RcStFip.rcStlFip(RcRegs.FIP_NO1);
        RcStlLcd.rcStlLcd(wCtrl, RegsDef.subttl);
        Rc28StlLcd.rc28StlLcdChange(ChangePart.CT_CLEAR.index, RegsDef.subttl);
        break;
      case RcRegs.KY_CHECKER:
        RcStFip.rcStlFip(RcRegs.FIP_NO2);
        RcStlLcd.rcStlLcd(wCtrl, RegsDef.subttl);
        Rc28StlLcd.rc28StlLcdChange(ChangePart.CT_CLEAR.index, RegsDef.subttl);
        break;
      case RcRegs.KY_SINGLE:
        RcStFip.rcStlFip(RcRegs.FIP_NO1);
        RcStFip.rcStlFip(RcRegs.FIP_NO2);
        RcStlLcd.rcStlLcd(wCtrl, RegsDef.subttl);
        Rc28StlLcd.rc28StlLcdChange(ChangePart.CT_CLEAR.index, RegsDef.subttl);
        break;
      default:
        break;
    }
  }

  /// 顧客リアル「PI」仕様のポイント利用取消でエラー発生後の処理
  /// 関連tprxソース:rckymbre.c - rckymbre_PointInfinityContinue
  static Future<void> _pointInfinityContinue() async {
    // ダイアログ表示をクリア
    TprDlg.tprLibDlgClear("RckyMbre._pointInfinityContinue()");
    await RcExt.rxChkModeReset("RckyMbre._pointInfinityContinue()");
    // 会員取消処理
    await rcClr2ndMbrClr();
  }

  /// ディスプレイフラグをクリアする
  /// 関連tprxソース:rckymbre.c - rcVmc_AchievFlgReset
  static void _rcVmcAchievFlgReset() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    if (cBuf.vmcChgReq == 1) {
      cBuf.vmcChgReq = 0;
    }
    if (cBuf.vmcHesoReq == 1) {
      cBuf.vmcHesoReq = 0;
    }
  }
}