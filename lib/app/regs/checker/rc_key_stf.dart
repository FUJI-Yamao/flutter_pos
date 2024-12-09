/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
//import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../../lib/apllib/apllib_staffpw.dart';
import '../../lib/apllib/opncls_lib.dart';
import '../../lib/cm_chg/bcdtol.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../ui/menu/register/m_menu.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/page/staff_open/controller/c_open_close_page_controller.dart';
import '../../ui/page/staff_open/enum/e_openclose_enum.dart';
import '../../ui/page/staff_open/w_open_close_page.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_59dsp.dart';
import 'rc_auto.dart';
import 'rc_ewdsp.dart';
import 'rc_ext.dart';
import 'rc_mbr_realsvr.dart';
import 'rc_mcd.dart';
import 'rc_obr.dart';
import 'rc_set.dart';
import 'rcfncchk.dart';
import 'rcky_2stf.dart';
import 'rcky_rfdopr.dart';
import 'rcky_stfrelease.dart';
import 'rcopncls.dart';
import 'rcsyschk.dart';

class RcKyStf {
  static List<int> staffList0 = [FncCode.KY_ENT.keyId, FncCode.KY_REG.keyId, 0];
  static List<int> staffList1 = [FncCode.KY_SCAN.keyId, FncCode.KY_PSET.keyId, 0];
  static List<int> staffList2 = [0];
  static List<int> staffList3 = [FncCode.KY_FNAL.keyId, 0];
  static List<int> staffList4 = [FuncKey.KY_STAFF.keyId, 0];
  static int staffPwFlg = 0;
  static int staffCdBuf = 0;
  static int staffCdInputBuf = 0;


  /// 従業員キーが押されたときの処理.
  static Future<void> openStaffInputDialog() async {
    if (await staffKeyPressed()) {
              Future.delayed(Duration.zero, () {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StaffOpenClosePage(labels: const [
            OpenCloseInputFieldLabel.codeNum,
            OpenCloseInputFieldLabel.password
          ]);
        },
      ).then((success) {
        if (!success) {
          Get.back();
        }
      });
    });
    }
  }


  /// 従業員キー押下時
  /// 戻り値: true=従業員クローズ成功  false=従業員クローズ失敗
  static Future<bool> staffKeyPressed() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;

    // 背景を登録画面まで戻す
    SetMenu1.navigateToRegisterPage();

    // 従業員クローズ処理
    if (pCom.dbStaffopen.cshr_status == 0) {
      //従業員クローズ中
      _showInfoMessage(MsgDialogType.info, "従業員クローズ済みです。");
    } else {
      //従業員オープン中
      RegsMem mem = SystemFunc.readRegsMem();
      if (mem.tTtllog.getItemLogCount() > 0) {
        //商品登録がある
        _showInfoMessage(MsgDialogType.error, "商品登録を取り消してください。");
      } else {
        //商品登録をしていない
        int errCode = await AplLibStaffPw.staffKeyPressed();
        if (errCode > 0) {
          _showErrorMessageId(errCode);
        } else {
          //_showInfoMessage(MsgDialogType.info, "従業員クローズしました。");
          return true;
        }
      }
    }
    return false;
  }

  

  /// ダイアログ表示処理（引数：メッセージ）
  /// 引数:[typ] ダイアログタイプ（確認orエラー）
  /// 引数:[msg] ダイアログメッセージ
  static void _showInfoMessage(MsgDialogType typ, String msg) {
    MsgDialog.show(
      MsgDialog.singleButtonMsg(
        type: typ,
        message: msg,
      ),
    );
  }

  /// ダイアログ表示処理（引数：エラーNo）
  /// 引数:[errCd] エラーコード
  static void _showErrorMessageId(int errCd) {
    //すでにエラーダイアログが表示されたら、新しいerrダイアログを出せない
    if (MsgDialog.isDialogShowing) {
      return;
    }

    MsgDialog.show(
      MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        dialogId: errCd,
      ),
    );
  }



  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース:rcky_stf.c - rcStfPostTend
  static bool rcStfPostTend() {
    return false;
  }

  // TODO:00002 佐野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース:rcky_stf.c - rcChkForceStaff
  static Future<int> rcChkForceStaff() async {
    /*
    rc_Clr_Reason();/* clear MEM->prnrbuf.reason SM7_HOKUSHIN */
    rcPrgStfReleaseRestore(); /* SM7_HOKUSHIN */
    rcPrgStfReleaseClear(); /* SM7_HOKUSHIN */

    if (CompileFlag.SELF_GATE) {
      if (await RcSysChk.rcSGChkSelfGateSystem()) {
        return 0;
      }
    }
    if (await RcSysChk.rcCheckWizAdjUpdate()) {
      return 0;
    }
    if (RcSysChk.rcCheckWiz()) {
      return 0;
    }

    if (RckyRfdopr.rcRfdOprCheckAllRefundMode()
        || RckyRfdopr.rcRfdOprCheckRcptVoidMode()
        || RckyRfdopr.rcRfdOprCheckManualRefundMode()) {
      // 結果確認画面表示中なので
      return 0;
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    if (cBuf.dbTrm.frcClkFlg == 1) {
      if ((cBuf.dbTrm.clkEveryCloseFlg == 0) && (RcSysChk.rcChkStfMode() == 1)) {
        return 1;
      }
    }
    else if ((CompileFlag.SIMPLE_2STAFF) && (cBuf.dbTrm.frcClkFlg == 2)) {
      if ((cBuf.dbTrm.clkEveryCloseFlg == 0)
          && (RcSysChk.rcChkStfMode() == 1)
          && (CmStf.cmPersonChk() == 1)) {
        return 1;
      }
    }
     */
    return 0;
  }

  /// 従業員キー判定
  /// 引数:[chkFlg] 0以外で特定のチェック処理を除外する
  /// 戻り値: エラーコード（0=OK）
  /// 関連tprxソース:rcky_stf.c - rcChk_Ky_Staff
  static Future<int> rcChkKyStaff(int chkFlg) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcKyStf.rcChkKyStaff(): rxMemRead error");
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    if (cBuf.dbTrm.frcClkFlg != 2) {
      //TODO:00002 佐野 - 202306納品仕様で以降の判定を有効にするため、コメント化
      //return DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
    }

    AcMem cMem = SystemFunc.readAcMem();
    cMem.keyChkb = List.filled(cMem.keyChkb.length, 0xff);
    for (int i = 0; i < staffList0.length; i++) {
      if (staffList0[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, staffList0[i]);
    }
    for (int i = 0; i < staffList1.length; i++) {
      if (staffList1[i] == 0) {
        break;
      }
      RcRegs.kyStR1(cMem.keyChkb, staffList1[i]);
    }
    for (int i = 0; i < staffList2.length; i++) {
      if (staffList2[i] == 0) {
        break;
      }
      RcRegs.kyStR2(cMem.keyChkb, staffList2[i]);
    }
    for (int i = 0; i < staffList3.length; i++) {
      if (staffList3[i] == 0) {
        break;
      }
      RcRegs.kyStR3(cMem.keyChkb, staffList3[i]);
    }
    for (int i = 0; i < staffList4.length; i++) {
      if (staffList4[i] == 0) {
        break;
      }
      RcRegs.kyStR4(cMem.keyChkb, staffList4[i]);
    }
    int ret = RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3);
    if (ret != 0) {
      return RcEwdsp.rcSetDlgAddDataKeyStatusResult(ret);
    }

    if (chkFlg == 0) {
      if ((RcSysChk.rcChkCustrealsvrSystem() != 0) ||
          (RcSysChk.rcChkCustrealNecSystem(0) != 0)) {
        if ((RcMbrRealsvr.custRealSvrWaitChk() != 0) ||
            (RcMcd.rcMcdMbrWaitChk() != 0)) {
          return DlgConfirmMsgKind.MSG_MBRINQUIR.dlgId;
        }
      }
    }

    // 返品操作中は実行エラー
    if (RckyRfdopr.rcRfdOprCheckOperateRefundMode()) {
      return DlgConfirmMsgKind.MSG_TRANSTFNOTCHG.dlgId;
    }

    return 0;
  }

  /// 置数禁止設定(disable_ent_ope_simple_openclose)での従業員キー判定
  /// 関連tprxソース:rcky_stf.c - rcChk_Ky_Staff_Disable_Ent
  static Future<int> rcChkKyStaffDisableEnt() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RcKyStf.rcChkKyStaffDisableEnt(): rxMemRead error");
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    AtSingl atSing = SystemFunc.readAtSingl();
    int errNo = 0;
    if ((!(await RcObr.rcChkStfBarcode())) &&
        (cBuf.dbTrm.frcClkFlg != 0) &&
        (cBuf.dbTrm.disableEntOpeSimpleOpenclose != 0)) {
      if ((await RcSysChk.rcChkStfMode() == 0) || RcFncChk.rcChkTenOn() ||
          (atSing.inputbuf.Smlcode != 0)) {
        errNo = DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
      }
    }
    return errNo;
  }

  /// 関連tprxソース:rcky_stf.c - rc_no_staff
  static int rcNoStaff() {
    // TODO:10146 従業員キー_宣言のみ
    return 0;
  }

  /// 関連tprxソース:rcky_stf.c - rc_single
  static int rcSingle() {
    // TODO:10146 従業員キー_宣言のみ
    return 0;
  }

  /// 関連tprxソース:rcky_stf.c - rc_single_over
  static int rcSingleOver() {
    // TODO:10146 従業員キー_宣言のみ
    return 0;
  }

  /// 関連tprxソース:rcky_stf.c - rcKyStf_Sub
  static Future<int> rcKyStfSub() async {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.ent.errNo = await RcOpnCls.entry();

    int mode = 0;
    int errNo = 0;
    if (cMem.ent.errNo == 0) {
      mode = await RcSysChk.rcChkStfMode();
      if (await RcOpnCls.overOpenCheck() != 0) {
        switch (mode) {
          case 0:
            errNo = rcNoStaff();
            break;
          case 1:
            errNo = rcSingle();
            break;
          default:
            errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
            break;
        }
      } else {
        switch (mode) {
          case 0:
            errNo = DlgConfirmMsgKind.MSG_CLERKUSED.dlgId;
            break;
          case 1:
            errNo = rcSingleOver();
            break;
          default:
            errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
            break;
        }
      }
      cMem.ent.errNo = errNo;
    }
    return cMem.ent.errNo;
  }

  /// 従業員キー押下時の処理
  /// 関連tprxソース:rcky_stf.c - rcKyStf
  static Future<void> rcKyStf() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcKyStf(): rxMemRead error");
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    if (RckyRfdopr.rcRfdOprCheckManualRefundMode()) {
      cMem.ent.errNo = DlgConfirmMsgKind.MSG_TRANSTFNOTCHG.dlgId;
      await RcExt.rcErr("rcKyStf", cMem.ent.errNo);
      return;
    }
    if (await CmCksys.cmStaffReleaseSystem() != 0) {
      if (await RckyStfRelease.rcChkStfRelease()) {
        await RcExt.rcErr("rcKyStf", DlgConfirmMsgKind.MSG_OPEERR.dlgId);
        RcSet.rcClearEntry();
        return;
      }
    }

    if ((cBuf.vtclRm5900RegsOnFlg) &&
        (cBuf.dbStaffopen.cshr_status == OpnClsLib.OPNCLS_STATUS_OPEN) &&
        (CmCksys.cmChkRm5900FloatingSystem() != 0)) {
      // ログを調査した結果、選択した従業員が不明なため、ログを追加
      // TODO:10143 従業員オープンクローズ実装対象外（RM3800フローティング仕様）
      /*
      int rm38StaffCd = rc59_get_staff_cd();
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "[RM-5900] rcKyStf(): Floating Select Staff_Code[$rm38StaffCd]");
      // 従業員存在チェック
      cMem.ent.errNo = rc59_Floating_Staff_Chk ( );
      if (cMem.ent.errNo != 0) {
        await RcExt.rcErr("rcKyStf", cMem.ent.errNo);
        return;
      }
      if ( rc59_floating_chk( ) == 1 ) {
        // 商品選択中
        rc59_Floating_Add_Item ( );	// 商品加算
      } else {
        RegsMem mem = SystemFunc.readRegsMem();
        if (RcFncChk.rcCheckRegistration() &&
            (mem.tTtllog.t100001Sts.itemlogCnt > 0)) {
          rc59_Floating_Set_ItemLog ( );	// 商品加算保存
        } else {
          rc59_Floating_Stl ( );		// 加算情報呼び出し
        }
      }
      return;
       */
    }

    if (CompileFlag.SIMPLE_2STAFF) {
      if (cBuf.dbTrm.frcClkFlg == 2) {
        await Rcky2Stf.rcKyStf2();
        return;
      }
    }
    if (CompileFlag.SIMPLE_STAFF) {
      cMem.ent.errNo = await rcChkKyStaffDisableEnt();
      if (cMem.ent.errNo != 0) {
        await RcExt.rcErr("rcKyStf", cMem.ent.errNo);
        RcSet.rcClearEntry();
        return;
      }
    }

    cMem.ent.errNo = await rcChkKyStaff(0);
    if (cMem.ent.errNo == 0) {
      if (await rcStfStaffEventChk() == 0) {
        // 従業員オープン画面表示中でない
        await rcSimpleStaffDisp(0);
        if (FbInit.subinitMainSingleSpecialChk()) {
          await rcSimpleStaffDisp(1);
        }
        return;
      }
    }

    if (cMem.ent.errNo == 0) {
      cMem.ent.errNo = await rcKyStfSub();
    }

    if (cMem.ent.errNo != 0) {
      await RcExt.rcErr("rcKyStf", cMem.ent.errNo);
      RcSet.rcClearEntry();
    } else {
      // 自動開閉設動作中の為の処理
      if (AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) != 0) {
        // 自動動作中
        if (AplLibAuto.aplLibAutoGetAutoMode(await RcSysChk.getTid())
            <= AutoMode.AUTOMODE_KY_CHGPICK.val) {
          RcAuto.rcAutoStrOpnClsJudg();
        }
      }
    }

    if (AplLibStaffPw.staffPw.staffData.staffOpen == 0) {
      await AplLibStaffPw.callCloseStaffAPI();
    }
  }

  /// 従業員オープン画面表示中のチェック
  /// 戻り値: 0=非表示  1=表示中
  /// 関連tprxソース:rcky_stf.c - rcStf_StaffEvent_Chk
  static Future<int> rcStfStaffEventChk() async {
    if (staffPwFlg == 1) {
      //登録終了時これを参照
      return 1;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcStfStaffEventChk(): rxMemRead error");
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR) {
      return tsBuf.cash.staff_pw;
    } else {
      return tsBuf.chk.staff_pw;
    }
  }

  ///【簡易従業員仕様】従業員オープン画面表示対応
  /// 従業員オープン中であれば、クローズして画面を表示
  /// 引数:[devId] タワータイプ（0=タワー表示  1=卓上表示）
  /// 関連tprxソース:rcky_stf.c - rc_SimpleStaff_Disp
  static Future<void> rcSimpleStaffDisp(int devId) async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcSimpleStaffDisp(): start");

    AtSingl atSing = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();
    String dataBuf = "0";
    int errNo = 0;
    if (devId == 0) {
      /* 従業員番号取得 */
      staffCdBuf = 0;
      staffCdInputBuf = 0;
      if (atSing.inputbuf.dev == DevIn.D_OBR) {  /* 従業員バーコードスキャン */
        //cm_opncls_check_inputcode(await RcSysChk.getTid(), dataBuf, cMem.working.janInf.code);
        staffCdBuf = int.parse(dataBuf);
        staffCdInputBuf = 2;  /* バーコードは２ */
      } else if (atSing.inputbuf.Smlcode != 0) {  /* 従業員プリセット／自動開閉店、QCJC番号取得 */
        staffCdBuf = atSing.inputbuf.Smlcode;
        staffCdInputBuf = 1;
      } else if (Bcdtol.cmBcdToL(cMem.ent.entry) != 0) {  /* 従業員手入力 */
        staffCdBuf = Bcdtol.cmBcdToL(cMem.ent.entry);
        staffCdInputBuf = 1;
      }

      if ((AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) == AutoRun.AUTORUN_NON.val)
          && (Rc59dsp.rm59FloatingAutoStaffOpneGet() == 0)
          && (staffCdInputBuf != 0)) {
        /* 入力された従業員コードをチェックし、従業員コードであれば外部変数に取得データを格納する */
        errNo = await RcOpnCls.entry2();
        if (errNo != 0) {
          cMem.ent.errNo = errNo;
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
              "rcSimpleStaffDisp(): err[$errNo] rcopncls_entry2");
          await RcExt.rcErr("rcSimpleStaffDisp", cMem.ent.errNo);
          return;
        }
        /* 従業員交代チェック */
        if (await RcOpnCls.overOpenCheck() != 0) {
          //従業員交代ではない時
          staffCdBuf = 0;
          staffCdInputBuf = 0;
        }
      }
    }
  }
}