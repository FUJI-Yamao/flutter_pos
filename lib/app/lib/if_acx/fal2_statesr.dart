/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:convert';

import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../if/if_changer_isolate.dart';
import 'package:flutter_pos/app/inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';
import 'fal2_resg.dart';

/// 関連tprxソース:fal2_statesr.c
class Fal2Statesr {
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StatSense()
  /// * 機能概要      : 動作環境設定／取得コマンド送信ライブラリ  (NEC製釣銭釣札機(FAL2)
  /// * 引数          : TprTID src
  /// *		              short	flag	設定フラグ	0:動作環境の設定値を取得
  /// *						        1:動作環境を設定
  /// *						        2:動作環境初期化
  /// *		              short	num	設定No.		flag = 2 の場合は 0 を入力
  /// *		              uchar	*status	設定値		2バイト flag = 0,2 の場合は NULL を入力
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static Future<int> ifFal2StateSetRead(TprTID src, int flag, int num,
      List<String> status) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(40, (_) => "");
      int len = 0;

      if ((AcxCom.ifAcbSelect() & CoinChanger.FAL2) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      sendBuf[len++] = "\x80";
      sendBuf[len++] = IfAcxDef.FAL2_STATESETREAD;
      sendBuf[len++] = "\x00";
      sendBuf[len++] = "\x05";

      switch (flag) {
        case 0:
          sendBuf[len++] = "\x00";
          break;
        case 1:
          sendBuf[len++] = "\x01";
          break;
        case 2:
          sendBuf[len++] = "\x02";
          break;
      }

      if (flag == 0) {
        sendBuf[len++] = "\x00";
        sendBuf[len++] = latin1.decode([(num >> 0) & 0xff]);
        sendBuf[len++] = "\x00";
        sendBuf[len++] = "\x00";
      }
      else if (flag == 1) {
        sendBuf[len++] = "\x00";
        sendBuf[len++] = latin1.decode([(num >> 0) & 0xff]);
        sendBuf[len++] = status[0];
        sendBuf[len++] = status[1];
      }
      else {
        sendBuf[len++] = "\x00";
        sendBuf[len++] = "\x00";
        sendBuf[len++] = "\x00";
        sendBuf[len++] = "\x00";
      }

      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StateSetReadGet()
  /// * 機能概要      : 動作環境設定／取得コマンド返答取得ライブラリ
  /// * 引数          : TprTID src
  /// *             		FAL2_ENVIRONMENT *envData
  /// *                 tprmsgdevreq2_t	*Rcvbuf
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  // static int ifFal2StateSetReadGet(TprTID src, Fal2Environment envData, tprmsgdevreq2_t *Rcvbuf) {
  // // #ifndef PPSDVS
  // short errCode = IfAcxDef.MSG_ACROK;
  // uchar data[15];
  // ushort num;
  //
  // if( (AcxCom.ifAcbSelect() & CoinChanger.FAL2) == 0){
  // return( IfAcxDef.MSG_ACRFLGERR );
  // }
  //
  // errCode = if_acx_RcvHeadChk( src, Rcvbuf );
  // if(errCode != IfAcxDef.MSG_ACROK ){
  // return( errCode ); /* NG return ! */
  // }
  //
  // errCode = if_fal2_ResFormatChk( src, Rcvbuf );
  // if(errCode != IfAcxDef.MSG_ACROK ){
  // return( errCode ); /* NG return ! */
  // }
  //
  // memset( data, '\0', sizeof(data) );
  // memcpy( data, Rcvbuf->data, Rcvbuf->datalen );
  //
  // num = (ushort)(data[9] * 256) + (ushort)data[10] - 1;
  // memcpy( &envData->envir[num][0], &data[11], 2 );
  //
  // return ( errCode );
  // // #else
  // return ( IfAcxDef.MSG_ACROK );
  // // #endif
  // }
}
