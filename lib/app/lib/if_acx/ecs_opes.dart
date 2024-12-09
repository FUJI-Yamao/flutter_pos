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

/// 関連tprxソース:ecs_opes.c
class EcsOpes{
  ////*--------------------------------------------------------------------------------
  /// * 関数名    : int if_ecs_OpeSet()
  /// * 機能概要  : 動作条件設定コマンド送信ライブラリ(富士電機製釣銭釣札機)
  /// * 引数      : TprTID src
  /// *           : String         mode    モード 30H - 3FH
  /// *           : List<String>   data    設定内容 データ１ - データ５
  /// * 戻り値    : 0(MSG_ACROK) 正常終了
  /// *           : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifEcsOpeSet( TprTID src, String mode, List<String> data ) async {
      int  err_code = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(40, (_) => ""); /* device data */
      int len = 0;

      if( (AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0x00 )
      {
          return( IfAcxDef.MSG_ACRFLGERR );
      }
      for( int i=0; i<40; i++) {
        sendBuf[i] = '\x00';
      }
      sendBuf[len++] = TprDefAsc.DC1;
      sendBuf[len++] = IfAcxDef.ECS_OPESET;
      sendBuf[len++] = '\x30';
      sendBuf[len++] = '\x36';

      /* Mode */
     if( mode.codeUnitAt(0) < 0x30 || mode.codeUnitAt(0) > 0x3f )
     {
        return( IfAcxDef.MSG_ACRFLGERR );
     }
      sendBuf[len++] = mode;

      /* Data */
      for( int i=0; i<5; i++){
        sendBuf[len++] = data[i];
      }

      err_code = await AcxCom.ifAcxTransmit(src, sendBuf, len);

      return( err_code );
  }

  ////*-------------------------------------------------------------------------------- 
  /// * 関数名    : int ifEcsOpeSetExpansion()
  /// * 機能概要  : 動作条件設定コマンド(拡張仕様)送信ライブラリ(富士電機製釣銭釣札機 ECS-777)
  /// * 引数      : TprTID src
  /// *           : List<String> mode  モード 30H 30H - 33H 3FH
  /// *           : List<String> data  設定内容 データ1 - データ12
  /// * 戻り値    : 0(MSG_ACROK) 正常終了
  /// *           : エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------*/
  static Future<int> ifEcsOpeSetExpansion( TprTID src, List<String> mode, List<String> data ) async {
    int  err_code = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(40, (_) => ""); /* device data */
    int len = 0;
    int i = 0;

    if( (AcxCom.ifAcbSelect() & CoinChanger.ECS_777) == 0x00 )
    {
      return( IfAcxDef.MSG_ACRFLGERR );
    }
    for( i=0; i<40; i++) {
      sendBuf[i] = '\x00';
    }
    sendBuf[len++] = TprDefAsc.DC1;
    sendBuf[len++] = IfAcxDef.ECS_OPESET;  /* 51H */
    sendBuf[len++] = '\x30';
    sendBuf[len++] = '\x3E';    /* 拡張仕様 */

    /* Mode */
    if(( mode[0].codeUnitAt(0) < 0x30 || mode[0].codeUnitAt(0) > 0x33 )
       || ( mode[1].codeUnitAt(0) < 0x30 || mode[1].codeUnitAt(0) > 0x3f ))
    {
      return( IfAcxDef.MSG_ACRFLGERR );
    }
    sendBuf[len++] = mode[0];
    sendBuf[len++] = mode[1];

    /* Data */
    for( i=0; i<12; i++) {
      sendBuf[len++] = data[i];
    }

    err_code = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return( err_code );
  }

}
