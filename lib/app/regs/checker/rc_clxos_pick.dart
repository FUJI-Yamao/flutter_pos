/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../../clxos/calc_api.dart';
import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../common/cmn_sysfunc.dart';
import 'rc_clxos.dart';
import 'rc_clxos_payment.dart';
import 'rcky_pick.dart';

/// クラウドPOSを利用する場合の売上回収処理の関連のクラス.
class RcClxosPick{
  /// frcSelectFlg 金種別登録を「1:する/しない」
  static Future<CalcResultPay> rcPick(RxCommonBuf pCom, int frcSelectFlg) async {
    CalcRequestPick para = CalcRequestPick(compCd: pCom.dbRegCtrl.compCd, streCd: pCom.dbRegCtrl.streCd, macNo: pCom.dbRegCtrl.macNo);
    RegsMem regsMem = SystemFunc.readRegsMem();
    int i = 0;

    para.inoutInfo = InoutInfo();
    if(frcSelectFlg == 1) {
      // 金種別登録を「する」
      para.inoutInfo?.sht10000     = regsMem.tTtllog.t105100Sts.mny10000Sht;
      para.inoutInfo?.sht05000     = regsMem.tTtllog.t105100Sts.mny5000Sht;
      para.inoutInfo?.sht02000     = regsMem.tTtllog.t105100Sts.mny2000Sht;
      para.inoutInfo?.sht01000     = regsMem.tTtllog.t105100Sts.mny1000Sht;
      para.inoutInfo?.sht00500     = regsMem.tTtllog.t105100Sts.mny500Sht;
      para.inoutInfo?.sht00100     = regsMem.tTtllog.t105100Sts.mny100Sht;
      para.inoutInfo?.sht00050     = regsMem.tTtllog.t105100Sts.mny50Sht;
      para.inoutInfo?.sht00010     = regsMem.tTtllog.t105100Sts.mny10Sht;
      para.inoutInfo?.sht00005     = regsMem.tTtllog.t105100Sts.mny5Sht;
      para.inoutInfo?.sht00001     = regsMem.tTtllog.t105100Sts.mny1Sht;

      for (i = 0; i < AmtKind.amtMax.index; i++)
      {
        if((regsMem.tTtllog.t100200[i].kyCd != 0) &&
           (regsMem.tTtllog.t100200[i].kyCd != FuncKey.KY_CASH.keyId)) {
          para.payList.add(PickPayData(
             code:       regsMem.tTtllog.t100200[i].kyCd,
             pickAmount: regsMem.tTtllog.t100200[i].drwAmt));
        }
      }
    } else {
      // 金種別登録を「しない」
      // 一括入力金額（円）
      para.inoutInfo?.amtTotal     = regsMem.tTtllog.t105100Sts.chgInoutAmt;
    }
    // 釣機収納庫枚数
    para.inoutInfo?.stockSht10000     = regsMem.tTtllog.t100600.acb10000Sht;
    para.inoutInfo?.stockSht05000     = regsMem.tTtllog.t100600.acb5000Sht;
    para.inoutInfo?.stockSht02000     = regsMem.tTtllog.t100600.acb2000Sht;
    para.inoutInfo?.stockSht01000     = regsMem.tTtllog.t100600.acb1000Sht;
    para.inoutInfo?.stockSht00500     = regsMem.tTtllog.t100600.acr500Sht;
    para.inoutInfo?.stockSht00100     = regsMem.tTtllog.t100600.acr100Sht;
    para.inoutInfo?.stockSht00050     = regsMem.tTtllog.t100600.acr50Sht;
    para.inoutInfo?.stockSht00010     = regsMem.tTtllog.t100600.acr10Sht;
    para.inoutInfo?.stockSht00005     = regsMem.tTtllog.t100600.acr5Sht;
    para.inoutInfo?.stockSht00001     = regsMem.tTtllog.t100600.acr1Sht;
    // 釣機金庫枚数
    para.inoutInfo?.stockPolSht10000  = regsMem.tTtllog.t100600.acb10000PolSht;
    para.inoutInfo?.stockPolSht05000  = regsMem.tTtllog.t100600.acb5000PolSht;
    para.inoutInfo?.stockPolSht02000  = regsMem.tTtllog.t100600.acb2000PolSht;
    para.inoutInfo?.stockPolSht01000  = regsMem.tTtllog.t100600.acb1000PolSht;
    para.inoutInfo?.stockPolSht00500  = regsMem.tTtllog.t100600.acr500PolSht;
    para.inoutInfo?.stockPolSht00100  = regsMem.tTtllog.t100600.acr100PolSht;
    para.inoutInfo?.stockPolSht00050  = regsMem.tTtllog.t100600.acr50PolSht;
    para.inoutInfo?.stockPolSht00010  = regsMem.tTtllog.t100600.acr10PolSht;
    para.inoutInfo?.stockPolSht00005  = regsMem.tTtllog.t100600.acr5PolSht;
    para.inoutInfo?.stockPolSht00001  = regsMem.tTtllog.t100600.acr1PolSht;
    // 釣銭機金庫枚数　その他
    para.inoutInfo?.stockPolShtOth    = regsMem.tTtllog.t100600.acrOthPolSht;
    // 釣札機回収予備枚数
    para.inoutInfo?.stockPolShtFil    = regsMem.tTtllog.t100600.acbFillPolSht;
    // 釣札機収納部リジェクト回数
    para.inoutInfo?.stockRjct         = regsMem.tTtllog.t100600.acbRejectCnt;
    // 釣銭機硬貨投入部情報
    para.inoutInfo?.coinSlot          = regsMem.tTtllog.t100600Sts.acrCoinSlot;
    // 釣機在高取得日時
    para.inoutInfo?.stockGetDate      = regsMem.tTtllog.t100600.stockDatetime;
    // 釣機在高不確定情報
    para.inoutInfo?.stockStateErrCode = regsMem.tTtllog.t100600Sts.chgStockStateErr;
    // 差異チェック入力データ反映フラグ
    para.inoutInfo?.drwChkPickFlg     = regsMem.tTtllog.t105100Sts.drwchkPickFlg;
    // 従業員精算フラグ
    para.inoutInfo?.closeFlg          = regsMem.tTtllog.t105100.closeFlg;

    CalcResultPay retData;
    if (!RcClxosCommon.validClxos) {
      retData = await stabPick();
    } else {
      final stopWatch = Stopwatch();
      stopWatch.start();
      retData = await CalcApi.pick(para);
      stopWatch.stop();
      debugPrint(
          'Clxos CalcApi.pick()  ${stopWatch.elapsedMilliseconds}[ms]');
    }
    return retData;
  }

  /// 下記はWindowsのみの処理
  static Future<CalcResultPay> stabPick() async {
    CalcResultPay result =  CalcResultPay(retSts: 0,errMsg: "",posErrCd: null,totalData: null,digitalReceipt: null);

    try {
      String tempRetData = "";
      final File file = File("/pj/tprx/testData/test_pick.txt"); // 適宜、ファイル名と内容を編集
      if (file.existsSync()) {
        tempRetData = file.readAsStringSync();
      } else {
        tempRetData =
        r'''{"RetSts":0,"ErrMsg":"","TotalData":{"Amount":0,"Payment":0,"Change":0,"RefundFlag":0},"DigitalReceipt":{"Transaction":{"ReceiptDateTime":"2024-07-11T23:37:52+09:00","WorkstationID":"3","ReceiptNumber":"157","TransactionID":"2024071000000000100001031000000000301570176","TRKReceiptImage":[{"LineSpace":6,"PrintType":"Line","CutType":"PartialCut","ReceiptLine":["@bitmap@Logo\/receipt.bmp@\/bitmap@","                                  ","店No:000010310      ﾚｼﾞNo:000003  ","2024年 7月11日(木曜日)  23時37分  ","000999999ﾒﾝﾃﾅﾝｽ      ﾚｼｰﾄNo:0157  ","                                  ","-------------入金1-------------   ","                                  ","入金合計              \\7,777,777  "],"PageParts":{}}]}}}''';
      }
      result = CalcResultPay.fromJson(jsonDecode(tempRetData));
      result.retSts = 0;
    } catch (e) {}
      return result;
  }
}
