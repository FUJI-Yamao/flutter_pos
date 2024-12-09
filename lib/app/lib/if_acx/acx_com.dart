/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:isolate';
import 'package:flutter/cupertino.dart';

import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../drv/changer/drv_changer_isolate.dart';
import '../../if/if_drv_control.dart';
import '../../if/if_changer_isolate.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/sys/tpr_def_asc.dart';
import '../../tprlib/tprlib_generic.dart';
import '../apllib/cnct.dart';
import '../cm_sys/cm_cksys.dart';

/// 関連tprxソース:acx_com.c
class AcxCom {
  ////*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxRcvDLEChk()
  /// * 機能概要      : Coin/Bill Changer & Coin Changer RcvData Checking
  /// * 引数          : TprTID src
  /// *               : List<String> rcvdata  レスポンスデータ
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  /// *               : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static int ifAcxRcvDLEChk(TprTID src, List<String> rcvdata)
  {

    int err_code;

    switch(rcvdata[0])
    {
        case TprDefAsc.ACK:
        case TprDefAsc.ETB:
            err_code = IfAcxDef.MSG_ACROK;
            break;
        case TprDefAsc.CAN:
        case TprDefAsc.NAK:
        case TprDefAsc.BEL:
            err_code = DlgConfirmMsgKind.MSG_ACRERROR.index;
            break;
        case TprDefAsc.FS://BON
        case TprDefAsc.SUB:
            err_code = DlgConfirmMsgKind.MSG_ACRACT.index;
            break;
        case TprDefAsc.EM:
            err_code = DlgConfirmMsgKind.MSG_ACB_STOPSTATUS.index;
            break;
        case TprDefAsc.DC2:
            err_code = DlgConfirmMsgKind.MSG_TAKE_MONEY.index;
            break;
        case TprDefAsc.SOH:
            err_code = DlgConfirmMsgKind.MSG_ACB_CINSTATUS.index;
            break;
        case TprDefAsc.DC4:
            err_code = DlgConfirmMsgKind.MSG_CHARGING.index;
            break;
        case TprDefAsc.DC3:
            //err_code = MSG_SETTINGERR;
            err_code = DlgConfirmMsgKind.MSG_TEXT192.index;
            break;
        default:
            err_code = IfAcxDef.MSG_ACROK;
            break;
    }
    
    return err_code;
  }

  ////*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxRcvHeadChk()
  /// * 機能概要      : Coin/Bill Changer & Coin Changer RcvData Header Checking
  /// * 引数          : TprTID src 
  /// *               : TprMsgDevReq2_t rcvBuf  受信データ
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  /// *               : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static int ifAcxRcvHeadChk(TprTID src, TprMsgDevReq2_t rcvBuf)
  {
    int    iDrvno;
    int    i;
    int    cnt;

    if(rcvBuf.result == TprDidDef.TPRDEVRESULTOFFLINE){    /* device off-line ?        */
        return ( DlgConfirmMsgKind.MSG_ACRLINEOFF.index );        /* NG !                */
    }
    else if(rcvBuf.result != TprDidDef.TPRDEVRESULTOK){    /* device I/O result OK ?    */
        if(rcvBuf.result == TprDidDef.TPRDEVRESULTTIMEOUT)
        {
           return ( DlgConfirmMsgKind.MSG_ACX_RESULT_TIMEOUT.index );
        }
        if(rcvBuf.result == TprDidDef.TPRDEVRESULTEERR)
        {
           return ( DlgConfirmMsgKind.MSG_ACRACT.index );
        }
        if(rcvBuf.result == TprDidDef.TPRDEVRESULTGIVEUP)
        {
           return ( DlgConfirmMsgKind.MSG_TEXT37.index );
        }
        if(rcvBuf.result == TprDidDef.TPRDEVRESULTWERR)
        {
           return ( IfAcxDef.MSG_ACRCMDERR );
        }
        return ( DlgConfirmMsgKind.MSG_ACRERROR.index );        /* NG !                */
    }

    return IfAcxDef.MSG_ACROK;
  }

  ////*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxTransmit()
  /// * 機能概要      : 釣銭機にデータ送信
  /// * 引数          : TprTID src 
  /// *               : List<String> sendData  送信データ
  /// *               : int length  送信データ長
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  /// *               : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxTransmit(TprTID src, List<String> sendData, int length) async {
    var receivePort = ReceivePort();
    int i = 0;
    TprMsgDevReq2_t  sendbuf = TprMsgDevReq2();

    // ドライバチェック
    if( !IfChangerIsolate.isChangerStat || 
        !IfChangerIsolate.isInit){
        return(IfAcxDef.MSG_ACRNOTOPEN);
    }
    sendbuf.tid      = IfChangerIsolate.taskId;     /* device ID                   */
    sendbuf.mid      = TprMidDef.TPRMID_DEVREQ;    /* an area of the message receiving */
    sendbuf.src      = src;         /* Spec-N001 */
    sendbuf.io       = await acxSeqNoSet();             /* sequence No. */
    sendbuf.result   = 0;             /* device I/O result */
    sendbuf.datalen  = length;        /* datalen & sequence No. */
    for( i=0; i<1024; i++) {
        sendbuf.data[i] = '\0';
    }
    for( i=0; i<length; i++) {
        sendbuf.data[i] = sendData[i];
    }
    IfDrvControl().changerIsolateCtrl.changerIsolatePort!.send(NotifyFromApp(NotifyTypeFromMIsolate.changerRequest, 0, msg:sendbuf, returnPort:receivePort.sendPort));
    debugPrint("receivePort.first as changerAcxTransmit receive in." );
    final notifyFromDev = await receivePort.first as ChangerDataReceiveResult;
    debugPrint("receivePort.first as changerAcxTransmit receive out. result = " + notifyFromDev.msg.result.toString() );
    receivePort.close();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return notifyFromDev.msg.result;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    tsBuf.catchDateTime1 = DateTime.now();
    debugPrint("catchDateTime1の値設定 : ${tsBuf.catchDateTime1}");
    return ifAcxRcvHeadChk(src, notifyFromDev.msg);
  }

  static Future<void> ifAcxReceive(TprMsgDevNotify2_t notify) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    tsBuf.catchDateTime2 = DateTime.now();
    tsBuf.acx.devAck = notify;
    debugPrint("**** catchDateTime2の値を設定する : ${tsBuf.catchDateTime2}");

  }
  ///  関連tprxソース:acx_com.c - if_acb_select()
  static int ifAcbSelect() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, " if_acb_select() rxMemRead() error");
      return DlgConfirmMsgKind.MSG_ACRERROR.dlgId;
    }
    RxCommonBuf pComBuf = xRet.object;

    int acbIndex = Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_ACB_SELECT);
    switch(acbIndex) {
      case 0:                               /* ACB-10 */
        if ((pComBuf.iniMacInfo.internal_flg.mode == 4)
            && (pComBuf.dbTrm.traningDrawAcxFlg == 0)) {
               return CoinChanger.ECS;      //精算機を動作させるために設定されていなければECSにする
        }
               return CoinChanger.ACB_10;   /* ACB-10 */
      case 1:  return CoinChanger.ACB_20;   /* ACB-20 */
      case 2:  return CoinChanger.ACB_50_;  /* ACB-50 */
      case 3:  return CoinChanger.ECS;      /* ECS */
      case 4:  return CoinChanger.SST1;     /* SST1 */
      case 5:  return CoinChanger.ACB_200;  /* ACB-200 */
      case 6:  return CoinChanger.FAL2;     /* FAL2 */
      case 7:  return CoinChanger.RT_300;   /* ACB-300 */
      case 8:  return CoinChanger.ECS_777;  /* ECS-777 */
      default: break;
    }
    TprLog().logAdd(0, LogLevelDefine.error, " if_acb_select() error[$acbIndex]");

    return DlgConfirmMsgKind.MSG_ACRERROR.dlgId;
  }
  ////*--------------------------------------------------------------------------------
  /// * 関数名        : int acxSeqNoSet() - acx_seq_no_set
  /// * 機能概要      : シーケンスNo.更新
  /// * 引数          : なし
  /// * 戻り値        : シーケンスNo.
  /// *--------------------------------------------------------------------------------
  static Future<int> acxSeqNoSet() async {
    int seq_no = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd( IfChangerIsolate.taskId, LogLevelDefine.error, "acx_seq_no_set() rxMemPtr() RXMEM_STAT error" );
      debugPrint( "Task stat memory get error" );
    } else {
      RxTaskStatBuf tsBuf = xRet.object;

      tsBuf.acx.seqNo++;
      if(tsBuf.acx.seqNo > 9) {
        tsBuf.acx.seqNo = 0;
      }
      seq_no = tsBuf.acx.seqNo;
      await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MAIN_TASK);
    }
    return(seq_no);
  }
  ////*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxCinPriceData()
  /// * 機能概要      : 入金額計算
  /// * 引数          : int acb_select  釣銭釣札機の種類
  /// * 戻り値        : 入金額
  /// *--------------------------------------------------------------------------------
  static int ifAcxCinPriceData( int acb_select ){ //入金額計算
    int price = 0;
    CinData cindata = CinData();

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd( IfChangerIsolate.taskId, LogLevelDefine.error, "acx_seq_no_set() rxMemPtr() RXMEM_STAT error" );
      debugPrint( "Task stat memory get error" );
      return price;
    } else {
      RxTaskStatBuf tsBuf = xRet.object;
      switch(acb_select)
      {
        case CoinChanger.RT_300:
            cindata = tsBuf.acx.cinInfo.cindata;
            price    = (cindata.bill10000 * 10000)
                + (cindata.bill5000  * 5000)
                + (cindata.bill2000  * 2000)
                + (cindata.bill1000  * 1000)
                + (cindata.coin500   * 500)
                + (cindata.coin100   * 100)
                + (cindata.coin50    * 50)
                + (cindata.coin10    * 10)
                + (cindata.coin5     * 5)
                + (cindata.coin1     * 1);
            break;
        case CoinChanger.ECS_777:
            cindata = tsBuf.acx.cinInfoEcs.cindata;
            price     = (cindata.bill10000 * 10000)
                + (cindata.bill5000  * 5000)
                + (cindata.bill2000  * 2000)
                + (cindata.bill1000  * 1000)
                + (cindata.coin500   * 500)
                + (cindata.coin100   * 100)
                + (cindata.coin50    * 50)
                + (cindata.coin10    * 10)
                + (cindata.coin5     * 5)
                + (cindata.coin1     * 1);
            break;
        default:
            break;
      }
    }
    return    price;
  }

  String log = "";
  ///*--------------------------------------------------------------------------------
  /// * 関数名         : int ifAcxDecToAscii()
  /// * 機能概要       : 10進データからASCIIデータへの変換
  /// * 引数           : TprTID src
  /// *               : List<int> AsciiData  ASCIIデータ
  /// *               : int IntDec  10進データ
  /// * 戻り値         : なし
  /// *-------------------------------------------------------------------------------
  static void ifAcxDecToAscii(TprTID src, int intDec, List<String> asciiData) {
    int highByte = 0;
    int lowByte = 0;
    // a premis IntDec is 99 under data !
    asciiData[0] = ""; // high byte data
    asciiData[1] = ""; // low  byte data

    while (true) {
      if (intDec < 100) {
        break;
      }
      intDec = intDec - 100;
    }

    while (true) {
      if (intDec < 10) {
        highByte = highByte + 0x30;
        lowByte = intDec + 0x30;

        asciiData[0] = highByte.toString();
        asciiData[1] = lowByte.toString();
        return;
      }
      highByte = highByte + 1;
      intDec = intDec - 10;
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名         : int ifAcxResultChk()
  /// * 機能概要       : 結果確認
  /// * 引数           : TprTID src
  /// *               : String rcvData  受信データ
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static int ifAcxResultChk(TprTID src, String rcvData) {
    int errCode;

    switch (rcvData) {
      case TprDefAsc.ACK:
      case TprDefAsc.ETB:
        errCode = IfAcxDef.MSG_ACROK;
        break;
      case TprDefAsc.EM:
        errCode = DlgConfirmMsgKind.MSG_ACB_STOPSTATUS.dlgId;
        break;
      case TprDefAsc.DLE:
      case TprDefAsc.CAN:
      case TprDefAsc.NAK:
      case TprDefAsc.BEL:
      errCode = DlgConfirmMsgKind.MSG_ACRERROR.dlgId;
        break;
      case TprDefAsc.FS:  // BON:
        switch (ifAcbSelect()) {
          case CoinChanger.ACB_10:
          case CoinChanger.ACB_20:
            errCode = DlgConfirmMsgKind.MSG_BILLONTRAY.dlgId;
            break;
          case CoinChanger.ACB_50_:
          case CoinChanger.ACB_200:
          case CoinChanger.RT_300:
          case CoinChanger.SST1:
            errCode = DlgConfirmMsgKind.MSG_ACRRJFULL.dlgId;
            break;
          default:
            errCode = DlgConfirmMsgKind.MSG_ACRERROR.dlgId;
        }
        break;
      case TprDefAsc.SUB:
        errCode = DlgConfirmMsgKind.MSG_ACRACT.dlgId;
        break;
      case TprDefAsc.DC2:
        errCode = DlgConfirmMsgKind.MSG_TAKE_MONEY.dlgId;
        break;
      case TprDefAsc.SOH:
        errCode = DlgConfirmMsgKind.MSG_ACB_CINSTATUS.dlgId;
        break;
      case TprDefAsc.DC4:
        errCode = DlgConfirmMsgKind.MSG_CHARGING.dlgId;
        break;
      case TprDefAsc.DC3:
        errCode = DlgConfirmMsgKind.MSG_TEXT192.dlgId;
        break;
      case TprDefAsc.DC1:	/* ECS recalc response */
        errCode = DlgConfirmMsgKind.MSG_RESERVE.dlgId;
        break;
      default:
        errCode = DlgConfirmMsgKind.MSG_ACRERROR.dlgId;
        break;
    }

    return errCode;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名         : int ifAcxNearEndChk()
  /// * 機能概要       : ニアエンドチェック(2000円を含めていないので注意)
  /// * 引数           : なし
  /// * 戻り値        : 0。1 正常終了
  /// *               : -1　エラーコード
  /// *-------------------------------------------------------------------------------
  Future<int> ifAcxNearEndChk() async {
    RxTaskStatBuf tsBuf = RxTaskStatBuf();
    int start, i;

    RxMemRet sRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (sRet.result != RxMem.RXMEM_OK) {
      TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.error,
          "if_acx_nearend_chk() rxMemPtr() RXMEM_STAT error");
      return -1;
    }
    tsBuf = sRet.object;

    if (tsBuf.acx.stockReady != 1) {
      /* 在高取得が行われていなければreturn */
      return -1;
    }

    // COINBILL
    if (await CmCksys.cmAcxCnct() == 2) {
      start = CoinBillKindList.CB_KIND_05000.id;
    } else {
      start = CoinBillKindList.CB_KIND_00500.id;
    }

    for (i = start; i <= CoinBillKindList.CB_KIND_00001.id; i++) {
      if (i == CoinBillKindList.CB_KIND_02000.id) {
        //2000円対象外
        continue;
      }
      if ((tsBuf.acx.holderStatus.kindFlg[i].index ==
              HolderFlagList.HOLDER_NEAR_END.index) ||
          (tsBuf.acx.holderStatus.kindFlg[i].index ==
              HolderFlagList.HOLDER_EMPTY.index)) {
        return (1);
      }
    }
    return (0);
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名         : int ifAcxNearFullChk()
  /// * 機能概要       : ニアフルチェック(2000円を含めていないので注意)
  /// * 引数           : なし
  /// * 戻り値        : 0。1 正常終了
  /// *               : -1　エラーコード
  /// *-------------------------------------------------------------------------------
  Future<int> ifAcxNearFullChk() async {
    return (await ifAcxNearFullChkMain(0));
  }

  //ニアフルチェック(2000円を含めていないので注意)
  Future<int> ifAcxNearFullChkMain(int typ) async {
    RxTaskStatBuf tsBuf = RxTaskStatBuf();
    int start, i;

    RxMemRet sRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (sRet.result != RxMem.RXMEM_OK) {
      TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.error,
          "if_acx_nearfull_chk() rxMemPtr() RXMEM_STAT error");
      return -1;
    }
    tsBuf = sRet.object;

    if (tsBuf.acx.stockReady != 1) {
      // 在高取得が行われていなければreturn */
      return -1;
    }

    // COINBILL
    if (await CmCksys.cmAcxCnct() == 2) {
      if (typ != 0) {
        start = CoinBillKindList.CB_KIND_10000.id;
      } else {
        start = CoinBillKindList.CB_KIND_05000.id;
      }
    } else {
      start = CoinBillKindList.CB_KIND_00500.id;
    }

    for (i = start; i <= CoinBillKindList.CB_KIND_00001.id; i++) {
      if (i == CoinBillKindList.CB_KIND_02000.id) {
        //2000円対象外
        continue;
      }
      if ((tsBuf.acx.holderStatus.kindFlg[i].index ==
              HolderFlagList.HOLDER_NEAR_FULL_BFR_ALERT.index) ||
          (tsBuf.acx.holderStatus.kindFlg[i].index ==
              HolderFlagList.HOLDER_NEAR_FULL.index) ||
          (tsBuf.acx.holderStatus.kindFlg[i].index ==
              HolderFlagList.HOLDER_FULL.index)) {
        return (1);
      }
    }
    return (0);
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名         : int ifAcxCmdSkip()
  /// * 機能概要       :
  /// * 引数           : TprTID src
  /// *               : Function func
  /// * 戻り値        : 0。1 正常終了
  /// *               : -1　エラーコード
  /// *-------------------------------------------------------------------------------
  static Future<int> ifAcxCmdSkip(TprTID src, Function func) async {
    RxTaskStatBuf tsBuf = RxTaskStatBuf();

    RxMemRet sRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (sRet.result == RxMem.RXMEM_OK) {
      tsBuf = sRet.object;
      TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.error,
          "ifAcxCmdSkip : $func order[${tsBuf.acx.order}] SKIP");

      tsBuf.acx.order = AcxProcNo.ACX_ORDER_RESET.no;
      await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_STAT, tsBuf, RxMemAttn.MASTER);

      return (Typ.OK);
    } else {
      TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.error,
          "%s : %s order[${tsBuf.acx.order}] Memory Error");
      return (DlgConfirmMsgKind.MSG_MEMORYERR.dlgId);
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名         : int ifAcxShtPriceData()
  /// * 機能概要       : 枚数データから金額計算
  /// * 引数           : CBillKind billKind　紙幣/硬貨の種別
  /// *               : int type　計算対象（紙幣/硬貨/両方）
  /// * 戻り値        : 0。1 正常終了
  /// *               : -1　エラーコード
  /// *-------------------------------------------------------------------------------
  static int ifAcxShtPriceData(CBillKind billKind, int type) {
    int price = 0;

    //硬貨のみ
    if(type == AcxCalcType.ACX_CALC_COIN.index) {
      price = (billKind.coin500   * 500)
          + (billKind.coin100   * 100)
          + (billKind.coin50    * 50)
          + (billKind.coin10    * 10)
          + (billKind.coin5     * 5)
          + (billKind.coin1     * 1);
    }
    //紙幣のみ
    else if(type == AcxCalcType.ACX_CALC_BILL.index) {
      price = (billKind.bill10000 * 10000)
          + (billKind.bill5000  * 5000)
          + (billKind.bill2000  * 2000)
          + (billKind.bill1000  * 1000);
    }
    else {
      price = (billKind.bill10000 * 10000)
          + (billKind.bill5000  * 5000)
          + (billKind.bill2000  * 2000)
          + (billKind.bill1000  * 1000)
          + (billKind.coin500   * 500)
          + (billKind.coin100   * 100)
          + (billKind.coin50    * 50)
          + (billKind.coin10    * 10)
          + (billKind.coin5     * 5)
          + (billKind.coin1     * 1);
    }

    return	price;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名         : int ifAcxStockStateChk()
  /// * 機能概要       : 在高不確定か判定
  /// * 引数           : CBillKind billKind　紙幣/硬貨の種別
  /// * 戻り値        　: 0 在高確定
  /// *　　　　　　　　　: 1　在高不確定
  /// *-------------------------------------------------------------------------------
  static int ifAcxStockStateChk(StockState stockState) {
    if ((stockState.billFlg != 0) || (stockState.coinFlg != 0)) {
      return 1; //在高不確定
    } else {
      return 0; //在高確定
    }
  }
}
