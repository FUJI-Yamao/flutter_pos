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

/// 関連tprxソース:ecs_cend.c
class EcsCend{
  ////*--------------------------------------------------------------------------------
  /// * 関数名    : int ifEcsCinEnd()
  /// * 機能概要  : 入金終了コマンド送信ライブラリ(富士電機製釣銭釣札機)
  /// * 引数      : TprTID src
  /// *           : int total_sht   トータル枚数
  /// *           :                      0:クリアしない／1:クリアする
  /// *           : int motion      入金動作
  /// *           :                      0:入金終了のみ／1:入金終了時キャンセル／2:入金終了時収納
  /// * 戻り値    : 0(MSG_ACROK) 正常終了
  /// *           : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifEcsCinEnd( TprTID src, int total_sht, int motion ) async {

    int  err_code = IfAcxDef.MSG_ACROK;
    int  acb_select;
    List<String> sendBuf = List.generate(40, (_) => ""); /* device data */
    int len = 0;
    int   cin_price = 0;

    acb_select = AcxCom.ifAcbSelect();
    sendBuf[len++] = TprDefAsc.DC1;
    sendBuf[len++] = IfAcxDef.ECS_CINEND;
    sendBuf[len++] = '\x30';
    sendBuf[len++] = '\x32';

    /* Mode1 */
    sendBuf[len++] = (total_sht == 0)? '\x3E' : '\x3F';
    /* Mode2 */
    switch( motion )
    {
      case 0: sendBuf[len++] = '\x3C';  break;
      case 1: sendBuf[len++] = '\x3D';  break;
      case 2: sendBuf[len++] = '\x3E';  break;
    }
    err_code = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    cin_price = AcxCom.ifAcxCinPriceData(acb_select);
    if(cin_price > 0) {
      if(motion == 1) {
        TprLog().logAdd( IfChangerIsolate.taskId, LogLevelDefine.normal, "***** IN End : cancel[$cin_price]" );
      } else {
        TprLog().logAdd( IfChangerIsolate.taskId, LogLevelDefine.normal, "***** IN End : price[$cin_price]" );
      }
    } else {
      TprLog().logAdd( IfChangerIsolate.taskId, LogLevelDefine.normal, "***** IN End" );
    }

    return( err_code );
  }
}
