/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'package:flutter_pos/app/inc/lib/typ.dart';
import 'package:flutter_pos/app/regs/checker/rc28stlinfo.dart';
import 'package:flutter_pos/app/regs/checker/rc_acracb.dart';
import 'package:flutter_pos/app/regs/checker/rc_atct.dart';
import 'package:flutter_pos/app/regs/checker/rc_fself.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_bcd/chk_z0.dart';
import '../../lib/cm_chg/bcdtol.dart';
import '../../lib/cm_chg/ltobcd.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../common/rx_log_calc.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_flrda.dart';
import 'rc_reserv.dart';
import 'rccatalina.dart';
import 'rcfncchk.dart';
import 'rcky_regassist.dart';
import 'rckyccin.dart';
import 'rckyccin_acb.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mbr.dart';
import 'rc_atct.dart';
import 'rc_mbr_com.dart';
import 'rc_reserv.dart';
import 'rc_voidupdate.dart';

class RcClsCom {

  static const  COLORFIP =  true;
  static const  execCheck =  1;

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース:rc_clscom.c - ClsCom_Acx_AutoDecision_Stop()
  static int clsComAcxAutoDecisionStop() {
    return 0;
  }
  
  /// 締め処理での釣銭機入金確定終了処理
  /// 関連tprxソース:rc_clscom.c - ClsCom_Acx_AutoDecision_Fnal_Proc
  ///                              (short *acr_errno, short *atct_retry_flg)
  /// 引数：int acrErrno, int atctRetryFlg
  /// 戻値：エラー番号
  static Future<int> clsComAcxAutoDecisionFnalProc(int acrErrNo, int atctRetryFlg) async {
    int errNo = 0;
    CBillKind	ccinSht = CBillKind();
    int	orgEntryData = 0;	//元entry_data。締め処理チェックOK時データ
    int	nowEntryData = 0;	//入金確定終了時entry_data
    int	autoDecFlg = 0;	//auto_decisionへ戻す判定フラグ
    int	chgcinModeDisp = 0;	//処理開始時ChgCin_Modeで動作したフラグ
    String log = '';
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    AcbInfo.autoDecisionFnal = 0;
    if ((await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) &&
        ((await RcSysChk.rcChkAcxDecisionSystem()) ||
            (await RcSysChk.rcSGChkSelfGateSystem()))) {
      if (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_CHGCIN.keyId])) {
        autoDecFlg = 1;
      }
      if (RcFncChk.rcCheckChgCinMode()) {
        //ScrModeが途中でResetされるので保存。
        //類似フラグでAcbInfo.AutoDecision_Fnalがあるがこちらは入金画面なしでもフラグ立つので要件に合わない
        chgcinModeDisp = 1;
      }
      if (!await RcSysChk.rcSGChkSelfGateSystem()) {
        //入金確定終了前の締め処理可能かチェック
        if (autoDecFlg == 1) {
          errNo = await RcAtct.rcAtctProcError2(1);
          if (await RckyRegassist.rcCheckRegAssistPaymentAct(errNo)) {
            log = "clsComAcxAutoDecisionFnalProc : errNo($errNo) -> Stop\n";
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          }
          else if (errNo != 0)
          {//締め処理チェックエラーで終了処理を行わなかったので入金額監視に戻る
            RcAcracb.rcGtkTimerRemoveAcb();
            RcAcracb.rcGtkTimerAddAcb(100, RckyccinAcb.rcAutoDecision());
            return(errNo);
          }
        }

        //締め処理チェックOK時のentry確保
        orgEntryData = Bcdtol.cmBcdToL(cMem.ent.entry);
      }

      AcbInfo.autoDecisionFlg = 0;
      if (RcSysChk.rcChkKYCHA(cMem.stat.fncCode)) {
        if(AcbInfo.othConnectAcbStopFlg != 1) {
          await clsComAcxAutoDecisionFnal(acrErrNo);
        }
        AcbInfo.othConnectAcbStopFlg = 0;
      }
      else {
        await clsComAcxAutoDecisionFnal(acrErrNo);
      }
      if (!await RcSysChk.rcSGChkSelfGateSystem()) {
        if ((autoDecFlg == 1) &&
            ((clsComAcxRejectEndChk(acrErrNo)) ||
                (RcKyccin.rcCheckAcbChangeOverErrno(acrErrNo) != 0)))
        { //リジェクトエラー/釣銭超過エラーのために終了処理ができなかった場合は入金額監視に戻る
          RcAcracb.rcGtkTimerRemoveAcb();
          RcAcracb.rcGtkTimerAddAcb(100, RckyccinAcb.rcAutoDecision());
          errNo = acrErrNo;
          log = "clsComAcxAutoDecisionFnalProc() Check 1 errNo($errNo) -> AutoDecision Timer\n";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          return (errNo);
        }
        if((autoDecFlg == 1) &&
            ((await RcSysChk.rcQCChkQcashierSystem()) &&
                (cMem.acbData.acbDeviceStat != AcxStatus.CinEnd.id) &&
                (acrErrNo != 0))) { //QCashierにてエラーのために終了処理ができなかった場合は入金額監視に戻る
          RcAcracb.rcGtkTimerRemoveAcb();
          RcAcracb.rcGtkTimerAddAcb(100, RckyccinAcb.rcAutoDecision());
          errNo = acrErrNo;
          log = "clsComAcxAutoDecisionFnalProc() Check 2 errNo($errNo) -> AutoDecision Timer\n";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          return (errNo);
        }
        if ((!((RcFncChk.rcCheckChgCinMode()) || (chgcinModeDisp == 1))) &&
            (!await RcSysChk.rcQCChkQcashierSystem())) {
          if (AcbInfo.stopwaitActFlg == 1) {	//締め処理中に入金動作が発生
            AcbInfo.stopwaitActFlg = 0;
            if (cMem.acbData.ccinPrice != 0) {
              log = "clsComAcxAutoDecisionFnalProc() Acb_Status = CinAct -> ChangeOut(${cMem.acbData.ccinPrice})\n";
              TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
              RcKyccin.rcAcrAcbCcinShtSet(ccinSht);
              errNo = await RcAcracb.rcAcrAcbShtSpecifyOut(ccinSht, 1, 0);
              if (errNo == 0) {
                errNo = await RcAcracb.rcPrgAcrAcbResultGet();
              }
              cMem.acbData.totalPrice = 0;
              cMem.acbData.ccinPrice = 0;
              AcbInfo.autoDecisionFnal = 0;
              atSing.acracbStartFlg = 0;	/* 入金確定　開始フラグ */
              if (errNo == 0) {
                errNo = DlgConfirmMsgKind.MSG_TEXT187.dlgId;
              }
              return(errNo);
            }
          }
        }

        //個別釣銭入力額の更新
        clsComAcxInputPaySet();

        //入金終了後の最終entry確保
        nowEntryData = Bcdtol.cmBcdToL(cMem.ent.entry);

        //釣銭機停止前後で入金額が変わっている
        if ((orgEntryData != nowEntryData) && (cMem.acbData.totalPrice != 0)) {
          if ((!((RcFncChk.rcCheckChgCinMode()) ||
              (chgcinModeDisp == 1))) &&
              (!await RcSysChk.rcQCChkQcashierSystem())) {
            if (cMem.acbData.ccinPrice != 0) {
              log = "clsComAcxAutoDecisionFnalProc() org_ent[$orgEntryData] != now_ent[$nowEntryData] -> ChangeOut(%${cMem.acbData.ccinPrice})\n";
              TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
              RcKyccin.rcAcrAcbCcinShtSet(ccinSht);
              errNo = await RcAcracb.rcAcrAcbShtSpecifyOut(ccinSht, 1, 0);
              if (errNo == 0) {
                errNo = await RcAcracb.rcPrgAcrAcbResultGet();
              }
              cMem.acbData.totalPrice = 0;
              cMem.acbData.ccinPrice = 0;
              AcbInfo.autoDecisionFnal = 0;
              atSing.acracbStartFlg = 0;	/* 入金確定　開始フラグ */
              if (errNo == 0) {
                errNo = DlgConfirmMsgKind.MSG_TEXT187.dlgId;
              }
              return(errNo);
            }
          }
        }
      }
    }
    return errNo;
  }

  /// 表示条件判定。条件番号に応じ、承認・設定等のチェックを行う。
  /// 関連tprxソース: rc_clscom.c - ClsCom_Acx_CoinBillOut()
  /// 引数：eTendType 提供タイプ
  /// 引数：acrErrNo エラーNO
  /// 戻値：非同期Void
  static Future<void> clsComAcxCoinBillOut(TendType? eTendType,
      int acrErrNo) async {

    if( acrErrNo != Typ.OK) {
      return;
    }
    if(await RcAcracb.rcCheckAcrAcbON( 1 ) == 0 ) {
      acrErrNo = await RcAcracb.rcATCTCoinBillOut( eTendType );
      if( COLORFIP ) {
        bool chkFselfSystem = await RcSysChk.rcChkFselfSystem();
        if ( chkFselfSystem ) {
          if( acrErrNo == Typ.OK ) {
            switch( eTendType )
            {
              case TendType.TEND_TYPE_NO_ENTRY_DATA:
              case TendType.TEND_TYPE_TEND_AMOUNT:
                if( Rc28StlInfo.colorFipChk() == 1 ) {
                  AcMem cMem = SystemFunc.readAcMem();
                  if( cMem.acbData.totalPrice == 0 ) {
                    await RcfSelf.rcFselfMovieStop();
                    await RcfSelf.rcFselfTranendCreate();
                  }
                  RcfSelf.rcfSelfTranFinishCreate(1);
                }
                break;
              default :
                break;
            }
          }
        }
      }
    }
    return;
  }

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース:rc_clscom.c - ClsCom_Acx_Result()
  static void clsComAcxResult(int acrErrno) {
    return;
  }

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース:rc_clscom.c - ClsCom_Acx_ChkStock()
  static int clsComAcxChkStock(int acrErrno) {
    return 0;
  }

  /// 関連tprxソース:rc_clscom.c - ClsCom_Acx_AutoDecision_Fnal()
  static Future<void> clsComAcxAutoDecisionFnal(int acrErrno) async {
    String log = '';
    int errNo;
    KopttranBuff koptTran = KopttranBuff();
    int rtn;
    AcMem cMem = SystemFunc.readAcMem();
    IfWaitSave ifSave = SystemFunc.readIfWaitSave();

    if (acrErrno != 0) {
      return;
    }
    if ((await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) &&
        ((await RcSysChk.rcChkAcxDecisionSystem()) ||
            (await RcSysChk.rcSGChkSelfGateSystem()))) {
      RcAcracb.rcGtkTimerRemoveAcb();
      switch (FuncKey.getKeyDefine(cMem.stat.fncCode)) {
        case FuncKey.KY_CNCL :
        case FuncKey.KY_SPCNCL :
          rtn = 0; //締めキーでないのでrcRead_kopttranしない
          break;
        default:
          rtn = await RcFlrda.rcReadKopttran(cMem.stat.fncCode, koptTran)? 1 : 0;
          break;
      }
      if (cMem.acbData.acbDeviceStat != AcxStatus.CinEnd.id) {
        acrErrno = await RcKyccin.rcAcrAcbCinFinish();
      }
      if (AcbInfo.totalPrice != 0) {
        log = "totalPrice[${AcbInfo.totalPrice}] acbTotalPrice[${cMem.acbData.totalPrice}]\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      }
      if ((rtn != 0) &&
          (errNo = RcKyccin.rcCheckAcbCnangeOver(koptTran)) != 0) {
        acrErrno = errNo;
      }
      else if (! clsComAcxRejectEndChk(acrErrno)) {
        //正常終了
        if (RcFncChk.rcCheckChgCinMode()) {
          await RcKyccin.rcChgCinScrModeReset();
          await RcKyccin.rcChgCinDispDestroy();

          if (await RcSysChk.rcSysChkHappySmile()) { // 客側表時のタッチセーブを無効化したい為
            if (ifSave.count != 0) {
              TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
                  "<happy_smile>IF_SAVE Clear!!\n");
            }
          }
        }
        else {
          //入金画面が出ていない時の締め処理にて万券が入力されていた場合、
          //ent.entryは上書きで入金額になるが万券フラグがセットされたままに
          //なるのでここでクリア
          if (cMem.acbData.totalPrice != 0) {
            cMem.working.dataReg.kMan0 = 0;
          }
        }
        AcbInfo.totalPrice = 0;
        cMem.acbData.acbFullPrice = 0;
        if (cMem.acbData.totalPrice != 0) {
          AcbInfo.autoDecisionFnal = 1; //入金額がある。入金画面は消去済みなので入金確定で処理した判断のために
        }
      }
    }
  }

  /// 関連tprxソース:rc_clscom.c - ClsCom_Acx_Reject_EndChk()
  static bool clsComAcxRejectEndChk(int errNo) {
    //リジェクトのため終了できなかったかチェック
    AcMem cMem = SystemFunc.readAcMem();
    return((RcAcracb.rcChkAcrAcbRjctErr(errNo)) &&
        (cMem.acbData.acbDeviceStat != AcxStatus.CinEnd.id));
  }

  /// 関連tprxソース:rc_clscom.c - ClsCom_Acx_InputPaySet()
  static Future<void> clsComAcxInputPaySet() async {
    int ttlPrc;
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    RxCommonBuf cBuf = SystemFunc.readRxCommonBuf();

    if (await RcSysChk.rcCheckIndividChange()) {
      if (((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
          (await RcSysChk.rcCheckQCJCSystem())) &&
          (await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) &&
          (!await RcSysChk.rcSGChkSelfGateSystem())) {
        if (RcRegs.kyStC2(cMem.keyStat[FncCode.KY_FNAL.keyId])) {
          /* sprit tend ? */
          ttlPrc = RxLogCalc.rxCalcStlTaxAmt(mem);
        } else {
          ttlPrc = RxLogCalc.rxCalcStlTaxInAmt(mem);
          if (RcCatalina.cmCatalinaSystem(0)) {
            ttlPrc -= mem.tmpbuf.catalinaTtlamt;
          }
          if (cBuf.dbTrm.discBarcode28d != 0) {
            ttlPrc -= mem.tmpbuf.beniyaTtlamt;
          }
          ttlPrc -= mem.tmpbuf.notepluTtlamt;
          if ((await CmCksys.cmReservSystem() != 0 ||
              await CmCksys.cmNetDoAreservSystem() != 0) &&
              RcReserv.rcReservReceiptCall()) {
            ttlPrc -= await RcReserv.rcreservReceiptAdvance();
          }
        }
        if (ttlPrc <= cMem.acbData.inputPrice) {
          cMem.acbData.inputPrice = cMem.acbData.totalPrice;
        }
        if (cMem.acbData.totalPrice != 0) {
          if ((cMem.acbData.totalPrice == cMem.acbData.inputPrice) ||
              cMem.acbData.inputPrice == 0) {
            Ltobcd.cmLtobcd(cMem.acbData.totalPrice, cMem.ent.entry.length);
          } else {
            Ltobcd.cmLtobcd(cMem.acbData.inputPrice, cMem.ent.entry.length);
          }
          cMem.ent.tencnt =
              ChkZ0.cmChkZero0(cMem.ent.entry);
        }
      }
    }
  }

  /// 関連tprxソース:rc_clscom.c - ClsCom_Mbr_Update
  static Future<void> clsComMbrUpdate(TendType? eTendType) async {
    if ((await RcMbrCom.rcmbrChkStat() != 0) &&
        (RcMbrCom.rcmbrChkCust() != 0)) {
      // #ifdef SPD_DBG
      // clscom_t1 = times(&clscom_tp);
      // #endif

      if (!CompileFlag.RESERV_SYSTEM ||
          (CompileFlag.RESERV_SYSTEM && !await RcReserv.rcReservNotUpdate())) {
        if (!(((await RcVoidUpdate.voidCustRealSrvUpdChk() == false) &&
                (RegsMem().tTtllog.t100003.voidFlg == 1)) ||
            ((await CmCksys.cmIchiyamaMartSystem() != 0) &&
                (RegsMem().tTtllog.t100700.mbrInput ==
                    MbrInputType.mbrprcKeyInput.index)))) {
          await RcAtct.rcATCTMbrUpdate(eTendType!);
        }
        // #ifdef SPD_DBG
        // clscom_t2 = times(&clscom_tp);
        // printf("rcATCTMbr_Update time[%f]\n", (double)(clscom_t2 - clscom_t1)/CLK_TCK);
        // #endif
      }
    }
  }
}