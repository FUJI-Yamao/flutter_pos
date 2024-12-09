/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../drv/ffi/library.dart';
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

/// 関連tprxソース:acx_stcr.c
class AcxStcr{
  ////*--------------------------------------------------------------------------------
  /// * 関数名    : int ifAcb20StockRead()
  /// * 機能概要  : Coin Changer Stock Data Reading
  /// * 引数      : TprTID src
  /// * 戻り値    : 0(MSG_ACROK) 正常終了
  /// *           : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcb20StockRead( TprTID src ) async {

    int  err_code = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(4, (_) => ""); /* device data */
    int len = 0;
   
    /*  Send Buffer set(Stock Data Read Command)     */
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_INSPECT;
    sendBuf[2] = '\x30';
    sendBuf[3] = '\x30';
    len = 4;
    
    /*  transmit a message                           */
    err_code = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return err_code;
  }

  ////*--------------------------------------------------------------------------------
  /// * 関数名    : int ifAcrStockRead()
  /// * 機能概要  : Coin Changer Stock Data Reading
  /// * 引数      : TprTID src
  /// * 戻り値    : 0(MSG_ACROK) 正常終了
  /// *           : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcrStockRead( TprTID src ) async {

    int  err_code = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(4, (_) => ""); /* device data */
    int len = 0;
   
    /*  Send Buffer set(Stock Data Read Command)     */
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_INSPECT;
    sendBuf[2] = '\x30';
    sendBuf[3] = '\x30';
    len = 4;
    
    /*  transmit a message                           */
    err_code = await AcxCom.ifAcxTransmit(src, sendBuf, len);
       
    return err_code;
  }

  ////*--------------------------------------------------------------------------------
  /// * 関数名    : int ifAcxStockRead()
  /// * 機能概要  : Coin Changer Stock Data Reading
  /// * 引数      : TprTID src
  /// *           : int changerFlg  ACR_COINBILL(Coin/Bill Changer) or ACR_COINONLY(Coin Changer)
  /// * 戻り値    : 0(MSG_ACROK) 正常終了
  /// *           : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxStockRead( TprTID src, int changerFlg ) async {
    int  err_code = IfAcxDef.MSG_ACROK;

    if (isDummyAcx()) {
      return IfAcxDef.MSG_ACROK;
    }
    if(changerFlg == CoinChanger.ACR_COINBILL)      /* Coin/Bill Changer ? */
    {
        switch(AcxCom.ifAcbSelect())
        {
            case CoinChanger.RT_300:
            case CoinChanger.ECS_777:
                err_code = await ifAcb20StockRead( src );
                break;
            default:
                err_code = IfAcxDef.MSG_ACRFLGERR;
                break;
        }
    }
    else if(changerFlg == CoinChanger.ACR_COINONLY) /* Coin Changer ? */
    {
        switch(AcxCom.ifAcbSelect())
        {
            case CoinChanger.ECS_777:
                err_code = await ifAcb20StockRead( src );
                break;
            case CoinChanger.RT_300:
                err_code = await ifAcrStockRead( src );
                break;
            default:
                err_code = IfAcxDef.MSG_ACRFLGERR;
                break;
        }
    }
    else                                 /* Changer_flg NG ! */
    {
       err_code = IfAcxDef.MSG_ACRFLGERR;
    }
    return err_code;
  }
}
