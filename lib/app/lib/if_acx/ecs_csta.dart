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

/// 関連tprxソース:ecs_csta.c
class EcsCsta{
  ///*--------------------------------------------------------------------------------
  /// * 関数名    : int ifEcsCinStart()
  /// * 機能概要  : 入金許可コマンド送信ライブラリ(富士電機製釣銭釣札機)
  /// * 引数      : TprTID src
  /// *           : CinStartEcs CinStartEcs 入金許可情報
  /// * 戻り値    : 0(MSG_ACROK) 正常終了
  /// *           : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifEcsCinStart( TprTID src, CinStartEcs cinStartEcs ) async {
    int  err_code = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(40, (_) => ""); /* device data */
    int len = 0;

    if(cinStartEcs.suspention == 0) {    //一時保留なしの開始
      TprLog().logAdd( IfChangerIsolate.taskId, LogLevelDefine.normal, "***** IN Start (Non Suspend)" );
    }

    sendBuf[len++] = TprDefAsc.DC1;
    sendBuf[len++] = IfAcxDef.ECS_CINSTART;
    sendBuf[len++] = '\x30';
    sendBuf[len++] = '\x34';

    /* Mode1 */
    int mode1 = 0x00;
    mode1 |= (cinStartEcs.total_sht == 0)? 0x00 : 0x01;
    mode1 |= (cinStartEcs.auto_continue == 0)? 0x00 : 0x02;
    mode1 |= (cinStartEcs.suspention == 0)? 0x00 : 0x04;
    sendBuf[len++] = mode1.toString();

    /* Mode2 */
    int mode2 = 0x00;
    mode2 |= (cinStartEcs.reject.bill1000 == 0)? 0x00 : 0x01;
    mode2 |= (cinStartEcs.reject.bill5000 == 0)? 0x00 : 0x02;
    mode2 |= (cinStartEcs.reject.bill10000 == 0)? 0x00 : 0x04;
    mode2 |= (cinStartEcs.reject.bill2000 == 0)? 0x00 : 0x08;
    sendBuf[len++] = mode2.toString();

    /* Mode3 */
    int mode3 = 0x00;
    mode3 |= (cinStartEcs.reject.coin100 == 0)? 0x00 : 0x01;
    mode3 |= (cinStartEcs.reject.coin500 == 0)? 0x00 : 0x02;
    sendBuf[len++] = mode3.toString();

    /* Mode4 */
    int mode4 = 0x00;
    mode4 |= (cinStartEcs.reject.coin1 == 0)? 0x00 : 0x01;
    mode4 |= (cinStartEcs.reject.coin5 == 0)? 0x00 : 0x02;
    mode4 |= (cinStartEcs.reject.coin10 == 0)? 0x00 : 0x04;
    mode4 |= (cinStartEcs.reject.coin50 == 0)? 0x00 : 0x08;
    sendBuf[len++] = mode4.toString();

    /*  transmit a message                           */
    err_code = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return err_code;
  }
}
