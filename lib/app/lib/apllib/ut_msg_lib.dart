/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/lib/if_fcl.dart';
import 'package:flutter_pos/app/inc/sys/tpr_dlg.dart';
import 'package:flutter_pos/app/inc/sys/tpr_log.dart';
import 'package:flutter_pos/app/inc/sys/tpr_type.dart';

///関連tprxソース: ut_msg_lib.c
class UtMsgLib {

  /// TMNマルチ決済端末用エラーメッセージ変換Lib
  /// 関連tprxソース: ut_msg_lib.c - Set_Ut_ResErr
  /// 引数:TPRTID tid
  ///     int stat: ステータス（オーダーなど）※登録タスクで利用中
  ///     int opeBrand: 2:QUICPay、3:iD ※登録タスクで利用中
  /// 戻値:各種エラーコード
  static int SetUtResErr(TprTID tid, int stat, int opeBrand) {
    String errLog = "";
    int errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "SetUtResErr() rxMemRead error\n");
      return -1;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    // TODO:10121 QUICPay、iD 202404実装対象外
    // if(rxMemPtr(RXMEM_STAT, (void **)&TS_BUF_TMN) != RXMEM_OK) {
    //   snprintf(erlog, sizeof(erlog), "%s rxMemPtr get error(TS_BUF_TMN)\n", __FUNCTION__);
    //   TprLibLogWrite(tid, TPRLOG_ERROR, -1, erlog);
    //   err_no = MSG_MEMORYERR;
    //   return(err_no);
    // }
    //
    // if((! cm_Ut1_QUICPay_system()) && (! cm_Ut1_iD_system()) && (! cm_multi_vega_system())) {
    //   snprintf(erlog, sizeof(erlog), "%s Recog Key Error\n", __FUNCTION__);
    //   TprLibLogWrite(tid, TPRLOG_ERROR, -1, erlog);
    //   err_no = MSG_CHKSETTING;
    //   return(err_no);
    // }
    // if((TS_BUF_TMN->multi.err_cd != FCL_RESERR) && (TS_BUF_TMN->multi.err_cd != FCL_OCXERR)
    //     && !((ope_brand == FCL_SUIC) && (TS_BUF_TMN->multi.step == FCL_STEP_TRAN_RETRY1)))
    // {		snprintf(erlog, sizeof(erlog), "%s err_cd unmach multi.err_cd now[%d]\n", __FUNCTION__, TS_BUF_TMN->multi.err_cd);
    // TprLibLogWrite(tid, TPRLOG_ERROR, -1, erlog);
    // err_no = MSG_NOCODEERR;
    // return(err_no);
    // }

    switch(tsBuf.multi.fclData.resultCode){
      case 101:
        errNo = DlgConfirmMsgKind.MSG_OCXERR.dlgId;
        break;
      case 103:
        errNo = DlgConfirmMsgKind.MSG_OCXERR.dlgId;
        break;
      case 104:
        errNo = DlgConfirmMsgKind.MSG_OCXERR.dlgId;
        break;
      case 105:
        errNo = DlgConfirmMsgKind.MSG_OCXERR.dlgId;
        break;
      case 106:
        errNo = DlgConfirmMsgKind.MSG_OCXERR.dlgId;
        break;
      case 111:
        errNo = DlgConfirmMsgKind.MSG_OCXERR.dlgId;
        break;
      case 112:
        errNo = DlgConfirmMsgKind.MSG_OCX_TIMEOUT.dlgId;
        break;
      case 113:
        errNo = DlgConfirmMsgKind.MSG_OCXERR.dlgId;
        break;
      case 114:
        errNo = SetUtExtendErr(stat, opeBrand);
        break;
      default:
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
        break;
    }

    // TODO:10121 QUICPay、iD 202404実装対象外
    // if(cm_multi_vega_system())
    // {
    //   Change_MultiVega_ErrCode(&err_no);
    // }

    return errNo;
  }

  /// 関連tprxソース: ut_msg_lib.c - Set_Ut_ExtendErr
  static int SetUtExtendErr(int stat, int opeBrand){
    int errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "SetUtExtendErr() rxMemRead error\n");
      return -1;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    switch(tsBuf.multi.fclData.resultCodeExtended){
      case 110000001 :
        errNo = DlgConfirmMsgKind.MSG_OCXERR.dlgId;
        break;
      case 110000002 :
        errNo = DlgConfirmMsgKind.MSG_OCXERR.dlgId;
        break;
      case 110000003 :
        errNo = DlgConfirmMsgKind.MSG_OCXERR.dlgId;
        break;
      case 110000004 :
        errNo = DlgConfirmMsgKind.MSG_OCXERR.dlgId;
        break;
      case 110000005 :
        errNo = DlgConfirmMsgKind.MSG_OCXERR.dlgId;
        break;
      case 110000006 :
        errNo = DlgConfirmMsgKind.MSG_OCXERR.dlgId;
        break;
      case 120000001 :
        errNo = DlgConfirmMsgKind.MSG_MDLWARE_ERR.dlgId;
        break;
      case 120000002 :
        errNo = DlgConfirmMsgKind.MSG_MDLWARE_ERR.dlgId;
        break;
      case 122000001 :
        errNo = DlgConfirmMsgKind.MSG_MDLWARE_ERR.dlgId;
        break;
      case 122000002 :
        errNo = DlgConfirmMsgKind.MSG_MDLWARE_ERR.dlgId;
        break;
      case 123000001 :
        errNo = DlgConfirmMsgKind.MSG_MDLWARE_ERR.dlgId;
        break;
      case 123000002 :
        errNo = DlgConfirmMsgKind.MSG_TMN_CENTER_ERR.dlgId;
        break;
      case 123000004 :
        errNo = DlgConfirmMsgKind.MSG_MDLWARE_ERR.dlgId;
        break;
      case 123000006 :
        errNo = DlgConfirmMsgKind.MSG_TMN_CENTER_ERR.dlgId;
        break;
      case 123000007 :
        errNo = DlgConfirmMsgKind.MSG_TMN_CENTER_ERR.dlgId;
        break;
      case 123000008 :
        errNo = DlgConfirmMsgKind.MSG_TANPA_ERR.dlgId;
        break;
      case 123000009 :
        errNo = DlgConfirmMsgKind.MSG_TANPA_ERR.dlgId;
        break;
      case 123000010 :
        errNo = DlgConfirmMsgKind.MSG_UT1_COMERR.dlgId;
        break;
      case 130000001 :
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
        break;
      case 300000000 :
      case 200000000 :
      case 200000010 :
      case 200000110 :
      case 200001000 :
      case 200000001 :
        errNo = SetUtCenterErr(stat, opeBrand);
        break;
      default        :
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
        break;
    }
    return errNo;
  }

  /// 関連tprxソース: ut_msg_lib.c - Set_Ut_CenterErr
  static int SetUtCenterErr(int stat, int opeBrand){
    int errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "SetUtCenterErr() rxMemRead error\n");
      return -1;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    switch(tsBuf.multi.fclData.centerResultCode[0])
    {
      case 'A' :
        errNo = SetUtCenterErrA();
        break;
      case 'T' :
        errNo = SetUtCenterErrT();
        break;
      case 'S' :
        errNo = SetUtCenterErrS();
        break;
      case 'G' :
        if(tsBuf.multi.fclData.centerResultCode[1] == 'Q') {
          errNo = SetUtCenterErrGQ();
        }
        else {
          errNo = SetUtCenterErrG();
        }
        break;
      case 'C' :
        errNo = SetUtCenterErrC();
        break;
      case 'E' :
        errNo = SetUtCenterErrE();
        break;
      case 'K' :
        errNo = SetUtCenterErrK();
        break;
      case 'P' :
        errNo = SetUtCenterErrP();
        break;
      default  :
        errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
        break;
    }
    return errNo;
  }

  /// 関連tprxソース: ut_msg_lib.c - Set_Ut_CenterErr_A()
  static int SetUtCenterErrA(){
    int errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "SetUtCenterErrA() rxMemRead error\n");
      return -1;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if(tsBuf.multi.fclData.centerResultCode.startsWith('A1001')){
      errNo = DlgConfirmMsgKind.MSG_TMS_CNCTERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A1201')){
      errNo = DlgConfirmMsgKind.MSG_TMS_SYSERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A1202')){
      errNo = DlgConfirmMsgKind.MSG_TMS_SYSERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A1203')){
      errNo = DlgConfirmMsgKind.MSG_TMS_ERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A1204')){
      errNo = DlgConfirmMsgKind.MSG_TEXT8.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A1401')){
      errNo = DlgConfirmMsgKind.MSG_UT1_FLWR_ERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A1402')){
      errNo = DlgConfirmMsgKind.MSG_UT1_FLWR_ERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A1403')){
      errNo = DlgConfirmMsgKind.MSG_UT1_FLWR_ERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A1404')){
      errNo = DlgConfirmMsgKind.MSG_UT1_FLWR_ERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A1901')){
      errNo = DlgConfirmMsgKind.MSG_TMS_SYSERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2101')){
      errNo = DlgConfirmMsgKind.MSG_TMS_AUTHEN_ERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2102')){
      errNo = DlgConfirmMsgKind.MSG_TMS_SYSERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2103')){
      errNo = DlgConfirmMsgKind.MSG_TMS_MSTERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2104')){
      errNo = DlgConfirmMsgKind.MSG_TMS_MSTERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2105')){
      errNo = DlgConfirmMsgKind.MSG_TMS_MSTERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2201')){
      errNo = DlgConfirmMsgKind.MSG_TMS_MSTERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2202')){
      errNo = DlgConfirmMsgKind.MSG_TMS_MSTERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2203')){
      errNo = DlgConfirmMsgKind.MSG_TMS_MSTERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2204')){
      errNo = DlgConfirmMsgKind.MSG_TMS_MSTERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2205')){
      errNo = DlgConfirmMsgKind.MSG_TMS_MSTERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2206')){
      errNo = DlgConfirmMsgKind.MSG_TMS_MSTERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2207')){
      errNo = DlgConfirmMsgKind.MSG_TMS_MSTERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2208')){
      errNo = DlgConfirmMsgKind.MSG_TMS_MSTERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2209')){
      errNo = DlgConfirmMsgKind.MSG_TMS_MSTERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2210')){
      errNo = DlgConfirmMsgKind.MSG_TMS_MSTERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2211')){
      errNo = DlgConfirmMsgKind.MSG_TMS_MSTERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2212')){
      errNo = DlgConfirmMsgKind.MSG_TMS_MSTERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2301')){
      errNo = DlgConfirmMsgKind.MSG_TMSTEM_COMERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2302')){
      errNo = DlgConfirmMsgKind.MSG_TMSTEM_COMERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2303')){
      errNo = DlgConfirmMsgKind.MSG_TMSTEM_COMERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2304')){
      errNo = DlgConfirmMsgKind.MSG_TMSTEM_COMERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('A2901')){
      errNo = DlgConfirmMsgKind.MSG_TMS_EXPTERR.dlgId;
    }else{
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }

    return errNo;
  }

  /// 関連tprxソース: ut_msg_lib.c - Set_Ut_CenterErr_T()
  static int SetUtCenterErrT(){
    int errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "SetUtCenterErrT() rxMemRead error\n");
      return -1;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if(tsBuf.multi.fclData.centerResultCode.startsWith('T0101')){
      errNo = DlgConfirmMsgKind.MSG_CARD_RD_TIMEOUT.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0102')){
      errNo = DlgConfirmMsgKind.MSG_NOT_CARD_DATA.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0103')){
      errNo = DlgConfirmMsgKind.MSG_RD_ERR_CARD_RETOUCH.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0104')){
      errNo = DlgConfirmMsgKind.MSG_RD_ERR_CARD_RETOUCH.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0105')){
      errNo = DlgConfirmMsgKind.MSG_TEXT34.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0201')){
      errNo = DlgConfirmMsgKind.MSG_RD_ERR_CARD_RETOUCH.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0202')){
      errNo = DlgConfirmMsgKind.MSG_RD_ERR_CARD_RETOUCH.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0203')){
      errNo = DlgConfirmMsgKind.MSG_RD_ERR_CARD_RETOUCH.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0204')){
      errNo = DlgConfirmMsgKind.MSG_RD_ERR_CARD_RETOUCH.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0205')){
      errNo = DlgConfirmMsgKind.MSG_RD_ERR_CARD_RETOUCH.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0206')){
      errNo = DlgConfirmMsgKind.MSG_RD_ERR_CARD_PIN.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0301')){
      errNo = DlgConfirmMsgKind.MSG_CRDT_LIMIT.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0401')){
      errNo = DlgConfirmMsgKind.MSG_CRDT_LIMIT.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0402')){
      errNo = DlgConfirmMsgKind.MSG_CARD_ERR_PUBLISER.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0403')){
      errNo = DlgConfirmMsgKind.MSG_CANT_USE.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0404')){
      errNo = DlgConfirmMsgKind.MSG_CARD_NOT_SAME.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0405')){
      errNo = DlgConfirmMsgKind.MSG_TEXT27.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0406')){
      errNo = DlgConfirmMsgKind.MSG_CRDT_LIMIT.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0501')){
      errNo = DlgConfirmMsgKind.MSG_CENTER_SYSERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0502')){
      errNo = DlgConfirmMsgKind.MSG_CENTER_SYSERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0601')){
      errNo = DlgConfirmMsgKind.MSG_CARD_WRITE_ERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0602')){
      errNo = DlgConfirmMsgKind.MSG_CARD_WRITE_ERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0603')){
      errNo = DlgConfirmMsgKind.MSG_CARD_WR_TIMEOUT.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0605')){
      errNo = DlgConfirmMsgKind.MSG_CARD_NOT_WR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0701')){
      errNo = DlgConfirmMsgKind.MSG_NONEXISTDATA.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0702')){
      errNo = DlgConfirmMsgKind.MSG_CORRDATA.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0703')){
      errNo = DlgConfirmMsgKind.MSG_PRCERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0704')){
      errNo = DlgConfirmMsgKind.MSG_PRCERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0705')){
      errNo = DlgConfirmMsgKind.MSG_NOT_CONDITION.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0707')){
      errNo = DlgConfirmMsgKind.MSG_CRDTNO_NOTAGREE.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0708')){
      errNo = DlgConfirmMsgKind.MSG_CANNOT_THIS_CANCEL.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0901')){
      errNo = DlgConfirmMsgKind.MSG_SALE_UPDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T0902')){
      errNo = DlgConfirmMsgKind.MSG_SALE_UPDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T1001')){
      errNo = DlgConfirmMsgKind.MSG_CARD_ERR_PUBLISER.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T1101')){
      errNo = DlgConfirmMsgKind.MSG_CARD_ERR_PUBLISER.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T1102')){
      errNo = DlgConfirmMsgKind.MSG_CARD_ERR_PUBLISER.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T1111')){
      errNo = DlgConfirmMsgKind.MSG_CARD_ERR_PUBLISER.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T1201')){
      errNo = DlgConfirmMsgKind.MSG_CARD_ERR_PUBLISER.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T1301')){
      errNo = DlgConfirmMsgKind.MSG_CRDT_LIMIT.dlgId; //高額支払い時に1verではキー入力が要求されたがアークス様対応のver12ベースと同じく利用可能額オーバーのエラーとします
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T1302')){
      errNo = DlgConfirmMsgKind.MSG_PINNO_IN_TIMEOUT.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T1303')){
      errNo = DlgConfirmMsgKind.MSG_PINNO_IN_CNCL.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T1304')){
      errNo = DlgConfirmMsgKind.MSG_PINNO_NOT_INPUT.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T1305')){
      errNo = DlgConfirmMsgKind.MSG_UT1_ONOFF.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T1501')){
      errNo = DlgConfirmMsgKind.MSG_RD_ERR_CARD_RETOUCH.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T1502')){
      errNo = DlgConfirmMsgKind.MSG_RD_ERR_CARD_RETOUCH.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T1503')){
      errNo = DlgConfirmMsgKind.MSG_RD_ERR_CARD_RETOUCH.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T1601')){
      errNo = DlgConfirmMsgKind.MSG_TMN_SYSERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T1701')){
      errNo = DlgConfirmMsgKind.MSG_TMN_SYSERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T2001')){
      errNo = DlgConfirmMsgKind.MSG_TELEGRM_ERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T2101')){
      errNo = DlgConfirmMsgKind.MSG_RD_ERR_CARD_RETOUCH.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T2301')){
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T2302')){
      errNo = DlgConfirmMsgKind.MSG_TEXT8.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T2401')){
      errNo = DlgConfirmMsgKind.MSG_DATACORRUPT.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T2402')){
      errNo = DlgConfirmMsgKind.MSG_DATACORRUPT.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T2403')){
      errNo = DlgConfirmMsgKind.MSG_DATACORRUPT.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T2404')){
      errNo = DlgConfirmMsgKind.MSG_DATACORRUPT.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T9001')){
      errNo = DlgConfirmMsgKind.MSG_EXPLOIT_CONDITION_NG.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T9002')){
      errNo = DlgConfirmMsgKind.MSG_EXPLOIT_CONDITION_NG.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T9003')){
      errNo = DlgConfirmMsgKind.MSG_EXPLOIT_CONDITION_NG.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T9012')){
      errNo = DlgConfirmMsgKind.MSG_EDY_PEC2_LOGFULL.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T9901')){
      errNo = DlgConfirmMsgKind.MSG_DATACORRUPT.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('T9902')){
      errNo = DlgConfirmMsgKind.MSG_DATACORRUPT.dlgId;
    }else{
      errNo = DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }

    return errNo;
  }

  /// 関連tprxソース: ut_msg_lib.c - Set_Ut_CenterErr_S()
  static int SetUtCenterErrS(){
    int errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "SetUtCenterErrS() rxMemRead error\n");
      return -1;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if(tsBuf.multi.fclData.centerResultCode.startsWith('S20')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('S29')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else{
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }

    return errNo;
  }

  /// 関連tprxソース: ut_msg_lib.c - Set_Ut_CenterErr_GQ()
  static int SetUtCenterErrGQ(){
    int errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "SetUtCenterErrGQ() rxMemRead error\n");
      return -1;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if(tsBuf.multi.fclData.centerResultCode.startsWith('GQ1')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('GQ2')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('GQ3')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('GQ4')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('GQ5')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('GQ6')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('GQ7')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('GQ8')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('GQ9')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else{
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }

    return errNo;
  }

  /// 関連tprxソース: ut_msg_lib.c - Set_Ut_CenterErr_G()
  static int SetUtCenterErrG(){
    int errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "SetUtCenterErrG() rxMemRead error\n");
      return -1;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if(tsBuf.multi.fclData.centerResultCode.startsWith('G12')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('G42')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('G54')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('G55')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('G56')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('G60')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('G61')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('G65')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('G67')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('G68')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('G77')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('G80')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('G81')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('G83')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('G84')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('G97')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else{
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }

    return errNo;
  }

  /// 関連tprxソース: ut_msg_lib.c - Set_Ut_CenterErr_C()
  static int SetUtCenterErrC(){
    int errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "SetUtCenterErrC() rxMemRead error\n");
      return -1;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if(tsBuf.multi.fclData.centerResultCode.startsWith('C01')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('C12')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('C13')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('C14')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('C15')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('C53')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('C54')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('C55')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('C56')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('C57')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('C58')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('C60')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else{
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }

    return errNo;
  }

  /// 関連tprxソース: ut_msg_lib.c - Set_Ut_CenterErr_E()
  static int SetUtCenterErrE(){
    int errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "SetUtCenterErrE() rxMemRead error\n");
      return -1;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if(tsBuf.multi.fclData.centerResultCode.startsWith('E90')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else{
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }

    return errNo;
  }

  /// 関連tprxソース: ut_msg_lib.c - Set_Ut_CenterErr_K()
  static int SetUtCenterErrK(){
    int errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "SetUtCenterErrK() rxMemRead error\n");
      return -1;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if(tsBuf.multi.fclData.centerResultCode.startsWith('K01')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('K02')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('K40')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('K50')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else{
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }

    return errNo;
  }

  /// 関連tprxソース: ut_msg_lib.c - Set_Ut_CenterErr_P()
  static int SetUtCenterErrP(){
    int errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "SetUtCenterErrP() rxMemRead error\n");
      return -1;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if(tsBuf.multi.fclData.centerResultCode.startsWith('P30')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('P31')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('P50')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('P51')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('P52')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('P53')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('P54')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('P55')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('P65')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('P68')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('P80')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('P81')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('P83')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else if(tsBuf.multi.fclData.centerResultCode.startsWith('P90')){
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }else{
      errNo = DlgConfirmMsgKind.MSG_CRDTDEMANDERR.dlgId;
    }

    return errNo;
  }
}