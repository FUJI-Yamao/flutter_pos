/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:typed_data';

import 'package:flutter_pos/app/inc/lib/mcd.dart';
import 'package:flutter_pos/app/inc/lib/typ.dart';
import 'package:flutter_pos/app/lib/apllib/competition_ini.dart';
import 'package:flutter_pos/app/lib/cm_ary/chk_spc.dart';
import 'package:flutter_pos/app/lib/cm_bcd/chk_z0.dart';
import 'package:flutter_pos/app/lib/cm_chg/asctobcd.dart';
import 'package:flutter_pos/app/lib/cm_chg/bcdtoa.dart';
import 'package:flutter_pos/app/lib/cm_chg/bcdtol.dart';
import 'package:flutter_pos/app/lib/cm_chg/ltobcd.dart';
import 'package:flutter_pos/app/lib/cm_chg/sup_asc.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../common/rxcrdtcom.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_mem.dart';
import 'rc28stlinfo.dart';
import 'rc_crdt_fnc.dart';
import 'rccrdtdsp.dart';
import '../../fb/fb2gtk.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_log.dart';
import '../common/rx_log_calc.dart';
import '../inc/rc_regs.dart';
import 'rc_acracb.dart';
import 'rc_barcode_pay.dart';
import 'rc_ext.dart';
import 'rc_flrd.dart';
import 'rc_gtktimer.dart';
import 'rc_ifevent.dart';
import 'rc_masr.dart';
import 'rc_mbr_com.dart';
import 'rc_mcd.dart';
import 'rc_set.dart';
import 'rc_touch_key.dart';
import 'rccardcrew.dart';
import 'rcfncchk.dart';
import 'rcky_rfdopr.dart';
import 'rckyccin.dart';
import 'rcsyschk.dart';

///  関連tprxソース: rckycrdtin.c
class RckyCrdtIn {
  static const NTT_ENCRYPT = (true && (!CompileFlag.FELICA_SMT));

  static int crdtinTimer = 0;

  /// 関連tprxソース: rckycrdtin.c - rcKyCrdtIn
  static Future<void> rcKyCrdtIn() async {
    int startStep = 0;
    int orgcode = 0;
    int errNo = 0;
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    startStep = cMem.working.crdtReg.step;
    orgcode = cMem.stat.orgCode;

    errNo = 0;

    if (RcSysChk.rcChkMultiVegaSystem() != 0) {
      if (crdtinTimer != 0) {
        log = "rcKyCrdtIn() gtk_timeout_remove crdtin_timer : $crdtinTimer\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        Fb2Gtk.gtkTimeoutRemove(crdtinTimer);
        crdtinTimer = 0;
      }

      // TODO:10166 クレジット決済 20241004実装対象外
      // if (AT_SING->multi_vega_wait_flg == 1)  /* 処理中です画面を表示させる場合 */
      //  {
      //    if (rcsyschk_happy_smile())
      //    {       // 客側で選択へ変更する
      //          TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcKyCrdtIn() -> call rcQC_Btn_CrdtSelect_Proc()\n");
      //          rcQC_Btn_CrdtSelect_Proc(NULL, NULL);
      //          return;
      //    }
      //
      //    if (cm_tb1_system())
      //    {       // 特定交通系1仕様はiniの値
      //             nimoca_aplchg_wait3 = rcMultiNimoca_AplChgWait(3);
      //    }
      //    else
      //    {
      //             nimoca_aplchg_wait3 = 6;
      //    }
      //
      //    if(nimoca_aplchg_wait3 > 0)
      //    {
      //       crdtin_timer = gtk_timeout_add(nimoca_aplchg_wait3 * 1000, (GtkFunction)rcKyCrdtIn, 0);
      //       if ( crdtin_timer > 0 )
      //      {
      //         sprintf(log, "rcKyCrdtIn() gtk_timeout_add OK crdtin_timer : %d\n", crdtin_timer);
      //         TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
      //         rxChkModeSet();
      //         AT_SING->multi_vega_wait_flg = 2;
      //         rcErrNoBz(MSG_PROCESS_WAITING);
      //       }
      //       else
      //       {
      //         sprintf(log, "rcKyCrdtIn() gtk_timeout_add NG crdtin_timer : %d\n", crdtin_timer);
      //         TprLibLogWrite(GetTid(), TPRLOG_ERROR, -1, log);
      //         crdtin_timer = 0;
      //         rcErr(MSG_SYSERR);
      //         if ( rcsyschk_happy_smile() )
      //         {
      //                 rc_fself_subttl_redisp();
      //         }
      //      }
      //    }
      //    else
      //    {
      //      sprintf(log, "rcKyCrdtIn() crdtin_timer non wait");
      //      TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
      //
      //      AT_SING->multi_vega_wait_flg = 0;
      //      rcKyCrdtIn();
      //    }
      //
      //    return;
      //  }
      //  else if (AT_SING->multi_vega_wait_flg)
      //  {
      //     sprintf(log, "rcKyCrdtIn() reset AT_SING->multi_vega_wait_flg crdtin_timer : %d\n", crdtin_timer);
      //     TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, log);
      //     crdtin_timer = 0;
      //     AT_SING->multi_vega_wait_flg = 0;
      //     rcClear_PopDisplay();
      //     rcClearErr_Stat();
      //     rxChkModeSaveReset();
      //     //rc_WaitSaveTch();
      //     rc_WaitSave();
      //     if (IF_SAVE->count)
      //     {
      //           memset((char *)IF_SAVE, 0, sizeof(IF_SAVE));
      //     }
      //  }
    }

    // TODO:10166 クレジット決済 20241004実装対象外
    // if((cm_nimoca_point_system()) && (MEM->tTtllog.t100700.mbr_input == MBRPRC_KEY_INPUT) && (CMEM->working.crdt_reg.step == NIMOCA_RD)) {
    //   CMEM->working.crdt_reg.step = INPUT_1ST;
    // }
    // #if 0
    // if( rcChk_VEGA_Process()
    // && ((CMEM->jis2_tmp_buf[0] != 0) || (CMEM->jis1_tmp_buf[0] != 0)) )
    // {
    // /* VEGA3000接続の場合、クレジット1度読み非対応の為クリアする*/
    // rc_Mcd_Tmp_Buf_Clear();
    // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "rcKyCrdtIn() CMEM->jis1_tmp_buf, jis2_tmp_buf clear !!\n");
    // }
    // #endif

    cMem.ent.errNo = await rcChkKyCrdtIn(0);
    if (!(cMem.ent.errNo != 0)) {
      if (!await RcSysChk.rcQCChkQcashierSystem()) {
        // Qcashierの場合は、カードを読み込むタイミングが違う為
        // TODO:10166 クレジット決済 20241004実装対象外
        // if((cm_nimoca_point_system())
        //     && ((cm_Suica_system()) || (rcChk_MultiVega_PayMethod(FCL_SUIC))))
        // {
        //   if((MEM->tTtllog.t100700.mbr_input == MBRPRC_KEY_INPUT) && ((start_step == INPUT_1ST)) && (CMEM->working.crdt_reg.step == INPUT_1ST)) {
        //     if(rcChk_MultiVega_PayMethod(FCL_SUIC))
        //     {
        //       AT_SING->spvt_data.Fnc_Code = CMEM->stat.FncCode;
        //       rcMultiNimoca_ReadMainProc();
        //     }
        //     else
        //     {
        //       rcSuica_Read_MainProc();
        //     }
        //       return;
        //     }
        //     else if(start_step == NIMOCA_RD) {
        //       start_step = INPUT_1ST;
        //     }
        // }
      }

      if (FbInit.subinitMainSingleSpecialChk()) {
        // TODO:10166 クレジット決済 20241004実装対象外
        // if((CMEM->working.crdt_reg.step == 0) && (CMEM->stat.OrgCode != KEY_BREAK1)) {
        //   if(rcSG_Chk_SelfGate_System())
        //     CMEM->stat.DualT_Single = 1;
        //   else {
        //      if(CMEM->working.crdt_reg.kasumi_inpflg == 0)
        //        CMEM->stat.DualT_Single = C_BUF->dev_id;
        //   }
        // }
      } else {
        cMem.stat.dualTSingle = 0;
      }
      await rcPrgKyCrdtIn();
      await rcEndKyCrdtIn();

      // TODO:10166 クレジット決済 20241004実装対象外
      // #if !MC_SYSTEM && SAPPORO
      // /* Rainbow Card仕様 */
      // if((cm_RainbowCard_system()) && (! rcChk_Crdt_Cancel()) && (start_step == INPUT_1ST) && (CMEM->working.crdt_reg.step == CARD_KIND) && ((MEM->tTtllog.t100700.mbr_input == SAPPORO_PANA_INPUT) || (MEM->tTtllog.t100700.mbr_input == MAGCARD_INPUT && (rcChk_Custreal_UID_System()))) && ((TS_BUF->rwc.rainbow_panadata.typ == 1) || (TS_BUF->rwc.rainbow_panadata.typ == 3)) && (TS_BUF->rwc.rainbow_panadata.jis2[0] != 0) && (! cm_CAPS_PQVIC_system())) {
      //   rcCardCrew_Mcd_NoScan(TS_BUF->rwc.rainbow_panadata.jis2);
      // }
      // else
      // #endif
      // if((cm_ichiyama_mart_system()) && (! rcChk_Crdt_Cancel()) && (start_step == INPUT_1ST) && (CMEM->working.crdt_reg.step == CARD_KIND) && (MEM->tTtllog.t100700.mbr_input == MAGCARD_INPUT) && (! cm_dummy_crdt_system())) {
      //   if(CMEM->jis2_tmp_buf[0] != 0)
      //     rcCardCrew_Mcd_NoScan(CMEM->jis2_tmp_buf);
      //   else if(CMEM->jis1_tmp_buf[0] != 0)
      //     rcCardCrew_Mcd_NoScanjis1(CMEM->jis1_tmp_buf);
      // }
    }
    if (cMem.ent.errNo == DlgConfirmMsgKind.MSG_NONPRESET.dlgId) {
      /* 5.7Inchでボタンがない所を押された時にエラーを出さない為 */
      cMem.ent.errNo = Typ.FALSE;
    }

    if (((CompileFlag.DEPARTMENT_STORE) &&
            ((cMem.stat.fncCode == FuncKey.KY_CRDTIN.keyId) ||
                (cMem.stat.fncCode == FuncKey.KY_HCRDTIN.keyId))) ||
        ((!CompileFlag.DEPARTMENT_STORE) &&
            (cMem.stat.fncCode == FuncKey.KY_CRDTIN.keyId))) {
      if (!(cMem.ent.errNo != 0)) {
        RcKyccin.rcOthConnectAcrAcbStop();
      }
      cMem.stat.fncCode = 0;
    }
    if (cMem.ent.errNo != 0) {
      if (!RcCrdt.CHK_DEVICE_MCD()) {
        if ((RcSysChk.rcChkTpointSystem() != 0) &&
            (cMem.ent.errNo == DlgConfirmMsgKind.MSG_PNTERR_AUTOSPCNCL.dlgId)) {
          // TODO:10166 クレジット決済 20241004実装対象外 アークス様向けには不要のためコメントアウト
          // rxChkModeSet();
          // rcrealsvr2_Tpoint_Err_SpCncl ();
          // MEM->tTtllog.t100710.t_pts_flg = 2;
          // TprLibLogWrite (GetTid (), TPRLOG_NORMAL, 0, "rcChk_Tpoint_System Add error \n");
        } else {
          await RcExt.rcErr('rcKyCrdtIn', cMem.ent.errNo);
          if (await RcSysChk.rcSysChkHappySmile()) {
            await Rc28StlInfo.rcFselfSubttlRedisp();
          }
        }
      }
    }
    // TODO:10032 コンパイルスイッチ(MC_SYSTEM)
    // #if MC_SYSTEM
    //   else if((rcChk_Mc_Izumi_System()) && (CMEM->working.crdt_reg.step == PLES_CARD) && (MEM->tTtllog.t100700.mbr_input == MAGCARD_INPUT) && (MEM->tmpbuf.mcarddata.mc_addr[0] != 0))
    //   {
    //   /* 会員呼出時にイズミカードをスキャンしているためカードスキャンはスキップする */
    //
    //     cm_mov(CMEM->working.crdt_reg.jis2, MEM->tmpbuf.mcarddata.mc_addr, sizeof(CMEM->working.crdt_reg.jis2));
    //     AT_SING->inputbuf.dev = D_MCD2;
    //
    //     rcKyCrdtIn();
    //   }
    // #else
    //   else if( rcChk_CAPS_CAFIS_System() && cm_dcmpoint_system() && (! rcChk_Crdt_Cancel()) && (start_step == INPUT_1ST) && (CMEM->working.crdt_reg.step == CARD_KIND) )
    //     rcCAPS_CAFIS_Mcd_NoScan();
    //   else if((cm_RainbowCard_system()) && (cm_CAPS_PQVIC_system()) && (! rcChk_Crdt_Cancel()) && (start_step == INPUT_1ST) && (CMEM->working.crdt_reg.step == CARD_KIND) && ((MEM->tTtllog.t100700.mbr_input == SAPPORO_PANA_INPUT) || (MEM->tTtllog.t100700.mbr_input == MAGCARD_INPUT && (rcChk_Custreal_UID_System()))) && ((TS_BUF->rwc.rainbow_panadata.typ == 1) || (TS_BUF->rwc.rainbow_panadata.typ == 3)) && (TS_BUF->rwc.rainbow_panadata.jis2[0] != 0)) {
    //     rcCapsPQvic_Mcd_NoScan(TS_BUF->rwc.rainbow_panadata.jis2);
    //   }
    else {
      if (await CmCksys.cmNttaspSystem() != 0) {
        if (RcSysChk.rcChkRalseCardSystem()) {
          /* カードスキャンをスキップする */
          if (await RcCrdtFnc.rcNttCheckHouseStatus()) {
            if (orgcode != RcCrdt.KEY_BREAK1) {
              KyCrdtInStep define =
                  KyCrdtInStep.getDefine(cMem.working.crdtReg.step);
              switch (define) {
                case KyCrdtInStep.CARD_KIND:
                  RcSet.rcClearEntry();
                  String bcd = Ltobcd.cmLtobcd(2, cMem.ent.entry.length);
                  for (int i = 0; i < cMem.ent.entry.length; i++) {
                    // 文字列bcdを文字コードに変換して代入
                    cMem.ent.entry[i] = bcd.codeUnits[i];
                  }
                  await TchKeyDispatch.rcPre104CrdtProc(RcCrdt.KEY_INPUT1);
                  break;
                case KyCrdtInStep.PLES_CARD:
                  RcSet.rcClearEntry();
                  cMem.ent.tencnt = RegsMem().tTtllog.t100700.magMbrCd.length;
                  cMem.ent.entry =
                      AscToBcd.cmAscTobcd(RegsMem().tTtllog.t100700.magMbrCd);
                  await TchKeyDispatch.rcPre104CrdtProc(RcCrdt.KEY_INPUT1);
                  break;
                case KyCrdtInStep.GOOD_THRU:
                  RcSet.rcClearEntry();
                  String bcd = Ltobcd.cmLtobcd(9999, cMem.ent.entry.length);
                  for (int i = 0; i < cMem.ent.entry.length; i++) {
                    // 文字列bcdを文字コードに変換して代入
                    cMem.ent.entry[i] = bcd.codeUnits[i];
                  }
                  await TchKeyDispatch.rcPre104CrdtProc(RcCrdt.KEY_INPUT1);
                  break;
                default:
                  break;
              }
            }
          } else {
            // TODO:10166 クレジット決済 20241004実装対象外
            // if((CMEM->working.crdt_reg.step == CARD_KIND) && (orgcode != KEY_BREAK1)) {
            //   cm_clr((char *)&AT_SING->inputbuf, sizeof(AT_SING->inputbuf));
            //   AT_SING->inputbuf.dev = D_MCD2;
            //   AT_SING->inputbuf.Acode[0] = 0x7F;
            //   cm_mov((char *)&AT_SING->inputbuf.Acode[1],
            //   (char *)&MEM->tmpbuf.rcarddata.jis2, sizeof(MEM->tmpbuf.rcarddata.jis2));
            //   cm_mov(CMEM->working.crdt_reg.jis1, MEM->tmpbuf.rcarddata.jis1,
            //   sizeof(CMEM->working.crdt_reg.jis1));
            //   rcD_Mcd();
            // }
          }
        }
        // TODO:10166 クレジット決済 20241004実装対象外
        // if((cm_ichiyama_mart_system()) && (MEM->tTtllog.t100700.mbr_input == MAGCARD_INPUT) && (cm_dummy_crdt_system())) {
        //   if((CMEM->working.crdt_reg.step == CARD_KIND) && (orgcode != KEY_BREAK1)) {
        //     cm_clr((char *)&AT_SING->inputbuf, sizeof(AT_SING->inputbuf));
        //     AT_SING->inputbuf.dev = D_MCD2;
        //     if(CMEM->jis2_tmp_buf[0] != 0){
        //     AT_SING->inputbuf.Acode[0] = 0x7F;
        //     cm_mov((char *)&AT_SING->inputbuf.Acode[1],
        //     (char *)&CMEM->jis2_tmp_buf, sizeof(CMEM->jis2_tmp_buf));
        //     }
        //     if(CMEM->jis2_tmp_buf[0] != 0)
        //     rcD_Mcd();
        //   }
        // }
      }
    }
    // TODO:10166 クレジット決済 20241004実装対象外
    // if((rcChk_Crdt_User() == KASUMI_CRDT) && (rcQC_Check_CrdtUse_Mode())) {
    //   if(CMEM->ent.err_no)
    //     AT_SING->crdt_mismsg_cnt = 0;
    //   else if((CMEM->working.crdt_reg.card_div == '1') && (AT_SING->crdt_mismsg_cnt == QC_CRDTMSG_STAFFCALL)){
    //     rcQC_Staff_Dsp_AutoSelect();
    //     rc_Assist_Send(35022);
    //     rc_Assist_Send(MSG_TEXT140);
    //   }
    // }
    if ((await RcSysChk.rcChkVegaProcess()) &&
        (!(cMem.ent.errNo != 0)) &&
        (orgcode != RcCrdt.KEY_BREAK1) &&
        (((!await RcCrdtFnc.rcChkCrdtCancel()) &&
                (startStep == KyCrdtInStep.INPUT_1ST.cd)) ||
            ((await RcCrdtFnc.rcChkCrdtCancel()) &&
                (startStep == KyCrdtInStep.RECEIT_NO.cd)))) {
      /* キャンセルフラグをリセットする */
      cBuf.vega3000Conf.vega3000CancelFlg = 0;

      /* 問合せ中ダイアログを表示し、決済端末へコマンド送信 */
      if (!await RcSysChk.rcQCChkQcashierSystem()) {
        RcCrdtDsp.rcCrdtInquDisp();
      }
      errNo = await RcCardCrew.rcCardCrewInquWtxt(RcCrdt.CARD_REQ);
      if (errNo == Typ.OK) {
        // todo クレ宣言　暫定対応6 rcGtkTimerAddが実装されていないため
        // errNo = RcGtkTimer.rcGtkTimerAdd(300, RcCardCrew.rcCardCrewInquCard);
        errNo = await RcCardCrew.rcCardCrewInquCard();
        if (errNo != Typ.OK) {
          await RcMcd.rcCardCrewVegaError(errNo);
        }
      } else {
        await RcMcd.rcCardCrewVegaError(errNo);
      }
    }
  }

  /// キーステータスのチェック関数
  /// 引数：int chkCtrlFlg
  ///      0以外で特定のチェック処理を除外する
  ///      除外対象はチェックではない箇所（実績等メモリ作成部分）や
  ///      通信関連、周辺機へのアクション等時間を要するもの
  ///      0:標準のキー押下時のチェック  0以外:キー押下前の動作可能かのチェック
  /// 戻値：errNo エラー番号
  /// 関連tprxソース: rckycrdtin.c - rcChk_Ky_CrdtIn
  static Future<int> rcChkKyCrdtIn(int chkCtrlFlg) async {
    int errNo;
    // int p;
    String encryptPidNew;

    AcMem cMem = SystemFunc.readAcMem();

    if ((RcCrdtFnc.rcCheckEntryCrdtInqu()) &&
        (!await RcSysChk.rcCheckEntryCrdtSystem())) // 置数 + クレジットでの問合せ後は全てOK
    {
      return Typ.OK;
    }

    errNo = Typ.FALSE;
    if (errNo == 0) {
      /* クレジット仕様か？ */
      if (await CmCksys.cmCrdtSystem() == 0) {
        errNo = DlgConfirmMsgKind.MSG_INVALIDKEY.dlgId;
      }
    }
    if (errNo == 0) {
      /* クレジット宣言中か？ */
      if ((cMem.stat.fncCode == FuncKey.KY_CRDTIN.keyId) &&
          (cMem.working.crdtReg.step != KyCrdtInStep.INPUT_1ST.cd)) {
        // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
        // #if DEPARTMENT_STORE
        //           if((rcChk_Department_System()                               ) &&
        //             ((rcWorkin_Chk_WorkTyp(&MEM->tTtllog) == WK_CRDITRECEIV   ) ||
        //              (rcWorkin_Chk_WorkTyp(&MEM->tTtllog) == WK_RET_CRDITRECEIV)))
        //              err_no = (short)MSG_CREDIT_INVALID;
        //           else
        // #endif
        errNo = DlgConfirmMsgKind.MSG_NONPRESET.dlgId;
      }
    }
    if (errNo == 0) {
      if (CompileFlag.MC_SYSTEM) {
        if (!(RcSysChk.rcRGOpeModeChk() || RcSysChk.rcTROpeModeChk())) {
          errNo = DlgConfirmMsgKind.MSG_OPEMERR_REGI.dlgId;
        } /*{ err_no = (short)MSG_OPEMERR;}*/
      } else {
        if (RcSysChk.rcSROpeModeChk()) {
          errNo = DlgConfirmMsgKind.MSG_OPEMERR.dlgId;
        }
      }
    }
    if (errNo == 0) /* 釣機入金画面が表示されている？ */ {
      if (RcFncChk.rcCheckChgCinMode()) {
        errNo = DlgConfirmMsgKind.MSG_OPEMERR.dlgId;
      }
    }
    if (errNo == 0) {
      /* チェッカーでクレジット宣言か？ */
//       if(rcKy_Self() == KY_CHECKER)                 { err_no = (short)MSG_OPEERR;}
      if ((await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) &&
          (!await RcSysChk.rcCheckQCJCSystem())) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }
    if (errNo == 0) {
      /* 自走式磁気リーダエラー発生しているか？ */
      errNo = await RcMasr.rcCheckMasrErr();
    }
    // TODO:10032 コンパイルスイッチ(MC_SYSTEM)
    // #if MC_SYSTEM
    //     if(! errNo)
    //     {                                  /* 単独割振中か？ */
    // //       if(Ky_St_C7(CMEM->key_stat[KY_MCALC]))        { return((short)FALSE);}
    //        if(Ky_St_C7(CMEM->key_stat[KY_MCALC]))        {return(rcChk_Crdt_Step());}
    //     }
    // #endif
    if (errNo == 0) {
      /* 商品登録しているか？ */
      if (!RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG.keyId])) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }
    if (!RckyRfdopr.rcRfdOprCheckManualRefundMode()) {
      if (errNo == 0) {
        /* ０円以下の買い上げか？ */
        if (0 >= RcCrdtFnc.payPrice()) {
          errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
        }
      }
      if (errNo == 0) {
        /* 返品商品あるか？ */
        if (RegsMem().tTtllog.t100003.refundAmt != 0) {
          errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
        }
      }
    }
    if (errNo == 0) {
      /* 置数中のクレジット宣言か？ */
      if ((!RcSysChk.rcCheckCrdtStat()) &&
          (RcFncChk.rcChkTenOn()) &&
          (await RcSysChk.rcCheckEntryCrdtMode()) &&
          (!await RcSysChk.rcCheckEntryCrdtSystem())) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
      //if((! rcCheck_Crdt_Stat()) && (rcChk_Ten_On() == 0) && (rcCheckEntryCrdtMode() == TRUE))    // 置数 + クレジットでは一発締めは出来無い
      //                                            { errNo = DlgConfirmMsgKind.MSG_OPEERR;}
      if ((!RcSysChk.rcCheckCrdtStat()) &&
          (await RcSysChk.rcCheckEntryCrdtSystem()) &&
          (RcCrdtFnc.rcChkSptendCrdt() != 0)) // 置数 + クレジット複数回支払禁止
      {
        errNo = DlgConfirmMsgKind.MSG_CREDT_ONCE.dlgId;
      }
    }

    if (errNo == 0) {
      /* 売価チェック中か？ */
      if ((RcFncChk.rcCheckScanCheck()) || (RcFncChk.rcCheckScanWtCheck())) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }
    if (errNo == 0) {
      /* カード決済機接続:しない or Edy or ヤマトか？ */
      if ((RcRegs.rcInfoMem.rcCnct.cnctCardCnct != 0) &&
          (RcRegs.rcInfoMem.rcCnct.cnctCardCnct != 5) &&
          (RcRegs.rcInfoMem.rcCnct.cnctCardCnct != 7) &&
          (RcRegs.rcInfoMem.rcCnct.cnctCardCnct != 8)) {
        errNo = DlgConfirmMsgKind.MSG_CREDIT_INVALID.dlgId;
      }
    }
    if (errNo == 0) {
      /* カード決済機接続（デビッット／クレジット）:しないか？ */
      if (((CompileFlag.DEPARTMENT_STORE) &&
              ((RcRegs.rcInfoMem.rcCnct.cnctGcatCnct != 0) &&
                  (!RcSysChk.rcCheckMarine5Simizuya()))) ||
          ((!CompileFlag.DEPARTMENT_STORE) &&
              ((RcRegs.rcInfoMem.rcCnct.cnctGcatCnct != 0) &&
                  (!await RcSysChk.rcChkVegaProcess())))) /* VEGA3000ではないか？ */ {
        errNo = DlgConfirmMsgKind.MSG_CHK_CRDT.dlgId;
      }
    }
    CompetitionIniRet ret = await CompetitionIni.competitionIniGet(
        await RcSysChk.getTid(),
        CompetitionIniLists.COMPETITION_INI_ENCRYPT_PIDNEW,
        CompetitionIniType.COMPETITION_INI_GETMEM);
    encryptPidNew = ret.value;
    if (NTT_ENCRYPT) {
      if (errNo == 0) {
        /* セキュリテイ鍵セット済か？ */
        if ((await CmCksys.cmNttaspSystem() != 0) &&
            (!RcSysChk.rcTROpeModeChk())) {
          if ((encryptPidNew.compareTo("00000000") != 0)) {
            errNo = DlgConfirmMsgKind.MSG_CREDIT_INVALID.dlgId;
          }
        }
      }
    }
    if (CompileFlag.MC_SYSTEM) {
      // TODO:10032 コンパイルスイッチ(MC_SYSTEM)
      //     if(! errNo)
      //     {
      //        if(rcChk_Mc_System()) {
      //           if(rcCheck_Itm_Mode())                     { errNo = DlgConfirmMsgKind.MSG_OPEERR;}
      //           if(! errNo) {
      //              if(MEM->tTtllog.t100700.mbr_input == MCARD_INPUT) {
      //                 if((AT_SING->mc_tbl.k_amount == KY_MCRDT) ||     /* カード一括 */
      //                    (AT_SING->mc_tbl.k_amount == KY_MCASH) )      /* カード現金 */
      //                                                      { errNo = DlgConfirmMsgKind.MSG_OPEERR;}
      //              }
      //           }
      // //          if(! err_no) {
      // //             if((rcChk_Mc_Izumi_System()) && (MEM->tTtllog.t100700.mbr_input == CARD_KEY_INPUT)) /* 手入力イズミカード */
      // //                                                     { err_no = DlgConfirmMsgKind.MSG_OPEERR;}
      // //          }
      //        }
      //        else {
      //                                                        errNo = DlgConfirmMsgKind.MSG_INVALIDKEY;
      //        }
      //     }
      //     if(! errNo)
      //     {
      //        if((C_BUF->db_mcspec.tele_flg == 4) && (AT_SING->mc_tbl.k_amount != KY_HCRDT))
      //                                                      { errNo = DlgConfirmMsgKind.MSG_CHK_OPERATION;}
      //     }
    }
    if (!CompileFlag.MC_SYSTEM) {
      // TODO:10166 クレジット決済 20241004実装対象外
      // if (errNo == 0) {
      //   /* 関西スーパー従業員証カードリード済か？ */
      //   if ((!cm_nttasp_system()) && (rcChk_Crdt_User() == KANSUP_CRDT)) {
      //     if (MEM->tTtllog.t100700.mbr_input == MAGCARD_INPUT) {
      //       errNo = DlgConfirmMsgKind.MSG_CREDIT_INVALID;
      //     }
      //   }
      // }
      // if (errNo == 0) {
      //   /* カスミ商品券が登録されている？ */
      //   if ((!cm_nttasp_system()) && (rcChk_Crdt_User() == KASUMI_CRDT)) {
      //     if (MEM->tTtllog.t100001Sts.itemlog_cnt > 0) {
      //       for (p = 0; p < MEM->tTtllog.t100001Sts.itemlog_cnt; p++) {
      //         if (rcCheck_OutMdlTranCrdt(&MEM->tItemlog[p])) {
      //           errNo = DlgConfirmMsgKind.MSG_TEXT77;
      //           break;
      //         }
      //       }
      //     }
      //   }
      // }
      // if (errNo == 0) {
      //   if (cm_RainbowCard_system()) {
      //     /* Rainbow Card仕様             */
      //     if (MEM->tTtllog.t100001Sts.itemlog_cnt > 0) {
      //       /* 部門外商品が登録されている？ */
      //       for (p = 0; p < MEM->tTtllog.t100001Sts.itemlog_cnt; p++) {
      //         if (rcCheck_OutMdlTranCrdt(&MEM->tItemlog[p])) {
      //           errNo = DlgConfirmMsgKind.MSG_CREDIT_INVALID;
      //           break;
      //         }
      //       }
      //     }
      //   }
      // }
      // if (errNo == 0) {
      //   /* カスミ様タバコのみ登録されている？  */
      //   errNo = rcCheck_OutLrgTranCrdt();
      // }
      if (errNo == 0) {
        /* RARA現金カード、RARAクレジットカード、他社クレジットカード読込み済み？ */
        if ((await CmCksys.cmNttaspSystem() != 0) &&
            (RcSysChk.rcChkRalseCardSystem())) {
          if(!CompileFlag.ARCS_VEGA){
            if (RegsMem().tTtllog.t100700Sts.mbrTyp == 0) {
              errNo = DlgConfirmMsgKind.MSG_NSC_CR_READ.dlgId;
            }
          }
          if (errNo == 0) {
            if ((RegsMem().tTtllog.t100700Sts.mbrTyp != Mcd.MCD_RLSCARD) &&
                (RegsMem().tTtllog.t100700Sts.mbrTyp != Mcd.MCD_RLSCRDT) &&
                (RegsMem().tTtllog.t100700Sts.mbrTyp != Mcd.MCD_RLSVISA) &&
                (RegsMem().tTtllog.t100700Sts.mbrTyp != Mcd.MCD_RLSJACCS) &&
                (!((RegsMem().tTtllog.t100700Sts.mbrTyp == Mcd.MCD_RLSSTAFF) &&
                    ((RegsMem().tmpbuf.rcarddata.typ == Mcd.MCD_RLSCRDT) ||
                        (RegsMem().tmpbuf.rcarddata.typ == Mcd.MCD_RLSVISA) ||
                        ((RegsMem().tmpbuf.rcarddata.typ ==
                            Mcd.MCD_RLSJACCS))))) &&
                ((CompileFlag.ARCS_VEGA) &&
                    (RegsMem().tTtllog.t100700Sts.mbrTyp != 0)) &&
                (RegsMem().tTtllog.t100700Sts.mbrTyp != Mcd.MCD_RLSOTHER)) {
              errNo = DlgConfirmMsgKind.MSG_NSC_CR_READ.dlgId;
            }
          }
          if (errNo == 0) {
            if (RegsMem().tTtllog.t100700Sts.mbrTyp == Mcd.MCD_RLSCARD) {
              if (!await RcCrdtFnc.rcNttCheckHouseStatus()) {
                errNo = DlgConfirmMsgKind.MSG_CARDOPEERR.dlgId;
              }
            }
          }
          if (errNo == 0) {
            if(!CompileFlag.ARCS_VEGA){
              if (RegsMem().tmpbuf.rcarddata.jis2.isEmpty) {
                errNo = DlgConfirmMsgKind.MSG_JCBCOOPSAPPOROCARD2.dlgId;
              }
              if (errNo == 0) {
                if (ChkSpc.cmChkSpc(RegsMem().tmpbuf.rcarddata.jis2,
                    RegsMem().tmpbuf.rcarddata.jis2.length)) {
                  errNo = DlgConfirmMsgKind.MSG_JCBCOOPSAPPOROCARD2.dlgId;
                }
              }
            }
          }
          if (CompileFlag.ARCS_MBR) {
            if (errNo == 0) {
              if ((await RcMbrCom.rcChkCrdtReceipt(0)) ||
                  (RcMbrCom.rcChkCha9Receipt() != -1) ||
                  (await RcMbrCom.rcChkIDReceipt() != -1) ||
                  (await RcMbrCom.rcChkPrepaidReceipt() != -1) ||
                  (await RcMbrCom.rcChkQUICPayReceipt() != -1)) {
                errNo = DlgConfirmMsgKind.MSG_CREDT_ONCE.dlgId;
              }
            }
          }
        }
      }
    }
    if (CompileFlag.DEPARTMENT_STORE) {
      // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
      // if(! errNo){
      //    if((rcChk_Department_System()) && (rcChk_Crdt_User() == NAKAGO_CRDT)) {
      //       switch(rcWorkin_Chk_WorkTyp(&MEM->tTtllog)){
      //          case WK_SCREDIT:
      //          case WK_CASHDELIVERY:
      //          case WK_PLUMVST:
      //          case WK_PLUMVEND:
      //          case WK_SUMUP_CASHDELIVERY:
      //          case WK_ADDDEPOSIT:
      //          case WK_ANNUL_SCREDIT:
      //          case WK_ANNUL_CASHDELIVERY:
      //             errNo = DlgConfirmMsgKind.MSG_CREDIT_INVALID;
      //             break;
      //          case WK_ANNUL_ORDER:
      //             if(MEM->tTtllog.t100002.cust_cd != MEM->tTtllog.t100010.approval_no)
      //                errNo = DlgConfirmMsgKind.MSG_CREDIT_INVALID;
      //             break;
      //          case WK_CRDITRECEIV:
      //          case WK_RET_CRDITRECEIV:
      //             if(CMEM->working.crdt_reg.step == INPUT_END)
      //                errNo = DlgConfirmMsgKind.MSG_CREDIT_INVALID;
      //             break;
      //          case WK_OTHER : if(MEM->tTtllog.t100001Sts.itemlog_cnt > 0) {     /* 部門外商品が登録されている？ */
      //                             for(p = 0; p < MEM->tTtllog.t100001Sts.itemlog_cnt; p++)
      //                             {
      //                                if(rcCheck_OutMdlTranCrdt(&MEM->itmrbp[p])) {
      //                                   errNo = DlgConfirmMsgKind.MSG_CREDIT_INVALID;
      //                                   break;
      //                                }
      //                             }
      //                          }
      //                          break;
      //          default       : break;
      //       }
      //    }
      // }
    }
    // TODO:10166 クレジット決済 20241004実装対象外
    // if(! errNo)
    // {
    //    if(cm_sp_department_system())
    //       errNo = rcYao_ChkWorkTyp(KY_CHA2, 0);
    // }
    // if(! errNo)
    // {
    //    if( rcChk_CAPS_CAFIS_System() && cm_dcmpoint_system() ) {
    //       if(MEM->tTtllog.t100700.mbr_input == MCP200_INPUT)    /* MCP200 Member Card */
    //          errNo = DlgConfirmMsgKind.MSG_CREDIT_INVALID;
    //    }
    // }
//    if(! err_no)
//    {
//       if( cm_ichiyama_mart_system() ) {
//          if((MEM->tTtllog.t100700.mbr_input == MAGCARD_INPUT) && (!((MEM->tHeader.cust_no[9] == ' ')||(MEM->tHeader.cust_no[9] == 0))) && (CMEM->working.crdt_reg.step == INPUT_1ST)) /* ichiyama MoreCard (not credit card) */
//             err_no = (short)MSG_CREDIT_INVALID;
//       }
//    }
    if (RcSysChk.rcCheckMbrTelMode()) {
      errNo = DlgConfirmMsgKind.MSG_CHK_OPERATION.dlgId;
    }

    if (errNo == 0) {
      /* 他のキーステータスOK？ */
      RcRegs.kyStR0(cMem.keyChkb, FncCode.KY_ENT.keyId);
      RcRegs.kyStR0(cMem.keyChkb, FuncKey.KY_CRDTIN.keyId); /* Credit Subtotal Discount % */
      RcRegs.kyStR4(cMem.keyChkb, FuncKey.KY_CRDTIN.keyId);
      if (CompileFlag.DEPARTMENT_STORE) {
        // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
        // if (rcChk_Department_System())
        //   Ky_St_R4(CMEM->key_chkb[KY_WORKIN]);
      }
      if (RcFncChk.rcKyStatus(
              cMem.keyChkb, (RcRegs.MACRO1 + RcRegs.MACRO2 + RcRegs.MACRO3)) !=
          0) {
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
      }
    }
    if (errNo == 0) {
      // #if !MC_SYSTEM
      if (((CompileFlag.ARCS_VEGA) &&
              (!Rxcrdtcom.rxArcsNttaspSystem(
                  RegsMem().tTtllog.t100700Sts.mbrTyp, RegsMem().workInType))) ||
          ((!CompileFlag.ARCS_VEGA) &&
              (!(await CmCksys.cmNttaspSystem() != 0)))) {
        if (((RcSysChk.rcChkCrdtUser() == Datas.KASUMI_CRDT) ||
                (RcSysChk.rcChkCrdtUser() == Datas.NAKAGO_CRDT)) &&
            ((cMem.working.crdtReg.stat & 0x1000) != 0)) {
          /* 通信PCオフライン？ */
          errNo = await rcChkCrdtStep();
          if (errNo != 0) {
            if (!await RcSysChk.rcQCChkQcashierSystem()) {
              RcSet.rcClearEntry();
              cMem.working.crdtReg.stat |= 0x0200;
            }
          }
        } else {
          // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
          // #if DEPARTMENT_STORE
          //              if(rcChk_Crdt_User() == NAKAGO_CRDT) {
          //                 recogn_cd = rcGet_Recogn_No();
          //                 if(CMEM->working.crdt_reg.multi_flg & 0x08)
          //                    errNo = rcChk_Crdt_Step();
          //                 else if((CMEM->working.crdt_reg.multi_flg & 0x20) && (recogn_cd > 0))
          //                    errNo = rcChk_Crdt_Step();
          //                 else if(rc_Check_Marine5_Simizuya()) {
          //                    errNo = rcChk_Crdt_Step();
          //                 }
          //                 else
          //                    errNo = rcChk_CardCrewStep();
          //              }
          //              else
          // #endif
          errNo = await rcChkCardCrewStep();
        }
      } else {
        // #endif
        errNo = await rcChkCrdtStep();
      }
    }
    if (errNo == 0) {
      if (await RcKyccin.rcChkAcbCinAct() != 0) {
        errNo = DlgConfirmMsgKind.MSG_ACBACT.dlgId;
      }
    }

    // TODO:10166 クレジット決済 20241004実装対象外
    // if (rcChk_Cogca_System() && errNo == 0) {
    //   /* プリカ併用禁止 */
    //   if (rcChk_Sptend_preca_enble_flg()) {
    //     errNo = DlgConfirmMsgKind.MSG_PRECA_TOGETHER_ERR;
    //   }
    //   if (rcCheck_Cogca_Deposit_Item(1)) {
    //     errNo = DlgConfirmMsgKind.MSG_CHARGE_INVALID;
    //   }
    //  }
    //
    // if (errNo == 0) {
    //   if (rcChk_Repica_System()) {
    //     /* プリカ併用禁止 */
    //     if (rcChk_Sptend_preca_enble_flg()) {
    //       errNo = DlgConfirmMsgKind.MSG_PRECA_TOGETHER_ERR;
    //     }
    //     else if (rcCheck_Repica_Deposit_Item(1)) {
    //       errNo = DlgConfirmMsgKind.MSG_CHARGE_INVALID;
    //     }
    //   }
    // }
    //
    // if (rcChk_ValueCard_System() && errNo == 0) {
    //   /* プリカ併用禁止 */
    //   if (rcChk_Sptend_preca_enble_flg()) {
    //     errNo = DlgConfirmMsgKind.MSG_PRECA_TOGETHER_ERR;
    //   }
    //   if (rcCheck_ValueCard_Deposit_Item(1)) {
    //     errNo = DlgConfirmMsgKind.MSG_CHARGE_INVALID;
    //   }
    // }
    //
    // if (rcChk_Ajs_Emoney_System() && errNo == 0) {
    //   if (rcChk_Sptend_preca_enble_flg()) {
    //     errNo = DlgConfirmMsgKind.MSG_PRECA_TOGETHER_ERR;
    //   }
    //   if (rcCheck_Ajs_Emoney_Deposit_Item(1)) {
    //     errNo = DlgConfirmMsgKind.MSG_CHARGE_INVALID;
    //   }
    // }

    if ((await RcSysChk.rcChkBarcodePaySystem() != 0) && errNo == 0) {
      // TODO:00012 平野 クレジット宣言：コード決済で関数実装していそうなので要確認
      // if (rcChk_Sptend_Barcode_Pay_enble_flg()) {
      //   errNo = DlgConfirmMsgKind.MSG_HC2_USE_TOGETHER_ERR.dlgId;
      // }
      if (RcBarcodePay.rcChkBarcodePayDepositItem(1) != 0) {
        errNo = DlgConfirmMsgKind.MSG_CHARGE_INVALID.dlgId;
      }
    }

    // TODO:10166 クレジット決済 20241004実装対象外
    // if (errNo == 0) {
    //   // くろがねや仕様
    //   if (cm_hc2_Kuroganeya_system(GetTid()) == 1) {
    //     if ((MEM->tTtllog.t100200[AMT_CHA1].amt != 0) ||
    //         (MEM->tTtllog.t100200[AMT_CHA2].amt != 0) ||
    //         (MEM->tTtllog.t100200[AMT_CHA3].amt != 0)) {
    //       errNo = MSG_HC2_USE_TOGETHER_ERR;
    //     }
    //   }
    // }
    // if (errNo == 0) {
    //   if (cm_ichiyama_mart_system()) {
    //     if (MEM->tTtllog.t100001Sts.sptend_cnt > 0) {
    //       errNo = MSG_OPEMISS;
    //     }
    //   }
    // }
    // if (errNo == 0) {
    //   if (rcChk_ChargeSlip_System()) {
    //     if (rcChkMember_ChargeSlipCard()) {
    //       errNo = MSG_OPEMISS;
    //     }
    //   }
    // }
    // if (!errNo) {
    //   if (((cm_PFM_JR_IC_system()) || (rcChk_Suica_System()) ||
    //       (rcChk_MultiVega_PayMethod(FCL_SUIC)))
    //       && (rxCalc_Suica_Amt(MEM)))
    //     errNo = MSG_OPEMISS;
    //   if ((cm_PFM_JR_IC_Charge_system() || cm_Suica_Charge_system()) &&
    //       rcChk_RegMultiChargeItem(FCL_SUIC, 1) > 0)
    //     errNo = MSG_OPEMISS;
    //   if (cm_nimoca_point_system() &&
    //       (MEM->tTtllog.t100700.mbr_input == MBRPRC_KEY_INPUT) &&
    //       (MEM->tTtllog.t100700Sts.nimoca_number[0] == 0)) {
    //     if (TS_BUF->suica.order != SUICA_NOT_ORDER) {
    //       if ((TS_BUF->suica.Trans_flg == 1) || (TS_BUF->suica.Trans_flg == 2))
    //         errNo = MSG_BUSY_FCLDLL;
    //       else
    //         errNo = MSG_TEXT14;
    //     }
    //   }
    // }
    //
    // if ((errNo == 0)
    //     && (chk_ctrl_flg == 0)) {
    //   if ((rcChk_Tpoint_System())
    //       && (MEM->tTtllog.t100700.mbr_input != NON_INPUT)
    //       && ((rcRG_OpeModeChk())
    //           || (rcTR_OpeModeChk()))
    //       && (MEM->tTtllog.t100701.dupt_ttlrv != 0)
    //       && (!rcQC_Chk_Qcashier_System())
    //       && (MEM->tTtllog.t100710.ret_cd_enq == 0)
    //       && (MEM->tTtllog.t100710.t_pts_flg == 0)) {
    //     CMEM
    // ->ent.errNo = rcrealsvr2_Tpoint_Use (0, (t_ttllog *)&MEM->tTtllog);
    //
    // if (CMEM->ent.errNo != OK)
    // {
    // errNo = MSG_PNTERR_AUTOSPCNCL;
    // }
    // else
    // {
    // MEM->tTtllog.t100710.t_pts_flg = 1;
    // }
    // }
    // }
    //
    // if(errNo == 0)
    // {
    // // VEGA交通系の処理未了発生時は、特定会計キーでしか決済不可
    // if((rcChk_MultiVega_PayMethod(FCL_SUIC))
    // && (MEM->tmpbuf.multi_timeout== 2)
    // && (MEM->mltsuica_alarm_payprc != 0))
    // {
    // return(MSG_TEXT99);
    // }
    // }
    //
    // if (errNo == 0)
    // {
    // if (rcChk_MultiVega_System())
    // {
    // if (C_BUF->edy_seterr_flg == 3)
    // {
    // TprLibLogWrite(GetTid(), TPRLOG_ERROR, -1, "C_BUF->edy_seterr_flg == 3 !!\n");
    // errNo = MSG_CANNOT_PAY_EDY;
    // }
    //
    // if (rcChk_Sptend_crdt_enble_flg())
    // {
    // errNo = DlgConfirmMsgKind.MSG_HC2_USE_TOGETHER_ERR;
    // }
    // }
    // }

    return (errNo);
  }

  /// 関連tprxソース: rckycrdtin.c - rcPrg_Ky_CrdtIn
  static Future<void> rcPrgKyCrdtIn() async {
    bool mode = false;
    int stat = 0;
    int kasumi;
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    RegsMem mem = SystemFunc.readRegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;

    KyCrdtInStep define = KyCrdtInStep.getDefine(cMem.working.crdtReg.step);
    switch (define) {
      case KyCrdtInStep.INPUT_1ST:
        if ((cMem.working.crdtReg.stat & 0x0080) != 0) {
          stat |= 0x0080;
        }
        if ((cMem.working.crdtReg.stat & 0x0100) != 0) {
          stat |= 0x0100;
        }
        if (cMem.working.crdtReg.kasumiInpflg == 1) {
          kasumi = cMem.working.crdtReg.kasumiInpflg;
        }

        // 置数 + クレジットで入力値をセット
        if (((await RcSysChk.rcCheckEntryCrdtMode()) ||
                (await RcSysChk.rcCheckEntryCrdtSystem())) &&
            (cMem.stat.orgCode != RcCrdt.KEY_BREAK1)) {
          if ((await RcSysChk.rcCheckEntryCrdtSystem()) &&
              (!RcFncChk.rcChkTenOn())) //置数していなければ全額支払
          {
            cMem.ent.entry = Uint8List(10);
            cMem.ent.entry = RckyCrdtIn.cmLtobcd(
                RcCrdtFnc.payPrice().abs(), cMem.ent.entry.length);
            cMem.ent.tencnt = ChkZ0.cmChkZero0(cMem.ent.entry);
          }
          atSing.entryCrdtAmt = Bcdtol.cmBcdToL(cMem.ent.entry);
          if (await RcSysChk.rcCheckEntryCrdtSystem()) {
            atSing.lastCommSaveOtherEntry = cMem.ent.entry;
          }
        }
        RcSet.rcClearCrdtReg();
        cMem.stat.orgCode = 0;
        // TODO:10166 クレジット決済 20241004実装対象外
        // if(kasumi == 1) {
        //   cMem.working.crdtReg.kasumiInpflg = kasumi;
        // }
        cMem.working.crdtReg.stat = stat;
        if ((cBuf.dbTrm.rbtlAddSaleAmt == 0) &&
            (mem.tTtllog.t100003.btlRetAmt != 0)) {
          atSing.btlAmtTotal = mem.tTtllog.t100003.btlRetAmt;
        } else {
          atSing.btlAmtTotal = 0;
        }

        break;
      case KyCrdtInStep.CARD_KIND:
        await rcSetCompCode();
        break;
      case KyCrdtInStep.PLES_CARD:
        mode = await rcSetCardCode();
        break;
      case KyCrdtInStep.GOOD_THRU:
        mode = await rcSetGoodThru();
        if (await RcSysChk.rcChkCrdtDscSystem()) {
          RcRegs.kyStS0(cMem.keyStat, FuncKey.KY_CRDTIN.keyId);
          await RcCrdtFnc.rcCrdtStlDscSet();
        }
        break;
      case KyCrdtInStep.RECEIT_NO : mode = rcSetReceitNo();
      break;
      case KyCrdtInStep.PAY_A_WAY:
        mode = await rcSetPayAWay();
        break;
      case KyCrdtInStep.DIV_BEGIN : mode = await rcSetPayBegin();
      break;
      case KyCrdtInStep.PAY_DIVID : mode = await rcSetPayDivid();
      break;
      case KyCrdtInStep.BONUS_TWO : mode = await rcSetBonusTwo();
      break;
      case KyCrdtInStep.BNS_BEGIN : mode = await rcSetPayBegin();
      break;
      case KyCrdtInStep.BONUSUSE1 : mode = await rcSetBonusUse();
      break;
      case KyCrdtInStep.BONUS_CNT : mode = rcSetBonusCnt();
      break;
      case KyCrdtInStep.BONUSUSE2 : mode = await rcSetBonusTwo();
      break;
      case KyCrdtInStep.PAY_KYCHA : break;
      case KyCrdtInStep.OFF_KYCHA : cMem.working.crdtReg.step--;
      break;
      case KyCrdtInStep.RECOGN_NO : mode = rcSetRecognNo();
      break;
      default:
        break;
    }
    if ((await RcCrdtFnc.rcChkCrdtCancel()) &&
        (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_CRDTIN.keyId]))) {
      if (CompileFlag.DEPARTMENT_STORE) {
        //   if((rcChk_Department_System()) && (rcWorkin_Chk_WorkTyp(&mem.tTtllog) == WK_RET_CRDITRECEIV)) {
        // rcCrdt_StepDisp();
        // }
        // else {
        // rcCrdt_Chk_Date();
        // cMem.working.crdtReg.stat &= ~0x0100;
        //
        // rcCrdt_StepDisp();
        // if(mode == TRUE)
        // rcEnd_Crdt_Step();
        // }
      } else {
        RcIfEvent.rxChkTimerRemove(); /* キー入力禁止        */
        rcCrdtVDcanDisp();
      }
    } else {
      if ((await RcSysChk.rcChkVegaProcess()) &&
          (await RcCrdtFnc.rcChkCrdtCancel()) &&
          (cMem.working.crdtReg.step == (KyCrdtInStep.RECEIT_NO.cd - 1))) {
        /* VEGA3000接続の場合、カード読取前に元伝票番号入力しているためステップを1プラスする */
        cMem.working.crdtReg.step++;
      }

      await RcCrdtDsp.rcCrdtStepDisp();
      if (mode == true) {
        await rcEndCrdtStep();
      }
    }
  }

  // TODO:10166 クレジット決済 20241004実装対象外
  /// 関連tprxソース: rckycrdtin.c - rcCrdt_VDcan_Disp
  static void rcCrdtVDcanDisp() {}

  /// 関連tprxソース: rckycrdtin.c - rcEnd_Ky_CrdtIn
  static Future<void> rcEndKyCrdtIn() async {
    int errNo;

    AcMem cMem = SystemFunc.readAcMem();

    await RcSet.rcClearKyItem();
    RcSet.rcClearEntry();
    await RcSet.rcClearDataReg();
    RcRegs.kyStS4(cMem.keyStat, FuncKey.KY_CRDTIN.keyId);

    if ((await CmCksys.cmNttaspSystem() == 0) &&
        (!await RcSysChk.rcChkCapSCafisSystem()) &&
        (await CmCksys.cmCapsPqvicSystem() == 0) &&
        (!await RcSysChk.rcChkCapsCafisStandardSystem())) {
      /* for CardCrew */
      // TODO:10166 クレジット決済 20241004実装対象外
      // if(rcChk_Crdt_User() == KASUMI_CRDT) {
      //   if(cMem.working.crdt_reg.card_div == '1') {
      //     if((cMem.working.crdt_reg.kasumi_aeon == KASUMI_AEON) || (cMem.working.crdt_reg.kasumi_aeon == AEON)) {
      //       TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "JIS2 Read Err Caution Skip Because Kasumi_Card or AEON_Card Use!!\n");
      //     }
      //     else {
      //       #if SELF_GATE
      //       if(rcSG_Chk_SelfGate_System()) {
      //         if((DualDsp.subttl_dsp_flg == 1) || (DualDsp.subttl_dsp_flg == 3))
      //           rcCrdt_SelectDialog(MSG_TEXT140, 1);
      //         }
      //         else {
      //           #endif
      //           if(rcQC_Chk_Qcashier_System()) {
      //             if(rcQC_Check_CrdtDsp_Mode()){
      //               if(AT_SING->crdt_mismsg_cnt < QC_CRDTMSG_CNT_MAX){
      //                 TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "JIS2 Read Err Msg Show");
      //                 rcCrdt_SelectDialog(MSG_TEXT140, 0);
      //                 AT_SING->crdt_mismsg_cnt ++;
      //               }
      //               else{
      //                 TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "JIS2 Read Err Staff Call Go");
      //                 AT_SING->crdt_mismsg_cnt = QC_CRDTMSG_STAFFCALL;
      //               }
      //             }
      //           }
      //           else if(rcVD_OpeModeChk()) {
      //             TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "JIS2 Read Err Caution Skip Because OpeMode VD!!\n");
      //           }
      //           else {
      //             if(cMem.working.crdt_reg.step == PAY_A_WAY)
      //               rcCrdt_SelectDialog(MSG_TEXT140, 0);
      //           }
      //           #if SELF_GATE
      //         }
      //         #endif
      //     }
      //   }
      // }
    }

    // TODO:10166 クレジット決済 20241004実装対象外
    // if(rcChk_CrdtDsc_System()) {
    // if(MEM->tTtllog.t100002.stlcrdtdsc_amt != 0) {
    // #if DEPARTMENT_STORE
    // if(rc_Check_Marine5_Simizuya()) {
    // if((cMem.stat.Depart_Flg & 0x01) || (cMem.working.crdt_reg.multi_flg & 0x08)) {
    // if(((cMem.working.crdt_reg.kasumi_offcrdt == 0) && (cMem.working.crdt_reg.step == PAY_A_WAY)) ||
    // ((cMem.working.crdt_reg.kasumi_offcrdt == 1) && (cMem.working.crdt_reg.step == OFF_KYCHA))) {
    // rcCrdtDsc_WarnUp(MSG_STLCRDTDSC);
    // }
    // }
    // else {
    // if(cMem.working.crdt_reg.step == INPUT_END) {
    // rcCrdtDsc_WarnUp(MSG_STLCRDTDSC);
    // }
    // }
    // }
    // else {
    // if(rcChk_Crdt_User() == NAKAGO_CRDT) {
    // if(((cMem.working.crdt_reg.kasumi_offcrdt == 0) && (cMem.working.crdt_reg.step == PAY_A_WAY)) ||
    // ((cMem.working.crdt_reg.kasumi_offcrdt == 1) && (cMem.working.crdt_reg.step == OFF_KYCHA))) {
    // rcCrdtDsc_WarnUp(MSG_STLCRDTDSC);
    // }
    // }
    // else {
    // if(rcVD_OpeModeChk()) {
    // if(((cMem.working.crdt_reg.kasumi_offcrdt == 0) && (cMem.working.crdt_reg.step == RECEIT_NO)) ||
    // ((cMem.working.crdt_reg.kasumi_offcrdt == 1) && (cMem.working.crdt_reg.step == OFF_KYCHA))) {
    // rcCrdtDsc_WarnUp(MSG_STLCRDTDSC);
    // }
    // }
    // else {
    // if(((cMem.working.crdt_reg.kasumi_offcrdt == 0) && (cMem.working.crdt_reg.step == PAY_A_WAY)) ||
    // ((cMem.working.crdt_reg.kasumi_offcrdt == 1) && (cMem.working.crdt_reg.step == OFF_KYCHA))) {
    // rcCrdtDsc_WarnUp(MSG_STLCRDTDSC);
    // }
    // }
    // }
    // }
    // #else
    // if(rcVD_OpeModeChk()) {
    // if(((cMem.working.crdt_reg.kasumi_offcrdt == 0) && (cMem.working.crdt_reg.step == RECEIT_NO)) ||
    // ((cMem.working.crdt_reg.kasumi_offcrdt == 1) && (cMem.working.crdt_reg.step == OFF_KYCHA))) {
    // rcCrdtDsc_WarnUp(MSG_STLCRDTDSC);
    // }
    // }
    // else {
    // if(((cMem.working.crdt_reg.kasumi_offcrdt == 0) && (cMem.working.crdt_reg.step == PAY_A_WAY)) ||
    // ((cMem.working.crdt_reg.kasumi_offcrdt == 1) && (cMem.working.crdt_reg.step == OFF_KYCHA))) {
    // rcCrdtDsc_WarnUp(MSG_STLCRDTDSC);
    // }
    // }
    // #endif
    // }
    // else {
    // if(((MEM->tTtllog.t100002.stlcrdtdsc_per != 0) && (MEM->tTtllog.t100002.stlcrdtdsc_amt == 0)) || (cMem.working.crdt_reg.crdtdsc_cancel == 1)) {
    // #if SELF_GATE
    // if(rcSG_Chk_SelfGate_System()) {
    // if((DualDsp.subttl_dsp_flg == 1) || (DualDsp.subttl_dsp_flg == 3))
    // rcSG_CrdtDsc_Caution(MSG_TEXT78, (char *)&BTN_CONF);
    // }
    // else {
    // #endif
    // if(rcQC_Chk_Qcashier_System())
    // ;
    // else if(cMem.working.crdt_reg.step == PAY_A_WAY)
    // rcCardCrew_Caution(MSG_TEXT78, CARD_REQ);
    // #if SELF_GATE
    // }
    // #endif
    // }
    // }
    // }

    if (await CmCksys.cmNttaspSystem() != 0) {
      if ((cMem.working.crdtReg.step ==
              KyCrdtInStep.INPUT_END.cd) && /* クレジット入力完了？*/
          ((cMem.working.crdtReg.stat & 0x8000) != 0)) /* クレジット保留？    */ {
        errNo = RcCrdtFnc.rcCrdtInquProg(); /* 承認後問い合わせ    */
        if (errNo != Typ.OK) {
          // TODO:00012 平野 クレジット宣言：UI(ポップ画面クリア)
          // rcClear_PopDisplay();
          RcExt.rcClearErrStat('rcEndKyCrdtIn');
          cMem.ent.errNo = errNo;
          await RcExt.rcErr('rcEndKyCrdtIn', cMem.ent.errNo);
          RcIfEvent.rxChkTimerAdd(); /* キー入力許可        */
        }
      }
    } else {
      if ((cMem.working.crdtReg.step ==
              KyCrdtInStep.INPUT_END.cd) && /* クレジット入力完了？*/
          ((cMem.working.crdtReg.stat & 0x0010) != 0)) /* クレジット承認？    */ {
        errNo = await RcFncChk.rcChkRPrinter();
        if (errNo != Typ.OK) {
          cMem.ent.errNo = errNo;
          await RcExt.rcErr('rcEndKyCrdtIn', cMem.ent.errNo);
          return;
        }
        if (CompileFlag.DEPARTMENT_STORE) {
          // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
          // if ((rcChk_Crdt_User() == NAKAGO_CRDT) &&
          //     (memcmp(cMem.ent.crdt_err_cd, "G30", 3) != 0)) {
          //   rxChkTimerRemove(); /* キー入力禁止 */
          //   rcCardCrew_NotInq_Prg();
          //   rcClearKy_Item();
          //   rcClearEntry();
          //   rcClearData_Reg();
          //   Ky_St_S4(cMem.key_stat[KY_CRDTIN]);
          //   cMem.stat.FncCode = cMem.working.crdt_reg.crdtkey;
          //   cMem.working.crdt_reg.step = INPUT_END;
          //   rcReMov_ScrMode();
          //   rcCrdt_ReDsp();
          //   cMem.working.crdt_reg.stat |= 0x1000;
          //   rcChargeAmount1();
          //   Ky_St_R4(cMem.key_stat[KY_CRDTIN]);
          // }
          // else {
          //   errNo = rcCrdt_InquProg(); /* 承認後問い合わせ    */
          //   if (errNo != OK) {
          //     rcClear_PopDisplay();
          //     rcClearErr_Stat();
          //     cMem.ent.errNo = errNo;
          //     rcErr(cMem.ent.errNo);
          //     rxChkTimerAdd(); /* キー入力許可        */
          //   }
          // }
        } else {
          errNo = RcCrdtFnc.rcCrdtInquProg(); /* 承認後問い合わせ    */
          if (errNo != Typ.OK) {
            // TODO:00012 平野 クレジット宣言：UI(ポップ画面クリア)
            // rcClear_PopDisplay();
            RcExt.rcClearErrStat('rcEndKyCrdtIn');
            cMem.ent.errNo = errNo;
            await RcExt.rcErr('rcEndKyCrdtIn', cMem.ent.errNo);
            RcIfEvent.rxChkTimerAdd(); /* キー入力許可        */
          }
        }
      }
    }
  }

  ///  関連tprxソース: rckycrdtin.c - rcChk_Crdt_Step
  static Future<int> rcChkCrdtStep() async {
    int errNo;
    String cdno = '';
    // TODO:00012 平野 クレジット宣言：後回し
    // char   *cd;
    // char   ckdg;
    // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
    // #if DEPARTMENT_STORE
    // char   buf[20];
    // #endif

    AcMem cMem = SystemFunc.readAcMem();

    errNo = Typ.FALSE;
    if ((cMem.stat.orgCode == RcCrdt.KEY_BREAK1) ||
        ((cMem.stat.fncCode == FuncKey.KY_CRDTIN.keyId) &&
            (!RcFncChk.rcChkTenOn()))) {
      cMem.working.crdtReg.step = KyCrdtInStep.INPUT_1ST.cd;
    }
    KyCrdtInStep define = KyCrdtInStep.getDefine(cMem.working.crdtReg.step);
    switch (define) {
      case KyCrdtInStep.INPUT_1ST:
        if ((await RcSysChk.rcCheckEntryCrdtMode()) ||
            (await RcSysChk.rcCheckEntryCrdtSystem())) {
          if (cMem.stat.orgCode != RcCrdt.KEY_BREAK1) {
            // 置数 + クレジットでの置数データへのチェック
            if (cMem.ent.tencnt > 7) {
              return DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
            }
            if (await RcCrdtFnc.rcGetCrdtPayAmount() != 0) {
              return DlgConfirmMsgKind.MSG_OPEACNTERR.dlgId;
            }
            if (Bcdtol.cmBcdToL(cMem.ent.entry) >
                (RxLogCalc.rxCalcStlTaxAmt(RegsMem()).abs())) {
              return DlgConfirmMsgKind.MSG_NOOVERKEEP.dlgId;
            }
            if ((RegsMem().tTtllog.t100001Sts.sptendCnt >=
                    (RcAcracb.SPTEND_MAX - 1)) &&
                (Bcdtol.cmBcdToL(cMem.ent.entry) <
                    (RxLogCalc.rxCalcStlTaxAmt(RegsMem()).abs()))) {
              return DlgConfirmMsgKind.MSG_LASTBUF.dlgId;
            }
          }
        }
        break;
      case KyCrdtInStep.CARD_KIND:
        if (cMem.ent.tencnt > RcCrdt.CARD_KIND_DGT) {
          errNo = DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
        }
        if (errNo == 0) {
          rcSetCardKind();
          errNo = await RcFlrd.rcReadCrdttblFL(
              RcCrdt.MANUAL_INPUT, RcCrdt.CARDCREW_OFF);
          if (errNo != 0) {
            cMem.working.crdtReg.cardKind = 0;
          }
        }
        break;
      case KyCrdtInStep.PLES_CARD:
        if (cMem.ent.tencnt > cMem.working.refData.crdtTbl.mbr_no_digit) {
          errNo = DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
        }
        if (errNo == 0) {
          if (!await rcChkCardIDorBUSINESS()) {
            errNo = DlgConfirmMsgKind.MSG_NOTUSECARD.dlgId;
          }
        }
        if (errNo == 0) {
          if (((!CompileFlag.MC_SYSTEM) &&
                  (await CmCksys.cmNttaspSystem() != 0)) ||
              (CompileFlag.MC_SYSTEM)) {
            if (RcCrdtFnc.rcSpecCkDigit()) {
              cdno = Bcdtoa.cmBcdToA(cMem.ent.entry, cMem.ent.entry.length);
              // TODO:10166 クレジット決済 20241004実装対象外
              // if (!CHK_MODULAS10(cm_BOA(cdno))) {
              //   errNo = DlgConfirmMsgKind.MSG_CARDNOCDERR.dlgId;
              // }
            }
          } else {
            if (RcCrdtFnc.rcSpecCkDigit()) {
              cdno = Bcdtoa.cmBcdToA(cMem.ent.entry, cMem.ent.entry.length);
              // TODO:10166 クレジット決済 20241004実装対象外
              // cd = cm_BOA(cdno);
              // ckdg = (cm_w2_modulas10(
              //     cm_BOA(cdno),
              //     cm_BOA(cMem.working.ref_data.crdttbl.ckdigit_wait),
              //     cMem.working.ref_data.crdttbl.mbr_no_digit));
              // if (ckdg != -1)
              //   ckdg |= 0x30;
              // if (*cd != ckdg)
              //   errNo = DlgConfirmMsgKind.MSG_CARDNOCDERR.dlgId;
            }
            // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
            // #if DEPARTMENT_STORE
            // else if(CMEM->working.ref_data.crdttbl.ckdigit_chk == 2) {
            // cm_clr(cdno, sizeof(cdno));
            // cm_clr(buf,  sizeof(buf ));
            // cm_bcdtoa(cdno, CMEM->ent.entry, sizeof(cdno), sizeof(CMEM->ent.entry));
            // cd = cm_BOA(cdno);
            // sprintf(buf, &cdno[(sizeof(CMEM->ent.entry)*2) - CMEM->working.ref_data.crdttbl.mbr_no_digit], CMEM->working.ref_data.crdttbl.mbr_no_digit);
            // ckdg = (cm_w27_modulas11(buf, CMEM->working.ref_data.crdttbl.ckdigit_wait, (CMEM->working.ref_data.crdttbl.mbr_no_digit - 1)));
            // /* チェックデジット分をサイズから引く */
            // if(ckdg != -1)
            // ckdg |= 0x30;
            // if(*cd != ckdg)
            // err_no = (short)MSG_CARDNOCDERR;
            // }
            // else if(CMEM->working.ref_data.crdttbl.ckdigit_chk == 3) {     /* モジュラス11特 */
            // cm_clr(cdno, sizeof(cdno));
            // cm_clr(buf,  sizeof(buf ));
            // cm_bcdtoa(cdno, CMEM->ent.entry, sizeof(cdno), sizeof(CMEM->ent.entry));
            // cd = cm_BOA(cdno);
            // sprintf(buf, &cdno[(sizeof(CMEM->ent.entry)*2) - CMEM->working.ref_data.crdttbl.mbr_no_digit], CMEM->working.ref_data.crdttbl.mbr_no_digit);
            // ckdg = (cm_w27_modulas11(buf, CMEM->working.ref_data.crdttbl.ckdigit_wait, (CMEM->working.ref_data.crdttbl.mbr_no_digit - 1)));
            // /* チェックデジット分をサイズから引く */
            // if(ckdg == 0)     /* 中合福島店対応：C/Dが0の場合1へ補正 */
            // ckdg = 1;
            // if(ckdg != -1)
            // ckdg |= 0x30;
            // if(*cd != ckdg)
            // err_no = (short)MSG_CARDNOCDERR;
            // }
            // #endif
          }
        }
        if (errNo == 0) {
          errNo = await RcCrdtFnc.rcChkCdNoFromTo();
        }
        break;
      case KyCrdtInStep.GOOD_THRU:
        if (cMem.ent.tencnt > RcCrdt.GOOD_THRU_DGT) {
          errNo = DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
        }
        if (errNo == 0) {
          errNo = await RcCrdtFnc.rcChkGoodThru();
        }
        if (errNo == 0) {
          if (!rcChkPayAWay()) {
            errNo = DlgConfirmMsgKind.MSG_PAYKIND_NOTSET.dlgId;
          }
        }
        break;
      case KyCrdtInStep.RECEIT_NO:
        if (cMem.ent.tencnt > RcCrdt.RECEIT_NO_DGT) {
          errNo = DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
        }
        break;
      case KyCrdtInStep.PAY_A_WAY:
        errNo = await rcUseKyPayAWay();
        if ((errNo != DlgConfirmMsgKind.MSG_NONPRESET.dlgId) &&
            (errNo != DlgConfirmMsgKind.MSG_DIVIDECOUNT_NOTSET.dlgId) &&
            (errNo != DlgConfirmMsgKind.MSG_HLIMITERR.dlgId) &&
            (errNo != DlgConfirmMsgKind.MSG_BONUSMONTH_NOTSET.dlgId)) {
          errNo = 0;
        }
        break;
      case KyCrdtInStep.DIV_BEGIN:
        errNo = rcUseKyPayBegin();
        if (errNo != DlgConfirmMsgKind.MSG_NONPRESET.dlgId) {
          errNo = 0;
        }
        break;
      case KyCrdtInStep.PAY_DIVID:
        errNo = await rcUseKyPayDivid();
        if ((errNo != DlgConfirmMsgKind.MSG_NONPRESET.dlgId) &&
            (errNo != DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId)) {
          errNo = 0;
        }
        break;
      case KyCrdtInStep.BONUS_TWO:
        errNo = await rcUseKyBonusTwo();
        if (errNo != DlgConfirmMsgKind.MSG_NONPRESET.dlgId) {
          errNo = 0;
        }
        break;
      case KyCrdtInStep.BNS_BEGIN:
        errNo = rcUseKyPayBegin();
        if (errNo != DlgConfirmMsgKind.MSG_NONPRESET.dlgId) {
          errNo = 0;
        }
        break;
      case KyCrdtInStep.BONUSUSE1:
        errNo = await rcUseKyBonusUse();
        if ((errNo != DlgConfirmMsgKind.MSG_NONPRESET.dlgId) &&
            (errNo != DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId)) {
          errNo = 0;
        }
        break;
      case KyCrdtInStep.BONUS_CNT:
        errNo = rcUseKyBonusCnt();
        if ((errNo != DlgConfirmMsgKind.MSG_NONPRESET.dlgId) &&
            (errNo != DlgConfirmMsgKind.MSG_NOT_CONDITION.dlgId)) {
          errNo = Typ.OK;
        }
        break;
      case KyCrdtInStep.BONUSUSE2:
        errNo = await rcUseKyBonusTwo();
        if (errNo != DlgConfirmMsgKind.MSG_NONPRESET.dlgId) {
          errNo = 0;
        }
        break;
      case KyCrdtInStep.PAY_KYCHA:
        break;
      case KyCrdtInStep.OFF_KYCHA:
        break;
      case KyCrdtInStep.RECOGN_NO:
        if (cMem.ent.tencnt > RcCrdt.RECOGN_NO_DGT) {
          errNo = DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
        }
        break;
      default:
        break;
    }
    return (errNo);
  }

  ///  関連tprxソース: rckycrdtin.c - rcSet_Card_Kind
  static void rcSetCardKind() {
    int cardCd;
    Uint8List kindCd = Uint8List(3); // char  kind_cd[3];
    int j = 0;

    AcMem cMem = SystemFunc.readAcMem();

    cMem.working.crdtReg.stat |= 0x0400;
    for (int i = 7; i < 7 + kindCd.length; i++) {
      // cm_mov((char *)kind_cd, &CMEM->ent.entry[7], sizeof(kind_cd));
      kindCd[j] = cMem.ent.entry[i];
      j++;
    }
    cardCd = Bcdtol.cmBcdToL(kindCd);
    if (CompileFlag.DEPARTMENT_STORE) {
      if ((cMem.stat.departFlg & 0x01) != 0) {
        /* 自社クレジット宣言中？ */
        if ((cardCd > 0) && (cardCd < 10)) {
          cardCd = 1000 + cardCd;
        }
      }
    }
    cMem.working.crdtReg.cardKind = cardCd;
  }

  ///  関連tprxソース: rckycrdtin.c - rcChk_Card_IDorBUSINESS
  static Future<bool> rcChkCardIDorBUSINESS() async {
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    if (atSing.inputbuf.dev == DevIn.D_MCD2) /* International JIS2 CARD */ {
      if ((await CmCksys.cmNttaspSystem() != 0) &&
          (cMem.working.refData.crdtTbl.company_cd == 99999)) {
        /* wildcard ? */
        return true;
      }

      if (cMem.working.refData.crdtTbl.id != atSing.inputbuf.Acode[1]) {
        return false;
      }
      if ((cMem.working.refData.crdtTbl.business + 30).toString() !=
          atSing.inputbuf.Acode[2]) {
        return false;
      }
    }
    return true;
  }

  ///  関連tprxソース: rckycrdtin.c - rcChk_Pay_A_Way
  static bool rcChkPayAWay() {
    AcMem cMem = SystemFunc.readAcMem();

    return ((cMem.working.refData.crdtTbl.lump == 1) ||
        (cMem.working.refData.crdtTbl.twice == 1) ||
        (cMem.working.refData.crdtTbl.divide == 1) ||
        (cMem.working.refData.crdtTbl.bonus_lump == 1) ||
        (cMem.working.refData.crdtTbl.bonus_twice == 1) ||
        (cMem.working.refData.crdtTbl.bonus_use == 1) ||
        // #if DEPARTMENT_STORE
        // (cMem.working.refData.crdtTbl.skip        == 1) ||
        // (cMem.working.refData.crdtTbl.fil2        == 1) ||
        // #endif
        (cMem.working.refData.crdtTbl.ribo == 1));
  }

  /// 開始月指定払いでの各月についてチェックを行っている
  /// 各月が設定されていて選択された？ 
  ///  関連tprxソース: rckycrdtin.c - rcUseKy_Pay_Begin
static int rcUseKyPayBegin() {
  AcMem cMem = SystemFunc.readAcMem();

  if ((cMem.working.crdtReg.step == KyCrdtInStep.DIV_BEGIN.cd) ||
      (cMem.working.crdtReg.step == KyCrdtInStep.BNS_BEGIN.cd)) {
    if (cMem.working.refData.crdtTbl.paymonth_input_chk != 0) {
      if (cMem.stat.orgCode == RcCrdt.NOMONTH) return RcCrdt.NOMONTH;
      if (cMem.stat.orgCode == RcCrdt.MONTH1) return RcCrdt.MONTH1;
      if (cMem.stat.orgCode == RcCrdt.MONTH2) return RcCrdt.MONTH2;
      if (cMem.stat.orgCode == RcCrdt.MONTH3) return RcCrdt.MONTH3;
      if (cMem.stat.orgCode == RcCrdt.MONTH4) return RcCrdt.MONTH4;
      if (cMem.stat.orgCode == RcCrdt.MONTH5) return RcCrdt.MONTH5;
      if (cMem.stat.orgCode == RcCrdt.MONTH6) return RcCrdt.MONTH6;
      if (cMem.stat.orgCode == RcCrdt.MONTH7) return RcCrdt.MONTH7;
      if (cMem.stat.orgCode == RcCrdt.MONTH8) return RcCrdt.MONTH8;
      if (cMem.stat.orgCode == RcCrdt.MONTH9) return RcCrdt.MONTH9;
      if (cMem.stat.orgCode == RcCrdt.MONTH10) return RcCrdt.MONTH10;
      if (cMem.stat.orgCode == RcCrdt.MONTH11) return RcCrdt.MONTH11;
      if (cMem.stat.orgCode == RcCrdt.MONTH12) return RcCrdt.MONTH12;
    }
  }
  return DlgConfirmMsgKind.MSG_NONPRESET.dlgId;
}

  /// 分割払いでの各回数についてチェックを行っている
  /// 各回数が設定されていて選択された？
  /// 各回数での支払上限額を超えていない？
  ///  関連tprxソース: rckycrdtin.c - rcUseKy_Pay_Divid
  static Future<int> rcUseKyPayDivid() async {
    AcMem cMem = SystemFunc.readAcMem();

    if (cMem.working.crdtReg.step == KyCrdtInStep.PAY_DIVID.cd) {
      if ((cMem.working.refData.crdtTbl.paymonth_input_chk != 0) &&
          (cMem.working.crdtReg.crdtTbl.paymonth_input_chk != 0) &&
          (cMem.stat.orgCode == RcCrdt.DIVIDE1)) {
        return RcCrdt.DIVIDE1;
      }
      if ((cMem.working.refData.crdtTbl.paymonth_input_chk != 0) &&
          (cMem.working.crdtReg.crdtTbl.paymonth_input_chk != 0) &&
          (cMem.stat.orgCode == RcCrdt.DIVIDE2)) {
        return RcCrdt.DIVIDE2;
      }
      if ((cMem.working.refData.crdtTbl.divide3 != 0) &&
          (cMem.stat.orgCode == RcCrdt.DIVIDE3)) {
        // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
        // #if DEPARTMENT_STORE
        // if(rcChk_Crdt_User() == NAKAGO_CRDT)
        // return(DIVIDE3);     /* 中合仕様の場合、個別割賦コードでフィールドの流用をしている為、チェックしない */
        // else {
        // #endif
        if (cMem.working.refData.crdtTbl.divide3_limit == 0) {
          return RcCrdt.DIVIDE3;
        }
        if (cMem.working.refData.crdtTbl.divide3_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.DIVIDE3;
        }
        // #if DEPARTMENT_STORE
        // }
        // #endif
      }
      if ((cMem.working.refData.crdtTbl.divide5 != 0) &&
          (cMem.stat.orgCode == RcCrdt.DIVIDE5)) {
        // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
        // #if DEPARTMENT_STORE
        // if(rcChk_Crdt_User() == NAKAGO_CRDT)
        // return(DIVIDE5);     /* 中合仕様の場合、フィールドの流用をしている為、チェックしない */
        // else {
        // #endif
        if (cMem.working.refData.crdtTbl.divide5_limit == 0) {
          return RcCrdt.DIVIDE5;
        }
        if (cMem.working.refData.crdtTbl.divide5_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.DIVIDE5;
        }
        // #if DEPARTMENT_STORE
        // }
        // #endif
      }
      if ((cMem.working.refData.crdtTbl.divide6 != 0) &&
          (cMem.stat.orgCode == RcCrdt.DIVIDE6)) {
        if (cMem.working.refData.crdtTbl.divide6_limit == 0) {
          return RcCrdt.DIVIDE6;
        }
        if (cMem.working.refData.crdtTbl.divide6_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.DIVIDE6;
        }
      }
      if ((cMem.working.refData.crdtTbl.divide10 != 0) &&
          (cMem.stat.orgCode == RcCrdt.DIVIDE10)) {
        if (cMem.working.refData.crdtTbl.divide10_limit == 0) {
          return RcCrdt.DIVIDE10;
        }
        if (cMem.working.refData.crdtTbl.divide10_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.DIVIDE10;
        }
      }
      if ((cMem.working.refData.crdtTbl.divide12 != 0) &&
          (cMem.stat.orgCode == RcCrdt.DIVIDE12)) {
        if (cMem.working.refData.crdtTbl.divide12_limit == 0) {
          return RcCrdt.DIVIDE12;
        }
        if (cMem.working.refData.crdtTbl.divide12_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.DIVIDE12;
        }
      }
      if ((cMem.working.refData.crdtTbl.divide15 != 0) &&
          (cMem.stat.orgCode == RcCrdt.DIVIDE15)) {
        if (cMem.working.refData.crdtTbl.divide15_limit == 0) {
          return RcCrdt.DIVIDE15;
        }
        if (cMem.working.refData.crdtTbl.divide15_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.DIVIDE15;
        }
      }
      if ((cMem.working.refData.crdtTbl.divide18 != 0) &&
          (cMem.stat.orgCode == RcCrdt.DIVIDE18)) {
        if (cMem.working.refData.crdtTbl.divide18_limit == 0) {
          return RcCrdt.DIVIDE18;
        }
        if (cMem.working.refData.crdtTbl.divide18_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.DIVIDE18;
        }
      }
      if ((cMem.working.refData.crdtTbl.divide20 != 0) &&
          (cMem.stat.orgCode == RcCrdt.DIVIDE20)) {
        if (cMem.working.refData.crdtTbl.divide20_limit == 0) {
          return RcCrdt.DIVIDE20;
        }
        if (cMem.working.refData.crdtTbl.divide20_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.DIVIDE20;
        }
      }
      if ((cMem.working.refData.crdtTbl.divide24 != 0) &&
          (cMem.stat.orgCode == RcCrdt.DIVIDE24)) {
        if (cMem.working.refData.crdtTbl.divide24_limit == 0) {
          return RcCrdt.DIVIDE24;
        }
        if (cMem.working.refData.crdtTbl.divide24_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.DIVIDE24;
        }
      }
      if ((cMem.working.refData.crdtTbl.divide30 != 0) &&
          (cMem.stat.orgCode == RcCrdt.DIVIDE30)) {
        if (cMem.working.refData.crdtTbl.divide30_limit == 0) {
          return RcCrdt.DIVIDE30;
        }
        if (cMem.working.refData.crdtTbl.divide30_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.DIVIDE30;
        }
      }
      if ((cMem.working.refData.crdtTbl.divide36 != 0) &&
          (cMem.stat.orgCode == RcCrdt.DIVIDE36)) {
        if (cMem.working.refData.crdtTbl.divide36_limit == 0) {
          return RcCrdt.DIVIDE36;
        }
        if (cMem.working.refData.crdtTbl.divide36_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.DIVIDE36;
        }
      }
      // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
      // #if DEPARTMENT_STORE
      // if((CMEM->working.ref_data.crdttbl.divide8) && (CMEM->stat.OrgCode == DIVIDE8))
      // return(DIVIDE8);
      // if((CMEM->working.ref_data.crdttbl.divide4) && (CMEM->stat.OrgCode == DIVIDE4))
      // return(DIVIDE4);
      // if((CMEM->working.ref_data.crdttbl.divide25) && (CMEM->stat.OrgCode == DIVIDE25))
      // return(DIVIDE25);
      // if((CMEM->working.ref_data.crdttbl.divide35) && (CMEM->stat.OrgCode == DIVIDE35))
      // return(DIVIDE35);
      // #endif
    }
    return DlgConfirmMsgKind.MSG_NONPRESET.dlgId;
  }

  /// ボーナス支払月についてチェックを行っている
  /// ボーナス支払月が設定されていて選択されたか？
  ///  関連tprxソース: rckycrdtin.c - rcUseKy_Bonus_Two
  static Future<int> rcUseKyBonusTwo() async {
    AcMem cMem = SystemFunc.readAcMem();

    if ((cMem.working.crdtReg.step == KyCrdtInStep.BONUS_TWO.cd) ||
        (cMem.working.crdtReg.step == KyCrdtInStep.BONUSUSE2.cd)) {
      // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
      // #if DEPARTMENT_STORE
      // if(rcChk_All_Season() == OK)
      // {
      //    if(CMEM->working.ref_data.crdttbl.summer_bonus_pay1) {
      //       if(CMEM->stat.OrgCode == S_B1_PAY1) return(S_B1_PAY1);
      //       if(CMEM->stat.OrgCode == S_B2_PAY1) return(S_B2_PAY1);
      //    }
      //    if(CMEM->working.ref_data.crdttbl.summer_bonus_pay2) {
      //       if(CMEM->stat.OrgCode == S_B1_PAY2) return(S_B1_PAY2);
      //       if(CMEM->stat.OrgCode == S_B2_PAY2) return(S_B2_PAY2);
      //    }
      //    if(CMEM->working.ref_data.crdttbl.summer_bonus_pay3) {
      //       if(CMEM->stat.OrgCode == S_B1_PAY3) return(S_B1_PAY3);
      //       if(CMEM->stat.OrgCode == S_B2_PAY3) return(S_B2_PAY3);
      //    }
      //    if(CMEM->working.ref_data.crdttbl.winter_bonus_pay1) {
      //       if(CMEM->stat.OrgCode == W_B1_PAY1) return(W_B1_PAY1);
      //       if(CMEM->stat.OrgCode == W_B2_PAY1) return(W_B2_PAY1);
      //    }
      //    if(CMEM->working.ref_data.crdttbl.winter_bonus_pay2) {
      //       if(CMEM->stat.OrgCode == W_B1_PAY2) return(W_B1_PAY2);
      //       if(CMEM->stat.OrgCode == W_B2_PAY2) return(W_B2_PAY2);
      //    }
      //    if(CMEM->working.ref_data.crdttbl.winter_bonus_pay3) {
      //       if(CMEM->stat.OrgCode == W_B1_PAY3) return(W_B1_PAY3);
      //       if(CMEM->stat.OrgCode == W_B2_PAY3) return(W_B2_PAY3);
      //    }
      // }
      // #endif
      if (await RcCrdtFnc.rcChkPaySeason()) {
        /* 1St. Bonus Pay Winter */
        if ((cMem.working.refData.crdtTbl.winter_bonus_pay1 != 0) &&
            (cMem.stat.orgCode == RcCrdt.W_B1_PAY1)) {
          return RcCrdt.W_B1_PAY1;
        }
        if ((cMem.working.refData.crdtTbl.winter_bonus_pay2 != 0) &&
            (cMem.stat.orgCode == RcCrdt.W_B1_PAY2)) {
          return RcCrdt.W_B1_PAY2;
        }
        if ((cMem.working.refData.crdtTbl.winter_bonus_pay3 != 0) &&
            (cMem.stat.orgCode == RcCrdt.W_B1_PAY3)) {
          return RcCrdt.W_B1_PAY3;
        }
        /* 2nd. Bonus Pay Summer */
        if ((cMem.working.refData.crdtTbl.summer_bonus_pay1 != 0) &&
            (cMem.stat.orgCode == RcCrdt.S_B2_PAY1)) {
          return RcCrdt.S_B2_PAY1;
        }
        if ((cMem.working.refData.crdtTbl.summer_bonus_pay2 != 0) &&
            (cMem.stat.orgCode == RcCrdt.S_B2_PAY2)) {
          return RcCrdt.S_B2_PAY2;
        }
        if ((cMem.working.refData.crdtTbl.summer_bonus_pay3 != 0) &&
            (cMem.stat.orgCode == RcCrdt.S_B2_PAY3)) {
          return RcCrdt.S_B2_PAY3;
        }
      } else {
        /* 1St. Bonus Pay Summer */
        if ((cMem.working.refData.crdtTbl.summer_bonus_pay1 != 0) &&
            (cMem.stat.orgCode == RcCrdt.S_B1_PAY1)) {
          return RcCrdt.S_B1_PAY1;
        }
        if ((cMem.working.refData.crdtTbl.summer_bonus_pay2 != 0) &&
            (cMem.stat.orgCode == RcCrdt.S_B1_PAY2)) {
          return RcCrdt.S_B1_PAY2;
        }
        if ((cMem.working.refData.crdtTbl.summer_bonus_pay3 != 0) &&
            (cMem.stat.orgCode == RcCrdt.S_B1_PAY3)) {
          return RcCrdt.S_B1_PAY3;
        }
        /* 2nd. Bonus Pay Winter */
        if ((cMem.working.refData.crdtTbl.winter_bonus_pay1 != 0) &&
            (cMem.stat.orgCode == RcCrdt.W_B2_PAY1)) {
          return RcCrdt.W_B2_PAY1;
        }
        if ((cMem.working.refData.crdtTbl.winter_bonus_pay2 != 0) &&
            (cMem.stat.orgCode == RcCrdt.W_B2_PAY2)) {
          return RcCrdt.W_B2_PAY2;
        }
        if ((cMem.working.refData.crdtTbl.winter_bonus_pay3 != 0) &&
            (cMem.stat.orgCode == RcCrdt.W_B2_PAY3)) {
          return RcCrdt.W_B2_PAY3;
        }
      }
    }
    return DlgConfirmMsgKind.MSG_NONPRESET.dlgId;
  }

  /// ボーナス併用払いでの各回数についてチェックを行っている
  /// 各回数が設定されていて選択された？
  /// 各回数での支払上限額を超えていない？
  ///  関連tprxソース: rckycrdtin.c - rcUseKy_Bonus_Use
  static Future<int> rcUseKyBonusUse() async {
    AcMem cMem = SystemFunc.readAcMem();

    if (cMem.working.crdtReg.step == KyCrdtInStep.BONUSUSE1.cd) {
      if ((cMem.working.refData.crdtTbl.bonus_use3 != 0) &&
          (cMem.stat.orgCode == RcCrdt.B_USE3)) {
        if (cMem.working.refData.crdtTbl.bonus_use3_limit == 0) {
          return RcCrdt.B_USE3;
        }
        if (cMem.working.refData.crdtTbl.bonus_use3_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.B_USE3;
        }
      }
      if ((cMem.working.refData.crdtTbl.bonus_use5 != 0) &&
          (cMem.stat.orgCode == RcCrdt.B_USE5)) {
        // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
        // if(rcChk_Crdt_User() == NAKAGO_CRDT)
        // return(B_USE5);     /* 中合仕様の場合、フィールドの流用をしている為、チェックしない */
        // else {
        if (cMem.working.refData.crdtTbl.bonus_use5_limit == 0) {
          return RcCrdt.B_USE5;
        }
        if (cMem.working.refData.crdtTbl.bonus_use5_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.B_USE5;
        }
        // }
      }
      if ((cMem.working.refData.crdtTbl.bonus_use6 != 0) &&
          (cMem.stat.orgCode == RcCrdt.B_USE6)) {
        if (cMem.working.refData.crdtTbl.bonus_use6_limit == 0) {
          return RcCrdt.B_USE6;
        }
        if (cMem.working.refData.crdtTbl.bonus_use6_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.B_USE6;
        }
      }
      if ((cMem.working.refData.crdtTbl.bonus_use10 != 0) &&
          (cMem.stat.orgCode == RcCrdt.B_USE10)) {
        if (cMem.working.refData.crdtTbl.bonus_use10_limit == 0) {
          return RcCrdt.B_USE10;
        }
        if (cMem.working.refData.crdtTbl.bonus_use10_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.B_USE10;
        }
      }
      if ((cMem.working.refData.crdtTbl.bonus_use12 != 0) &&
          (cMem.stat.orgCode == RcCrdt.B_USE12)) {
        if (cMem.working.refData.crdtTbl.bonus_use12_limit == 0) {
          return RcCrdt.B_USE12;
        }
        if (cMem.working.refData.crdtTbl.bonus_use12_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.B_USE12;
        }
      }
      if ((cMem.working.refData.crdtTbl.bonus_use15 != 0) &&
          (cMem.stat.orgCode == RcCrdt.B_USE15)) {
        if (cMem.working.refData.crdtTbl.bonus_use15_limit == 0) {
          return RcCrdt.B_USE15;
        }
        if (cMem.working.refData.crdtTbl.bonus_use15_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.B_USE15;
        }
      }
      if ((cMem.working.refData.crdtTbl.bonus_use18 != 0) &&
          (cMem.stat.orgCode == RcCrdt.B_USE18)) {
        if (cMem.working.refData.crdtTbl.bonus_use18_limit == 0) {
          return RcCrdt.B_USE18;
        }
        if (cMem.working.refData.crdtTbl.bonus_use18_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.B_USE18;
        }
      }
      if ((cMem.working.refData.crdtTbl.bonus_use20 != 0) &&
          (cMem.stat.orgCode == RcCrdt.B_USE20)) {
        if (cMem.working.refData.crdtTbl.bonus_use20_limit == 0) {
          return RcCrdt.B_USE20;
        }
        if (cMem.working.refData.crdtTbl.bonus_use20_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.B_USE20;
        }
      }
      if ((cMem.working.refData.crdtTbl.bonus_use24 != 0) &&
          (cMem.stat.orgCode == RcCrdt.B_USE24)) {
        if (cMem.working.refData.crdtTbl.bonus_use24_limit == 0) {
          return RcCrdt.B_USE24;
        }
        if (cMem.working.refData.crdtTbl.bonus_use24_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.B_USE24;
        }
      }
      if ((cMem.working.refData.crdtTbl.bonus_use30 != 0) &&
          (cMem.stat.orgCode == RcCrdt.B_USE30)) {
        if (cMem.working.refData.crdtTbl.bonus_use30_limit == 0) {
          return RcCrdt.B_USE30;
        }
        if (cMem.working.refData.crdtTbl.bonus_use30_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.B_USE30;
        }
      }
      if ((cMem.working.refData.crdtTbl.bonus_use36 != 0) &&
          (cMem.stat.orgCode == RcCrdt.B_USE36)) {
        if (cMem.working.refData.crdtTbl.bonus_use36_limit == 0) {
          return RcCrdt.B_USE36;
        }
        if (cMem.working.refData.crdtTbl.bonus_use36_limit >
            await RcCrdtFnc.rcGetCrdtPayAmount()) {
          return DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId;
        } else {
          return RcCrdt.B_USE36;
        }
      }
      // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
      // if((CMEM->working.ref_data.crdttbl.bonus_use8)  && (CMEM->stat.OrgCode == B_USE8))
      // return(B_USE8);
      // if((CMEM->working.ref_data.crdttbl.bonus_use4)  && (CMEM->stat.OrgCode == B_USE4))
      // return(DIVIDE4);
      // if((CMEM->working.ref_data.crdttbl.bonus_use25) && (CMEM->stat.OrgCode == B_USE25))
      // return(DIVIDE25);
      // if((CMEM->working.ref_data.crdttbl.bonus_use35) && (CMEM->stat.OrgCode == B_USE35))
      // return(DIVIDE35);
    }
    return DlgConfirmMsgKind.MSG_NONPRESET.dlgId;
  }

  ///  関連tprxソース: rckycrdtin.c - rcUseKy_Bonus_Cnt
  static int rcUseKyBonusCnt() {
    AcMem cMem = SystemFunc.readAcMem();
    int errNo;

    if (cMem.working.crdtReg.step == KyCrdtInStep.BONUS_CNT.cd) {
      switch (cMem.stat.orgCode) {
        case RcCrdt.BONUSCNT1:
          errNo = RcCrdt.BONUSCNT1;
          break;
        case RcCrdt.BONUSCNT2:
          errNo = RcCrdt.BONUSCNT2;
          break;
        case RcCrdt.BONUSCNT3:
          errNo = RcCrdt.BONUSCNT3;
          break;
        case RcCrdt.BONUSCNT4:
          errNo = RcCrdt.BONUSCNT4;
          break;
        case RcCrdt.BONUSCNT5:
          errNo = RcCrdt.BONUSCNT5;
          break;
        case RcCrdt.BONUSCNT6:
          errNo = RcCrdt.BONUSCNT6;
          break;
        default:
          errNo = DlgConfirmMsgKind.MSG_NONPRESET.dlgId;
          break;
      }
      return errNo;
    } else {
      return DlgConfirmMsgKind.MSG_NONPRESET.dlgId;
    }
  }

  ///  関連tprxソース: rckycrdtin.c - rcChk_CardCrewStep
  static Future<int> rcChkCardCrewStep() async {
    String log = '';
    int errNo = 0;
    // TODO:10166 クレジット決済 20241004実装対象外
    // char   cdno[sizeof(CMEM->ent.entry)*2];
    // char   *cd;
    // char   ckdg;
    // char   buf[20];

    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
    // #if DEPARTMENT_STORE
    // char   wait[] = {'3','2','9','8','7','6','5','4','3','2','0','0','0','0','0'};
    // char   *zero_ck;
    // int    i;
    // #endif

    errNo = Typ.OK;
    if ((cMem.stat.orgCode == RcCrdt.KEY_BREAK1) ||
        ((cMem.stat.fncCode == FuncKey.KY_CRDTIN.keyId) &&
            (!RcFncChk.rcChkTenOn()))) {
      cMem.working.crdtReg.step = KyCrdtInStep.INPUT_1ST.cd;
    }

    KyCrdtInStep define = KyCrdtInStep.getDefine(cMem.working.crdtReg.step);
    switch (define) {
      case KyCrdtInStep.INPUT_1ST:
        if ((await RcSysChk.rcCheckEntryCrdtMode()) ||
            (await RcSysChk.rcCheckEntryCrdtSystem())) {
          if (cMem.stat.orgCode != RcCrdt.KEY_BREAK1) {
            // 置数 + クレジットでの置数データへのチェック
            if (cMem.ent.tencnt > 7) {
              return DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
            }
            if (await RcCrdtFnc.rcGetCrdtPayAmount() != 0) {
              return DlgConfirmMsgKind.MSG_OPEACNTERR.dlgId;
            }
            if (Bcdtol.cmBcdToL(cMem.ent.entry) >
                (RxLogCalc.rxCalcStlTaxAmt(RegsMem()).abs())) {
              return DlgConfirmMsgKind.MSG_NOOVERKEEP.dlgId;
            }
            if ((RegsMem().tTtllog.t100001Sts.sptendCnt >=
                    (RcAcracb.SPTEND_MAX - 1)) &&
                (Bcdtol.cmBcdToL(cMem.ent.entry)) <
                    (RxLogCalc.rxCalcStlTaxAmt(RegsMem()).abs())) {
              return DlgConfirmMsgKind.MSG_LASTBUF.dlgId;
            }
          }
        }
        break;

      case KyCrdtInStep.CARD_KIND:
        if (cMem.ent.tencnt > RcCrdt.CARD_KIND_DGT) {
          errNo = DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
          return (errNo);
        }
        if (CompileFlag.DEPARTMENT_STORE) {
          // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
          // if((rcChk_Crdt_User() == NAKAGO_CRDT) && (CMEM->stat.Depart_Flg & 0x01)) {     /* 自社クレジット宣言中？ */
          // if(CMEM->ent.tencnt > 1) {
          // err_no = (short)MSG_INPUTOVER;
          // return(err_no);
          // }
          // }
        }
        /* クレジット小計割引する？ or カスミ仕様？ or 中合仕様？ならクレジット会社請求テーブルをリードする */
        // TODO:10166 クレジット決済 20241004実装対象外
        // if(((cBuf.dbTrm.crdtStlpdscOpe != 0) ||
        // rcChk_Crdt_User() == KASUMI_CRDT) ||
        // (rcChk_Crdt_User() == NAKAGO_CRDT))
        //   && (errNo == OK)) {
        // rcSet_Card_Kind();
        // errNo = rcRead_crdttbl_FL(MANUAL_INPUT, CARDCREW_ON);
        // }
        if (errNo != Typ.OK) {
          log = 'rcChkCardCrewStep() errNo = [$errNo]\n';
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log,
              errId: -1);
          cMem.working.crdtReg.stat &= ~0x0400;
        } else {
          // TODO:10166 クレジット決済 20241004実装対象外
          // if(rcChk_Crdt_User() == KASUMI_CRDT)
          //     rcSet_KasumiCard(KASUMI_AEON);
        }
        if ((RcSysChk.rcChkCrdtUser() != Datas.KASUMI_CRDT) &&
            (RcSysChk.rcChkCrdtUser() != Datas.NAKAGO_CRDT)) {
          errNo = Typ.OK;
        }
        break;
      case KyCrdtInStep.PLES_CARD:
        if (await RcSysChk.rcChkEMVCreditSystem()) {
          /* クレジットEMV仕様の場合、カード番号のチェックはしない */
          break;
        }

        if (cMem.ent.tencnt > RcCrdt.MEMBER_NO_DGT) {
          errNo = DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
        }
        if (errNo == 0) {
          errNo = rcChkCdNo();
        }

        if ((errNo == 0) &&
            ((cMem.working.crdtReg.stat & 0x0400) != 0)) /* マニュアル入力中？ */ {
          if (CompileFlag.DEPARTMENT_STORE) {
            // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
            // cm_clr(cdno, sizeof(cdno));
            // cm_bcdtoa(cdno, CMEM->ent.entry, sizeof(cdno), sizeof(CMEM->ent.entry));
            // zero_ck = cm_BOA(cdno);
            // CMEM->ent.tencnt = cm_chk_zero0(CMEM->ent.entry, sizeof(CMEM->ent.entry));
            // switch(CMEM->working.crdt_reg.card_kind)
            // {
            // case 1 : /* OMC        */
            // if(CMEM->ent.tencnt == 11) {
            // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "OMC_11_Card Use\n");
            // CMEM->working.ref_data.crdttbl.ckdigit_chk = 2;
            // CMEM->working.ref_data.crdttbl.mbr_no_digit = 11;
            // memset(CMEM->working.ref_data.crdttbl.ckdigit_wait, 0x0, sizeof(CMEM->working.ref_data.crdttbl.ckdigit_wait));
            // memcpy(CMEM->working.ref_data.crdttbl.ckdigit_wait, wait, sizeof(CMEM->working.ref_data.crdttbl.ckdigit_wait));
            // }
            // else if(CMEM->ent.tencnt == 10) {
            // for(i = 0; i < CMEM->ent.tencnt; i++)
            // zero_ck --;
            // if(*zero_ck == '0') {
            // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "OMC_11_Card Use\n");
            // CMEM->working.ref_data.crdttbl.ckdigit_chk = 0;
            // }
            // }
            // break;
            // case 3 : /* JACCS      */
            // if(CMEM->ent.tencnt == 14) {
            // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "JACCS_14_Card Use\n");
            // CMEM->working.ref_data.crdttbl.ckdigit_chk = 0;
            // }
            // else if(CMEM->ent.tencnt == 13) {
            // for(i = 0; i < CMEM->ent.tencnt; i++)
            // zero_ck --;
            // if(*zero_ck == '0') {
            // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "JACCS_14_Card Use\n");
            // CMEM->working.ref_data.crdttbl.ckdigit_chk = 0;
            // }
            // }
            // break;
            // case 15 : /* セントラル */
            // if(CMEM->ent.tencnt == 12) {
            // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "CF_12_Card Use\n");
            // CMEM->working.ref_data.crdttbl.ckdigit_chk = 0;
            // }
            // else if(CMEM->ent.tencnt == 11) {
            // for(i = 0; i < CMEM->ent.tencnt; i++)
            // zero_ck --;
            // if(*zero_ck == '0') {
            // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "CF_12_Card Use\n");
            // CMEM->working.ref_data.crdttbl.ckdigit_chk = 0;
            // }
            // }
            // break;
            // case 22 : /* 山ぎんJCB  or 日専連札幌 */
            // if((CMEM->ent.tencnt == 10) || (CMEM->ent.tencnt == 12)) {
            // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "YAMAGIN_10_Card or NISSEN_12_Card Use\n");
            // CMEM->working.ref_data.crdttbl.ckdigit_chk = 0;
            // }
            // else if((CMEM->ent.tencnt == 9) || (CMEM->ent.tencnt == 11)) {
            // for(i = 0; i < CMEM->ent.tencnt; i++)
            // zero_ck --;
            // if(*zero_ck == '0') {
            // TprLibLogWrite(GetTid(), TPRLOG_NORMAL, 0, "YAMAGIN_10_Card or NISSEN_12_Card Use\n");
            // CMEM->working.ref_data.crdttbl.ckdigit_chk = 0;
            // }
            // }
            // break;
            // default : break;
            // }
          }
          // TODO:10166 クレジット決済 20241004実装対象外
          // if(rcChk_CAPS_CAFIS_System()) {
          // cm_clr(cdno, sizeof(cdno));
          // cm_clr(buf, sizeof(buf));
          // cm_bcdtoa(cdno, cMem.ent.entry, sizeof(cdno), sizeof(cMem.ent.entry));
          // cm_mov(buf, &cdno[4], 6);
          // cMem.working.crdtReg.company_cd = atol(buf);
          // errNo = rcRead_crdttbl_FL(MANUAL_INPUT, CARDCREW_OFF);
          // if(errNo) {
          // cMem.working.crdtReg.step = (PLES_CARD-1);
          // break;
          // }
          // }
          //
          // if(rcSpec_Ck_Digit()) {
          // cm_clr(cdno, sizeof(cdno));
          // cm_bcdtoa(cdno, cMem.ent.entry, sizeof(cdno), sizeof(cMem.ent.entry));
          // cd = cm_BOA(cdno);
          // ckdg = (cm_w2_modulas10(cm_BOA(cdno), cm_BOA(cMem.working.ref_data.crdttbl.ckdigit_wait), cMem.working.ref_data.crdttbl.mbr_no_digit));
          // if(ckdg != -1)
          // ckdg |= 0x30;
          // if(*cd != ckdg)
          // errNo = (short)DlgConfirmMsgKind.MSG_CARDNOCDERR;
          // }

          // TODO:10118 コンパイルスイッチ(DEPARTMENT_STORE)
          // #if DEPARTMENT_STORE
          // else if(CMEM->working.ref_data.crdttbl.ckdigit_chk == 2) {
          // cm_clr(cdno, sizeof(cdno));
          // cm_clr(buf,  sizeof(buf ));
          // cm_bcdtoa(cdno, CMEM->ent.entry, sizeof(cdno), sizeof(CMEM->ent.entry));
          // cd = cm_BOA(cdno);
          // sprintf(buf, &cdno[(sizeof(CMEM->ent.entry)*2) - CMEM->working.ref_data.crdttbl.mbr_no_digit], CMEM->working.ref_data.crdttbl.mbr_no_digit);
          // ckdg = (cm_w27_modulas11(buf, CMEM->working.ref_data.crdttbl.ckdigit_wait, (CMEM->working.ref_data.crdttbl.mbr_no_digit - 1)));
          // /* チェックデジット分をサイズから引く */
          // if(ckdg != -1)
          // ckdg |= 0x30;
          // if(*cd != ckdg)
          // err_no = (short)MSG_CARDNOCDERR;
          // }
          // else if(CMEM->working.ref_data.crdttbl.ckdigit_chk == 3) {     /* モジュラス11特 */
          // cm_clr(cdno, sizeof(cdno));
          // cm_clr(buf,  sizeof(buf ));
          // cm_bcdtoa(cdno, CMEM->ent.entry, sizeof(cdno), sizeof(CMEM->ent.entry));
          // cd = cm_BOA(cdno);
          // sprintf(buf, &cdno[(sizeof(CMEM->ent.entry)*2) - CMEM->working.ref_data.crdttbl.mbr_no_digit], CMEM->working.ref_data.crdttbl.mbr_no_digit);
          // ckdg = (cm_w27_modulas11(buf, CMEM->working.ref_data.crdttbl.ckdigit_wait, (CMEM->working.ref_data.crdttbl.mbr_no_digit - 1)));
          // /* チェックデジット分をサイズから引く */
          // if(ckdg == 0)     /* 中合福島店対応：C/Dが0の場合1へ補正 */
          // ckdg = 1;
          // if(ckdg != -1)
          // ckdg |= 0x30;
          // if(*cd != ckdg)
          // err_no = (short)MSG_CARDNOCDERR;
          // }
          // #endif
        }
        break;
      case KyCrdtInStep.GOOD_THRU:
        if (cMem.ent.tencnt > RcCrdt.GOOD_THRU_DGT) {
          errNo = DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
        }
        if ((errNo == 0) && (await RcSysChk.rcChkCapsCafisStandardSystem())) {
          errNo = await RcCrdtFnc.rcChkGoodThru();
        }
        if (errNo == 0) {
          if ((cMem.working.crdtReg.stat & 0x0400) != 0) {
            /* マニュアル入力中？ */
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                "rcChkCardCrewStep(): CHK_GOOD_THRU\n");
            errNo = await RcCrdtFnc.rcChkGoodThru();
            if (errNo == 0) {
              cMem.working.crdtReg.stat &= ~0x0400;
            }
          }
        }
        break;
      case KyCrdtInStep.RECEIT_NO:
        if (await CmCksys.cmCapsPqvicSystem() != 0) {
          if (cMem.ent.tencnt > RcCrdt.PQVIC_RECEIT_NO_DGT) {
            errNo = DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
          }
        } else {
          if (cMem.ent.tencnt > RcCrdt.RECEIT_NO_DGT) {
            errNo = DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
          }
        }
        break;
      case KyCrdtInStep.PAY_A_WAY:
        errNo = await rcUseKyPayAWay();
        if ((errNo != DlgConfirmMsgKind.MSG_NONPRESET.dlgId) &&
            (errNo != DlgConfirmMsgKind.MSG_DIVIDECOUNT_NOTSET.dlgId) &&
            (errNo != DlgConfirmMsgKind.MSG_HLIMITERR.dlgId) &&
            (errNo != DlgConfirmMsgKind.MSG_BONUSMONTH_NOTSET.dlgId)) {
          errNo = Typ.OK;
        }
        break;
      case KyCrdtInStep.DIV_BEGIN:
        errNo = rcUseKyPayBegin();
        if (errNo != DlgConfirmMsgKind.MSG_NONPRESET.dlgId) {
          errNo = Typ.OK;
        }
        break;
      case KyCrdtInStep.PAY_DIVID:
        errNo = await rcUseKyPayDivid();
        if ((errNo != DlgConfirmMsgKind.MSG_NONPRESET.dlgId) &&
            (errNo != DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId)) {
          errNo = Typ.OK;
        }
        break;
      case KyCrdtInStep.BONUS_TWO:
        errNo = await rcUseKyBonusTwo();
        if (errNo != DlgConfirmMsgKind.MSG_NONPRESET.dlgId) {
          errNo = Typ.OK;
        }
        break;
      case KyCrdtInStep.BNS_BEGIN:
        errNo = rcUseKyPayBegin();
        if (errNo != DlgConfirmMsgKind.MSG_NONPRESET.dlgId) {
          errNo = Typ.OK;
        }
        break;
      case KyCrdtInStep.BONUSUSE1:
        errNo = await rcUseKyBonusUse();
        if ((errNo != DlgConfirmMsgKind.MSG_NONPRESET.dlgId) &&
            (errNo != DlgConfirmMsgKind.MSG_DIVIDELIMIT_OVER.dlgId)) {
          errNo = Typ.OK;
        }
        break;
      case KyCrdtInStep.BONUS_CNT:
        errNo = rcUseKyBonusCnt();
        if ((errNo != DlgConfirmMsgKind.MSG_NONPRESET.dlgId) &&
            (errNo != DlgConfirmMsgKind.MSG_NOT_CONDITION.dlgId)) {
          errNo = Typ.OK;
        }
        break;
      case KyCrdtInStep.BONUSUSE2:
        errNo = await rcUseKyBonusTwo();
        if (errNo != DlgConfirmMsgKind.MSG_NONPRESET.dlgId) {
          errNo = Typ.OK;
        }
        break;
      case KyCrdtInStep.PAY_KYCHA:
        break;
      case KyCrdtInStep.OFF_KYCHA:
        break;
      case KyCrdtInStep.RECOGN_NO:
        if (await CmCksys.cmCapsPqvicSystem() != 0) {
          if (cMem.ent.tencnt > RcCrdt.PQVIC_RECOGN_NO_DGT) {
            errNo = DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
          }
        } else {
          if (cMem.ent.tencnt > RcCrdt.RECOGN_NO_DGT) {
            errNo = DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
          }
        }
        break;
      default:
        break;
    }
    return (errNo);
  }

  ///  関連tprxソース: rckycrdtin.c - rcChk_CdNo
  static int rcChkCdNo() {
    String cdno = ""; // char      cdno[sizeof(CMEM->ent.entry)*2];
    String cardNo = ""; // char      card_no[MEMBER_NO_DGT+1];
    int cardNoLl = 0;
    int i;

    AcMem cMem = SystemFunc.readAcMem();

    cdno = Bcdtoa.cmBcdToA(cMem.ent.entry, cMem.ent.entry.length);

    cardNo = cdno;
    cardNoLl = int.parse(cardNo);

    if (cardNoLl < 1) {
      return (DlgConfirmMsgKind.MSG_CARDNOCDERR.dlgId);
    }

    for (i = 0; i < RcCrdt.MEMBER_NO_DGT; i++) {
      if ((int.parse(cardNo[i]) < 0) || (int.parse(cardNo[i]) > 9)) {
        return (DlgConfirmMsgKind.MSG_CARDNOCDERR.dlgId);
      }
    }

    // TODO:10166 クレジット決済 20241004実装対象外
    // if( rcChk_CAPS_CAFIS_System() && cm_dcmpoint_system() ) {
    //   if(MEM->tTtllog.t100700.mbr_input) {
    //     if( ((cm_mcd_Check_TS3(MEM->tHeader.cust_no) == TS3_DAIKI_MBR_CRDT) &&
    //         (cm_mcd_Check_TS3(&cdno[4])            != TS3_DAIKI_MBR_CRDT)    ) ||
    //         (memcmp(MEM->tHeader.cust_no, &cdno[4], cm_mbrcd_len()) != 0)           )
    //     {
    //       rcClearCrdt_Reg();
    //       CMEM->working.crdt_reg.step = (PLES_CARD-1);
    //       return(MSG_CRDTNO_NOTAGREE);    /* "カード番号が一致しません" */
    //     }
    //   }
    //   else {
    //     if(cm_mcd_Check_TS3(&cdno[4]) == TS3_DAIKI_MBR_CRDT) {
    //        rcClearCrdt_Reg();
    //         CMEM->working.crdt_reg.step = (PLES_CARD-1);
    //         return(MSG_CALL_RLSMBR);    /* "会員カード呼出をして下さい" */
    //     }
    //   }
    // }

    return Typ.OK;
  }

  /// int型をBCDに変換する
  static Uint8List cmLtobcd(int hex, int size) {
    int uint4Size = (size / 2).ceil();
    Uint8List bcd = Uint8List(uint4Size);
    List<String> reverseHex = [];
    for (int i = 0; 0 < hex; hex ~/= 10, i++) {
      reverseHex.add((hex % 10).toString());
    }

    int target = uint4Size - 1;
    bool isFirst = true;
    for (int i = 0; i < reverseHex.length; i++) {
      int digit = (int.parse(reverseHex.elementAt(i), radix: 16) & 0x0F);

      if (i % 2 == 0) {
        bcd[target] = bcd[target] | digit;
        if (isFirst) {
          isFirst = false;
        } else {
          target = target - 1;
        }
      } else {
        bcd[target] = bcd[target] << 4;
        bcd[target] = bcd[target] | digit;
      }
    }

    return bcd;
  }

  ///  関連tprxソース: rckycrdtin.c - rcChk_Divid_Cnt
  static bool rcChkDividCnt() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.working.refData.crdtTbl.divide3 == 1) ||
        (cMem.working.refData.crdtTbl.divide5 == 1) ||
        (cMem.working.refData.crdtTbl.divide6 == 1) ||
        (cMem.working.refData.crdtTbl.divide10 == 1) ||
        (cMem.working.refData.crdtTbl.divide12 == 1) ||
        (cMem.working.refData.crdtTbl.divide15 == 1) ||
        (cMem.working.refData.crdtTbl.divide18 == 1) ||
        (cMem.working.refData.crdtTbl.divide20 == 1) ||
        (cMem.working.refData.crdtTbl.divide24 == 1) ||
        (cMem.working.refData.crdtTbl.divide30 == 1) ||
        (cMem.working.refData.crdtTbl.divide36 == 1));
  }

  ///  関連tprxソース: rckycrdtin.c - rcChk_BoUse_Cnt
  static bool rcChkBoUseCnt() {
    AcMem cMem = SystemFunc.readAcMem();
    return ((cMem.working.refData.crdtTbl.bonus_use3 == 1) ||
        (cMem.working.refData.crdtTbl.bonus_use5 == 1) ||
        (cMem.working.refData.crdtTbl.bonus_use6 == 1) ||
        (cMem.working.refData.crdtTbl.bonus_use10 == 1) ||
        (cMem.working.refData.crdtTbl.bonus_use12 == 1) ||
        (cMem.working.refData.crdtTbl.bonus_use15 == 1) ||
        (cMem.working.refData.crdtTbl.bonus_use18 == 1) ||
        (cMem.working.refData.crdtTbl.bonus_use20 == 1) ||
        (cMem.working.refData.crdtTbl.bonus_use24 == 1) ||
        (cMem.working.refData.crdtTbl.bonus_use30 == 1) ||
        (cMem.working.refData.crdtTbl.bonus_use36 == 1));
  }

  ///  関連tprxソース: rckycrdtin.c - rcChk_Bonus_Mth
  static Future<bool> rcChkBonusMth() async {
    AcMem cMem = SystemFunc.readAcMem();
    if (RcCrdtFnc.rcSpecBonusMthInput()) {
      if (!(((cMem.working.refData.crdtTbl.winter_bonus_pay1 !=
                  0) || /* 冬ボーナス     */
              (cMem.working.refData.crdtTbl.winter_bonus_pay2 !=
                  0) || /* 支払月未設定？ */
              (cMem.working.refData.crdtTbl.winter_bonus_pay3 != 0)) &&
          ((cMem.working.refData.crdtTbl.summer_bonus_pay1 !=
                  0) || /* 夏ボーナス     */
              (cMem.working.refData.crdtTbl.summer_bonus_pay2 !=
                  0) || /* 支払月未設定？ */
              (cMem.working.refData.crdtTbl.summer_bonus_pay3 != 0)))) {
        return false;
      }
    } else {
      if ((await CmCksys.cmNttaspSystem()) != 0) {
        cMem.working.refData.crdtTbl.summer_bonus_pay1 = 8; /* 未入力時８月   */
        cMem.working.refData.crdtTbl.winter_bonus_pay1 = 2; /* 未入力時２月   */
      }
    }
    return true;
  }

  ///  関連tprxソース: rckycrdtin.c - rcUseKy_Pay_A_Way
  static Future<int> rcUseKyPayAWay() async {
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.working.crdtReg.step == KyCrdtInStep.PAY_A_WAY.cd) {
      /* 一括払いが設定されていて選択されたか */
      if ((cMem.working.refData.crdtTbl.lump != 0) &&
          (cMem.stat.orgCode == RcCrdt.LUMP)) {
        return RcCrdt.LUMP;
      }

      /* ２回払いが設定されていて選択されたか */
      if ((cMem.working.refData.crdtTbl.twice != 0) &&
          (cMem.stat.orgCode == RcCrdt.TWICE)) {
        return RcCrdt.TWICE;
      }

      /* 分割払いが設定されていて選択されたか */
      if ((cMem.working.refData.crdtTbl.divide != 0) &&
          (cMem.stat.orgCode == RcCrdt.DIVIDE)) {
        /* 回数が未設定？ */
        if (rcChkDividCnt()) {
          return RcCrdt.DIVIDE;
        } else {
          return DlgConfirmMsgKind.MSG_DIVIDECOUNT_NOTSET.dlgId;
        }
      }

      /* ボーナス一括払いが設定されていて選択されたか */
      if ((cMem.working.refData.crdtTbl.bonus_lump != 0) &&
          (cMem.stat.orgCode == RcCrdt.B_LUMP)) {
        if (cMem.working.refData.crdtTbl.bonus_lump_limit != 0) {
          if (cMem.working.refData.crdtTbl.bonus_lump_limit >
              (await RcCrdtFnc.rcGetCrdtPayAmount())) {
            return DlgConfirmMsgKind.MSG_HLIMITERR.dlgId;
          }
        }
        return RcCrdt.B_LUMP;
      }

      /* ボーナス２回払いが設定されていて選択されたか */
      if ((cMem.working.refData.crdtTbl.bonus_twice != 0) &&
          (cMem.stat.orgCode == RcCrdt.B_TWICE)) {
        if (await rcChkBonusMth()) {
          if (cMem.working.refData.crdtTbl.bonus_twice_limit != 0) {
            if (cMem.working.refData.crdtTbl.bonus_twice_limit >
                (await RcCrdtFnc.rcGetCrdtPayAmount())) {
              return DlgConfirmMsgKind.MSG_HLIMITERR.dlgId;
            }
          }
          return RcCrdt.B_TWICE;
        } else {
          return DlgConfirmMsgKind.MSG_BONUSMONTH_NOTSET.dlgId;
        }
      }

      /* ボーナス併用払いが設定されていて選択されたか */
      if ((cMem.working.refData.crdtTbl.bonus_use != 0) &&
          (cMem.stat.orgCode == RcCrdt.B_USE)) {
        if (await rcChkBonusMth()) {
          /* 回数が未設定？ */
          if (rcChkBoUseCnt()) {
            return RcCrdt.B_USE;
          } else {
            return DlgConfirmMsgKind.MSG_DIVIDECOUNT_NOTSET.dlgId;
          }
        } else {
          return DlgConfirmMsgKind.MSG_BONUSMONTH_NOTSET.dlgId;
        }
      }

      /* リボ払いが設定されていて選択されたか */
      if ((cMem.working.refData.crdtTbl.ribo != 0) &&
          (cMem.stat.orgCode == RcCrdt.RIBO)) {
        return RcCrdt.RIBO;
      }
    }
    return DlgConfirmMsgKind.MSG_NONPRESET.dlgId;
  }

  ///  関連tprxソース: rckycrdtin.c - rcSet_Pay_A_Way
  static Future<bool> rcSetPayAWay() async {
    AcMem cMem = SystemFunc.readAcMem();
    var stat = false;
    var kind = await rcUseKyPayAWay();
    switch (kind) {
      case RcCrdt.LUMP:
        cMem.working.crdtReg.crdtTbl.lump = 1;
        stat = true;
        break;
      case RcCrdt.TWICE:
        cMem.working.crdtReg.crdtTbl.twice = 1;
        stat = true;
        break;
      case RcCrdt.DIVIDE:
        cMem.working.crdtReg.crdtTbl.divide = 1;
        stat = false;
        break;
      case RcCrdt.B_LUMP:
        if (await CmCksys.cmNttaspSystem() == 0) {
          cMem.working.crdtReg.crdtTbl.bonus_lump = 1;
          stat = true;
        } else {
          cMem.working.crdtReg.crdtTbl.bonus_lump = 1;
          if (RcCrdtFnc.rcSpecBonusMthInput()) {
            stat = false;
          } else {
            stat = true;
          }
        }
        break;
      case RcCrdt.B_TWICE:
        cMem.working.crdtReg.crdtTbl.bonus_twice = 1;
        if (RcCrdtFnc.rcSpecBonusMthInput()) {
          stat = false;
        } else {
          stat = true;
        }
        break;
      case RcCrdt.B_USE:
        cMem.working.crdtReg.crdtTbl.bonus_use = 1;
        stat = false;
        break;
      case RcCrdt.RIBO:
        cMem.working.crdtReg.crdtTbl.ribo = 1;
        stat = true;
        break;
    }
    if (((await CmCksys.cmSm3MaruiSystem()) == 0) ||
        (((await CmCksys.cmSm3MaruiSystem()) != 0) &&
            (cMem.working.refData.crdtTbl.lump == 0))) {
      cMem.working.crdtReg.step = cMem.working.crdtReg.step - 1;
      await RcCrdtDsp.rcCrdtStepDisp();
    }

    switch (kind) {
      case RcCrdt.DIVIDE:
        if ((await RcSysChk.rcChkCapsCafisStandardSystem()) &&
            (cMem.working.refData.crdtTbl.pay_autoinput_chk == 1)) {
          cMem.working.crdtReg.step = (KyCrdtInStep.DIV_BEGIN.cd - 1);
        } else {
          cMem.working.crdtReg.step = (KyCrdtInStep.PAY_DIVID.cd - 1);
        }
        break;

      case RcCrdt.B_LUMP:
        if ((await CmCksys.cmNttaspSystem()) != 0) {
          cMem.working.crdtReg.step = (KyCrdtInStep.PAY_KYCHA.cd - 1);
        } else {
          if (stat == false) {
            cMem.working.crdtReg.step = (KyCrdtInStep.BONUS_TWO.cd - 1);
          } else {
            cMem.working.crdtReg.step = (KyCrdtInStep.PAY_KYCHA.cd - 1);
          }
        }
        break;

      case RcCrdt.B_TWICE:
        if (stat == false) {
          cMem.working.crdtReg.step = (KyCrdtInStep.BONUS_TWO.cd - 1);
        } else {
          cMem.working.crdtReg.step = (KyCrdtInStep.PAY_KYCHA.cd - 1);
        }
        break;

      case RcCrdt.B_USE:
        if ((await RcSysChk.rcChkCapsCafisStandardSystem()) &&
            (cMem.working.refData.crdtTbl.pay_autoinput_chk == 1)) {
          cMem.working.crdtReg.step = (KyCrdtInStep.BNS_BEGIN.cd - 1);
        } else {
          cMem.working.crdtReg.step = (KyCrdtInStep.BONUSUSE1.cd - 1);
        }
        break;

      default:
        cMem.working.crdtReg.step = (KyCrdtInStep.PAY_KYCHA.cd - 1);
        break;
    }
    return (stat);
  }

  ///  関連tprxソース: rckycrdtin.c - rcEnd_Crdt_Step
  static Future<void> rcEndCrdtStep() async {
    AcMem cMem = SystemFunc.readAcMem();

    if (cMem.working.crdtReg.cardDiv == '3') {
      if (await CmCksys.cmNttaspSystem() == 0) {
        CrdtMAanal cm2 = CrdtMAanal();
        cm2.mbrNo = cMem.working.crdtReg.cdno;

        Uint8List aKind2 = cmLtobcd(cMem.working.crdtReg.cardKind, 5);
        String bKind2 = SupAsc.cmSetupAsc(0, aKind2, 5);
        cm2.cdKind = bKind2;

        Uint8List aDate2 = cmLtobcd(int.parse(cMem.working.crdtReg.date), 2);
        String bDate2 = SupAsc.cmSetupAsc(0, aDate2, 4);
        cm2.insLim = bDate2;
        cMem.working.crdtReg.jis2 = cm2;

        CrdtMAanal cm1 = CrdtMAanal();
        cm1.mbrNo = cMem.working.crdtReg.cdno;

        Uint8List aKind1 = cmLtobcd(cMem.working.crdtReg.cardKind, 5);
        String bKind1 = SupAsc.cmSetupAsc(0, aKind1, 5);
        cm1.cdKind = bKind1;

        Uint8List aDate1 = cmLtobcd(int.parse(cMem.working.crdtReg.date), 2);
        String bDate1 = SupAsc.cmSetupAsc(0, aDate1, 4);
        cm2.insLim = bDate1;

        cMem.working.crdtReg.jis1 = cm1;
      }
    }
    cMem.working.crdtReg.step = KyCrdtInStep.INPUT_END.cd;
  }

  ///  関連tprxソース: rckycrdtin.c - rcCardCrew_InpPrg
  static Future<void> rcCardCrewInpPrg() async {
    AcMem cMem = SystemFunc.readAcMem();

    var errNo = Typ.OK;
    errNo = await rcChkKyCrdtIn(0);
    if (errNo == Typ.OK) {
      await rcSetGoodThru();
      RcCrdtDsp.rcCrdtInquDisp();
      errNo = await RcCardCrew.rcCardCrewInquWtxt(RcCrdt.CARD_REQ);
    }
    if (errNo == Typ.OK) {
      // todo クレ宣言　暫定対応6 rcGtkTimerAddが実装されていないため
      // errNo = RcGtkTimer.rcGtkTimerAdd(100, RcCardCrew.rcCardCrewInquCard);
      errNo = await RcCardCrew.rcCardCrewInquCard();
    }
    if (errNo != Typ.OK) {
      cMem.ent.errNo = errNo;
      if (!((await RcFncChk.rcCheckCrdtVoidMode()))) {
        await RcExt.rcErr("rcCardCrewInpPrg", cMem.ent.errNo);
      }
      await RcIfEvent.rxChkTimerAdd(); /* キー入力許可 */
    }
  }

  ///  関連tprxソース: rckycrdtin.c - rcSet_Good_Thru
  static Future<bool> rcSetGoodThru() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    if ((RcCrdt.CHK_DEVICE_MCD()) ||
        (cBuf.dbTrm.goodThruDsp == 1)) /* MCD or YYMM spec.? */
    {
      cMem.working.crdtReg.date =
          cMem.ent.entry.sublist(4, 5).toString(); /* Copy YYMM */
    } else {
      var mmyy = cMem.ent.entry.sublist(4, 5).toString();

      cMem.working.crdtReg.date =
          mmyy.split('').reversed.join(''); /* Copy YYMM */
    }
    if (!(await RcCrdtFnc.rcChkCrdtCancel())) {
      cMem.working.crdtReg.step = (KyCrdtInStep.PAY_A_WAY.cd - 1);
    }
    return (false);
  }

  ///  関連tprxソース: rckycrdtin.c - rcSet_Card_Divi
  static Future<void> rcSetCardDivi() async {
    AtSingl atSingl = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();
    if (atSingl.inputbuf.dev == DevIn.D_MCD1) {
      if (cMem.working.crdtReg.companyCd == int.parse(RcCrdt.INTERNAL_JIS1)) {
        cMem.working.crdtReg.cardDiv = '4'; /* Internal JIS1 CARD      */
      } else {
        cMem.working.crdtReg.cardDiv = '1'; /* International JIS1 CARD */
      }
    } else {
      if (atSingl.inputbuf.dev == DevIn.D_MCD2) {
        cMem.working.crdtReg.cardDiv = '2'; /* International JIS2 CARD */
      } else {
        cMem.working.crdtReg.cardDiv = '3'; /* Manual Input            */
      }
    }
  }

  ///  関連tprxソース: rckycrdtin.c - rcSet_Card_Code
  static Future<bool> rcSetCardCode() async {
    if (await RcSysChk.rcChkVegaProcess()) {
      /* VEGA3000接続の場合、応答電文の値を参照しカード番号をセットする
		   rcCardCrew_SetName()内でセットする */
      return true;
    }
    AcMem cMem = SystemFunc.readAcMem();
    cMem.working.crdtReg.cdno =
        Bcdtoa.cmBcdToA(cMem.ent.entry.sublist(2), cMem.ent.entry.length - 2);
    await rcSetCardDivi();
    return false;
  }

  ///  関連tprxソース: rckycrdtin.c - rcSet_Comp_Code
  static Future<void> rcSetCompCode() async {
    int entCnt = 0;

    if (await CmCksys.cmNttaspSystem() != 0) return;

    AcMem cMem = SystemFunc.readAcMem();
    cMem.working.crdtReg.companyCd = Bcdtol.cmBcdToL(cMem.ent.entry);
    entCnt = cMem.ent.tencnt;

    if (CompileFlag.DEPARTMENT_STORE) {
      if ((cMem.stat.departFlg & 0x01) != 0) {
        // 自社クレジット宣言中？
        if ((cMem.working.crdtReg.companyCd > 0) &&
            (cMem.working.crdtReg.companyCd < 10)) {
          cMem.working.crdtReg.companyCd =
              1000 + cMem.working.crdtReg.companyCd;
        }
        entCnt = 4;
      }
    }
    if ((cMem.stat.departFlg & 0x01) != 0) {
      // 自社クレジット宣言中？
      if ((cMem.working.crdtReg.companyCd > 0) &&
          (cMem.working.crdtReg.companyCd < 10)) {
        cMem.working.crdtReg.companyCd = 1000 + cMem.working.crdtReg.companyCd;
      }
      entCnt = 4;
    }
    // #endif

    if (cMem.working.refData.crdtTbl.card_company_name[0] == ' ') {
      cMem.working.refData.crdtTbl.card_company_name =
          cMem.working.refData.crdtTbl.card_company_name.substring(0, 15) +
              cMem.working.crdtReg.companyCd.toString().padLeft(5, ' ');
    }
  }

  ///  関連tprxソース: rckycrdtin.c - rcSet_Receit_No
  static bool rcSetReceitNo() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.working.crdtReg.rpno = cMem.ent.entry.sublist(7);
    return false;
  }

  ///  関連tprxソース: rckycrdtin.c - rcSet_Pay_Begin
  static Future<bool> rcSetPayBegin() async {
    AcMem cMem = SystemFunc.readAcMem();
    bool stat = false;

    switch (rcUseKyPayBegin()) {
      case RcCrdt.NOMONTH:
        cMem.working.crdtReg.crdtTbl.pay_autoinput_chk = 0;
        break;
      case RcCrdt.MONTH1:
        SystemFunc.readAcMem().working.crdtReg.crdtTbl.pay_autoinput_chk = 1;
        break;
      case RcCrdt.MONTH2:
        SystemFunc.readAcMem().working.crdtReg.crdtTbl.pay_autoinput_chk = 2;
        break;
      case RcCrdt.MONTH3:
        SystemFunc.readAcMem().working.crdtReg.crdtTbl.pay_autoinput_chk = 3;
        break;
      case RcCrdt.MONTH4:
        SystemFunc.readAcMem().working.crdtReg.crdtTbl.pay_autoinput_chk = 4;
        break;
      case RcCrdt.MONTH5:
        SystemFunc.readAcMem().working.crdtReg.crdtTbl.pay_autoinput_chk = 5;
        break;
      case RcCrdt.MONTH6:
        SystemFunc.readAcMem().working.crdtReg.crdtTbl.pay_autoinput_chk = 6;
        break;
      case RcCrdt.MONTH7:
        SystemFunc.readAcMem().working.crdtReg.crdtTbl.pay_autoinput_chk = 7;
        break;
      case RcCrdt.MONTH8:
        SystemFunc.readAcMem().working.crdtReg.crdtTbl.pay_autoinput_chk = 8;
        break;
      case RcCrdt.MONTH9:
        SystemFunc.readAcMem().working.crdtReg.crdtTbl.pay_autoinput_chk = 9;
        break;
      case RcCrdt.MONTH10:
        SystemFunc.readAcMem().working.crdtReg.crdtTbl.pay_autoinput_chk = 10;
        break;
      case RcCrdt.MONTH11:
        SystemFunc.readAcMem().working.crdtReg.crdtTbl.pay_autoinput_chk = 11;
        break;
      case RcCrdt.MONTH12:
        SystemFunc.readAcMem().working.crdtReg.crdtTbl.pay_autoinput_chk = 12;
        break;
    }

    SystemFunc.readAcMem().working.crdtReg.step--; // 押されたキーを反転させる為
    await RcCrdtDsp.rcCrdtStepDisp(); // 選択された支払月キーを反転

    return stat;
  }

  ///  関連tprxソース: rckycrdtin.c - rcSet_Pay_Divid
  static Future<bool> rcSetPayDivid() async {
    AcMem cMem = SystemFunc.readAcMem();
    switch (await rcUseKyPayDivid()) {
      // #if !DEPARTMENT_STORE
      case RcCrdt.DIVIDE1:
        cMem.working.crdtReg.crdtTbl.lump = 1;
        break;
      case RcCrdt.DIVIDE2:
        cMem.working.crdtReg.crdtTbl.twice = 1;
        break;
      // #endif
      case RcCrdt.DIVIDE3:
        cMem.working.crdtReg.crdtTbl.divide3 = 1;
        break;
      case RcCrdt.DIVIDE5:
        cMem.working.crdtReg.crdtTbl.divide5 = 1;
        break;
      case RcCrdt.DIVIDE6:
        cMem.working.crdtReg.crdtTbl.divide6 = 1;
        break;
      case RcCrdt.DIVIDE10:
        cMem.working.crdtReg.crdtTbl.divide10 = 1;
        break;
      case RcCrdt.DIVIDE12:
        cMem.working.crdtReg.crdtTbl.divide12 = 1;
        break;
      case RcCrdt.DIVIDE15:
        cMem.working.crdtReg.crdtTbl.divide15 = 1;
        break;
      case RcCrdt.DIVIDE18:
        cMem.working.crdtReg.crdtTbl.divide18 = 1;
        break;
      case RcCrdt.DIVIDE20:
        cMem.working.crdtReg.crdtTbl.divide20 = 1;
        break;
      case RcCrdt.DIVIDE24:
        cMem.working.crdtReg.crdtTbl.divide24 = 1;
        break;
      case RcCrdt.DIVIDE30:
        cMem.working.crdtReg.crdtTbl.divide30 = 1;
        break;
      case RcCrdt.DIVIDE36:
        cMem.working.crdtReg.crdtTbl.divide36 = 1;
        break;
      // #if DEPARTMENT_STORE
      // case RcCrdt.DIVIDE8:
      //   cMem.working.crdtReg.crdtTbl.divide5_limit = 10000;
      //   break;
      // case RcCrdt.DIVIDE4:
      //   cMem.working.crdtReg.crdtTbl.fil3 = 10000;
      //   break;
      // case RcCrdt.DIVIDE25:
      //   cMem.working.crdtReg.crdtTbl.fil3 = 100;
      //   break;
      // case RcCrdt.DIVIDE35:
      //   cMem.working.crdtReg.crdtTbl.fil3 = 1;
      //   break;
      // #endif
    }
    cMem.working.crdtReg.step--; // 押されたキーを反転させる為
    await RcCrdtDsp.rcCrdtStepDisp(); // 選択された回数キーを反転
    cMem.working.crdtReg.step = KyCrdtInStep.PAY_KYCHA.cd - 1;
    return true;
  }

  ///  関連tprxソース: rckycrdtin.c - rcSet_Bonus_Two
  static Future<bool> rcSetBonusTwo() async {
    bool stat = false;
    AcMem cMem = SystemFunc.readAcMem();

    // #if DEPARTMENT_STORE
    // if(rcChk_All_Season() == OK) {
    //    switch(rcUseKy_Bonus_Two())
    //    {
    //       case W_B1_PAY1 :
    //       case W_B1_PAY2 :
    //       case W_B1_PAY3 : CMEM->working.crdt_reg.b_season = 0;     /* Winter Season */
    //                        if(CMEM->working.crdt_reg.b1_setflg) {
    //                           CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1 = 0;
    //                           CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2 = 0;
    //                           CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3 = 0;
    //                           CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1 = 0;
    //                           CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2 = 0;
    //                           CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3 = 0;
    //                        }
    //                        else
    //                           CMEM->working.crdt_reg.b1_setflg = 1;
    //                        break;
    //       case S_B1_PAY1 :
    //       case S_B1_PAY2 :
    //       case S_B1_PAY3 : CMEM->working.crdt_reg.b_season = 1;     /* Summer Season */
    //                        if(CMEM->working.crdt_reg.b1_setflg) {
    //                           CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1 = 0;
    //                           CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2 = 0;
    //                           CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3 = 0;
    //                           CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1 = 0;
    //                           CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2 = 0;
    //                           CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3 = 0;
    //                        }
    //                        else
    //                           CMEM->working.crdt_reg.b1_setflg = 1;
    //                        break;
    //       case W_B2_PAY1 :
    //       case W_B2_PAY2 :
    //       case W_B2_PAY3 :
    //       case S_B2_PAY1 :
    //       case S_B2_PAY2 :
    //       case S_B2_PAY3 : if(CMEM->working.crdt_reg.b2_setflg) {
    //                           CMEM->working.crdt_reg.crdttbl.winter_bonus_pay1 = 0;
    //                           CMEM->working.crdt_reg.crdttbl.winter_bonus_pay2 = 0;
    //                           CMEM->working.crdt_reg.crdttbl.winter_bonus_pay3 = 0;
    //                           CMEM->working.crdt_reg.crdttbl.summer_bonus_pay1 = 0;
    //                           CMEM->working.crdt_reg.crdttbl.summer_bonus_pay2 = 0;
    //                           CMEM->working.crdt_reg.crdttbl.summer_bonus_pay3 = 0;
    //                        }
    //                        else
    //                           CMEM->working.crdt_reg.b2_setflg = 1;
    //                        break;
    //    }
    // }
    // #endif

    switch (await rcUseKyBonusTwo()) {
      case RcCrdt.W_B1_PAY1:
      case RcCrdt.W_B2_PAY1:
        if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay2 != 0) {
          cMem.working.crdtReg.crdtTbl.winter_bonus_pay2 = 0;
        }
        if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay3 != 0) {
          cMem.working.crdtReg.crdtTbl.winter_bonus_pay3 = 0;
        }
        cMem.working.crdtReg.crdtTbl.winter_bonus_pay1 =
            cMem.working.refData.crdtTbl.winter_bonus_pay1;
        break;
      case RcCrdt.W_B1_PAY2:
      case RcCrdt.W_B2_PAY2:
        if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay1 != 0) {
          cMem.working.crdtReg.crdtTbl.winter_bonus_pay1 = 0;
        }
        if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay3 != 0) {
          cMem.working.crdtReg.crdtTbl.winter_bonus_pay3 = 0;
        }
        cMem.working.crdtReg.crdtTbl.winter_bonus_pay2 =
            cMem.working.refData.crdtTbl.winter_bonus_pay2;
        break;
      case RcCrdt.W_B1_PAY3:
      case RcCrdt.W_B2_PAY3:
        if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay1 != 0) {
          cMem.working.crdtReg.crdtTbl.winter_bonus_pay1 = 0;
        }
        if (cMem.working.crdtReg.crdtTbl.winter_bonus_pay2 != 0) {
          cMem.working.crdtReg.crdtTbl.winter_bonus_pay2 = 0;
        }
        cMem.working.crdtReg.crdtTbl.winter_bonus_pay3 =
            cMem.working.refData.crdtTbl.winter_bonus_pay3;
        break;
      case RcCrdt.S_B1_PAY1:
      case RcCrdt.S_B2_PAY1:
        if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay2 != 0) {
          cMem.working.crdtReg.crdtTbl.summer_bonus_pay2 = 0;
        }
        if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay3 != 0) {
          cMem.working.crdtReg.crdtTbl.summer_bonus_pay3 = 0;
        }
        cMem.working.crdtReg.crdtTbl.summer_bonus_pay1 =
            cMem.working.refData.crdtTbl.summer_bonus_pay1;
        break;
      case RcCrdt.S_B1_PAY2:
      case RcCrdt.S_B2_PAY2:
        if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay1 != 0) {
          cMem.working.crdtReg.crdtTbl.summer_bonus_pay1 = 0;
        }
        if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay3 != 0) {
          cMem.working.crdtReg.crdtTbl.summer_bonus_pay3 = 0;
        }
        cMem.working.crdtReg.crdtTbl.summer_bonus_pay2 =
            cMem.working.refData.crdtTbl.summer_bonus_pay2;
        break;
      case RcCrdt.S_B1_PAY3:
      case RcCrdt.S_B2_PAY3:
        if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay1 != 0) {
          cMem.working.crdtReg.crdtTbl.summer_bonus_pay1 = 0;
        }
        if (cMem.working.crdtReg.crdtTbl.summer_bonus_pay2 != 0) {
          cMem.working.crdtReg.crdtTbl.summer_bonus_pay2 = 0;
        }
        cMem.working.crdtReg.crdtTbl.summer_bonus_pay3 =
            cMem.working.refData.crdtTbl.summer_bonus_pay3;
        break;
    }

    cMem.working.crdtReg.step--; // 押されたキーを反転させる為
    await RcCrdtDsp.rcCrdtStepDisp(); // 選択された支払月キーを反転

    if (((cMem.working.crdtReg.crdtTbl.winter_bonus_pay1 != 0) ||
            (cMem.working.crdtReg.crdtTbl.winter_bonus_pay2 != 0) ||
            (cMem.working.crdtReg.crdtTbl.winter_bonus_pay3 != 0)) &&
        ((cMem.working.crdtReg.crdtTbl.summer_bonus_pay1 != 0) ||
            (cMem.working.crdtReg.crdtTbl.summer_bonus_pay2 != 0) ||
            (cMem.working.crdtReg.crdtTbl.summer_bonus_pay3 != 0))) {
      cMem.working.crdtReg.step = KyCrdtInStep.PAY_KYCHA.cd - 1;
      stat = true;
    } else {
      if (((CompileFlag.ARCS_VEGA) &&
              (!Rxcrdtcom.rxArcsNttaspSystem(
                  RegsMem().tTtllog.t100700Sts.mbrTyp, RegsMem().workInType)) &&
              (cMem.working.crdtReg.crdtTbl.bonus_lump == 1)) ||
          ((!CompileFlag.ARCS_VEGA) &&
              ((!(await CmCksys.cmNttaspSystem() != 0)) &&
                  (cMem.working.crdtReg.crdtTbl.bonus_lump == 1)))) {
        if ((RcCardCrew.rcCardCrewChkBonusMonth()) &&
            (RcCrdtFnc.rcSpecBonusMthInput())) {
          cMem.working.crdtReg.step = KyCrdtInStep.PAY_KYCHA.cd - 1;
          stat = true;
        } else {
          cMem.working.crdtReg.step--; // 同じ画面を表示させる為
        }
      } else {
        if (cMem.working.crdtReg.buseBcnt == 1) {
          cMem.working.crdtReg.step = KyCrdtInStep.PAY_KYCHA.cd - 1;
          stat = true;
        } else {
          cMem.working.crdtReg.step--; // 同じ画面を表示させる為
        }
      }
    }
    return stat;
  }

  ///  関連tprxソース: rckycrdtin.c - rcSet_Bonus_Use
  static Future<bool> rcSetBonusUse() async {
    bool stat = false;
    AcMem cMem = SystemFunc.readAcMem();

    switch (await rcUseKyBonusUse()) {
      case RcCrdt.B_USE3:
        cMem.working.crdtReg.crdtTbl.bonus_use3 = 1;
        break;
      case RcCrdt.B_USE5:
        cMem.working.crdtReg.crdtTbl.bonus_use5 = 1;
        break;
      case RcCrdt.B_USE6:
        cMem.working.crdtReg.crdtTbl.bonus_use6 = 1;
        break;
      case RcCrdt.B_USE10:
        cMem.working.crdtReg.crdtTbl.bonus_use10 = 1;
        break;
      case RcCrdt.B_USE12:
        cMem.working.crdtReg.crdtTbl.bonus_use12 = 1;
        break;
      case RcCrdt.B_USE15:
        cMem.working.crdtReg.crdtTbl.bonus_use15 = 1;
        break;
      case RcCrdt.B_USE18:
        cMem.working.crdtReg.crdtTbl.bonus_use18 = 1;
        break;
      case RcCrdt.B_USE20:
        cMem.working.crdtReg.crdtTbl.bonus_use20 = 1;
        break;
      case RcCrdt.B_USE24:
        cMem.working.crdtReg.crdtTbl.bonus_use24 = 1;
        break;
      case RcCrdt.B_USE30:
        cMem.working.crdtReg.crdtTbl.bonus_use30 = 1;
        break;
      case RcCrdt.B_USE36:
        cMem.working.crdtReg.crdtTbl.bonus_use36 = 1;
        break;
      // #if DEPARTMENT_STORE
      // case RcCrdt.B_USE8:
      //   cMem.working.crdtReg.crdtTbl.bonus_use5Limit = 10000;
      //   break;
      // case RcCrdt.B_USE4:
      //   cMem.working.crdtReg.crdtTbl.fil4 = 10000;
      //   break;
      // case RcCrdt.B_USE25:
      //   cMem.working.crdtReg.crdtTbl.fil4 = 100;
      //   break;
      // case RcCrdt.B_USE35:
      //   cMem.working.crdtReg.crdtTbl.fil4 = 1;
      //   break;
      // #endif
    }
    cMem.working.crdtReg.step--; // 押されたキーを反転させる為
    await RcCrdtDsp.rcCrdtStepDisp(); // 選択された回数キーを反転

    if (((CompileFlag.ARCS_VEGA) &&
            (Rxcrdtcom.rxArcsNttaspSystem(
                RegsMem().tTtllog.t100700Sts.mbrTyp, RegsMem().workInType))) ||
        ((!CompileFlag.ARCS_VEGA) && (await CmCksys.cmNttaspSystem() != 0))) {
      if (cMem.working.crdtReg.crdtTbl.bonus_use == 1) {
        cMem.working.crdtReg.step = KyCrdtInStep.PAY_KYCHA.cd - 1;
        stat = true;
      }
    }
    if ((!RcCrdtFnc.rcSpecBonusMthInput()) ||
        (await RcSysChk.rcChkCapsCafisStandardSystem())) {
      cMem.working.crdtReg.step = KyCrdtInStep.PAY_KYCHA.cd - 1;
      stat = true;
    }
    return stat;
  }

  ///  関連tprxソース: rckycrdtin.c - rcSet_Bonus_Cnt
  static bool rcSetBonusCnt() {
    bool stat = false;
    AcMem cMem = SystemFunc.readAcMem();

    switch (rcUseKyBonusCnt()) {
      case RcCrdt.BONUSCNT1:
        cMem.working.crdtReg.buseBcnt = 1;
        break;
      case RcCrdt.BONUSCNT2:
        cMem.working.crdtReg.buseBcnt = 2;
        break;
      case RcCrdt.BONUSCNT3:
        cMem.working.crdtReg.buseBcnt = 3;
        break;
      case RcCrdt.BONUSCNT4:
        cMem.working.crdtReg.buseBcnt = 4;
        break;
      case RcCrdt.BONUSCNT5:
        cMem.working.crdtReg.buseBcnt = 5;
        break;
      case RcCrdt.BONUSCNT6:
        cMem.working.crdtReg.buseBcnt = 6;
        break;
      default:
        cMem.working.crdtReg.buseBcnt = 0;
        break;
    }
    cMem.working.crdtReg.step--; // 押されたキーを反転させる為
    RcCrdtDsp.rcCrdtStepDisp(); // 選択された回数キーを反転
    return stat;
  }

  ///  関連tprxソース: rckycrdtin.c - rcSet_Recogn_No
  static bool rcSetRecognNo() {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.working.crdtReg.reno = cMem.ent.entry.sublist(7);
    if ((cMem.working.crdtReg.stat & 0x0020) != 0) {
      // 手動締め操作仕様？
      cMem.working.crdtReg.step = KyCrdtInStep.PAY_KYCHA.cd - 1;
    }
    return true;
  }
}
