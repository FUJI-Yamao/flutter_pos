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

class Fal2Statuss {
  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StatSense()
  /// * 機能概要      : 状態センスコマンド送信ライブラリ  (NEC製釣銭釣札機(FAL2)
  /// * 引数          : TprTID src
  /// *             		short	type	種別		0:変化のあったデータのみ  1:全データ
  /// *              		short	mode	モード		0:通常モード  1:アテンションモード
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static Future<int> ifFal2StatSense(TprTID src, int type, int mode) async {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      List<String> sendBuf = List.generate(40, (index) => "");
      int len = 0;

      if ((AcxCom.ifAcbSelect() & CoinChanger.FAL2) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      sendBuf[len++] = "\x80";
      sendBuf[len++] = IfAcxDef.FAL2_STATESENSE;
      sendBuf[len++] = "\x00";
      sendBuf[len++] = "\x05";
      sendBuf[len++] = latin1.decode([((type == 0) ? 0x01 : 0x02)]);
      sendBuf[len++] = "\x00";
      sendBuf[len++] = latin1.decode([(mode == 0) ? 0x00 : 0x01]);
      sendBuf[len++] = "\x00";
      sendBuf[len++] = "\x00";

      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

      return (errCode);
    } else {
    // #else
      // return	( IfAcxDef.MSG_ACROK );
    // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StatSenseGet()
  /// * 機能概要      : 状態センスコマンド返答取得ライブラリ
  /// * 引数          : TprTID src
  /// *             		StateFal2 *stateFal2
  /// *		              TprMsgDevReq2_t *rcvBuf
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static int ifFal2StatSenseGet(TprTID src, StateFal2 stateFal2,
      TprMsgDevReq2_t rcvBuf) {
    // TODO:コンパイルSW
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;
      int i, byteCnt, ret;
      List<String> dataBuf = List.generate(100, (_) => ""); // data buffer

      if ((AcxCom.ifAcbSelect() & CoinChanger.FAL2) == 0) {
        return (IfAcxDef.MSG_ACRFLGERR);
      }

      errCode = AcxCom.ifAcxRcvHeadChk(src, rcvBuf);
      if (errCode != IfAcxDef.MSG_ACROK) {
        return (errCode); // NG return !
      }

      errCode = Fal2Resg.ifFal2ResFormatChk(src, rcvBuf);
      if (errCode != IfAcxDef.MSG_ACROK) {
        return (errCode); // NG return !
      }

      byteCnt = 0;
      for (i = 0; i < 5; i++) {
        dataBuf.fillRange(0, dataBuf.length, "0x00");
        switch (i) {
          case 0:
          // レスポンス　ヘッダー部
            byteCnt += 9;
            break;
          case 1:
          // 常時通知データ
            dataBuf = rcvBuf.data.sublist(byteCnt, byteCnt + 8);
            ifFal2StSsGetAlwaysResp(src, stateFal2, dataBuf);
            byteCnt += 8;
            break;
          case 2:
          // 変化データ有無情報はライブラリで取得しない
            byteCnt += 3;
            break;
          case 3:
          // 変化データ
            ret = ifFal2StSsGetChgData(src, stateFal2, rcvBuf.data.sublist(byteCnt));
            if (ret < 0) {
              return (IfAcxDef.MSG_ACRFLGERR);
            } else {
              byteCnt += ret;
            }
            break;
          case 4:
          // 障害ログデータはライブラリで取得しない
            break;
        }
      }

      return (errCode);
    } else {
      // #else
      return (IfAcxDef.MSG_ACROK);
      // #endif
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StSsGetAlwaysResp()
  /// * 機能概要      : 状態センスコマンド結果取得ライブラリ(常時通知データ)
  /// * 引数          : TprTID src
  /// *             		StateFal2 *stateFal2
  /// *		              uchar *rcvBuf
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifFal2StSsGetAlwaysResp(TprTID src, StateFal2 stateFal2,
      List<String> rcvData) {
    stateFal2.alwaysResp.actStatus = rcvData.sublist(0, 2); // 動作ステータス
    stateFal2.alwaysResp.actResultCcode = rcvData.sublist(2, 4); // 動作結果コード
    stateFal2.alwaysResp.unitOffInfo = int.parse(rcvData[4]); // 外れ情報
    stateFal2.alwaysResp.typeCode = int.parse(rcvData[5]); // 代表コード
    stateFal2.alwaysResp.detailCode = rcvData.sublist(6, 8); // 詳細コード
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StSsGetChgData()
  /// * 機能概要      : 状態センスコマンド結果取得ライブラリ(変化データ)
  /// * 引数          : TprTID src
  /// *             		StateFal2 *stateFal2
  /// *		              uchar *rcvBuf
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static int ifFal2StSsGetChgData(TprTID src, StateFal2 stateFal2,
      List<String> rcvData) {
    int length = 0;
    String buf1;
    List<String> buf2 = List.generate(35, (_) => "");

    /* 媒体有無情報 */
    buf1 = rcvData[length];
    ifFal2StSsGetMediaExist(src, stateFal2, buf1);
    length += 1;

    /* セキュリティー情報 */
    buf1 = rcvData[length];
    ifFal2StSsGetSecurity(src, stateFal2, buf1);
    length += 1;

    /* バッテリーアラーム */
    buf1 = rcvData[length];
    ifFal2StSsGetBatteryAlarm(src, stateFal2, buf1);
    length += 1;

    /* 収納庫A状態 */
    buf1 = rcvData[length];
    ifFal2StSsGetUnitStatus(src, stateFal2, buf1, 0);
    length += 1;

    /* 収納庫B状態 */
    buf1 = rcvData[length];
    ifFal2StSsGetUnitStatus(src, stateFal2, buf1, 1);
    length += 1;

    /* 収納庫C状態 */
    buf1 = rcvData[length];
    ifFal2StSsGetUnitStatus(src, stateFal2, buf1, 2);
    length += 1;

    /* 紙幣回収庫状態 */
    buf1 = rcvData[length];
    ifFal2StSsGetUnitStatus(src, stateFal2, buf1, 3);
    length += 1;

    /* 紙幣リジェクト庫状態 */
    buf1 = rcvData[length];
    ifFal2StSsGetUnitStatus(src, stateFal2, buf1, 4);
    length += 1;

    /* 500円庫状態 */
    buf1 = rcvData[length];
    ifFal2StSsGetUnitStatus(src, stateFal2, buf1, 5);
    length += 1;

    /* 100円庫状態 */
    buf1 = rcvData[length];
    ifFal2StSsGetUnitStatus(src, stateFal2, buf1, 6);
    length += 1;

    /* 50円庫状態 */
    buf1 = rcvData[length];
    ifFal2StSsGetUnitStatus(src, stateFal2, buf1, 7);
    length += 1;

    /* 10円庫状態 */
    buf1 = rcvData[length];
    ifFal2StSsGetUnitStatus(src, stateFal2, buf1, 8);
    length += 1;

    /* 5円庫状態 */
    buf1 = rcvData[length];
    ifFal2StSsGetUnitStatus(src, stateFal2, buf1, 9);
    length += 1;

    /* 1円庫状態 */
    buf1 = rcvData[length];
    ifFal2StSsGetUnitStatus(src, stateFal2, buf1, 10);
    length += 1;

    /* 硬貨リジェクト口状態 */
    buf1 = rcvData[length];
    ifFal2StSsGetUnitStatus(src, stateFal2, buf1, 11);
    length += 1;

    /* 釣銭機待機モード */
    buf1 = rcvData[length];
    ifFal2StSsGetStandbyMode(src, stateFal2, buf1);
    length += 1;

    /* センサ情報 */
    buf2.fillRange(0, buf2.length, "0x00");
    buf2 = rcvData.sublist(length, length+7);
    ifFal2StSsGetSensor(src, stateFal2, buf2);
    length += 7;

    /* 収納庫在高状態 */
    buf1 = rcvData[length];
    ifFal2StSsGetHolderAmt(src, stateFal2, buf1);
    length += 1;

    /* ローカルモード */
    buf1 = rcvData[length];
    ifFal2StSsGetLocalMode(src, stateFal2, buf1);
    length += 1;

    /* 計数内容 */
    buf2.fillRange(0, buf2.length, "0x00");
    buf2 = rcvData.sublist(length, length+34);
    ifFal2StSsGetCount(src, stateFal2, buf2);
    length += 34;

    /* 常時入金計数内容 */
    buf2.fillRange(0, buf2.length, "0x00");
    buf2 = rcvData.sublist(length, length+34);
    ifFal2StSsGetAlwaysCount(src, stateFal2, buf2);
    length += 34;

    return length;
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StSsGetMediaExist()
  /// * 機能概要      : 状態センスコマンド結果取得ライブラリ(変化データ)
  /// * 引数          : TprTID src
  /// *             		StateFal2 *stateFal2
  /// *		              uchar data
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifFal2StSsGetMediaExist(TprTID src, StateFal2 stateFal2,
      String data) {
    int i;
    int bit = 0;

    for (i = 0; i < 5; i++) {
      bit = (int.parse(data) & (1 << i));
      if (bit > 0) {
        bit = 1;
      }

      switch (i) {
        case 0: stateFal2.mediaExist.coinInRoute = bit; break;
        case 1: stateFal2.mediaExist.coinOut = bit;     break;
        case 2: stateFal2.mediaExist.coinIn = bit;      break;
        case 3: stateFal2.mediaExist.billRoute = bit;   break;
        case 4: stateFal2.mediaExist.billInOut = bit;   break;
      }
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StSsGetSecurity()
  /// * 機能概要      : 状態センスコマンド結果取得ライブラリ(変化データ)
  /// * 引数          : TprTID src
  /// *             		StateFal2 *stateFal2
  /// *		              uchar data
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifFal2StSsGetSecurity(TprTID src, StateFal2 stateFal2, String data) {
    int i;
    int bit = 0;

    for (i = 0; i < 6; i++) {
      bit = (int.parse(data) & (1 << i));
      if (bit > 0) {
        bit = 1;
      }

      switch (i) {
        case 0: stateFal2.security.unit = bit;          break;
        case 1: stateFal2.security.collectBox = bit;    break;
        case 2:                                         break;
        case 3: stateFal2.security.rejectBoxDoor = bit; break;
        case 4: stateFal2.security.billBox = bit;       break;
        case 5: stateFal2.security.coinBox = bit;       break;
      }
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StSsGetSecurity()
  /// * 機能概要      : 状態センスコマンド結果取得ライブラリ(変化データ)
  /// * 引数          : TprTID src
  /// *             		StateFal2 *stateFal2
  /// *		              uchar data
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifFal2StSsGetBatteryAlarm(TprTID src, StateFal2 stateFal2,
      String data) {
    if (int.parse(data) == 0x00) {
      stateFal2.batteryAlarm = 0;
    } else {
      stateFal2.batteryAlarm = 1;
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StSsGetUnitStatus()
  /// * 機能概要      : 状態センスコマンド結果取得ライブラリ(変化データ)
  /// * 引数          : TprTID src
  /// *             		StateFal2 *stateFal2
  /// *		              uchar data
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifFal2StSsGetUnitStatus(TprTID src, StateFal2 stateFal2,
      String data, int flag) {
    int stat = 0;

    int temp = int.parse(data);
    if (temp == 0x00) { // エンド
      stat = 0;
    } else if (temp == 0x01) { // ニアエンド
      stat = 1;
    } else if (temp == 0x02) { // ニアフル
      stat = 2;
    } else if (temp == 0x03) { // フル
      stat = 3;
    } else { // 媒体あり
      stat = 4;
    }
    switch (flag) {
      case 0: stateFal2.unitStatus.holderA = stat;      break;
      case 1: stateFal2.unitStatus.holderB = stat;      break;
      case 2: stateFal2.unitStatus.holderC = stat;      break;
      case 3: stateFal2.unitStatus.cashBox = stat;      break;
      case 4: stateFal2.unitStatus.rejectBox = stat;    break;
      case 5: stateFal2.unitStatus.coin500Box = stat;   break;
      case 6: stateFal2.unitStatus.coin100Box = stat;   break;
      case 7: stateFal2.unitStatus.coin50Box = stat;    break;
      case 8: stateFal2.unitStatus.coin10Box = stat;    break;
      case 9: stateFal2.unitStatus.coin5Box = stat;     break;
      case 10: stateFal2.unitStatus.coin1Box = stat;    break;
      case 11: stateFal2.unitStatus.coinReject = stat;  break;
      default:                                          break;
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StSsGetStandbyMode()
  /// * 機能概要      : 状態センスコマンド結果取得ライブラリ(変化データ)
  /// * 引数          : TprTID src
  /// *             		StateFal2 *stateFal2
  /// *		              uchar data
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifFal2StSsGetStandbyMode(TprTID src, StateFal2 stateFal2,
      String data) {
    if (int.parse(data) == 0x30) {
      stateFal2.standbyMode = 0;
    } else {
      stateFal2.standbyMode = 1;
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StSsGetSensor()
  /// * 機能概要      : 状態センスコマンド結果取得ライブラリ(変化データ)
  /// * 引数          : TprTID src
  /// *             		StateFal2 *stateFal2
  /// *		              uchar data
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifFal2StSsGetSensor(TprTID src, StateFal2 stateFal2,
      List<String> rcvData) {
    int i, j;
    int bit = 0;

    for (i = 0; i < 7; i++) {
      for (j = 0; j < 8; j++) {
        bit = (int.parse(rcvData[i]) & (1 << j));
        if (bit > 0) {
          bit = 1;
        }

        if (i == 0) {
          switch (j) {
            case 0: stateFal2.sensor.sc01_1 = bit;  break;
            case 1: stateFal2.sensor.sc03 = bit;    break;
            case 2: stateFal2.sensor.sc04 = bit;    break;
            case 3: stateFal2.sensor.reserve = bit; break;
            case 4: stateFal2.sensor.sc02 = bit;    break;
            case 5: stateFal2.sensor.sc19 = bit;    break;
            case 6: stateFal2.sensor.sc21 = bit;    break;
            case 7: stateFal2.sensor.sc22 = bit;    break;
            default:                                break;
          }
        }
        else if (i == 1) {
          switch (j) {
            case 0:                             break;
            case 1:stateFal2.sensor.sc15 = bit; break;
            case 2:stateFal2.sensor.sc16 = bit; break;
            case 3:stateFal2.sensor.sc11 = bit; break;
            case 4:stateFal2.sensor.sc12 = bit; break;
            case 5:stateFal2.sensor.sc07 = bit; break;
            case 6:stateFal2.sensor.sc08 = bit; break;
            case 7:
            default:                            break;
          }
        }
        else if (i == 2) {
          switch (j) {
            case 0:
            case 1:                               break;
            case 2: stateFal2.sensor.sc17 = bit;  break;
            case 3: stateFal2.sensor.sc18 = bit;  break;
            case 4: stateFal2.sensor.sc13 = bit;  break;
            case 5: stateFal2.sensor.sc14 = bit;  break;
            case 6: stateFal2.sensor.sc09 = bit;  break;
            case 7: stateFal2.sensor.sc10 = bit;  break;
            default:                              break;
          }
        }
        else if (i == 3) {
          switch (j) {
            case 0: stateFal2.sensor.sc31 = bit;  break;
            case 1: stateFal2.sensor.sc32 = bit;  break;
            case 2: stateFal2.sensor.sc34 = bit;  break;
            case 3: stateFal2.sensor.sc35 = bit;  break;
            case 4: stateFal2.sensor.sc33 = bit;  break;
            case 5: stateFal2.sensor.sc45 = bit;  break;
            case 6: stateFal2.sensor.sc52 = bit;  break;
            case 7: stateFal2.sensor.sc53 = bit;  break;
            default:                              break;
          }
        }
        else if (i == 4) {
          switch (j) {
            case 0: stateFal2.sensor.sc39 = bit;  break;
            case 1: stateFal2.sensor.sc40 = bit;  break;
            case 2: stateFal2.sensor.sc41 = bit;  break;
            case 3: stateFal2.sensor.sc42 = bit;  break;
            case 4: stateFal2.sensor.sc43 = bit;  break;
            case 5: stateFal2.sensor.sc44 = bit;  break;
            case 6: stateFal2.sensor.sc37 = bit;  break;
            case 7: stateFal2.sensor.sc38 = bit;  break;
            default:                              break;
          }
        }
        else if (i == 5) {
          switch (j) {
            case 0: stateFal2.sensor.sc46 = bit;  break;
            case 1: stateFal2.sensor.sc47 = bit;  break;
            case 2: stateFal2.sensor.sc48 = bit;  break;
            case 3: stateFal2.sensor.sc49 = bit;  break;
            case 4: stateFal2.sensor.sc50 = bit;  break;
            case 5: stateFal2.sensor.sc51 = bit;  break;
            case 6: stateFal2.sensor.sc54 = bit;  break;
            case 7:
            default:                              break;
          }
        }
        else if (i == 6) {
          switch (j) {
            case 0: stateFal2.sensor.sc55 = bit;  break;
            case 1: stateFal2.sensor.sc56 = bit;  break;
            case 2: stateFal2.sensor.sc57 = bit;  break;
            case 3: stateFal2.sensor.sc58 = bit;  break;
            case 4: stateFal2.sensor.sc59 = bit;  break;
            case 5: stateFal2.sensor.sc60 = bit;  break;
            case 6:
            case 7:
            default:                              break;
          }
        }
      }
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StSsGetHolderAmt()
  /// * 機能概要      : 状態センスコマンド結果取得ライブラリ(変化データ)
  /// * 引数          : TprTID src
  /// *             		StateFal2 *stateFal2
  /// *		              uchar data
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifFal2StSsGetHolderAmt(TprTID src, StateFal2 stateFal2,
      String data) {
    int temp = int.parse(data);
    if (temp == 0x00) {
      stateFal2.holderAmt = 0;
    }
    else if (temp == 0x01) {
      stateFal2.holderAmt = 1;
    }
    else if (temp == 0x02) {
      stateFal2.holderAmt = 2;
    }
    else if (temp == 0x03) {
      stateFal2.holderAmt = 3;
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StSsGetLocalMode()
  /// * 機能概要      : 状態センスコマンド結果取得ライブラリ(変化データ)
  /// * 引数          : TprTID src
  /// *             		StateFal2 *stateFal2
  /// *		              uchar data
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifFal2StSsGetLocalMode(TprTID src, StateFal2 stateFal2,
      String data) {
    int temp = int.parse(data);
    if (temp == 0x01) {
      stateFal2.localMode = 0;
    }
    else if (temp == 0x02) {
      stateFal2.localMode = 1;
    }
    else if (temp == 0x04) {
      stateFal2.localMode = 2;
    }
    else if (temp == 0x08) {
      stateFal2.localMode = 3;
    }
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StSsGetCount()
  /// * 機能概要      : 状態センスコマンド結果取得ライブラリ(変化データ)
  /// * 引数          : TprTID src
  /// *             		StateFal2 *stateFal2
  /// *		              uchar data
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifFal2StSsGetCount(TprTID src, StateFal2 stateFal2,
      List<String> rcvData) {

  List<int> temp = List.generate(rcvData.length, (_) => 0);
  for (int i = 0; i < rcvData.length; i++) {
    temp[i] = int.parse(rcvData[i]);
  }

  stateFal2.count.amount			  = ((temp[0] & 0xff) << 24) + ((temp[1] & 0xff) << 16)
  + ((temp[2] & 0xff) << 8) + ((temp[3] & 0xff) << 0);
  stateFal2.count.bill10000		  = ((temp[4] & 0xff) << 8) + ((temp[5] & 0xff) << 0);
  stateFal2.count.bill5000		  = ((temp[6] & 0xff) << 8) + ((temp[7] & 0xff) << 0);
  stateFal2.count.bill2000		  = ((temp[8] & 0xff) << 8) + ((temp[9] & 0xff) << 0);
  stateFal2.count.bill1000		  = ((temp[10] & 0xff) << 8) + ((temp[11] & 0xff) << 0);
  stateFal2.count.coin500		    = ((temp[12] & 0xff) << 8) + ((temp[13] & 0xff) << 0);
  stateFal2.count.coin100		    = ((temp[14] & 0xff) << 8) + ((temp[15] & 0xff) << 0);
  stateFal2.count.coin50			  = ((temp[16] & 0xff) << 8) + ((temp[17] & 0xff) << 0);
  stateFal2.count.coin10			  = ((temp[18] & 0xff) << 8) + ((temp[19] & 0xff) << 0);
  stateFal2.count.coin5			    = ((temp[20] & 0xff) << 8) + ((temp[21] & 0xff) << 0);
  stateFal2.count.coin1			    = ((temp[22] & 0xff) << 8) + ((temp[23] & 0xff) << 0);
  stateFal2.count.billReject		= ((temp[24] & 0xff) << 8) + ((temp[25] & 0xff) << 0);
  stateFal2.count.coinReject		= ((temp[26] & 0xff) << 8) + ((temp[27] & 0xff) << 0);
  stateFal2.count.out1000Reject	= ((temp[28] & 0xff) << 8) + ((temp[29] & 0xff) << 0);
  stateFal2.count.out5000Reject	= ((temp[30] & 0xff) << 8) + ((temp[31] & 0xff) << 0);
  stateFal2.count.out10000Reject= ((temp[32] & 0xff) << 8) + ((temp[33] & 0xff) << 0);
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StSsGetAlwaysCount()
  /// * 機能概要      : 状態センスコマンド結果取得ライブラリ(変化データ)
  /// * 引数          : TprTID src
  /// *             		StateFal2 *stateFal2
  /// *		              uchar data
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static void ifFal2StSsGetAlwaysCount(TprTID src, StateFal2 stateFal2,
      List<String> rcvData) {

    List<int> temp = List.generate(rcvData.length, (_) => 0);
    for (int i = 0; i < rcvData.length; i++) {
      temp[i] = int.parse(rcvData[i]);
    }

  stateFal2.alwaysCin.amount		  = ((temp[0] & 0xff) << 24) + ((temp[1] & 0xff) << 16)
  + ((temp[2] & 0xff) << 8) + ((temp[3] & 0xff) << 0);
  stateFal2.alwaysCin.bill10000		= ((temp[4] & 0xff) << 8) + ((temp[5] & 0xff) << 0);
  stateFal2.alwaysCin.bill5000		= ((temp[6] & 0xff) << 8) + ((temp[7] & 0xff) << 0);
  stateFal2.alwaysCin.bill2000		= ((temp[8] & 0xff) << 8) + ((temp[9] & 0xff) << 0);
  stateFal2.alwaysCin.bill1000		= ((temp[10] & 0xff) << 8) + ((temp[11] & 0xff) << 0);
  stateFal2.alwaysCin.coin500		  = ((temp[12] & 0xff) << 8) + ((temp[13] & 0xff) << 0);
  stateFal2.alwaysCin.coin100		  = ((temp[14] & 0xff) << 8) + ((temp[15] & 0xff) << 0);
  stateFal2.alwaysCin.coin50		  = ((temp[16] & 0xff) << 8) + ((temp[17] & 0xff) << 0);
  stateFal2.alwaysCin.coin10		  = ((temp[18] & 0xff) << 8) + ((temp[19] & 0xff) << 0);
  stateFal2.alwaysCin.coin5		    = ((temp[20] & 0xff) << 8) + ((temp[21] & 0xff) << 0);
  stateFal2.alwaysCin.coin1		    = ((temp[22] & 0xff) << 8) + ((temp[23] & 0xff) << 0);
  stateFal2.alwaysCin.billReject	= ((temp[24] & 0xff) << 8) + ((temp[25] & 0xff) << 0);
  stateFal2.alwaysCin.coinReject  = ((temp[26] & 0xff) << 8) + ((temp[27] & 0xff) << 0);
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StSsGetAlwaysCount()
  /// * 機能概要      : 入出金口センサ、リジェクトエラーチェック
  /// * 引数          : TprTID src
  /// *             		StateFal2 *stateFal2
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static int ifFal2StatSenseGetInOutSensorChk(TprTID src, StateFal2 stateFal2) {
    String log = "";

    //貨幣残留チェック
    if (stateFal2.mediaExist.billInOut != 0) { //紙幣入出金口
      //エラーでない	投入口に紙幣をセットして入金開始しようとするとエラーになるから
      log = "ifFal2StatSenseGetInOutSensorChk:billInOut[${stateFal2.mediaExist.billInOut}]";
    }
    if (stateFal2.mediaExist.coinIn != 0) { //硬貨投入口
      //エラーでない	投入口に硬貨をセットして入金開始しようとするとエラーになるから
      log =
      "ifFal2StatSenseGetInOutSensorChk:coinIn[${stateFal2.mediaExist.coinIn}]";
    }
    if (stateFal2.mediaExist.coinOut != 0) { //硬貨出金口
      //エラーでない	出金時に残留があっても問題ない（釣銭機側で残留無し検知後に出金が正常動作）
      //貨幣取忘れ警告処理では直接センサ情報を見て対応している
      log = "ifFal2StatSenseGetInOutSensorChk:coinOut[${stateFal2.mediaExist.coinOut}]";
    }
    if (stateFal2.mediaExist.billRoute != 0) { //紙幣搬送路
      //エラーでない  これをエラー扱いにすると入金中エラーになる
      log = "ifFal2StatSenseGetInOutSensorChk:billRoute[${stateFal2.mediaExist.billRoute}]";
    }
    if (stateFal2.mediaExist.coinInRoute != 0) { //硬貨入金搬送路
      //エラーでない  これをエラー扱いにすると入金中エラーになる
      log = "ifFal2StatSenseGetInOutSensorChk:coinInRoute[${stateFal2.mediaExist.coinInRoute}]";
    }
    TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal, log);

    //硬貨リジェクトチェック
    if (stateFal2.unitStatus.coinReject != 0) {
      TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal,
          "ifFal2StatSenseGetInOutSensorChk:coin_reject[${stateFal2.unitStatus.coinReject}]");
      return (DlgConfirmMsgKind.MSG_TEXT126.dlgId); //硬貨リジェクト
    }

    return (Typ.OK);
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StatSenseGetUnitInfoChk()
  /// * 機能概要      : 状態センスレスポンスを解析し、適切なエラーへ振り分け
  /// * 引数          : TprTID src
  /// *             		StateFal2 *stateFal2
  /// *                 uchar   *rcvData
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static int ifFal2StatSenseGetUnitInfoChk(TprTID src, StateFal2 stateFal2,
    List<String>? deviceStat) {
    String log = "";
    int errNo = Typ.OK;

    errNo = ifFal2StSsGetErrChk(src, stateFal2, deviceStat);
    if (errNo != Typ.OK) {
      log = "ifFal2StatSenseGetUnitInfoChk:StSsGet_ErrChk errNo[$errNo]";
      TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal, log);
      return (errNo);
    }

    //ユニット外れチェック
    if (stateFal2.alwaysResp.unitOffInfo != 0) {
      log = "ifFal2StatSenseGetUnitInfoChk:unitOffInfo[${stateFal2.alwaysResp.unitOffInfo}]";
      TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal, log);
      return (DlgConfirmMsgKind.MSG_TEXT192.dlgId);
    }

    //ローカルモードチェック
    if (stateFal2.localMode != 0) { //01:鍵位置運用モード
      log = "ifFal2StatSenseGetUnitInfoChk:localMode[${stateFal2.localMode}]";
      TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal, log);
      return (DlgConfirmMsgKind.MSG_ACRACT.dlgId);
    }

    errNo = ifFal2StatSenseGetInOutSensorChk(src, stateFal2);
    if (errNo != Typ.OK) {
      return (errNo);
    }

    return (Typ.OK);
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StSsGetErrChk()
  /// * 機能概要      :
  /// * 引数          : TprTID src
  /// *             		StateFal2 *stateFal2
  /// *                 uchar   *rcvData
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static int ifFal2StSsGetErrChk(TprTID src, StateFal2 stateFal2,
      List<String>? deviceStatStr) {
    String log = "";
    int statData;
    int num;

    List<List<String>> chkList = [
      //1桁目が「1」の動作ステータス：運用中
      ["0x1000", "OK", "CinEnd"],
      ["0x1100", "MSG_ACRACT", "CinReset"],
      ["0x1210", "MSG_TAKE_MONEY", "-1"],
      ["0x1300", "MSG_ACRERROR", "-1"],
      //1桁目が「2」の動作ステータス：入金中
      ["0x2004", "MSG_TEXT192", "-1"],
      ["0x2104", "MSG_TEXT192", "-1"],
      ["0x2220", "OK", "CinWait"], //貨幣投入待ち
      ["0x2302", "OK", "CinAct"], //入金動作中
      ["0x2408", "MSG_ACRRJFULL", "-1"],
      ["0x2510", "MSG_TEXT127", "-1"],
      ["0x2608", "MSG_TEXT126", "-1"],
      ["0x2701", "OK", "-1"], //入金動作完了
      ["0x2800", "MSG_ACRERROR", "-1"],
      //1桁目が「3」の動作ステータス：出金中
      ["0x3002", "OK", "-1"],
      ["0x3110", "OK", "-1"], //硬貨溢れ抜き取り待ちでエラー扱いにすると釣取忘れチェックが止まってしまう
      ["0x3210", "MSG_TAKE_MONEY", "-1"],
      ["0x3310", "MSG_TAKE_MONEY", "-1"],
      ["0x3410", "OK", "-1"], //紙幣抜き取り待ちでエラー扱いにすると釣取忘れチェックが止まってしまう
      ["0x3508", "MSG_ACRRJFULL", "-1"],
      ["0x3604", "MSG_TEXT192", "-1"],
      ["0x3704", "MSG_TEXT192", "-1"],
      ["0x3801", "OK", "-1"], //出金動作完了
      ["0x3910", "MSG_BILLONTRAY", "-1"],
      //1桁目が「4」の動作ステータス：回収/自動回収中
      ["0x4002", "MSG_ACBACT", "-1"],
      ["0x4110", "MSG_TAKE_MONEY", "-1"],
      ["0x4210", "MSG_TAKE_MONEY", "-1"],
      ["0x4308", "MSG_TEXT174", "-1"],
      ["0x4408", "MSG_ACRRJFULL", "-1"],
      ["0x4504", "MSG_TEXT192", "-1"],
      ["0x4604", "MSG_TEXT192", "-1"],
      ["0x4740", "OK", "-1"], //中断キーによる中断中（要検討）
      ["0x4801", "OK", "-1"], //回収動作完了
      ["0x4082", "MSG_ACBACT", "-1"],
      ["0x4584", "MSG_TEXT192", "-1"],
      ["0x4684", "MSG_TEXT192", "-1"],
      ["0x4884", "OK", "-1"], //自動回収動作完了
      //1桁目が「5」の動作ステータス：自動精査中
      ["0x5002", "MSG_ACBACT", "-1"],
      ["0x5110", "MSG_TAKE_MONEY", "-1"],
      ["0x5208", "MSG_TAKE_MONEY", "-1"],
      ["0x5304", "MSG_TEXT192", "-1"],
      ["0x5404", "MSG_TEXT192", "-1"],
      ["0x5501", "OK", "-1"], //自動精査動作完了
      //1桁目が「A」の動作ステータス：両替（入金）中
      ["0xA004", "MSG_TEXT192", "-1"],
      ["0xA104", "MSG_TEXT192", "-1"],
      ["0xA220", "OK", "-1"], //貨幣投入待ち
      ["0xA302", "MSG_ACBACT", "-1"],
      ["0xA408", "MSG_ACRRJFULL", "-1"],
      ["0xA510", "MSG_TEXT127", "-1"],
      ["0xA608", "MSG_TEXT126", "-1"],
      ["0xA701", "OK", "-1"], //両替入金動作完了
      ["0xA800", "MSG_ACRERROR", "-1"],
      //1桁目が「B」の動作ステータス：両替（出金）中
      ["0xB002", "MSG_ACBACT", "-1"],
      ["0xB110", "MSG_TAKE_MONEY", "-1"],
      ["0xB210", "MSG_TAKE_MONEY", "-1"],
      ["0xB310", "MSG_TAKE_MONEY", "-1"],
      ["0xB410", "MSG_TAKE_MONEY", "-1"],
      ["0xB508", "MSG_ACRRJFULL", "-1"],
      ["0xB604", "MSG_TEXT192", "-1"],
      ["0xB704", "MSG_TEXT192", "-1"],
      ["0xB801", "OK", "-1"], //両替出金動作完了
      ["0xB910", "MSG_TAKE_MONEY", "-1"],
      ["-1", "-1", "-1"]
    ];
    int data = 0;
    int deviceStat = 1;
    int errNo = 2;

    statData = ((int.parse(stateFal2.alwaysResp.actStatus[0]) & 0xff) << 8) +
        ((int.parse(stateFal2.alwaysResp.actStatus[1]) & 0xff) << 0);

    log = "ifFal2StSsGetErrChk:actStatus[$statData]";
    TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal, log);

    // リストと合致するエラーを返す
    for (num = 0; int.parse(chkList[num][data]) != -1; num++) {
      if (statData == int.parse(chkList[num][data])) {
        if (deviceStatStr != null) {
          // 動作ステータスをセット
          deviceStatStr[0] = chkList[num][deviceStat];
        }
        return (int.parse(chkList[num][errNo]));
      }
    }

    log = "ifFal2StSsGetErrChk:actStatus[$statData] Error Nothing";
    TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.error, log);
    return (DlgConfirmMsgKind.MSG_ACRERROR.dlgId);
  }

  /// *-------------------------------------------------------------------------------
  /// * 関数名        : int ifFal2StSsGetChgDataInfo()
  /// * 機能概要      : 変化データ有無情報
  /// * 引数          : TprTID src
  /// *             		StateFal2 *stateFal2
  /// *                 uchar   *rcvData
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  ///                  エラーコード エラー内容に対応したコード番号
  /// *-------------------------------------------------------------------------------
  static bool ifFal2StSsGetChgDataInfo(TprTID tid, List<String> data,
      Fal2ChgInfo chgInfo) {
    int i, j;
    int bit;

    for (i = 0; i < 3; i++) {
      for (j = 0; j < 8; j++) {
        bit = 0;
        bit = (int.parse(data[i]) & (1 << j));
        if (bit > 0) {
          bit = 1;
        }

        if (i == 0) {
          switch (j) {
            case 0: chgInfo.statRejectBox = bit;    /* 紙幣リジェクト庫状態 */ break;
            case 1: chgInfo.statCashBox = bit;      /* 紙幣回収庫状態 */      break;
            case 2: chgInfo.statHolderC = bit;      /* 収納庫C状態 */         break;
            case 3: chgInfo.statHolderB = bit;      /* 収納庫B状態 */         break;
            case 4: chgInfo.statHolderA = bit;      /* 収納庫A状態 */         break;
            case 5: chgInfo.statBatteryAlarm = bit; /* バッテリーアラーム */   break;
            case 6: chgInfo.statSecurityInfo = bit; /* セキュリティー情報 */   break;
            case 7: chgInfo.statMediaExist = bit;   /* 媒体有無情報 */        break;
          }
        }
        else if (i == 1) {
          switch (j) {
            case 0: chgInfo.statCinMode = bit;    /* 入金モード */       break;
            case 1: chgInfo.statCoinReject = bit; /* 硬貨リジェクト枚数 */break;
            case 2: chgInfo.statCoin1Box = bit;   /* 1円庫状態 */       break;
            case 3: chgInfo.statCoin5Box = bit;   /* 5円庫状態 */       break;
            case 4: chgInfo.statCoin10Box = bit;  /* 10円庫状態 */      break;
            case 5: chgInfo.statCoin50Box = bit;  /* 50円庫状態 */      break;
            case 6: chgInfo.statCoin100Box = bit; /* 100円庫状態 */     break;
            case 7: chgInfo.statCoin500Box = bit; /* 500円庫状態 */     break;
          }
        }
        else {
          switch (j) {
            case 0:
            case 1:
            case 2:break;
            case 3: chgInfo.statAlwaysCin = bit;  /* 常時入金計数内容 */  break;
            case 4: chgInfo.statCountUp = bit;    /* 計数内容 */        break;
            case 5: chgInfo.statLocalMode = bit;  /* ローカルモード */   break;
            case 6: chgInfo.statHolderAmt = bit;  /* 収納庫在高状態 */   break;
            case 7: chgInfo.statSensorInfo = bit; /* センサ情報 */       break;
          }
        }
      }
    }
    return true;
  }
}
