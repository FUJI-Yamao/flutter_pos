/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../common/date_util.dart';
import '../../common/cls_conf/qcashierJsonFile.dart';
import '../../common/cls_conf/configJsonFile.dart';
import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../if/if_changer_isolate.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/if_acx.dart';
import '../cm_sys/cm_cksys.dart';
import 'acx_com.dart';

/// 関連tprxソース:acx_stcg.c
class AcxStcg {
  static int chgDrwSystem = 0;
  static RxTaskStatBuf tsBuf = RxTaskStatBuf();

  ////*--------------------------------------------------------------------------------
  /// * 関数名         : int ifAcxRepack()
  /// * 機能概要       : Receiving Data Repacking
  /// * 引数           : TprTID src
  /// *                : List<String> rcvData  変換データ
  /// * 戻り値         : 変換後データ
  ///  --------------------------------------------------------------------------------
  static int ifAcxRepack(TprTID src, List<String> rcvData) {
    String ret = rcvData[0] + rcvData[1] + rcvData[2];
    return (int.parse(ret));
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifEcsStockGet()
  /// * 機能概要      : Coin/Bill Changer Stock Data Get
  /// * 引数          : TprTID src
  /// *                 CoinData coinData
  /// *                 List<String> rcvData
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifEcsStockGet(TprTID src, CoinData coinData, List<String> rcvData) {
    int i = 0;
    List<int> billB = List.generate(98, (_) => 0);
    List<String> billBStr = List.generate(98, (_) => "");

    // billB buf init
    for (i = 0; i < (billB.length - 2); i++) {
      try {
        billB[i] = rcvData[i + 2].codeUnitAt(0);
      } catch(e) {
        billB[i] = 0x30;
      }
    }
    for (i = 0; i < billB.length; i++) {
      if ((0x39 >= billB[i]) && (billB[i] >= 0x30)) {
        billBStr[i] = latin1.decode([billB[i]]);
      } else {
        billBStr[i] = "\x30";
      }
    }

    coinData.holder.bill10000 = ifAcxRepack(src, billBStr.sublist(3));
    coinData.holder.bill5000  = ifAcxRepack(src, billBStr.sublist(6));
    coinData.holder.bill2000  = ifAcxRepack(src, billBStr.sublist(0));
    coinData.holder.bill1000  = ifAcxRepack(src, billBStr.sublist(9));
    coinData.holder.coin500   = ifAcxRepack(src, billBStr.sublist(24));
    coinData.holder.coin100   = ifAcxRepack(src, billBStr.sublist(27));
    coinData.holder.coin50    = ifAcxRepack(src, billBStr.sublist(30));
    coinData.holder.coin10    = ifAcxRepack(src, billBStr.sublist(33));
    coinData.holder.coin5     = ifAcxRepack(src, billBStr.sublist(36));
    coinData.holder.coin1     = ifAcxRepack(src, billBStr.sublist(39));

    coinData.billrjct = 0;
    coinData.coinrjct = 0;

    coinData.overflow.bill10000 = ifAcxRepack(src, billBStr.sublist(15));
    coinData.overflow.bill5000  = ifAcxRepack(src, billBStr.sublist(18));
    coinData.overflow.bill2000  = ifAcxRepack(src, billBStr.sublist(12));
    coinData.overflow.bill1000  = ifAcxRepack(src, billBStr.sublist(21));
    coinData.overflow.coin500   = 0;
    coinData.overflow.coin100   = 0;
    coinData.overflow.coin50    = 0;
    coinData.overflow.coin10    = 0;
    coinData.overflow.coin5     = 0;
    coinData.overflow.coin1     = 0;

    coinData.billfull.rjctfull = 0;
    coinData.billfull.csetfull = 0;
    coinData.billfull.actFlg = 0;
    coinData.coinslot = 0;

    coinData.stockState.billFlg = ((billB[70] & 0x01) != 0) ? 1 : 0;
    coinData.stockState.billOverflow = ((billB[70] & 0x02) != 0) ? 1 : 0;
    coinData.stockState.coinFlg = ((billB[72] & 0x01) != 0) ? 1 : 0;

    if (chgDrwSystem == 1) {
      coinData.drawData.bill10000 = 0;
      coinData.drawData.bill5000  = 0;
      coinData.drawData.bill2000  = 0;
      coinData.drawData.bill1000  = 0;
      coinData.drawData.coin500   = ifAcxRepack(src, billBStr.sublist(80));
      coinData.drawData.coin100   = ifAcxRepack(src, billBStr.sublist(83));
      coinData.drawData.coin50    = ifAcxRepack(src, billBStr.sublist(86));
      coinData.drawData.coin10    = ifAcxRepack(src, billBStr.sublist(89));
      coinData.drawData.coin5     = ifAcxRepack(src, billBStr.sublist(92));
      coinData.drawData.coin1     = ifAcxRepack(src, billBStr.sublist(95));
    }

    return;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb50StockGet()
  /// * 機能概要      : Coin/Bill Changer Stock Data Get
  /// * 引数          : TprTID src
  /// *                 CoinData coinData
  /// *                 List<String> rcvData
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifAcb50StockGet(TprTID src, CoinData coinData,
      List<String> rcvData) {
    List<int> billB = List.generate(98, (_) => 0);
    int i = 0;
    int tmpData;
    List<String> billBStr = List.generate(98, (_) => "");

    // billB buf init
    for (i = 0; i < billB.length; i++) {
      try {
        billB[i] = rcvData[i + 2].codeUnitAt(0);
      } catch(e) {
        billB[i] = 0x30;
      }
    }
    for (i = 0; i < billB.length; i++) {
      if ((0x39 >= billB[i]) && (billB[i] >= 0x30)) {
        billBStr[i] = latin1.decode([billB[i]]);
      } else {
        billBStr[i] = "\x30";
      }
    }
    TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal,
        "ifAcb50StockGet : normal");

    coinData.holder.bill10000 = ifAcxRepack(src, billBStr.sublist(3));
    coinData.holder.bill5000 = ifAcxRepack(src, billBStr.sublist(6));
    coinData.holder.bill2000 = ifAcxRepack(src, billBStr.sublist(0));
    coinData.holder.bill1000 = ifAcxRepack(src, billBStr.sublist(9));
    coinData.holder.coin500 = ifAcxRepack(src, billBStr.sublist(24));
    coinData.holder.coin100 = ifAcxRepack(src, billBStr.sublist(27));
    coinData.holder.coin50 = ifAcxRepack(src, billBStr.sublist(30));
    coinData.holder.coin10 = ifAcxRepack(src, billBStr.sublist(33));
    coinData.holder.coin5 = ifAcxRepack(src, billBStr.sublist(36));
    coinData.holder.coin1 = ifAcxRepack(src, billBStr.sublist(39));

    if (AcxCom.ifAcbSelect() & CoinChanger.SST1 != 0) {
      tmpData = ifAcxRepack(src, billBStr.sublist(74));
      coinData.billrjctIn = tmpData ~/ 100; // 入金リジェクト
      coinData.billrjctOut = tmpData % 100; // 出金リジェクト
      coinData.billrjct = coinData.billrjctIn + coinData.billrjctOut;
    } else {
      coinData.billrjct = ifAcxRepack(src, billBStr.sublist(74));
    }

    coinData.coinrjct = ifAcxRepack(src, billBStr.sublist(77));

    coinData.overflow.bill10000 = ifAcxRepack(src, billBStr.sublist(15));
    coinData.overflow.bill5000 = ifAcxRepack(src, billBStr.sublist(18));
    coinData.overflow.bill2000 = ifAcxRepack(src, billBStr.sublist(12));
    coinData.overflow.bill1000 = ifAcxRepack(src, billBStr.sublist(21));
    coinData.overflow.coin500 = ifAcxRepack(src, billBStr.sublist(80));
    coinData.overflow.coin100 = ifAcxRepack(src, billBStr.sublist(83));
    coinData.overflow.coin50 = ifAcxRepack(src, billBStr.sublist(86));
    coinData.overflow.coin10 = ifAcxRepack(src, billBStr.sublist(89));
    coinData.overflow.coin5 = ifAcxRepack(src, billBStr.sublist(92));
    coinData.overflow.coin1 = ifAcxRepack(src, billBStr.sublist(95));

    int temp70 = int.parse(billBStr[70]);
    int temp71 = int.parse(billBStr[71]);
    int temp72 = int.parse(billBStr[72]);
    int temp73 = int.parse(billBStr[73]);
    coinData.billfull.rjctfull = temp71 & 0x01;
    coinData.billfull.csetfull = ((temp71 & 0x02) > 1) ? 1 : 0;
    coinData.billfull.actFlg = ((temp71 & 0x04) > 2) ? 1 : 0;
    coinData.coinslot = ((temp73 & 0x08) > 4) ? 1 : 0;
    coinData.stockState.billFlg = ((temp70 & 0x01) != 0) ? 1 : 0;
    coinData.stockState.billOverflow = ((temp70 & 0x02) != 0) ? 1 : 0;
    coinData.stockState.coinFlg = ((temp72 & 0x01) != 0) ? 1 : 0;

    return;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb50StockGet2()
  /// * 機能概要      : 棒金拡張フォーマット
  /// * 引数          : TprTID src
  /// *                 CoinData coinData
  /// *                 List<String> rcvData
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifAcb50StockGet2(TprTID src, CoinData coinData,
      List<String> rcvData) {
    List<int> billB = List.generate(118, (_) => 0);
    int i = 0;
    List<String> billBStr = List.generate(118, (_) => "");

    // billB buf init
    for (i = 0; i < billB.length; i++) {
      try {
        billB[i] = rcvData[i + 2].codeUnitAt(0);
      } catch(e) {
        billB[i] = 0x30;
      }
    }
    for (i = 0; i < billB.length; i++) {
      if ((0x39 >= billB[i]) && (billB[i] >= 0x30)) {
        billBStr[i] = latin1.decode([billB[i]]);
      } else {
        billBStr[i] = "\x30";
      }
    }
    TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal,
        "ifAcb50StockGet2 : chgdrw cnct");

    coinData.holder.bill10000 = ifAcxRepack(src, billBStr.sublist(3));
    coinData.holder.bill5000 = ifAcxRepack(src, billBStr.sublist(6));
    coinData.holder.bill2000 = ifAcxRepack(src, billBStr.sublist(0));
    coinData.holder.bill1000 = ifAcxRepack(src, billBStr.sublist(9));
    coinData.holder.coin500 = ifAcxRepack(src, billBStr.sublist(24));
    coinData.holder.coin100 = ifAcxRepack(src, billBStr.sublist(27));
    coinData.holder.coin50 = ifAcxRepack(src, billBStr.sublist(30));
    coinData.holder.coin10 = ifAcxRepack(src, billBStr.sublist(33));
    coinData.holder.coin5 = ifAcxRepack(src, billBStr.sublist(36));
    coinData.holder.coin1 = ifAcxRepack(src, billBStr.sublist(39));

    coinData.billrjct = ifAcxRepack(src, billBStr.sublist(74));

    coinData.coinrjct = ifAcxRepack(src, billBStr.sublist(77));

    coinData.overflow.bill10000 = ifAcxRepack(src, billBStr.sublist(15));
    coinData.overflow.bill5000 = ifAcxRepack(src, billBStr.sublist(18));
    coinData.overflow.bill2000 = ifAcxRepack(src, billBStr.sublist(12));
    coinData.overflow.bill1000 = ifAcxRepack(src, billBStr.sublist(21));
    coinData.overflow.coin500 = ifAcxRepack(src, billBStr.sublist(80));
    coinData.overflow.coin100 = ifAcxRepack(src, billBStr.sublist(83));
    coinData.overflow.coin50 = ifAcxRepack(src, billBStr.sublist(86));
    coinData.overflow.coin10 = ifAcxRepack(src, billBStr.sublist(89));
    coinData.overflow.coin5 = ifAcxRepack(src, billBStr.sublist(92));
    coinData.overflow.coin1 = ifAcxRepack(src, billBStr.sublist(95));

    coinData.drawData.bill10000 = 0;
    coinData.drawData.bill5000 = 0;
    coinData.drawData.bill2000 = 0;
    coinData.drawData.bill1000 = 0;
    coinData.drawData.coin500 = ifAcxRepack(src, billBStr.sublist(100));
    coinData.drawData.coin100 = ifAcxRepack(src, billBStr.sublist(103));
    coinData.drawData.coin50 = ifAcxRepack(src, billBStr.sublist(106));
    coinData.drawData.coin10 = ifAcxRepack(src, billBStr.sublist(109));
    coinData.drawData.coin5 = ifAcxRepack(src, billBStr.sublist(112));
    coinData.drawData.coin1 = ifAcxRepack(src, billBStr.sublist(115));

    int temp70 = billBStr[70].codeUnitAt(0);
    int temp71 = billBStr[71].codeUnitAt(0);
    int temp72 = billBStr[72].codeUnitAt(0);
    int temp73 = billBStr[73].codeUnitAt(0);
    int temp99 = billBStr[99].codeUnitAt(0);

    coinData.billfull.rjctfull = temp71 & 0x01;
    coinData.billfull.csetfull = ((temp71 & 0x02) > 1) ? 1 : 0;
    coinData.billfull.actFlg = ((temp71 & 0x04) > 2) ? 1 : 0;
    coinData.coinslot = ((temp73 & 0x08) > 4) ? 1 : 0;
    coinData.stockState.billFlg = ((temp70 & 0x01) != 0) ? 1 : 0;
    coinData.stockState.billOverflow = ((temp70 & 0x02) != 0) ? 1 : 0;
    coinData.stockState.coinFlg = ((temp72 & 0x01) != 0) ? 1 : 0;
    coinData.drawStat = temp99 & 0x01;

    return;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb20StockGet()
  /// * 機能概要      : Coin/Bill Changer Stock Data Get
  /// * 引数          : TprTID src
  /// *                 CoinData coinData
  /// *                 List<String> rcvData
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifAcb20StockGet(TprTID src, CoinData coinData,
      List<String> rcvData) {
    RxCommonBuf pComBuf = RxCommonBuf();
    List<int> billB = List.generate(98, (_) => 0);
    int i = 0;
    List<String> billBStr = List.generate(98, (_) => "");

    // billB buf init
    for (i = 0; i < billB.length; i++) {
      try {
        billB[i] = rcvData[i + 2].codeUnitAt(0);
      } catch(e) {
        billB[i] = 0x30;
      }
    }
    for (i = 0; i < billB.length; i++) {
      if ((0x39 >= billB[i]) && (billB[i] >= 0x30)) {
        billBStr[i] = latin1.decode([billB[i]]);
      } else {
        billBStr[i] = "\x30";
      }
    }

    RxMemRet cRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (cRet.result != RxMem.RXMEM_OK) {
      return;
    }
    pComBuf = cRet.object;

    coinData.holder.bill10000 = 0;
    coinData.holder.bill1000 = ifAcxRepack(src, billBStr.sublist(9));
    coinData.holder.coin500 = ifAcxRepack(src, billBStr.sublist(24));
    coinData.holder.coin100 = ifAcxRepack(src, billBStr.sublist(27));
    coinData.holder.coin50 = ifAcxRepack(src, billBStr.sublist(30));
    coinData.holder.coin10 = ifAcxRepack(src, billBStr.sublist(33));
    coinData.holder.coin5 = ifAcxRepack(src, billBStr.sublist(36));
    coinData.holder.coin1 = ifAcxRepack(src, billBStr.sublist(39));

    coinData.billrjct = 0;
    coinData.coinrjct = ifAcxRepack(src, billBStr.sublist(77));

    coinData.overflow.bill10000 = ifAcxRepack(src, billBStr.sublist(15));
    coinData.overflow.bill1000 = ifAcxRepack(src, billBStr.sublist(21));
    coinData.overflow.coin500 = ifAcxRepack(src, billBStr.sublist(80));
    coinData.overflow.coin100 = ifAcxRepack(src, billBStr.sublist(83));
    coinData.overflow.coin50 = ifAcxRepack(src, billBStr.sublist(86));
    coinData.overflow.coin10 = ifAcxRepack(src, billBStr.sublist(89));
    coinData.overflow.coin5 = ifAcxRepack(src, billBStr.sublist(92));
    coinData.overflow.coin1 = ifAcxRepack(src, billBStr.sublist(95));

    if (pComBuf.dbTrm.bothAcrClrFlg == 0) // 5000
        {
      coinData.holder.bill5000 =
          ifAcxRepack(src, billBStr.sublist(6)); // h5000
      coinData.holder.bill2000 = 0;
      coinData.overflow.bill5000 =
          ifAcxRepack(src, billBStr.sublist(18)); // o5000
      coinData.overflow.bill2000 =
          ifAcxRepack(src, billBStr.sublist(0)) // h2000
              + ifAcxRepack(src, billBStr.sublist(12)); // o2000
    } else if (pComBuf.dbTrm.bothAcrClrFlg == 1) { // 2000
      coinData.holder.bill5000 = 0;
      coinData.holder.bill2000 =
          ifAcxRepack(src, billBStr.sublist(0)); // h2000
      coinData.overflow.bill5000 =
          ifAcxRepack(src, billBStr.sublist(6)) // h5000
              + ifAcxRepack(src, billBStr.sublist(18)); // o5000
      coinData.overflow.bill2000 =
          ifAcxRepack(src, billBStr.sublist(12)); // o2000
    }
    return;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb10StockGet()
  /// * 機能概要      : Coin/Bill Changer Stock Data Get
  /// * 引数          : TprTID src
  /// *                 CoinData coinData
  /// *                 List<String> rcvData
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifAcb10StockGet(TprTID src, CoinData coinData,
      List<String> rcvData) {
    RxCommonBuf pComBuf = RxCommonBuf();

    RxMemRet cRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (cRet.result != RxMem.RXMEM_OK) {
      return;
    }
    pComBuf = cRet.object;

    coinData.holder.bill10000 = 0;
    coinData.holder.bill1000 = ifAcxRepack(src, rcvData.sublist(11));
    coinData.holder.coin500 = ifAcxRepack(src, rcvData.sublist(14));
    coinData.holder.coin100 = ifAcxRepack(src, rcvData.sublist(17));
    coinData.holder.coin50 = ifAcxRepack(src, rcvData.sublist(20));
    coinData.holder.coin10 = ifAcxRepack(src, rcvData.sublist(23));
    coinData.holder.coin5 = ifAcxRepack(src, rcvData.sublist(26));
    coinData.holder.coin1 = ifAcxRepack(src, rcvData.sublist(29));

    coinData.billrjct = ifAcxRepack(src, rcvData.sublist(32));
    coinData.coinrjct = ifAcxRepack(src, rcvData.sublist(35));

    coinData.overflow.bill10000 = ifAcxRepack(src, rcvData.sublist(38))
        + ifAcxRepack(src, rcvData.sublist(2));
    coinData.overflow.bill1000 = ifAcxRepack(src, rcvData.sublist(47));
    coinData.overflow.coin500 = ifAcxRepack(src, rcvData.sublist(50));
    coinData.overflow.coin100 = ifAcxRepack(src, rcvData.sublist(53));
    coinData.overflow.coin50 = ifAcxRepack(src, rcvData.sublist(56));
    coinData.overflow.coin10 = ifAcxRepack(src, rcvData.sublist(59));
    coinData.overflow.coin5 = ifAcxRepack(src, rcvData.sublist(62));
    coinData.overflow.coin1 = ifAcxRepack(src, rcvData.sublist(65));

    if (pComBuf.dbTrm.bothAcrClrFlg == 0) {
      /* 5000 */
      coinData.holder.bill5000 = ifAcxRepack(src, rcvData.sublist(5));
      coinData.holder.bill2000 = 0;
      coinData.overflow.bill5000 = ifAcxRepack(src, rcvData.sublist(41));
      coinData.overflow.bill2000 = ifAcxRepack(src, rcvData.sublist(8))
          + ifAcxRepack(src, rcvData.sublist(44));
    } else if (pComBuf.dbTrm.bothAcrClrFlg == 1) {
      /* 2000 */
      coinData.holder.bill5000 = 0;
      coinData.holder.bill2000 = ifAcxRepack(src, rcvData.sublist(8));
      coinData.overflow.bill5000 = ifAcxRepack(src, rcvData.sublist(5))
          + ifAcxRepack(src, rcvData.sublist(41));
      coinData.overflow.bill2000 = ifAcxRepack(src, rcvData.sublist(44));
    }

    return;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcrStockGet()
  /// * 機能概要      : Coin Changer tock Data Get
  /// * 引数          : TprTID src
  /// *                 CoinData coinData
  /// *                 List<String> rcvData
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifAcrStockGet(TprTID src, CoinData coinData, List<String> rcvData) {
    List<int> coinB = List.generate(39, (_) => 0);
    int i = 0;
    List<String> coinBStr = List.generate(39, (_) => "");

    // coinb buf init
    for (i = 0; i < coinB.length; i++) {
      try {
        coinB[i] = rcvData[i + 2].codeUnitAt(0);
      } catch(e) {
        coinB[i] = 0x30;
      }
      debugPrint("coinB[${i}]}:${coinB[i]}");
    }
    for (i = 0; i < coinBStr.length; i++) {
      if ((0x39 >= coinB[i]) && (coinB[i] >= 0x30)) {
        coinBStr[i] = latin1.decode([coinB[i]]);
      } else {
        coinBStr[i] = "\x30";
      }
      debugPrint("coinBStr[${i}]}:${coinBStr[i]}");
    }

    // data set
    coinData.holder.bill10000 = 0;
    coinData.holder.bill5000 = 0;
    coinData.holder.bill2000 = 0;
    coinData.holder.bill1000 = 0;

    coinData.holder.coin500 = ifAcxRepack(src, coinBStr.sublist( 0));
    coinData.holder.coin100 = ifAcxRepack(src, coinBStr.sublist( 3));
    coinData.holder.coin50 = ifAcxRepack(src, coinBStr.sublist( 6));
    coinData.holder.coin10 = ifAcxRepack(src, coinBStr.sublist( 9));
    coinData.holder.coin5 = ifAcxRepack(src, coinBStr.sublist(12));
    coinData.holder.coin1 = ifAcxRepack(src, coinBStr.sublist(15));

    coinData.billrjct = 0;

    coinData.coinrjct = ifAcxRepack(src, coinBStr.sublist(18));

    coinData.overflow.bill10000 = 0;
    coinData.overflow.bill5000 = 0;
    coinData.overflow.bill2000 = 0;
    coinData.overflow.bill1000 = 0;

    coinData.overflow.coin500 = ifAcxRepack(src, coinBStr.sublist(21));
    coinData.overflow.coin100 = ifAcxRepack(src, coinBStr.sublist(24));
    coinData.overflow.coin50 = ifAcxRepack(src, coinBStr.sublist(27));
    coinData.overflow.coin10 = ifAcxRepack(src, coinBStr.sublist(30));
    coinData.overflow.coin5 = ifAcxRepack(src, coinBStr.sublist(33));
    coinData.overflow.coin1 = ifAcxRepack(src, coinBStr.sublist(36));

    return;
  }
  // #endif

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxStockGet()
  /// * 機能概要      : Coin/Bill Changer & Coin Changer Stock Data Get
  /// * 引数          : TprTID src
  /// *                 CoinData coinData
  /// *                 List<String> rcvData
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static Future<int> ifAcxStockGet(TprTID src, int changerFlg,
                            CoinData coinData, TprMsgDevReq2_t rcvBuf) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;
      String log = "";

      errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);
      if (errCode == IfAcxDef.MSG_ACROK) /*  OK !  next    */ {
        if ((AcxCom.ifAcbSelect() & CoinChanger.FAL2) != 0) {
          errCode = AcxCom.ifAcxRcvDLEChk(src, rcvBuf.data);
        }
      }
      if (errCode != IfAcxDef.MSG_ACROK) {
        return errCode; /* NG return   !  */
      }
      // OK !  next

      chgDrwSystem = await CmCksys.cmAcxChgdrwSystem();

      if (changerFlg == CoinChanger.ACR_COINBILL) /* Coin/Bill Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ACB_10:
            ifAcb10StockGet(src, coinData, rcvBuf.data);
            break;
          case CoinChanger.ACB_20:
            ifAcb20StockGet(src, coinData, rcvBuf.data);
            break;
          case CoinChanger.ACB_50_:
          case CoinChanger.ACB_200:
          case CoinChanger.RT_300:
            if (chgDrwSystem == 1) {
              ifAcb50StockGet2(src, coinData, rcvBuf.data);
            } else {
              ifAcb50StockGet(src, coinData, rcvBuf.data);
            }
            break;
          case CoinChanger.SST1:
            ifAcb50StockGet(src, coinData, rcvBuf.data);
            break;
          case CoinChanger.ECS:
          case CoinChanger.ECS_777:
            ifEcsStockGet(src, coinData, rcvBuf.data);
            break;
          case CoinChanger.FAL2:
            // if_fal2_StockGet(src, coinData, &rcvBuf.data);
            break;
          default:
            errCode = IfAcxDef.MSG_ACRFLGERR;
            break;
        }
      }
      else if (changerFlg == CoinChanger.ACR_COINONLY) /* Coin Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ECS:
          case CoinChanger.ECS_777:
            ifEcsStockGet(src, coinData, rcvBuf.data);
            break;
          default:
            ifAcrStockGet(src, coinData, rcvBuf.data);
            break;
        }
      }
      else /* changerFlg NG ! */ {
        errCode = IfAcxDef.MSG_ACRFLGERR;
      }
      if (errCode == IfAcxDef.MSG_ACROK) {
        RxMemRet sRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
        if (sRet.result == RxMem.RXMEM_OK) {
          tsBuf = sRet.object;
          ifAcxRealMemSet(tsBuf.acx.coinStock, coinData, tsBuf.acx.stockState);
          if (tsBuf.acx.stockReady == 0) {
            await ifAcxHolderStatusFlagInit(tsBuf.acx);
            log = '''
"\n"
"*******************************************************************************************************
[  ] : Stock  /  {  } : Caset or Drw  /  STOCK_ERR : Fukakutei Unit);
(--) : Empty Trminal 0 set / (<<) : Empty / ( <):NearEnd / (  ):Normal / ( >):NearFull / (>>):Full);
*******************************************************************************************************"
''';
            TprLog().logAdd(
                IfChangerIsolate.taskId, LogLevelDefine.normal, log);
          }
          tsBuf.acx.stockReady = 1;
          await ifAcxHolderStatusFlagSet(tsBuf.acx);
        }
      }
      return errCode;
    }else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxRealMemSet()
  /// * 機能概要      : 精査コマンドで取得した在高データを在高データリアル問い合わせ用メモリにセットする
  /// * 引数          : CoinStock *coinStock     在高データリアル問い合わせ用メモリ
  /// *                COINDATA   *coinData      在高データ
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifAcxRealMemSet(CoinStock coinStock, CoinData coinData,
      StockState stockState) {
    DateTime dt;

    coinStock.holder = coinData.holder;
    coinStock.billRjct = coinData.billrjct;
    coinStock.coinRjct = coinData.coinrjct;
    coinStock.overflow = coinData.overflow;
    if(chgDrwSystem == 1){
      coinStock.drawData = coinData.drawData;
    }
    stockState.billFlg      = coinData.stockState.billFlg;
    stockState.billOverflow = coinData.stockState.billOverflow;
    stockState.coinFlg      = coinData.stockState.coinFlg;

    //在高取得日時をセット（実績作成処理にてデータ部が全て0のデータはDBに書込まれないため、全回収後在高0が実績として反映しない対策）
    //cm_read_sysdate(&dt);
    dt = DateTime.now();
    coinStock.dateTime = "${dt.year}-${dt.month}-${dt.day} ${dt.hour}:${dt.minute}:${dt.second}";
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxHolderStatusFlagInit()
  /// * 機能概要      : 1回目の保留枚数取得時に1度だけ行う
  /// * 引数          : RxTaskStatAcx acx
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static Future<void> ifAcxHolderStatusFlagInit(RxTaskStatAcx acx) async {
    String log = "";
    int num;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    JsonRet jsonRet;

    // 初期化
    acx.holderStatus.simpleFlg = HolderFlagList.HOLDER_NORMAL;
    acx.holderStatus.qcNearFullDiff = -1;
    acx.holderStatus.qcSignpFullChk = 0;
    for (num = CoinBillKindList.CB_KIND_10000.id; num < CoinBillKindList.CB_KIND_MAX.id; num++) {
      acx.holderStatus.kindFlg[num] = HolderFlagList.HOLDER_NORMAL;
    }

    // ニアフル差分枚数取得
    Mac_infoJsonFile macInfo = pCom.iniMacInfo;
    jsonRet = await macInfo.getValueWithName("acx_flg", "acx_nearfull_diff");
    if (jsonRet.result == true) {
      acx.holderStatus.nearFullDiff = macInfo.acx_flg.acx_nearfull_diff;
    }
    else {
      acx.holderStatus.nearFullDiff = 20;
    }

    if (await CmCksys.cmQCashierSystem() == 1) {
      acx.holderStatus.qcNearFullDiff = 0;

      // QCニアフル差分枚数取得
      QcashierJsonFile qCashier = QcashierJsonFile();
      await qCashier.load();
      jsonRet = await qCashier.getValueWithName("chg_info", "chg_info_full_chk");
      if (jsonRet.result == true) {
        acx.holderStatus.qcNearFullDiff += qCashier.chg_info.chg_info_full_chk;
      }
      else {
        acx.holderStatus.qcNearFullDiff += 30;
      }

      // QCニアフルサインポールの差分枚数
      jsonRet = await qCashier.getValueWithName("chg_info", "chg_signp_full_chk");
      if (jsonRet.result == true) {
        acx.holderStatus.qcSignpFullChk += qCashier.chg_info.chg_signp_full_chk;
      }
      else {
        acx.holderStatus.qcSignpFullChk += 10;
      }
    }

    //ターミナル最大保留枚数の設定値ログ出力
    log = "trm AcxMax "
        "[10000:${pCom.dbTrm.acxM10000}][5000:${pCom.dbTrm.acxM5000}]"
        "[2000:${pCom.dbTrm.acxM2000}][1000:${pCom.dbTrm.acxM1000}]  "
        "[500:${pCom.dbTrm.acxM500}][100:${pCom.dbTrm.acxM100}]"
        "[50:${pCom.dbTrm.acxM50}][10:${pCom.dbTrm.acxM10}]"
        "[5:${pCom.dbTrm.acxM5}][1:${pCom.dbTrm.acxM1}]";
    TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal, log);

    //ニアフル差分枚数ログ出力
    if (acx.holderStatus.qcNearFullDiff >= 0) {
      log = "nearFullDiff[${acx.holderStatus.qcNearFullDiff}] SignP[${acx.holderStatus.qcSignpFullChk}]";
    } else {
      log = "nearFullDiff[${acx.holderStatus.nearFullDiff}]";
    }
    TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal, log);
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxHolderStatusFlagSet()
  /// * 機能概要      : 全金種に対して設定との差を確認する
  /// * 引数          : RxTaskStatAcx acx
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  /// 関連tprxソース:acx_stcg.c  if_acx_HolderStatusFlagSet
  static Future<void> ifAcxHolderStatusFlagSet(RxTaskStatAcx acx) async {
    HolderFlagList setFlag;
    int num = 0;
    int chkDiff = 0; //ニアフル差分枚数
    int chkSignP = 0; //サインポール枚数
    int fullSetData = 0; //最大保留枚数設定
    int endSetData = 0; //ニアエンド枚数設定
    int stockDataKind = 0; //在高(金種単位)
    int stockDataUnit = 0; //在高(収納庫単位)
    int acbSelect = 0; //釣銭機機種
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pComBuf = xRet.object;

    acbSelect = AcxCom.ifAcbSelect();
    if (acx.holderStatus.qcNearFullDiff >= 0) {
      chkDiff = acx.holderStatus.qcNearFullDiff; // QC用ニアフル差分枚数
    }
    else {
      chkDiff = acx.holderStatus.nearFullDiff; // 通常ニアフル差分枚数
    }
    chkSignP = acx.holderStatus.qcSignpFullChk; // QCニアフルサインポールの差分枚数

    for (num = 0; num < CoinBillKindList.CB_KIND_MAX.id; num++) {
      setFlag = HolderFlagList.HOLDER_NORMAL;
      switch (coinBillKindListGetIndex(num)) {
        case CoinBillKindList.CB_KIND_10000 :
          if (await CmCksys.cmAcxCnct() != 2) {
            continue;
          }
          stockDataUnit = stockDataKind = acx.coinStock.holder!.bill10000;
          fullSetData = pComBuf.dbTrm.acxM10000;
          endSetData = 0; //万券はニアエンド設定がない

          if ((acbSelect & CoinChanger.ECS_X) != 0) { //混合庫
            stockDataUnit = acx.coinStock.holder!.bill10000 +
                acx.coinStock.holder!.bill5000 +
                acx.coinStock.holder!.bill2000;
            fullSetData = pComBuf.dbTrm.acxM5000; //混合庫なので設定値は5000円設定で判定
          }
          break;
        case CoinBillKindList.CB_KIND_05000 :
          if (await CmCksys.cmAcxCnct() != 2) {
            continue;
          }

          stockDataUnit = stockDataKind = acx.coinStock.holder!.bill5000;
          fullSetData = pComBuf.dbTrm.acxM5000;
          endSetData = pComBuf.dbTrm.acxN5000;

          if ((acbSelect & CoinChanger.ECS_X) != 0) { //混合庫
            stockDataUnit = acx.coinStock.holder!.bill10000 +
                acx.coinStock.holder!.bill5000 +
                acx.coinStock.holder!.bill2000;
          }
          else if ((acbSelect & CoinChanger.ACB_20_X) != 0) {
            //グローリー系は釣札機5000円筒の収納金種が[1:2千円札]であれば5000円のステータス表示しない
            if (pComBuf.dbTrm.bothAcrClrFlg == 1) {
              fullSetData = 0;
              endSetData = 0;
            }
          }
          break;
        case CoinBillKindList.CB_KIND_02000 :
          if (await CmCksys.cmAcxCnct() != 2) {
            continue;
          }

          stockDataUnit = stockDataKind = acx.coinStock.holder!.bill2000;
          fullSetData = pComBuf.dbTrm.acxM2000;
          endSetData = pComBuf.dbTrm.acxN2000;

          if ((acbSelect & CoinChanger.ECS_X) != 0) { //混合庫
            stockDataUnit = acx.coinStock.holder!.bill10000 +
                acx.coinStock.holder!.bill5000 +
                acx.coinStock.holder!.bill2000;
            fullSetData = pComBuf.dbTrm.acxM5000; //混合庫なので設定値は5000円設定で判定
            endSetData = 0; //QCに合わせてニアエンド判定しない
          }
          else if ((acbSelect & CoinChanger.ACB_20_X) != 0) {
            //グローリー系は釣札機5000円筒の収納金種が[0:5千円札]であれば2000円のステータス表示しない
            if (pComBuf.dbTrm.bothAcrClrFlg == 0) {
              fullSetData = 0;
              endSetData = 0;
            }
          }
          else { //富士電機でもグローリーでもない場合、2000円収納庫ない
            fullSetData = 0;
            endSetData = 0;
          }
          break;
        case CoinBillKindList.CB_KIND_01000 :
          if (await CmCksys.cmAcxCnct() != 2) {
            continue;
          }

          stockDataUnit = stockDataKind = acx.coinStock.holder!.bill1000;
          fullSetData = pComBuf.dbTrm.acxM1000;
          endSetData = pComBuf.dbTrm.acxN1000;
          break;
        case CoinBillKindList.CB_KIND_00500 :
          stockDataUnit = stockDataKind = acx.coinStock.holder!.coin500;
          fullSetData = pComBuf.dbTrm.acxM500;
          endSetData = pComBuf.dbTrm.acxN500;
          break;
        case CoinBillKindList.CB_KIND_00100 :
          stockDataUnit = stockDataKind = acx.coinStock.holder!.coin100;
          fullSetData = pComBuf.dbTrm.acxM100;
          endSetData = pComBuf.dbTrm.acxN100;
          break;
        case CoinBillKindList.CB_KIND_00050 :
          stockDataUnit = stockDataKind = acx.coinStock.holder!.coin50;
          fullSetData = pComBuf.dbTrm.acxM50;
          endSetData = pComBuf.dbTrm.acxN50;
          break;
        case CoinBillKindList.CB_KIND_00010 :
          stockDataUnit = stockDataKind = acx.coinStock.holder!.coin10;
          fullSetData = pComBuf.dbTrm.acxM10;
          endSetData = pComBuf.dbTrm.acxN10;
          break;
        case CoinBillKindList.CB_KIND_00005 :
          stockDataUnit = stockDataKind = acx.coinStock.holder!.coin5;
          fullSetData = pComBuf.dbTrm.acxM5;
          endSetData = pComBuf.dbTrm.acxN5;
          break;
        case CoinBillKindList.CB_KIND_00001 :
          stockDataUnit = stockDataKind = acx.coinStock.holder!.coin1;
          fullSetData = pComBuf.dbTrm.acxM1;
          endSetData = pComBuf.dbTrm.acxN1;
          break;
        default:
          stockDataUnit = stockDataKind = 0;
          fullSetData = 0;
          endSetData = 0;
          break;
      }

      if (stockDataKind == 0) {
        //ニアエンド枚数設定が0以下なら同じ空という状態でもEMPTYとステータスをわける(ニアエンド設定がない金種も含む)
        if (endSetData > 0) {
          setFlag = HolderFlagList.HOLDER_EMPTY;
        } else {
          setFlag = HolderFlagList.HOLDER_NON;
          //NONの扱いは「空」ではあるがニアエンドを判定しない(設定していない)、つまり不足してても問題ない「空」
        }
      }
      else {
        //最大保留枚数設定がされていない金種(fullSetData > 0 でない)はニアフル、フルにしない
        //ニアエンド枚数設定がされていない金種(endSetData > 0 でない)はニアエンドにしない
        if ((stockDataKind <= endSetData) && (endSetData > 0)) //ニアエンド設定ない金種は対象外にするように(endSetDataを-1にすれば対象外)
        {
          //混合庫等フル条件になると複数金種がFULLになってしまうのでNEAR_ENDを優先
          setFlag = HolderFlagList.HOLDER_NEAR_END;
        }
        else if ((stockDataUnit >= fullSetData) && (fullSetData > 0)) {
          setFlag = HolderFlagList.HOLDER_FULL;
        }
        else if ((stockDataUnit > (fullSetData - chkDiff)) && (fullSetData > 0)) {
          setFlag = HolderFlagList.HOLDER_NEAR_FULL;
        }
        else if ((stockDataUnit > (fullSetData - chkDiff - chkSignP)) && (fullSetData > 0)) {
          setFlag = HolderFlagList.HOLDER_NEAR_FULL_BFR_ALERT;
        }
        else {
          setFlag = HolderFlagList.HOLDER_NORMAL;
        }
      }

      acx.holderStatus.kindFlg[num] = setFlag;

      //割合計算
      acx.holderStatus.percentage[num] = 0;
      if ((setFlag == HolderFlagList.HOLDER_EMPTY) || (setFlag == HolderFlagList.HOLDER_NON)) {
        //割合計算は収納庫単位での計算のため、金種単位での判定を必要とするエンプティは別判定が必要なため
        acx.holderStatus.percentage[num] = 0;
      }
      else if (setFlag == HolderFlagList.HOLDER_FULL) {
        //最大保留枚数設定以上の場合100以上になってしまうので(例：収納200,最大保留100 . per=200)
        acx.holderStatus.percentage[num] = 100;
      }
      else {
        if (fullSetData > 0) {
          acx.holderStatus.percentage[num] = (stockDataUnit * 100) ~/ fullSetData;
        }
      }
    }


    // スピードセルフ釣機状態アイコン表示優先順位 ニアエンド(エンプティ含む) > ニアフル(フル含む)
    setFlag = HolderFlagList.HOLDER_NORMAL;
    for (num = CoinBillKindList.CB_KIND_10000.id; num < CoinBillKindList.CB_KIND_MAX.id; num++) {
      if ((acx.holderStatus.kindFlg[num] == HolderFlagList.HOLDER_EMPTY) ||
          (acx.holderStatus.kindFlg[num] == HolderFlagList.HOLDER_NEAR_END)) {
        setFlag = HolderFlagList.HOLDER_NEAR_END;
        break;
      }
      else if ((acx.holderStatus.kindFlg[num] == HolderFlagList.HOLDER_FULL) ||
          (acx.holderStatus.kindFlg[num] == HolderFlagList.HOLDER_NEAR_FULL) ||
          (acx.holderStatus.kindFlg[num] == HolderFlagList.HOLDER_NEAR_FULL_BFR_ALERT)) {
        setFlag = HolderFlagList.HOLDER_NEAR_FULL;
      }
    }
    acx.holderStatus.simpleFlg = setFlag;

    ifAcxHolderStatusLogWrite(tsBuf.acx);
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxHolderStatusLogWrite()
  /// * 機能概要      :
  /// * 引数          : RxTaskStatAcx acx
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifAcxHolderStatusLogWrite(RxTaskStatAcx acx) {
    String log = "";
    String stockErrBuf = "";
    int billPrc, coinPrc, billOverPrc, coinDataPrc;

    RxMemRet sRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (sRet.result == RxMem.RXMEM_OK) {
      tsBuf = sRet.object;
      if ((tsBuf.acx.stockState.billFlg != 0) && (tsBuf.acx.stockState.coinFlg != 0)) {
        stockErrBuf = " : STOCK_ERR[ BILL & COIN ]";
      } else if (tsBuf.acx.stockState.billFlg != 0) {
        stockErrBuf = " : STOCK_ERR[ BILL ]";
      } else if (tsBuf.acx.stockState.coinFlg != 0) {
        stockErrBuf = " : STOCK_ERR[ COIN ]";
      } else {
        stockErrBuf = "";
      }
    }
    else {
      stockErrBuf = "";
    }

    //収納庫金額(紙幣)
    billPrc = AcxCom.ifAcxShtPriceData(
        acx.coinStock.holder as CBillKind, AcxCalcType.ACX_CALC_BILL.index);
    //収納庫金額(硬貨)
    coinPrc = AcxCom.ifAcxShtPriceData(
        acx.coinStock.holder as CBillKind, AcxCalcType.ACX_CALC_COIN.index);
    //カセット金額(紙幣)
    billOverPrc = AcxCom.ifAcxShtPriceData(
        acx.coinStock.overflow as CBillKind, AcxCalcType.ACX_CALC_BILL.index);
    //棒金ドロア金額(硬貨)
    coinDataPrc = AcxCom.ifAcxShtPriceData(
        acx.coinStock.drawData as CBillKind, AcxCalcType.ACX_CALC_COIN.index);


    //金額ログ(ユニット毎)
    // log =
    // "bill[$billPrc]{$billOverPrc} + coin[$coinPrc]{$coinDataPrc}     = total[${(billPrc +
    //     coinPrc)}]{${(billOverPrc + coinDataPrc)}(${if_acx_StockStatus_LabelGet(acx.holderStatus.simpleFlg)}) $stockErrBuf";
    TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal, log);

    //収納庫枚数ログ
//     log = '''
// "10000[${acx.coinStock.holder!.bill10000}](${if_acx_StockStatus_LabelGet(acx.holderStatus.kindFlg[CoinBillKindList.CB_KIND_10000.id])})
// 5000[${acx.coinStock.holder!.bill5000}](${if_acx_StockStatus_LabelGet(acx.holderStatus.kindFlg[CoinBillKindList.CB_KIND_05000.id])})
// 2000[${acx.coinStock.holder!.bill2000}](${if_acx_StockStatus_LabelGet(acx.holderStatus.kindFlg[CoinBillKindList.CB_KIND_02000.id])})
// 1000[${acx.coinStock.holder!.bill1000}](${if_acx_StockStatus_LabelGet(acx.holderStatus.kindFlg[CoinBillKindList.CB_KIND_01000.id])})
// 500[${acx.coinStock.holder!.coin500}](${if_acx_StockStatus_LabelGet(acx.holderStatus.kindFlg[CoinBillKindList.CB_KIND_00500.id])})
// 100[${acx.coinStock.holder!.coin100}](${if_acx_StockStatus_LabelGet(acx.holderStatus.kindFlg[CoinBillKindList.CB_KIND_00100.id])})
// 50[${acx.coinStock.holder!.coin50}](${if_acx_StockStatus_LabelGet(acx.holderStatus.kindFlg[CoinBillKindList.CB_KIND_00050.id])})
// 10[${acx.coinStock.holder!.coin10}](${if_acx_StockStatus_LabelGet(acx.holderStatus.kindFlg[CoinBillKindList.CB_KIND_00010.id])})
// 5[${acx.coinStock.holder!.coin5}](${if_acx_StockStatus_LabelGet(acx.holderStatus.kindFlg[CoinBillKindList.CB_KIND_00005.id])})
// 1[${acx.coinStock.holder!.coin1}](${if_acx_StockStatus_LabelGet(acx.holderStatus.kindFlg[CoinBillKindList.CB_KIND_00001.id])})";
// ''';
    TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal, log);

    //カセット＆棒金ドロア枚数ログ
    log = "cassette{${acx.coinStock.overflow!.bill10000}          {${acx.coinStock.overflow!.bill5000}          {${acx.coinStock.overflow!.bill2000}          {${acx.coinStock.overflow!.bill1000}      drw{${acx.coinStock.drawData!.coin500}         {${acx.coinStock.drawData!.coin100}        {${acx.coinStock.drawData!.coin50}        {${acx.coinStock.drawData!.coin10}       {${acx.coinStock.drawData!.coin5}       {${acx.coinStock.drawData!.coin1}";
    TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal, log);
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxRjctChk()
  /// * 機能概要      : 出金リジェクト部にお金収納されているかチェック
  /// * 引数          : TprTID src
  /// *                 CoinData coinData
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static int ifAcxRjctChk(TprTID src, CoinData coinData) {
    if ((coinData.billrjct != 0) ||
        (coinData.billrjctIn != 0) ||
        (coinData.billrjctOut != 0) ||
        (coinData.billrjct2000 != 0)) {
      return 1;
    }

    return 0;
  }

  static CoinBillKindList coinBillKindListGetIndex(int handle) {
    switch (handle) {
      case 0:
        return CoinBillKindList.CB_KIND_10000;
      case 1:
        return CoinBillKindList.CB_KIND_05000;
      case 2:
        return CoinBillKindList.CB_KIND_02000;
      case 3:
        return CoinBillKindList.CB_KIND_01000;
      case 4:
        return CoinBillKindList.CB_KIND_00500;
      case 5:
        return CoinBillKindList.CB_KIND_00100;
      case 6:
        return CoinBillKindList.CB_KIND_00050;
      case 7:
        return CoinBillKindList.CB_KIND_00010;
      case 8:
        return CoinBillKindList.CB_KIND_00005;
      case 9:
        return CoinBillKindList.CB_KIND_00001;
      case 10:
        return CoinBillKindList.CB_KIND_MAX;
      default:
        return CoinBillKindList.CB_KIND_10000;
    }
  }
}
