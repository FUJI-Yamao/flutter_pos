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

/// 関連tprxソース:ecs_cread.c
class EcsCread{
  ////*--------------------------------------------------------------------------------
  /// * 関数名    : int ifEcsCinRead()
  /// * 機能概要  : 入金枚数リードコマンド送信ライブラリ(富士電機製釣銭釣札機)
  /// * 引数      : TprTID src
  /// * 戻り値    : 0(MSG_ACROK) 正常終了
  /// *           : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifEcsCinRead( TprTID src ) async {
    int  err_code = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(40, (_) => ""); /* device data */
    int len = 0;

    /*  Send Buffer set(Cin End Command)     */
    sendBuf[len++] = TprDefAsc.DC1;
    sendBuf[len++] = IfAcxDef.ECS_CINREAD;
    sendBuf[len++] = '\x30';
    sendBuf[len++] = '\x30';

    /*  transmit a message                           */
    err_code = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return err_code;
  }
}
