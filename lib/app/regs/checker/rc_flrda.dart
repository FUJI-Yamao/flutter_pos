/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/fnc_code.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/regs/checker/rcnoteplu.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rx_mbr_ata_chk.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxtbl_buff.dart';
import '../../inc/apl/rxtbl_buff_keyopt.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_log.dart';

class RcFlrda {

  ///関連tprxソース:rc_flrda.c - rcRead_kopttran
  static Future<bool> rcReadKopttran(int fncCode, KopttranBuff pKoptTran, {int bufSize = 0}) async {
    bool result;
    String log = "";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    result = true;
    ClrKoptTran();

    if(pCom.dbKfnc[fncCode].fncKind == KeyKindList.KEY_KIND_CASH)  {
      pKoptTran.frcCustCallFlg  = pCom.dbKfnc[fncCode].opt.cash.frcCustCallFlg;
      pKoptTran.stlMinusFlg     = pCom.dbKfnc[fncCode].opt.cash.stlMinusFlg;
      pKoptTran.frcStlkyFlg     = pCom.dbKfnc[fncCode].opt.cash.frcStlkyFlg;
      pKoptTran.stlOverFlg      = pCom.dbKfnc[fncCode].opt.cash.stlOverFlg ;
      pKoptTran.splitEnbleFlg   = pCom.dbKfnc[fncCode].opt.cash.splitEnbleFlg;
      pKoptTran.frcEntryFlg     = pCom.dbKfnc[fncCode].opt.cash.frcEntryFlg;
      pKoptTran.acbDrwFlg       = pCom.dbKfnc[fncCode].opt.cash.acbDrwFlg;
      pKoptTran.frcStlkyChkrFlg = pCom.dbKfnc[fncCode].opt.cash.frcStlkyChkrFlg;
      pKoptTran.digit           = pCom.dbKfnc[fncCode].opt.cash.digit;
      pKoptTran.crdtEnbleFlg    = pCom.dbKfnc[fncCode].opt.cash.chgamtRecalcFlg;
    } else if(pCom.dbKfnc[fncCode].fncKind == KeyKindList.KEY_KIND_CHA) {
      pKoptTran.frcCustCallFlg    = pCom.dbKfnc[fncCode].opt.cha.frcCustCallFlg;
      pKoptTran.stlMinusFlg       = pCom.dbKfnc[fncCode].opt.cha.stlMinusFlg;
      pKoptTran.frcStlkyFlg       = pCom.dbKfnc[fncCode].opt.cha.frcStlkyFlg;
      pKoptTran.stlOverFlg        = pCom.dbKfnc[fncCode].opt.cha.stlOverFlg ;
      pKoptTran.splitEnbleFlg     = pCom.dbKfnc[fncCode].opt.cha.splitEnbleFlg;
      pKoptTran.frcEntryFlg       = pCom.dbKfnc[fncCode].opt.cha.frcEntryFlg;
      pKoptTran.mulFlg            = pCom.dbKfnc[fncCode].opt.cha.mulFlg;
      pKoptTran.acbDrwFlg         = pCom.dbKfnc[fncCode].opt.cha.acbDrwFlg;
      pKoptTran.tranUpdateFlg     = pCom.dbKfnc[fncCode].opt.cha.tranUpdateFlg;
      pKoptTran.crdtEnbleFlg      = pCom.dbKfnc[fncCode].opt.cha.crdtEnbleFlg;
      pKoptTran.crdtTyp           = pCom.dbKfnc[fncCode].opt.cha.crdtTyp;
      pKoptTran.ticketCollectFlg  = pCom.dbKfnc[fncCode].opt.cha.ticketCollectFlg;
      pKoptTran.digit             = pCom.dbKfnc[fncCode].opt.cha.digit;
      pKoptTran.nochgFlg          = pCom.dbKfnc[fncCode].opt.cha.nochgFlg;
      pKoptTran.restmpFlg         = pCom.dbKfnc[fncCode].opt.cha.restmpFlg;
      pKoptTran.chkAmt            = pCom.dbKfnc[fncCode].opt.cha.chkAmt;
      pKoptTran.cashlessFlg       = pCom.dbKfnc[fncCode].opt.cha.cashlessFlg;
      pKoptTran.cashlessTyp       = pCom.dbKfnc[fncCode].opt.cha.cashlessTyp;
      pKoptTran.unreadCashTyp     = pCom.dbKfnc[fncCode].opt.cha.unreadCashTyp;
      pKoptTran.campaignDscntOpe  = pCom.dbKfnc[fncCode].opt.cha.campaignDscntOpe;
      pKoptTran.campaignDscntRate = pCom.dbKfnc[fncCode].opt.cha.campaignDscntRate;
      pKoptTran.campaignUprlmtAmt = pCom.dbKfnc[fncCode].opt.cha.campaignUprlmtAmt;
      pKoptTran.campaignLowlmtAmt = pCom.dbKfnc[fncCode].opt.cha.campaignLowlmtAmt;
    } else {
      //TranKey でない
      log = "rcReadKopttran : FncCode[${fncCode}] -> KoptTran Not Read";
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error, log);
      return false;
    }
    pKoptTran.tranCd = fncCode;

    if((await CmCksys.cmCrdtSystem() != 0)     // クレジット仕様
        && (pKoptTran.crdtEnbleFlg == 1) // 掛売許可？
        && (pKoptTran.crdtTyp == 0)      // クレジットで使用？
        && (RcSysChk.rcChkKYCHA(fncCode))){
      pKoptTran.chkAmt = 0; // 券面金額クリア
      // TODO:10108 コンパイルスイッチ(MC_SYSTEM)
      //#if MC_SYSTEM
      //     pKoptTran->frc_stlky_flg = 0;
      //#endif
    }
    if(RcSysChk.rcCheckWiz()){
      pKoptTran.frcEntryFlg = 0;
    }
    if(await RcNotePlu.rcCheckNotePlu()){
      pKoptTran.frcEntryFlg = 0;
    }

    if(RcSysChk.rcChkQRKoptStatusChange()) {// キーオプションリード時のローカルメモリーを変更する
      pKoptTran.frcCustCallFlg	 = 0;
      pKoptTran.frcStlkyFlg   	 = 0;
      pKoptTran.stlOverFlg  		 = 1;
      pKoptTran.splitEnbleFlg 	 = 1;
      pKoptTran.frcEntryFlg   	 = 0;
      pKoptTran.mulFlg      		 = 1;
      pKoptTran.crdtEnbleFlg  	 = 0;
      pKoptTran.unreadCashTyp 	 = 0;
      pKoptTran.campaignDscntOpe = 0;

      if((RecogLists.RECOG_QCASHIER_SYSTEM != 0)
          || (RecogLists.RECOG_HAPPYSELF_SYSTEM != 0)){
        if(pKoptTran.nochgFlg == 1){
          ; // 釣り無しの取引レシートをQCashierで印字したい為
        }else if(pKoptTran.nochgFlg == 2){ // 確認表示
          pKoptTran.nochgFlg = 1; // おつりが出ないように
        }else{
          pKoptTran.nochgFlg = 0;
        }
      }else{
        pKoptTran.nochgFlg = 0;
      }
    }
    return result;
  }

  /// KopttranBuffの中身を0で初期化する
  static void ClrKoptTran(){
    KopttranBuff pKoptTran = KopttranBuff();

    pKoptTran.tranCd = 0;
    pKoptTran.frcCustCallFlg = 0;
    pKoptTran.stlMinusFlg = 0;
    pKoptTran.frcStlkyFlg = 0;
    pKoptTran.stlOverFlg = 0;
    pKoptTran.splitEnbleFlg = 0;
    pKoptTran.frcEntryFlg = 0;
    pKoptTran.mulFlg = 0;
    pKoptTran.acbDrwFlg = 0;
    pKoptTran.tranUpdateFlg = 0;
    pKoptTran.crdtEnbleFlg = 0;
    pKoptTran.crdtTyp = 0;
    pKoptTran.ticketCollectFlg = 0;
    pKoptTran.frcStlkyChkrFlg = 0;
    pKoptTran.digit = 0;
    pKoptTran.nochgFlg = 0;
    pKoptTran.restmpFlg = 0;
    pKoptTran.chkAmt = 0;
    pKoptTran.cashlessFlg = 0;
    pKoptTran.cashlessTyp = 0;
    pKoptTran.unreadCashTyp = 0;
    pKoptTran.campaignDscntOpe = 0;
    pKoptTran.campaignDscntRate = 0;
    pKoptTran.campaignUprlmtAmt = 0;
    pKoptTran.campaignLowlmtAmt = 0;
  }

  ///関連tprxソース:rc_flrda.c - rcRead_koptinout
  static Future<bool> rcReadKoptinout(int fncCode, KoptinoutBuff pKoptInOut) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if(xRet.isInvalid()){
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
    KeyfncBuff keyData = cBuf.dbKfnc[fncCode];

    if (keyData.fncKind == KeyKindList.KEY_KIND_CIN) {
      //入金系
      pKoptInOut.frcSelectFlg    = keyData.opt.cin.frcSelectFlg;
      pKoptInOut.acbDrwFlg       = keyData.opt.cin.acbDrwFlg;
      pKoptInOut.digit           = keyData.opt.cin.digit;
      pKoptInOut.kyTyp           = keyData.opt.cin.kyTyp;
      pKoptInOut.restmpFlg       = keyData.opt.cin.restmpFlg;
      pKoptInOut.divideFlg       = keyData.opt.cin.divideFlg;
      pKoptInOut.tranCreateFlg   = keyData.opt.cin.tranCreateFlg;
      pKoptInOut.frcSelectOutFlg = 0; //ky_cin_optに存在しない -> 入金では金種別出金を0:しない
      pKoptInOut.keepFlg         = 0; //ky_cin_optに存在しない -> 入力内容を保持を0:しない
      pKoptInOut.outBarcodeFlg   = 0; //ky_cin_optに存在しない -> 入力内容を保持を0:しない
    } else if (fncCode == FuncKey.KY_CHGCIN.keyId) {
      //釣機入金
      pKoptInOut.frcSelectFlg    = 0;	//ky_chgcin_optに存在しない -> 釣機入金では金種別登録を0:しない
      pKoptInOut.acbDrwFlg       = keyData.opt.chgcin.acbDrwFlg;
      pKoptInOut.digit           = keyData.opt.chgcin.digit;
      pKoptInOut.kyTyp           = FuncKey.KY_CASH.keyId;	//ke_chgcin_optに存在しない -> 釣機入金では現金加算
      pKoptInOut.restmpFlg       = keyData.opt.chgcin.restmpFlg;
      pKoptInOut.divideFlg       = keyData.opt.chgcin.divideFlg;
      pKoptInOut.tranCreateFlg   = keyData.opt.chgcin.tranCreateFlg;
      pKoptInOut.frcSelectOutFlg = 0; //ky_chgcin_optに存在しない -> 釣機入金では金種別出金を0:しない
      pKoptInOut.keepFlg         = 0;//ky_chgcin_optに存在しない -> 入力内容を保持を0:しない
      pKoptInOut.outBarcodeFlg   = 0; //ky_chgcin_optに存在しない -> 入力内容を保持を0:しない
    } else if (keyData.fncKind == KeyKindList.KEY_KIND_OUT) {
      //支払系
      pKoptInOut.frcSelectFlg    = keyData.opt.out.frcSelectFlg;
      pKoptInOut.acbDrwFlg       = keyData.opt.out.acbDrwFlg;
      pKoptInOut.digit           = keyData.opt.out.digit;
      pKoptInOut.kyTyp           = keyData.opt.out.kyTyp;
      pKoptInOut.restmpFlg       = 0; ///ky_out_optに存在しない -> 支払では収入印紙発行を0:しない
      pKoptInOut.divideFlg       = keyData.opt.out.divideFlg;
      pKoptInOut.tranCreateFlg   = keyData.opt.out.tranCreateFlg;
      pKoptInOut.frcSelectOutFlg = 0; //ky_out_optに存在しない -> 支払では金種別出金を0:しない
      pKoptInOut.keepFlg         = 0; //ky_out_optに存在しない -> 入力内容を保持を0:しない
      pKoptInOut.outBarcodeFlg   = 0; //ky_out_optに存在しない -> 入力内容を保持を0:しない
    } else if (fncCode == FuncKey.KY_CHGOUT.keyId)    {
      //釣機払出
      pKoptInOut.frcSelectFlg    = keyData.opt.chgout.frcSelectFlg;
      pKoptInOut.acbDrwFlg       = keyData.opt.chgout.acbDrwFlg;
      pKoptInOut.digit           = keyData.opt.chgout.digit;
      pKoptInOut.kyTyp           = FuncKey.KY_CASH.keyId;	//ky_chgout_optに存在しない -> 釣機払出では現金加算
      pKoptInOut.restmpFlg       = 0;	///ky_chgout_optに存在しない -> 支払では収入印紙発行を0:しない
      pKoptInOut.divideFlg       = keyData.opt.chgout.divideFlg;
      pKoptInOut.tranCreateFlg   = keyData.opt.chgout.tranCreateFlg;
      pKoptInOut.frcSelectOutFlg = keyData.opt.chgout.frcSelectOutFlg;
      pKoptInOut.keepFlg         = 0; //ky_chgout_optに存在しない -> 入力内容を保持を0:しない
      pKoptInOut.outBarcodeFlg   = 0; //ky_chgout_optに存在しない -> 入力内容を保持を0:しない
    } else if (fncCode == FuncKey.KY_CHG_MENTEOUT.keyId) {
      //取引外払出	キーオプション設定なし
      pKoptInOut.frcSelectFlg    = 1;	//金種別登録のみ
      pKoptInOut.acbDrwFlg       = 0;
      pKoptInOut.digit           = 7;
      pKoptInOut.kyTyp           = FuncKey.KY_CASH.keyId;	//現金加算
      pKoptInOut.restmpFlg       = 0;	///収入印紙発行を0:しない
      pKoptInOut.divideFlg       = 0;	//区分選択がない
      pKoptInOut.tranCreateFlg   = 1;	//理論在高作成しない
      pKoptInOut.frcSelectOutFlg = 0;
      pKoptInOut.keepFlg         = 0; //入力内容を保持を0:しない
      pKoptInOut.outBarcodeFlg   = 0; //入力内容を保持を0:しない
    } else if (fncCode == FuncKey.KY_LOAN.keyId) {
      //釣準備
      pKoptInOut.frcSelectFlg    = keyData.opt.loan.frcSelectFlg;
      pKoptInOut.acbDrwFlg       = keyData.opt.loan.acbDrwFlg;
      pKoptInOut.digit           = keyData.opt.loan.digit;
      pKoptInOut.kyTyp           = keyData.opt.loan.kyTyp;
      pKoptInOut.restmpFlg       = 0;	///ky_loan_optに存在しない -> 釣準備では収入印紙発行を0:しない
      pKoptInOut.divideFlg       = 0;	//ky_loan_optに存在しない -> 釣準備では区分選択がない
      pKoptInOut.tranCreateFlg   = keyData.opt.loan.tranCreateFlg;
      pKoptInOut.frcSelectOutFlg = 0;	//ky_loan_optに存在しない -> 釣準備では金種別出金を0:しない
      pKoptInOut.keepFlg         = keyData.opt.loan.keepFlg;
      pKoptInOut.outBarcodeFlg   = 0;	//ky_loan_optに存在しない -> 釣準備では金種別出金を0:しない
    } else if (fncCode == FuncKey.KY_PICK.keyId) {
      //売上回収
      pKoptInOut.frcSelectFlg    = keyData.opt.pick.frcSelectFlg;
      pKoptInOut.acbDrwFlg       = keyData.opt.pick.acbDrwFlg;
      pKoptInOut.digit           = keyData.opt.pick.digit;
      pKoptInOut.kyTyp           = keyData.opt.pick.kyTyp;
      pKoptInOut.restmpFlg       = 0;	//ky_pick_optに存在しない -> 売上回収では収入印紙発行を0:しない
      pKoptInOut.divideFlg       = 0;	//ky_pick_optに存在しない -> 売上回収では区分選択がない
      pKoptInOut.tranCreateFlg   = keyData.opt.pick.tranCreateFlg;
      pKoptInOut.frcSelectOutFlg = 0;	//ky_pick_optに存在しない -> 売上回収では金種別出金を0:しない
      pKoptInOut.keepFlg         = 0; //ky_pick_optに存在しない -> 入力内容を保持を0:しない
      pKoptInOut.outBarcodeFlg   = 0; //ky_pick_optに存在しない -> 入力内容を保持を0:しない
    } else if (fncCode == FuncKey.KY_CHGPICK.keyId) {
      //釣機回収
      pKoptInOut.frcSelectFlg    = 1; //ky_chgpick_optに存在しない -> 釣機回収では金種別登録のみ
      pKoptInOut.acbDrwFlg       = 0; //ky_chgpick_optに存在しない -> 釣機回収ではドロア開けない
      pKoptInOut.digit           = 7; //ky_chgpick_optに存在しない -> 釣機回収では金種別登録のみなので不要
      pKoptInOut.kyTyp           = FuncKey.KY_CASH.keyId;	//ky_chgpick_optに存在しない -> 釣機回収では現金加算
      pKoptInOut.restmpFlg       = 0; //ky_chgpick_optに存在しない -> 釣機回収では収入印紙発行を0:しない
      pKoptInOut.divideFlg       = 0; //ky_chgpick_optに存在しない -> 釣機回収では区分選択がない
      pKoptInOut.tranCreateFlg   = keyData.opt.chgpick.tranCreateFlg;
      pKoptInOut.frcSelectOutFlg = keyData.opt.chgpick.frcSelectOutFlg;
      pKoptInOut.keepFlg         = 0; //ky_chgpick_optに存在しない -> 入力内容を保持を0:しない
      pKoptInOut.outBarcodeFlg   = keyData.opt.chgpick.outBarcodeFlg;
    } else {
      //InOutKey でない
      String message =
          'rcReadkoptinout : FncCode[$fncCode] -> KoptInout Not Read';
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, message);
      return false;
   }
    return true;
  }
}
