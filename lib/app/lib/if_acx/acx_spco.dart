/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter_pos/app/inc/lib/if_acx.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_def_asc.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/sys/tpr_dlg.dart';
import 'acx_com.dart';

/// 関連tprxソース:acx_spco.c
class AcxSpco{
  ////*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb20SpecifyOut()
  /// * 機能概要      : Coin/Bill Changer Specify Coin Out
  /// * 引数          : TprTID src
  /// *               : int mChange
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcb20SpecifyOut(TprTID src, int mChange) async {
    int errCode;
    List<String> sendBuf = List.generate(24, (_) => "");
    int   len;

    List<String>  data_10000 = [
      "\x30","\x30",   /* 2000  */
      "\x30","\x30",   /* dummy */
      "\x30","\x31",   /* 5000  */
      "\x30","\x35",   /* 1000  */
      "\x30","\x30",   /*  500  */
      "\x30","\x30",   /*  100  */
      "\x30","\x30",   /*   50  */
      "\x30","\x30",   /*   10  */
      "\x30","\x30",   /*    5  */
      "\x30","\x30" ]; /*    1  */

    List<String>  data_5000 = [
      "\x30","\x30",   /* 2000  */
      "\x30","\x30",   /* dummy */
      "\x30","\x30",   /* 5000  */
      "\x30","\x35",   /* 1000  */
      "\x30","\x30",   /*  500  */
      "\x30","\x30",   /*  100  */
      "\x30","\x30",   /*   50  */
      "\x30","\x30",   /*   10  */
      "\x30","\x30",   /*    5  */
      "\x30","\x30" ]; /*    1  */

    List<String>  data_2000 = [
      "\x30","\x30",   /* 2000  */
      "\x30","\x30",   /* dummy */
      "\x30","\x30",   /* 5000  */
      "\x30","\x32",   /* 1000  */
      "\x30","\x30",   /*  500  */
      "\x30","\x30",   /*  100  */
      "\x30","\x30",   /*   50  */
      "\x30","\x30",   /*   10  */
      "\x30","\x30",   /*    5  */
      "\x30","\x30" ]; /*    1  */

    List<String>  data_1000 = [
      "\x30","\x30",   /* 2000  */
      "\x30","\x30",   /* dummy */
      "\x30","\x30",   /* 5000  */
      "\x30","\x30",   /* 1000  */
      "\x30","\x31",   /*  500  */
      "\x30","\x35",   /*  100  */
      "\x30","\x30",   /*   50  */
      "\x30","\x30",   /*   10  */
      "\x30","\x30",   /*    5  */
      "\x30","\x30" ]; /*    1  */

    List<String>  data_500 = [
      "\x30","\x30",   /* 2000  */
      "\x30","\x30",   /* dummy */
      "\x30","\x30",   /* 5000  */
      "\x30","\x30",   /* 1000  */
      "\x30","\x30",   /*  500  */
      "\x30","\x35",   /*  100  */
      "\x30","\x30",   /*   50  */
      "\x30","\x30",   /*   10  */
      "\x30","\x30",   /*    5  */
      "\x30","\x30" ]; /*    1  */


    List<String>  data_100 = [
      "\x30","\x30",   /* 2000  */
      "\x30","\x30",   /* dummy */
      "\x30","\x30",   /* 5000  */
      "\x30","\x30",   /* 1000  */
      "\x30","\x30",   /*  500  */
      "\x30","\x30",   /*  100  */
      "\x30","\x31",   /*   50  */
      "\x30","\x35",   /*   10  */
      "\x30","\x30",   /*    5  */
      "\x30","\x30" ]; /*    1  */

    List<String>  data_50 = [
      "\x30","\x30",   /* 2000  */
      "\x30","\x30",   /* dummy */
      "\x30","\x30",   /* 5000  */
      "\x30","\x30",   /* 1000  */
      "\x30","\x30",   /*  500  */
      "\x30","\x30",   /*  100  */
      "\x30","\x30",   /*   50  */
      "\x30","\x35",   /*   10  */
      "\x30","\x30",   /*    5  */
      "\x30","\x30" ]; /*    1  */

    List<String>  data_10 = [
      "\x30","\x30",   /* 2000  */
      "\x30","\x30",   /* dummy */
      "\x30","\x30",   /* 5000  */
      "\x30","\x30",   /* 1000  */
      "\x30","\x30",   /*  500  */
      "\x30","\x30",   /*  100  */
      "\x30","\x30",   /*   50  */
      "\x30","\x30",   /*   10  */
      "\x30","\x31",   /*    5  */
      "\x30","\x35" ]; /*    1  */

    List<String>  data_5 = [
      "\x30","\x30",   /* 2000  */
      "\x30","\x30",   /* dummy */
      "\x30","\x30",   /* 5000  */
      "\x30","\x30",   /* 1000  */
      "\x30","\x30",   /*  500  */
      "\x30","\x30",   /*  100  */
      "\x30","\x30",   /*   50  */
      "\x30","\x30",   /*   10  */
      "\x30","\x30",   /*    5  */
      "\x30","\x35" ]; /*    1  */

    errCode = IfAcxDef.MSG_ACROK;
    // init:SendBuf
    sendBuf.fillRange(0, sendBuf.length, "\x00");

    //  Send Buffer set(Specify Coin Out Command)
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = "\x35";
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

    if( errCode == IfAcxDef.MSG_ACROK ){
      len = 24;

      //     transmit a message
      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    }

    return errCode;
  }

  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb10SpecifyOut()
  /// * 機能概要      : Coin/Bill Changer Specify Coin Out
  /// * 引数          : TprTID src
  /// *               : int mChange
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  /// *-------------------------------------------------------------------------------
  static Future<int> ifAcb10SpecifyOut( TprTID src, int mChange ) async {
    int errCode;
    List<String> sendBuf = List.generate(26, (_) => "");
    int   len;
/*                             dummy  ,10000yen , 5000yen           */
/*                            2000yen , 1000yen ,  500yen ,  100yen */
/*                              50yen ,   10yen ,    5yen ,    1yen */

    List<String> data_10000 = [ "\x30","\x30","\x30","\x30","\x30","\x31"
      ,"\x30","\x30","\x30","\x35","\x30","\x30","\x30","\x30"
      ,"\x30","\x30","\x30","\x30","\x30","\x30","\x30","\x30" ];

    List<String> data_5000 = [ "\x30","\x30","\x30","\x30","\x30","\x30"
      ,"\x30","\x30","\x30","\x35","\x30","\x30","\x30","\x30"
      ,"\x30","\x30","\x30","\x30","\x30","\x30","\x30","\x30" ];

    List<String> data_2000 = [ "\x30","\x30","\x30","\x30","\x30","\x30"
      ,"\x30","\x30","\x30","\x32","\x30","\x30","\x30","\x30"
      ,"\x30","\x30","\x30","\x30","\x30","\x30","\x30","\x30" ];

    List<String> data_1000 = [ "\x30","\x30","\x30","\x30","\x30","\x30"
      ,"\x30","\x30","\x30","\x30","\x30","\x31","\x30","\x35"
      ,"\x30","\x30","\x30","\x30","\x30","\x30","\x30","\x30" ];

    List<String> data_500 = [ "\x30","\x30","\x30","\x30","\x30","\x30"
      ,"\x30","\x30","\x30","\x30","\x30","\x30","\x30","\x35"
      ,"\x30","\x30","\x30","\x30","\x30","\x30","\x30","\x30" ];

    List<String> data_100 = [ "\x30","\x30","\x30","\x30","\x30","\x30"
      ,"\x30","\x30","\x30","\x30","\x30","\x30","\x30","\x30"
      ,"\x30","\x31","\x30","\x35","\x30","\x30","\x30","\x30" ];

    List<String> data_50 = [ "\x30","\x30","\x30","\x30","\x30","\x30"
      ,"\x30","\x30","\x30","\x30","\x30","\x30","\x30","\x30"
      ,"\x30","\x30","\x30","\x35","\x30","\x30","\x30","\x30" ];

    List<String> data_10 = [ "\x30","\x30","\x30","\x30","\x30","\x30"
      ,"\x30","\x30","\x30","\x30","\x30","\x30","\x30","\x30"
      ,"\x30","\x30","\x30","\x30","\x30","\x31","\x30","\x35" ];

    List<String> data_5 = [ "\x30","\x30","\x30","\x30","\x30","\x30"
      ,"\x30","\x30","\x30","\x30","\x30","\x30","\x30","\x30"
      ,"\x30","\x30","\x30","\x30","\x30","\x30","\x30","\x35" ];

    errCode = IfAcxDef.MSG_ACROK;
    // init:SendBuf
    sendBuf.fillRange(0, sendBuf.length, "\x00");

    //  Send Buffer set(Specify Coin Out Command)
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = "\x35";
    sendBuf[2] = "\x31";
    sendBuf[3] = "\x36";

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
      len = 26;

      //     transmit a message                         */
      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);
    }

    return errCode;
  }

  ////*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcrSpecifyOut()
  /// * 機能概要      : Coin/Bill Changer Specify Coin Out
  /// * 引数          : TprTID src
  /// *               : int mChange
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcrSpecifyOut(TprTID src, int mChange) async {
    int errCode;
    List<String> sendBuf = List.generate(16, (_) => "");
    int   len;
/*                            500yen ,  100yen ,  50yen  ,  10yen     */
/*                         ,   5yen  ,    1yen                        */
    List<String> data_1000 = [ "\x30","\x31","\x30","\x35","\x30","\x30","\x30","\x30"
      ,"\x30","\x30","\x30","\x30" ];

    List<String> data_500  = [ "\x30","\x30","\x30","\x35","\x30","\x30","\x30","\x30"
      ,"\x30","\x30","\x30","\x30" ];

    List<String> data_100  = [ "\x30","\x30","\x30","\x30","\x30","\x31","\x30","\x35"
      ,"\x30","\x30","\x30","\x30" ];

    List<String> data_50   = [ "\x30","\x30","\x30","\x30","\x30","\x30","\x30","\x35"
      ,"\x30","\x30","\x30","\x30" ];

    List<String> data_10   = [ "\x30","\x30","\x30","\x30","\x30","\x30","\x30","\x30"
      ,"\x30","\x31","\x30","\x35" ];

    List<String> data_5    = [ "\x30","\x30","\x30","\x30","\x30","\x30","\x30","\x30"
      ,"\x30","\x30","\x30","\x35" ];


    errCode = IfAcxDef.MSG_ACROK;

/*  Send Buffer set(Specify Coin Out Command)     */
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_SPECOUT;
    sendBuf[2] = "\x30";
    sendBuf[3] = "\x3C";

    switch (mChange) {
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

    if( errCode == IfAcxDef.MSG_ACROK ){
      len =16;

      //     transmit a message
      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    }

    return errCode;
  }
    
  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifSst1SpecifyOut()
  /// * 機能概要      : Coin/Bill Changer Specify Coin Out
  /// * 引数          : TprTID src
  /// *               : int mChange
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  /// *-------------------------------------------------------------------------------
  static Future<int> ifSst1SpecifyOut(TprTID src, int mChange) async {
    int errCode;
    List<String> sendBuf = List.generate(34, (_) => "");
    int len;

    List<String> data_10000 = [
      "\x30","\x30","\x30",   /* dummy */
      "\x30","\x30","\x30",   /* dummy */
      "\x30","\x30","\x31",   /* 5000  */
      "\x30","\x30","\x35",   /* 1000  */
      "\x30","\x30","\x30",   /*  500  */
      "\x30","\x30","\x30",   /*  100  */
      "\x30","\x30","\x30",   /*   50  */
      "\x30","\x30","\x30",   /*   10  */
      "\x30","\x30","\x30",   /*    5  */
      "\x30","\x30","\x30" ]; /*    1  */

    List<String> data_5000 = [
      "\x30","\x30","\x30",   /* dummy */
      "\x30","\x30","\x30",   /* dummy */
      "\x30","\x30","\x30",   /* 5000  */
      "\x30","\x30","\x35",   /* 1000  */
      "\x30","\x30","\x30",   /*  500  */
      "\x30","\x30","\x30",   /*  100  */
      "\x30","\x30","\x30",   /*   50  */
      "\x30","\x30","\x30",   /*   10  */
      "\x30","\x30","\x30",   /*    5  */
      "\x30","\x30","\x30" ]; /*    1  */

    List<String> data_2000 = [
      "\x30","\x30","\x30",   /* dummy */
      "\x30","\x30","\x30",   /* dummy */
      "\x30","\x30","\x30",   /* 5000  */
      "\x30","\x30","\x32",   /* 1000  */
      "\x30","\x30","\x30",   /*  500  */
      "\x30","\x30","\x30",   /*  100  */
      "\x30","\x30","\x30",   /*   50  */
      "\x30","\x30","\x30",   /*   10  */
      "\x30","\x30","\x30",   /*    5  */
      "\x30","\x30","\x30" ]; /*    1  */

    List<String> data_1000 = [
      "\x30","\x30","\x30",   /* dummy */
      "\x30","\x30","\x30",   /* dummy */
      "\x30","\x30","\x30",   /* 5000  */
      "\x30","\x30","\x30",   /* 1000  */
      "\x30","\x30","\x31",   /*  500  */
      "\x30","\x30","\x35",   /*  100  */
      "\x30","\x30","\x30",   /*   50  */
      "\x30","\x30","\x30",   /*   10  */
      "\x30","\x30","\x30",   /*    5  */
      "\x30","\x30","\x30" ]; /*    1  */

    List<String> data_500 = [
      "\x30","\x30","\x30",   /* dummy */
      "\x30","\x30","\x30",   /* dummy */
      "\x30","\x30","\x30",   /* 5000  */
      "\x30","\x30","\x30",   /* 1000  */
      "\x30","\x30","\x30",   /*  500  */
      "\x30","\x30","\x35",   /*  100  */
      "\x30","\x30","\x30",   /*   50  */
      "\x30","\x30","\x30",   /*   10  */
      "\x30","\x30","\x30",   /*    5  */
      "\x30","\x30","\x30" ]; /*    1  */

    List<String> data_100 = [
      "\x30","\x30","\x30",   /* dummy */
      "\x30","\x30","\x30",   /* dummy */
      "\x30","\x30","\x30",   /* 5000  */
      "\x30","\x30","\x30",   /* 1000  */
      "\x30","\x30","\x30",   /*  500  */
      "\x30","\x30","\x30",   /*  100  */
      "\x30","\x30","\x31",   /*   50  */
      "\x30","\x30","\x35",   /*   10  */
      "\x30","\x30","\x30",   /*    5  */
      "\x30","\x30","\x30" ]; /*    1  */

    List<String> data_50 = [
      "\x30","\x30","\x30",   /* dummy */
      "\x30","\x30","\x30",   /* dummy */
      "\x30","\x30","\x30",   /* 5000  */
      "\x30","\x30","\x30",   /* 1000  */
      "\x30","\x30","\x30",   /*  500  */
      "\x30","\x30","\x30",   /*  100  */
      "\x30","\x30","\x30",   /*   50  */
      "\x30","\x30","\x35",   /*   10  */
      "\x30","\x30","\x30",   /*    5  */
      "\x30","\x30","\x30" ]; /*    1  */

    List<String> data_10 = [
      "\x30","\x30","\x30",   /* dummy */
      "\x30","\x30","\x30",   /* dummy */
      "\x30","\x30","\x30",   /* 5000  */
      "\x30","\x30","\x30",   /* 1000  */
      "\x30","\x30","\x30",   /*  500  */
      "\x30","\x30","\x30",   /*  100  */
      "\x30","\x30","\x30",   /*   50  */
      "\x30","\x30","\x30",   /*   10  */
      "\x30","\x30","\x31",   /*    5  */
      "\x30","\x30","\x35" ]; /*    1  */

    List<String> data_5 = [
      "\x30","\x30","\x30",   /* dummy */
      "\x30","\x30","\x30",   /* dummy */
      "\x30","\x30","\x30",   /* 5000  */
      "\x30","\x30","\x30",   /* 1000  */
      "\x30","\x30","\x30",   /*  500  */
      "\x30","\x30","\x30",   /*  100  */
      "\x30","\x30","\x30",   /*   50  */
      "\x30","\x30","\x30",   /*   10  */
      "\x30","\x30","\x30",   /*    5  */
      "\x30","\x30","\x35" ]; /*    1  */

    errCode = IfAcxDef.MSG_ACROK;
    // init:SendBuf
    sendBuf.fillRange(0, sendBuf.length, "\x00");

    //  Send Buffer set(Specify Coin Out Command)
    sendBuf[0] = TprDefAsc.DC1;
    sendBuf[1] = IfAcxDef.ACR_SPECOUT;
    sendBuf[2] = "\x31";
    sendBuf[3] = "\x3E";

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
      len = 34;

      //     transmit a message
      errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);
    }

    return errCode;
  }
////*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxSpecifyOut()
  /// * 機能概要      : Coin/Bill Changer & Coin Changer Specify Coin Out
  /// * 引数          : TprTID src
  /// *               : int changerFlg  ACR_COINBILL(Coin/Bill Changer) or ACR_COINONLY(Coin Changer)
  /// *               : int mChange
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxSpecifyOut(TprTID src, int changerFlg, int mChange) async {
    int  errCode = IfAcxDef.MSG_ACROK;

    TprLog().logAdd(0, LogLevelDefine.normal, "***** OUT : price[$mChange]");

    if(changerFlg == CoinChanger.ACR_COINBILL)      /* Coin/Bill Changer ? */
    {
        switch(AcxCom.ifAcbSelect())
        {
            case CoinChanger.RT_300:
            case CoinChanger.ECS_777:
                errCode = await ifAcb20SpecifyOut( src, mChange );
                break;
            default:
                errCode = IfAcxDef.MSG_ACRFLGERR;
                break;
        }
    }
    else if(changerFlg == CoinChanger.ACR_COINONLY) /* Coin Changer ? */
    {
        switch(AcxCom.ifAcbSelect())
        {
            case CoinChanger.RT_300:
                errCode = await ifAcrSpecifyOut( src, mChange );
                break;
            case CoinChanger.ECS_777:
                errCode = await ifAcb20SpecifyOut( src, mChange );
                break;
            default:
                errCode = IfAcxDef.MSG_ACRFLGERR;
                break;
        }
    }
    else                                 /* Changer_flg NG ! */
    {
        errCode = IfAcxDef.MSG_ACRFLGERR;
    }

    return errCode;
  }

  ////*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcb20ShtSpecifyOut()
  /// * 機能概要      : 枚数指定払出（ acb用 ）
  /// *               : 固定パターンではなく、金種毎に指定した枚数を払い出す。
  /// * 引数          : TprTID src
  /// *               : CBILLKIND cbillkind  各金種の出金枚数
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcb20ShtSpecifyOut(TprTID src, CBillKind cbillkind) async {
    int  errCode = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(30, (_) => ""); /* device data */
    int   len = 0;

    /*  Send Buffer set(Specify Coin Out Command)     */
    sendBuf[len++] = TprDefAsc.DC1;
    sendBuf[len++] = IfAcxDef.ACR_SPECOUT;
    sendBuf[len++] = '\x31';
    sendBuf[len++] = '\x34';

    if( (cbillkind.bill5000 > 99 ) ||
        (cbillkind.bill2000 > 99 ) ||
        (cbillkind.bill1000 > 99 ) ||
        (cbillkind.coin500 > 99 ) ||
        (cbillkind.coin100 > 99 ) ||
        (cbillkind.coin50 > 99 ) ||
        (cbillkind.coin10 > 99 ) ||
        (cbillkind.coin5 > 99 ) ||
        (cbillkind.coin1 > 99 ) ) {
        return DlgConfirmMsgKind.MSG_MAX_ACR_CHANGEAMT_OVER.dlgId;
    }
    
    sendBuf[len++] = (cbillkind.bill2000 ~/ 10).toString();
    sendBuf[len++] = (cbillkind.bill2000 % 10).toString();
    sendBuf[len++] = (cbillkind.bill10000 ~/ 10).toString();
    sendBuf[len++] = (cbillkind.bill10000 % 10).toString();
    sendBuf[len++] = (cbillkind.bill5000 ~/ 10).toString();
    sendBuf[len++] = (cbillkind.bill5000 % 10).toString();
    sendBuf[len++] = (cbillkind.bill1000 ~/ 10).toString();
    sendBuf[len++] = (cbillkind.bill1000 % 10).toString();
    sendBuf[len++] = (cbillkind.coin500 ~/ 10).toString();
    sendBuf[len++] = (cbillkind.coin500 % 10).toString();
    sendBuf[len++] = (cbillkind.coin100 ~/ 10).toString();
    sendBuf[len++] = (cbillkind.coin100 % 10).toString();
    sendBuf[len++] = (cbillkind.coin50 ~/ 10).toString();
    sendBuf[len++] = (cbillkind.coin50 % 10).toString();
    sendBuf[len++] = (cbillkind.coin10 ~/ 10).toString();
    sendBuf[len++] = (cbillkind.coin10 % 10).toString();
    sendBuf[len++] = (cbillkind.coin5 ~/ 10).toString();
    sendBuf[len++] = (cbillkind.coin5 % 10).toString();
    sendBuf[len++] = (cbillkind.coin1 ~/ 10).toString();
    sendBuf[len++] = (cbillkind.coin1 % 10).toString();

    /*  transmit a message                           */
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  ////*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcrShtSpecifyOut()
  /// * 機能概要      : 枚数指定払出（ acr用 ）
  /// *               : 固定パターンではなく、金種毎に指定した枚数を払い出す。
  /// * 引数          : TprTID src
  /// *               : CBILLKIND cbillkind  各金種の出金枚数
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcrShtSpecifyOut(TprTID src, CBillKind cbillkind) async {
    int  errCode = IfAcxDef.MSG_ACROK;
    List<String> sendBuf = List.generate(20, (_) => ""); /* device data */
    int   len = 0;
    
    /*  Send Buffer set(Specify Coin Out Command)     */
    sendBuf[len++] = TprDefAsc.DC1;
    sendBuf[len++] = IfAcxDef.ACR_SPECOUT;
    sendBuf[len++] = '\x30';
    sendBuf[len++] = '\x3C';

    if( (cbillkind.coin500 > 99 ) ||
        (cbillkind.coin100 > 99 ) ||
        (cbillkind.coin50 > 99 ) ||
        (cbillkind.coin10 > 99 ) ||
        (cbillkind.coin5 > 99 ) ||
        (cbillkind.coin1 > 99 ) ) {
        return DlgConfirmMsgKind.MSG_MAX_ACR_CHANGEAMT_OVER.dlgId;
    }
    
    sendBuf[len++] = (cbillkind.coin500 ~/ 10).toString();
    sendBuf[len++] = (cbillkind.coin500 % 10).toString();
    sendBuf[len++] = (cbillkind.coin100 ~/ 10).toString();
    sendBuf[len++] = (cbillkind.coin100 % 10).toString();
    sendBuf[len++] = (cbillkind.coin50 ~/ 10).toString();
    sendBuf[len++] = (cbillkind.coin50 % 10).toString();
    sendBuf[len++] = (cbillkind.coin10 ~/ 10).toString();
    sendBuf[len++] = (cbillkind.coin10 % 10).toString();
    sendBuf[len++] = (cbillkind.coin5 ~/ 10).toString();
    sendBuf[len++] = (cbillkind.coin5 % 10).toString();
    sendBuf[len++] = (cbillkind.coin1 ~/ 10).toString();
    sendBuf[len++] = (cbillkind.coin1 % 10).toString();

    /* transmit a message                         */
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);
       
    return errCode;
  }

  ///*--------------------------------------------------------------------------------
  /// * 関数名        : int ifSst1ShtSpecifyOut()
  /// * 機能概要      : 枚数指定払出
  /// *               : 固定パターンではなく、金種毎に指定した枚数を払い出す。
  /// * 引数          : TprTID src
  /// *                Argument : TPRTID src
  /// *                CBILLKIND cbillkind  各金種の出金枚数
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  /// *--------------------------------------------------------------------------------
  static Future<int> ifSst1ShtSpecifyOut( TprTID src, CBillKind cBillKind) async {
    int errCode;
    List<String> sendBuf = List.generate(34, (_) => "");
    int   len = 0;

    errCode = IfAcxDef.MSG_ACROK;

/*  Send Buffer set(Specify Coin Out Command)     */
    sendBuf[len++] = TprDefAsc.DC1;
    sendBuf[len++] = IfAcxDef.ACR_SPECOUT;
    sendBuf[len++] = "\x31";
    sendBuf[len++] = "\x3E";

    if( (cBillKind.bill5000 > 20 ) ||
        (cBillKind.bill2000 > 0 ) ||
        (cBillKind.bill1000 > 20 ) ||
        (cBillKind.coin500 > 99 ) ||
        (cBillKind.coin100 > 99 ) ||
        (cBillKind.coin50 > 99 ) ||
        (cBillKind.coin10 > 99 ) ||
        (cBillKind.coin5 > 99 ) ||
        (cBillKind.coin1 > 99 ) ) {
      return DlgConfirmMsgKind.MSG_MAX_ACR_CHANGEAMT_OVER.dlgId;
    }

    sendBuf[len++] = "\x30";
    sendBuf[len++] = "\x30";
    sendBuf[len++] = "\x30";
    sendBuf[len++] = "\x30";
    sendBuf[len++] = "\x30";
    sendBuf[len++] = "\x30";
    sendBuf[len++] = ((cBillKind.bill5000 / 100) + 0x30).toString();
    sendBuf[len++] = (((cBillKind.bill5000 % 100) / 10) + 0x30).toString();
    sendBuf[len++] = (((cBillKind.bill5000 % 100) % 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.bill1000 / 100) + 0x30).toString();
    sendBuf[len++] = (((cBillKind.bill1000 % 100) / 10) + 0x30).toString();
    sendBuf[len++] = (((cBillKind.bill1000 % 100) % 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.coin500 / 100) + 0x30).toString();
    sendBuf[len++] = (((cBillKind.coin500 % 100) / 10) + 0x30).toString();
    sendBuf[len++] = (((cBillKind.coin500 % 100) % 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.coin100 / 100) + 0x30).toString();
    sendBuf[len++] = (((cBillKind.coin100 % 100) / 10) + 0x30).toString();
    sendBuf[len++] = (((cBillKind.coin100 % 100) % 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.coin50 / 100) + 0x30).toString();
    sendBuf[len++] = (((cBillKind.coin50 % 100) / 10) + 0x30).toString();
    sendBuf[len++] = (((cBillKind.coin50 % 100) % 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.coin10 / 100) + 0x30).toString();
    sendBuf[len++] = (((cBillKind.coin10 % 100) / 10) + 0x30).toString();
    sendBuf[len++] = (((cBillKind.coin10 % 100) % 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.coin5 / 100) + 0x30).toString();
    sendBuf[len++] = (((cBillKind.coin5 % 100) / 10) + 0x30).toString();
    sendBuf[len++] = (((cBillKind.coin5 % 100) % 10) + 0x30).toString();
    sendBuf[len++] = ((cBillKind.coin1 / 100) + 0x30).toString();
    sendBuf[len++] = (((cBillKind.coin1 % 100) / 10) + 0x30).toString();
    sendBuf[len++] = (((cBillKind.coin1 % 100) % 10) + 0x30).toString();

    //     transmit a message
    errCode = await AcxCom.ifAcxTransmit(src, sendBuf, len);

    return errCode;
  }

  ////*--------------------------------------------------------------------------------
  /// * 関数名        : int ifAcxShtSpecifyOut()
  /// * 機能概要      : 枚数指定払出
  /// *               : 固定パターンではなく、金種毎に指定した枚数を払い出す。
  /// * 引数          : TprTID src
  /// *               : int changerFlg  ACR_COINBILL 釣銭釣札機 / ACR_COINONLY 釣銭機
  /// *               : CBILLKIND cbillkind  各金種の出金枚数
  /// * 戻り値        : 0(MSG_ACROK) 正常終了
  /// *--------------------------------------------------------------------------------
  static Future<int> ifAcxShtSpecifyOut(TprTID src, int changerFlg, CBillKind cbillkind) async {
    int  errCode = IfAcxDef.MSG_ACROK;

    if(changerFlg == CoinChanger.ACR_COINBILL)      /* Coin/Bill Changer ? */
    {
        switch(AcxCom.ifAcbSelect())
        {
            case CoinChanger.RT_300:
            case CoinChanger.ECS_777:
                errCode = await ifAcb20ShtSpecifyOut( src, cbillkind );
                break;
            default:
                errCode = IfAcxDef.MSG_ACRFLGERR;
                break;
        }
    }
    else if(changerFlg == CoinChanger.ACR_COINONLY) /* Coin Changer ? */
    {
        switch(AcxCom.ifAcbSelect())
        {
            case CoinChanger.RT_300:
                errCode = await ifAcrShtSpecifyOut( src, cbillkind );
                break;
            case CoinChanger.ECS_777:
                errCode = await ifAcb20ShtSpecifyOut( src, cbillkind );
                break;
            default:
                errCode = IfAcxDef.MSG_ACRFLGERR;
                break;
        }
    }
    else                                 /* Changer_flg NG ! */
    {
        errCode = IfAcxDef.MSG_ACRFLGERR;
    }

    return errCode;
  }
}
