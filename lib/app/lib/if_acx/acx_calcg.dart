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
import 'acx_com.dart';

class changerCalcgRet {
  int result = 0;      // 関数実行結果
  int mode = AcrCalcMode.ACR_CALC_MANUAL.no;        // 
}

/// 関連tprxソース:acx_calcg.c
class AcxCalcg{
  ////*--------------------------------------------------------------------------------
  /// * 関数名        :changerCalcgRet ifAcb20CalcModeGet()
  /// * 機能概要      : 
  /// * 引数          : TprTID src
  /// *               : List<String> rcvdata  レスポンスデータ
  /// * 戻り値 result : 0(MSG_ACROK) 正常終了
  /// *        mode   : 
  ///  --------------------------------------------------------------------------------
  static changerCalcgRet ifAcb20CalcModeGet( TprTID src, List<String> rcvdata ) {
    changerCalcgRet ret = changerCalcgRet();
    ret.result = IfAcxDef.MSG_ACROK;
    switch(rcvdata[5])
    {
        case 0x30:  ret.mode = AcrCalcMode.ACR_CALC_MANUAL.no;            break;
        case 0x31:  ret.mode = AcrCalcMode.ACR_CALC_AUTO.no;              break;
        case 0x32:  ret.mode = AcrCalcMode.ACR_CALC_CTRL.no;              break;
        default:    ret.result = IfAcxDef.MSG_ACRERROR;
                    break;
    }

    return ret;
  }

  ////*--------------------------------------------------------------------------------
  /// * 関数名        :changerCalcgRet ifAcrCalcModeGet()
  /// * 機能概要      : 
  /// * 引数          : TprTID src
  /// *               : List<String> rcvdata  レスポンスデータ
  /// * 戻り値 result : 0(MSG_ACROK) 正常終了
  /// *        mode   : 
  ///  --------------------------------------------------------------------------------
  static changerCalcgRet ifAcrCalcModeGet( TprTID src, List<String> rcvdata )
  {
    changerCalcgRet ret = changerCalcgRet();
    ret.result = IfAcxDef.MSG_ACROK;
    switch(rcvdata[5])
    {
        case 0x30:  ret.mode = AcrCalcMode.ACR_CALC_MANUAL.no;            break;
        case 0x31:  ret.mode = AcrCalcMode.ACR_CALC_AUTO.no;              break;
        case 0x32:  ret.mode = AcrCalcMode.ACR_CALC_CTRL.no;              break;
        default:    ret.result = IfAcxDef.MSG_ACRERROR;
                    break;
    }

    return ret;
  }

  ////*--------------------------------------------------------------------------------
  /// * 関数名        : changerCalcgRet ifAcxCalcModeGet()
  /// * 機能概要      : 
  /// * 引数          : TprTID src 
  /// *               : int changerFlg  ACR_COINBILL(Coin/Bill Changer) or ACR_COINONLY(Coin Changer)
  /// *               : TprMsgDevReq2_t rcvBuf  受信データ
  /// * 戻り値 result : 0(MSG_ACROK) 正常終了
  /// *        mode   : 
  /// *--------------------------------------------------------------------------------
  static changerCalcgRet ifAcxCalcModeGet(TprTID src, int changerFlg, TprMsgDevReq2_t rcvbuf)
  {
      changerCalcgRet ret = changerCalcgRet();
      ret.mode = AcrCalcMode.ACR_CALC_MANUAL.no;

      ret.result = AcxCom.ifAcxRcvHeadChk(src, rcvbuf);
      if(ret.result == IfAcxDef.MSG_ACROK )         /*  OK !  next    */
      {
          ret.result = AcxCom.ifAcxRcvDLEChk(src, rcvbuf.data);
      }
      if(ret.result != IfAcxDef.MSG_ACROK )
      {
          return ret;  /* NG return   !  */
      }
                                  /*  OK !  next    */
      if(changerFlg == CoinChanger.ACR_COINBILL)      /* Coin/Bill Changer ? */
      {
          switch(AcxCom.ifAcbSelect())
          {
            case CoinChanger.ECS_777:
            case CoinChanger.RT_300:
                ret = ifAcb20CalcModeGet(src, rcvbuf.data);
                break;
            default:
                ret.result = IfAcxDef.MSG_ACRFLGERR;
                break;
          }
      }
      else if(changerFlg == CoinChanger.ACR_COINONLY) /* Coin Changer ? */
      {
          switch(AcxCom.ifAcbSelect())
          {
            case CoinChanger.ECS_777:
                ret = ifAcb20CalcModeGet(src, rcvbuf.data);
                break;
            case CoinChanger.RT_300:
                ret = ifAcrCalcModeGet(src, rcvbuf.data);
                break;
            default:
                ret.result = IfAcxDef.MSG_ACRFLGERR;
                break;
          }
      }
      else                                 /* changerFlg NG ! */
      {
         ret.result = IfAcxDef.MSG_ACRFLGERR;
      }
      return ret;
  }
}
