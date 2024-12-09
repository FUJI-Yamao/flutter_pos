/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:convert';

import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:ecs_download.c
class EcsDownload {
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsDownload()
  /// * 機能概要      : ダウンロード開始コマンド送信ライブラリ  (富士電機製釣銭釣札機(ECS77)
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifEcsDownload(TprTID src, int type,
      List<String> data) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(512, (_) => "\x00");
      int len = 0;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      sendBuf.fillRange(0, sendBuf.length, "\x30");
      sendBuf[len++] = TprDefAsc.DC1; // DC1 = 11H
      sendBuf[len++] = IfAcxDef.ECS_DOWNLOAD; // ECS_DOWNLOAD = 4DH

      sendBuf[len++] = "\x01"; //レングス01
      sendBuf[len++] = "\x01"; //レングス01

      // モード 31:硬貨＋コントローラ部、32:紙幣部、33:棒金ドロア、34:設定ファイル
      if (type == 1) {
        sendBuf[len++] = "\x31";
      } else {
        sendBuf[len++] = "\x32";
      }
      sendBuf.addAll(data);
      len += 256;

      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);
      // 応答は、「ACK」、「BEL」、「NAK」の３つのみ

      return (errCode);
    } else {
    // #else
      return (IfAcxDef.MSG_ACROK);
    // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsDownloadGet()
  /// * 機能概要      : 1バイトレスポンス解析処理
  /// * 引数          : TprTID src
  /// *                 TprMsgDevReq2_t *rcvBuf
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static int ifEcsDownloadGet(TprTID src, TprMsgDevReq2_t rcvBuf) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }
      errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);
      if (errCode == IfAcxDef.MSG_ACROK) {
        errCode = AcxCom.ifAcxRcvDLEChk(src, rcvBuf.data);
      }
      if (errCode != IfAcxDef.MSG_ACROK) {
        return errCode; /* NG return */
      }

      if (rcvBuf.data[0] != TprDefAsc.ACK) {
        return (IfAcxDef.MSG_ACRSENDERR);
      }

      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsProgramDownload()
  /// * 機能概要      : プログラムロードコマンド送信ライブラリ  (富士電機製釣銭釣札機(ECS77)
  /// * 引数          : TprTID src
  /// *                 int no
  /// *                 uchar *data
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifEcsProgramDownload(TprTID src, int no,
      List<String> data) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(512, (_) => "\x00");
      int len = 0;
      int noA = 0;
      int noB = 0;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      sendBuf.fillRange(0, sendBuf.length, "\x00");
      sendBuf[len++] = TprDefAsc.DC1; /* DC1 = 11H */
      sendBuf[len++] = IfAcxDef.ECS_PROGRAMLOAD; // ECS_PROGRAMLOAD = 4EH

      sendBuf[len++] = "\x01"; /* レングス01 */
      sendBuf[len++] = "\x02"; /*レングス02 */

      noA = (no / 256) as int;
      noB = no % 256;
      sendBuf[len++] = latin1.decode([noA]);
      sendBuf[len++] = latin1.decode([noB]);

      sendBuf.addAll(data);
      len += 256;

      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);
      /* 応答は、「ACK」、「BEL」、「NAK」、「CAN」の４つのみ */

      return (errCode);
    } else {
    // #else
      return (IfAcxDef.MSG_ACROK);
    // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsEndDownload()
  /// * 機能概要      : ダウンロード終了コマンド送信ライブラリ  (富士電機製釣銭釣札機(ECS77)
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifEcsEndDownload(TprTID src) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(28, (_) => "\x00");
      int len = 0;

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      sendBuf.fillRange(0, sendBuf.length, "\x00");
      sendBuf[len++] = TprDefAsc.DC1; /* DC1 = 11H */
      sendBuf[len++] = IfAcxDef.ECS_ENDDOWNLOAD; // ECS_ENDDOWNLOAD = 4FH

      sendBuf[len++] = "\x30";
      sendBuf[len++] = "\x30";

      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);
      /* 応答は、「ACK」、「BEL」、「NAK」、「CAN」の４つのみ */

      return (errCode);
    } else {
    // #else
      return (IfAcxDef.MSG_ACROK);
    // #endif
    }
  }
}
