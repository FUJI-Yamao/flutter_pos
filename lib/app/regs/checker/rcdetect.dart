/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../fb/fb_init.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_arange.dart';
import 'rc_event.dart';
import 'rc_ext.dart';
import 'rc_ifevent.dart';
import 'rc_set.dart';
import 'rcdishcalc.dart';
import 'rcfncchk.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';

/// 関連tprxソース: rcdetect.c
class RcDetect{

  /// RX_INPUT_BUF	I_BUF_sav;
  static RxInputBuf iBufSav = RxInputBuf();

  ///  関連tprxソース: rcdetect.c - rcKey_Detect()
  static void rcKeyDetect(RxInputBuf iBuf,int devno){
    AtSingl atSing = SystemFunc.readAtSingl();
    atSing.inputbuf.dev = DevIn.D_KEY;
    atSing.inputbuf.no = devno;
    atSing.inputbuf.Ocode[0] = iBuf.hardKey;
    atSing.inputbuf.Fcode = iBuf.funcCode;
    atSing.inputbuf.Acode = iBuf.devInf.data;
    atSing.inputbuf.ADcode = iBuf.devInf.adonCd;
    atSing.inputbuf.ITF_amt = iBuf.devInf.itfAmt;
    atSing.inputbuf.Smlcode = iBuf.smlclsCd;
    atSing.inputbuf.Ocnt = 1;
  }

  ///  関連tprxソース: rcdetect.c - rcTch_Detect()
  static void rcTchDetect(RxInputBuf iBuf,int devno){
    AtSingl atSing = SystemFunc.readAtSingl();
    atSing.inputbuf.dev = DevIn.D_TCH;
    atSing.inputbuf.no = devno;
    atSing.inputbuf.Ocode[0] = iBuf.hardKey;
    atSing.inputbuf.Fcode = iBuf.funcCode;
    atSing.inputbuf.Acode = iBuf.devInf.data;
    atSing.inputbuf.Smlcode = iBuf.smlclsCd;
    atSing.inputbuf.Ocnt = 1;
  }

  ///  関連tprxソース: rcdetect.c - rcFncDetect
  static void rcFncDetect(int fncCd) {
    rcInputBufSave();
    RxInputBuf iBuf = SystemFunc.readRxInputBuf();
    iBuf.funcCode = fncCd;
    rcInputDataChk();
  }

  ///  関連tprxソース: rcdetect.c - rcMenuDetect
  // TODO:00007 梶原 コールしているrcInputDataChk()の中身を入れる必要性あり
  static Future<void> rcMenuDetect() async {
    rcInputBufSave();
    RxInputBuf iBuf = SystemFunc.readRxInputBuf();
    iBuf = RxInputBuf();
    AcMem cMem = SystemFunc.readAcMem();
    IfWaitSave ifSave = SystemFunc.readIfWaitSave();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if ((CmCksys.cmFbDualSystem() == 2)
        && (await RcSysChk.rcKySelf() == RcRegs.KY_DUALCSHR)) {
      if ((cMem.stat.dspEventMode == 100) || (ifSave.count > 0)) {
        tsBuf.cash.menukey_flg = 1;
      }
    }

    iBuf.funcCode = FuncKey.KY_MENU.keyId;
    rcInputDataChk();
  }

  ///  関連tprxソース: rcdetect.c - rcInputBuf_Save
  static void rcInputBufSave(){
    //I_BUFをセーブ。特定条件でのイベント後回し、捨てる等にてロードするため。
    /// cm_clr((char *)&I_BUF_sav, sizeof(RX_INPUT_BUF)); 【dart置き換え時コメント】iBufSav初期化
    iBufSav = RxInputBuf();

    /// memcpy((char *)&I_BUF_sav, (char *)I_BUF, sizeof(RX_INPUT_BUF));
    RxInputBuf iBuf = SystemFunc.readRxInputBuf();
    iBufSav.ctrl = iBuf.ctrl;
    iBufSav.devInf = iBuf.devInf;
    iBufSav.hardKey = iBuf.hardKey;
    iBufSav.mecData = iBuf.mecData;
    iBufSav.funcCode = iBuf.funcCode;
    iBufSav.smlclsCd = iBuf.smlclsCd;
    iBufSav.appGrpCd = iBuf.appGrpCd;
    iBufSav.inst = iBuf.inst;
  }

  ///  関連tprxソース: rcdetect.c - rcInputDataChk
  ///  TODO:00007 梶原 メソッド内で使用するrcInputData,rcCheckChkrCshr,RcSysChk.getTidが未実装
  static Future<void> rcInputDataChk() async {
    // 置き換え済みだがコメントアウトしておく
    RxInputBuf iBuf = SystemFunc.readRxInputBuf();
    AcMem cMem = SystemFunc.readAcMem();
    IfWaitSave ifSave = SystemFunc.readIfWaitSave();

    if (await rcInputSaveStateChk() == 1) {
      await RcIfEvent.rxIfSave(iBuf,0);
      if (await RcSysChk.rcChkFselfMain()) {  // 障害調査用のログ
        String temp1 = 'rcInputDataChk';    // 【originalCodeでは⇒を使用していた】__FUNCTION__
        int temp2 = cMem.stat.dspEventMode;
        int temp3 = ifSave.count;
        String log = "$temp1 return !! : DspEventMode = [$temp2] save_count = [$temp3]\n";
        TprLog().logAdd(await RcSysChk.getTid(),LogLevelDefine.normal,log);
        RcIfEvent.rcIfeventRxTimerReAdd();
      }
      return;
    }
    if (await RcSysChk.rcKySelf() == MachineType.kyDualCshr.value) {
      await rcInputData(iBuf);
    }
    else {
      if (await rcCheckChkrCshr()) {
        await rcInputData(iBuf);
      }
    }
  }

  ///  TODO:00007 梶原 メソッド内で使用するRcFncChk.rcChkRwcReadModeの実装が必要
  /// キーSAVE状態チェック
  /// 戻り値: 0=キーSAVE状態ではない  1=キーSAVE状態
  ///  関連tprxソース: rcdetect.c - rcInputSaveStateChk
  static Future<int> rcInputSaveStateChk() async {
    AcMem cMem = SystemFunc.readAcMem();
    IfWaitSave ifSave = SystemFunc.readIfWaitSave();
    if ((cMem.stat.dspEventMode == 100) || (await RcDishCalc.rcCheckDishMode()) || (ifSave.count > 0) && (!(RcFncChk.rcChkRwcReadMode()))){
      return 1;
    } else {
      return 0;
    }
  }

  ///  関連tprxソース: rcdetect.c - rcInputData
  ///  TODO:00007 梶原 今後実装予定だが元Cソースが340stepほどある為、後回しにする　
  static Future<void> rcInputData(RxInputBuf iBuf) async {
    int devNo = DevIn.KEY2;

    if (iBuf.devInf.devId == 1) {
      devNo = DevIn.KEY2;
      iBuf.devInf.devId = 0;
    } else if (FbInit.fbDualCshrChk()) {
      devNo = DevIn.KEY1;
    } else {
      devNo = DevIn.KEY2;
    }

    switch(iBuf.devInf.devId)
    {
      case             0 : rcTchDetect(iBuf, devNo);
      case TprDidDef.TPRDIDMECKEY1: rcKeyDetect(iBuf, DevIn.KEY1);
      case TprDidDef.TPRDIDMECKEY2: rcKeyDetect(iBuf, DevIn.KEY2);
      case TprDidDef.TPRDIDMECKEY6: rcKeyDetect(iBuf, DevIn.KEY1);
      case TprDidDef.TPRDIDMECKEY2:
        if(RcFncChk.rcCheckReservMode()){
          rcKeyDetect(iBuf, DevIn.KEY6);
        }else{
          return;
        }
    // TODO:10121 QUICPay、iD 202404実装対象外
    //   case TPRDIDSCANNER1: rcObr_Detect(KEY1);  break;
    //   case TPRDIDSCANNER2: rcObr_Detect(KEY2);  break;
    //   case TPRDIDMGC1JIS1: rcMcd_Detect(KEY1);  break;
    //   case TPRDIDMGC2JIS1: rcMcd_Detect(KEY2);  break;
    //   case TPRDIDMGC1JIS2: rcMcd_Detect(KEY1);  break;
    //   case TPRDIDMGC2JIS2: rcMcd_Detect(KEY2);  break;
    //   case TPRDIDTOUKEY1 : rcSml_Detect(KEY1);  break;
    //      :
      default:
    }

    await AcArange.rcArrange();
  }


  ///  関連tprxソース: rcdetect.c - rcCheck_Chkr_Cshr
  ///  TODO:00007 梶原 中で呼んでいるRcSet.rcClearIntFlagとRcEwdsp.rcErr2の実装が必要
  static Future<bool> rcCheckChkrCshr() async {
    RxInputBuf iBuf = SystemFunc.readRxInputBuf();
    AcMem cMem = SystemFunc.readAcMem();
    if (RcSysChk.rcCheckKyIntIn(false)
        && RcEvent.rcOpeInterErrFncCode(iBuf.funcCode)) {
      cMem.ent.errNo = RcIfEvent.rcSendInt(iBuf);
      if (cMem.ent.errNo != 0) {
        RcSet.rcClearIntFlag();
        await RcExt.rcErr('rcCheckChkrCshr', cMem.ent.errNo);
      }
      return false;
    }
    return true;
  }
  /// プリセットキーが呼ばれたときの処理.
  ///  関連tprxソース: rcdetect.c - rcItmGtkDetect
  static rcItmGtkDetect(PresetInfo itmPre ,int sideFlag ) async {
    // TODO:10121 QUICPay、iD 202404実装対象外
    // クイックペイ、iDで通っているところだけ実装

    rcInputBufSave();
    RxMemRet ret = SystemFunc.rxMemRead(RxMemIndex.RXMEM_CHK_INP);
    RxInputBuf iBuf =  ret.object; // 初期化するので取得できたかチェックはしない.
    iBuf = RxInputBuf(); // 初期化.
    iBuf.funcCode = itmPre.kyCd;
    iBuf.devInf.data = itmPre.kyPluCd;
    iBuf.smlclsCd = itmPre.kySmlclsCd;
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_CHK_INP, iBuf, RxMemAttn.MAIN_TASK);
    await rcInputDataChk();
  }

  ///  関連tprxソース: rcdetect.c - rcChk_FinalProcessing
  static bool rcChkFinalProcessing() {
    AcMem cMem = SystemFunc.readAcMem();
    return RcRegs.kyStC5(cMem.keyStat[FncCode.KY_FNAL.keyId]);
  }

  /// 関連tprxソース: rcdetect.c - rcAplDlg_Detect
  static Future<void> rcAplDlgDetect(FuncKey fncCd) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    RxInputBuf iBuf = SystemFunc.readRxInputBuf();
    rcInputBufSave();
    // iBufのクリア処理
    // cm_clr((char *)I_BUF, sizeof(RX_INPUT_BUF));
    iBuf = RxInputBuf();
    iBuf.funcCode = fncCd.keyId;
    if ((CmCksys.cmFbDualSystem() == 2) &&
        await RcSysChk.rcKySelf() == RcRegs.KY_SINGLE) {
      iBuf.devInf.devId = cBuf.devId;
    }
    rcInputDataChk();
  }
}

