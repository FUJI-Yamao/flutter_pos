/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:ecs_memg.c
class EcsMemg {
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsMemoryGet()
  /// * 機能概要      : ログリードレスポンス受信データ解析ライブラリ（富士電機製釣銭釣札機）
  /// * 引数          : TprTID src
  /// *                 LOGDATA_ECS *logDataEcs  ログデータ格納エリア
  /// *                 TprMsgDevReq2_t *rcvBuf  受信データアドレス
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static int ifEcsMemoryGet(TprTID src, LogDataEcs logDataEcs,
      TprMsgDevReq2_t rcvBuf) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      int bcdPint;
      List<String> bcdLog = List.generate(254, (_) => "0");
      int bcdData;

      bcdLog.fillRange(0, bcdLog.length, "0");

      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) == 0) {
        return IfAcxDef.MSG_ACRFLGERR;
      }

      errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);
      if (errCode == IfAcxDef.MSG_ACROK) {
        errCode = AcxCom.ifAcxRcvDLEChk(src, rcvBuf.data);
      }
      if (errCode != IfAcxDef.MSG_ACROK) {
        return errCode; /* NG return */
      }

      for (bcdPint = 0; bcdPint < 127; bcdPint++) {
        bcdLog[bcdPint] = (rcvBuf.data[2 + (bcdPint * 2)].codeUnitAt(0) << 4).toString();
        bcdData = rcvBuf.data[2 + ((bcdPint * 2) + 1)].codeUnitAt(0) & 0x0f;
        bcdLog[bcdPint] = (bcdLog[bcdPint].codeUnitAt(0) | bcdData).toString();
      }

      logDataEcs.logData = bcdLog;

      return errCode;
    } else {
      // #else
      return IfAcxDef.MSG_ACROK;
      // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ltoAddr()
  /// * 機能概要      : アドレス　long型からuchar型へ変換
  /// * 引数          : uchar	*address
  /// *                 long		lData
  /// *                 LOGDATA_ECS *logDataEcs  ログデータ格納エリア
  /// *                 TprMsgDevReq2_t *rcvBuf  受信データアドレス
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  int ltoAddr(List<int> address, int lData) {
    int type;
    int num = 0;
    int cnt = 0;
    int i;
    List<int> addressTmp = List.generate(7, (_) => 0);

    type = AcxCom.ifAcbSelect();

    switch (type) {
      case CoinChanger.ECS:
      case CoinChanger.ECS_777:
        num = 6;
        break;
      case CoinChanger.SST1:
        num = 4;
        break;
      default:
        num = 3;
        break;
    }

    cnt = num * 4;
    for (i = 0; i <= num; i++) {
      addressTmp[i] = (lData >> cnt) & 0x0f;
      cnt = cnt - 4;
    }

    address = addressTmp;

    return 0;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int addrtoL()
  /// * 機能概要      : アドレス　uchar型からlong型へ変換
  /// * 引数          : uchar	*address
  /// *                 TprMsgDevReq2_t *rcvBuf  受信データアドレス
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  int addrtoL(List<int> address) {
    int lData = 0;
    int type;
    int num = 0;
    int cnt = 0;
    int i;

    type = AcxCom.ifAcbSelect();

    switch (type) {
      case CoinChanger.ECS:
      case CoinChanger.ECS_777:
        num = 6;
        break;
      case CoinChanger.SST1:
        num = 4;
        break;
      default:
        num = 3;
        break;
    }

    cnt = num * 4;
    for (i = 0; i <= num; i++) {
      lData += (address[i] & 0x0f) << cnt;
      cnt = cnt - 4;
    }

    return lData;
  }
}
