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

/// 関連tprxソース:acx_answ.c
class AcxAnsw{
  ////*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxAnswerRead()
  /// * 機能概要      : Coin/Bill Changer & Coin Changer Status Reading
  /// * 引数          : TprTID src
  /// *               : int changerFlg  ACR_COINBILL(Coin/Bill Changer) or ACR_COINONLY(Coin Changer)
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  /// *--------------------------------------------------------------------------------
  ///  関連tprxソース: acx_answ.c - if_acx_AnswerRead
  static Future<int> ifAcxAnswerRead(TprTID src, int changerFlg) async {
    int  err_code = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(1, (_) => ""); /* device data */
    int   len = 0;
    /* Coin/Bill Changer ?                        */
    if (isDummyAcx()) {
      RxTaskStatBuf tsBuf = SystemFunc.readRxTaskStat();
      tsBuf.acx.order = AcxProcNo.ACX_RESULT_GET.no;
      return IfAcxDef.MSG_ACROK;
    }
    if(changerFlg == CoinChanger.ACR_COINBILL){
        /* Buffer set(Status Get Command)             */
        len = 0;
        sendBuf[len++] = TprDefAsc.ENQ;

        /* transmit a message                         */
        err_code = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    } else {
        /* Coin Changer ?                        */
        if(changerFlg == CoinChanger.ACR_COINONLY){
            /* COMMON(acr,csc) */
            /*  Buffer set(Status Get Command)         */
            len = 0;
            sendBuf[len++] = TprDefAsc.ENQ;
            /* transmit a message                      */
            err_code = await AcxCom.ifAcxTransmit(src, sendBuf, len);
        }
        else{    
            /* changerFlg NG !                        */
            err_code = IfAcxDef.MSG_ACRFLGERR;
        }
    }
    return( err_code );

  }

}
