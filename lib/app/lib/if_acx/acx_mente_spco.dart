/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/lib/if_acx.dart';
import 'package:flutter_pos/app/lib/if_acx/acx_coin.dart';

import '../../common/cmn_sysfunc.dart';
import '../../if/if_changer_isolate.dart';
import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import 'acx_com.dart';
import 'acx_spco.dart';

/// 関連tprxソース:acx_mente_spco.c
class AcxMenteSpco {
  // TODO:コンパイルSW
  //#ifndef PPSDVS
  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifRt300MenteSpecifyOut()
  /// * 機能概要      : Coin/Bill Changer Mentenance(Out of Sales) Change Out
  /// * 引数          : TprTID src
  /// *              : int mChange
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifRt300MenteSpecifyOut(TprTID src, int mChange) async {
    int errCode;
    List<String> sendBuf = List.generate(24, (_) => "");
    int len;

    List<String> data_10000 = [
      "\x30","\x30",/* 2000  */
      "\x30","\x30",/* dummy */
      "\x30","\x31",/* 5000  */
      "\x30","\x35",/* 1000  */
      "\x30","\x30",/*  500  */
      "\x30","\x30",/*  100  */
      "\x30","\x30",/*   50  */
      "\x30","\x30",/*   10  */
      "\x30","\x30",/*    5  */
      "\x30","\x30"]; /*    1  */

    List<String> data_5000 = [
      "\x30","\x30",/* 2000  */
      "\x30","\x30",/* dummy */
      "\x30","\x30",/* 5000  */
      "\x30","\x35",/* 1000  */
      "\x30","\x30",/*  500  */
      "\x30","\x30",/*  100  */
      "\x30","\x30",/*   50  */
      "\x30","\x30",/*   10  */
      "\x30","\x30",/*    5  */
      "\x30","\x30"]; /*    1  */

    List<String> data_2000 = [
      "\x30","\x30",/* 2000  */
      "\x30","\x30",/* dummy */
      "\x30","\x30",/* 5000  */
      "\x30","\x32",/* 1000  */
      "\x30","\x30",/*  500  */
      "\x30","\x30",/*  100  */
      "\x30","\x30",/*   50  */
      "\x30","\x30",/*   10  */
      "\x30","\x30",/*    5  */
      "\x30","\x30"]; /*    1  */

    List<String> data_1000 = [
      "\x30","\x30",/* 2000  */
      "\x30","\x30",/* dummy */
      "\x30","\x30",/* 5000  */
      "\x30","\x30",/* 1000  */
      "\x30","\x31",/*  500  */
      "\x30","\x35",/*  100  */
      "\x30","\x30",/*   50  */
      "\x30","\x30",/*   10  */
      "\x30","\x30",/*    5  */
      "\x30","\x30"]; /*    1  */

    List<String> data_500 = [
      "\x30","\x30",/* 2000  */
      "\x30","\x30",/* dummy */
      "\x30","\x30",/* 5000  */
      "\x30","\x30",/* 1000  */
      "\x30","\x30",/*  500  */
      "\x30","\x35",/*  100  */
      "\x30","\x30",/*   50  */
      "\x30","\x30",/*   10  */
      "\x30","\x30",/*    5  */
      "\x30","\x30"]; /*    1  */

    List<String> data_100 = [
      "\x30","\x30",/* 2000  */
      "\x30","\x30",/* dummy */
      "\x30","\x30",/* 5000  */
      "\x30","\x30",/* 1000  */
      "\x30","\x30",/*  500  */
      "\x30","\x30",/*  100  */
      "\x30","\x31",/*   50  */
      "\x30","\x35",/*   10  */
      "\x30","\x30",/*    5  */
      "\x30","\x30"]; /*    1  */

    List<String> data_50 = [
      "\x30","\x30",/* 2000  */
      "\x30","\x30",/* dummy */
      "\x30","\x30",/* 5000  */
      "\x30","\x30",/* 1000  */
      "\x30","\x30",/*  500  */
      "\x30","\x30",/*  100  */
      "\x30","\x30",/*   50  */
      "\x30","\x35",/*   10  */
      "\x30","\x30",/*    5  */
      "\x30","\x30"]; /*    1  */

    List<String> data_10 = [
      "\x30","\x30",/* 2000  */
      "\x30","\x30",/* dummy */
      "\x30","\x30",/* 5000  */
      "\x30","\x30",/* 1000  */
      "\x30","\x30",/*  500  */
      "\x30","\x30",/*  100  */
      "\x30","\x30",/*   50  */
      "\x30","\x30",/*   10  */
      "\x30","\x31",/*    5  */
      "\x30","\x35"]; /*    1  */

    List<String> data_5 = [
      "\x30","\x30",/* 2000  */
      "\x30","\x30",/* dummy */
      "\x30","\x30",/* 5000  */
      "\x30","\x30",/* 1000  */
      "\x30","\x30",/*  500  */
      "\x30","\x30",/*  100  */
      "\x30","\x30",/*   50  */
      "\x30","\x30",/*   10  */
      "\x30","\x30",/*    5  */
      "\x30","\x35"]; /*    1  */

    errCode = IfAcxDef.MSG_ACROK;
    // init:SendBuf
    sendBuf.fillRange(0, sendBuf.length, "\x00");

    //  Send Buffer set(Specify Coin Out Command)
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_MENTE_SPECOUT;
    sendBuf[2] = "\x31";
    sendBuf[3] = "\x34";

    switch (mChange) {
      case 10000:
        sendBuf.addAll(data_10000);
        break;
      case 5000:
        sendBuf.addAll(data_5000);
        break;
      case 2000:
        sendBuf.addAll(data_2000);
        break;
      case 1000:
        sendBuf.addAll(data_1000);
        break;
      case 500:
        sendBuf.addAll(data_500);
        break;
      case 100:
        sendBuf.addAll(data_100);
        break;
      case 50:
        sendBuf.addAll(data_50);
        break;
      case 10:
        sendBuf.addAll(data_10);
        break;
      case 5:
        sendBuf.addAll(data_5);
        break;
      default:
        errCode = IfAcxDef.MSG_INPUTERR;
        break;
    }

    if (errCode == IfAcxDef.MSG_ACROK) {
      len = 24;

      //     transmit a message
      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);
    }

    return errCode;
  }
  // #endif

  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxMenteSpecifyOut()
  /// * 機能概要      : Coin/Bill Changer Mentenance(Out of Sales) Change Out
  /// * 引数          : TprTID src
  /// *              : int mChange
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxMenteSpecifyOut(
      TprTID src, int changerFlg, int mChange) async {
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;

      TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal,
          "***** OUT : price[$mChange]");

      if (changerFlg == CoinChanger.ACR_COINBILL) /* Coin/Bill Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ACB_10:
            errCode = await AcxSpco.ifAcb10SpecifyOut(src, mChange);
            break;
          case CoinChanger.ACB_20:
          case CoinChanger.ACB_50_:
          case CoinChanger.ACB_200:
          case CoinChanger.ECS:
          case CoinChanger.ECS_777:
            errCode = await AcxSpco.ifAcb20SpecifyOut(src, mChange);
            break;
          case CoinChanger.SST1:
          case CoinChanger.FAL2:
            errCode = await AcxSpco.ifSst1SpecifyOut(src, mChange);
            break;
          case CoinChanger.RT_300:
            errCode = await ifRt300MenteSpecifyOut(src, mChange);
            break;
          default:
            errCode = IfAcxDef.MSG_ACRFLGERR;
            break;
        }
      } else if (changerFlg == CoinChanger.ACR_COINONLY) /* Coin Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ECS:
          case CoinChanger.ECS_777:
            errCode = await AcxSpco.ifAcb20SpecifyOut(src, mChange);
            break;
          default:
            errCode = await AcxSpco.ifAcrSpecifyOut(src, mChange);
            break;
        }
      } else /* changerFlg NG ! */ {
        errCode = IfAcxDef.MSG_ACRFLGERR;
      }

      return errCode;
      // #else
    } else {
      return IfAcxDef.MSG_ACROK;
      // #endif
    }
  }

  // TODO:コンパイルSW
  // #ifndef PPSDVS
  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifRt300MenteShtSpecifyOut()
  /// * 機能概要      : 枚数指定払出（ acb用 ）
  /// *                固定パターンではなく、金種毎に指定した枚数を払い出す。
  /// * 引数          : TprTID src
  /// *              : CBILLKIND cbillkind  各金種の出金枚数
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifRt300MenteShtSpecifyOut(
      TprTID src, CBillKind cBillKind) async {
    int errCode;
    List<String> sendBuf = List.generate(30, (_) => "");
    int len = 0;

    errCode = IfAcxDef.MSG_ACROK;

    //  Send Buffer set(Specify Coin Out Command)
    sendBuf[len++] = TprDefAsc.DC1;
    sendBuf[len++] = IfAcxDef.ACR_MENTE_SPECOUT;
    sendBuf[len++] = "\x31";
    sendBuf[len++] = "\x34";

    if ((cBillKind.bill5000 > 99) ||
        (cBillKind.bill2000 > 99) ||
        (cBillKind.bill1000 > 99) ||
        (cBillKind.coin500 > 99) ||
        (cBillKind.coin100 > 99) ||
        (cBillKind.coin50 > 99) ||
        (cBillKind.coin10 > 99) ||
        (cBillKind.coin5 > 99) ||
        (cBillKind.coin1 > 99)) {
      return DlgConfirmMsgKind.MSG_MAX_ACR_CHANGEAMT_OVER.dlgId;
    }

    sendBuf[len++] = ((cBillKind.bill2000 / 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.bill2000 % 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.bill10000 / 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.bill10000 % 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.bill5000 / 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.bill5000 % 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.bill1000 / 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.bill1000 % 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.coin500 / 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.coin500 % 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.coin100 / 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.coin100 % 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.coin50 / 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.coin50 % 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.coin10 / 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.coin10 % 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.coin5 / 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.coin5 % 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.coin1 / 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.coin1 % 10) + 0x30).toString();

    //     transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }
  // #endif

  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxMenteShtSpecifyOut()
  /// * 機能概要      : 枚数指定払出
  /// *                固定パターンではなく、金種毎に指定した枚数を払い出す。
  /// * 引数          : TprTID src
  ///                   ushort changerFlg   ACR_COINBILL 釣銭釣札機 / ACR_COINONLY 釣銭機
  ///                   CBILLKIND cBillKind  各金種の出金枚数
  /// * 戻り値        :  エラーコード エラー内容に対応したコード番号
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxMenteShtSpecifyOut(
      TprTID src, int changerFlg, CBillKind cBillKind) async {
    // #ifndef PPSDVS
    if (true) {
      int errCode = IfAcxDef.MSG_ACROK;

      TprLog().logAdd(IfChangerIsolate.taskId, LogLevelDefine.normal,
          "***** OUT : price[${AcxCom.ifAcxShtPriceData(cBillKind, AcxCalcType.ACX_CALC_ALL.index)}]");

      if (changerFlg == CoinChanger.ACR_COINBILL) /* Coin/Bill Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ACB_10:
            break;
          case CoinChanger.ACB_20:
          case CoinChanger.ACB_50_:
          case CoinChanger.ACB_200:
          case CoinChanger.ECS:
          case CoinChanger.ECS_777:
            errCode = await AcxSpco.ifAcb20ShtSpecifyOut(src, cBillKind);
            break;
          case CoinChanger.SST1:
          case CoinChanger.FAL2:
            errCode = await AcxSpco.ifSst1ShtSpecifyOut(src, cBillKind);
            break;
          case CoinChanger.RT_300:
            errCode = await ifRt300MenteShtSpecifyOut(src, cBillKind);
            break;
          default:
            errCode = IfAcxDef.MSG_ACRFLGERR;
            break;
        }
      } else if (changerFlg == CoinChanger.ACR_COINONLY) /* Coin Changer ? */ {
        switch (AcxCom.ifAcbSelect()) {
          case CoinChanger.ECS:
          case CoinChanger.ECS_777:
            errCode = await AcxSpco.ifAcb20ShtSpecifyOut(src, cBillKind);
            break;
          default:
            errCode = await AcxSpco.ifAcrShtSpecifyOut(src, cBillKind);
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
}
