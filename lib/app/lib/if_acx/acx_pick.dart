/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';
import 'package:get/get.dart';

import '../../if/if_changer_isolate.dart';
import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';
import 'erc_pick.dart';

/// 関連tprxソース:acx_pick.c
class AcxPick {
  // TODO:コンパイルSW
  //#ifndef PPSDVS
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb20Pickup()
  /// * 機能概要      : 回収（ acb用 ）
  /// * 引数          : TprTID src
  /// *                 short coinMode     硬貨回収モード
  /// *                 CBILLKIND cBillKind 回収金種枚数
  /// * 戻り値 result : 0(MSG_ACROK) 正常終了
  /// *        mode   :
  /// *-------------------------------------------------------------------------------
  static Future<int> ifAcb20Pickup(TprTID src, PickData pickData) async {
    int errCode;
    List<String> sendBuf = List.generate(40, (_) => "");
    int len = 0;
    List<String> buf = List.generate(10, (_) => "");
    int idx;

    errCode = IfAcxDef.MSG_ACROK;

    //残置回収は釣銭機側の機能を使用せず、POSで計算した枚数を指定し回収
    if (pickData.billMode == AcrPick.ACR_PICK_LEAVE.index) {
      pickData.billMode = AcrPick.ACR_PICK_DATA.index;
    }
    if (pickData.coinMode == AcrPick.ACR_PICK_LEAVE.index) {
      pickData.coinMode = AcrPick.ACR_PICK_DATA.index;
    }

    sendBuf[len++] = TprDefAsc.DC1;
    sendBuf[len++] = IfAcxDef.ACR_PICKUP;
    sendBuf[len++] = "\x32";
    sendBuf[len++] = "\x30";

    switch (acrPickGetIndex(pickData.billMode)) /* D0 */ {
      case AcrPick.ACR_PICK_NON:
        sendBuf[len++] = "\x30";
        break;
      case AcrPick.ACR_PICK_1000:
        sendBuf[len++] = "\x31";
        break;
      case AcrPick.ACR_PICK_5000:
        sendBuf[len++] = "\x32";
        break;
      case AcrPick.ACR_PICK_ALL:
        sendBuf[len++] = "\x33";
        break;
      case AcrPick.ACR_PICK_LEAVE:
        sendBuf[len++] = "\x34";
        break;
      case AcrPick.ACR_PICK_CASET:
        sendBuf[len++] = "\x35";
        break;
      case AcrPick.ACR_PICK_DATA:
        sendBuf[len++] = "\x36";
        break;
      case AcrPick.ACR_PICK_10000:
        sendBuf[len++] = "\x37";
        break;
      case AcrPick.ACR_PICK_2000:
        sendBuf[len++] = "\x38";
        break;
      default:
        return IfAcxDef.MSG_INPUTERR;
    }

    switch (acrPickGetIndex(pickData.coinMode)) /* D1 */ {
      case AcrPick.ACR_PICK_NON:
        sendBuf[len++] = "\x30";
        break;
      case AcrPick.ACR_PICK_500:
        sendBuf[len++] = "\x31";
        break;
      case AcrPick.ACR_PICK_100:
        sendBuf[len++] = "\x32";
        break;
      case AcrPick.ACR_PICK_50:
        sendBuf[len++] = "\x33";
        break;
      case AcrPick.ACR_PICK_10:
        sendBuf[len++] = "\x34";
        break;
      case AcrPick.ACR_PICK_5:
        sendBuf[len++] = "\x35";
        break;
      case AcrPick.ACR_PICK_1:
        sendBuf[len++] = "\x36";
        break;
      case AcrPick.ACR_PICK_ALL:
        sendBuf[len++] = "\x37";
        break;
      case AcrPick.ACR_PICK_LEAVE:
        sendBuf[len++] = "\x38";
        break;
      case AcrPick.ACR_PICK_DATA:
        sendBuf[len++] = "\x39";
        break;
      default:
        return IfAcxDef.MSG_INPUTERR;
    }
    /* D2 - D13 */
    if (pickData.billMode == AcrPick.ACR_PICK_DATA.index) {
      if ((pickData.cBillKind.bill10000 > 999) ||
          (pickData.cBillKind.bill5000 > 999) ||
          (pickData.cBillKind.bill2000 > 999) ||
          (pickData.cBillKind.bill1000 > 999)) {
        return IfAcxDef.MSG_INPUTERR;
      }

      buf.clear();
      buf.add((pickData.cBillKind.bill2000).toString().padLeft(3, "0"));
      sendBuf.setAll(len, buf);
      len += 3;
      buf.clear();
      buf.add((pickData.cBillKind.bill10000).toString().padLeft(3,"0"));
      sendBuf.setAll(len, buf);
      len += 3;
      buf.clear();
      buf.add((pickData.cBillKind.bill5000).toString().padLeft(3,"0"));
      sendBuf.setAll(len, buf);
      len += 3;
      buf.clear();
      buf.add((pickData.cBillKind.bill1000).toString().padLeft(3,"0"));
      sendBuf.setAll(len, buf);
      len += 3;
    }
    else {
      for (idx = 2; idx <= 13; idx++) {
        sendBuf[len++] = "\x30"; /* D2 - D13 */
      }
    }

    /* D14 - D31 */
    if (pickData.coinMode == AcrPick.ACR_PICK_DATA.index) {
      if ((pickData.cBillKind.coin500 > 999) ||
          (pickData.cBillKind.coin100 > 999) ||
          (pickData.cBillKind.coin50 > 999) ||
          (pickData.cBillKind.coin10 > 999) ||
          (pickData.cBillKind.coin5 > 999) ||
          (pickData.cBillKind.coin1 > 999)) {
        return IfAcxDef.MSG_INPUTERR;
      }

      buf.clear();
      buf.add((pickData.cBillKind.coin500).toString().padLeft(3, "0"));
      sendBuf.setAll(len, buf);
      len += 3;
      buf.clear();
      buf.add((pickData.cBillKind.coin100).toString().padLeft(3, "0"));
      sendBuf.setAll(len, buf);
      len += 3;
      buf.clear();
      buf.add((pickData.cBillKind.coin50).toString().padLeft(3, "0"));
      sendBuf.setAll(len, buf);
      len += 3;
      buf.clear();
      buf.add((pickData.cBillKind.coin10).toString().padLeft(3, "0"));
      sendBuf.setAll(len, buf);
      len += 3;
      buf.clear();
      buf.add((pickData.cBillKind.coin5).toString().padLeft(3, "0"));
      sendBuf.setAll(len, buf);
      len += 3;
      buf.clear();
      buf.add((pickData.cBillKind.coin1).toString().padLeft(3, "0"));
      sendBuf.setAll(len, buf);
      len += 3;
    }
    else {
      for (idx = 14; idx <= 31; idx++) {
        sendBuf[len++] = "\x30"; /* D14 - D31 */
      }
    }

    //     transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcrPickup()
  /// * 機能概要      : 回収（ acr用 ）
  /// * 引数          : TprTID src
  /// *                 short coinMode     硬貨回収モード
  /// *                 CBILLKIND cBillKind 回収金種枚数
  /// * 戻り値 result : 0(MSG_ACROK) 正常終了
  /// *        mode   :
  /// *-------------------------------------------------------------------------------
  static Future<int> ifAcrPickup(TprTID src, PickData pickData) async {
    int errCode;
    List<String> sendBuf = List.generate(40, (_) => "");
    int len = 0;
    List<String> buf = List.generate(10, (_) => "");
    int idx;

    errCode = IfAcxDef.MSG_ACROK;

    //残置回収は釣銭機側の機能を使用せず、POSで計算した枚数を指定し回収
    if (pickData.coinMode == AcrPick.ACR_PICK_LEAVE.index) {
      pickData.coinMode = AcrPick.ACR_PICK_DATA.index;
    }

    sendBuf[len++] = TprDefAsc.DC1;
    sendBuf[len++] = IfAcxDef.ACR_PICKUP;
    sendBuf[len++] = "\x32";
    sendBuf[len++] = "\x30";

    sendBuf[len++] = "\x30"; /* D0 */
    switch (acrPickGetIndex(pickData.coinMode)) /* D1 */ {
      case AcrPick.ACR_PICK_500:
        sendBuf[len++] = "\x31";
        break;
      case AcrPick.ACR_PICK_100:
        sendBuf[len++] = "\x32";
        break;
      case AcrPick.ACR_PICK_50:
        sendBuf[len++] = "\x33";
        break;
      case AcrPick.ACR_PICK_10:
        sendBuf[len++] = "\x34";
        break;
      case AcrPick.ACR_PICK_5:
        sendBuf[len++] = "\x35";
        break;
      case AcrPick.ACR_PICK_1:
        sendBuf[len++] = "\x36";
        break;
      case AcrPick.ACR_PICK_ALL:
        sendBuf[len++] = "\x37";
        break;
      case AcrPick.ACR_PICK_LEAVE:
        sendBuf[len++] = "\x38";
        break;
      case AcrPick.ACR_PICK_DATA:
        sendBuf[len++] = "\x39";
        break;
      default:
        return IfAcxDef.MSG_INPUTERR;
    }
    for (idx = 2; idx <= 13; idx++) {
      sendBuf[len++] = "\x30"; /* D2 - D13 */
    }
    if (pickData.coinMode == AcrPick.ACR_PICK_DATA.index) {
      if ((pickData.cBillKind.coin500 > 999) ||
          (pickData.cBillKind.coin100 > 999) ||
          (pickData.cBillKind.coin50 > 999) ||
          (pickData.cBillKind.coin10 > 999) ||
          (pickData.cBillKind.coin5 > 999) ||
          (pickData.cBillKind.coin1 > 999)) {
        return IfAcxDef.MSG_INPUTERR;
      }

      buf.clear();
      buf.add((pickData.cBillKind.coin500).toString().padLeft(3, "\x00"));
      sendBuf.addAll(buf);
      len += 3;
      buf.clear();
      buf.add((pickData.cBillKind.coin100).toString().padLeft(3, "\x00"));
      sendBuf.addAll(buf);
      len += 3;
      buf.clear();
      buf.add((pickData.cBillKind.coin50).toString().padLeft(3, "\x00"));
      sendBuf.addAll(buf);
      len += 3;
      buf.clear();
      buf.add((pickData.cBillKind.coin10).toString().padLeft(3, "\x00"));
      sendBuf.addAll(buf);
      len += 3;
      buf.clear();
      buf.add((pickData.cBillKind.coin5).toString().padLeft(3, "\x00"));
      sendBuf.addAll(buf);
      len += 3;
      buf.clear();
      buf.add((pickData.cBillKind.coin1).toString().padLeft(3, "\x00"));
      sendBuf.addAll(buf);
      len += 3;
    }
    else {
      for (idx = 14; idx <= 31; idx++) {
        sendBuf[len++] = "\x30"; /* D14 - D31 */
      }
    }

    //     transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }
  // #endif

  static PickEcs ecsPickupDataset(PickData pickData, PickEcs pickEcs) {
    pickEcs.cBillKind = pickData.cBillKind;
    pickEcs.bill = pickData.bill;
    pickEcs.coin = pickData.coin;
    pickEcs.leave = pickData.leave;

    //カセット釦は独立していて他の回収方法と併用可能
    if ((pickData.billMode == AcrPick.ACR_PICK_CASET.index) ||
        (pickData.billMode == AcrPick.ACR_PICK_ALL.index) ||
        (pickData.billMode == AcrPick.ACR_PICK_LEAVE.index)) {
      pickEcs.caset = 1;
    }

    //残置回収は釣銭機側の機能を使用せず、POSで計算した枚数を指定し回収
    if (pickData.billMode == AcrPick.ACR_PICK_LEAVE.index) {
      pickData.billMode = AcrPick.ACR_PICK_DATA.index;
    }
    if (pickData.coinMode == AcrPick.ACR_PICK_LEAVE.index) {
      pickData.coinMode = AcrPick.ACR_PICK_DATA.index;
    }

    //紙幣の回収方法セット
    if (pickData.billMode == AcrPick.ACR_PICK_ALL.index) {
      pickEcs.cBillKind.bill10000 =
          pickEcs.cBillKind.bill5000 =
          pickEcs.cBillKind.bill2000 =
          pickEcs.cBillKind.bill1000 = 10001;
    }
    else if (pickData.billMode == AcrPick.ACR_PICK_10000.index) {
      pickEcs.cBillKind.bill10000 = 10001;
    }

    //硬貨の回収方法セット
    if (pickData.coinMode == AcrPick.ACR_PICK_ALL.index) {
      pickEcs.cBillKind.coin500 =
          pickEcs.cBillKind.coin100 =
          pickEcs.cBillKind.coin50 =
          pickEcs.cBillKind.coin10 =
          pickEcs.cBillKind.coin5 =
          pickEcs.cBillKind.coin1 = 10001;
    }

    return pickEcs;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxPickup()
  /// * 機能概要      : 回収
  /// * 引数          : TprTID src
  /// *                 ushort changerFlg  ACR_COINBILL 釣銭釣札機 / ACR_COINONLY 釣銭機
  /// *                 short billMode     紙幣回収モード
  /// *                 short coinMode     硬貨回収モード
  /// *                 CBILLKIND cBillKind 回収金種枚数
  /// * 戻り値 result : 0(MSG_ACROK) 正常終了
  /// *        mode   :
  /// *-------------------------------------------------------------------------------
  static Future<int> ifAcxPickup(
      TprTID src, int changerFlg, PickData pickData) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      PickEcs pickEcs = PickEcs();

      // TprLog().logAdd(
      //     IfChangerIsolate.taskId, LogLevelDefine.normal,
      //     "***** PICK : bill[${ifAcxPickDataLabelGet(
      //         pickData.billMode)}] coin[${ifAcxPickDataLabelGet(
      //         pickData.coinMode)}]");

      if (changerFlg == CoinChanger.ACR_COINBILL) /* Coin/Bill Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ACB_10:
            break;
          case CoinChanger.ACB_20:
          case CoinChanger.ACB_50_:
          case CoinChanger.ACB_200:
          case CoinChanger.RT_300:
            errCode = await ifAcb20Pickup(src, pickData);
            break;
          case CoinChanger.SST1:
          case CoinChanger.FAL2:
            if (((pickData.billMode == AcrPick.ACR_PICK_CASET.index) ||
                    (pickData.billMode == AcrPick.ACR_PICK_DATA.index)) &&
                (pickData.coinMode == AcrPick.ACR_PICK_DATA.index) &&
                (acxPickDataZeroChk(pickData))) {
              pickData.billMode = AcrPick.ACR_PICK_NON.index;
              pickData.coinMode = AcrPick.ACR_PICK_NON.index;
            }
            errCode = await ifAcb20Pickup(src, pickData);
            break;
          case CoinChanger.ECS:
          case CoinChanger.ECS_777:
            pickEcs = ecsPickupDataset(pickData, pickEcs);
            errCode = await ErcPick.ifEcsPickup(src, pickEcs);
            break;
          default:
            errCode = IfAcxDef.MSG_ACRFLGERR;
            break;
        }
      } else if (changerFlg == CoinChanger.ACR_COINONLY) /* Coin Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ECS:
          case CoinChanger.ECS_777:
            pickEcs = ecsPickupDataset(pickData, pickEcs);
            errCode = await ErcPick.ifEcsPickup(src, pickEcs);
            break;
          default:
            errCode = await ifAcrPickup(src, pickData);
            break;
        }
      } else /* changerFlg NG ! */ {
        errCode = IfAcxDef.MSG_ACRFLGERR;
      }

      return errCode;
    } else {
      // #else
      return IfAcxDef.MSG_ACROK;
      // #endif
    }
  }

  static bool acxPickDataZeroChk(PickData pickData) {
    return ((pickData.cBillKind.bill10000 == 0) &&
        (pickData.cBillKind.bill5000 == 0) &&
        (pickData.cBillKind.bill2000 == 0) &&
        (pickData.cBillKind.bill1000 == 0) &&
        (pickData.cBillKind.coin500 == 0) &&
        (pickData.cBillKind.coin100 == 0) &&
        (pickData.cBillKind.coin50 == 0) &&
        (pickData.cBillKind.coin10 == 0) &&
        (pickData.cBillKind.coin5 == 0) &&
        (pickData.cBillKind.coin1 == 0));
  }

  static AcrPick acrPickGetIndex(int handle) {
    switch (handle) {
      case 0:
        return AcrPick.ACR_PICK_NON;
      case 1:
        return AcrPick.ACR_PICK_10000;
      case 2:
        return AcrPick.ACR_PICK_5000;
      case 3:
        return AcrPick.ACR_PICK_2000;
      case 4:
        return AcrPick.ACR_PICK_1000;
      case 5:
        return AcrPick.ACR_PICK_500;
      case 6:
        return AcrPick.ACR_PICK_100;
      case 7:
        return AcrPick.ACR_PICK_50;
      case 8:
        return AcrPick.ACR_PICK_10;
      case 9:
        return AcrPick.ACR_PICK_5;
      case 10:
        return AcrPick.ACR_PICK_1;
      case 11:
        return AcrPick.ACR_PICK_ALL;
      case 12:
        return AcrPick.ACR_PICK_LEAVE;
      case 13:
        return AcrPick.ACR_PICK_DATA;
      case 14:
        return AcrPick.ACR_PICK_CASET;
      default:
        return AcrPick.ACR_PICK_NON;
    }
  }
}
