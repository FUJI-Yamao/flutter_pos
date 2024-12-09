/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../if/if_changer_isolate.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';

/// 関連tprxソース:acx_closeg.c
class AcxCloseg {
  // #ifndef PPSDVS
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifRt300CloseDataGet()
  /// * 機能概要      : Close Data Get
  /// * 引数          : TprTID src
  /// *                 TprMsgDevReq2_t rcvBuf
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifRt300CloseDataGet(TprTID src, CloseData closeData,
      List<String> rcvData, int offset) {
    String log = "";
    List<int> buf = List.generate(11, (_) => 0);
    List<int> readBuf = List.generate(88 + offset, (_) => 0);
    int i;
    int bit;

    readBuf.fillRange(0, readBuf.length, 0);
    // read buf init
    for (i = 0; i < (88 + offset); i++) {
      readBuf[i] = int.parse(rcvData[i + 2]) & 0x3f;
    }

    //データインデックス
    closeData.index = 0;
    if (offset == 2) {
      buf.fillRange(0, buf.length, 0);
      buf = readBuf.sublist(0, 2);
      bit = 4;
      for (i = 0; i < buf.length; i++) {
        closeData.index |= buf[i] << bit;
        bit -= 4;
      }
    }

    //開始時間
    closeData.startDate = readBuf.sublist(0 + offset, 0 + offset + 8).join("");

    //現在時間
    closeData.nowDate = readBuf.sublist(8 + offset, 8 + offset + 8).join("");

    String temp = "";

    //開始時在高金額
    buf.fillRange(0, buf.length, 0);
    buf[0] = readBuf[16 + offset];
    if (buf[0] != 0) { //10桁目が存在。後の処理で9桁に切り取るので記録だけ残す
      log = "ifRt300CloseDataGet: start_price length over data[${buf[0]}]";
      TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal, log);
    }
    buf.fillRange(0, buf.length, 0);
    buf = readBuf.sublist(16+offset, 16+offset+10);
    temp = (int.parse((buf.join())) % 1000000000).toString();
    for (i = 0; i < temp.length; i++) {
      closeData.startPrice[i+1] = int.parse(temp[i]);
    }
    //最大9桁で処理する(釣銭機に億単位の在高は収納不可なので10桁目を切っても影響ないと考え)

    //累積入金系金額
    buf.fillRange(0, buf.length, 0);
    buf[0] = readBuf[26 + offset];
    if (buf[0] != 0) { //10桁目が存在。後の処理で9桁に切り取るので記録だけ残す
      log = "ifRt300CloseDataGet: inPrice length over data[${buf[0]}]";
      TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal, log);
    }
    buf.fillRange(0, buf.length, 0);
    buf = readBuf.sublist(26 + offset, 26 + offset + 10);
    temp = (int.parse((buf.join())) % 1000000000).toString();
    for (i = 0; i < temp.length; i++) {
      closeData.inPrice[i+1] = int.parse(temp[i]);
    }
    //最大9桁で処理する(釣銭機に億単位の在高は収納不可なので10桁目を切っても影響ないと考え)

    //累積出金系金額
    buf.fillRange(0, buf.length, 0);
    buf[0] = readBuf[36 + offset];
    if (buf[0] != 0) { //10桁目が存在。後の処理で9桁に切り取るので記録だけ残す
      log = "ifRt300CloseDataGet: outPrice length over data[${buf[0]}]";
      TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal, log);
    }
    buf.fillRange(0, buf.length, 0);
    buf = readBuf.sublist(36+offset, 36+offset+10);
    temp = (int.parse((buf.join())) % 1000000000).toString();
    for (i = 0; i < temp.length; i++) {
      closeData.outPrice[i+1] = int.parse(temp[i]);
    }
    //最大9桁で処理する(釣銭機に億単位の在高は収納不可なので10桁目を切っても影響ないと考え)

    //現在在高金額
    buf.fillRange(0, buf.length, 0);
    buf[0] = readBuf[46 + offset];
    if (buf[0] != 0) { //10桁目が存在。後の処理で9桁に切り取るので記録だけ残す
      log = "ifRt300CloseDataGet: nowPrice length over data[${buf[0]}]";
      TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal, log);
    }
    buf.fillRange(0, buf.length, 0);
    buf = readBuf.sublist(46+offset, 46+offset+10);
    temp = (int.parse((buf.join())) % 1000000000).toString();
    for (i = 0; i < temp.length; i++) {
      closeData.nowPrice[i+1] = int.parse(temp[i]);
    }
    //最大9桁で処理する(釣銭機に億単位の在高は収納不可なので10桁目を切っても影響ないと考え)

    //在高差分金額
    buf.fillRange(0, buf.length, 0);
    buf[0] = readBuf[56 + offset];
    if (buf[0] != 0) { //10桁目が存在。後の処理で9桁に切り取るので記録だけ残す
      log = "ifRt300CloseDataGet: diffPrice length over data[${buf[0]}]";
      TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal, log);
    }
    buf.fillRange(0, buf.length, 0);
    buf = readBuf.sublist(56+offset, 56+offset+10);
    temp = (int.parse((buf.join())) % 1000000000).toString();
    for (i = 0; i < temp.length; i++) {
      closeData.diffPrice[i+1] = int.parse(temp[i]);
    }
    //最大9桁で処理する(釣銭機に億単位の在高は収納不可なので10桁目を切っても影響ないと考え)

    //紙幣在高異常
    closeData.billStock.holderOpen =
    ((readBuf[66 + offset] & 0x08) == 0x00) ? 0 : 1;
    closeData.billStock.caset = ((readBuf[66 + offset] & 0x01) == 0x00) ? 0 : 1;
    closeData.billStock.bill10000 =
    ((readBuf[67 + offset] & 0x08) == 0x00) ? 0 : 1;
    closeData.billStock.bill5000 =
    ((readBuf[67 + offset] & 0x04) == 0x00) ? 0 : 1;
    closeData.billStock.bill2000 =
    ((readBuf[67 + offset] & 0x02) == 0x00) ? 0 : 1;
    closeData.billStock.bill1000 =
    ((readBuf[67 + offset] & 0x01) == 0x00) ? 0 : 1;

    //硬貨在高異常
    closeData.coinStock.holderOpen =
    ((readBuf[68 + offset] & 0x08) == 0x00) ? 0 : 1;
    closeData.coinStock.coin500 =
    ((readBuf[68 + offset] & 0x02) == 0x00) ? 0 : 1;
    closeData.coinStock.coin100 =
    ((readBuf[68 + offset] & 0x01) == 0x00) ? 0 : 1;
    closeData.coinStock.coin50 =
    ((readBuf[69 + offset] & 0x08) == 0x00) ? 0 : 1;
    closeData.coinStock.coin10 =
    ((readBuf[69 + offset] & 0x04) == 0x00) ? 0 : 1;
    closeData.coinStock.coin5 = ((readBuf[69 + offset] & 0x02) == 0x00) ? 0 : 1;
    closeData.coinStock.coin1 = ((readBuf[69 + offset] & 0x01) == 0x00) ? 0 : 1;

    //紙幣区間ステータス
    closeData.billSegSt.rjBfrErr =
    ((readBuf[71 + offset] & 0x08) == 0x00) ? 0 : 1;
    closeData.billSegSt.rjNowErr =
    ((readBuf[71 + offset] & 0x04) == 0x00) ? 0 : 1;
    closeData.billSegSt.stockErr =
    ((readBuf[71 + offset] & 0x02) == 0x00) ? 0 : 1;
    closeData.billSegSt.holderErr =
    ((readBuf[71 + offset] & 0x01) == 0x00) ? 0 : 1;

    //硬貨区間ステータス
    closeData.coinSegSt.drawerErr =
    ((readBuf[73 + offset] & 0x04) == 0x00) ? 0 : 1;
    closeData.coinSegSt.stockErr =
    ((readBuf[73 + offset] & 0x02) == 0x00) ? 0 : 1;
    closeData.coinSegSt.holderErr =
    ((readBuf[73 + offset] & 0x01) == 0x00) ? 0 : 1;

    //ID
    buf.fillRange(0, buf.length, 0);
    buf = readBuf.sublist(76+offset, 76+offset+8);
    closeData.closeId = (int.parse((buf.join())) % 1000000000);

    return;
  }
  // #endif

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxCloseDataGet()
  /// * 機能概要      : Close Data Get
  /// * 引数          : TprTID src
  /// *                 TprMsgDevReq2_t rcvBuf
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static int ifAcxCloseDataGet(TprTID src, int changerFlg, CloseData closeData,
      TprMsgDevReq2_t rcvBuf) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;
      int offset;

      errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);
      if (errCode == IfAcxDef.MSG_ACROK) /*  OK !  next    */ {
        errCode = AcxCom.ifAcxRcvDLEChk(src, rcvBuf.data);
      }
      if (errCode != IfAcxDef.MSG_ACROK) {
        return errCode; /* NG return   !  */
      }

      if ((rcvBuf.datalen - 2 - 1) == 90) {
        offset = 2;
      } else {
        //0x58
        offset = 0;
      }

      if (changerFlg == CoinChanger.ACR_COINBILL) /* Coin/Bill Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ACB_10:
          case CoinChanger.ACB_20:
          case CoinChanger.ACB_50_:
          case CoinChanger.ACB_200:
          case CoinChanger.ECS:
          case CoinChanger.SST1:
          case CoinChanger.FAL2:
          case CoinChanger.ECS_777:
            return (IfAcxDef.MSG_ACROK);
          case CoinChanger.RT_300:
            ifRt300CloseDataGet(src, closeData, rcvBuf.data, offset);
            break;
          default:
            errCode = IfAcxDef.MSG_ACRFLGERR;
            break;
        }
      }
      else if (changerFlg == CoinChanger.ACR_COINONLY) /* Coin Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.RT_300:
            ifRt300CloseDataGet(src, closeData, rcvBuf.data, offset);
            break;
          default:
            return (IfAcxDef.MSG_ACROK);
        }
      }
      else
        /* changerFlg NG ! */ {
        errCode = IfAcxDef.MSG_ACRFLGERR;
      }

      return errCode;
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }
}
