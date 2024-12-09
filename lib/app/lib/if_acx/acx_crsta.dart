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
import '../../if/if_changer_isolate.dart';
import 'acx_com.dart';

/// 関連tprxソース:acx_crsta.c
class AcxCrsta{
  ////*--------------------------------------------------------------------------------
  /// * 関数名    : int ifAcb20CinReStart()
  /// * 機能概要  : 
  /// * 引数      : TprTID src
  /// * 戻り値    : 0(MSG_ACROK) 正常終了
  /// *           : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcb20CinReStart( TprTID src ) async {
    int  err_code = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(4, (_) => ""); /* device data */
    int len = 0;

    /*  Send Buffer set(Cin End Command)     */
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_CINRESTART;
    sendBuf[2] = '\x30';
    sendBuf[3] = '\x30';
    len = 4;

    /*  transmit a message                           */
    err_code = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return err_code;
  }
  ////*--------------------------------------------------------------------------------
  /// * 関数名    : int ifAcrCinReStart()
  /// * 機能概要  : 
  /// * 引数      : TprTID src
  /// * 戻り値    : 0(MSG_ACROK) 正常終了
  /// *           : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcrCinReStart( TprTID src ) async {
    int  err_code = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(4, (_) => ""); /* device data */
    int len = 0;
 
    /*  Send Buffer set(Cin End Command)     */
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_CINRESTART;
    sendBuf[2] = '\x30';
    sendBuf[3] = '\x30';
    len = 4;

    /*  transmit a message                           */
    err_code = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return err_code;
  }

  ////*--------------------------------------------------------------------------------
  /// * 関数名    : int ifAcxCinReStart()
  /// * 機能概要  : 計測開始
  /// * 引数      : TprTID src
  /// *           : int changerFlg  ACR_COINBILL(Coin/Bill Changer) or ACR_COINONLY(Coin Changer)
  /// * 戻り値    : 0(MSG_ACROK) 正常終了
  /// *           : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxCinReStart( TprTID src, int changerFlg ) async {
    int  err_code = IfAcxDef.MSG_ACROK;
    int  cin_price = 0;

    int acb_select = AcxCom.ifAcbSelect();
    if(changerFlg == CoinChanger.ACR_COINBILL)      /* Coin/Bill Changer ? */
    {
        switch(acb_select)
        {
            case CoinChanger.RT_300:
                err_code = await ifAcb20CinReStart( src );
                break;
            case CoinChanger.ECS_777:
                //処理なし err_code = if_acx_cmd_skip( src, __FUNCTION__ );
                break;
            default:
                err_code = IfAcxDef.MSG_ACRFLGERR;
                break;
        }
    }
    else if(changerFlg == CoinChanger.ACR_COINONLY) /* Coin Changer ? */
    {
        switch(acb_select)
        {
            case CoinChanger.RT_300:
                err_code = await ifAcrCinReStart( src );
                break;
            case CoinChanger.ECS_777:
                //処理なし err_code = if_acx_cmd_skip( src, __FUNCTION__ );
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
