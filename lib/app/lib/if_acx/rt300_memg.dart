/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import 'package:flutter_pos/app/inc/lib/acx_log_lib.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:rt300_memg.c
class Rt300Memg {
  AplLibLogData acxLog = AplLibLogData();
  Rt300LogData rt300 = Rt300LogData();

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifRt300MemoryGet()
  /// * 機能概要      : ログリードコマンド送信ライブラリ(RT300)
  /// * 引数          : TprTID src
  /// *                 uchar *ptData
  /// *                 TprMsgDevReq2_t *rcvBuf
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  int ifRt300MemoryGet(
      TprTID src, List<String> ptData, TprMsgDevReq2_t rcvBuf) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      int bcdPint;
      int bcdData;
      List<String> buf = List.generate(256, (_) => "");

      buf.fillRange(0, buf.length, "0x00");
      rt300.logLengthData.fillRange(0, rt300.logLengthData.length, 0);
      acxLog.writeSize = 0;

      if ((AcxCom.ifAcbSelect() & CoinChanger.RT_300) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);
      if (errCode == IfAcxDef.MSG_ACROK) {
        errCode = AcxCom.ifAcxRcvDLEChk(src, rcvBuf.data);
      }
      if (errCode != IfAcxDef.MSG_ACROK) {
        return (errCode);
      }

      // 指定ログヘッダー結果の場合
      if (rt300.indexNum == 0) {
        acxLog.writeSize = 25; // データサイズは固定長
        rt300.indexMaxData.fillRange(0, rt300.indexMaxData.length, 0);
        rt300.allSizeData.fillRange(0, rt300.allSizeData.length, 0);
      } else {
        acxLog.writeSize = AcxLogLib.MAX_LOGSIZE;
      }

      for (bcdPint = 0; bcdPint < acxLog.writeSize; bcdPint++) {
        int temp = int.parse(rcvBuf.data[2 + (bcdPint * 2)]);
        int temp2 = int.parse(rcvBuf.data[2 + ((bcdPint * 2) + 1)]);
        int temp3 = int.parse(ptData[bcdPint]);

        ptData[bcdPint] = (temp << 4).toString();
        bcdData = temp2 & 0x0f;
        ptData[bcdPint] = (temp3 | bcdData).toString();

        if (bcdPint < 2) {
          // レスポンスのデータサイズ取得
          rt300.logLengthData[bcdPint] = int.parse(rcvBuf.data[bcdPint]);
        }

        if (rt300.indexNum == 0) {
          // 最終インデックス取得
          if ((bcdPint == 3) || (bcdPint == 4)) {
            rt300.indexMaxData[bcdPint - 3] = int.parse(ptData[bcdPint]);
          }
          // ログヘッダー部のログデータサイズ(ログ番号内全データサイズ合算値)取得
          else if ((bcdPint > 20) && (bcdPint < acxLog.writeSize)) {
            rt300.allSizeData[bcdPint - 21] = int.parse(ptData[bcdPint]);
          }
        }
      }

      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }
}
