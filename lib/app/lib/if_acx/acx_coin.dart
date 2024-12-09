/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/drv/ffi/library.dart';
import 'package:path_provider/path_provider.dart';

import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_mid.dart';
import '../../drv/changer/drv_changer_isolate.dart';
import '../../if/if_drv_control.dart';
import 'acx_com.dart';

/// 関連tprxソース:acx_coin.c
class AcxCoin{
  ////*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb20ChangeOut()
  /// * 機能概要      : Coin/Bill Changer Change Out
  /// * 引数          : TprTID src
  /// *               : int mChange
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcb20ChangeOut(TprTID src, int mChange) async {
    int  err_code = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(10, (_) => ""); /* device data */
    int   len = 0;

    if (isDummyAcx()) {
      return IfAcxDef.MSG_ACROK;
    }
    Mac_infoJsonFile macInfo = Mac_infoJsonFile();
    await macInfo.load();

    if (((AcxCom.ifAcbSelect() & CoinChanger.ACB_50_X) != 0) && (macInfo.acx_flg.acb50_ssw24_0 == 1)) {
      /* \999,999 up Change ? */
      if(mChange > 999999){
        return DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
      }
      /*  Send Buffer set(Change out Command)          */
      sendBuf[0] = TprDefAsc.DC1;
      sendBuf[1] = IfAcxDef.ACR_COINOUT;
      sendBuf[2] = '\x30';
      sendBuf[3] = '\x36';
      sendBuf[4] = (mChange ~/ 100000).toString();
      sendBuf[5] = ((mChange % 100000) ~/ 10000).toString();
      sendBuf[6] = (((mChange % 100000) % 10000) ~/ 1000).toString();
      sendBuf[7] = ((((mChange % 100000) % 10000) % 1000) ~/ 100).toString();
      sendBuf[8] = (((((mChange % 100000) % 10000) % 1000) % 100) ~/ 10).toString();
      sendBuf[9] = ((((((mChange % 100000) % 10000) % 1000) % 100) % 10)).toString();
      len = 10;
      /*  transmit a message                           */
      err_code = await AcxCom.ifAcxTransmit(src, sendBuf, len);
    }
    else if(((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) != 0) && (macInfo.acx_flg.acb50_ssw24_0 == 1)){
      /* \999,999 up Change ? */
      if(mChange > 999999){
          return DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
      }
      /* Send Buffer set(Change out Command) */
      sendBuf[0] = TprDefAsc.DC1;
      sendBuf[1] = IfAcxDef.ECS_COINOUT6DIGIT;
      sendBuf[2] = '\x30';
      sendBuf[3] = '\x36';
      sendBuf[4] = (mChange ~/ 100000).toString();
      sendBuf[5] = ((mChange % 100000) ~/ 10000).toString();
      sendBuf[6] = (((mChange % 100000) % 10000) ~/ 1000).toString();
      sendBuf[7] = ((((mChange % 100000) % 10000) % 1000) ~/ 100).toString();
      sendBuf[8] = (((((mChange % 100000) % 10000) % 1000) % 100) ~/ 10).toString();
      sendBuf[9] = ((((((mChange % 100000) % 10000) % 1000) % 100) % 10)).toString();
      len = 10;

      /*  transmit a message                           */
      err_code = await AcxCom.ifAcxTransmit(src, sendBuf, len);
    }
    else{
      /*  \9,999 up Change ?                           */
      if(mChange > 99999){
         return DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
      }
      
      /*  Send Buffer set(Change out Command)          */
      sendBuf[0] = TprDefAsc.DC1;
      sendBuf[1] = IfAcxDef.ACR_COINOUT;
      sendBuf[2] = '\x30';
      sendBuf[3] = '\x35';
      sendBuf[4] = (mChange ~/ 10000).toString();
      sendBuf[5] = ((mChange % 10000) ~/ 1000).toString();
      sendBuf[6] = (((mChange % 10000) % 1000) ~/ 100).toString();
      sendBuf[7] = ((((mChange % 10000) % 1000) % 100) ~/ 10).toString();
      sendBuf[8] = ((((mChange % 10000) % 1000) % 100) % 10).toString();
      len = 9;

      /*  transmit a message                           */
      err_code = await AcxCom.ifAcxTransmit(src, sendBuf, len);
    }

    return err_code;
  }

  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb10ChangeOut()
  /// * 機能概要      : Coin/Bill Changer Change Out
  /// * 引数          : TprTID src
  /// *               : int mChange
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  /// *-------------------------------------------------------------------------------
  static Future<int> ifAcb10ChangeOut(TprTID src, int mChange) async {
    int errCode;
    List<String> sendBuf = List.generate(9, (_) => "");
    int len;

    //  \9,999 up Change ?
    if (mChange > 9999) {
      return DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
    }
    if (isDummyAcx()) {
      return IfAcxDef.MSG_ACROK;
    }
    
    //  Send Buffer set(Change out Command)
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = "\x31";
    sendBuf[2] = "\x30";
    sendBuf[3] = "\x35";
    sendBuf[4] = "\x30";
    sendBuf[5] = (0x30 + (mChange / 1000)).toString();
    sendBuf[6] = (0x30 + ((mChange % 1000) / 100)).toString();
    sendBuf[7] = (0x30 + (((mChange % 1000) % 100) / 10)).toString();
    sendBuf[8] = (0x30 + (((mChange % 1000) % 100) % 10)).toString();
    len = 9;

    //  transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  ////*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcrChangeOut()
  /// * 機能概要      : Coin/Bill Changer Change Out
  /// * 引数          : TprTID src
  /// *               : int mChange
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcrChangeOut(TprTID src, int mChange) async {
    int  err_code = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(7, (_) => ""); /* device data */
    int   len = 0;
   
    /*  \999 up Change ?                             */
    if(mChange > 999){
        return DlgConfirmMsgKind.MSG_INPUTOVER.dlgId;
    }
    if (isDummyAcx()) {
      return IfAcxDef.MSG_ACROK;
    }
    
    /*  Send Buffer set(Change out Command)          */
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_COINOUT;
    sendBuf[2] = '\x30';
    sendBuf[3] = '\x33';
    sendBuf[4] = (mChange ~/ 100).toString();
    sendBuf[5] = ((mChange % 100) ~/ 10).toString();
    sendBuf[6] = ((mChange % 100) % 10).toString();
    len = 7;

    /*  transmit a message                           */
    err_code = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return err_code;
  }

  ////*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxChangeOut()
  /// * 機能概要      : Coin/Bill Changer & Coin Changer Change Out
  /// * 引数          : TprTID src
  /// *               : int changerFlg  ACR_COINBILL(Coin/Bill Changer) or ACR_COINONLY(Coin Changer)
  /// *               : int mChange
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxChangeOut(TprTID src, int changerFlg, int mChange) async {
    int  err_code = IfAcxDef.MSG_ACROK;

    TprLog().logAdd(0, LogLevelDefine.normal, "***** OUT : price[$mChange]");
    
    if(changerFlg == CoinChanger.ACR_COINBILL)      /* Coin/Bill Changer ? */
    {
        switch(AcxCom.ifAcbSelect())
        {
            case CoinChanger.RT_300:
            case CoinChanger.ECS_777:
                err_code = await ifAcb20ChangeOut( src, mChange );
                break;
            default:
                err_code = IfAcxDef.MSG_ACRFLGERR;
                break;
        }
    }
    else if(changerFlg == CoinChanger.ACR_COINONLY) /* Coin Changer ? */
    {
        //釣銭機接続時、指定金額の硬貨だけを出金。それ以外はドロアからとして正常終了。
        mChange = mChange % 1000;

        switch(AcxCom.ifAcbSelect())
        {
            case CoinChanger.ECS_777:
                err_code = await ifAcb20ChangeOut( src, mChange );
                break;
            case CoinChanger.RT_300:
                err_code = await ifAcrChangeOut( src, mChange );
                break;
            default:
                err_code = IfAcxDef.MSG_ACRFLGERR;
                break;
        }
    } else {                                 /* Changer_flg NG ! */
        err_code = IfAcxDef.MSG_ACRFLGERR;
    }

    return err_code;
  }
}
