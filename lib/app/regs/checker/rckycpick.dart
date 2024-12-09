/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/common/environment.dart';
import 'package:flutter_pos/app/regs/checker/rc_28dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_acracb.dart';
import 'package:flutter_pos/app/regs/checker/rc_acracbdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_assist_mnt.dart';
import 'package:flutter_pos/app/regs/checker/rc_auto.dart';
import 'package:flutter_pos/app/regs/checker/rc_clxos_changer.dart';
import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rc_flrda.dart';
import 'package:flutter_pos/app/regs/checker/rc_gtktimer.dart';
import 'package:flutter_pos/app/regs/checker/rc_ifevent.dart';
import 'package:flutter_pos/app/regs/checker/rc_inout.dart';
import 'package:flutter_pos/app/regs/checker/rc_itm_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_mbr_com.dart';
import 'package:flutter_pos/app/regs/checker/rc_obr.dart';
import 'package:flutter_pos/app/regs/checker/rc_recno.dart';
import 'package:flutter_pos/app/regs/checker/rc_rfmdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_set.dart';
import 'package:flutter_pos/app/regs/checker/rc_setdate.dart';
import 'package:flutter_pos/app/regs/checker/rc_sgdsp.dart';
import 'package:flutter_pos/app/regs/checker/rc_stl.dart';
import 'package:flutter_pos/app/regs/checker/rc_stl_cal.dart';
import 'package:flutter_pos/app/regs/checker/rc_usbcam1.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcinoutdsp.dart';
import 'package:flutter_pos/app/regs/checker/rcky_cin.dart';
import 'package:flutter_pos/app/regs/checker/rcky_clr.dart';
import 'package:flutter_pos/app/regs/checker/rcky_rpr.dart';
import 'package:flutter_pos/app/regs/checker/rckyccin.dart';
import 'package:flutter_pos/app/regs/checker/rckyccin_acb.dart';
import 'package:flutter_pos/app/regs/checker/rcsg_com.dart';
import 'package:flutter_pos/app/regs/checker/rcstllcd.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:flutter_pos/app/regs/checker/regs.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sprintf/sprintf.dart';
import 'package:uuid/uuid.dart';

import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../common/cls_conf/configJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../fb/fb_lib.dart';
import '../../fb/fb_style.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/image.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/apl/rxtbl_buff_keyopt.dart';
import '../../inc/db/c_ttllog_sts.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/cm_nedit.dart';
import '../../inc/lib/cm_str_molding_define.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/lib/if_suica.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/ex/L_tprdlg.dart';
import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/apllib_auto.dart';
import '../../lib/apllib/apllib_img_read.dart';
import '../../lib/apllib/apllib_inifile.dart';
import '../../lib/apllib/apllib_other.dart';
import '../../lib/apllib/apllib_strutf.dart';
import '../../lib/apllib/cnct.dart';
import '../../lib/cm_ary/chk_spc.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/if_acx/acx_com.dart';
import '../../lib/pr_sp/cm_str_molding.dart';
import '../../tprlib/TprLibDlg.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../common/rxkoptcmncom.dart';
import '../inc/L_rckycpick.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'liblary.dart';

import 'package:get/get.dart';
import '../../ui/page/charge_collect/p_charge_collect.dart';

///  関連tprxソース: rckycpick.c
class RcKyCpick {
  static KindPickInfo kindOutInfo = KindPickInfo();
  static KindPickInfo bkKindOutInfo = KindPickInfo();
  static KoptinoutBuff koptInOut = KoptinoutBuff();
  static StrChgInOutDisp cPick = StrChgInOutDisp();
  static CoinData pCoinData = CoinData();
  static CoinData cPickOrg = CoinData();
  static InOutCloseData inOutClose = InOutCloseData();
  static OverFlowInfo overFlow = OverFlowInfo();
  static PickData cPickData = PickData();
  static EcsPayout ecsPayoutData = EcsPayout();

  static int opeSet = 0;
  static int pickMth = 0;
  static int nextFlg = 1;
  static int autoFlg = 0;
  static List<String> envData = List.generate(
      IfAcxDef.ECS_ENVSET_DATA_MAX, (_) => '');
  static int overflowPickFlg = 0; // 1:オーバーフロー回収キー  2:自動精算(オーバーフロー回収設定)
  static int cPickErrno = 0; //釣銭機の回収に対するエラーをセット
  static int cPickWinDispTyp = 0; // 表示タイプ (0: 卓上  1: タワー)
  static int btnPressFlgOrg = 0; //回収方法の選択（戻し入れ終了後に再度回収選択をセットするためのセーブ）
  static int pickMode = 0; //実際の回収方法（残置等設定に応じ回収方法が変更されたもの）
  static int actMsgFlg = 0;
  static String asstPcLog = '';
  static int asstSusMode = 0;
  static List<int> cPickUnit = [
    10000,
    5000,
    2000,
    1000,
    500,
    100,
    50,
    10,
    5,
    1
  ];
  static Function? fncConf;
  static KindPickInfo contInfo = KindPickInfo();
  static int resvAmt = 0;
  static int resvDrwAmt = 0;
  static int errEnd = 0;

  /// Constant Values
  static List<int> diffChgPick0 = [
    FncCode.KY_REG.keyId,
    FncCode.KY_ENT.keyId,
    FuncKey.KY_PLU.keyId,
    0
  ];
  static List<int> diffChgPick1 = [0];
  static List<int> diffChgPick2 = [0];
  static List<int> diffChgPick3 = [0];
  static List<int> diffChgPick4 = [0];

  static const OVERFLOW_PICK_NON = 0;
  static const OVERFLOW_PICK_KEY = 1; //オーバーフロー回収キー
  static const OVERFLOW_AUTO_STRCLS = 2; //自動精算(オーバーフロー回収設定)

  static int pickDataSave = 0;
  static int btnPressFlg = 0; //回収方法の選択（押下されたもの）
  static int cPickDlgErrno = 0;

  /// 釣機回収が正常に完了したかどうかのフラグ
  static bool complete = true;

  /// つり機回収画面を開く
  static void openDifCheckPage(String title, FuncKey key) {
    Get.to(() => ChargeCollectScreen(title: title, funcKey: key));
  }

  ///  関連tprxソース: rckycpick.c - rc_KindOut_Prn_Clr
  static void rcKindOutPrnClr() {
    RegsMem mem = SystemFunc.readRegsMem();
    mem.tTtllog.t105100Sts.kindoutPrnFlg = 0;
    mem.tTtllog.t105100Sts.kindoutPrnStat1 = 0;
    mem.tTtllog.t105100Sts.kindoutPrnStat2 = 0;
    mem.tTtllog.t105100Sts.kindoutPrnStat3 = 0;
    mem.tTtllog.t105100Sts.kindoutPrnStat4 = 0;
    mem.tTtllog.t105100Sts.kindoutPrnStat5 = 0;
    mem.tTtllog.t105100Sts.kindoutPrnStat6 = 0;
    mem.tTtllog.t105100Sts.kindoutPrnStat7 = 0;
    mem.tTtllog.t105100Sts.kindoutPrnStat8 = 0;
    mem.tTtllog.t105100Sts.kindoutPrnStat9 = 0;
    mem.tTtllog.t105100Sts.kindoutPrnStat10 = 0;
    mem.tTtllog.t105100Sts.kindoutPrnErrno1 = 0;
    mem.tTtllog.t105100Sts.kindoutPrnErrno2 = 0;
    mem.tTtllog.t105100Sts.kindoutPrnErrno3 = 0;
    mem.tTtllog.t105100Sts.kindoutPrnErrno4 = 0;
    mem.tTtllog.t105100Sts.kindoutPrnErrno5 = 0;
    mem.tTtllog.t105100Sts.kindoutPrnErrno6 = 0;
    mem.tTtllog.t105100Sts.kindoutPrnErrno7 = 0;
    mem.tTtllog.t105100Sts.kindoutPrnErrno8 = 0;
    mem.tTtllog.t105100Sts.kindoutPrnErrno9 = 0;
    mem.tTtllog.t105100Sts.kindoutPrnErrno10 = 0;
  }

  /// TODO:00010 長田 定義のみ追加
  ///  関連tprxソース: rckycpick.c - rcSst_BillMoveProc
  static int rcSstBillMoveProc() {
    int err_no = 0;
    //
    // switch (if_acb_select()) {
    //   case SST1 :
    //   case FAL2 :
    //     break;
    //   default :
    //     return (0);
    // }
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcSst_BillMoveProc");
    // err_no = rcAcrAcb_ChangeOut(0);
    // if (err_no == OK) {
    //   err_no = rcPrg_AcrAcb_ResultGet();
    //   if (err_no == OK) {
    //     rcSst_BillMoveWait();
    //   }
    // }
    return (err_no);
  }

  /// KY_CHGPICK  Management Program
  ///  関連tprxソース: rckycpick.c - rcKyChgPick
  static Future<void> rcKyChgPick() async {
    int resvAmt = 0;
    int resvDrwAmt = 0;
    int errEnd = 0;
    int cpickErrno = 0;
    int cpickEntryNoflg = 0;
    AcMem cMem = SystemFunc.readAcMem();
    String callFunc = '';

    rcKindOutPrnClr();

    kindOutInfo = KindPickInfo();
    bkKindOutInfo = KindPickInfo();
    nextFlg = 1;
    opeSet = 0;
    pickMth = 0;
    Rcinoutdsp.rcNoStaffGetSet(1, 0);
    await rcCPickAutoFlgSet(0);

    if (await RcSysChk.rcSGChkSelfGateSystem()) {
      Rcinoutdsp.rcSGKeyImageTextMake(FuncKey.KY_CHGPICK.keyId);
    }

    cMem.ent.errNo = await rcCheckKyChgPick();

    if (cMem.ent.errNo == 0) {
      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_777) != 0) {
        if (cMem.stat.fncCode == FuncKey.KY_CHGPICK.keyId &&
            await rcChkAutoOverFlowPick() == 0) {
          /* 回収先設定を出金庫にする */
          await rcKyChgOverFlowPickStartProc(2);
        }
      }

      // 釣機回収を行った場合のＵＳＢカメラのスタート
      if (await RcSysChk.rcQCChkQcashierSystem()) {
        RcUsbCam1.rcUsbcamStopSet(0, UsbCamStat.QC_CAM_STOP.index);
        RcUsbCam1.rcUsbcamStartStop(UsbCamStat.QC_CAM_START.index, 0);
      }

      await RcFlrda.rcReadKoptinout(cMem.stat.fncCode, koptInOut);
      await rcKyDifferentChgPick();
//      if(AplLib_CMAuto_MsgSend_Chk(GetTid())){
      if (await rcChkCMAutoPickAutoCPick()) {
        btnPressFlg = ChgPickBtn.BTN_OFF.index;

        if (!RcFncChk.rcChkErrNon() ||
            cMem.ent.errNo != 0 ||
            TprLibDlg.tprLibDlgCheck2(1) != 0) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "ChgPick : Auto PickBtn Select Not Doing");
          complete = false;
          return;
        }

        if (await rcChkCMAutoPickAutoAll()) {
          await rcChgPickAllFuncMain();
        } else {
          await rcChgPickReserveFuncMain();
        }

        await rcCPickAutoFlgSet(1);

        if (RcFncChk.rcChkErrNon() &&
            cMem.ent.errNo == 0 &&
            TprLibDlg.tprLibDlgCheck2(1) == 0 &&
            cMem.scrData.price == 0 &&
            await Rcinoutdsp.rcInOutStaffEntChk() != 0) {
          cMem.staffInfo!.entFlg =
              ((int.tryParse(cMem.staffInfo!.entFlg) ?? 0) | 0x04).toString();
          Rcinoutdsp.rcNoStaffGetSet(1, 1);
          complete = false;
        }

        await Rcinoutdsp.rcAutoExec(rcQuitMain, rcExecFuncMain);
      }
    } else {
      complete = false;
      await RcExt.rcErr(callFunc, cMem.ent.errNo);
      /* 自動開閉設動作中 */
      if (AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) != 0) {
        await RcAuto.rcAutoStrOpnClsFuncErrStop(
            cMem.ent.errNo); /* エラー発生の為、自動化中止 */
      }
    }
  }

  ///  関連tprxソース: rckycpick.c - rcCPick_AutoFlg_Set
  static Future<void> rcCPickAutoFlgSet(int flg) async {
    String log = '';

    log = "rcCPick_AutoFlg_Set($flg)\n";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    autoFlg = flg;
  }

  ///  関連tprxソース: rckycpick.c - rcCheck_Ky_ChgPick
  static Future<int> rcCheckKyChgPick() async {
    int p = 0;
    AcMem cMem = SystemFunc.readAcMem();

//   if(rcKy_Self() == KY_CHECKER)
    if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER &&
        !await RcSysChk.rcCheckQCJCSystem()) {
//      return(MSG_OPEERR);
      return DlgConfirmMsgKind.MSG_DO_DESKTOPSIDE.dlgId;
    }

    if (await RcAcracb.rcCheckAcrAcbON(1) == 0) {
      /* Not ACRorACB System ? */
//      return(MSG_OPEERR);
      return RcAcracb.rcCheckAcrAcbOFFType(0);
    }

    if (RcSysChk.rcChkTRDrwAcxNotUse()) {
      return DlgConfirmMsgKind
          .MSG_TR_ACX_NOTUSE.dlgId; //練習モードでの釣銭機「禁止」に設定されています
    }

    Liblary.cmFil(cMem.keyChkb, 0xff, cMem.keyChkb.length);

    for (int i = 0; i < diffChgPick0.length; i++) {
      if (diffChgPick0[i] == 0) {
        break;
      }
      RcRegs.kyStR0(cMem.keyChkb, diffChgPick0[i]);
    }

    for (int i = 0; i < diffChgPick1.length; i++) {
      if (diffChgPick1[i] == 0) {
        break;
      }
      RcRegs.kyStR1(cMem.keyChkb, diffChgPick1[i]);
    }

    for (int i = 0; i < diffChgPick2.length; i++) {
      if (diffChgPick2[i] == 0) {
        break;
      }
      RcRegs.kyStR2(cMem.keyChkb, diffChgPick2[i]);
    }

    for (int i = 0; i < diffChgPick3.length; i++) {
      if (diffChgPick3[i] == 0) {
        break;
      }
      RcRegs.kyStR3(cMem.keyChkb, diffChgPick3[i]);
    }

    for (int i = 0; i < diffChgPick4.length; i++) {
      if (diffChgPick4[i] == 0) {
        break;
      }
      RcRegs.kyStR4(cMem.keyChkb, diffChgPick4[i]);
    }

    if (RcFncChk.rcKyStatus(cMem.keyChkb, RcRegs.MACRO3) != 0) {
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    return Typ.OK;
  }

  ///  関連tprxソース: rckycpick.c - rcChk_Auto_OverFlow_Pick
  static Future<int> rcChkAutoOverFlowPick() async {
    //自動精算でオーバーフロー回収する設定
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if (Cnct.cnctMemGet(await RcSysChk.getTid(), CnctLists.CNCT_ACR_CNCT) !=
        0 //釣銭機接続
        && (AcxCom.ifAcbSelect() & CoinChanger.ECS_777) != 0 //ECS-777
        && cBuf.iniMacInfo.acx_flg.ecs_overflowpick_use == 1 //硬貨オーバーフロー回収を使用
        &&
        AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) != 0 //自動精算
        && await AplLibAuto.strOpnClsSetChk(await RcSysChk.getTid(),
            StrOpnClsCodeList.STRCLS_CPICK_COIN_POSITN) == 1) {
      //回収搬送先「ｵｰﾊﾞｰﾌﾛｰ庫」
      return 1;
    }

    return 0;
  }

  /// 機能：オーバーフロー回収開始時の処理
  /// 引数：short flg : 変更フラグ 1:オーバーフロー庫に変更 2:出金口に変更
  /// 戻値：0:OK その他:エラー番号
  /// 関連tprxソース: rckycpick.c - rcKy_Chg_OverFlow_Pick_Start_Proc
  static Future<int> rcKyChgOverFlowPickStartProc(int flg) async {
    String log = '';
    int ret = 0;
    String callFunc = 'rcKyChgOverFlowPickStartProc';

    /* 釣銭機動作条件設定読込 */
    envData = List.generate(IfAcxDef.ECS_ENVSET_DATA_MAX, (_) => '');
    ret = await rcKyChgOverFlowPickSettingRead();
    if (ret != 0) {
      return ret;
    }

    /* 設定値変更 */
    if (rcChkOverFlowPickFlg(OVERFLOW_PICK_NON) != 0) {
      //設定変更後の値を保存しないように制御
      log = "$callFunc: Save data[${envData[0]}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      pickDataSave = int.tryParse(envData[0]) ?? 0;
    }

    ret = await rcKyChgOverFlowPickSettingDataChg(flg, envData);

    if (ret == 0) {
      /* 設定書込 */
      ret = await rcKyChgOverFlowPickSettingSet();
      if (ret != 0) {
        return ret;
      }
    }

    return 0;
  }

  /// 機能：釣銭機設定(硬貨回収時搬送先設定)を取得
  /// 引数：なし
  /// 戻値：0:OK その他:エラー番号
  /// 関連tprxソース: rckycpick.c - rcKy_Chg_OverFlow_Pick_SettingRead
  static Future<int> rcKyChgOverFlowPickSettingRead() async {
    int ret = 0;
    String log = '';
    List<int> mode = List.generate(3, (_) => 0);
    String callFunc = 'rcKyChgOverFlowPickSettingRead';

    ret = IfAcxDef.MSG_ACROK;

    // 釣銭機設定（データグループ1A）を取得
    mode[0] = 0x31;
    mode[1] = 0x3A;
    ret = await RcAcracb.rcEcsRASSettingDtl(0, mode, envData);

    // 釣銭機の状態リードコマンド送信に失敗した場合
    if (ret != IfAcxDef.MSG_ACROK) {
      log = " $callFunc Error ret = $ret\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);

      if (ret == DlgConfirmMsgKind.MSG_ACRLINEOFF.dlgId) {
        ret = DlgConfirmMsgKind.MSG_ACRLINEOFF.dlgId; // 釣銭機が接続されていません
      } else if (ret == IfAcxDef.MSG_ACRDATAERR) {
        ret = DlgConfirmMsgKind.MSG_DATA_ERROR.dlgId; // データが異常です。
      }
      return ret;
    } else {
      log = " $callFunc: Setting Read\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }

    return ret;
  }

  /// 関連tprxソース: rckycpick.c - rcChk_OverFlow_Pick_Flg
  static int rcChkOverFlowPickFlg(int type) {
    //overflow_pick_flg判定
    if (overflowPickFlg == type) {
      return 1;
    }
    return 0;
  }

  /// 機能：硬貨回収時搬送先設定の設定値変更
  /// 引数：short flg	: 変更フラグ 0:元に戻す 1:オーバーフロー庫に変更 2:出金口に変更
  /// char *data	: 設定データ(データグループ1A)
  /// 戻値：0:設定値変更　1:設定値変更不要->書換不要
  /// 関連tprxソース: rckycpick.c - rcKy_Chg_OverFlow_Pick_Setting_DataChg
  static Future<int> rcKyChgOverFlowPickSettingDataChg(int flg,
      List<String> data) async {
    String log = '';
    String callFunc = 'rcKyChgOverFlowPickSettingDataChg';

    switch (flg) {
      case 1:
        if (data[0] == '\x34') {
          log = "$callFunc: Change[$flg] data[${data[0]}] -> No Change\n";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          return 1;
        }
        log = "$callFunc: Change[$flg] data[${data[0]}]->[34]\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        data[0] = '\x34';
        break;
      case 2:
        if (data[0] == '\x30') {
          log = "$callFunc: Change[$flg] data[${data[0]}] -> No Change\n";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          return 1;
        }
        log = "$callFunc: Change[$flg] data[${data[0]}]->[30]\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        data[0] = '\x30';
        break;
      default:
        if (pickDataSave == 0 || data[0] == '$pickDataSave') {
          //設定がセーブされていない もしくは設定変更が不要
          log = "$callFunc: Change[$flg] data[${data[0]}] -> No Change\n";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          return 1;
        }
        log = "$callFunc: Change[$flg] data[${data[0]}]->[$pickDataSave]\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        data[0] = '$pickDataSave';
        break;
    }

    return 0;
  }

  /// 機能：釣銭機設定を送信
  /// 引数：なし
  /// 戻値：0:OK その他:エラー番号
  /// 関連tprxソース: rckycpick.c - rcKy_Chg_OverFlow_Pick_SettingSet
  static Future<int> rcKyChgOverFlowPickSettingSet() async {
    int ret = 0;
    String log = '';
    List<int> mode = List.empty(growable: true);
    String callFunc = 'rcKyChgOverFlowPickSettingSet';

    ret = IfAcxDef.MSG_ACROK;

    // 釣銭機設定（データグループ1A）を送信
    mode[0] = 0x31;
    mode[1] = 0x3A;
    ret = await RcAcracb.rcEcsRASSettingDtl(1, mode, envData);

    // 釣銭機の状態設定コマンド送信に失敗した場合
    if (ret != IfAcxDef.MSG_ACROK) {
      log = " $callFunc Error ret = $ret\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);

      if (ret == DlgConfirmMsgKind.MSG_ACRLINEOFF.dlgId) {
        ret = DlgConfirmMsgKind.MSG_ACRLINEOFF.dlgId; // 釣銭機が接続されていません
      } else if (ret == IfAcxDef.MSG_ACRDATAERR) {
        ret = DlgConfirmMsgKind.MSG_DATA_ERROR.dlgId; // データが異常です。
      } else {
        ret = DlgConfirmMsgKind
            .MSG_ACRERROR.dlgId; // 釣銭機が異常です。\nエラーコード確認後、解除操作\nを行って下さい。
      }
      return ret;
    } else {
      log = " $callFunc: Setting Set\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }

    return ret;
  }

  /// 関連tprxソース: rckycpick.c - rcKy_DifferentChgPick
  static Future<void> rcKyDifferentChgPick() async {
    int errNo = 0;
    int errTyp = 0;
    AcMem cMem = SystemFunc.readAcMem();
    String callFunc = 'rcKyDifferentChgPick';

    // 元ソースのgoto文の置き換えのためループ処理に変更
    // （ループ処理でしかラベルが使用できないため）
    ChgPickChkEnd:
    while (true) {
      errNo = await rcChkDifferentChgPick();
      if (errNo == Typ.OK) {
        errNo = await RcAcracb.rcAcrAcbAnswerReadDtl();
        if (errNo == Typ.OK) {
          if (await RcSysChk.rcSGChkSelfGateSystem()) {
            // TODO:10164 自動閉設 UI系の為保留
            // rcSG_EntDsp_Entry();
            errNo = await rcPrgDifferentChgPick();
            if (errNo != Typ.OK) {
              break ChgPickChkEnd;
            }
            return;
          }

          if (await RcSysChk.rcQCChkQcashierSystem()) {
            await RcItmDsp.rcQCEntDspEntry();
            errNo = await rcPrgDifferentChgPick();
            if (errNo != Typ.OK) {
              break ChgPickChkEnd;
            }
            return;
          }
          if (!await RcFncChk.rcCheckStlMode() && !RcFncChk.rcCheckSItmMode()) {
            if (!ChkSpc.cmChkSpc(
                cMem.scrData.subibuf, cMem.scrData.subibuf.length)) {
              await RcItmDsp.rcDspQtyLCD();
              await RcItmDsp.rcDspEntLCD();
              await RcItmDsp.rcQtyClr();
            }
          }
          errNo = await rcPrgDifferentChgPick();
          break ChgPickChkEnd;
        } else {
          errTyp = 1;
          break ChgPickChkEnd;
        }
      }
    }

    if (errNo != Typ.OK) {
      complete = false;
      await rcEndKyChgInOut();
      if (errTyp == 1) {
        await RcKyccin.ccinErrDialog2(callFunc, errNo, 0);
      } else {
        await RcExt.rcErr(callFunc, errNo);
      }

      /* 自動開閉設動作中 */
      if (AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) != 0 &&
          !await RcFncChk.rcCheckChgInOutMode()) {
        await RcAuto.rcAutoStrOpnClsFuncErrStop(errNo); /* エラー発生の為、自動化中止 */
      }
    }
  }

  /// 関連tprxソース: rckycpick.c - rcChk_DifferentChgPick
  static Future<int> rcChkDifferentChgPick() async {
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    if (!RcRegs.kyStC0(cMem.keyStat[cMem.stat.fncCode]) &&
        RcRegs.kyStC0(cMem.keyStat[FncCode.KY_ENT.keyId])) {
      return DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }

    if (await RcSysChk.rcCheckPrimeStat() == RcRegs.PRIMETOWER) {
      if (atSing.inputbuf.no == DevIn.KEY1) {
        return DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
      }
    }

    return Typ.OK;
  }

  /// 関連tprxソース: rckycpick.c - rcPrg_DifferentChgPick
  static Future<int> rcPrgDifferentChgPick() async {
    int errNo = 0;
    AcMem cMem = SystemFunc.readAcMem();
    String callFunc = 'rcPrgDifferentChgPick';

    errNo = Typ.OK;
    RegsMem().tTtllog.t105100Sts.cpickErrno = 0;
    cPickErrno = 0;

    await rcStartDifferentChgPick();
    errNo = rcSstBillMoveProc();
    if (errNo != Typ.OK) {
      complete = false;
      return errNo;
    }

    await rcCPickStockMake();
    //回収実行前在高を保存する
    cPickOrg = CoinData();
    cPickOrg = cMem.coinData;
    await rcChgPickDisp();

    errNo = RcAcracb.rcChkChgStockState();
    if (errNo != Typ.OK) {
      complete = false;
      await RcExt.rcErr(callFunc, errNo);
    }

    return Typ.OK;
  }

  /// 関連tprxソース: rckycpick.c - rcStart_DifferentChgPick
  static Future<void> rcStartDifferentChgPick() async {
    String callFunc = 'rcStartDifferentChgPick';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    await RcExt.cashStatSet(callFunc);
    tsBuf.cash.inout_flg = 1;
    rcEditKeyData();
    if (cMem.keyStat.length >= cPick.fncCode && cPick.fncCode >= 0) {
      RcRegs.kyStS0(cMem.keyStat, cPick.fncCode); /* Set Bit 0 of KY_CHGPICK? */
    }
    RcRegs.kyStS0(cMem.keyStat, FncCode.KY_REG.keyId); /* Set Bit 0 of KY_REG */
  }

  /// 関連tprxソース: rckycpick.c - rcCPickStockMake
  static Future<void> rcCPickStockMake() async {
    //在高取得用（カセット回収待ち状態取得とはわける）
    CoinData pCoinDataBk = CoinData();
    String log = '';
    String buf = '';
    int i = 0;
    AcMem cMem = SystemFunc.readAcMem();
    String callFunc = 'rcCPickStockMake';

    await RcAcracb.rcChkAcrAcbChkStock(0);
    pCoinDataBk = pCoinData;
    pCoinData = cMem.coinData;
    if (kindOutInfo.typ != 0 &&
        (kindOutInfo.nowKind != kindOutInfo.firstKind ||
            (await rcCPickUnitShtChk() &&
                kindOutInfo.nowKind == kindOutInfo.firstKind &&
                kindOutInfo.ttlSht[kindOutInfo.nowKind] != 0))) { //出金中
      ChgInOutDisp value = ChgInOutDisp.getDefine(kindOutInfo.nowKind);
      switch (value) {
        case ChgInOutDisp.CHGINOUT_Y1:
          pCoinData.overflow.coin5 = pCoinDataBk.overflow.coin5;
          pCoinData.holder.coin5 = pCoinDataBk.holder.coin5;
          if (await rcCPickUnitShtChk() &&
              kindOutInfo.ttlSht[kindOutInfo.nowKind] != 0 &&
              kindOutInfo.nowKind ==
                  ChgInOutDisp.CHGINOUT_Y1.value) { //棒金単位金種別出金した場合は在高更新しない
            pCoinData.overflow.coin1 = pCoinDataBk.overflow.coin1;
            pCoinData.holder.coin1 += kindOutInfo.ttlSht[kindOutInfo.nowKind];
          }
        case ChgInOutDisp.CHGINOUT_Y5:
          pCoinData.overflow.coin10 = pCoinDataBk.overflow.coin10;
          pCoinData.holder.coin10 = pCoinDataBk.holder.coin10;
          if (await rcCPickUnitShtChk() &&
              kindOutInfo.ttlSht[kindOutInfo.nowKind] != 0 &&
              kindOutInfo.nowKind ==
                  ChgInOutDisp.CHGINOUT_Y5.value) { //棒金単位金種別出金した場合は在高更新しない
            pCoinData.overflow.coin5 = pCoinDataBk.overflow.coin5;
            pCoinData.holder.coin5 += kindOutInfo.ttlSht[kindOutInfo.nowKind];
          }
        case ChgInOutDisp.CHGINOUT_Y10:
          pCoinData.overflow.coin50 = pCoinDataBk.overflow.coin50;
          pCoinData.holder.coin50 = pCoinDataBk.holder.coin50;
          if (await rcCPickUnitShtChk() &&
              kindOutInfo.ttlSht[kindOutInfo.nowKind] != 0 &&
              kindOutInfo.nowKind ==
                  ChgInOutDisp.CHGINOUT_Y10.value) { //棒金単位金種別出金した場合は在高更新しない
            pCoinData.overflow.coin10 = pCoinDataBk.overflow.coin10;
            pCoinData.holder.coin10 += kindOutInfo.ttlSht[kindOutInfo.nowKind];
          }
        case ChgInOutDisp.CHGINOUT_Y50:
          pCoinData.overflow.coin100 = pCoinDataBk.overflow.coin100;
          pCoinData.holder.coin100 = pCoinDataBk.holder.coin100;
          if (await rcCPickUnitShtChk() &&
              kindOutInfo.ttlSht[kindOutInfo.nowKind] != 0 &&
              kindOutInfo.nowKind ==
                  ChgInOutDisp.CHGINOUT_Y50.value) { //棒金単位金種別出金した場合は在高更新しない
            pCoinData.overflow.coin50 = pCoinDataBk.overflow.coin50;
            pCoinData.holder.coin50 += kindOutInfo.ttlSht[kindOutInfo.nowKind];
          }
        case ChgInOutDisp.CHGINOUT_Y100:
          pCoinData.overflow.coin500 = pCoinDataBk.overflow.coin500;
          pCoinData.holder.coin500 = pCoinDataBk.holder.coin500;
          if (await rcCPickUnitShtChk() &&
              kindOutInfo.ttlSht[kindOutInfo.nowKind] != 0 &&
              kindOutInfo.nowKind ==
                  ChgInOutDisp.CHGINOUT_Y100.value) { //棒金単位金種別出金した場合は在高更新しない
            pCoinData.overflow.coin100 = pCoinDataBk.overflow.coin100;
            pCoinData.holder.coin100 += kindOutInfo.ttlSht[kindOutInfo.nowKind];
          }
        case ChgInOutDisp.CHGINOUT_Y500:
          pCoinData.overflow.bill10000 = pCoinDataBk.overflow.bill10000;
          pCoinData.overflow.bill5000 = pCoinDataBk.overflow.bill5000;
          pCoinData.overflow.bill2000 = pCoinDataBk.overflow.bill2000;
          pCoinData.overflow.bill1000 = pCoinDataBk.overflow.bill1000;
          pCoinData.holder.bill10000 = pCoinDataBk.holder.bill10000;
          pCoinData.holder.bill5000 = pCoinDataBk.holder.bill5000;
          pCoinData.holder.bill2000 = pCoinDataBk.holder.bill2000;
          pCoinData.holder.bill1000 = pCoinDataBk.holder.bill1000;
          if (await rcCPickUnitShtChk() &&
              kindOutInfo.ttlSht[kindOutInfo.nowKind] != 0 &&
              kindOutInfo.nowKind ==
                  ChgInOutDisp.CHGINOUT_Y500.value) { //棒金単位金種別出金した場合は在高更新しない
            pCoinData.overflow.coin500 = pCoinDataBk.overflow.coin500;
            pCoinData.holder.coin500 += kindOutInfo.ttlSht[kindOutInfo.nowKind];
          }
          break;
        default:
          break;
      }

      log = sprintf("%s: Before overflow[%i,%i,%i,%i,%i,%i,%i,%i,%i,%i]", [
        callFunc,
        pCoinDataBk.overflow.bill10000,
        pCoinDataBk.overflow.bill5000,
        pCoinDataBk.overflow.bill2000,
        pCoinDataBk.overflow.bill1000,
        pCoinDataBk.overflow.coin500,
        pCoinDataBk.overflow.coin100,
        pCoinDataBk.overflow.coin50,
        pCoinDataBk.overflow.coin10,
        pCoinDataBk.overflow.coin5,
        pCoinDataBk.overflow.coin1
      ]);
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

      log = sprintf("%s: After overflow[%i,%i,%i,%i,%i,%i,%i,%i,%i,%i]", [
        callFunc,
        pCoinData.overflow.bill10000,
        pCoinData.overflow.bill5000,
        pCoinData.overflow.bill2000,
        pCoinData.overflow.bill1000,
        pCoinData.overflow.coin500,
        pCoinData.overflow.coin100,
        pCoinData.overflow.coin50,
        pCoinData.overflow.coin10,
        pCoinData.overflow.coin5,
        pCoinData.overflow.coin1
      ]);
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

      log = sprintf("%s: Before holder[%i,%i,%i,%i,%i,%i,%i,%i,%i,%i]", [
        callFunc,
        pCoinDataBk.holder.bill10000,
        pCoinDataBk.holder.bill5000,
        pCoinDataBk.holder.bill2000,
        pCoinDataBk.holder.bill1000,
        pCoinDataBk.holder.coin500,
        pCoinDataBk.holder.coin100,
        pCoinDataBk.holder.coin50,
        pCoinDataBk.holder.coin10,
        pCoinDataBk.holder.coin5,
        pCoinDataBk.holder.coin1
      ]);
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

      log = sprintf("%s: After holder[%i,%i,%i,%i,%i,%i,%i,%i,%i,%i]", [
        callFunc,
        pCoinData.holder.bill10000,
        pCoinData.holder.bill5000,
        pCoinData.holder.bill2000,
        pCoinData.holder.bill1000,
        pCoinData.holder.coin500,
        pCoinData.holder.coin100,
        pCoinData.holder.coin50,
        pCoinData.holder.coin10,
        pCoinData.holder.coin5,
        pCoinData.holder.coin1
      ]);
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

      log = sprintf("%s: OverSht[", [callFunc]);
      for (i = ChgInOutDisp.CHGINOUT_Y10000.value; i <=
          ChgInOutDisp.CHGINOUT_Y1.value; i ++) {
        if (kindOutInfo.overSht[i] < 0) {
          kindOutInfo.overSht[i] = 0;
        }
        buf = "${kindOutInfo.overSht[i]}";
        if (i < ChgInOutDisp.CHGINOUT_Y1.value) {
          buf = "$buf,";
        } else {
          buf = "$buf]";
        }
        log = log + buf;
      }
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
  }

  /// 関連tprxソース: rckycpick.c - rcCPick_UnitSht_Chk
  static Future<bool> rcCPickUnitShtChk() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if (cBuf.dbTrm.coinUnitSht > 0 &&
        Rxkoptcmncom.rxChkKoptCmnChgPickKindOut(cBuf) == 2) {
      if (await RcFncChk.rcCheckChgInOutMode()) {
        return true;
      }
    }

    return false;
  }

  /// 関連tprxソース: rckycpick.c - rcChgPickDisp
  static Future<void> rcChgPickDisp() async {
    cPick.cashRecycle = 0;
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RxInputBuf iBuf = RxInputBuf();

    if (FbInit.subinitMainSingleSpecialChk() == true) {
      if (inOutClose.closePickFlg == 1) {
        cMem.stat.dualTSingle = inOutClose.devId;
      } else {
        cMem.stat.dualTSingle = cBuf.devId;
      }
    } else {
      cMem.stat.dualTSingle = 0;
    }

    // どちらで画面を表示しているかを保持しておく
    if (cMem.stat.dualTSingle == 1) {
      cPickWinDispTyp = 1; // タワー
    } else {
      cPickWinDispTyp = 0;
    }

    if (await RcSysChk.rcSGChkSelfGateSystem()) {
      cMem.stat.dualTSingle = 0;
      await RcObr.rcScanDisable();

      if(cPick.cashRecycle != 0){
        // TODO:10164 自動閉設 キャッシュリサイクル
        // rcCashrecycleExecFunc();
      }else if(rcChkOverFlowPickFlg(OVERFLOW_PICK_NON) == 0){
        // TODO:10164 自動閉設 オーバーフロー回収実行
        // rcKy_Chg_OverFlow_Pick_Execfunc();
      }else{
        await rcExecFunc();
      }

      return;
    }

    if (await RcSysChk.rcQCChkQcashierSystem()) {
      cMem.stat.dualTSingle = 0;

      await RcObr.rcScanDisable();
      if (cPick.cashRecycle != 0) {
        // TODO:10164 自動閉設 キャッシュリサイクル
        // rcCashrecycleExecFunc();
      } else if (rcChkOverFlowPickFlg(OVERFLOW_PICK_NON) == 0) {
        // TODO:10164 自動閉設 オーバーフロー回収実行
        // rcKy_Chg_OverFlow_Pick_Execfunc();
      } else {
        await rcExecFunc();
      }

      return;
    }

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
      if (cPick.cashRecycle != 0) {
          // TODO:10164 自動閉設 キャッシュリサイクル
          // rcCashrecycleExecFunc();
        } else if (rcChkOverFlowPickFlg(OVERFLOW_PICK_NON) == 0) {
          // TODO:10164 自動閉設 オーバーフロー回収実行
          // rcKy_Chg_OverFlow_Pick_Execfunc();
        } else {
          await rcExecFunc();
        }
        break;
      case RcRegs.KY_SINGLE:
        if (FbInit.subinitMainSingleSpecialChk() == true) {
          await rcLcdMsgChgPickDisp();
          if (cPick.cashRecycle != 0) {
            // TODO:10164 自動閉設 キャッシュリサイクル
            // rcCashrecycleExecFunc();
          } else if (rcChkOverFlowPickFlg(OVERFLOW_PICK_NON) == 0) {
            // TODO:10164 自動閉設 オーバーフロー回収実行
            // rcKy_Chg_OverFlow_Pick_Execfunc();
          } else {
            await rcExecFunc();
          }
        } else {
          if (iBuf.devInf.devId != TprDidDef.TPRDIDTOUKEY1 &&
              iBuf.devInf.devId != TprDidDef.TPRDIDMECKEY1) {
            if (cPick.cashRecycle != 0) {
              // TODO:10164 自動閉設 キャッシュリサイクル
              // rcCashrecycleExecFunc();
            } else if (rcChkOverFlowPickFlg(OVERFLOW_PICK_NON) == 0) {
              // TODO:10164 自動閉設 オーバーフロー回収実行
              // rcKy_Chg_OverFlow_Pick_Execfunc();
            } else {
              await rcExecFunc();
            }
          }
        }
        break;
    }
  }

  /// 関連tprxソース: rckycpick.c - rcLcd_MsgChgPickDisp
  static Future<void> rcLcdMsgChgPickDisp() async {
    String buf = '';
    AcMem cMem = SystemFunc.readAcMem();

    if (await RcSysChk.rcSGChkSelfGateSystem() ||
        await RcSysChk.rcQCChkQcashierSystem()) {
      return;
    }

    if ((cMem.stat.scrMode == RcRegs.RG_STL) ||
        (cMem.stat.scrMode == RcRegs.VD_STL) ||
        (cMem.stat.scrMode == RcRegs.TR_STL) ||
        (cMem.stat.scrMode == RcRegs.SR_STL)) {
      await RcStlLcd.rcStlLcdQuit(RegsDef.subttl);
      await RcRfmDsp.rcItemDispLCD();
      await RcSet.rcItmLcdScrMode();
    }

    if (cPick.cashRecycle != 0) {
      AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_CASHRECYCLE_DRWCHG_OUT);
    } else {
      AplLibImgRead.aplLibImgRead(FuncKey.KY_CHGPICK.keyId);
    }

    cMem.scrData.msgLcd = sprintf(LRcKyCPick.CPICK_ING, [buf]);
    if (FbInit.subinitMainSingleSpecialChk() == true) {
      if (cMem.stat.dualTSingle == 1) {
        RcItmDsp.DualTSingleDlg(cMem.scrData.msgLcd, 0);
      } else {
        RcItmDsp.DualTSingleDlg(cMem.scrData.msgLcd, 1);
      }
    } else {
      await RcItmDsp.rcLcdPrice();
      await RcItmDsp.rcQtyClr();
    }

    return;
  }

  /// 関連tprxソース: rckycpick.c - rcEnd_Ky_ChgInOut
  static Future<void> rcEndKyChgInOut() async {
    String callFunc = 'rcEndKyChgInOut';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    if (inOutClose.closePickFlg == 1) {
      //締め精算処理中
      //釣機回収「終了」ボタン->締め精算終了
      if (inOutClose.updateFlg == 1) {
        //「次へ」であれば実績作成。精算処理中止であれば、実績は作成しない
        await Rcinoutdsp.rcInOutCloseLineUpdate(
            callFunc); //区切り線(ope_mode_flg)を実績上げ
      }
      inOutClose = InOutCloseData();
    }

    await RcSet.rcClearDataReg();
    RcSet.rcErr1timeSet();
    await RcSet.cashStatReset2(callFunc);
    if (await RcSysChk.rcCheckQCJCChecker()) {
      await RcSet.rcClearDualChkReg();
    }

    tsBuf.cash.inout_flg = 0;
    if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_777) != 0) {
      if (rcChkOverFlowPickFlg(OVERFLOW_PICK_NON) == 0) {
        overflowPickFlg = 0;
      }
    }

    cMem.keyStat = RcFncChk.rcKyResetStat(cMem.keyStat, RcRegs.MACRO0);
    if (cMem.keyStat.length >= cPick.fncCode && cPick.fncCode >= 0) {
      RcRegs.kyStR0(cMem.keyStat, cPick.fncCode); /* Reset Bit 0 of CPick.Fnc */
    }
    RcRegs.kyStS3(cMem.keyStat, FncCode.KY_FNAL.keyId); /* Set   Bit 3 of KY_FNAL */
  }

  /// 関連tprxソース: rckycpick.c - rcChk_CMAuto_Pick_AutoCPick
  static Future<bool> rcChkCMAutoPickAutoCPick() async {
    //CM精算で釣機回収の回収方法を自動「残置」「全回収」選択
    int chgPickFlg = 0;

    chgPickFlg = await AplLibAuto.strOpnClsSetChk(
        await RcSysChk.getTid(), StrOpnClsCodeList.STRCLS_CPICK);

    return AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) != 0 &&
        (chgPickFlg == 1 || chgPickFlg == 3);
  }

  /// 関連tprxソース: rckycpick.c - rcChk_CMAuto_Pick_AutoAll
  static Future<bool> rcChkCMAutoPickAutoAll() async {
    //CM精算で釣機回収の回収方法を自動「全回収」選択
    return (AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) != 0 &&
        await AplLibAuto.strOpnClsSetChk(
            await RcSysChk.getTid(), StrOpnClsCodeList.STRCLS_CPICK) == 3);
  }

  /// 関連tprxソース: rckycpick.c - rcChgPickAll_Func_Main
  static Future<void> rcChgPickAllFuncMain() async {
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();
    String callFunc = 'rcChgPickAllFuncMain';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    if (await RcSysChk.rcSGChkSelfGateSystem() ||
        await RcSysChk.rcQCChkQcashierSystem()) {
      log = LRcKyCPick.ALLPICK_LABEL;
      RcSgCom.mngPcLog = RcSgCom.mngPcLog + log;
      RcSgCom.rcSGManageLogButton();
      RcSgCom.rcSGManageLogSend(SgDsp.REG_LOG);
      RcAssistMnt.rcAssistSend(23064);
    }

    RcSet.rcClearEntry();

    //精査できない機種は全回収→再入金の流れなのでここでわざわざ警告しない
    if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) != 0 &&
        AcxCom.ifAcxStockStateChk(cMem.coinData.stockState) != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcChgPickAll_Func ALLBTN_ON");
      // TODO:10164 自動閉設 UI系の為保留
      // rcChgPick_BtnOn(ChgPickBtn.ALLBTN_ON.index);
      cMem.ent.errNo = DlgConfirmMsgKind.MSG_ACB_RECALC.dlgId;
      await RcSet.rcErrStatSet2(callFunc);
      await confDialog(cMem.ent.errNo);
      return;
    }

    if (btnPressFlg == ChgPickBtn.ALLBTN_ON.index) {
      if (cBuf.dbTrm.acxRecoverSameButton != 0) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "rcChgPickAll_Func ALLBTN_ON");
        return;
      } else {
        // TODO:10164 自動閉設 UI系の為保留
        // rcChgPick_BtnOff();
        return;
      }
    } else {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcChgPickAll_Func ALLBTN_ON");
      // TODO:10164 自動閉設 UI系の為保留
      // rcChgPick_BtnOn(ChgPickBtn.ALLBTN_ON.index);
      if (await rcChkChgPickPriceSet()) {
        cMem.ent.errNo = DlgConfirmMsgKind.MSG_CASTDAT.dlgId;
        await RcSet.rcErrStatSet2(callFunc);
        await confDialog(cMem.ent.errNo);
        return;
      } else {
        // await rcChgPickBtnProc();
      }
    }
  }

  /// 関連tprxソース: rckycpick.c - Conf_Dialog
  static Future<int> confDialog(int erCode) async {
    tprDlgParam_t param = tprDlgParam_t();
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    log = "Conf_Dialog($erCode)\n";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    cPickDlgErrno = erCode;

    RcSet.rcClearEntry();
    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
      case RcRegs.KY_DUALCSHR:
        param.erCode = erCode;
        param.dialogPtn = DlgPattern.TPRDLG_PT1.dlgPtnId;
        if (erCode == DlgConfirmMsgKind.MSG_ACB_RECALC.dlgId) {
          param.func1 = confClicked;
          param.msg1 = LTprDlg.BTN_CONF;
        } else {
          param.func1 = yesClicked;
          param.msg1 = LTprDlg.BTN_YES;
          param.func2 = noClicked;
          param.msg2 = LTprDlg.BTN_NO;
        }

        rcCPickDlg(
            param.erCode,
            param.dialogPtn,
            param.func1,
            param.msg1,
            param.func2,
            param.msg2,
            param.func3,
            param.msg3);

        break;
      case RcRegs.KY_SINGLE:
        if (cPick.nowDisplay == RcInOut.LDISP) {
          param.erCode = erCode;
          param.dialogPtn = DlgPattern.TPRDLG_PT1.dlgPtnId;
          if (erCode == DlgConfirmMsgKind.MSG_ACB_RECALC.dlgId) {
            param.func1 = confClicked;
            param.msg1 = LTprDlg.BTN_CONF;
          } else {
            param.func1 = yesClicked;
            param.msg1 = LTprDlg.BTN_YES;
            param.func2 = noClicked;
            param.msg2 = LTprDlg.BTN_NO;
          }

          if (cMem.stat.dualTSingle == 1) {
            param.dual_dsp = 2;
          }

          rcCPickDlg(
              param.erCode,
              param.dialogPtn,
              param.func1,
              param.msg1,
              param.func2,
              param.msg2,
              param.func3,
              param.msg3);

          break;
        }
    }

    if (await RcSysChk.rcSGChkSelfGateSystem() ||
        await RcSysChk.rcQCChkQcashierSystem()) {
      RcAssistMnt.asstPcLog = RcAssistMnt.asstPcLog + tsBuf.managePc.msgLogBuf;
      RcAssistMnt.rcAssistSend(erCode);
    }
    AplLibAuto.aplLibCMAutoErrMsgSend(await RcSysChk.getTid(), erCode);
    return 0;
  }

  /// 関連tprxソース: rckycpick.c - yes_clicked
  static Future<void> yesClicked() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "ChgPick Dlg Yes Click");
    await rcChgPickDlgClr();
    // TODO:10164 自動閉設 UI系の為保留
    // rcChgPick_DlgBtn(0);
    if (await RcSysChk.rcSGChkSelfGateSystem() ||
        await RcSysChk.rcQCChkQcashierSystem()) {
      RcSgCom.rcSGManageLogYesNo(RcSgDsp.JDG_YES);
    }
  }

  /// 関連tprxソース: rckycpick.c - no_clicked
  static Future<void> noClicked() async {
    TprLog().logAdd(
        await RcSysChk.getTid(), LogLevelDefine.normal, "ChgPick Dlg No Click");
    await rcChgPickDlgClr();
    // TODO:10164 自動閉設 UI系の為保留
    // rcChgPick_DlgBtn(1);
    if (await RcSysChk.rcSGChkSelfGateSystem() ||
        await RcSysChk.rcQCChkQcashierSystem()) {
      RcSgCom.rcSGManageLogYesNo(RcSgDsp.JDG_NO);
    }
    return;
  }

  /// 関連tprxソース: rckycpick.c - conf_clicked
  static Future<void> confClicked() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "ChgPick Dlg Conf Click");
    await rcChgPickDlgClr();
    // TODO:10164 自動閉設 UI系の為保留
    // rcChgPick_DlgBtn(2);
    if (await RcSysChk.rcSGChkSelfGateSystem() ||
        await RcSysChk.rcQCChkQcashierSystem()) {
      RcSgCom.rcSGManageLogYesNo(RcSgDsp.JDG_CONF);
    }
    return;
  }

  /// 関連tprxソース: rckycpick.c - rcChgPick_DlgClr
  static Future<void> rcChgPickDlgClr() async {
    String callFunc = 'rcChgPickDlgClr';
    _closeDialogAll();
    await RcExt.rcClearErrStat(callFunc);
    // gtk_grab_add(CPick.window);
  }

  /// 関連tprxソース: rckycpick.c - conf_clicked
  static Future<void> rcChgPickDlgBtn(int flg) async {
    //flg 0:はい 1:いいえ	err_noにより制御逆にする
    String log = '';
    String callFunc = 'rcChgPickDlgBtn';

    log = "$callFunc($cPickDlgErrno, $flg)\n";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    DlgConfirmMsgKind dlgId = DlgConfirmMsgKind.getDefine(cPickDlgErrno);
    switch (dlgId) {
      case DlgConfirmMsgKind.MSG_CASTDAT :
        if (flg == 1) {
          // TODO:10164 自動閉設 UI系の為保留
          // rcChgPick_BtnOff();
        } else {
          // await rcChgPickBtnProc();
        }
        break;
      default :
        if (flg == 2) {
          // await rcChgPickBtnProc();
        } else if (flg == 1) {
          // await rcChgPickBtnProc();
        } else {
          // TODO:10164 自動閉設 UI系の為保留
          // rcChgPick_BtnOff();
        }
        break;
    }
    cPickDlgErrno = 0;
  }

  /// 関連tprxソース: rckycpick.c - rcChgPick_BtnProc
  static Future<void> rcChgPickBtnProc() async {
    CBillKind shtData = CBillKind();
    int i = 0;
    int startPosition = 0;
    int shortFlg = 0;

    ChgPickBtn btn = ChgPickBtn.getDefine(pickMode);
    switch (btn) {
      case ChgPickBtn.ALLBTN_ON :
        await rcChgPickAllProc();
        break;
      case ChgPickBtn.RESERVEBTN_ON :
        await rcChgPickReserveProc();
        break;
      case ChgPickBtn.MANBTN_ON :
        await rcChgPickManProc();
        break;
      case ChgPickBtn.BILLBTN_ON :
        await rcChgPickBillProc();
        break;
      case ChgPickBtn.COINBTN_ON :
        await rcChgPickCoinProc();
        break;
      case ChgPickBtn.USERDATABTN_ON :
        await rcChgPickUserdataProc();
        break;
      case ChgPickBtn.FULLBTN_ON :
        await rcChgPickFullProc();
        break;
      case ChgPickBtn.CASETBTN_ON :
        await rcChgPickCasetProc();
        break;
      default :
      //枚数指定回収
        if (kindOutInfo.typ != 0) { //金種別出金
          shtData.bill10000 =
              cPick.btn[ChgInOutDisp.CHGINOUT_Y10000.value].cPickCount;
          shtData.bill5000 =
              cPick.btn[ChgInOutDisp.CHGINOUT_Y5000.value].cPickCount;
          shtData.bill2000 =
              cPick.btn[ChgInOutDisp.CHGINOUT_Y2000.value].cPickCount;
          shtData.bill1000 =
              cPick.btn[ChgInOutDisp.CHGINOUT_Y1000.value].cPickCount;
          shtData.coin500 =
              cPick.btn[ChgInOutDisp.CHGINOUT_Y500.value].cPickCount -
                  await rcCPickKindOutttlshtSet(
                      ChgInOutDisp.CHGINOUT_Y500.value);
          shtData.coin100 =
              cPick.btn[ChgInOutDisp.CHGINOUT_Y100.value].cPickCount -
                  await rcCPickKindOutttlshtSet(
                      ChgInOutDisp.CHGINOUT_Y100.value);
          shtData.coin50 =
              cPick.btn[ChgInOutDisp.CHGINOUT_Y50.value].cPickCount -
                  await rcCPickKindOutttlshtSet(
                      ChgInOutDisp.CHGINOUT_Y50.value);
          shtData.coin10 =
              cPick.btn[ChgInOutDisp.CHGINOUT_Y10.value].cPickCount -
                  await rcCPickKindOutttlshtSet(
                      ChgInOutDisp.CHGINOUT_Y10.value);
          shtData.coin5 = cPick.btn[ChgInOutDisp.CHGINOUT_Y5.value].cPickCount -
              await rcCPickKindOutttlshtSet(ChgInOutDisp.CHGINOUT_Y5.value);
          shtData.coin1 = cPick.btn[ChgInOutDisp.CHGINOUT_Y1.value].cPickCount -
              await rcCPickKindOutttlshtSet(ChgInOutDisp.CHGINOUT_Y1.value);

          shortFlg = await rcCPickShtDataStockChk(shtData);
          if (shortFlg == 1) {
            RegsMem().tTtllog.t105100Sts.cpickErrno =
                DlgConfirmMsgKind.MSG_TEXT38.dlgId;
          }

          await rcCPickCountShtSet(shtData);

          startPosition = await rcChkChgPickStartPosition();
          for (
          i = startPosition; i < ChgInOutDisp.CHGINOUT_DIF_MAX.value; i++) {
            if (cPick.btn[i].cPickCount < 0) {
              cPick.btn[i].cPickCount = 0;
            }
            await rcChgPickAcrData(
                cPick.btn[i].cPickCount, RcInOut.CPick_Length, i, 0);
            await rcAfterEntryDraw(i);
          }
          await rcTotalEntryDraw();
        }
        break;
    }
  }

  /// 関連tprxソース: rckycpick.c - rcChgPickAll_Proc
  static Future<void> rcChgPickAllProc() async {
    int i = 0;
    int startPosition = 0;
    CBillKind shtData = CBillKind();

    rcCPickAllCountSet(shtData);
    await rcCPickCountShtSet(shtData);
    startPosition = await rcChkChgPickStartPosition();
    for (i = startPosition; i < ChgInOutDisp.CHGINOUT_DIF_MAX.value; i++) {
      await rcChgPickAcrData(
          cPick.btn[i].cPickCount, RcInOut.CPick_Length, i, 0);
      await rcAfterEntryDraw(i);
    }
    await rcTotalEntryDraw();
  }

  /// 釣機収納庫枚数をセット
  /// 関連tprxソース: rckycpick.c - rcCPick_AllCount_Set
  static void rcCPickAllCountSet(CBillKind shtData) {
    AcMem cMem = SystemFunc.readAcMem();
    shtData.bill10000 = cMem.coinData.holder.bill10000;
    shtData.bill5000 = cMem.coinData.holder.bill5000;
    shtData.bill2000 = cMem.coinData.holder.bill2000;
    shtData.bill1000 = cMem.coinData.holder.bill1000;
    shtData.coin500 = cMem.coinData.holder.coin500;
    shtData.coin100 = cMem.coinData.holder.coin100;
    shtData.coin50 = cMem.coinData.holder.coin50;
    shtData.coin10 = cMem.coinData.holder.coin10;
    shtData.coin5 = cMem.coinData.holder.coin5;
    shtData.coin1 = cMem.coinData.holder.coin1;
  }

  /// 計算結果(sht_data)を回収枚数へセット
  /// 関連tprxソース: rckycpick.c - rcCPick_Count_ShtSet
  static Future<void> rcCPickCountShtSet(CBillKind shtData) async {
    String log = '';
    int kind = 0;
    String callFunc = 'rcCPickCountShtSet';

    log = "$callFunc : kindout_info.typ[${kindOutInfo.typ}]\n";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    if (kindOutInfo.typ == 0) { //金種別出金でない
      cPick.btn[ChgInOutDisp.CHGINOUT_Y10000.value].cPickCount =
          shtData.bill10000;
      cPick.btn[ChgInOutDisp.CHGINOUT_Y5000.value].cPickCount =
          shtData.bill5000;
      cPick.btn[ChgInOutDisp.CHGINOUT_Y2000.value].cPickCount =
          shtData.bill2000;
      cPick.btn[ChgInOutDisp.CHGINOUT_Y1000.value].cPickCount =
          shtData.bill1000;
      cPick.btn[ChgInOutDisp.CHGINOUT_Y500.value].cPickCount = shtData.coin500;
      cPick.btn[ChgInOutDisp.CHGINOUT_Y100.value].cPickCount = shtData.coin100;
      cPick.btn[ChgInOutDisp.CHGINOUT_Y50.value].cPickCount = shtData.coin50;
      cPick.btn[ChgInOutDisp.CHGINOUT_Y10.value].cPickCount = shtData.coin10;
      cPick.btn[ChgInOutDisp.CHGINOUT_Y5.value].cPickCount = shtData.coin5;
      cPick.btn[ChgInOutDisp.CHGINOUT_Y1.value].cPickCount = shtData.coin1;
    } else {
      kind = kindOutInfo.nowKind;
      ChgInOutDisp value = ChgInOutDisp.getDefine(kind);
      switch (value) { //続き位置からセット
        case ChgInOutDisp.CHGINOUT_Y10000:
          cPick.btn[ChgInOutDisp.CHGINOUT_Y10000.value].cPickCount =
              shtData.bill10000;
          cPick.btn[ChgInOutDisp.CHGINOUT_Y5000.value].cPickCount =
              shtData.bill5000;
          cPick.btn[ChgInOutDisp.CHGINOUT_Y2000.value].cPickCount =
              shtData.bill2000;
          cPick.btn[ChgInOutDisp.CHGINOUT_Y1000.value].cPickCount =
              shtData.bill1000;
        case ChgInOutDisp.CHGINOUT_Y500:
          if (!await rcCPickUnitShtChk() || (await rcCPickUnitShtChk() &&
              kindOutInfo.ttlSht[ChgInOutDisp.CHGINOUT_Y500.value] ==
                  0)) { //未出金
            cPick.btn[ChgInOutDisp.CHGINOUT_Y500.value].cPickCount =
                shtData.coin500;
            kindOutInfo.resvSht[ChgInOutDisp.CHGINOUT_Y500.value] =
                shtData.coin500;
          }
          if (await rcCPickUnitShtChk() &&
              kind == ChgInOutDisp.CHGINOUT_Y500.value &&
              kindOutInfo.ttlSht[kind] != 0) { //出金中
            kindOutInfo.resvSht[kind] = shtData.coin500;
            cPick.btn[kind].cPickCount =
                kindOutInfo.ttlSht[kind] + kindOutInfo.resvSht[kind];
          }
        case ChgInOutDisp.CHGINOUT_Y100:
          if (!await rcCPickUnitShtChk() || (await rcCPickUnitShtChk() &&
              (kindOutInfo.ttlSht[ChgInOutDisp.CHGINOUT_Y100.value] ==
                  0))) { //未出金
            cPick.btn[ChgInOutDisp.CHGINOUT_Y100.value].cPickCount =
                shtData.coin100;
            kindOutInfo.resvSht[ChgInOutDisp.CHGINOUT_Y100.value] =
                shtData.coin100;
          }
          if ((await rcCPickUnitShtChk()) &&
              (kind == ChgInOutDisp.CHGINOUT_Y100.value) &&
              kindOutInfo.ttlSht[kind] != 0) { //出金中
            kindOutInfo.resvSht[kind] = shtData.coin100;
            cPick.btn[kind].cPickCount =
                kindOutInfo.ttlSht[kind] + kindOutInfo.resvSht[kind];
          }
        case ChgInOutDisp.CHGINOUT_Y50:
          if (!await rcCPickUnitShtChk() || (await rcCPickUnitShtChk() &&
              kindOutInfo.ttlSht[ChgInOutDisp.CHGINOUT_Y50.value] == 0)) { //未出金
            cPick.btn[ChgInOutDisp.CHGINOUT_Y50.value].cPickCount =
                shtData.coin50;
            kindOutInfo.resvSht[ChgInOutDisp.CHGINOUT_Y50.value] =
                shtData.coin50;
          }
          if (await rcCPickUnitShtChk() &&
              (kind == ChgInOutDisp.CHGINOUT_Y50.value) &&
              kindOutInfo.ttlSht[kind] != 0) { //出金中
            kindOutInfo.resvSht[kind] = shtData.coin50;
            cPick.btn[kind].cPickCount =
                kindOutInfo.ttlSht[kind] + kindOutInfo.resvSht[kind];
          }
        case ChgInOutDisp.CHGINOUT_Y10:
          if (!await rcCPickUnitShtChk() || (await rcCPickUnitShtChk() &&
              kindOutInfo.ttlSht[ChgInOutDisp.CHGINOUT_Y10.value] == 0)) { //未出金
            cPick.btn[ChgInOutDisp.CHGINOUT_Y10.value].cPickCount =
                shtData.coin10;
            kindOutInfo.resvSht[ChgInOutDisp.CHGINOUT_Y10.value] =
                shtData.coin10;
          }
          if (await rcCPickUnitShtChk() &&
              kind == ChgInOutDisp.CHGINOUT_Y10.value &&
              kindOutInfo.ttlSht[kind] != 0) { //出金中
            kindOutInfo.resvSht[kind] = shtData.coin10;
            cPick.btn[kind].cPickCount =
                kindOutInfo.ttlSht[kind] + kindOutInfo.resvSht[kind];
          }
        case ChgInOutDisp.CHGINOUT_Y5:
          if (!await rcCPickUnitShtChk() || (await rcCPickUnitShtChk() &&
              kindOutInfo.ttlSht[ChgInOutDisp.CHGINOUT_Y5.value] == 0)) { //未出金
            cPick.btn[ChgInOutDisp.CHGINOUT_Y5.value].cPickCount =
                shtData.coin5;
            kindOutInfo.resvSht[ChgInOutDisp.CHGINOUT_Y5.value] = shtData.coin5;
          }
          if ((await rcCPickUnitShtChk()) &&
              (kind == ChgInOutDisp.CHGINOUT_Y5.value) &&
              kindOutInfo.ttlSht[kind] != 0) { //出金中
            kindOutInfo.resvSht[kind] = shtData.coin5;
            cPick.btn[kind].cPickCount =
                kindOutInfo.ttlSht[kind] + kindOutInfo.resvSht[kind];
          }
        case ChgInOutDisp.CHGINOUT_Y1:
          if (!await rcCPickUnitShtChk() || (await rcCPickUnitShtChk() &&
              kindOutInfo.ttlSht[ChgInOutDisp.CHGINOUT_Y1.value] == 0)) { //未出金
            cPick.btn[ChgInOutDisp.CHGINOUT_Y1.value].cPickCount =
                shtData.coin1;
            kindOutInfo.resvSht[ChgInOutDisp.CHGINOUT_Y1.value] = shtData.coin1;
          }
          if (await rcCPickUnitShtChk() &&
              kind == ChgInOutDisp.CHGINOUT_Y1.value &&
              kindOutInfo.ttlSht[kind] != 0) { //出金中
            kindOutInfo.resvSht[kind] = shtData.coin1;
            cPick.btn[kind].cPickCount =
                kindOutInfo.ttlSht[kind] + kindOutInfo.resvSht[kind];
          }
          await rcCPickKindOutCountMake(
              KindOutCountMake.KINDOUT_COUNT_CLEAR.index);
          break;
        default :
          break;
      }
    }
  }

  /// 金種別回収時エラー後の継続出金にてエラー前の回収枚数をそのまま使用する
  /// 関連tprxソース: rckycpick.c - rcCPick_KindOut_Count_Make
  static Future<void> rcCPickKindOutCountMake(int flg) async {
    String log = '';
    int i = 0;
    String callFunc = 'rcCPickKindOutCountMake';

    log = "$callFunc : flg[$flg]";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    if (flg == KindOutCountMake.KINDOUT_COUNT_SAVE.index) {
      //回収枚数をセーブ
      for (i = 0; i < ChgInOutDisp.CHGINOUT_DIF_MAX.value; i++) {
        kindOutInfo.orgSht[i] = cPick.btn[i].cPickCount;
      }
    } else if (flg == KindOutCountMake.KINDOUT_COUNT_LOAD.index) {
      //セーブしていた枚数を回収枚数へロード
      for (i = 0; i < ChgInOutDisp.CHGINOUT_DIF_MAX.value; i++) {
        cPick.btn[i].cPickCount = kindOutInfo.orgSht[i];
      }
    } else { //KINDOUT_COUNT_CLEAR
      //セーブしていた枚数をクリア
      for (i = 0; i < ChgInOutDisp.CHGINOUT_DIF_MAX.value; i++) {
        kindOutInfo.orgSht[i] = 0;
      }
    }
  }

  /// 関連tprxソース: rckycpick.c - rcChk_ChgPick_StartPosition
  static Future<int> rcChkChgPickStartPosition() async {
    int startPosition = 0;

    if (await rcChkBillUnitDisp() != 0) {
      startPosition = ChgInOutDisp.CHGINOUT_Y10000.value;
    } else {
      startPosition = ChgInOutDisp.CHGINOUT_Y500.value;
    }
    return startPosition;
  }

  /// 関連tprxソース: rckycpick.c - rcChk_BillUnit_Disp
  static Future<int> rcChkBillUnitDisp() async {
    //紙幣部表示を行うか判定
    if (await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL &&
        cPick.fncCode != FuncKey.KY_OVERFLOW_PICK.keyId) {
      return 1;
    }
    return 0;
  }

  /// 関連tprxソース: rckycpick.c - rcChgPick_AcrData
  static Future<void> rcChgPickAcrData(int cnt, int length, int i,
      int entry) async {
    /* 枚数データ作成 */
    CmEditCtrl fCtrl = CmEditCtrl();
    List<int> pb = List.generate(length * 4 + 1, (_) => 0);
    List<int> pb2 = List.generate(length * 4 + 1, (_) => 0); //, digit;
    TImgDataAdd imgDataAdd = TImgDataAdd();
    TImgDataAddAns ans = TImgDataAddAns();
    int imgPos = 0;
    int dCount = 5;
    int cntdt = 0;

    pb = List.generate(length * 4 + 1, (_) => 0x20);
    pb2 = List.generate(length * 4 + 1, (_) => 0x20);
    pb[length] = 0;

    fCtrl.SignEdit = 1; /* 負の時符号を付ける   */
    fCtrl.SeparatorEdit = 0; /* 桁区切り有り */
    fCtrl.CurrencyEdit = 0; /* 正の時値段マークを付ける */

    imgPos = 0;
    imgDataAdd.width = pb2.length;
    cntdt = cnt;
    imgDataAdd.imgData[imgPos].fCtrl = fCtrl;
    imgDataAdd.imgData[imgPos].posi = 0;
    imgDataAdd.imgData[imgPos].Edit_typ = EditTyps.EDIT_TYP_TOTALPRICE.id;
    imgDataAdd.imgData[imgPos].typ = DataTyps.DATA_TYP_LONG.id;
    imgDataAdd.imgData[imgPos].count = dCount;
    imgDataAdd.imgData[imgPos].data = cntdt;

    imgPos++;
    imgDataAdd.imgData[imgPos].posi = dCount;
    imgDataAdd.imgData[imgPos].typ = DataTyps.DATA_TYP_CHAR.id;
    imgDataAdd.imgData[imgPos].count =
        AplLibStrUtf.aplLibEntCnt(Rcinoutdsp.INOUT_PIECE);
    // TODO:10164 自動閉設 UI系の為保留
    // imgDataAdd.imgData[imgPos].data = Rcinoutdsp.INOUT_PIECE.codeUnits;

    CmStrMolding.cmMultiImgDataAdd(await RcSysChk.getTid(), imgDataAdd, ans);
    pb2 = List.generate(length * 4 + 1, (_) => 0); //, digit;
    // TODO:10164 自動閉設 UI系の為保留
    // AplLib_EucCutCopy( PB2, Ans.line[0], sizeof(PB2)-1 );

    if (entry == 2) {
      if (cnt < 0) {
        // TODO:10164 自動閉設 UI系の為保留
        // FbStyle.chgStyle(cPick.btn[i].afterLabel, &ColorSelect[Red], ColorSelect[MidiumGray], &ColorSelect[MidiumGray],KANJI16);
      } else if (cnt == 0) {
        // TODO:10164 自動閉設 UI系の為保留
        // ChgStyle(CPick.Btn[i].AfterLabel, &ColorSelect[Orange], &ColorSelect[MidiumGray], &ColorSelect[MidiumGray],KANJI16);
      } else {
        // ChgStyle(CPick.Btn[i].AfterLabel, &ColorSelect[White], &ColorSelect[MidiumGray], &ColorSelect[MidiumGray],KANJI16);
      }
    }

    if (entry == 0) {
      // TODO:10164 自動閉設 UI系の為保留
      // gtk_round_entry_set_text(GTK_ROUND_ENTRY(CPick.Btn[i].CPickEntry), PB2);
    } else if (entry == 1) {
      // TODO:10164 自動閉設 UI系の為保留
      // gtk_label_set_text(GTK_LABEL(CPick.Btn[i].NowLabel), PB2);
    } else if (entry == 2) {
      // TODO:10164 自動閉設 UI系の為保留
      // gtk_label_set_text(GTK_LABEL(CPick.Btn[i].AfterLabel), PB2);
    }
  }

  /// 関連tprxソース: rckycpick.c - rcAfterEntry_Draw
  static Future<void> rcAfterEntryDraw(int i) async {
    /* 回収後データ作成 */
    cPick.btn[i].afterCount = cPick.btn[i].acrCount - cPick.btn[i].cPickCount;
    await rcChgPickAcrData(cPick.btn[i].afterCount, RcInOut.CPick_Length, i, 2);
  }

  /// 関連tprxソース: rckycpick.c - rcTotalEntry_Draw
  static Future<void> rcTotalEntryDraw() async {
    /* 回収合計データ作成 */
    List<int> totalPrice = List.generate(13 * 2, (_) => 0);
    CmEditCtrl fCtrl = CmEditCtrl();
    int bytes = 0;
    AcMem cMem = SystemFunc.readAcMem();

    fCtrl.SignEdit = 1;
    fCtrl.SeparatorEdit = 2;
    await rcCalDifferentCPickTtl(0, 0);
    totalPrice[0] = 0x20;
    CmNedit().cmEditTotalPriceUtf(
        fCtrl, totalPrice, totalPrice.length, 12, cMem.scrData.price, bytes);
    totalPrice = List.generate(13 * 2, (_) => 0x00);
    // TODO:10164 自動閉設 UI系の為保留
    // gtk_round_entry_set_text(GTK_ROUND_ENTRY(CPick.TtlPrice),TotalPrice);
    if (pickMode != ChgPickBtn.USERDATABTN_ON.btnType &&
        pickMode != ChgPickBtn.RESERVEBTN_ON.btnType) {
      if (RegsMem().tTtllog.t105100Sts.cpickErrno ==
          DlgConfirmMsgKind.MSG_TEXT38.dlgId ||
          RegsMem().tTtllog.t105100Sts.cpickErrno ==
              DlgConfirmMsgKind.MSG_TEXT39.dlgId) {
        RegsMem().tTtllog.t105100Sts.cpickErrno = 0;
      }
    }
  }

  /// 関連tprxソース: rckycpick.c - rcCal_DifferentCPickTtl
  static Future<void> rcCalDifferentCPickTtl(int typ, int cassetFlg) async {
    int i = 0;
    int startPosition = 0;
    int flg = 0;
    AcMem cMem = SystemFunc.readAcMem();

    cPick.total = 0;

    if (await rcChkBillUnitDisp() != 0) {
      cPick.btn[ChgInOutDisp.CHGINOUT_Y10000.value].amount =
      (cPick.btn[ChgInOutDisp.CHGINOUT_Y10000.value].cPickCount * 10000);
      cPick.btn[ChgInOutDisp.CHGINOUT_Y5000.value].amount =
      (cPick.btn[ChgInOutDisp.CHGINOUT_Y5000.value].cPickCount * 5000);
      cPick.btn[ChgInOutDisp.CHGINOUT_Y2000.value].amount =
      (cPick.btn[ChgInOutDisp.CHGINOUT_Y2000.value].cPickCount * 2000);
      cPick.btn[ChgInOutDisp.CHGINOUT_Y1000.value].amount =
      (cPick.btn[ChgInOutDisp.CHGINOUT_Y1000.value].cPickCount * 1000);
    }

    cPick.btn[ChgInOutDisp.CHGINOUT_Y500.value].amount =
    (cPick.btn[ChgInOutDisp.CHGINOUT_Y500.value].cPickCount * 500);
    cPick.btn[ChgInOutDisp.CHGINOUT_Y100.value].amount =
    (cPick.btn[ChgInOutDisp.CHGINOUT_Y100.value].cPickCount * 100);
    cPick.btn[ChgInOutDisp.CHGINOUT_Y50.value].amount =
    (cPick.btn[ChgInOutDisp.CHGINOUT_Y50.value].cPickCount * 50);
    cPick.btn[ChgInOutDisp.CHGINOUT_Y10.value].amount =
    (cPick.btn[ChgInOutDisp.CHGINOUT_Y10.value].cPickCount * 10);
    cPick.btn[ChgInOutDisp.CHGINOUT_Y5.value].amount =
    (cPick.btn[ChgInOutDisp.CHGINOUT_Y5.value].cPickCount * 5);
    cPick.btn[ChgInOutDisp.CHGINOUT_Y1.value].amount =
    (cPick.btn[ChgInOutDisp.CHGINOUT_Y1.value].cPickCount * 1);

    startPosition = await rcChkChgPickStartPosition();
    for (i = startPosition; i < ChgInOutDisp.CHGINOUT_DIF_MAX.value; i++) {
      cPick.total += cPick.btn[i].amount;
      if (kindOutInfo.typ != 0 && kindOutInfo.stat == 0) {
        /*金種別出金前以外*/
        kindOutInfo.pickSht = 0;
        kindOutInfo.ttlSht[i] = 0;
        kindOutInfo.resvSht[i] = cPick.btn[i].cPickCount;
        kindOutInfo.bkresvsht = kindOutInfo.resvSht[kindOutInfo.firstKind];
      }
    }

    cMem.scrData.price = cPick.total;

    if (cPick.cashRecycle != 0) {
      return;
    }

    if (typ == 0) {
      flg = await rcChkCassettePick();
    } else {
      flg = cassetFlg;
    }

    if (flg != 0 && cPick.cassette != 0) {
      cMem.scrData.price += cPick.cassette;
      // gtk_widget_show(CPick.CasetIncMsg);
    } else {
      // gtk_widget_hide(CPick.CasetIncMsg);
    }
  }

  /// 関連tprxソース: rckycpick.c - rcChk_CassettePick
  static Future<int> rcChkCassettePick() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if (await rcChkBillUnitDisp() == 0) {
      return 0;
    }

    if (rcChkBillClosePick() || pickMode == ChgPickBtn.CASETBTN_ON.btnType) {
      return 1;
    }

    if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) != 0) {
      if (cBuf.iniMacInfo.acx_flg.ecs_pick_positn1000 != 0 ||
          cBuf.iniMacInfo.acx_flg.ecs_pick_positn2000 != 0 ||
          cBuf.iniMacInfo.acx_flg.ecs_pick_positn5000 != 0 ||
          cBuf.iniMacInfo.acx_flg.ecs_pick_positn10000 != 0) {
        if (rcChgPickBillPositionChg()) {
          return 0;
        } else {
          if (cPick.total != 0) {
            return 1;
          }
        }
      }
    } else {
      if (rcChkChgPickBillCnt() != 0) {
        return 1;
      } else {
        return 0;
      }
    }
    return 0;
  }

  /// 関連tprxソース: rckycpick.c - rcChk_BillClosePick
  static bool rcChkBillClosePick() {
    /* １日の閉めとして行われる回収の中で紙幣に関係するもの->出金リジェクト紙幣の回収条件 */
    return (pickMode == ChgPickBtn.ALLBTN_ON.btnType ||
        pickMode == ChgPickBtn.RESERVEBTN_ON.btnType ||
        pickMode == ChgPickBtn.BILLBTN_ON.btnType);
  }

  /// 関連tprxソース: rckycpick.c - rcChgPick_BillPosition_Chg
  static bool rcChgPickBillPositionChg() {
    //全回収・残置回収・カセット回収以外に紙幣回収搬送先を出金口に変更する
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    return (cBuf.dbTrm.acxChgRecoverArea != 0 &&
        (btnPressFlg != ChgPickBtn.ALLBTN_ON.btnType &&
            btnPressFlg != ChgPickBtn.RESERVEBTN_ON.btnType &&
            btnPressFlg != ChgPickBtn.CASETBTN_ON.btnType));
  }

  /// 関連tprxソース: rckycpick.c - rcChk_ChgPick_BillCnt
  static int rcChkChgPickBillCnt() {
    int i = 0;
    int billCnt = 0;

    for (
    i = ChgInOutDisp.CHGINOUT_Y10000.value; i < RcAcrAcbDsp.CHG_1LINE; i++) {
      billCnt += cPick.btn[i].cPickCount; /* 紙幣回収枚数 */
    }
    return billCnt;
  }

  /// 関連tprxソース: rckycpick.c - rcChgPickMan_Proc
  static Future<void> rcChgPickManProc() async {
    int i = 0;
    int startPosition = 0;
    CBillKind shtData = CBillKind();
    AcMem cMem = SystemFunc.readAcMem();

    shtData.bill10000 = cMem.coinData.holder.bill10000;
    await rcCPickCountShtSet(shtData);
    startPosition = await rcChkChgPickStartPosition();
    for (i = startPosition; i < ChgInOutDisp.CHGINOUT_DIF_MAX.value; i++) {
      if (i != ChgInOutDisp.CHGINOUT_Y10000.value) {
        cPick.btn[i].cPickCount = 0;
      }
      await rcChgPickAcrData(
          cPick.btn[i].cPickCount, RcInOut.CPick_Length, i, 0);
      await rcAfterEntryDraw(i);
    }
    await rcTotalEntryDraw();
  }

  /// 関連tprxソース: rckycpick.c - rcChgPickBill_Proc
  static Future<void> rcChgPickBillProc() async {
    int i = 0;
    int startPosition = 0;
    CBillKind shtData = CBillKind();

    rcCPickAllCountSet(shtData);
    await rcCPickCountShtSet(shtData);
    startPosition = await rcChkChgPickStartPosition();
    for (i = startPosition; i < ChgInOutDisp.CHGINOUT_DIF_MAX.value; i++) {
      if (i >= RcAcrAcbDsp.CHG_1LINE && i < RcAcrAcbDsp.CHG_2LINE) {
        cPick.btn[i].cPickCount = 0;
      }
      await rcChgPickAcrData(
          cPick.btn[i].cPickCount, RcInOut.CPick_Length, i, 0);
      await rcAfterEntryDraw(i);
    }
    await rcTotalEntryDraw();
  }

  /// 関連tprxソース: rckycpick.c - rcChgPickCoin_Proc
  static Future<void> rcChgPickCoinProc() async {
    int i = 0;
    int startPosition = 0;
    CBillKind shtData = CBillKind();

    rcCPickAllCountSet(shtData);
    await rcCPickCountShtSet(shtData);
    startPosition = await rcChkChgPickStartPosition();
    for (i = startPosition; i < ChgInOutDisp.CHGINOUT_DIF_MAX.value; i++) {
      if (i < RcAcrAcbDsp.CHG_1LINE) {
        cPick.btn[i].cPickCount = 0;
      }
      await rcChgPickAcrData(
          cPick.btn[i].cPickCount, RcInOut.CPick_Length, i, 0);
      await rcAfterEntryDraw(i);
    }
    await rcTotalEntryDraw();
  }

  /// 関連tprxソース: rckycpick.c - rcChgPickUserdata_Proc
  static Future<void> rcChgPickUserdataProc() async {
    int i = 0;
    int startPosition = 0;
    int shortFlg = 0;
    CBillKind shtData = CBillKind();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    if (await rcChkBillUnitDisp() != 0) {
      shtData.bill10000 = cBuf.iniMacInfo.acx_flg.acx_pick_data10000;
      shtData.bill5000 = cBuf.iniMacInfo.acx_flg.acx_pick_data5000;
      shtData.bill2000 = cBuf.iniMacInfo.acx_flg.acx_pick_data2000;
      shtData.bill1000 = cBuf.iniMacInfo.acx_flg.acx_pick_data1000;
    }
    shtData.coin500 = cBuf.iniMacInfo.acx_flg.acx_pick_data500 -
        await rcCPickKindOutttlshtSet(ChgInOutDisp.CHGINOUT_Y500.value);
    shtData.coin100 = cBuf.iniMacInfo.acx_flg.acx_pick_data100 -
        await rcCPickKindOutttlshtSet(ChgInOutDisp.CHGINOUT_Y100.value);
    shtData.coin50 = cBuf.iniMacInfo.acx_flg.acx_pick_data50 -
        await rcCPickKindOutttlshtSet(ChgInOutDisp.CHGINOUT_Y50.value);
    shtData.coin10 = cBuf.iniMacInfo.acx_flg.acx_pick_data10 -
        await rcCPickKindOutttlshtSet(ChgInOutDisp.CHGINOUT_Y10.value);
    shtData.coin5 = cBuf.iniMacInfo.acx_flg.acx_pick_data5 -
        await rcCPickKindOutttlshtSet(ChgInOutDisp.CHGINOUT_Y5.value);
    shtData.coin1 = cBuf.iniMacInfo.acx_flg.acx_pick_data1 -
        await rcCPickKindOutttlshtSet(ChgInOutDisp.CHGINOUT_Y1.value);

    shortFlg = await rcCPickShtDataStockChk(shtData);
    if (shortFlg == 1) {
      RegsMem().tTtllog.t105100Sts.cpickErrno =
          DlgConfirmMsgKind.MSG_TEXT38.dlgId;
    }
    await rcCPickCountShtSet(shtData);

    startPosition = await rcChkChgPickStartPosition();
    for (i = startPosition; i < ChgInOutDisp.CHGINOUT_DIF_MAX.value; i++) {
      await rcChgPickAcrData(
          cPick.btn[i].cPickCount, RcInOut.CPick_Length, i, 0);
      await rcAfterEntryDraw(i);
    }
    await rcTotalEntryDraw();
  }

  /// 収納庫枚数を越える回収枚数がセットされている場合は、収納庫枚数をセット
  /// 関連tprxソース: rckycpick.c - rcCPick_ShtData_StockChk
  static Future<int> rcCPickShtDataStockChk(CBillKind shtData) async {
    String log = '';
    int shortFlg = 0;
    AcMem cMem = SystemFunc.readAcMem();
    String callFunc = 'rcCPickShtDataStockChk';

    shortFlg = 0;
    if (shtData.bill10000 > cMem.coinData.holder.bill10000) {
      log =
      "$callFunc : Stock Short 10000 Pick Chg[${shtData.bill10000} -> ${cMem
          .coinData.holder.bill10000}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      shtData.bill10000 = cMem.coinData.holder.bill10000;
      shortFlg = 1;
    }
    if (shtData.bill5000 > cMem.coinData.holder.bill5000) {
      log =
      "$callFunc : Stock Short  5000 Pick Chg[${shtData.bill5000} -> ${cMem
          .coinData.holder.bill5000}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      shtData.bill5000 = cMem.coinData.holder.bill5000;
      shortFlg = 1;
    }
    if (shtData.bill2000 > cMem.coinData.holder.bill2000) {
      log =
      "$callFunc : Stock Short  2000 Pick Chg[${shtData.bill2000} -> ${cMem
          .coinData.holder.bill2000}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      shtData.bill2000 = cMem.coinData.holder.bill2000;
      shortFlg = 1;
    }
    if (shtData.bill1000 > cMem.coinData.holder.bill1000) {
      log =
      "$callFunc : Stock Short  1000 Pick Chg[${shtData.bill1000} -> ${cMem
          .coinData.holder.bill1000}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      shtData.bill1000 = cMem.coinData.holder.bill1000;
      shortFlg = 1;
    }
    if (shtData.coin500 > cMem.coinData.holder.coin500) {
      log = "$callFunc : Stock Short   500 Pick Chg[${shtData.coin500} -> ${cMem
          .coinData.holder.coin500}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      shtData.coin500 = cMem.coinData.holder.coin500;
      shortFlg = 1;
    }
    if (shtData.coin100 > cMem.coinData.holder.coin100) {
      log = "$callFunc : Stock Short   100 Pick Chg[${shtData.coin100} -> ${cMem
          .coinData.holder.coin100}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      shtData.coin100 = cMem.coinData.holder.coin100;
      shortFlg = 1;
    }
    if (shtData.coin50 > cMem.coinData.holder.coin50) {
      log = "$callFunc : Stock Short    50 Pick Chg[${shtData.coin50} -> ${cMem
          .coinData.holder.coin50}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      shtData.coin50 = cMem.coinData.holder.coin50;
      shortFlg = 1;
    }
    if (shtData.coin10 > cMem.coinData.holder.coin10) {
      log = "$callFunc : Stock Short    10 Pick Chg[${shtData.coin10} -> ${cMem
          .coinData.holder.coin10}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      shtData.coin10 = cMem.coinData.holder.coin10;
      shortFlg = 1;
    }
    if (shtData.coin5 > cMem.coinData.holder.coin5) {
      log = "$callFunc : Stock Short     5 Pick Chg[${shtData.coin5} -> ${cMem
          .coinData.holder.coin5}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      shtData.coin5 = cMem.coinData.holder.coin5;
      shortFlg = 1;
    }
    if (shtData.coin1 > cMem.coinData.holder.coin1) {
      log = "$callFunc : Stock Short     1 Pick Chg[${shtData.coin1} -> ${cMem
          .coinData.holder.coin1}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      shtData.coin1 = cMem.coinData.holder.coin1;
      shortFlg = 1;
    }

    return shortFlg;
  }

  /// 指定金種の金種別回収出金済み枚数(ttlsht)を返す
  /// 関連tprxソース: rckycpick.c - rcCPick_KindOut_ttlsht_set
  static Future<int> rcCPickKindOutttlshtSet(int kind) async {
    String log = '';
    String callFunc = 'rcCPickKindOutttlshtSet';

    if (kindOutInfo.typ == 0) { //金種別出金でない
      return 0;
    }

    if (await rcCPickUnitShtChk() && kindOutInfo.nowKind == kind &&
        kindOutInfo.ttlSht[kind] != 0) { //出金中
      log =
      "$callFunc($kind) : kindOutInfo.ttlsht[${kindOutInfo.ttlSht[kind]}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      return (kindOutInfo.ttlSht[kind]);
    }

    return 0;
  }

  /// 関連tprxソース: rckycpick.c - rcChgPickFull_Proc
  static Future<void> rcChgPickFullProc() async {
    int i = 0;
    int startPosition = 0;
    int acbSelect = 0;
    CBillKind shtData = CBillKind();
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    acbSelect = AcxCom.ifAcbSelect();
    await rcChgPickCPickCountClr();

    if (await rcChkBillUnitDisp() != 0) {
      if (await rcChgPickFullChk(ChgInOutDisp.CHGINOUT_Y10000.value) != 0) {
        shtData.bill10000 = cMem.coinData.holder.bill10000;
      }
      if ((acbSelect & CoinChanger.ECS_X) != 0) {
        if (await rcChgPickFullChk(ChgInOutDisp.CHGINOUT_Y5000.value) != 0) {
          shtData.bill5000 =
              cMem.coinData.holder.bill5000 - cBuf.dbTrm.acxS5000;
        }
        if (await rcChgPickFullChk(ChgInOutDisp.CHGINOUT_Y2000.value) != 0) {
          shtData.bill2000 =
              cMem.coinData.holder.bill2000 - cBuf.dbTrm.acxS2000;
        }
      } else {
        if ((acbSelect & CoinChanger.ACB_50_X) != 0 &&
            cBuf.dbTrm.bothAcrClrFlg == 1) {
          shtData.bill5000 = cMem.coinData.holder.bill5000;
          if (await rcChgPickFullChk(ChgInOutDisp.CHGINOUT_Y2000.value) != 0) {
            shtData.bill2000 =
                cMem.coinData.holder.bill2000 - cBuf.dbTrm.acxS2000;
          }
        } else {
          if (await rcChgPickFullChk(ChgInOutDisp.CHGINOUT_Y5000.value) != 0) {
            shtData.bill5000 =
                cMem.coinData.holder.bill5000 - cBuf.dbTrm.acxS5000;
          }
          shtData.bill2000 = cMem.coinData.holder.bill2000;
        }
      }
      if (await rcChgPickFullChk(ChgInOutDisp.CHGINOUT_Y1000.value) != 0) {
        shtData.bill1000 = cMem.coinData.holder.bill1000 - cBuf.dbTrm.acxS1000;
      }
    }

    if (await rcChgPickFullChk(ChgInOutDisp.CHGINOUT_Y500.value) != 0) {
      shtData.coin500 = cMem.coinData.holder.coin500 - cBuf.dbTrm.acxS500;
    }

    if (await rcChgPickFullChk(ChgInOutDisp.CHGINOUT_Y100.value) != 0) {
      shtData.coin100 = cMem.coinData.holder.coin100 - cBuf.dbTrm.acxS100;
    }

    if (await rcChgPickFullChk(ChgInOutDisp.CHGINOUT_Y50.value) != 0) {
      shtData.coin50 = cMem.coinData.holder.coin50 - cBuf.dbTrm.acxS50;
    }

    // if (await rcChgPickFullChk(ChgInOutDisp.CHGINOUT_Y10.value) != 0) {
    if (await rcChgPickFullChk(ChgInOutDisp.CHGINOUT_Y10.value) == 0) {
      shtData.coin10 = cMem.coinData.holder.coin10 - cBuf.dbTrm.acxS10;
    }

    if (await rcChgPickFullChk(ChgInOutDisp.CHGINOUT_Y5.value) != 0) {
      shtData.coin5 = cMem.coinData.holder.coin5 - cBuf.dbTrm.acxS5;
    }

    if (await rcChgPickFullChk(ChgInOutDisp.CHGINOUT_Y1.value) != 0) {
      shtData.coin1 = cMem.coinData.holder.coin1 - cBuf.dbTrm.acxS1;
    }

    await rcCPickCountShtSet(shtData);

    startPosition = await rcChkChgPickStartPosition();
    for (i = startPosition; i < ChgInOutDisp.CHGINOUT_DIF_MAX.value; i++) {
      if (cPick.btn[i].cPickCount < 0) {
        cPick.btn[i].cPickCount = 0;
      }
      await rcChgPickAcrData(
          cPick.btn[i].cPickCount, RcInOut.CPick_Length, i, 0);
      await rcAfterEntryDraw(i);
    }
    await rcTotalEntryDraw();
  }

  /// 関連tprxソース: rckycpick.c - rcChgPick_CPickCount_Clr
  static Future<void> rcChgPickCPickCountClr() async {
    int i = 0;
    int startPosition = 0;

    startPosition = await rcChkChgPickStartPosition();
    for (i = startPosition; i < ChgInOutDisp.CHGINOUT_DIF_MAX.value; i++) {
      cPick.btn[i].cPickCount = 0;
    }
  }

  /// 関連tprxソース: rckycpick.c - rcChgPick_FullChk
  static Future<int> rcChgPickFullChk(int kind) async {
    String log = '';
    int num = 0;
    int trmAcxMax = 0;
    int fullFlg = 0;
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRetC.object;
    RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetS.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRetS.object;
    String callFunc = 'rcChgPickFullChk';

    ChgInOutDisp value = ChgInOutDisp.getDefine(kind);
    switch (value) {
      case ChgInOutDisp.CHGINOUT_Y10000 :
        num = CoinBillKindList.CB_KIND_10000.id;
        trmAcxMax = cBuf.dbTrm.acxM10000;
        break;
      case ChgInOutDisp.CHGINOUT_Y5000 :
        num = CoinBillKindList.CB_KIND_05000.id;
        trmAcxMax = cBuf.dbTrm.acxM5000;
        break;
      case ChgInOutDisp.CHGINOUT_Y2000 :
        num = CoinBillKindList.CB_KIND_02000.id;
        trmAcxMax = cBuf.dbTrm.acxM2000;
        break;
      case ChgInOutDisp.CHGINOUT_Y1000 :
        num = CoinBillKindList.CB_KIND_01000.id;
        trmAcxMax = cBuf.dbTrm.acxM1000;
        break;
      case ChgInOutDisp.CHGINOUT_Y500 :
        num = CoinBillKindList.CB_KIND_00500.id;
        trmAcxMax = cBuf.dbTrm.acxM500;
        break;
      case ChgInOutDisp.CHGINOUT_Y100 :
        num = CoinBillKindList.CB_KIND_00100.id;
        trmAcxMax = cBuf.dbTrm.acxM100;
        break;
      case ChgInOutDisp.CHGINOUT_Y50 :
        num = CoinBillKindList.CB_KIND_00050.id;
        trmAcxMax = cBuf.dbTrm.acxM50;
        break;
      case ChgInOutDisp.CHGINOUT_Y10 :
        num = CoinBillKindList.CB_KIND_00010.id;
        trmAcxMax = cBuf.dbTrm.acxM10;
        break;
      case ChgInOutDisp.CHGINOUT_Y5 :
        num = CoinBillKindList.CB_KIND_00005.id;
        trmAcxMax = cBuf.dbTrm.acxM5;
        break;
      case ChgInOutDisp.CHGINOUT_Y1 :
        num = CoinBillKindList.CB_KIND_00001.id;
        trmAcxMax = cBuf.dbTrm.acxM1;
        break;
      default:
        break;
    }

    //戻し入れ前の回収枚数があった場合（金種別回収では回収終了前(分割出金途中)にニアフル状態が解除されてしまう可能性があるため）
    if (kindOutInfo.orgSht[kind] > 0) {
      log = "$callFunc : kind[$kind] kindout_info.orgsht[${kindOutInfo
          .orgSht[kind]}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      return 1;
    }

    //ニアフルに達しているか
    fullFlg = tsBuf.acx.holderStatus.kindFlg[num].index;
    if (fullFlg == HolderFlagList.HOLDER_NEAR_FULL.index ||
        fullFlg == HolderFlagList.HOLDER_NEAR_FULL_BFR_ALERT.index ||
        fullFlg == HolderFlagList.HOLDER_FULL.index) {
      log = "$callFunc : kind[$kind] fullFlg[$fullFlg]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      return 1;
    }

    //カスミでは、フルエラーを1枚前(設定値)、フル回収20枚前(固定値)というように動作させる。
    if (RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) {
      if (cPick.btn[kind].acrCount >= trmAcxMax - 20 &&
          (cPick.btn[kind].acrCount > 0)) {
        log = "$callFunc : kind[$kind] cnt[${cPick.btn[kind]
            .acrCount}] >= (max[${trmAcxMax}] - 20)\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        return 1;
      }
    }

    return 0;
  }

  /// 関連tprxソース: rckycpick.c - rcChgPickCaset_Proc
  static Future<void> rcChgPickCasetProc() async {
    int i = 0;
    int startPosition = 0;

    startPosition = await rcChkChgPickStartPosition();
    for (i = startPosition; i < ChgInOutDisp.CHGINOUT_DIF_MAX.value; i++) {
      if (btnPressFlg == ChgPickBtn.RESERVEBTN_ON
          .btnType) { //残置回収選択によるカセット回収はカセット回収だけを行うので回収枚数クリア
        cPick.btn[i].cPickCount = 0;
      }
      await rcChgPickAcrData(
          cPick.btn[i].cPickCount, RcInOut.CPick_Length, i, 0);
      await rcAfterEntryDraw(i);
    }
    await rcTotalEntryDraw();
  }

  /// 関連tprxソース: rckycpick.c - rcChgPickReserve_Proc
  static Future<void> rcChgPickReserveProc() async {
    int i = 0;
    int startPosition = 0;
    int errNo = 0;
    int exchgRsltPrc = 0;
    String log = '';
    CBillKind shtData = CBillKind();
    String callFunc = 'rcChgPickReserveProc';

    errNo = await AplLibOther.aplLibChgPickReserveCalc(
        await RcSysChk.getTid(), shtData, exchgRsltPrc, 0);

    if (errNo != Typ.OK) {
      complete = false;
      await rcChgPickCPickCountClr();
      // TODO:10164 自動閉設 UI系の為保留
      // rcChgPick_BtnOff();
      DlgConfirmMsgKind id = DlgConfirmMsgKind.getDefine(errNo);

      switch (id) {
        case DlgConfirmMsgKind.MSG_MONEY_SUPPLEMENT :
        case DlgConfirmMsgKind.MSG_CPICK_CALC_NG : //代替計算しましたが、残置金額に\nなりませんでした。
        case DlgConfirmMsgKind
            .MSG_CPICK_LIMIT_NG : //代替計算しましたが、必要最低枚数\nを確保できませんでした。
        case DlgConfirmMsgKind
            .MSG_CPICK_DRW_OVER : //棒金ドロア内在高が過剰です。先に\n「%s」キーを使用し、\n棒金を抜き出して下さい。
          log = "rcChgPickReserve_Proc exchg_rslt_prc($exchgRsltPrc})\n";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          // TODO:10164 自動閉設 必要あれば実装（ダイアログ系）
          // rcCPick_LackSht_PrintDlg(errNo);
          break;
        default :
          await RcExt.rcErr(callFunc, errNo);
          break;
      }
      return;
    }

    await rcCPickCountShtSet(shtData);

    startPosition = await rcChkChgPickStartPosition();
    for (i = startPosition; i < ChgInOutDisp.CHGINOUT_DIF_MAX.value; i++) {
      if (cPick.btn[i].cPickCount < 0) {
        cPick.btn[i].cPickCount = 0;
        RegsMem().tTtllog.t105100Sts.cpickErrno =
            DlgConfirmMsgKind.MSG_TEXT39.dlgId;
      }
      await rcChgPickAcrData(
          cPick.btn[i].cPickCount, RcInOut.CPick_Length, i, 0);
      await rcAfterEntryDraw(i);
    }
    await rcTotalEntryDraw();
  }

  /// ダイアログ表示関数
  static int rcCPickDlg(int erCode, int dialogPtn, Function? func1,
      String? msg1,
      Function? func2, String? msg2, Function? func3, String? msg3) {
    if ((func1 != null && func2 == null && func3 == null) && (msg1 != null && msg2 == null && msg3 == null)) {
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          dialogId: dialogPtn,
          type: MsgDialogType.info,
          btnTxt: msg1,
          btnFnc: () {
            func1.call();
            Get.back();
          },
        ),
      );
    } else
    if ((func1 != null && func2 != null && func3 == null) && (msg1 != null && msg2 != null && msg3 == null)) {
      MsgDialog.show(
        MsgDialog.twoButtonDlgId(
          dialogId: dialogPtn,
          type: MsgDialogType.info,
          leftBtnTxt: msg1,
          leftBtnFnc: () {
            func1.call();
            Get.back();
          },
          rightBtnTxt: msg2,
          rightBtnFnc: () {
            func2.call();
            Get.back();
          },
        ),
      );
    }else if((func1 != null && func2 != null && func3 != null) && (msg1 != null && msg2 != null && msg3 != null)){
      MsgDialog.show(
        MsgDialog.threeButtonDlgId(
          dialogId: dialogPtn,
          type: MsgDialogType.info,
          leftBtnTxt: msg1,
          leftBtnFnc: () {
            func1.call();
            Get.back();
          },
          middleBtnTxt: msg2,
          middleBtnFnc: () {
            func2.call();
            Get.back();
          },
          rightBtnTxt: msg3,
          rightBtnFnc: () {
            func3.call();
            Get.back();
          },
        ),
      );
    }
    return 0;
  }

  /// 関連tprxソース: rckycpick.c - rcChk_ChgPick_PriceSet
  static Future<bool> rcChkChgPickPriceSet() async {
    AcMem cMem = SystemFunc.readAcMem();

    if (AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) != 0) {
      return false;
    }

    if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) != 0) {
      return cMem.scrData.price != 0 && cMem.scrData.price != cPick.cassette;
    } else {
      return cMem.scrData.price != 0;
    }
  }

  /// 関連tprxソース: rckycpick.c - rcChgPickReserve_Func_Main
  static Future<void> rcChgPickReserveFuncMain() async {
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();
    String callFunc = 'rcChgPickReserveFuncMain';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    if (await RcSysChk.rcSGChkSelfGateSystem() ||
        await RcSysChk.rcQCChkQcashierSystem()) {
      log = LRcKyCPick.RESERVEPICK_LABEL;
      RcSgCom.mngPcLog = RcSgCom.mngPcLog + log;
      RcSgCom.rcSGManageLogButton();
      RcSgCom.rcSGManageLogSend(SgDsp.REG_LOG);
      RcAssistMnt.rcAssistSend(23065);
    }

    RcSet.rcClearEntry();

    //精査できない機種は全回収→再入金の流れなのでここでわざわざ警告しない
    if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) != 0 &&
        AcxCom.ifAcxStockStateChk(cMem.coinData.stockState) != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcChgPickReserve_Func RESERVEBTN_ON");
      // TODO:10164 自動閉設 UI系の為保留
      // rcChgPick_BtnOn(RESERVEBTN_ON);
      cMem.ent.errNo = DlgConfirmMsgKind.MSG_ACB_RECALC.dlgId;
      await RcSet.rcErrStatSet2(callFunc);
      await confDialog(cMem.ent.errNo);
      return;
    }

    if (btnPressFlg == ChgPickBtn.RESERVEBTN_ON.btnType) {
      if (cBuf.dbTrm.acxRecoverSameButton != 0) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "rcChgPickReserve_Func RESERVEBTN_ON");
        return;
      } else {
        // TODO:10164 自動閉設 UI系の為保留
        // rcChgPick_BtnOff();
        return;
      }
    } else {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcChgPickReserve_Func RESERVEBTN_ON");
      // TODO:10164 自動閉設 UI系の為保留
      // rcChgPick_BtnOn(RESERVEBTN_ON);
      if (await rcChkChgPickPriceSet()) {
        cMem.ent.errNo = DlgConfirmMsgKind.MSG_CASTDAT.dlgId;
        await RcSet.rcErrStatSet2(callFunc);
        await confDialog(cMem.ent.errNo);
        return;
      } else {
        // await rcChgPickBtnProc();
      }
    }
  }

  /// 関連tprxソース: rckycpick.c - rcQuit_Main
  static Future<void> rcQuitMain() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcQuitMain in Ky_ChgPick");

    RcSet.rcClearEntry();
    await rcEndKyChgInOut();

    Rc28dsp.rc28MainWindowSizeChange(0);

    if (await RcSysChk.rcSGChkSelfGateSystem()) {
      RcAssistMnt.rcAssistSend(39001);
      // gtk_widget_destroy(CPick.window);
      await RcObr.rcScanEnable();
      RcSet.rcSGMntScrMode();
      cPick.nowDisplay = 0;
      return;
    }
    if (await RcSysChk.rcQCChkQcashierSystem()) {
      RcAssistMnt.rcAssistSend(39001);

      // TODO:10164 自動閉設 UI系の為保留
      // if(cPick.window != NULL) {
      // gtk_widget_destroy(cPick.window);
      // cPick.window = NULL;
      // }

      await RcSet.rcQCMenteDspScrMode();
      cPick.nowDisplay = 0;
      return;
    }

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
        await RcSet.rcItmLcdScrMode();
        // gtk_widget_destroy(cPick.window);
        await RcItmDsp.rcDspEntLCD();
        await RcItmDsp.rcQtyClr();
        await RcSet.rcClearKyItem();
        RcMbrCom.rcmbrClearModeDisp();
        break;
      case RcRegs.KY_DUALCSHR:
        if (await RcSysChk.rcChkDesktopCashier()) {
          await RcSet.rcItmLcdScrMode();
          // gtk_widget_destroy(cPick.window);
          await RcItmDsp.rcDspEntLCD();
          await RcItmDsp.rcQtyClr();
          await RcSet.rcClearKyItem();
          RcMbrCom.rcmbrClearModeDisp();
        } else {
          await RcStlLcd.rcStlLcdQuit(RegsDef.subttl);
          await RcStlLcd.rcStlLcdScrModeDualCashier();
          // gtk_widget_destroy(cPick.window);
          if (RegsMem().tTtllog.t100001Sts.itemlogCnt == 0) {
            RcStlCal.rcStlInitilaizeBuf();
          }
          RcStlLcd.rcStlLcdDualCashier();
          await RcSet.rcClearKyItem();
        }
        break;
      case RcRegs.KY_SINGLE:
        if (cPick.nowDisplay == RcInOut.LDISP) {
          await RcSet.rcItmLcdScrMode();
        }
        await rcKySingleQuit();
        if (FbInit.subinitMainSingleSpecialChk() == true) {
          RcItmDsp.dualTSingleDlgClear();
        }
        RcItmDsp.dualTSingleCshrTendChgClr();
        await RcSet.rcClearKyItem();
        break;
      default:
        break;
    }
    cPick.nowDisplay = 0;
    return;
  }

  /// 関連tprxソース: rckycpick.c - rcKySingle_Quit
  static Future<void> rcKySingleQuit() async {
    if (cPick.nowDisplay == RcInOut.LDISP) {
      // gtk_widget_destroy(CPick.window);                                        /* LCD Display Change */
      Rc28dsp.rc28MainWindowSizeChange(0);
      await RcItmDsp.rcDspEntLCD();
      await RcItmDsp.rcQtyClr();
    }
  }

  /// 関連tprxソース: rckycpick.c - rcExecFunc_Main
  static Future<void> rcExecFuncMain() async {
    tprDlgParam_t param = tprDlgParam_t();
    int billMode = 0;
    int coinMode = 0;
    int pickWaitFlg = 0;
    int pickCaset = 0;
    int errNo = 0;
    int i = 0;
    int startPosition = 0;
    int resvPrc = 0;
    CBillKind cPickSht = CBillKind();
    String log = '';
    List<int> sht = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    List<int> shtAfter = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    String callFunc = 'rcExecFuncMain';
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcExecFunc_Main Start");
    TprDlg.tprLibDlgClear(callFunc);

    if (await rcChkAutoOverFlowPick() != 0) {
      //自動精算でオーバーフロー庫へ回収する設定
      errNo = await RcFncChk.rcCheckAcxOverFlowBoxExist2(callFunc); //収納BOXの検知

      if (errNo == 0) {
        //あふれ判定
        overFlow.moveCnt.coin500 =
            cPick.btn[ChgInOutDisp.CHGINOUT_Y500.value].cPickCount;
        overFlow.moveCnt.coin100 =
            cPick.btn[ChgInOutDisp.CHGINOUT_Y100.value].cPickCount;
        overFlow.moveCnt.coin50 =
            cPick.btn[ChgInOutDisp.CHGINOUT_Y50.value].cPickCount;
        overFlow.moveCnt.coin10 =
            cPick.btn[ChgInOutDisp.CHGINOUT_Y10.value].cPickCount;
        overFlow.moveCnt.coin5 =
            cPick.btn[ChgInOutDisp.CHGINOUT_Y5.value].cPickCount;
        overFlow.moveCnt.coin1 =
            cPick.btn[ChgInOutDisp.CHGINOUT_Y1.value].cPickCount;
        errNo = await RcAcracb.rcAcrAcbAutoOverFlowMoveMaxOverChk(0);
      }

      if (errNo == 0) {
        /* 釣銭機動作条件設定 */
        errNo = await rcKyChgOverFlowPickStartProc(1);
      }

      if (errNo != 0) {
        if (AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) != 0) {
          RcAuto.rcAutoChkDlg(
              await RcSysChk.getTid(), FuncKey.KY_CHGPICK.keyId, errNo);
        }

        if (TprLibDlg.tprLibDlgCheck2(1) == 0) {
          if (RcFncChk.rcChkErr() != 0) {
            RckyClr.rcClearPopDisplay();
          } else {
            _closeDialogAll();
          }
        }

        param.erCode = errNo;
        param.dialogPtn = DlgPattern.TPRDLG_PT31.dlgPtnId;
        param.msg1 = LTprDlg.BTN_CONTINUE;
        param.msg2 = LTprDlg.BTN_INTERRUPT;
        param.func1 = yesExecFunc;
        param.func2 = noExecFunc;
        param.user_code_4 = LRcKyCPick.CPICK_RCPT_STOP;

        if (cMem.stat.dualTSingle == 1) {
          param.dual_dsp = 2;
        }
        await RcSet.rcErrStatSet2(callFunc);

        rcCPickDlg(param.erCode, param.dialogPtn, param.func1, param.msg1,
            param.func2, param.msg2, param.func3, param.msg3);
        AplLibAuto.aplLibCMAutoErrMsgSend(await RcSysChk.getTid(), errNo);

        if (await RcSysChk.rcSGChkSelfGateSystem() ||
            await RcSysChk.rcQCChkQcashierSystem()) {
          asstPcLog = asstPcLog + tsBuf.managePc.msgLogBuf;
          RcAssistMnt.rcAssistSend(errNo);
        }
        complete = false;
        return;
      } else {
        overflowPickFlg = 2;
      }
    }

    if (AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) != 0 ||
        kindOutInfo.typ != 0) {
      RegsMem().tTtllog.t105100Sts.cpickErrno =
          0; //自動精算時、回収異常終了は戻し入れ→再回収となるのでエラー情報を引き継がないように
    }

    cMem.ent.errNo = await RcAcracb.rcAcrAcbAnswerReadDtl();

    if (cMem.ent.errNo != 0) {
      RcKyccin.ccinErrDialog2(callFunc, cMem.ent.errNo, 0);
      complete = false;
      return;
    }

    RcSet.rcClearEntry();
    if (!await RcSysChk.rcSGChkSelfGateSystem() &&
        !await RcSysChk.rcQCChkQcashierSystem()) {
      await RcItmDsp.rcDspEntLCD();
      await RcItmDsp.rcLcdPrice();
      await RcItmDsp.rcQtyClr();
    }

    if (kindOutInfo.stat == 0) {
      /*金種別出金中以外*/
      await rcRefreshProc(1);
    }

    if (AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) != 0 &&
        (RcFncChk.rcChkErr() != 0 ||
            cMem.ent.errNo != 0 ||
            TprLibDlg.tprLibDlgCheck2(1) != 0)) {
      complete = false;
      return;
    }

    if (kindOutInfo.stat == 0) {
      /*金種別出金中以外*/
      await rcCalDifferentCPickTtl(0, 0);

      startPosition = await rcChkChgPickStartPosition();
      for (i = startPosition; i < ChgInOutDisp.CHGINOUT_DIF_MAX.value; i++) {
        if (cPick.btn[i].cPickCount > cPick.btn[i].acrCount) {
          complete = false;
          await RcExt.rcErr(callFunc, DlgConfirmMsgKind.MSG_INPUTERR.dlgId);
          return;
        }
      }

      ChgPickBtn type = ChgPickBtn.getDefine(pickMode);
      switch (type) {
        case ChgPickBtn.ALLBTN_ON:
        case ChgPickBtn.BILLBTN_ON:
        case ChgPickBtn.COINBTN_ON:
          //全回収系は在高不確定クリアのために合計額０でも実行
          break;
        case ChgPickBtn.RESERVEBTN_ON:
        case ChgPickBtn.MANBTN_ON:
        case ChgPickBtn.USERDATABTN_ON:
        case ChgPickBtn.CASETBTN_ON:
        default:
          if (cMem.scrData.price == 0) {
            if (cPick.fncCode == FuncKey.KY_CHGPICK.keyId &&
                AplLibAuto.strCls(await RcSysChk.getTid()) != 0 &&
                await rcChkAutoPickManual() == 0) {
              //自動精算で手動選択以外は０円でも実行可能。手動選択は、回収方法選択忘れをするので警告。
              TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                  "rcExecFunc_Main price = 0. But OK!!!");
            } else {
              cMem.ent.errNo = DlgConfirmMsgKind.MSG_TRC_TTL_ZERO.dlgId;
              complete = false;
              await RcExt.rcErr(callFunc, cMem.ent.errNo);
              return;
            }
          }
          break;
      }

      if (rcChgPickBillPositionChg() && kindOutInfo.typ == 0 ||
          (kindOutInfo.typ != 0 &&
              (kindOutInfo.nowKind < ChgInOutDisp.CHGINOUT_Y500.value))) {
        errNo = await RcAcracb.rcEcsOpeSetGp2Dtl(1);
        opeSet = 1;
      }
    }

    await rcCPickKindOutChk();
    if (kindOutInfo.typ != 0 && TprLibDlg.tprLibDlgCheck2(1) != 0) {
      //ダイアログ表示中
      return;
    }

    (billMode, coinMode, pickWaitFlg, pickCaset) =
        await rcChgPickPickModeSet(billMode, coinMode, pickWaitFlg, pickCaset);
    if (await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINONLY) {
      billMode = AcrPick.ACR_PICK_NON.index;
    } else if (cPick.fncCode == FuncKey.KY_OVERFLOW_PICK.keyId) {
      billMode = AcrPick.ACR_PICK_NON.index;
    }
    cPickSht = await rcCPickCntMake(billMode, coinMode, cPickSht);

    if (kindOutInfo.typ == 0 ||
        (kindOutInfo.typ != 0 && kindOutInfo.stat == 0)) {
      if (await rcChkBillUnitDisp() != 0) {
        log = sprintf("CPick_Data(%i,%i,%i,%i,%i,%i,%i,%i,%i,%i) = [%i]\n", [
          cPick.btn[ChgInOutDisp.CHGINOUT_Y10000.value].cPickCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y5000.value].cPickCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y2000.value].cPickCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y10000.value].cPickCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y500.value].cPickCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y100.value].cPickCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y50.value].cPickCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y10.value].cPickCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y5.value].cPickCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y1.value].cPickCount,
          cPick.total
        ]);
      } else {
        log = sprintf("CPick_Data(0,0,0,0,%i,%i,%i,%i,%i,%i) = [%i]\n", [
          cPick.btn[ChgInOutDisp.CHGINOUT_Y500.value].cPickCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y100.value].cPickCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y50.value].cPickCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y10.value].cPickCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y5.value].cPickCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y1.value].cPickCount,
          cPick.total
        ]);
      }
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

      log = "Cassette Price[${cPick.cassette}]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

      resvPrc = 0;
      startPosition = await rcChkChgPickStartPosition();
      for (i = startPosition; i < ChgInOutDisp.CHGINOUT_DIF_MAX.value; i++) {
        resvPrc += cPickUnit[i] * cPick.btn[i].afterCount;
      }
      if (await rcChkBillUnitDisp() != 0) {
        log =
            sprintf("CPickAfter_Data(%i,%i,%i,%i,%i,%i,%i,%i,%i,%i) = [%i]\n", [
          cPick.btn[ChgInOutDisp.CHGINOUT_Y10000.value].afterCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y5000.value].afterCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y2000.value].afterCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y10000.value].afterCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y500.value].afterCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y100.value].afterCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y50.value].afterCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y10.value].afterCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y5.value].afterCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y1.value].afterCount,
          resvPrc
        ]);
      } else {
        log = sprintf("CPickAfter_Data(0,0,0,0,%i,%i,%i,%i,%i,%i) = [%i]\n", [
          cPick.btn[ChgInOutDisp.CHGINOUT_Y500.value].afterCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y100.value].afterCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y50.value].afterCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y10.value].afterCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y5.value].afterCount,
          cPick.btn[ChgInOutDisp.CHGINOUT_Y1.value].afterCount,
          resvPrc
        ]);
      }
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }

    if (kindOutInfo.typ != 0) {
      if (kindOutInfo.nowKind == ChgInOutDisp.CHGINOUT_Y10000.value) {
        for (i = ChgInOutDisp.CHGINOUT_Y10000.value;
            i < RcAcrAcbDsp.CHG_1LINE;
            i++) {
          sht[i] = cPick.btn[i].cPickCount;
          shtAfter[i] = cPick.btn[i].afterCount;
          kindOutInfo.ttlSht[i] = sht[i];
          kindOutInfo.resvSht[i] = 0;
        }
      } else if (kindOutInfo.nowKind < ChgInOutDisp.CHGINOUT_DIF_MAX.value) {
        kindOutInfo = await rcCPickPickShtCal(kindOutInfo);
        kindOutInfo.resvSht[kindOutInfo.nowKind] -= kindOutInfo.pickSht;
        kindOutInfo.ttlSht[kindOutInfo.nowKind] += kindOutInfo.pickSht;
        sht[kindOutInfo.nowKind] = kindOutInfo.pickSht;
        shtAfter[kindOutInfo.nowKind] =
            cPick.btn[kindOutInfo.nowKind].afterCount +
                kindOutInfo.resvSht[kindOutInfo.nowKind];
      } else if (kindOutInfo.nowKind == RcAcracb.OVERSHT_PICK) {
        for (i = ChgInOutDisp.CHGINOUT_Y10000.value;
            i < ChgInOutDisp.CHGINOUT_DIF_MAX.value;
            i++) {
          sht[i] = kindOutInfo.overSht[i];
          shtAfter[i] = cPick.btn[i].afterCount;
        }
      }

      log = sprintf("CPick_Data_KindOut(%i,%i,%i,%i,%i,%i,%i,%i,%i,%i)", [
        sht[0],
        sht[1],
        sht[2],
        sht[3],
        sht[4],
        sht[5],
        sht[6],
        sht[7],
        sht[8],
        sht[9]
      ]);
      if (billMode == AcrPick.ACR_PICK_ALL.index ||
          coinMode == AcrPick.ACR_PICK_ALL.index) {
        log = "$log PICK ALL";
      }
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      log = sprintf("CPickAfter_Data_KindOut(%i,%i,%i,%i,%i,%i,%i,%i,%i,%i)", [
        shtAfter[0],
        shtAfter[1],
        shtAfter[2],
        shtAfter[3],
        shtAfter[4],
        shtAfter[5],
        shtAfter[6],
        shtAfter[7],
        shtAfter[8],
        shtAfter[9]
      ]);
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      bkKindOutInfo = KindPickInfo();
      bkKindOutInfo = kindOutInfo;
    }

    cPickData = rcAcrAcbPIckDataSet(cPickData, cPickSht, billMode, coinMode, pickWaitFlg);
    await rcExecFuncMain2();
  }

  /// 関連tprxソース: rckycpick.c - Yes_ExecFunc
  static Future<void> yesExecFunc() async {
    String callFunc = 'yesExecFunc';
    TprLog().logAdd(
        await RcSysChk.getTid(), LogLevelDefine.normal, "Yes_ExecFunc Clicked");
    TprLibDlg.tprLibDlgClear2(callFunc);
    await RcExt.rcClearErrStat(callFunc);
    // gtk_grab_add(CPick.window);
    if (await RcSysChk.rcSGChkSelfGateSystem() ||
        await RcSysChk.rcQCChkQcashierSystem()) {
      RcSgCom.rcSGManageLogYesNo(RcSgDsp.JDG_CONTINUE);
    }
    await rcExecFuncMain();
  }

  /// 関連tprxソース: rckycpick.c - No_ExecFunc
  static Future<void> noExecFunc() async {
    String callFunc = 'noExecFunc';
    TprLog().logAdd(
        await RcSysChk.getTid(), LogLevelDefine.normal, "No_ExecFunc Clicked");
    _closeDialogAll();
    await RcSet.rcClearErrStat2(callFunc);
    // gtk_grab_add(CPick.window);
    if (await RcSysChk.rcSGChkSelfGateSystem() ||
        await RcSysChk.rcQCChkQcashierSystem()) {
      RcSgCom.rcSGManageLogYesNo(RcSgDsp.JDG_INTERRUPT);
    }
  }

  /// 関連tprxソース: rckycpick.c - rcCPick_PickSht_Cal
  static Future<KindPickInfo> rcCPickPickShtCal(KindPickInfo info) async {
    int kind = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return info;
    }
    RxCommonBuf cBuf = xRet.object;

    kind = info.nowKind;
    if (!(kind >= ChgInOutDisp.CHGINOUT_Y500.value &&
        kind <= ChgInOutDisp.CHGINOUT_Y1.value)) {
      return info;
    }

    if (await rcCPickUnitShtChk()) {
      if (await rcCPickUnitShtKindChk(info) != 0 && info.pickmth != 0) {
        info.pickSht = cBuf.dbTrm.coinUnitSht;
      } else {
        info.pickSht = info.resvSht[kind];
      }
    } else {
      info.pickSht = cPick.btn[kind].cPickCount;
    }

    return info;
  }

  /// 関連tprxソース: rckycpick.c - rcCPick_UnitSht_Kind_Chk
  static Future<int> rcCPickUnitShtKindChk(KindPickInfo info) async {
    int kind = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    kind = info.nowKind;
    if (await rcCPickUnitShtChk() && kind >= ChgInOutDisp.CHGINOUT_Y500.value &&
        kind <= ChgInOutDisp.CHGINOUT_Y1.value &&
        info.resvSht[kind] > cBuf.dbTrm.coinUnitSht) {
      return 1;
    }

    return 0;
  }

  /// 関連tprxソース: rckycpick.c - rcAcrAcb_PIckData_Set
  static PickData rcAcrAcbPIckDataSet(PickData pickData, CBillKind cBillKind,
      int billMode, int coinMode, int pickWaitFlg) {
    pickData = PickData();

    pickData.cBillKind = cBillKind;
    pickData.billMode = billMode;
    pickData.coinMode = coinMode;
    pickData.bill = 0; //紙幣の金種別回収はカセットを１金種毎に回収しなくてはならず、標準仕様としては対応しない
    pickData.coin = pickWaitFlg;
    pickData.leave = 0;

    return pickData;
  }

  /// 金種別出金対象かチェック 0:非対象　 1:対象
  /// 関連tprxソース: rckycpick.c - rcCPick_KindOut_Chk
  static Future<void> rcCPickKindOutChk() async {
    int flg = 0;
    int i = 0;
    int posi = 0;
    String pickFlg = '';
    int acbSelect = 0;
    int lastKind = 0;
    String log = '';
    int execFirstFlg = 0;
    String callFunc = 'rcCPickKindOutChk';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    if (cPick.fncCode == FuncKey.KY_OVERFLOW_PICK.keyId) {
      return;
    }

    if (await rcChkAutoOverFlowPick() != 0) {
      return;
    }

    if (cPick.cashRecycle != 0) {
      return;
    }

    if (kindOutInfo.typ != 0 && kindOutInfo.stat != 0) {
      /*出金中*/
      return;
    }

    if (kindOutInfo.typ == 0) {
      execFirstFlg = 1;
    }

    kindOutInfo = KindPickInfo();

    if (cPick.total <= 0) {
      return;
    }
//釣銭機接続時に釣札機種類は見ないし、200で動作するなら50,20も動作するので削除
//仕様書には下記の機種以外動作保証しないと記載あり。(つまり、returnすることはないと捉えられる)
    acbSelect = AcxCom.ifAcbSelect();

    flg = Rxkoptcmncom.rxChkKoptCmnChgPickKindOut(cBuf);
    if (flg >= 1) { //硬貨のみ
      i = 0;
      ChgPickBtn type = ChgPickBtn.getDefine(pickMode);
      switch (type) {
        case ChgPickBtn.ALLBTN_ON :
          i = 1;
          break;
        case ChgPickBtn.RESERVEBTN_ON :
          i = 2;
          break;
        case ChgPickBtn.MANBTN_ON :
        case ChgPickBtn.BILLBTN_ON :
          return;
        case ChgPickBtn.COINBTN_ON :
          i = 3;
          break;
        case ChgPickBtn.USERDATABTN_ON :
          if (cBuf.dbTrm.acxRecoverEcs07 != 0) {
            return;
          }
          i = 4;
          break;
        case ChgPickBtn.CASETBTN_ON :
          break;
        case ChgPickBtn.FULLBTN_ON :
          i = 5;
          break;
        default :
          i = 6;
          break;
      }
      if (i != 0) {
        pickFlg = '';
        if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) != 0) {
          /*ECS接続時のみ*/
          if (AplLibIniFile.aplLibIniFile(
              Tpraid.TPRAID_STR,
              AplLib.INI_GET,
              0,
              "mac_info.ini",
              "acx_flg",
              "ecs_pick_flg",
              pickFlg) == Typ.OK) {
            if (pickFlg[i - 1] == '1') { //金種別出金設定時無効
              return;
            }
          }
        }
      }
      lastKind = 0;
      for (i = ChgInOutDisp.CHGINOUT_Y500.value; i <=
          ChgInOutDisp.CHGINOUT_Y1.value; i++) {
        if (cPick.btn[i].cPickCount > 0) {
          kindOutInfo.kindFlg[i] = 1;
          kindOutInfo.resvSht[i] = cPick.btn[i].cPickCount;
          if (posi == 0) {
            posi = i;
          }
          lastKind = i;
        }
      }
      if (posi != 0) {
        kindOutInfo.typ = 1;
        kindOutInfo.lastKind = lastKind;
        kindOutInfo.pickmth = pickMth;
      } else {
        return;
      }

      if (rcChkChgPickBillCnt() != 0 ||
          (await rcChkCassettePick() != 0 && cPick.cassette != 0)) {
        kindOutInfo.nowKind = ChgInOutDisp.CHGINOUT_Y10000.value;
        kindOutInfo.kindFlg[ChgInOutDisp.CHGINOUT_Y10000.value] = 1;
        kindOutInfo.kindFlg[ChgInOutDisp.CHGINOUT_Y5000.value] = 1;
        kindOutInfo.kindFlg[ChgInOutDisp.CHGINOUT_Y2000.value] = 1;
        kindOutInfo.kindFlg[ChgInOutDisp.CHGINOUT_Y1000.value] = 1;
      } else {
        kindOutInfo.nowKind = posi;
      }
      kindOutInfo.bkKind = kindOutInfo.nowKind;
      kindOutInfo.firstKind = kindOutInfo.nowKind;
      if (pickMode == ChgPickBtn.ALLBTN_ON.btnType ||
          pickMode == ChgPickBtn.COINBTN_ON.btnType) {
        kindOutInfo.coinPickAll = 1;
      }
      log = sprintf(
          "CPick Kind Out Put: nowKind[%d], firstKind[%d], lastKind[%d] coin_pickall[%d]",
          [
            kindOutInfo.nowKind,
            kindOutInfo.firstKind,
            kindOutInfo.lastKind,
            kindOutInfo.coinPickAll
          ]);
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      if (execFirstFlg != 0 && await rcCPickUnitShtKindChk(kindOutInfo) != 0) {
        _closeDialogAll();
        await rcCPickKindOutConfDlg(kindOutInfo, rcExecFuncMain);
      }
    }
  }

  /// 関連tprxソース: rckycpick.c - rcCPick_KindOut_ConfDlg
  static Future<void> rcCPickKindOutConfDlg(KindPickInfo info,
      Function func) async {
    tprDlgParam_t param = tprDlgParam_t();
    String buf = '';
    String msg = '';
    String log = '';
    int errNo = 0;
    String num = '';
    int kind = 0;
    String callFunc = 'rcCPickKindOutConfDlg';
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    log = "$callFunc : Show[${info.nowKind}]";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    _closeDialogAll();
    fncConf = func;
    contInfo = info;

    if (info.nowKind == RcAcracb.COIN_PICKALL) {
      errNo = DlgConfirmMsgKind.MSG_KINDOUT_PICKALL.dlgId;
    } else if (info.nowKind == RcAcracb.OVERSHT_PICK) {
      errNo = DlgConfirmMsgKind.MSG_OVERSHT_PICKOUT.dlgId;
    } else {
      errNo = DlgConfirmMsgKind.MSG_KIND_PAYOUT.dlgId;
    }

    RcSet.rcErrStatSet2(callFunc);
    rcCPickKindOutMsgGet(info, buf, 0);
    param.erCode = errNo;
    param.dialogPtn = DlgPattern.TPRDLG_PT1.dlgPtnId;
    param.title = LTprDlg.BTN_CONF;
    param.func1 = rcCPickKindOutConfClick;
    param.userCode = 0;
    param.msgBuf = buf;
    kind = info.nowKind;
    if (await rcCPickUnitShtChk() && kind >= ChgInOutDisp.CHGINOUT_Y500.value &&
        kind <= ChgInOutDisp.CHGINOUT_Y1.value) {
      msg = sprintf(LRcKyCPick.CPICK_RESERV_SHT, [info.resvSht[kind]]);
      param.user_code_4 = msg;
    }

    if (await rcCPickUnitShtKindChk(info) != 0) {
      param.msg1 = LRcKyCPick.CPICK_ALL_SHT;
      num = sprintf(LRcKyCPick.CPICK_UNIT_SHT, [cBuf.dbTrm.coinUnitSht]);
      param.msg2 = num;
      param.func2 = rcCPickKindOutUnitClick;
    } else {
      param.msg1 = LTprDlg.BTN_CONF;
    }
    if (cMem.stat.dualTSingle == 1) {
      param.dual_dsp = 2;
    }
    rcCPickDlg(
        param.erCode,
        param.dialogPtn,
        param.func1,
        param.msg1,
        param.func2,
        param.msg2,
        param.func3,
        param.msg3);

    await AplLibAuto.aplLibCmAutoMsgSend(
        await RcSysChk.getTid(), AutoMsg.AUTO_MSG_OPERAT);
  }

  /// 関連tprxソース: rckycpick.c - rcCPick_KindOut_MsgGet
  static void rcCPickKindOutMsgGet(KindPickInfo info, String buf, int flg) {
    List<int> kind = [10000, 5000, 2000, 1000, 500, 100, 50, 10, 5, 1];
    int num = 0;

    switch (flg) {
      case 1:
      case 2:
        num = info.bkKind;
        break;
      default:
        num = info.nowKind;
        break;
    }
    if (num > ChgInOutDisp.CHGINOUT_Y1.value) {
      return;
    }

    if (num <= ChgInOutDisp.CHGINOUT_Y1000.value) {
      if ((flg == 1) || (flg == 3)) {
        buf = "(${LRcKyCPick.MSG_BILL})";
      } else {
        buf = LRcKyCPick.MSG_BILL;
      }
    } else {
      if (flg == 2) {
        buf = "${kind[num]}${LRcKyCPick.MSG_YEN}${LRcKyCPick.MSG_COIN}";
      } else if (flg == 0) {
        buf = "${kind[num]}${LRcKyCPick.MSG_YEN}";
      } else {
        buf = "(${kind[num]}${LRcKyCPick.MSG_YEN})";
      }
    }
  }

  /// 関連tprxソース: rckycpick.c - rcCPick_KindOut_Conf_Click
  static Future<void> rcCPickKindOutConfClick() async {
    String callFunc = 'rcCPickKindOutConfClick';
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcCPickKindOutConfClick!");
    _closeDialogAll();
    await RcExt.rcClearErrStat(callFunc);
    contInfo.pickmth = 0;
    pickMth = 0;
    if (fncConf != null) {
      fncConf!();
    }
  }

  /// 関連tprxソース: rckycpick.c - rcCPick_KindOut_Unit_Click
  static Future<void> rcCPickKindOutUnitClick() async {
    String callFunc = 'rcCPickKindOutUnitClick';
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcCPickKindOutUnitClick!");
    _closeDialogAll();
    await RcExt.rcClearErrStat(callFunc);
    contInfo.pickmth = 1;
    pickMth = 1;
    if (fncConf != null) {
      fncConf!();
    }
  }

  /// 関連tprxソース: rckycpick.c - rcChgPick_PickMode_Set
  static Future<(int, int, int, int)> rcChgPickPickModeSet(int billMode, int coinMode,
      int pickWaitFlg, int pickCaset) async {
    List<String> pickFlg = List.generate(8, (_) => '');
    String iniName = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return (billMode, coinMode, pickWaitFlg, pickCaset);
    }
    RxCommonBuf cBuf = xRet.object;

    if (kindOutInfo.typ == 0) {
      iniName = sprintf("%s/conf/mac_info.ini", [EnvironmentData().sysHomeDir]);
      JsonRet ret = await getJsonValue(iniName, "backupd", "start");
      if (ret.result) {
        pickFlg = List.generate(8, (_) => '');
      }
    }

    /*pick_waitflg 変更時rcCPick_KindOut_Chk()を確認*/
    ChgPickBtn type = ChgPickBtn.getDefine(pickMode);
    switch (type) {
      case ChgPickBtn.ALLBTN_ON :
        billMode = AcrPick.ACR_PICK_ALL.index;
        coinMode = AcrPick.ACR_PICK_ALL.index;
        if (pickFlg[0] == '1') {
          pickWaitFlg = 1;
        }
        if (kindOutInfo.typ == 1 &&
            kindOutInfo.nowKind != RcAcracb.COIN_PICKALL) {
          coinMode = AcrPick.ACR_PICK_DATA.index;
        }
        break;
      case ChgPickBtn.RESERVEBTN_ON :
        billMode = AcrPick.ACR_PICK_LEAVE.index;
        coinMode = AcrPick.ACR_PICK_LEAVE.index;
        if (pickFlg[1] == '1') {
          pickWaitFlg = 1;
        }
        break;
      case ChgPickBtn.MANBTN_ON :
        billMode = AcrPick.ACR_PICK_10000.index;
        coinMode = AcrPick.ACR_PICK_NON.index;
        break;
      case ChgPickBtn.BILLBTN_ON :
        billMode = AcrPick.ACR_PICK_ALL.index;
        coinMode = AcrPick.ACR_PICK_NON.index;
        break;
      case ChgPickBtn.COINBTN_ON :
        billMode = AcrPick.ACR_PICK_NON.index;
        coinMode = AcrPick.ACR_PICK_ALL.index;
        if (pickFlg[2] == '1') {
          pickWaitFlg = 1;
        }
        if (kindOutInfo.typ == 1 &&
            kindOutInfo.nowKind != RcAcracb.COIN_PICKALL) {
          coinMode = AcrPick.ACR_PICK_DATA.index;
        }
        break;
      case ChgPickBtn.USERDATABTN_ON :
        if (rcChkChgPickBillCnt() == 0) {
          /* 紙幣回収枚数 */
          billMode = AcrPick.ACR_PICK_NON.index;
        } else {
          billMode = AcrPick.ACR_PICK_DATA.index;
        }
        coinMode = AcrPick.ACR_PICK_DATA.index;
        if (cBuf.dbTrm.acxRecoverEcs07 != 0) {
          pickWaitFlg = 1;
        } else if (pickFlg[3] == '1') {
          pickWaitFlg = 1;
        } else {
          pickWaitFlg = 0;
        }
        break;
      case ChgPickBtn.CASETBTN_ON :
        if ((AcxCom.ifAcbSelect() & CoinChanger.SST1) != 0) {
          billMode = AcrPick.ACR_PICK_DATA.index;
        } else
        if (cPick.btn[ChgInOutDisp.CHGINOUT_Y10000.value].cPickCount != 0 ||
            (cPick.btn[ChgInOutDisp.CHGINOUT_Y5000.value].cPickCount != 0) ||
            (cPick.btn[ChgInOutDisp.CHGINOUT_Y2000.value].cPickCount != 0) ||
            (cPick.btn[ChgInOutDisp.CHGINOUT_Y1000.value].cPickCount != 0)) {
          billMode = AcrPick.ACR_PICK_DATA.index;
        } else {
          billMode = AcrPick.ACR_PICK_CASET.index;
          pickCaset = 1;
        }
        coinMode = AcrPick.ACR_PICK_DATA.index;
        break;
      case ChgPickBtn.FULLBTN_ON :
        if (rcChkChgPickBillCnt() == 0) {
          /* 紙幣回収枚数 */
          billMode = AcrPick.ACR_PICK_NON.index;
        } else {
          billMode = AcrPick.ACR_PICK_DATA.index;
        }
        coinMode = AcrPick.ACR_PICK_DATA.index;
        if (pickFlg[4] == '1') {
          pickWaitFlg = 1;
        }
        break;
      default :
        if (rcChkChgPickBillCnt() == 0) {
          /* 紙幣回収枚数 */
          billMode = AcrPick.ACR_PICK_NON.index;
        } else {
          billMode = AcrPick.ACR_PICK_DATA.index;
        }
        coinMode = AcrPick.ACR_PICK_DATA.index;
        if (pickFlg[5] == '1') {
          pickWaitFlg = 1;
        }
        break;
    }
    if (kindOutInfo.typ == 1) {
      if (kindOutInfo.nowKind == RcAcracb.OVERSHT_PICK) {
        if ((rcCPickOverShtChk() & 0x01) != 0) {
          billMode = AcrPick.ACR_PICK_DATA.index;
        }
        if ((rcCPickOverShtChk() & 0x02) != 0) {
          coinMode = AcrPick.ACR_PICK_DATA.index;
        }
      } else if (kindOutInfo.nowKind <= ChgInOutDisp.CHGINOUT_Y1000.value) {
        /*紙幣回収*/
        coinMode = AcrPick.ACR_PICK_NON.index;
      } else {
        billMode = AcrPick.ACR_PICK_NON.index;
      }
    }
    return (billMode, coinMode, pickWaitFlg, pickCaset);
  }

  /// 関連tprxソース: rckycpick.c - rcCPick_OverSht_Chk
  static int rcCPickOverShtChk() {
    int i = 0;
    int ret = 0;

    for (i = ChgInOutDisp.CHGINOUT_Y10000.value; i <=
        ChgInOutDisp.CHGINOUT_Y1000.value; i ++) {
      if (kindOutInfo.overSht[i] > 0) {
        ret |= 0x01;
      } else {
        kindOutInfo.overSht[i] = 0;
      }
    }

    for (i = ChgInOutDisp.CHGINOUT_Y500.value; i <=
        ChgInOutDisp.CHGINOUT_Y1.value; i ++) {
      if (kindOutInfo.overSht[i] > 0) {
        ret |= 0x02;
      } else {
        kindOutInfo.overSht[i] = 0;
      }
    }
    return ret;
  }

  /// 関連tprxソース: rckycpick.c - rcRefreshProc
  static Future<void> rcRefreshProc(int flg) async {
    int i = 0;
    int startPosition = 0;
    int errNo = 0;
    String log = '';
    String callFunc = 'rcRefreshProc';

    errNo = rcSstBillMoveProc();
    if (errNo != 0) {
      await RcKyccin.ccinErrDialog2(callFunc, errNo, 0);
      return;
    }

    await rcCPickStockMake();
    await rcAcrEntryDraw();
    // await rcChgPickBtnProc();
    await rcCassetteEntryDraw();
    startPosition = await rcChkChgPickStartPosition();
    for (i = startPosition; i < ChgInOutDisp.CHGINOUT_DIF_MAX.value; i++) {
      await rcAfterEntryDraw(i);
    }

    if (AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) != 0) {
      if (cPick.fncCode == FuncKey.KY_CHGPICK.keyId &&
          await rcChkCMAutoPickAutoCPick()) {
        if (await rcChkCMAutoPickAutoReserv()) {
          if (flg == 0 ||
              (flg == 1 && btnPressFlg != ChgPickBtn.RESERVEBTN_ON.btnType)) {
            btnPressFlg = ChgPickBtn.BTN_OFF.btnType;
            await rcChgPickReserveFunc();
          }
        } else if (await rcChkCMAutoPickAutoAll()) {
          if (flg == 0 ||
              (flg == 1 && btnPressFlg != ChgPickBtn.ALLBTN_ON.btnType)) {
            btnPressFlg = ChgPickBtn.BTN_OFF.btnType;
            await rcChgPickAllFunc();
          }
        }
      } else {
        if (btnPressFlg == ChgPickBtn.BTN_OFF.btnType) {
          // TODO:10164 自動閉設 UI系の為保留
          // rcChgPick_BtnOn(btnPressFlg_Org);	//セーブしていた回収ボタンをセット
          // TODO:10164 自動閉設 ボタン描画なのでコメントアウト
          // rcCPick_BtnPush_Disp();
          log = "btnPressFlgOrg[$btnPressFlgOrg] -> rcChgPick_BtnProc()\n";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          // await rcChgPickBtnProc(); //回収ボタン押下
        }
        btnPressFlgOrg = ChgPickBtn.BTN_OFF.btnType;
      }
    }
  }

  /// 関連tprxソース: rckycpick.c - rcAcrEntry_Draw
  static Future<void> rcAcrEntryDraw() async {
    /* 回収前データ作成 */
    int i = 0;

    if (await rcChkBillUnitDisp() != 0) {
      cPick.btn[ChgInOutDisp.CHGINOUT_Y10000.value].acrCount =
          pCoinData.holder.bill10000;
      cPick.btn[ChgInOutDisp.CHGINOUT_Y5000.value].acrCount =
          pCoinData.holder.bill5000;
      cPick.btn[ChgInOutDisp.CHGINOUT_Y2000.value].acrCount =
          pCoinData.holder.bill2000;
      cPick.btn[ChgInOutDisp.CHGINOUT_Y1000.value].acrCount =
          pCoinData.holder.bill1000;
      for (i = 0; i < RcAcrAcbDsp.CHG_1LINE; i++) {
        await rcChgPickAcrData(
            cPick.btn[i].acrCount, RcInOut.CPick_Length, i, 1);
      }
    }

    cPick.btn[ChgInOutDisp.CHGINOUT_Y500.value].acrCount =
        pCoinData.holder.coin500;
    cPick.btn[ChgInOutDisp.CHGINOUT_Y100.value].acrCount =
        pCoinData.holder.coin100;
    cPick.btn[ChgInOutDisp.CHGINOUT_Y50.value].acrCount =
        pCoinData.holder.coin50;
    cPick.btn[ChgInOutDisp.CHGINOUT_Y10.value].acrCount =
        pCoinData.holder.coin10;
    cPick.btn[ChgInOutDisp.CHGINOUT_Y5.value].acrCount = pCoinData.holder.coin5;
    cPick.btn[ChgInOutDisp.CHGINOUT_Y1.value].acrCount = pCoinData.holder.coin1;
    for (i = RcAcrAcbDsp.CHG_1LINE;
    i < ChgInOutDisp.CHGINOUT_DIF_MAX.value;
    i++) {
      await rcChgPickAcrData(cPick.btn[i].acrCount, RcInOut.CPick_Length, i, 1);
    }
  }

  /// 関連tprxソース: rckycpick.c - rcCassetteEntry_Draw
  static Future<void> rcCassetteEntryDraw() async {
    /* カセット内金額データ作成 */
    List<int> casetPrc = List.generate(15 * 2, (index) => 0);
    CmEditCtrl fCtrl = CmEditCtrl();
    int bytes = 0;

    fCtrl.SignEdit = 1;
    fCtrl.SeparatorEdit = 2;
    if (cPick.cashRecycle == 0) {
      await rcCalCPickCassette();
    }

    casetPrc[0] = int.tryParse(TprDefAsc.SPC) ?? 0;
    CmNedit().cmEditTotalPriceUtf(
        fCtrl, casetPrc, casetPrc.length, 14, cPick.cassette, bytes);
    casetPrc = List.generate(15 * 2, (index) => 0x00);
    // gtk_round_entry_set_text(GTK_ROUND_ENTRY(CPick.CassettePrice),CasetPrc);
  }

  /// 関連tprxソース: rckycpick.c - rcCal_CPickCassette
  static Future<void> rcCalCPickCassette() async {
    cPick.cassette = 0;

    if (await rcChkBillUnitDisp() != 0) {
      cPick.cassette = (pCoinData.overflow.bill10000 * 10000) +
          (pCoinData.overflow.bill5000 * 5000) +
          (pCoinData.overflow.bill2000 * 2000) +
          (pCoinData.overflow.bill1000 * 1000) +
          (pCoinData.overflow.coin500 * 500) +
          (pCoinData.overflow.coin100 * 100) +
          (pCoinData.overflow.coin50 * 50) +
          (pCoinData.overflow.coin10 * 10) +
          (pCoinData.overflow.coin5 * 5) +
          (pCoinData.overflow.coin1 * 1);
    } else {
      cPick.cassette = (pCoinData.overflow.coin500 * 500) +
          (pCoinData.overflow.coin100 * 100) +
          (pCoinData.overflow.coin50 * 50) +
          (pCoinData.overflow.coin10 * 10) +
          (pCoinData.overflow.coin5 * 5) +
          (pCoinData.overflow.coin1 * 1);
    }
  }

  /// CM精算で釣機回収の回収方法を自動「残置」選択
  /// 関連tprxソース: rckycpick.c - rcChk_CMAuto_Pick_AutoReserv
  static Future<bool> rcChkCMAutoPickAutoReserv() async {
    return AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) != 0 &&
        await AplLibAuto.strOpnClsSetChk(
            await RcSysChk.getTid(), StrOpnClsCodeList.STRCLS_CPICK) == 1;
  }

  /// 関連tprxソース: rckycpick.c - rcChgPickReserve_Func
  static Future<void> rcChgPickReserveFunc() async {
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.stat.dspEventMode == 100) {
      return;
    }

    if (await rcCPickKindOutStatChk(kindOutInfo) != 0 &&
        AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) == 0) {
      return;
    }

    await rcChgPickReserveFuncMain();
  }

  /// 関連tprxソース: rckycpick.c - rcCPick_KindOut_Stat_Chk
  static Future<int> rcCPickKindOutStatChk(KindPickInfo info) async {
    String log = '';
    String callFunc = 'rcCPickKindOutStatChk';

    if (info.typ == 0) {
      return 0;
    }

    if (info.stat != 0) {
      log = "$callFunc : typ[${info.typ}] stat[${info.stat}]";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }

    return info.stat;
  }

  /// 関連tprxソース: rckycpick.c - rcChgPickAll_Func
  static Future<void> rcChgPickAllFunc() async {
    AcMem cMem = SystemFunc.readAcMem();

    if (cMem.stat.dspEventMode == 100) {
      return;
    }

    if (await rcCPickKindOutStatChk(kindOutInfo) != 0) {
      return;
    }

    await rcChgPickAllFuncMain();
  }

  /// 手動選択で動作しているか確認
  /// 関連tprxソース: rckycpick.c - rcChk_Auto_Pick_Manual
  static Future<int> rcChkAutoPickManual() async {
    int tmpData = 0;

    if (AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) == 0) {
      //自動精算でない
      return 1; //手動選択
    }

    tmpData = await AplLibAuto.strOpnClsSetChk(
        await RcSysChk.getTid(), StrOpnClsCodeList.STRCLS_CPICK);
    switch (tmpData) {
      case 2: //手動選択(複数可)
      case 4: //する(複数可)
        return 1; //手動選択
      default:
        break;
    }

    return 0; //手動でない
  }

  /// 関連tprxソース: rckycpick.c - rcCPickCntMake
  static Future<CBillKind> rcCPickCntMake(int billMode, int coinMode, CBillKind cPickSht) async {
    cPickSht = CBillKind();
    if ((kindOutInfo.typ == 1) &&
        (kindOutInfo.nowKind == RcAcracb.OVERSHT_PICK)) {
      if (billMode != AcrPick.ACR_PICK_NON.index) {
        cPickSht.bill10000 =
            kindOutInfo.overSht[ChgInOutDisp.CHGINOUT_Y10000.value];
        cPickSht.bill5000 =
            kindOutInfo.overSht[ChgInOutDisp.CHGINOUT_Y5000.value];
        cPickSht.bill2000 =
            kindOutInfo.overSht[ChgInOutDisp.CHGINOUT_Y2000.value];
        cPickSht.bill1000 =
            kindOutInfo.overSht[ChgInOutDisp.CHGINOUT_Y1000.value];
      }

      if (coinMode != AcrPick.ACR_PICK_NON.index) {
        cPickSht.coin500 =
            kindOutInfo.overSht[ChgInOutDisp.CHGINOUT_Y500.value];
        cPickSht.coin100 =
            kindOutInfo.overSht[ChgInOutDisp.CHGINOUT_Y100.value];
        cPickSht.coin50 = kindOutInfo.overSht[ChgInOutDisp.CHGINOUT_Y50.value];
        cPickSht.coin10 = kindOutInfo.overSht[ChgInOutDisp.CHGINOUT_Y10.value];
        cPickSht.coin5 = kindOutInfo.overSht[ChgInOutDisp.CHGINOUT_Y5.value];
        cPickSht.coin1 = kindOutInfo.overSht[ChgInOutDisp.CHGINOUT_Y1.value];
      }
      return cPickSht;
    }

    if (billMode != AcrPick.ACR_PICK_NON.index) {
      cPickSht.bill10000 =
          cPick.btn[ChgInOutDisp.CHGINOUT_Y10000.value].cPickCount;
      cPickSht.bill5000 =
          cPick.btn[ChgInOutDisp.CHGINOUT_Y5000.value].cPickCount;
      cPickSht.bill2000 =
          cPick.btn[ChgInOutDisp.CHGINOUT_Y2000.value].cPickCount;
      cPickSht.bill1000 =
          cPick.btn[ChgInOutDisp.CHGINOUT_Y1000.value].cPickCount;
    }

    if (coinMode != AcrPick.ACR_PICK_NON.index) {
      if (kindOutInfo.typ == 1) {
        kindOutInfo = await rcCPickPickShtCal(kindOutInfo);
        ChgInOutDisp value = ChgInOutDisp.getDefine(kindOutInfo.nowKind);
        switch (value) {
          case ChgInOutDisp.CHGINOUT_Y500:
            cPickSht.coin500 = kindOutInfo.pickSht;
            return cPickSht;
          case ChgInOutDisp.CHGINOUT_Y100:
            cPickSht.coin100 = kindOutInfo.pickSht;
            return cPickSht;
          case ChgInOutDisp.CHGINOUT_Y50:
            cPickSht.coin50 = kindOutInfo.pickSht;
            return cPickSht;
          case ChgInOutDisp.CHGINOUT_Y10:
            cPickSht.coin10 = kindOutInfo.pickSht;
            return cPickSht;
          case ChgInOutDisp.CHGINOUT_Y5:
            cPickSht.coin5 = kindOutInfo.pickSht;
            return cPickSht;
          case ChgInOutDisp.CHGINOUT_Y1:
            cPickSht.coin1 = kindOutInfo.pickSht;
            return cPickSht;
          default:
            break;
        }
        return cPickSht;
      }

      cPickSht.coin500 = cPick.btn[ChgInOutDisp.CHGINOUT_Y500.value].cPickCount;
      cPickSht.coin100 = cPick.btn[ChgInOutDisp.CHGINOUT_Y100.value].cPickCount;
      cPickSht.coin50 = cPick.btn[ChgInOutDisp.CHGINOUT_Y50.value].cPickCount;
      cPickSht.coin10 = cPick.btn[ChgInOutDisp.CHGINOUT_Y10.value].cPickCount;
      cPickSht.coin5 = cPick.btn[ChgInOutDisp.CHGINOUT_Y5.value].cPickCount;
      cPickSht.coin1 = cPick.btn[ChgInOutDisp.CHGINOUT_Y1.value].cPickCount;
    }

    return cPickSht;
  }

  /// 関連tprxソース: rckycpick.c - rcExecFunc_Main2
  static Future<void> rcExecFuncMain2() async {
    int errNo = 0;
    String callFunc = 'rcExecFuncMain2';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    if (kindOutInfo.typ == 0 || !(await rcCPickUnitShtChk())) {
      await rcCPickErrSet(kindOutInfo, 0, 0);
    }

    errNo = await RcAcracb.rcAcrAcbPickUp(cPickData);
    // TODO:10164 自動閉設 UI系の為保留
    // rc_KindOut_Btn_Off();
    kindOutInfo.kindMsg = '';
    rcCPickKindOutMsgGet(kindOutInfo, kindOutInfo.kindMsg, 0);
    await rcCPickNextKindSet(kindOutInfo);

    if (errNo == Typ.OK) {
      await RcExt.rxChkModeSet(callFunc);
      TprLog().logAdd(
          await RcSysChk.getTid(), LogLevelDefine.normal, "rcCPick_Rslt_Chk()");
      AcbInfo.cPickRsltCnt = 0;
      await rcCPickRsltChk();
    } else {
      if (cBuf.dbTrm.acxChgRecoverArea != 0 && kindOutInfo.typ == 0) {
        errNo = await RcAcracb.rcEcsOpeSetGp2Dtl(0);
        opeSet = 0;
      }
      complete = false;
      rcExecProc();
    }
  }

  /// 出金金種のエラーをセット typ  0:出金前　1：出金後
  /// 関連tprxソース: rckycpick.c - rcCPick_Err_Set
  static Future<void> rcCPickErrSet(KindPickInfo info, int errNo,
      int typ) async {
    int kind = 0;
    String log = '';
    String callFunc = 'rcCPickErrSet';

    if (info.typ == 0) {
      return;
    }

    if (typ != 0) {
      kind = info.bkKind;
    } else {
      kind = info.nowKind;
    }

    if (kind == ChgInOutDisp.CHGINOUT_DIF_MAX.value) {
      return;
    }

    rcKindOutPrnSet(kind, KindOutPrn.KINDOUT_PRN_ERR.index, errNo);
    if (info.typ == 1 && kind == ChgInOutDisp.CHGINOUT_Y10000.value) {
      rcKindOutPrnSet(ChgInOutDisp.CHGINOUT_Y5000.value,
          KindOutPrn.KINDOUT_PRN_ERR.index, errNo);
      rcKindOutPrnSet(ChgInOutDisp.CHGINOUT_Y2000.value,
          KindOutPrn.KINDOUT_PRN_ERR.index, errNo);
      rcKindOutPrnSet(ChgInOutDisp.CHGINOUT_Y1000.value,
          KindOutPrn.KINDOUT_PRN_ERR.index, errNo);
    }

    log = "$callFunc : kind[$kind] errNo[$errNo]";

    if (errNo != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
      complete = false;
    } else {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }
  }

  /// 関連tprxソース: rckycpick.c - rc_KindOut_Prn_Set
  static int rcKindOutPrnSet(int i, int flg, int data) {
    ChgInOutDisp value = ChgInOutDisp.getDefine(i);
    switch (value) {
      case ChgInOutDisp.CHGINOUT_Y10000:
        if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
          RegsMem().tTtllog.t105100Sts.kindoutPrnErrno1 = data;
        } else {
          RegsMem().tTtllog.t105100Sts.kindoutPrnStat1 = data;
        }
        break;
      case ChgInOutDisp.CHGINOUT_Y5000:
        if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
          RegsMem().tTtllog.t105100Sts.kindoutPrnErrno2 = data;
        } else {
          RegsMem().tTtllog.t105100Sts.kindoutPrnStat2 = data;
        }
        break;
      case ChgInOutDisp.CHGINOUT_Y2000:
        if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
          RegsMem().tTtllog.t105100Sts.kindoutPrnErrno3 = data;
        } else {
          RegsMem().tTtllog.t105100Sts.kindoutPrnStat3 = data;
        }
        break;
      case ChgInOutDisp.CHGINOUT_Y1000:
        if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
          RegsMem().tTtllog.t105100Sts.kindoutPrnErrno4 = data;
        } else {
          RegsMem().tTtllog.t105100Sts.kindoutPrnStat4 = data;
        }
        break;
      case ChgInOutDisp.CHGINOUT_Y500:
        if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
          RegsMem().tTtllog.t105100Sts.kindoutPrnErrno5 = data;
        } else {
          RegsMem().tTtllog.t105100Sts.kindoutPrnStat5 = data;
        }
        break;
      case ChgInOutDisp.CHGINOUT_Y100:
        if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
          RegsMem().tTtllog.t105100Sts.kindoutPrnErrno6 = data;
        } else {
          RegsMem().tTtllog.t105100Sts.kindoutPrnStat6 = data;
        }
        break;
      case ChgInOutDisp.CHGINOUT_Y50:
        if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
          RegsMem().tTtllog.t105100Sts.kindoutPrnErrno7 = data;
        } else {
          RegsMem().tTtllog.t105100Sts.kindoutPrnStat7 = data;
        }
        break;
      case ChgInOutDisp.CHGINOUT_Y10:
        if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
          RegsMem().tTtllog.t105100Sts.kindoutPrnErrno8 = data;
        } else {
          RegsMem().tTtllog.t105100Sts.kindoutPrnStat8 = data;
        }
        break;
      case ChgInOutDisp.CHGINOUT_Y5:
        if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
          RegsMem().tTtllog.t105100Sts.kindoutPrnErrno9 = data;
        } else {
          RegsMem().tTtllog.t105100Sts.kindoutPrnStat9 = data;
        }
        break;
      case ChgInOutDisp.CHGINOUT_Y1:
        if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
          RegsMem().tTtllog.t105100Sts.kindoutPrnErrno10 = data;
        } else {
          RegsMem().tTtllog.t105100Sts.kindoutPrnStat10 = data;
        }
        break;
      default:
        break;
    }
    return 0;
  }

  /// 次の出金金種をセット
  /// 関連tprxソース: rckycpick.c - rcCPick_NextKind_Set
  static Future<void> rcCPickNextKindSet(KindPickInfo info) async {
    int i = 0;
    int num = 0;
    int kind = 0;

    if (info.typ == 0 || info.stat == 2) {
      return;
    }

    bkKindOutInfo = kindOutInfo;
    info.bkKind = info.nowKind;
    kind = info.nowKind;
    if (kind >= ChgInOutDisp.CHGINOUT_Y500.value &&
        kind <= ChgInOutDisp.CHGINOUT_Y1.value) {
      info.bkresvsht = info.resvSht[kind] + info.pickSht;
    }

    if (await rcCPickUnitShtChk() &&
        kind >= ChgInOutDisp.CHGINOUT_Y500.value &&
        kind <= ChgInOutDisp.CHGINOUT_Y1.value &&
        info.resvSht[kind] > 0) {
      rcKindOutPrnSet(info.nowKind, KindOutPrn.KINDOUT_PRN_STAT.index, 1);
      info.stat = 1;
      return;
    }

    if ((info.nowKind == RcAcracb.COIN_PICKALL) ||
        (info.nowKind == RcAcracb.OVERSHT_PICK)) {
      info.stat = 2;
      info.nowKind = ChgInOutDisp.CHGINOUT_DIF_MAX.value;
      return;
    } else if (info.nowKind < ChgInOutDisp.CHGINOUT_DIF_MAX.value) {
      rcKindOutPrnSet(info.nowKind, KindOutPrn.KINDOUT_PRN_STAT.index, 1);
      if (info.nowKind == ChgInOutDisp.CHGINOUT_Y10000.value) {
        rcKindOutPrnSet(ChgInOutDisp.CHGINOUT_Y5000.value,
            KindOutPrn.KINDOUT_PRN_STAT.index, 1);
        rcKindOutPrnSet(ChgInOutDisp.CHGINOUT_Y2000.value,
            KindOutPrn.KINDOUT_PRN_STAT.index, 1);
        rcKindOutPrnSet(ChgInOutDisp.CHGINOUT_Y1000.value,
            KindOutPrn.KINDOUT_PRN_STAT.index, 1);
      }
    }

    if (info.nowKind >= info.lastKind) {
      if (info.coinPickAll != 0) {
        info.stat =
        1; //first_kind == lastKindの時、全回収を行う確認ボタン押下にて入力エラーが発生するためstatセット
        info.nowKind = RcAcracb.COIN_PICKALL;
      } else if (AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) !=
          0 &&
          rcCPickOverShtChk() != 0) {
        info.stat = 1;
        info.nowKind = RcAcracb.OVERSHT_PICK;
      } else {
        info.stat = 2;
        info.nowKind = ChgInOutDisp.CHGINOUT_DIF_MAX.value;
      }
      return;
    }
    info.stat = 1;

    if (info.typ == 1) {
      if (info.nowKind == ChgInOutDisp.CHGINOUT_Y10000.value) {
        num = ChgInOutDisp.CHGINOUT_Y500.value;
      } else {
        num = info.nowKind + 1;
      }
      for (i = num; i <= info.lastKind; i++) {
        if (info.kindFlg[i] == 1) {
          info.nowKind = i;
          return;
        }
      }
      /*回収金種がなければstatを完了にする*/
      info.nowKind = ChgInOutDisp.CHGINOUT_DIF_MAX.value;
      info.stat = 2;
    }
  }

  /// 関連tprxソース: rckycpick.c - rcCPick_Rslt_Chk
  static Future<void> rcCPickRsltChk() async {
    int errNo = 0;
    String log = '';
    int acbSelect = 0;
    String callFunc = 'rcCPickRsltChk';
    RxMemRet xRetS = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetS.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRetS.object;
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRetC.object;

    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }

    acbSelect = AcxCom.ifAcbSelect();
    RcGtkTimer.rcGtkTimerRemove();
    if (AcbInfo.cPickRsltCnt < 2100) {
      await RcIfEvent.rcWaitSave();
      if (tsBuf.acx.order == AcxProcNo.ACX_PICKUP_GET.no ||
          tsBuf.acx.order == AcxProcNo.ACX_NOT_ORDER.no) {

        await Future.delayed(const Duration(microseconds: 20000));
        errNo = await RcAcracb.rcAcrAcbResultGet(tsBuf.acx.devAck);

        // TODO : 動作中で帰ってきた場合のみ無視して先に進む
        if (errNo == DlgConfirmMsgKind.MSG_ACRACT.dlgId) {
          errNo = 0;
        }

        if (errNo == 0 ||
            errNo == DlgConfirmMsgKind.MSG_ACRACT.index ||
            errNo == DlgConfirmMsgKind.MSG_TAKE_MONEY.index) {
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
              "rcCPick_Rslt_Chk() OK");
        } else {
          RegsMem().tTtllog.t105100Sts.cpickErrno = cPickErrno = errNo;
          log = "rcCPick_Rslt_Chk() errNo[$errNo]\n";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
          complete = false;
        }
        if (actMsgFlg > 0) {
          actMsgFlg = 0;
          _closeDialogAll();
        }

        if ((acbSelect & CoinChanger.SST1) != 0 ||
            (acbSelect & CoinChanger.FAL2) != 0) {
          if (await rcChkCassettePick() != 0 &&
              (kindOutInfo.typ != 0 ||
                  kindOutInfo.bkKind < ChgInOutDisp.CHGINOUT_Y500.value)) {
            await rcSstCassetteWait();
          } else {
            if (cPickErrno != 0) {
              ChgPickBtn type = ChgPickBtn.getDefine(pickMode);
              switch (type) {
                case ChgPickBtn.ALLBTN_ON:
                case ChgPickBtn.BILLBTN_ON:
                case ChgPickBtn.COINBTN_ON:
//                   case RESERVEBTN_ON  :	//残置回収の再計算ができない(回収前在高から計算。回収枚数から印字情報作成。)
                  if (kindOutInfo.typ == 0 ||
                      (kindOutInfo.typ != 0 &&
                          (kindOutInfo.bkKind <
                                  ChgInOutDisp.CHGINOUT_Y500.value ||
                              kindOutInfo.bkKind == RcAcracb.COIN_PICKALL))) {
                    /*金種別出金時全回収のみ表示*/
                    await cPickContinueDialog();
                    break;
                  }
                default:
                  rcExecProc();
                  break;
              }
              complete = false;
            } else {
              rcExecProc();
            }
          }
        } else {
          if (cBuf.dbTrm.acxChgRecoverArea != 0 && kindOutInfo.typ == 0) {
            errNo = await RcAcracb.rcEcsOpeSetGp2Dtl(0);
            opeSet = 0;
          }
          rcExecProc();
        }
        return;
      } else {
        /* Retry */
        if (actMsgFlg > 2) {
          actMsgFlg = 0;
          _closeDialogAll();
        } else {
          if (actMsgFlg == 0) {
            await cPickEndDialog(1);
          }
          actMsgFlg++;
        }
        AcbInfo.cPickRsltCnt++;
        await Future.delayed(const Duration(milliseconds: 1000));
        await rcCPickRsltChk();
        // errNo = RcGtkTimer.rcGtkTimerAdd(1000, rcCPickRsltChk);
        return;
      }
    } else {
      /* Retry Over */
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcCPick_Rslt_Chk Retry Over");
      RegsMem().tTtllog.t105100Sts.cpickErrno =
          DlgConfirmMsgKind.MSG_TEXT37.index;
      if (actMsgFlg > 0) {
        actMsgFlg = 0;
        _closeDialogAll();
      }
      rcExecProc();
      return;
    }
  }

  /// 関連tprxソース: rckycpick.c - rcSst_CassetteWait
  static Future<void> rcSstCassetteWait() async {
    int errNo = 0;
    String log = '';
    String callFunc = 'rcSstCassetteWait';
    AcMem cMem = SystemFunc.readAcMem();

    if (await RcSysChk.rcCheckOutSider()) {
      return;
    }

    RcGtkTimer.rcGtkTimerRemove();

    if (AcbInfo.cPickRsltCnt < 2100) {
      await RcIfEvent.rcWaitSave();
      errNo = await RcAcracb.rcChkAcrAcbChkStock(0);
      if (errNo != 0 && errNo != DlgConfirmMsgKind.MSG_ACRACT.index) {
        if (cPickErrno == 0) {
          RegsMem().tTtllog.t105100Sts.cpickErrno = cPickErrno;
          cPickErrno = errNo;
        }
        log = "rcSst_CassetteWait() errNo[$errNo]\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
        if (actMsgFlg > 0) {
          actMsgFlg = 0;
          _closeDialogAll();
        }
        rcExecProc();
        complete = false;
        return;
      }
      if (cMem.coinData.overflow.bill10000 == 0 &&
          cMem.coinData.overflow.bill5000 == 0 &&
          cMem.coinData.overflow.bill2000 == 0 &&
          cMem.coinData.overflow.bill1000 == 0 &&
          cMem.coinData.billrjctIn == 0) {
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "rcSst_CassetteWait() OK");
        if (actMsgFlg > 0) {
          actMsgFlg = 0;
          _closeDialogAll();
        }
        if (cPickErrno != 0) {
          ChgPickBtn type = ChgPickBtn.getDefine(pickMode);
          switch (type) {
            case ChgPickBtn.ALLBTN_ON:
            case ChgPickBtn.BILLBTN_ON:
            case ChgPickBtn.COINBTN_ON:
              if (kindOutInfo.typ == 0 ||
                  (kindOutInfo.typ != 0 &&
                      (kindOutInfo.bkKind < ChgInOutDisp.CHGINOUT_Y500.value ||
                          kindOutInfo.bkKind == RcAcracb.COIN_PICKALL))) {
                /*金種別出金時全回収のみ表示*/
                await cPickContinueDialog();
                break;
              }
            default:
              rcExecProc();
              break;
          }
          complete = false;
        } else {
          rcExecProc();
        }
        return;
      } else {
        /* Retry */
        if (actMsgFlg > 2) {
          actMsgFlg = 0;
          _closeDialogAll();
        } else {
          if (actMsgFlg == 0) {
            await cPickEndDialog(0);
          }
          actMsgFlg++;
        }
        AcbInfo.cPickRsltCnt++;
        errNo = RcGtkTimer.rcGtkTimerAdd(1000, rcSstCassetteWait);
        return;
      }
    } else {
      /* Retry Over */
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcSst_CassetteWait Retry Over");
      RegsMem().tTtllog.t105100Sts.cpickErrno =
          DlgConfirmMsgKind.MSG_TEXT37.index;
      if (actMsgFlg > 0) {
        actMsgFlg = 0;
        _closeDialogAll();
      }
      rcExecProc();
      return;
    }
  }

  /// 関連tprxソース: rckycpick.c - rcExecProc
  static Future<void> rcExecProc() async {
    String log = '';
    String buf = '';
    String callFunc = 'rcExecProc';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    if (RegsMem().tTtllog.t105100Sts.cpickErrno != 0) {
      await rcCPickErrSet(
          kindOutInfo, RegsMem().tTtllog.t105100Sts.cpickErrno, 1);
      complete = false;
    }

    if (AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) != 0 &&
        kindOutInfo.bkKind != RcAcracb.OVERSHT_PICK) {
      if (cPickErrno != 0) {
        log =
            "rcExecProc in Ky_ChgPick cPickErrno[$cPickErrno] CashRecycle Out_Err_In_Proc\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        await RcExt.rxChkModeReset(callFunc);
        if (kindOutInfo.typ != 0) {
          rcCPickKindOutMsgGet(kindOutInfo, buf, 2);
          // TODO:10164 自動閉設 必要があれば実装
          // rc_CashRecycle_Out_Err_In_Proc(CashRecycleType.CASH_RECYCLE_PICK_TYPE.type, buf);
        } else {
          // TODO:10164 自動閉設 必要があれば実装
          // rc_CashRecycle_Out_Err_In_Proc(CashRecycleType.CASH_RECYCLE_PICK_TYPE.type, null);
        }
        await RcKyccin.ccinErrDialog2(callFunc, cPickErrno, 0);
        cPickErrno = 0;
        complete = false;
        return;
      }
    }

    if (kindOutInfo.typ != 0 && kindOutInfo.stat != 2 && cPickErrno != 0) {
      log = "rcExecProc in Ky_ChgPick cPickErrno[$cPickErrno]\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
      await RcExt.rxChkModeReset(callFunc);
      await RcKyccin.ccinErrDialog2(callFunc, cPickErrno, 0);
      RegsMem().tTtllog.t105100Sts.cpickErrno = 0;
      cPickErrno = 0;
      complete = false;
      return;
    }
    if (rcCPickKindOutConChk(kindOutInfo) != 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcExecProc in Ky_ChgPick To Pick Next Kind");
      await RcExt.rxChkModeReset(callFunc);
      await rcCPickKindOutConfDlg(kindOutInfo, rcExecFuncMain);
      return;
    }
    if (cBuf.dbTrm.acxChgRecoverArea != 0 &&
        kindOutInfo.typ != 0 &&
        opeSet != 0) {
      await RcAcracb.rcEcsOpeSetGp2Dtl(0);
      opeSet = 0;
    }
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcExecProc in Ky_ChgPick");
    if (rcChkOverFlowPickFlg(OVERFLOW_PICK_NON) == 0) {
      await rcKyChgOverFlowPickPayOutRead();
      await rcEndDifferentChgPick();
    } else {
      await rcEndDifferentChgPick();
    }
  }

  /// 継続出金チェック
  /// 関連tprxソース: rckycpick.c - rcCPick_KindOut_ConChk
  static int rcCPickKindOutConChk(KindPickInfo info) {
    if (info.typ == 0 || info.stat == 2) {
      return 0;
    }

    if (info.nowKind <= info.lastKind ||
        info.nowKind == RcAcracb.COIN_PICKALL ||
        info.resvSht[info.nowKind] > 0 ||
        info.nowKind == RcAcracb.OVERSHT_PICK) {
      return 1;
    }

    return 0;
  }

  /// 機能：払出枚数リード実行
  /// 引数：なし
  /// 戻値：0:OK その他:エラー番号
  /// 関連tprxソース: rckycpick.c - rcKy_Chg_OverFlow_Pick_PayOut_Read
  static Future<int> rcKyChgOverFlowPickPayOutRead() async {
    int ret = 0;
    String log = '';
    String callFunc = 'rcKyChgOverFlowPickPayOutRead';

    ret = IfAcxDef.MSG_ACROK;

    ret = await RcAcracb.rcEcsPayOutReadDtl();

    // 釣銭機の状態設定コマンド送信に失敗した場合
    if (ret != IfAcxDef.MSG_ACROK) {
      log = " $callFunc Error ret = $ret\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);

      if (ret == DlgConfirmMsgKind.MSG_ACRLINEOFF.index) {
        ret = DlgConfirmMsgKind.MSG_ACRLINEOFF.index; // 釣銭機が接続されていません
      } else if (ret == IfAcxDef.MSG_ACRDATAERR) {
        ret = DlgConfirmMsgKind.MSG_DATA_ERROR.dlgId; // データが異常です。
      } else {
        ret = IfAcxDef.MSG_ACRERROR; // 釣銭機が異常です。\nエラーコード確認後、解除操作\nを行って下さい。
      }
      return ret;
    } else {
      log = " $callFunc: PayOut Read\n";
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    }

    return ret;
  }

  /// 関連tprxソース: rckycpick.c - rcEnd_DifferentChgPick
  static Future<int> rcEndDifferentChgPick() async {
    int errNo = Typ.OK;
    int errNo2 = Typ.OK;
    int printFlg = 1;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    AtSingl atSing = SystemFunc.readAtSingl();
    String callFunc = 'rcEndDifferentChgPick';
    AcMem cMem = SystemFunc.readAcMem();

    await rcUpdateDiffChgPick();
    if (cPick.fncCode == FuncKey.KY_CHGPICK.keyId &&
        AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) != 0) {
      cBuf.strclsInfo.cpickAmt = RegsMem().tTtllog.t105100.pickAmt;
      cBuf.strclsInfo.cpickResAmt = resvAmt;
    }

    if ((cPick.fncCode == FuncKey.KY_CHGPICK.keyId) &&
        AplLibAuto.strCls(await RcSysChk.getTid()) != 0) {
      printFlg = await AplLibAuto.strOpnClsSetChk(
          await RcSysChk.getTid(), StrOpnClsCodeList.STRCLS_CPICK_PRINT);
    }

    if (printFlg != 0) {
      errNo = await RcFncChk.rcChkRPrinter();
    }

    if (errNo != Typ.OK) {
      RcIfEvent.rcSendUpdate();
      await rcEndKyChgPick(errNo);
      complete = false;
    } else {
      atSing.rctChkCnt = 0;
      await RcExt.rxChkModeSet(callFunc);

      // TODO:00013 三浦 印字処理の実装必要
      CalcResultChanger retData = await RcClxosChanger.changerPick(cBuf);
      if (printFlg != 0) {
        errNo = retData.retSts!;
      }

      if (errNo != Typ.OK) {
        complete = false;
        await RcExt.rcErr(callFunc, errNo);
      }else{
        // 釣機回収後印字処理
        // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
        await IfTh.printReceipt(await RcSysChk.getTid(), retData.digitalReceipt, callFunc);
      }
      errNo2 = RcIfEvent.rcSendUpdate();
      if (errNo != 0 || errNo2 != 0) {
        await rcEndKyChgPick(errNo);
        await RcExt.rxChkModeReset(callFunc);
        complete = false;
      } else {
        if (printFlg == 0) {
          atSing.noPrintFlg = 1;
        }
        // TODO:00013 三浦 cMem.stat.dspEventMode リセット処理暫定対応 本来はrcWaitResponce内処理
        await RcExt.rxChkModeReset("ChargeCollectController");
        // TODO:00013 三浦 cMem.stat.dspEventMode リセット処理暫定対応 本来はrcWaitResponce内処理
        await rcEndKyChgPick(errNo);

        RckyRpr.rcWaitResponce(cPick.fncCode);
      }
    }
    return errNo;
  }

  /// 関連tprxソース: rckycpick.c - rcUpdate_DiffChgPick
  static Future<void> rcUpdateDiffChgPick() async {
    await rcUpdateDiffChgEdit();
    if (await RcAcracb.rcCheckAcrAcbON(1) != 0) {
      await RcAcracb.rcAcrAcbStockUpdate(1);
    }
  }

  /// 関連tprxソース: rckycpick.c - rcUpdate_DiffChgEdit
  static Future<void> rcUpdateDiffChgEdit() async {
    String log = '';
    int i = 0;
    int cassetFlg = 0;
    T105100Sts stsBk = T105100Sts();
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    stsBk = RegsMem().tTtllog.t105100Sts;

    /*金種別出金カセットのみ回収された場合、rcChk_CassettePick()が0にされるので、状態を保存する*/
    cassetFlg = await rcChkCassettePick();
    if (kindOutInfo.typ != 0 && kindOutInfo.stat == 1) {
      /*金種別出金途中*/
      for (i = ChgInOutDisp.CHGINOUT_Y10000.value;
          i <= ChgInOutDisp.CHGINOUT_Y1.value;
          i++) {
        if (await rcKindOutPrnChk(i, KindOutPrn.KINDOUT_PRN_STAT.index) == 0) {
          /*未出金*/
          cPick.btn[i].cPickCount = 0;
        } else if (i >= ChgInOutDisp.CHGINOUT_Y500.value &&
            i <= ChgInOutDisp.CHGINOUT_Y1.value) {
          cPick.btn[i].cPickCount = kindOutInfo.ttlSht[i];
        }
      }
      await rcCalDifferentCPickTtl(1, cassetFlg);
    }

    RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL); /* Ttl Buffer All Clear */
//	DualT_Single_CshrDspClr();
    RegsMem().tHeader.inout_flg = RcInOut.TTLLOG_PICK_FLAG; /* PICK flag */
    RegsMem().tHeader.prn_typ = PrnterControlTypeIdx.TYPE_CHGPICK.index;

    if (cPick.fncCode == FuncKey.KY_OVERFLOW_PICK.keyId) {
      // TYPE_OVERFLOW_PICKは、紙幣部の印字無し。overflow_pick_flgで条件判定する場合は自動精算釣機回収(オーバーフロー庫搬送)が含まれないように注意
      RegsMem().tHeader.prn_typ = PrnterControlTypeIdx.TYPE_OVERFLOW_PICK.index;
    }

    RegsMem().tTtllog.t105100Sts.kindoutPrnFlg = kindOutInfo.typ;
    await RcRecno.rcSetRctJnlNo();
    await RcSetDate.rcSetDate();

//回収前在高(t100600Sts)
    await RcAcracb.rcAcrAcbBeforeMemorySet(cPickOrg);

//回収実績(t105100)
    RegsMem().tTtllog.t105100.pickCd = cPick.fncCode;
    RegsMem().tTtllog.t105100Sts.chgInoutAmt = cMem.scrData.price;

    if (await rcChkBillUnitDisp() != 0) {
      //紙幣回収枚数セット
      RegsMem().tTtllog.t105100Sts.mny10000Sht =
          cPick.btn[ChgInOutDisp.CHGINOUT_Y10000.value].cPickCount;
      RegsMem().tTtllog.t105100Sts.mny5000Sht =
          cPick.btn[ChgInOutDisp.CHGINOUT_Y5000.value].cPickCount;
      RegsMem().tTtllog.t105100Sts.mny2000Sht =
          cPick.btn[ChgInOutDisp.CHGINOUT_Y2000.value].cPickCount;
      RegsMem().tTtllog.t105100Sts.mny1000Sht =
          cPick.btn[ChgInOutDisp.CHGINOUT_Y1000.value].cPickCount;

      //カセット回収枚数セット
      if (cassetFlg != 0) {
        RegsMem().tTtllog.t105100Sts.mny10000Sht +=
            pCoinData.overflow.bill10000;
        RegsMem().tTtllog.t105100Sts.mny5000Sht += pCoinData.overflow.bill5000;
        RegsMem().tTtllog.t105100Sts.mny2000Sht += pCoinData.overflow.bill2000;
        RegsMem().tTtllog.t105100Sts.mny1000Sht += pCoinData.overflow.bill1000;
      }

      //紙幣残枚数セット
      RegsMem().tTtllog.t105100Sts.resv10000Sht =
          cPick.btn[ChgInOutDisp.CHGINOUT_Y10000.value].acrCount -
              cPick.btn[ChgInOutDisp.CHGINOUT_Y10000.value].cPickCount;
      RegsMem().tTtllog.t105100Sts.resv5000Sht =
          cPick.btn[ChgInOutDisp.CHGINOUT_Y5000.value].acrCount -
              cPick.btn[ChgInOutDisp.CHGINOUT_Y5000.value].cPickCount;
      RegsMem().tTtllog.t105100Sts.resv2000Sht =
          cPick.btn[ChgInOutDisp.CHGINOUT_Y2000.value].acrCount -
              cPick.btn[ChgInOutDisp.CHGINOUT_Y2000.value].cPickCount;
      RegsMem().tTtllog.t105100Sts.resv1000Sht =
          cPick.btn[ChgInOutDisp.CHGINOUT_Y1000.value].acrCount -
              cPick.btn[ChgInOutDisp.CHGINOUT_Y1000.value].cPickCount;
    }

    //硬貨回収枚数セット
    /*金種別出金の対象機種は硬貨のカセットがない為、チェック行わない*/
    RegsMem().tTtllog.t105100Sts.mny500Sht =
        cPick.btn[ChgInOutDisp.CHGINOUT_Y500.value].cPickCount +
            pCoinData.overflow.coin500;
    RegsMem().tTtllog.t105100Sts.mny100Sht =
        cPick.btn[ChgInOutDisp.CHGINOUT_Y100.value].cPickCount +
            pCoinData.overflow.coin100;
    RegsMem().tTtllog.t105100Sts.mny50Sht =
        cPick.btn[ChgInOutDisp.CHGINOUT_Y50.value].cPickCount +
            pCoinData.overflow.coin50;
    RegsMem().tTtllog.t105100Sts.mny10Sht =
        cPick.btn[ChgInOutDisp.CHGINOUT_Y10.value].cPickCount +
            pCoinData.overflow.coin10;
    RegsMem().tTtllog.t105100Sts.mny5Sht =
        cPick.btn[ChgInOutDisp.CHGINOUT_Y5.value].cPickCount +
            pCoinData.overflow.coin5;
    RegsMem().tTtllog.t105100Sts.mny1Sht =
        cPick.btn[ChgInOutDisp.CHGINOUT_Y1.value].cPickCount +
            pCoinData.overflow.coin1;
    //硬貨残枚数セット
    RegsMem().tTtllog.t105100Sts.resv500Sht =
        cPick.btn[ChgInOutDisp.CHGINOUT_Y500.value].acrCount -
            cPick.btn[ChgInOutDisp.CHGINOUT_Y500.value].cPickCount;
    RegsMem().tTtllog.t105100Sts.resv100Sht =
        cPick.btn[ChgInOutDisp.CHGINOUT_Y100.value].acrCount -
            cPick.btn[ChgInOutDisp.CHGINOUT_Y100.value].cPickCount;
    RegsMem().tTtllog.t105100Sts.resv50Sht =
        cPick.btn[ChgInOutDisp.CHGINOUT_Y50.value].acrCount -
            cPick.btn[ChgInOutDisp.CHGINOUT_Y50.value].cPickCount;
    RegsMem().tTtllog.t105100Sts.resv10Sht =
        cPick.btn[ChgInOutDisp.CHGINOUT_Y10.value].acrCount -
            cPick.btn[ChgInOutDisp.CHGINOUT_Y10.value].cPickCount;
    RegsMem().tTtllog.t105100Sts.resv5Sht =
        cPick.btn[ChgInOutDisp.CHGINOUT_Y5.value].acrCount -
            cPick.btn[ChgInOutDisp.CHGINOUT_Y5.value].cPickCount;
    RegsMem().tTtllog.t105100Sts.resv1Sht =
        cPick.btn[ChgInOutDisp.CHGINOUT_Y1.value].acrCount -
            cPick.btn[ChgInOutDisp.CHGINOUT_Y1.value].cPickCount;

    //棒金残枚数セット
    if (await CmCksys.cmAcxChgdrwSystem() != 0) {
      RegsMem().tTtllog.t105100Sts.resvDrw500Sht = pCoinData.drawData.coin500;
      RegsMem().tTtllog.t105100Sts.resvDrw100Sht = pCoinData.drawData.coin100;
      RegsMem().tTtllog.t105100Sts.resvDrw50Sht = pCoinData.drawData.coin50;
      RegsMem().tTtllog.t105100Sts.resvDrw10Sht = pCoinData.drawData.coin10;
      RegsMem().tTtllog.t105100Sts.resvDrw5Sht = pCoinData.drawData.coin5;
      RegsMem().tTtllog.t105100Sts.resvDrw1Sht = pCoinData.drawData.coin1;
    }

    RegsMem().tTtllog.t105100.pickCnt = 1;
    RegsMem().tTtllog.t105100.pickAmt =
        RegsMem().tTtllog.t105100Sts.chgInoutAmt; //回収合計(=釣機回収金額+カセット回収金額)

    if (inOutClose.closePickFlg == 1) {
      //従業員精算
      RegsMem().tTtllog.t105100.closeFlg = 1;
    }

    RegsMem().tTtllog.t105100.sht10000 =
        RegsMem().tTtllog.t105100Sts.mny10000Sht;
    RegsMem().tTtllog.t105100.sht5000 = RegsMem().tTtllog.t105100Sts.mny5000Sht;
    RegsMem().tTtllog.t105100.sht2000 = RegsMem().tTtllog.t105100Sts.mny2000Sht;
    RegsMem().tTtllog.t105100.sht1000 = RegsMem().tTtllog.t105100Sts.mny1000Sht;
    RegsMem().tTtllog.t105100.sht500 = RegsMem().tTtllog.t105100Sts.mny500Sht;
    RegsMem().tTtllog.t105100.sht100 = RegsMem().tTtllog.t105100Sts.mny100Sht;
    RegsMem().tTtllog.t105100.sht50 = RegsMem().tTtllog.t105100Sts.mny50Sht;
    RegsMem().tTtllog.t105100.sht10 = RegsMem().tTtllog.t105100Sts.mny10Sht;
    RegsMem().tTtllog.t105100.sht5 = RegsMem().tTtllog.t105100Sts.mny5Sht;
    RegsMem().tTtllog.t105100.sht1 = RegsMem().tTtllog.t105100Sts.mny1Sht;

    //在高実績
    await Rcinoutdsp.rcInOutDiffAmtSetCmn(-1, koptInOut,
        RegsMem().tTtllog.t105100.pickAmt, 1); //入出金画面メモリを使用せず、金額指定で現金在高実績作成

    RegsMem().tTtllog.t105100Sts.cpickAmt = cPick.total; //釣機回収金額
    RegsMem().tTtllog.t105100Sts.cpickCassette =
        cPick.cassette; //カセット内金額(回収するしないに関わらず)
    RegsMem().tTtllog.t105100Sts.cpickType = btnPressFlg; //回収方法ボタン選択情報

    if (RcRegs.rcInfoMem.rcCnct.cnctAcrCnct == 2) {
      resvAmt += RegsMem().tTtllog.t105100Sts.resv10000Sht * 10000;
      resvAmt += RegsMem().tTtllog.t105100Sts.resv5000Sht * 5000;
      resvAmt += RegsMem().tTtllog.t105100Sts.resv2000Sht * 2000;
      resvAmt += RegsMem().tTtllog.t105100Sts.resv1000Sht * 1000;
    }

    resvAmt += RegsMem().tTtllog.t105100Sts.resv500Sht * 500;
    resvAmt += RegsMem().tTtllog.t105100Sts.resv100Sht * 100;
    resvAmt += RegsMem().tTtllog.t105100Sts.resv50Sht * 50;
    resvAmt += RegsMem().tTtllog.t105100Sts.resv10Sht * 10;
    resvAmt += RegsMem().tTtllog.t105100Sts.resv5Sht * 5;
    resvAmt += RegsMem().tTtllog.t105100Sts.resv1Sht * 1;

    if (await CmCksys.cmAcxChgdrwSystem() != 0) {
      resvDrwAmt += RegsMem().tTtllog.t105100Sts.resvDrw500Sht * 500;
      resvDrwAmt += RegsMem().tTtllog.t105100Sts.resvDrw100Sht * 100;
      resvDrwAmt += RegsMem().tTtllog.t105100Sts.resvDrw50Sht * 50;
      resvDrwAmt += RegsMem().tTtllog.t105100Sts.resvDrw10Sht * 10;
      resvDrwAmt += RegsMem().tTtllog.t105100Sts.resvDrw5Sht * 5;
      resvDrwAmt += RegsMem().tTtllog.t105100Sts.resvDrw1Sht * 1;
    }

    RegsMem().tTtllog.t105100Sts.cpickErrno = stsBk.cpickErrno;
    RegsMem().tTtllog.t105100Sts.kindoutPrnErrno1 = stsBk.kindoutPrnErrno1;
    RegsMem().tTtllog.t105100Sts.kindoutPrnStat1 = stsBk.kindoutPrnStat1;
    RegsMem().tTtllog.t105100Sts.kindoutPrnErrno2 = stsBk.kindoutPrnErrno2;
    RegsMem().tTtllog.t105100Sts.kindoutPrnStat2 = stsBk.kindoutPrnStat2;
    RegsMem().tTtllog.t105100Sts.kindoutPrnErrno3 = stsBk.kindoutPrnErrno3;
    RegsMem().tTtllog.t105100Sts.kindoutPrnStat3 = stsBk.kindoutPrnStat3;
    RegsMem().tTtllog.t105100Sts.kindoutPrnErrno4 = stsBk.kindoutPrnErrno4;
    RegsMem().tTtllog.t105100Sts.kindoutPrnStat4 = stsBk.kindoutPrnStat4;
    RegsMem().tTtllog.t105100Sts.kindoutPrnErrno5 = stsBk.kindoutPrnErrno5;
    RegsMem().tTtllog.t105100Sts.kindoutPrnStat5 = stsBk.kindoutPrnStat5;
    RegsMem().tTtllog.t105100Sts.kindoutPrnErrno6 = stsBk.kindoutPrnErrno6;
    RegsMem().tTtllog.t105100Sts.kindoutPrnStat6 = stsBk.kindoutPrnStat6;
    RegsMem().tTtllog.t105100Sts.kindoutPrnErrno7 = stsBk.kindoutPrnErrno7;
    RegsMem().tTtllog.t105100Sts.kindoutPrnStat7 = stsBk.kindoutPrnStat7;
    RegsMem().tTtllog.t105100Sts.kindoutPrnErrno8 = stsBk.kindoutPrnErrno8;
    RegsMem().tTtllog.t105100Sts.kindoutPrnStat8 = stsBk.kindoutPrnStat8;
    RegsMem().tTtllog.t105100Sts.kindoutPrnErrno9 = stsBk.kindoutPrnErrno9;
    RegsMem().tTtllog.t105100Sts.kindoutPrnStat9 = stsBk.kindoutPrnStat9;
    RegsMem().tTtllog.t105100Sts.kindoutPrnErrno10 = stsBk.kindoutPrnErrno10;
    RegsMem().tTtllog.t105100Sts.kindoutPrnStat10 = stsBk.kindoutPrnStat10;

    //回収方法
    log = "CPickPrint Type [${RegsMem().tTtllog.t105100Sts.cpickType}]\n";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    //釣機回収合計
    log = "CPickPrint Total[${RegsMem().tTtllog.t105100Sts.chgInoutAmt}]\n";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    //回収後釣機合計
    log = "CPickPrint Resv [$resvAmt][$resvDrwAmt]\n";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    //エラー情報
    int err = await rcKindOutPrnChk(
        ChgInOutDisp.CHGINOUT_DIF_MAX.value, KindOutPrn.KINDOUT_PRN_ERR.index);
    log =
        "CPickPrint Err  [$err][${RegsMem().tTtllog.t105100Sts.cpickErrno}]\n";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);

    RegsMem().tTtllog.t105100.pickTyp = 0;
    RegsMem().tTtllog.t105100.opeStaffCd = "${RegsMem().tHeader.cshr_no}";

    if (AplLibAuto.strCls(await RcSysChk.getTid()) != 0) {
      /* 閉店 */
      if (await CmCksys.cmAcxChgdrwSystem() != 0 &&
          cBuf.iniMacInfo.acx_flg.chgdrw_loan_tran == 0) {
        log = "${resvAmt + resvDrwAmt}"; //棒金ドロア金resvDrwAmtを含む
      } else {
        log = "$resvAmt";
      }
      AplLibIniFile.aplLibIniFile(await RcSysChk.getTid(), AplLib.INI_SET, 0,
          "auto_strcls_tran.ini", "autostrl_info", "cls_resvAmt", log);
      if (RegsMem().prnrBuf.opeStaffCd != 0) {
        RegsMem().tTtllog.t105100.opeStaffCd =
            "${RegsMem().prnrBuf.opeStaffCd}";
      }
      RegsMem().tTtllog.t105100.pickTyp = 1;
    }
  }

  /// 関連tprxソース: rckycpick.c - rc_KindOut_Prn_Chk
  static Future<int> rcKindOutPrnChk(int num, int flg) async {
    String log = '';
    int i = 0;
    int startPosi = 0;
    int endPosi = 0;
    int kindOutChk = 0;
    String callFunc = 'rcKindOutPrnChk';

    if (num == ChgInOutDisp.CHGINOUT_DIF_MAX.value) {
      startPosi = ChgInOutDisp.CHGINOUT_Y10000.value;
      endPosi = ChgInOutDisp.CHGINOUT_Y1.value;
    } else {
      startPosi = num;
      endPosi = num;
    }

    for (i = startPosi; i <= endPosi; i++) {
      ChgInOutDisp value = ChgInOutDisp.getDefine(i);
      switch (value) {
        case ChgInOutDisp.CHGINOUT_Y10000:
          if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnErrno1;
          } else {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnStat1;
          }
          break;
        case ChgInOutDisp.CHGINOUT_Y5000:
          if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnErrno2;
          } else {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnStat2;
          }
          break;
        case ChgInOutDisp.CHGINOUT_Y2000:
          if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnErrno3;
          } else {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnStat3;
          }
          break;
        case ChgInOutDisp.CHGINOUT_Y1000:
          if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnErrno4;
          } else {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnStat4;
          }
          break;
        case ChgInOutDisp.CHGINOUT_Y500:
          if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnErrno5;
          } else {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnStat5;
          }
          break;
        case ChgInOutDisp.CHGINOUT_Y100:
          if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnErrno6;
          } else {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnStat6;
          }
          break;
        case ChgInOutDisp.CHGINOUT_Y50:
          if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnErrno7;
          } else {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnStat7;
          }
          break;
        case ChgInOutDisp.CHGINOUT_Y10:
          if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnErrno8;
          } else {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnStat8;
          }
          break;
        case ChgInOutDisp.CHGINOUT_Y5:
          if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnErrno9;
          } else {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnStat9;
          }
          break;
        case ChgInOutDisp.CHGINOUT_Y1:
          if (flg == KindOutPrn.KINDOUT_PRN_ERR.index) {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnErrno10;
          } else {
            kindOutChk = RegsMem().tTtllog.t105100Sts.kindoutPrnStat10;
          }
          break;
        default:
          kindOutChk = 0;
          break;
      }
      if (kindOutChk != 0) {
        log = "$callFunc: flg[$flg] i[$i]";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        break;
      }
    }
    return kindOutChk;
  }

  /// 関連tprxソース: rckycpick.c - rcEnd_Ky_ChgPick
  static Future<void> rcEndKyChgPick(int errNo) async {
    tprDlgParam_t param = tprDlgParam_t();
    String callFunc = 'rcEndKyChgPick';
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;

    if (errNo != Typ.OK) {
      if (AplLibAuto.AplLibAutoGetRunMode(await RcSysChk.getTid()) != 0) {
        RcAuto.rcAutoChkDlg(
            await RcSysChk.getTid(), FuncKey.KY_CHGPICK.keyId, errNo);
      }
      if (TprLibDlg.tprLibDlgCheck2(1) != 0) {
        if (RcFncChk.rcChkErr() != 0) {
          RckyClr.rcClearPopDisplay();
        } else {
          _closeDialogAll();
        }
      }
      param.erCode = errNo;
      param.dialogPtn = DlgPattern.TPRDLG_PT31.dlgPtnId;
      param.msg1 = LTprDlg.BTN_CONTINUE;
      param.msg2 = LTprDlg.BTN_INTERRUPT;
      param.func1 = yesContinue;
      param.func2 = noContinue;
      param.user_code_4 = LRcKyCPick.CPICK_RCPT_STOP;

      if (cMem.stat.dualTSingle == 1) {
        param.dual_dsp = 2;
      }

      RcSet.rcErrStatSet2(callFunc);
      rcCPickDlg(param.erCode, param.dialogPtn, param.func1, param.msg1,
          param.func2, param.msg2, param.func3, param.msg3);

      AplLibAuto.aplLibCMAutoErrMsgSend(await RcSysChk.getTid(), errNo);
      if (await RcSysChk.rcSGChkSelfGateSystem() ||
          await RcSysChk.rcQCChkQcashierSystem()) {
        asstPcLog = tsBuf.managePc.msgLogBuf;
        RcAssistMnt.rcAssistSend(errNo);
      }
      complete = false;
      return;
    }

    await rcEndKyChgPick1();

    await RcRecno.rcIncRctJnlNo(true);
    await RcSet.rcClearDataReg();
    RcStl.rcClrTtlRBuf(ClrTtlRBuf.NCLR_TTLRBUF_ALL); /* Total Reicept Clear */

    if (rcCPickKindOutForceEndChk() == true) {
      /*金種別出金途中強制中止*/
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "KindOut ForceEnd : rcInOut_CloseLine_Update Skip");
    } else if (await rcChkCMAutoPickNotOnce() != 0) {
      //複数可
      //自動精算の釣機回収「(複数可能)」では、最終的に次へで釣機回収が終了するのでここでは、実績上げしない
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "AutoChgPick : strcls_pick=2 rcInOut_CloseLine_Update Skip");
    } else if (inOutClose.closePickFlg == 1) {
      //従業員精算処理中
      //釣機回収「実行」ボタン->締め精算終了
      await Rcinoutdsp.rcInOutCloseLineUpdate(
          callFunc); //区切り線(ope_mode_flg)を実績上げ
      inOutClose = InOutCloseData();
    }

    cMem.postReg = PostReg();
    RcSet.rcErr1timeSet();
    tsBuf.cash.inout_flg = 0;
    cMem.keyStat = RcFncChk.rcKyResetStat(cMem.keyStat, RcRegs.MACRO0);
    if (cMem.keyStat.length >= cPick.fncCode && cPick.fncCode >= 0) {
      RcRegs.kyStR0(cMem.keyStat, cPick.fncCode); /* Reset Bit 0 of KY_OUT? */
    }
    RcRegs.kyStS3(
        cMem.keyStat, FncCode.KY_FNAL.keyId); /* Set   Bit 3 of KY_FNAL */
    await rcEndKyChgPick2();
  }

  /// 関連tprxソース: rckycpick.c - rcEnd_Ky_ChgPick2
  static Future<void> rcEndKyChgPick2() async {
    int result = 0;
    int popTimer = 0;
    String buf = '';
    AcMem cMem = SystemFunc.readAcMem();
    String callFunc = 'rcEndKyChgPick2';
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRetC.object;

    if (RcRegs.ifSave.count != 0) {
      RcRegs.ifSave = IfWaitSave();
    }

    RcGtkTimer.rcGtkTimerRemove();

    if (await RcAcracb.rcCheckAcrAcbON(1) != 0 &&
        await RcSysChk.rcChkAcrAcbForgetChange()) {
      result = RckyccinAcb.rcChkPopWindowChgOutWarn(0);
      if (result != 0) {
        cBuf.kymenuUpFlg = 2;
        popTimer = await RcAcracb.rcAcrAcbPopTimerCalc(result);
        cMem.ent.errNo = RcGtkTimer.rcGtkTimerAdd(popTimer, rcEndKyChgPick2);
        if (cMem.ent.errNo != 0) {
          complete = false;
          await RcExt.rcErr(callFunc, cMem.ent.errNo);
          await RcExt.rxChkModeReset(callFunc);
          if (RcSysChk.rcCheckRegFnal()) {
            await RcSet.cashStatReset2(callFunc);
          }
          cBuf.kymenuUpFlg = 0;
        }
        return;
      }
    }

    await RcExt.rxChkModeReset(callFunc);
    if (RcSysChk.rcCheckRegFnal()) {
      await RcSet.cashStatReset2(callFunc);
      if (await RcSysChk.rcCheckQCJCChecker()) {
        await RcSet.rcClearDualChkReg();
      }
    }
    cBuf.kymenuUpFlg = 0;

    if ((errEnd != 0 ||
            await rcKindOutPrnChk(ChgInOutDisp.CHGINOUT_DIF_MAX.value,
                    KindOutPrn.KINDOUT_PRN_ERR.index) !=
                0) &&
        AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) != 0) {
      if (RcAcracb.rcChkChgStockState() != 0) {
        buf = sprintf(AutoMsg.AUTO_MSG_NG, [1]);
      } else {
        buf = sprintf(AutoMsg.AUTO_MSG_NG, [0]);
      }
      await AplLibAuto.aplLibCmAutoMsgSend(await RcSysChk.getTid(), buf);
    } else {
      await RcAuto.rcAutoResultSend();
    }

    /* 自動開閉設仕様 */
    if (rcCPickKindOutForceEndChk() == true) {
      /*金種別出金途中強制中止*/
      await RcAuto.rcAutoEndFunc2(AutoLibEj.AUTOLIB_EJ_STOP, 0);
      return;
    }

    if (await rcChkCMAutoPickNotOnce() != 0) {
      //複数可
      RcAuto.rcAutoStrOpnClsJudg(); //次のステップへせずに処理を行うことにより、再度釣機回収となる
    } else {
      await RcAuto.rcAutoStrOpnClsNextJudg();
    }

    return;
  }

  /// 金種別出金の途中で中止選択したか確認
  /// 関連tprxソース: rckycpick.c - rcCPick_KindOut_ForceEnd_Chk
  static bool rcCPickKindOutForceEndChk() {
    if (kindOutInfo.typ != 0 && kindOutInfo.stat != 0 && nextFlg == 0) {
      /*金種別出金途中強制中止*/
      return true;
    } else {
      return false;
    }
  }

  /// CM精算の複数可で動作しているか確認
  /// 関連tprxソース: rckycpick.c - rcChk_CMAuto_Pick_NotOnce
  static Future<int> rcChkCMAutoPickNotOnce() async {
    int tmpData = 0;

    if (AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) == 0) {
      //自動精算でない
      return 0; //複数不可
    }

    tmpData = await AplLibAuto.strOpnClsSetChk(
        await RcSysChk.getTid(), StrOpnClsCodeList.STRCLS_CPICK);
    switch (tmpData) {
      case 2: //手動選択(複数可)
      case 4: //する(複数可)
        return 1; //複数可
      default:
        break;
    }

    return 0; //複数不可
  }

  /// 関連tprxソース: rckycpick.c - rcEnd_Ky_ChgPick_1
  static Future<void> rcEndKyChgPick1() async {
    AcMem cMem = SystemFunc.readAcMem();
    String callFunc = 'rcEndKyChgPick1';

    if ((AcxCom.ifAcbSelect() & CoinChanger.SST1) != 0) {
      if (pickMode == ChgPickBtn.ALLBTN_ON.btnType) {
        await rcSstStockFlgClearProc(0);
      } else if (pickMode == ChgPickBtn.BILLBTN_ON.btnType) {
        await rcSstStockFlgClearProc(1);
      } else if (pickMode == ChgPickBtn.COINBTN_ON.btnType) {
        await rcSstStockFlgClearProc(2);
      }
    }

    if (AcxCom.ifAcbSelect() == CoinChanger.SST1 &&
        (rcChkBillClosePick() && cMem.coinData.billrjctOut != 0)) {
      cMem.ent.errNo = DlgConfirmMsgKind
          .MSG_TEXT40.dlgId; //収納庫在高に出金リジェクトを含まないので回収合計には含まれない -> 売上回収必要
      await RcSet.rcErrStatSet2(callFunc);
      await rcChgPickRjctDlg(cMem.ent.errNo);
    } else {
      await rcChgPickDispEnd();
    }
    btnPressFlg = ChgPickBtn.BTN_OFF.btnType;
    pickMode = ChgPickBtn.BTN_OFF.btnType;
  }

  /// 関連tprxソース: rckycpick.c - rcSst_StockFlgClearProc
  static Future<int> rcSstStockFlgClearProc(int clrFlg) async {
    int errNo = 0;
    String log = '';
    String callFunc = 'rcSstStockFlgClearProc';

    log = "$callFunc()";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    errNo = Typ.OK;
    if ((AcxCom.ifAcbSelect() & CoinChanger.SST1) == 0) {
      return 0;
    }

    if (clrFlg == 0) {
      if (await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) {
        await RcAcracb.rcSstStockFlgClearDtl(0);
        errNo = await RcAcracb.rcSstStockFlgClearDtl(1);
      } else {
        errNo = await RcAcracb.rcSstStockFlgClearDtl(0);
      }
    }

    if (clrFlg == 1) {
      if (await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) {
        errNo = await RcAcracb.rcSstStockFlgClearDtl(1);
      }
    } else {
      errNo = await RcAcracb.rcSstStockFlgClearDtl(0);
    }
    return errNo;
  }

  /// 関連tprxソース: rckycpick.c - rcChgPickRjctDlg
  static Future<void> rcChgPickRjctDlg(int erCode) async {
    tprDlgParam_t param = tprDlgParam_t();
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    TprLog()
        .logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal, "rcChgPickRjctDlg\n");

    param.erCode = erCode;
    param.dialogPtn = DlgPattern.TPRDLG_PT13.dlgPtnId;
    param.msg1 = LTprDlg.BTN_CONF;
    param.func1 = cPickConfDlgClicked;

    if (cMem.stat.dualTSingle == 1) {
      param.dual_dsp = 2;
    }

    rcCPickDlg(param.erCode, param.dialogPtn, param.func1, param.msg1,
        param.func2, param.msg2, param.func3, param.msg3);

    if (await RcSysChk.rcSGChkSelfGateSystem() ||
        await RcSysChk.rcQCChkQcashierSystem()) {
      asstPcLog = tsBuf.managePc.msgLogBuf;
      RcAssistMnt.rcAssistSend(erCode);
    }

    AplLibAuto.aplLibCMAutoErrMsgSend(await RcSysChk.getTid(), erCode);
  }

  /// 関連tprxソース: rckycpick.c - cpick_conf_dlg_clicked
  static Future<void> cPickConfDlgClicked() async {
    String callFunc = 'cPickConfDlgClicked';
    TprLog().logAdd(
        Tpraid.TPRAID_CHK, LogLevelDefine.normal, "cpick_conf_dlg_clicked\n");
    _closeDialogAll();
    await RcExt.rcClearErrStat(callFunc);

    if (await RcSysChk.rcSGChkSelfGateSystem() ||
        await RcSysChk.rcQCChkQcashierSystem()) {
      RcSgCom.rcSGManageLogYesNo(RcSgDsp.JDG_CONF);
    }

    await rcChgPickDispEnd();
  }

  /// 関連tprxソース: rckycpick.c - rcChgPickDispEnd
  static Future<void> rcChgPickDispEnd() async {
    Rc28dsp.rc28MainWindowSizeChange(0);

    if (RcRegs.ifSave.count != 0) {
      RcRegs.ifSave = IfWaitSave();
    }

    if (await RcSysChk.rcSGChkSelfGateSystem()) {
      RcAssistMnt.rcAssistSend(39001);
      // gtk_widget_destroy(CPick.window);
      await RcObr.rcScanEnable();
      RcSet.rcSGMntScrMode();
      return;
    }

    if (await RcSysChk.rcQCChkQcashierSystem()) {
      RcAssistMnt.rcAssistSend(39001);

      // if(cPick.window != NULL) {
      // gtk_widget_destroy(cPick.window);
      // cPick.window = NULL;
      // }

      await RcSet.rcQCMenteDspScrMode();
      return;
    }

    switch (await RcSysChk.rcKySelf()) {
      case RcRegs.DESKTOPTYPE:
      case RcRegs.KY_CHECKER:
        await RcSet.rcItmLcdScrMode();
        // gtk_widget_destroy(cPick.window);
        break;
      case RcRegs.KY_DUALCSHR:
        if (await RcSysChk.rcChkDesktopCashier()) {
          await RcSet.rcItmLcdScrMode();
          // gtk_widget_destroy(cPick.window);
        } else {
          await RcStlLcd.rcStlLcdQuit(RegsDef.subttl);
          await RcStlLcd.rcStlLcdScrModeDualCashier();
          // gtk_widget_destroy(cPick.window);
          if (RegsMem().tTtllog.t100001Sts.itemlogCnt == 0) {
            RcStlCal.rcStlInitilaizeBuf();
          }
          RcStlLcd.rcStlLcdDualCashier();
        }
        break;
      case RcRegs.KY_SINGLE:
        if (cPick.nowDisplay == RcInOut.LDISP) {
          await RcSet.rcItmLcdScrMode();
          // gtk_widget_destroy(cPick.window);
        }

        if (FbInit.subinitMainSingleSpecialChk() == true) {
          RcItmDsp.dualTSingleDlgClear();
        }
    }

    if (rcChkOverFlowPickFlg(RcKyCpick.OVERFLOW_PICK_KEY) != 0) {
      await rcKyChgOverFlowPickQuitProc();
      await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_OVERFLOW_PICK.keyId);
    } else if (rcChkOverFlowPickFlg(OVERFLOW_AUTO_STRCLS) != 0) {
      await rcKyChgOverFlowPickQuitProc();
      await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_CHGPICK.keyId);
    } else {
      overflowPickFlg = 0;
      await RcItmDsp.rcInOutTotalDisp(FuncKey.KY_CHGPICK.keyId);
    }
  }

  /// 機能：オーバーフロー回収終了時の処理
  /// 引数：なし
  /// 戻値：0:OK その他:エラー番号
  /// 関連tprxソース: rckycpick.c - rcKy_Chg_OverFlow_Pick_Quit_Proc
  static Future<int> rcKyChgOverFlowPickQuitProc() async {
    int ret = 0;

    /* 設定値を元に戻す */
    ret = await rcKyChgOverFlowPickSettingDataChg(0, envData);
    if (ret == 0) {
      /* 設定書込 */
      ret = await rcKyChgOverFlowPickSettingSet();
      if (ret != 0) {
        return ret;
      }
    }

    overflowPickFlg = 0;

    return 0;
  }

  /// 関連tprxソース: rckycpick.c - Yes_Continue
  static Future<void> yesContinue() async {
    String callFunc = 'yesContinue';

    TprLog().logAdd(
        await RcSysChk.getTid(), LogLevelDefine.normal, "Yes_Continue Clicked");
    RcGtkTimer.rcGtkTimerRemove();
    await RcExt.rxChkModeSet(callFunc);
    _closeDialogAll();
    await RcExt.rcClearErrStat(callFunc);
    // gtk_grab_add(CPick.window);


    RcGtkTimer.rcGtkTimerAdd(50, execPrintChkContinue);
    if (await RcSysChk.rcSGChkSelfGateSystem() ||
        await RcSysChk.rcQCChkQcashierSystem()) {
      RcSgCom.rcSGManageLogYesNo(RcSgDsp.JDG_CONTINUE);
    }
  }

  /// 関連tprxソース: rckycpick.c - No_Continue
  static Future<void> noContinue() async {
    String callFunc = 'noContinue';

    TprLog().logAdd(
        await RcSysChk.getTid(), LogLevelDefine.normal, "No_Continue Clicked");
    errEnd = 1;
    await RcExt.rxChkModeSet(callFunc);
    _closeDialogAll();
    await RcExt.rcClearErrStat(callFunc);
    // gtk_grab_add(CPick.window);
    await rcEndKyChgPick(Typ.OK);
    if (await RcSysChk.rcSGChkSelfGateSystem() ||
        await RcSysChk.rcQCChkQcashierSystem()) {
      RcSgCom.rcSGManageLogYesNo(RcSgDsp.JDG_INTERRUPT);
    }
  }

  /// 関連tprxソース: rckycpick.c - ExecPrintChkContinue
  static Future<int> execPrintChkContinue() async {
    int errNo;
    String callFunc = 'execPrintChkContinue';
    AtSingl atSing = SystemFunc.readAtSingl();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    RcGtkTimer.rcGtkTimerRemove();
    errNo = await RcFncChk.rcChkRPrinter();
    if (errNo != Typ.OK) {
      await rcEndKyChgPick(errNo);
      complete = false;
    } else {
      atSing.rctChkCnt = 0;
      CalcResultChanger retData = await RcClxosChanger.changerPick(cBuf);
      errNo = retData.retSts!;
      if (errNo != 0) {
        await rcEndKyChgPick(errNo);
        complete = false;
      } else {
        // 釣機回収後印字処理
        // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
        await IfTh.printReceipt(await RcSysChk.getTid(), retData.digitalReceipt, callFunc);

        // TODO:00013 三浦 cMem.stat.dspEventMode リセット処理暫定対応 本来はrcWaitResponce内処理
        await RcExt.rxChkModeReset("ChargeCollectController");
        // TODO:00013 三浦 cMem.stat.dspEventMode リセット処理暫定対応 本来はrcWaitResponce内処理
        await rcEndKyChgPick(errNo);

        RckyRpr.rcWaitResponce(cPick.fncCode);
      }
    }
    return 0;
  }

  /// 関連tprxソース: rckycpick.c - CPickEnd_Dialog
  static Future<int> cPickEndDialog(int pickResWaitFlg) async {
    int acbSelect = 0;
    int ssw503 = 0;
    String tmpBuf = '';
    String iniName = '';
    tprDlgParam_t param = tprDlgParam_t();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    acbSelect = AcxCom.ifAcbSelect();
    iniName = "${EnvironmentData().sysHomeDir}/conf/mac_info.ini";
    JsonRet ret = await getJsonValue(iniName, "acx_flg", "acb50_ssw50_3");
    if (ret.result) {
      String tmpBuf = '';
    }
    ssw503 = int.tryParse(tmpBuf) ?? 0;

    param.msgBuf = "\x00";
    param.erCode = -1; //非利用
    param.dialogPtn = DlgPattern.TPRDLG_PT10.dlgPtnId;
    param.title = "";
    param.userCode = 0;
    param.user_code_2 = "0";

    if (pickResWaitFlg == 1) {
      if ((acbSelect & CoinChanger.SST1) != 0 ||
          (acbSelect & CoinChanger.FAL2) != 0 ||
          (tsBuf.acx.pickStatus[0] ==
              IfSuica.SUB.toString()) || /* SUB = 1A(回収動作中) */
          (tsBuf.acx.pickStatus[0] == "\x00")) {
        /* 回収レスポンス待ちのENQが3秒間隔なのでまだ取得していない状態 */
        if ((acbSelect & CoinChanger.ACB_20_X) != 0 && ssw503 == 0) {
          //硬貨抜き取り待ちを意味するキャラクタが動作中と同じSUB
          param.user_code_3 = LRcKyCPick.CPICKEND_WARN2;
        } else {
          param.user_code_3 = LRcKyCPick.CPICKEND_WAIT;
        }
      } else {
        param.user_code_3 = LRcKyCPick.CPICKEND_WARN2;
      }
    } else {
      param.user_code_3 = LRcKyCPick.CPICKEND_WARN2;
    }

    if (kindOutInfo.typ != 0) {
      if (param.user_code_3 == LRcKyCPick.CPICKEND_WARN2) {
        param.user_code_3 = LRcKyCPick.CPICKEND_WARN3;
      }
      param.user_code_2 = kindOutInfo.kindMsg;
    }

    MsgDialog.show(
      MsgDialog.noButtonDlgId(
        dialogId: param.dialogPtn,
        type: MsgDialogType.info,
        footerMessage: param.user_code_3,
      ),
    );

    if (cMem.scrData.price != 0) {
      await AplLibAuto.aplLibCmAutoMsgSend(
          await RcSysChk.getTid(), AutoMsg.AUTO_MSG_OPERAT);
    }

    if (await RcSysChk.rcSGChkSelfGateSystem() ||
        await RcSysChk.rcQCChkQcashierSystem()) {
      return 0;
    }

    if (FbInit.subinitMainSingleSpecialChk() == true) {
      param.dual_dsp = 3;
      MsgDialog.show(
        MsgDialog.noButtonDlgId(
          dialogId: param.dialogPtn,
          type: MsgDialogType.info,
          footerMessage: param.user_code_3,
        ),
      );
    }
    return 0;
  }

  /// 関連tprxソース: rckycpick.c - CPickContinue_Dialog
  static Future<int> cPickContinueDialog() async {
    tprDlgParam_t param = tprDlgParam_t();
    AcMem cMem = SystemFunc.readAcMem();

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "ChgPick : CPickContinue_Dialog");

    param.msgBuf = "\x00";
    param.erCode = -1; //非利用
    param.dialogPtn = DlgPattern.TPRDLG_PT21.dlgPtnId;
    param.title = "";
    param.userCode = 0;
    param.user_code_2 = "0";
    param.user_code_3 = LRcKyCPick.CPICK_CASET_FULL_DLG;
    param.func1 = cPickContinue;
    param.msg1 = LRcKyCPick.CPICK_CASET_FULL_CONTINUE;
    param.func2 = cPickStop;
    param.msg2 = LRcKyCPick.CPICK_CASET_FULL_END;

    // TprLibDlgSetBtnStyle( &param.btnStyle[1], Yellow, BlackGray, DLG_DEFAULT, DLG_DEFAULT );

    if (cMem.stat.dualTSingle == 1) {
      param.dual_dsp = 2;
    }

    rcCPickDlg(param.erCode, param.dialogPtn, param.func1, param.msg1,
        param.func2, param.msg2, param.func3, param.msg3);

    return 0;
  }

  /// 関連tprxソース: rckycpick.c - CPick_Continue
  static Future<void> cPickContinue() async {
    int billMode = 0;
    int coinMode = 0;
    int pickWaitFlg = 0;
    int pickCaset = 0;
    CBillKind cPickSht = CBillKind();
    String callFunc = 'cPickContinue';
    AcMem cMem = SystemFunc.readAcMem();

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "ChgPick : Continue Btn Push");
    _closeDialogAll();
    cMem.ent.errNo = await RcAcracb.rcAcrAcbAnswerReadDtl();

    if (cMem.ent.errNo != 0) {
      await cPickContinueDialog();
      complete = false;
      return;
    }

    if (kindOutInfo.typ != 0) {
      kindOutInfo = bkKindOutInfo;
    }

    RegsMem().tTtllog.t105100Sts.cpickErrno = 0;
    cPickErrno = 0;

    if (pickMode == ChgPickBtn.RESERVEBTN_ON.btnType) {
      await rcChgPickReserveProc();
      (billMode, coinMode, pickWaitFlg, pickCaset) = await rcChgPickPickModeSet(
          billMode, coinMode, pickWaitFlg, pickCaset);
      cPickSht = await rcCPickCntMake(billMode, coinMode, cPickSht);
      cPickData = rcAcrAcbPIckDataSet(cPickData, cPickSht, billMode, coinMode, pickWaitFlg);
    }
    await rcExecFuncMain2();
  }

  /// 関連tprxソース: rckycpick.c - CPick_Stop
  static Future<void> cPickStop() async {
    String callFunc = 'cPickStop';

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "ChgPick : Stop Btn Push");
    _closeDialogAll();
    rcExecProc();
  }

  /// 関連tprxソース: rckycpick.c - rcCPick_LackSht_PrintDlg
  static Future<void> rcCPickLackShtPrintDlg(int errNo) async {
    RcMemDlgParam	cPickAplDlg = RcMemDlgParam();
    String buf = '';
    String msgBuf = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "rcCPick_LackSht_PrintDlg");

    // TODO:10164 自動閉設 UI系の為、コメントアウト
  // rc_28dsp_Mkey_Flg_Set(-1, MKEY_NOTSHOW);	// ソフトテンキー状態を保存し、非表示にする

  cPickAplDlg.erCode    = errNo;
  cPickAplDlg.dialogPtn = 1;

  if(errNo == DlgConfirmMsgKind.MSG_CPICK_DRW_OVER.dlgId){
    AplLibImgRead.aplLibImgRead(FuncKey.KY_CHGDRW.keyId);
    // TODO:10164 自動閉設 TprLibMsgGetの実装検討中の為、コメントアウト
  // snprintf(msgBuf, sizeof(msgBuf), TprLibMsgGet(errNo), buf);
  cPickAplDlg.mesgInfo.msg = msgBuf;
  cPickAplDlg.mesgInfo.msg = LRcKyCPick.CPICK_RESERV_PRINT;
  }else{
    // TODO:10164 自動閉設 TprLibMsgGetの実装検討中の為、コメントアウト
  // cPickAplDlg.mesgInfo.msg = TprLibMsgGet(errNo);
  cPickAplDlg.mesgInfo.msg = LRcKyCPick.CPICK_RESERV_PRINT;
  }
  cPickAplDlg.titlInfo.titleColor = "YE";
  cPickAplDlg.titlInfo.charColor = "BG";

  //cPickAplDlg.confInfo.func = rcCPick_LackSht_PrintBtn;
  cPickAplDlg.confInfo.msg = LTprDlg.BTN_YES;
  cPickAplDlg.confInfo.btnColor = "TB";
  cPickAplDlg.confInfo.charColor = "WH";
  cPickAplDlg.confInfo.btnSiz = 1;

  //cPickAplDlg.confInfo.func = rcCPick_LackSht_NoBtn;
  cPickAplDlg.confInfo.msg = LTprDlg.BTN_NO;
  cPickAplDlg.confInfo.btnColor = "TB";
  cPickAplDlg.confInfo.charColor = "WH";

  cPickAplDlg.opsFlg = 1;	//タワー表示で「只今処理中」表示を出さないようにするため

  cBuf.devId = cPickWinDispTyp;	// 画面描画した際に確保した表示側をセット

  //rcAplDlg(&cPickAplDlg);
    return;
  }

  /// 関連tprxソース: rckycpick.c - rcExecFunc
  static Future<void> rcExecFunc() async {
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();

    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        "rcExecFunc in Ky_ChgPick");

    if (cMem.stat.dspEventMode == 100) {
      return;
    }

    if (await rcCpickAutoFlgChk() == 1) {
      return;
    }

    if (kindOutInfo.typ != 0 && (kindOutInfo.stat == 2)) {
      /*自動精算最終金種出金エラー戻し入れ処理で「閉じる」押下後*/
      return;
    }

    if (await RcSysChk.rcSGChkSelfGateSystem() ||
        await RcSysChk.rcQCChkQcashierSystem()) {
      log = Rcinoutdsp.EXEC_LABEL;
      RcSgCom.mngPcLog = RcSgCom.mngPcLog + log;
      RcSgCom.rcSGManageLogButton();
      RcSgCom.rcSGManageLogSend(SgDsp.REG_LOG);
      RcAssistMnt.rcAssistSend(23062);
    }

    if (Rcinoutdsp.rcNoStaffGetSet(0, 0) != 0) {
      Rcinoutdsp.rcNoStaffGetSet(1, 0);
      cMem.staffInfo!.entFlg =
          ((int.tryParse(cMem.staffInfo!.entFlg) ?? 0) & ~0x04).toString();
    }

    if (await Rcinoutdsp.rcInOutStaffEntChk() != 0) {
      await Rcinoutdsp.rcAutoExec(rcQuitMain, rckyPickExecFuncMain);
    } else {
      await rckyPickExecFuncMain();
    }
  }

  /// 関連tprxソース: rckycpick.c - rcExecFunc_Main_
  static Future<void> rckyPickExecFuncMain() async {
    if (await rcCPickUnitShtKindChk(kindOutInfo) != 0) {
      _closeDialogAll();
      await rcCPickKindOutConfDlg(kindOutInfo, rcExecFuncMain);
    } else {
      await rcExecFuncMain();
    }
  }

  /// 関連tprxソース: rckycpick.c - rcCpick_AutoFlg_Chk
  static Future<int> rcCpickAutoFlgChk() async {
    if (cPick.fncCode == FuncKey.KY_CHGPICK.keyId &&
        await RcFncChk.rcCheckChgInOutMode() &&
        AplLibAuto.aplLibCMAutoMsgSendChk(await RcSysChk.getTid()) != 0) {
      return autoFlg;
    }
    return 0;
  }

  /// 表示しているダイアログを全て閉じる
  static void _closeDialogAll() {
    while (Get.isDialogOpen == true) {
      Get.until((route) =>
      route.settings.name == '/ChargeCollectScreen');
    }
  }

  /// KY_CHGPICK Management Functions
  /// 関連tprxソース: rckycpick.c - rcEdit_KeyData
  static Future<void> rcEditKeyData() async {
    AcMem cMem = SystemFunc.readAcMem();
    cPick.fncCode = cMem.stat.fncCode;
  }
}
