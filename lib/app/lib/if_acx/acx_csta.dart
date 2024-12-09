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
import '../apllib/cnct.dart';
import '../cm_sys/cm_cksys.dart';
import 'acx_com.dart';
import 'ecs_csta.dart';

class EcsStartSetResult {
    int ret = 0;
    CinStartEcs cinStartEcs = CinStartEcs();
}

/// 関連tprxソース:acx_csta.c
class AcxCsta{
  ///*--------------------------------------------------------------------------------
  /// * 関数名    : int ifAcb20CinStart()
  /// * 機能概要  :
  /// * 引数      : TprTID src
  /// * 戻り値    : 0(MSG_ACROK) 正常終了
  /// *           : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcb20CinStart( TprTID src ) async {
    int  err_code = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(4, (_) => ""); /* device data */
    int len = 0;
   
    /*  Send Buffer set(Cin End Command)     */
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_CINSTART;
    sendBuf[2] = '\x30';
    sendBuf[3] = '\x30';
    len = 4;
    
    /*  transmit a message                           */
    err_code = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return err_code;
  }
  ///*--------------------------------------------------------------------------------
  /// * 関数名    : int ifAcrCinStart()
  /// * 機能概要  :
  /// * 引数      : TprTID src
  /// * 戻り値    : 0(MSG_ACROK) 正常終了
  /// *           : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcrCinStart( TprTID src ) async {
    int  err_code = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(4, (_) => ""); /* device data */
    int len = 0;
   
    /*  Send Buffer set(Cin End Command)     */
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_CINSTART;
    sendBuf[2] = '\x30';
    sendBuf[3] = '\x30';
    len = 4;
    
    /*  transmit a message                           */
    err_code = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return err_code;
  }

  ///*--------------------------------------------------------------------------------
  /// * 関数名    : int ifAcxCinStart()
  /// * 機能概要  : 計測開始
  /// * 引数      : TprTID src
  /// *           : int changerFlg  ACR_COINBILL(Coin/Bill Changer) or ACR_COINONLY(Coin Changer)
  /// * 戻り値    : 0(MSG_ACROK) 正常終了
  /// *           : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxCinStart( TprTID src, int changerFlg ) async {
    int  err_code = IfAcxDef.MSG_ACROK;
    int  cin_price = 0;
    EcsStartSetResult ecsStartSetResult = EcsStartSetResult();

    TprLog().logAdd( IfChangerIsolate.taskId, LogLevelDefine.normal, "***** IN Start" );

    int acb_select = AcxCom.ifAcbSelect();
    if(changerFlg == CoinChanger.ACR_COINBILL) {      /* Coin/Bill Changer ? */
        switch(acb_select) {
            case CoinChanger.RT_300:
                err_code = await ifAcb20CinStart( src );
                break;
            case CoinChanger.ECS_777:
                ecsStartSetResult = await ecsStartSet(src);
                err_code = ecsStartSetResult.ret;
                if(err_code != IfAcxDef.MSG_ACROK) {
                  return err_code;
                }
                err_code = await EcsCsta.ifEcsCinStart( src, ecsStartSetResult.cinStartEcs );
                break;
            default:
                err_code = IfAcxDef.MSG_ACRFLGERR;
                break;
        }
    } else if(changerFlg == CoinChanger.ACR_COINONLY) { /* Coin Changer ? */
        switch(acb_select) {
            case CoinChanger.ECS_777:
                ecsStartSetResult = await ecsStartSet(src);
                err_code = ecsStartSetResult.ret;
                if(err_code != IfAcxDef.MSG_ACROK) {
                  return err_code;
                }
                err_code = await EcsCsta.ifEcsCinStart( src, ecsStartSetResult.cinStartEcs );
                break;
            case CoinChanger.RT_300:
                err_code = await ifAcrCinStart(src );
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

  ///*--------------------------------------------------------------------------------
  /// * 関数名      : ecsStartSet()
  /// * 機能概要    :
  /// * 引数        : TprTID src
  /// * 戻り値  ret : 0(MSG_ACROK) 正常終了
  /// *         cinStartEcs  : 
  /// *--------------------------------------------------------------------------------
  static Future<EcsStartSetResult> ecsStartSet(TprTID src) async {
    EcsStartSetResult result = EcsStartSetResult();
    int mode = 0;

    RxCommonBuf pCom = RxCommonBuf();
    RxMemRet cRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (cRet.result != RxMem.RXMEM_OK) {
      TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.error,
          "if_acx_CinStart() rxMemPtr() error");
      result.ret = IfAcxDef.MSG_ACRERROR;
      return (result);
    }
    pCom = cRet.object;

    if (await CmCksys.cmQCashierSystem() != 0) {
      mode = pCom.iniMacInfo.select_self.qc_mode;
    } else {
      mode = pCom.iniMacInfo.select_self.self_mode;
    }
    result.cinStartEcs.total_sht = 1;
    result.cinStartEcs.auto_continue =
    ((mode == 0) && (Cnct.cnctMemGet(src, CnctLists.CNCT_ACB_DECCIN) == 1 ||
        Cnct.cnctMemGet(src, CnctLists.CNCT_ACB_DECCIN) == 3)) ? 1 : 0;
    result.cinStartEcs.suspention = 1;
    result.cinStartEcs.reject.bill10000 =
    result.cinStartEcs.reject.bill5000 =
    result.cinStartEcs.reject.bill2000 =
    result.cinStartEcs.reject.bill1000 =
    result.cinStartEcs.reject.coin500 =
    result.cinStartEcs.reject.coin100 =
    result.cinStartEcs.reject.coin50 =
    result.cinStartEcs.reject.coin10 =
    result.cinStartEcs.reject.coin5 =
    result.cinStartEcs.reject.coin1 = 0;

    result.ret = IfAcxDef.MSG_ACROK;
    return (result);
  }
}
