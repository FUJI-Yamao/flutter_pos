/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:math';

import 'package:flutter_pos/app/inc/lib/if_acx.dart';

import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';
import 'acx_stcg.dart';

/// 関連tprxソース:acx_stag.c
class AcxStag {
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcbStateGet()
  /// * 機能概要      : Coin/Bill Changer Status Get
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static int ifAcbStateGet(TprTID src, StateData ptStateData, TprMsgDevReq2_t rcvBuf) {
  int errCode;
  int   i;
  int   j;
  int   a;
  List<int> temp = List.generate(rcvBuf.data.length, (_) => 0);

  errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);
  if (errCode == IfAcxDef.MSG_ACROK) {
    //  OK !  next
    errCode = AcxCom.ifAcxRcvDLEChk(src, rcvBuf.data);
  }
  if (errCode != IfAcxDef.MSG_ACROK) {
    return errCode; // NG return   !
  }

  // String => int
  for (a = 0; a < temp.length; a++) {
    temp[a] = rcvBuf.data[a].codeUnitAt(0);
  }

  //  OK !  next
  i = 2;
  j = 0;
  ptStateData.st1.busy        = (temp[i] & 0x01 ) >> j++;
  ptStateData.st1.ctmErrStat  = (temp[i] & 0x02 ) >> j++;
  ptStateData.st1.cssErrStat  = (temp[i] & 0x04 ) >> j++;
  ptStateData.st1.rcvPaidType = (temp[i] & 0x08 ) >> j++;
  ptStateData.st1.pickupMode  = (temp[i] & 0x10 ) >> j++;
  ptStateData.st1.coinChgMode = (temp[i] & 0x20 ) >> j++;
  ptStateData.st1.fix1        = (temp[i] & 0x40 ) >> j++;
  ptStateData.st1.dummy       = (temp[i++] & 0x80 );

  j = 0;
  ptStateData.st2.cssClean_h  = (temp[i] & 0x01 ) >> j++;
  ptStateData.st2.cssClean_s  = (temp[i] & 0x02 ) >> j++;
  ptStateData.st2.fix0        = (temp[i] & 0x04 ) >> j++;
  ptStateData.st2.cssPaidOut  = (temp[i] & 0x08 ) >> j++;
  ptStateData.st2.cssRcvOut   = (temp[i] & 0x10 ) >> j++;
  ptStateData.st2.cssRjtStat  = (temp[i] & 0x20 ) >> j++;
  ptStateData.st2.fix1        = (temp[i] & 0x40 ) >> j++;
  ptStateData.st2.dummy       = (temp[i++] & 0x80 );

  j = 0;
  ptStateData.st3.ctmClean    = (temp[i] & 0x01 ) >> j++;
  ptStateData.st3.ctmPaidOut  = (temp[i] & 0x02 ) >> j++;
  ptStateData.st3.ctmRcvOut   = (temp[i] & 0x04 ) >> j++;
  ptStateData.st3.ctmBunit    = (temp[i] & 0x08 ) >> j++;
  ptStateData.st3.ctmConnect  = (temp[i] & 0x10 ) >> j++;
  ptStateData.st3.ctmRjtStat  = (temp[i] & 0x20 ) >> j++;
  ptStateData.st3.fix1        = (temp[i] & 0x40 ) >> j++;
  ptStateData.st3.dummy       = (temp[i++] & 0x80 );

  j = 0;
  ptStateData.st4.fix0        = (temp[i] & 0x01 ) >> j++;
  ptStateData.st4.fix1        = (temp[i] & 0x02 ) >> j++;
  ptStateData.st4.fix2        = (temp[i] & 0x04 ) >> j++;
  ptStateData.st4.fix3        = (temp[i] & 0x08 ) >> j++;
  ptStateData.st4.ctmPosition = (temp[i] & 0x10 ) >> j++;
  ptStateData.st4.ctmKind     = (temp[i] & 0x20 ) >> j++;
  ptStateData.st4.fix4        = (temp[i] & 0x40 ) >> j++;
  ptStateData.st4.dummy       = (temp[i++] & 0x80 );

  ptStateData.hopperStat[0] = temp[i++];
  ptStateData.hopperStat[1] = temp[i++];
  ptStateData.hopperStat[2] = temp[i++];
  ptStateData.hopperStat[3] = temp[i++];
  ptStateData.hopperStat[4] = temp[i++];
  ptStateData.hopperStat[5] = temp[i++];
  ptStateData.hopperStat[6] = temp[i++];
  ptStateData.hopperStat[7] = temp[i++];
  ptStateData.hopperStat[8] = temp[i++];
  ptStateData.hopperStat[9] = temp[i++];
  ptStateData.errCode[0]    = temp[i++];
  ptStateData.errCode[1]    = temp[i++];
  ptStateData.errCode[2]    = temp[i++];

  return errCode;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcrStateGet()
  /// * 機能概要      : Coin Changer State Get
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static int ifAcrStateGet(TprTID src, TprMsgDevReq2_t rcvBuf) {
    int errCode;
    errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);

    if (errCode == IfAcxDef.MSG_ACROK) {
      //  OK !  next
      errCode = AcxCom.ifAcxResultChk(src, rcvBuf.data[0]);
    }

    return errCode;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxStateGet()
  /// * 機能概要      : Coin/Bill Changer Status Read
  /// * 引数          : TprTID src
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  int ifAcxStateGet(TprTID src, int changerFlg, StateData ptStateData,
      TprMsgDevReq2_t rcvBuf) {
    int errCode;

    // TODO:コンパイルSW
    // #ifndef PPSDVS
    // Coin/Bill Changer ?
    if (true) {
      if (changerFlg == CoinChanger.ACR_COINBILL) {
        errCode = ifAcbStateGet(src, ptStateData, rcvBuf);
      }
      else {
        // Coin      Changer ?
        if (changerFlg == CoinChanger.ACR_COINONLY) {
          errCode = ifAcrStateGet(src, rcvBuf);
        }
        else {
          // changerFlg NG !
          errCode = IfAcxDef.MSG_ACRFLGERR;
        }
      }

      return errCode;
    } else {
    // #else
      return (IfAcxDef.MSG_ACROK);
    // #endif
    }
  }
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb20State80Get()
  /// * 機能概要      : 状態リードレスポンス受信データ解析ライブラリ
  /// * 引数          : TprTID src
  /// *                 StateAcb *stateAcb  状態格納エリア
  /// *                 TprMsgDevReq2_t *rcvBuf  受信データアドレス
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static int ifAcb20State80Get(TprTID src, StateAcb stateAcb, List<String> rcvData) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<int> tmpBuf = List.generate(3, (_) => 0);
      List<int> readBuf = List.generate(64, (_) => 0);
      int i;

      // read buf init
      for (i = 0; i < 64; i++) {
        readBuf[i] = rcvData[i + 2].codeUnitAt(0) & 0x3f;
      }

      /*** BILL ***/
      // エラーコード
      stateAcb.bill.errCode = readBuf.sublist(0, 4);
      // 解除手順
      tmpBuf.fillRange(0, tmpBuf.length, 0x0);
      tmpBuf = readBuf.sublist(6, 8);
      stateAcb.bill.restoreFlg = tmpBuf[0] << 4;
      stateAcb.bill.restoreFlg += tmpBuf[1];
      // 搬送路センサー情報
      stateAcb.bill.sensorInfo = 0;
      for (i = 0; i < 2; i++) {
        stateAcb.bill.sensorInfo += ((readBuf[26 + i] & 0x01) != 0) ? 1 * pow(16, 1 - i).toInt() : 0;
        stateAcb.bill.sensorInfo += ((readBuf[26 + i] & 0x02) != 0) ? 2 * pow(16, 1 - i).toInt() : 0;
        stateAcb.bill.sensorInfo += ((readBuf[26 + i] & 0x04) != 0) ? 4 * pow(16, 1 - i).toInt() : 0;
        stateAcb.bill.sensorInfo += ((readBuf[26 + i] & 0x08) != 0) ? 8 * pow(16, 1 - i).toInt() : 0;
      }

      /*** COIN ***/
      // エラーコード */
      stateAcb.coin.errCode = readBuf.sublist(40, 44);
      /* 解除手順 */
      tmpBuf.fillRange(0, tmpBuf.length, 0x0);
      tmpBuf = readBuf.sublist(44, 46);
      stateAcb.coin.restoreFlg = tmpBuf[0] << 4;
      stateAcb.coin.restoreFlg += tmpBuf[1];
      /* 在高不確定解除方法 1:回収 2:戻し入れ */
      stateAcb.bill.stockErrBill10000 = (readBuf[14] & 0x0c) >> 2;
      stateAcb.bill.stockErrBill5000 = (readBuf[14] & 0x03);
      stateAcb.bill.stockErrBill2000 = (readBuf[15] & 0x0c) >> 2;
      stateAcb.bill.stockErrBill1000 = (readBuf[15] & 0x03);
      stateAcb.bill.stockErrCaset = (readBuf[16] & 0x0c) >> 2;
      stateAcb.coin.stockErrCoin500 = (readBuf[30] & 0x0c) >> 2;
      stateAcb.coin.stockErrCoin100 = (readBuf[30] & 0x03);
      stateAcb.coin.stockErrCoin50 = (readBuf[31] & 0x0c) >> 2;
      stateAcb.coin.stockErrCoin10 = (readBuf[31] & 0x03);
      stateAcb.coin.stockErrCoin5 = (readBuf[32] & 0x0c) >> 2;
      stateAcb.coin.stockErrCoin1 = (readBuf[32] & 0x03);
      /* 搬送路センサー情報 */
      stateAcb.coin.sensorInfo = 0;
      for (i = 0; i < 2; i++) {
        stateAcb.coin.sensorInfo += ((readBuf[34+i] & 0x01) != 0) ? 1 * pow(16,1-i).toInt() : 0;
        stateAcb.coin.sensorInfo += ((readBuf[34+i] & 0x02) != 0) ? 2 * pow(16,1-i).toInt() : 0;
        stateAcb.coin.sensorInfo += ((readBuf[34+i] & 0x04) != 0) ? 4 * pow(16,1-i).toInt() : 0;
        stateAcb.coin.sensorInfo += ((readBuf[34+i] & 0x08) != 0) ? 8 * pow(16,1-i).toInt() : 0;
      }
      /* 硬貨メカセット */
      stateAcb.coin.unitInfo = 0;
      for (i = 0; i < 2; i++) {
        stateAcb.coin.unitInfo += ((readBuf[38+i] & 0x01) != 0) ? 1 * pow(16,1-i).toInt() : 0;
        stateAcb.coin.unitInfo += ((readBuf[38+i] & 0x02) != 0) ? 2 * pow(16,1-i).toInt() : 0;
        stateAcb.coin.unitInfo += ((readBuf[38+i] & 0x04) != 0) ? 4 * pow(16,1-i).toInt() : 0;
        stateAcb.coin.unitInfo += ((readBuf[38+i] & 0x08) != 0) ? 8 * pow(16,1-i).toInt() : 0;
      }

      stateAcb.coin.drawStat = ((readBuf[51] & 0x01) != 0) ? 1 : 0;

      return (errCode);
    } else {
    // #else
      return (IfAcxDef.MSG_ACROK);
    // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcbState80Get()
  /// * 機能概要      : 
  /// * 引数          : TprTID src
  /// *                 StateAcb *stateAcb  状態格納エリア
  /// *                 TprMsgDevReq2_t *rcvBuf  受信データアドレス
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static int ifAcbState80Get(TprTID src, StateAcb stateAcb, TprMsgDevReq2_t rcvBuf) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;

      errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);
      if (errCode == IfAcxDef.MSG_ACROK) /*  OK !  next    */ {
        errCode = AcxCom.ifAcxRcvDLEChk(src, rcvBuf.data);
      }
      if (errCode != IfAcxDef.MSG_ACROK) {
        return errCode; // NG return   !
      }
      //  OK !  next
      switch (AcxCom.ifAcbSelect()) {
        case CoinChanger.ACB_10:
          errCode = IfAcxDef.MSG_ACRFLGERR;
          break;
        case CoinChanger.ACB_20:
        case CoinChanger.ACB_50_:
        case CoinChanger.ACB_200:
        case CoinChanger.RT_300:
          errCode = ifAcb20State80Get(src, stateAcb, rcvBuf.data);
          break;
        case CoinChanger.SST1:
        case CoinChanger.FAL2:
        case CoinChanger.ECS:
        case CoinChanger.ECS_777:
        default:
          errCode = IfAcxDef.MSG_ACRFLGERR;
          break;
      }

      return errCode;
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcbState80Get()
  /// * 機能概要      : 状態リードレスポンス受信データ解析ライブラリ
  /// * 引数          : TprTID src
  /// *                 LAST_DATA *lastData  前回データ格納エリア
  /// *                 TprMsgDevReq2_t *rcvBuf  受信データアドレス
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static int ifAcb20StateLastDataGet(TprTID src, int type, LastData lastData,
      List<String> rcvData) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> readBuf = List.generate(64, (_) => "0");
      int i;

      // read buf init
      for (i = 0; i < 64; i++) {
        readBuf[i] = (rcvData[i + 2].codeUnitAt(0) & 0x3f).toString();
      }

//	memset(lastData, 0x0, sizeof(LAST_DATA));	初期化禁止：アプリ側で行うこと。LastDataは紙幣、硬貨で２回取得するので初期化すると一方が消える

      if (type == AcrUnitCmd.BILL_CMD.index) {
        lastData.iN.bill10000 = AcxStcg.ifAcxRepack(src, readBuf.sublist(0));
        lastData.iN.bill5000 = AcxStcg.ifAcxRepack(src, readBuf.sublist(3));
        lastData.iN.bill2000 = AcxStcg.ifAcxRepack(src, readBuf.sublist(6));
        lastData.iN.bill1000 = AcxStcg.ifAcxRepack(src, readBuf.sublist(9));
        lastData.out.bill10000 = AcxStcg.ifAcxRepack(src, readBuf.sublist(12));
        lastData.out.bill5000 = AcxStcg.ifAcxRepack(src, readBuf.sublist(15));
        lastData.out.bill2000 = AcxStcg.ifAcxRepack(src, readBuf.sublist(18));
        lastData.out.bill1000 = AcxStcg.ifAcxRepack(src, readBuf.sublist(21));
      }
      else {
        lastData.iN.coin500 = AcxStcg.ifAcxRepack(src, readBuf.sublist(0));
        lastData.iN.coin100 = AcxStcg.ifAcxRepack(src, readBuf.sublist(3));
        lastData.iN.coin50 = AcxStcg.ifAcxRepack(src, readBuf.sublist(6));
        lastData.iN.coin10 = AcxStcg.ifAcxRepack(src, readBuf.sublist(9));
        lastData.iN.coin5 = AcxStcg.ifAcxRepack(src, readBuf.sublist(12));
        lastData.iN.coin1 = AcxStcg.ifAcxRepack(src, readBuf.sublist(15));
        lastData.out.coin500 = AcxStcg.ifAcxRepack(src, readBuf.sublist(18));
        lastData.out.coin100 = AcxStcg.ifAcxRepack(src, readBuf.sublist(21));
        lastData.out.coin50 = AcxStcg.ifAcxRepack(src, readBuf.sublist(24));
        lastData.out.coin10 = AcxStcg.ifAcxRepack(src, readBuf.sublist(27));
        lastData.out.coin5 = AcxStcg.ifAcxRepack(src, readBuf.sublist(30));
        lastData.out.coin1 = AcxStcg.ifAcxRepack(src, readBuf.sublist(33));
      }

      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifAcbStateLastDataGet()
  /// * 機能概要      :
  /// * 引数          : TprTID src
  /// *                 LAST_DATA *lastData  前回データ格納エリア
  /// *                 TprMsgDevReq2_t *rcvBuf  受信データアドレス
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static int ifAcbStateLastDataGet(TprTID src, int type, LastData lastData,
      TprMsgDevReq2_t rcvBuf) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode;

      errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);
      if (errCode == IfAcxDef.MSG_ACROK) /*  OK !  next    */ {
        errCode = AcxCom.ifAcxRcvDLEChk(src, rcvBuf.data);
      }
      if (errCode != IfAcxDef.MSG_ACROK) {
        return errCode; // NG return   !
      }
      //  OK !  next
      switch (AcxCom.ifAcbSelect()) {
        case CoinChanger.ACB_10:
          errCode = IfAcxDef.MSG_ACRFLGERR;
          break;
        case CoinChanger.ACB_20:
        case CoinChanger.ACB_50_:
        case CoinChanger.ACB_200:
        case CoinChanger.RT_300:
          errCode =
              ifAcb20StateLastDataGet(src, type, lastData, rcvBuf.data);
          break;
        case CoinChanger.SST1:
        case CoinChanger.FAL2:
        case CoinChanger.ECS:
        case CoinChanger.ECS_777:
        default:
          errCode = IfAcxDef.MSG_ACRFLGERR;
          break;
      }

      return errCode;
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }
}
