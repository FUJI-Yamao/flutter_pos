/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../ui/page/manual_input/component/w_mglogin_dialogpage.dart';
import '../../ui/page/manual_input/controller/c_mglogininput_controller.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/typ.dart';
import '../../lib/cm_bcd/chk_z0.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_crdt.dart';
import '../inc/rc_mem.dart';
import '/app/if/if_drv_control.dart';
import '/app/inc/sys/tpr_log.dart';
import 'rc_crdt_fnc.dart';
import 'rc_gtktimer.dart';
import 'rc_mcd.dart';
import 'rc_qc_dsp.dart';
import 'rccardcrew.dart';
import 'rccrdtdsp.dart';
import 'rcdetect.dart';
import 'rcfncchk.dart';
import 'rcky_clr.dart';
import 'rckycncl.dart';
import 'rckycrdtin.dart';
import 'rcqc_com.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';

/// REG.Mode Touch Keys Dipspatch
/// 関連tprxソース:rc_tch.c
class TchKeyDispatch {
  static Future<void> rcDTchByKeyId(int keyId, dynamic option) async {
    if(option is PresetInfo ){
      if(option.kyPluCd == "" && option.kySmlclsCd > 0) {
        /// プリセットキーのPLUに設定がなく、小分類コードのみ登録されている場合は
        /// 小分類登録画面を呼び出し
        Get.to(
          MGLoginPage(initialMGIndex: option.kySmlclsCd.toString(), title: MGTitleConstants.mgTitle,),
        );
        return;
      }
    }

    FuncKey funcKey = FuncKey.getKeyDefine(keyId);
    await rcDTchByFuncKey(funcKey, option);
  }

  /// タッチキーが押されたときの処理.
  /// 関連tprxソース:rc_tch.c rcD_Tch();
  static Future<void> rcDTchByFuncKey(FuncKey funcKey, dynamic option) async {
    bool isSuccess = false;
    if(option is PresetInfo ){
      // プリセットキーの情報を、ATSINGに変換
      await RcDetect.rcItmGtkDetect(option,0);
    }

    switch (funcKey) {
      case FuncKey.KY_PLU: //optionにはPLUが入ってくる.
        PresetInfo plu = option as PresetInfo;
        isSuccess = rcPresetPluCode(plu.kyPluCd);
        option = plu.kyPluCd;
        break;
      default:
        isSuccess = true;
        break;
    }
    if (isSuccess) {
      await IfDrvControl().mkeyIsolateCtrl.dispatch?.rcDKeyByFuncKey(funcKey, option);
    }
  }

  /// PLUコードが選択されたときの処理.
  /// 関連tprxソース: rc_tch.c rcPreset_PluCode()
  static bool rcPresetPluCode(String? pluCd) {
    if (pluCd == null ) {
      TprLog().logAdd(
          Tpraid.TPRAID_CHK, LogLevelDefine.error, "PLU[$pluCd] is invalid ");
      return false;
    }
    return true;
  }

  /// 関連tprxソース: rc_tch.c - rcPreset_CrdtProc
  static Future<void> rcPresetCrdtProc() async {

    AcMem cMem = SystemFunc.readAcMem();

    if(cMem.stat.orgCode == RcCrdt.KEY_INPUT1) {
      KyCrdtInStep define =
      KyCrdtInStep.getDefine(cMem.working.crdtReg.step);
		  switch(define) {
			  case KyCrdtInStep.CARD_KIND :
				  if( ChkZ0.cmChkZero0(cMem.ent.entry) != 0 ) {
  					if( (await RcSysChk.rcChkCapSCafisSystem()) ) {
              cMem.working.crdtReg.stat |= 0x0400;
              cMem.working.crdtReg.step++;
              await RckyCrdtIn.rcKyCrdtIn();
              break;
            }
          }
        case KyCrdtInStep.PLES_CARD :
        case KyCrdtInStep.GOOD_THRU :
        case KyCrdtInStep.RECEIT_NO :
        case KyCrdtInStep.RECOGN_NO :
          if( ChkZ0.cmChkZero0(cMem.ent.entry) != 0 ) {

            if(    (! ((await CmCksys.cmNttaspSystem()) != 0))
                && (!  (await RcSysChk.rcChkCapSCafisSystem()))
                && (!  (await RcSysChk.rcChkCapsCafisStandardSystem())) ) {

              if( cMem.working.crdtReg.step == KyCrdtInStep.GOOD_THRU.cd ) {
                await RckyCrdtIn.rcCardCrewInpPrg();
              } else {
                await RckyCrdtIn.rcKyCrdtIn();
              }
            } else {
              await RckyCrdtIn.rcKyCrdtIn();
            }
          }
        default:
      }
    } else if(cMem.stat.orgCode == RcCrdt.KEY_BREAK1) {

	    int stepSave = cMem.working.crdtReg.step;	/* 中止処理の実行状況を保持 */
      int statChk = 0;
      int offMode = 0;

	    if ( await RcSysChk.rcsyschkKasumiEMVSystem() ) {
		    if (cMem.working.crdtReg.crdtReq.emvOffMode == 1) {
			    statChk = 1;
        } else if (cMem.working.crdtReg.crdtReq.emvOffMode == 2) {
          /* オフライン可能ボタン */
          statChk = 1;
          offMode = 1;
          cMem.working.crdtReg.crdtReq.emvOffMode = 1;	/* 元に戻す */
        }
      }

      if( (RcCrdtFnc.rcCheckEntryCrdtInqu()) && (cMem.working.crdtReg.step == KyCrdtInStep.RECOGN_NO.cd) ) {

        // 置数 + クレジットでの承認番号入力で中止した場合はスプリット全キャンセル
        TprLog().logAdd(
            await RcSysChk.getTid(), LogLevelDefine.normal, "rcPresetCrdtProc: Cancel Split Start");


        await RcCrdtFnc.rcCrdtCancel();
        RcKyCncl.rcClr2ndCnclSprit();
        RcKyCncl.rcEnd2ndCnclSprit();
        RckyClr.rcClearSptendInfo();

      } else if(cMem.working.crdtReg.step > KyCrdtInStep.CARD_KIND.cd) {     /* 画面がちらつくのを制御 */

        cMem.working.crdtReg.kasumiInpflg = 0;

        if((await RcSysChk.rcChkVegaProcess()) && (await RcSysChk.rcSysChkHappySmile())) {
          /* 現金投入画面でクレジットでお支払いの音声を流さないように */
          RcQcDsp.qcSoundOffFlg = 1;
        }
        await RckyCrdtIn.rcKyCrdtIn();

        if((await RcSysChk.rcChkVegaProcess()) && (await RcSysChk.rcSysChkHappySmile())) {
          RcQcDsp.qcSoundOffFlg = 0;
        }

        RegsMem mem = SystemFunc.readRegsMem();
        /* カスミ様EMV対応  訂正画面 */
        if ( (await RcSysChk.rcsyschkKasumiEMVSystem())
          && (await CmCksys.cmSm39KasumiSystem())
          && (await RcCrdtFnc.rcCheckCrdtVoidInquProc())) {
          /* カスミ様オフライン中は初期化行わない */
          if (cMem.working.crdtReg.crdtReq.emvOffMode == 0) {
            if ((await RcSysChk.rcChkCrdtDscSystem()) && (mem.tTtllog.t100002.stlcrdtdscAmt != 0)) {
              RcCrdtFnc.rcCrdtStlDscCancel();
            }
          }
        } else if((await RcSysChk.rcChkCrdtDscSystem()) && (mem.tTtllog.t100002.stlcrdtdscAmt != 0)) {
          RcCrdtFnc.rcCrdtStlDscCancel();
        }
      }

      if ((await RcSysChk.rcSysChkHappySmile())) {
        if (RcFncChk.rcCheckMasrSystem()) {
          RcQcCom.rcQcLedAllOff(QcLedNo.QC_LED_ALL, "rcPresetCrdtProc");
          RcQcCom.rcQCLedCom(
              QcLedNo.QC_LED_CRDT.index, QcLedColor.QC_LED_WHITE_COLOR.index
            , QcLedDisp.QC_LED_DISP_BRINK.index, 50, 50, 6000);
        }
      }

      if((await RcSysChk.rcChkVegaProcess())) {
        if((stepSave >= KyCrdtInStep.PAY_A_WAY.cd) && (stepSave <= KyCrdtInStep.INPUT_END.cd)) {

          /* 決済端末へ中止コマンド送信 */
          var errNo = await RcCardCrew.rcCardCrewInquWtxt(RcCrdt.CRDT_CNCL);

          if(errNo == Typ.OK) {
            // todo クレ宣言　暫定対応6 rcGtkTimerAddが実装されていないため
            // errNo = RcGtkTimer.rcGtkTimerAdd(300, RcCardCrew.rcCardCrewInquVegaCnclRcv);
            errNo = await RcCardCrew.rcCardCrewInquVegaCnclRcv();
          }

          if(errNo != Typ.OK) {
            await RcMcd.rcCardCrewVegaError(errNo);
          }
        } else {
          /* クレジット宣言状態をクリアする */
          await RcMcd.rcCardCrewVegaError(0);
        }
      } else {
        if (await RcSysChk.rcsyschkKasumiEMVSystem()) {
          if (statChk == 1) { // オフラインEMVを動作させたい為
            if ((stepSave >= KyCrdtInStep.RECEIT_NO.cd) && (stepSave <= KyCrdtInStep.INPUT_END.cd)) {
              if (offMode != 0) {
                /* オフライン可能ボタン時は中止させたくないため */
                /* 何もしない */
              } else {
                RxTaskStatBuf tsBuf = RxTaskStatBuf();
                tsBuf.multi.flg |= 0x40; // クレジット中止フラグ
                RcCrdtFnc.rcCrdtFncCheckJtrCncelEnd("rcPresetCrdtProc");
                await RcMcd.rcCardCrewVegaError(0);
              }
            }
          } else {
            if ((stepSave >= KyCrdtInStep.RECEIT_NO.cd) && (stepSave <= KyCrdtInStep.INPUT_END.cd)) {
              RxTaskStatBuf tsBuf = RxTaskStatBuf();
              tsBuf.multi.flg |= 0x40; // クレジット中止フラグ
              RcCrdtFnc.rcCrdtFncCheckJtrCncelEnd("rcPresetCrdtProc");
              await RcMcd.rcCardCrewVegaError(0);
            }
          }
        }
      }
    } else if(cMem.stat.orgCode == RcCrdt.KEY_PAYPREV) {  // 支払方法へ戻る処理
      cMem.working.crdtReg.step = (KyCrdtInStep.PAY_A_WAY.cd - 1);
      cMem.working.crdtReg.crdtTbl= CCrdtDemandTbl();

      await RcCrdtDsp.rcCrdtStepDisp();
    } else if((cMem.working.crdtReg.step >= KyCrdtInStep.PAY_A_WAY.cd) && /* 支払方法選択画面中？*/
              (cMem.working.crdtReg.step <= KyCrdtInStep.BONUSUSE2.cd) ) {

      if(  ((await CmCksys.cmCapsPqvicSystem()) != 0) &&  (cMem.working.refData.crdtTbl.fil2 == 0)) {
        cMem.working.refData.crdtTbl.fil2 = 1;
        if ((cMem.stat.orgCode == RcCrdt.B_LUMP) || (cMem.stat.orgCode == RcCrdt.B_TWICE) || (cMem.stat.orgCode == RcCrdt.B_USE)) {
          rcCrdtPQvicPayAWayDisp();
          return;
        }
      }

      await RckyCrdtIn.rcKyCrdtIn();
    }

    cMem.stat.orgCode = 0;
  }

  /// 関連tprxソース: rc_tch.c - rcCrdt_PQvicPayAWay_Disp
  // TODO:定義のみ追加
  static void rcCrdtPQvicPayAWayDisp() {}

  /// 関連tprxソース: rc_tch.c rcPre104_CrdtProc
  static Future<void> rcPre104CrdtProc(int orgCode) async {
    /* GTKからCALLされる関数 */
    String log = "";
    AtSingl atSingl = SystemFunc.readAtSingl();
    AcMem cMem = SystemFunc.readAcMem();

    log = "rcPre104CrdtProc [$orgCode]\n";
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
    atSingl.inputbuf.dev = DevIn.D_TCH;                     /* 10.4 Inch */
    cMem.stat.orgCode = orgCode;
    await rcPresetCrdtProc();
  }
}
