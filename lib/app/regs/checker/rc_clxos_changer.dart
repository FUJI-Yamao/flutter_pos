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
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import 'rc_clxos.dart';

/// クラウドPOSを利用する場合の釣機入金処理の関連のクラス.
class RcClxosChanger {
  static Future<CalcResultChanger> changerIn(RxCommonBuf pCom) async {
    CalcRequestParaChanger para = CalcRequestParaChanger(compCd: pCom.dbRegCtrl.compCd, streCd: pCom.dbRegCtrl.streCd, macNo: pCom.dbRegCtrl.macNo);
    RegsMem regsMem = RegsMem();
    para.opeMode = regsMem.tHeader.ope_mode_flg;

    // TODO:アークスの設定は、金種別登録は　「しない」 そのため、まずは一括入力金額（円）を対応する。
    para.inoutInfo = InoutInfo();
    para.inoutInfo?.amtTotal = regsMem.tTtllog.t105200Sts.chgInoutAmt;
    para.inoutInfo?.fncCode = FuncKey.KY_CHGCIN.keyId;

    CalcResultChanger retData;
    if (!RcClxosCommon.validClxos) {
//    if (true) { // 強制的にテストデータを読み込む.
      // チェックの時も返ってくるデータは同じなのでチェックパターンはなし.
      retData = await stabChangerIn();
    } else {
      final stopWatch = Stopwatch();
      stopWatch.start();
      retData = await CalcApi.changerIn(para);
      stopWatch.stop();
      debugPrint('Clxos CalcApi.changerIn() ${stopWatch.elapsedMilliseconds}[ms]');
    }
    return retData;
  }

  /// クラウドPOSを利用する場合の釣機支払処理の関連のクラス.
  static Future<CalcResultChanger> changerOut(RxCommonBuf pCom) async {
    CalcRequestParaChanger para = CalcRequestParaChanger(compCd: pCom.dbRegCtrl.compCd, streCd: pCom.dbRegCtrl.streCd, macNo: pCom.dbRegCtrl.macNo);
    RegsMem regsMem = RegsMem();
    para.opeMode = regsMem.tHeader.ope_mode_flg;

    // TODO:アークスの設定は、金種別登録は　「しない」 そのため、まずは一括入力金額（円）を対応する。
    para.inoutInfo = InoutInfo();
    para.inoutInfo?.amtTotal = regsMem.tTtllog.t105300Sts.chgInoutAmt;
    para.inoutInfo?.fncCode = FuncKey.KY_CHGOUT.keyId;

    CalcResultChanger retData;
    if (!RcClxosCommon.validClxos) {
      // チェックの時も返ってくるデータは同じなのでチェックパターンはなし.
      retData = await stabChangerOut();
    } else {
      final stopWatch = Stopwatch();
      stopWatch.start();
      retData = await CalcApi.changerOut(para);
      stopWatch.stop();
      debugPrint('Clxos CalcApi.changerOut() ${stopWatch.elapsedMilliseconds}[ms]');
    }
    return retData;
  }

  /// クラウドPOSを利用する場合の釣機支払処理の関連のクラス.
  static Future<CalcResultChanger> changerRef(RxCommonBuf pCom) async {
    CalcRequestParaChanger para = CalcRequestParaChanger(compCd: pCom.dbRegCtrl.compCd, streCd: pCom.dbRegCtrl.streCd, macNo: pCom.dbRegCtrl.macNo);
    RegsMem regsMem = RegsMem();
    para.opeMode = regsMem.tHeader.ope_mode_flg;

    para.inoutInfo = InoutInfo();
    // 釣機収納庫
    para.inoutInfo?.stockSht10000 = regsMem.tTtllog.t100600.acb10000Sht;
    para.inoutInfo?.stockSht05000 = regsMem.tTtllog.t100600.acb5000Sht;
    para.inoutInfo?.stockSht02000 = regsMem.tTtllog.t100600.acb2000Sht;
    para.inoutInfo?.stockSht01000 = regsMem.tTtllog.t100600.acb1000Sht;
    para.inoutInfo?.stockSht00500 = regsMem.tTtllog.t100600.acr500Sht;
    para.inoutInfo?.stockSht00100 = regsMem.tTtllog.t100600.acr100Sht;
    para.inoutInfo?.stockSht00050 = regsMem.tTtllog.t100600.acr50Sht;
    para.inoutInfo?.stockSht00010 = regsMem.tTtllog.t100600.acr10Sht;
    para.inoutInfo?.stockSht00005 = regsMem.tTtllog.t100600.acr5Sht;
    para.inoutInfo?.stockSht00001 = regsMem.tTtllog.t100600.acr1Sht;
    // 釣機金庫
    para.inoutInfo?.stockPolSht10000 = regsMem.tTtllog.t100600.acb10000PolSht;
    para.inoutInfo?.stockPolSht05000 = regsMem.tTtllog.t100600.acb5000PolSht;
    para.inoutInfo?.stockPolSht02000 = regsMem.tTtllog.t100600.acb2000PolSht;
    para.inoutInfo?.stockPolSht01000 = regsMem.tTtllog.t100600.acb1000PolSht;
    para.inoutInfo?.stockPolSht00500 = regsMem.tTtllog.t100600.acr500PolSht;
    para.inoutInfo?.stockPolSht00100 = regsMem.tTtllog.t100600.acr100PolSht;
    para.inoutInfo?.stockPolSht00050 = regsMem.tTtllog.t100600.acr50PolSht;
    para.inoutInfo?.stockPolSht00010 = regsMem.tTtllog.t100600.acr10PolSht;
    para.inoutInfo?.stockPolSht00005 = regsMem.tTtllog.t100600.acr5PolSht;
    para.inoutInfo?.stockPolSht00001 = regsMem.tTtllog.t100600.acr1PolSht;
    // 釣銭機金庫枚数　その他
    para.inoutInfo?.stockPolShtOth = regsMem.tTtllog.t100600.acrOthPolSht;
    // 釣札機回収予備枚数
    para.inoutInfo?.stockPolShtFil = regsMem.tTtllog.t100600.acbFillPolSht;
    // 釣札機収納部リジェクト回数
    para.inoutInfo?.stockRjct = regsMem.tTtllog.t100600.acbRejectCnt;
    // 釣銭機硬貨投入部情報
    para.inoutInfo?.coinSlot = regsMem.tTtllog.t100600Sts.acrCoinSlot;
    // 釣機在高取得日時
    para.inoutInfo?.stockGetDate = regsMem.tTtllog.t100600.stockDatetime;
    // 釣機在高不確定情報
    para.inoutInfo?.stockStateErrCode = regsMem.tTtllog.t100600Sts.chgStockStateErr;

    CalcResultChanger retData;
    if (!RcClxosCommon.validClxos) {
      // チェックの時も返ってくるデータは同じなのでチェックパターンはなし.
      retData = await stabChangerRef();
    } else {
      final stopWatch = Stopwatch();
      stopWatch.start();
      retData = await CalcApi.changerRef(para);
      stopWatch.stop();
      debugPrint('Clxos CalcApi.changerRef() ${stopWatch.elapsedMilliseconds}[ms]');
    }
    return retData;
  }

  /// クラウドPOSを利用する場合の釣機回収処理の関連のクラス.
  static Future<CalcResultChanger> changerPick(RxCommonBuf pCom) async {
    CalcRequestParaChanger para = CalcRequestParaChanger(compCd: pCom.dbRegCtrl.compCd, streCd: pCom.dbRegCtrl.streCd, macNo: pCom.dbRegCtrl.macNo);
    RegsMem regsMem = RegsMem();
    para.opeMode = regsMem.tHeader.ope_mode_flg;
    para.inoutInfo = InoutInfo();

    // 金種別登録時の枚数
    para.inoutInfo?.sht10000 = regsMem.tTtllog.t105100Sts.mny10000Sht;
    para.inoutInfo?.sht05000 = regsMem.tTtllog.t105100Sts.mny5000Sht;
    para.inoutInfo?.sht02000 = regsMem.tTtllog.t105100Sts.mny2000Sht;
    para.inoutInfo?.sht01000 = regsMem.tTtllog.t105100Sts.mny1000Sht;
    para.inoutInfo?.sht00500 = regsMem.tTtllog.t105100Sts.mny500Sht;
    para.inoutInfo?.sht00100 = regsMem.tTtllog.t105100Sts.mny100Sht;
    para.inoutInfo?.sht00050 = regsMem.tTtllog.t105100Sts.mny50Sht;
    para.inoutInfo?.sht00010 = regsMem.tTtllog.t105100Sts.mny10Sht;
    para.inoutInfo?.sht00005 = regsMem.tTtllog.t105100Sts.mny5Sht;
    para.inoutInfo?.sht00001 = regsMem.tTtllog.t105100Sts.mny1Sht;
    // 釣機収納庫の枚数
    para.inoutInfo?.stockSht10000 = regsMem.tTtllog.t100600.acb10000Sht;
    para.inoutInfo?.stockSht05000 = regsMem.tTtllog.t100600.acb5000Sht;
    para.inoutInfo?.stockSht02000 = regsMem.tTtllog.t100600.acb2000Sht;
    para.inoutInfo?.stockSht01000 = regsMem.tTtllog.t100600.acb1000Sht;
    para.inoutInfo?.stockSht00500 = regsMem.tTtllog.t100600.acr500Sht;
    para.inoutInfo?.stockSht00100 = regsMem.tTtllog.t100600.acr100Sht;
    para.inoutInfo?.stockSht00050 = regsMem.tTtllog.t100600.acr50Sht;
    para.inoutInfo?.stockSht00010 = regsMem.tTtllog.t100600.acr10Sht;
    para.inoutInfo?.stockSht00005 = regsMem.tTtllog.t100600.acr5Sht;
    para.inoutInfo?.stockSht00001 = regsMem.tTtllog.t100600.acr1Sht;
    // 釣機金庫の枚数
    para.inoutInfo?.stockPolSht10000 = regsMem.tTtllog.t100600.acb10000PolSht;
    para.inoutInfo?.stockPolSht05000 = regsMem.tTtllog.t100600.acb5000PolSht;
    para.inoutInfo?.stockPolSht02000 = regsMem.tTtllog.t100600.acb2000PolSht;
    para.inoutInfo?.stockPolSht01000 = regsMem.tTtllog.t100600.acb1000PolSht;
    para.inoutInfo?.stockPolSht00500 = regsMem.tTtllog.t100600.acr500PolSht;
    para.inoutInfo?.stockPolSht00100 = regsMem.tTtllog.t100600.acr100PolSht;
    para.inoutInfo?.stockPolSht00050 = regsMem.tTtllog.t100600.acr50PolSht;
    para.inoutInfo?.stockPolSht00010 = regsMem.tTtllog.t100600.acr10PolSht;
    para.inoutInfo?.stockPolSht00005 = regsMem.tTtllog.t100600.acr5PolSht;
    para.inoutInfo?.stockPolSht00001 = regsMem.tTtllog.t100600.acr1PolSht;
    // 釣銭機金庫枚数　その他
    para.inoutInfo?.stockPolShtOth = regsMem.tTtllog.t100600.acrOthPolSht;
    // 釣札機回収予備枚数
    para.inoutInfo?.stockPolShtFil = regsMem.tTtllog.t100600.acbFillPolSht;
    // 釣札機収納部リジェクト回数
    para.inoutInfo?.stockRjct = regsMem.tTtllog.t100600.acbRejectCnt;
    // 釣銭機硬貨投入部情報
    para.inoutInfo?.coinSlot = regsMem.tTtllog.t100600Sts.acrCoinSlot;
    // 釣機在高取得日時
    para.inoutInfo?.stockGetDate = regsMem.tTtllog.t100600.stockDatetime;
    // 釣機在高不確定情報
    para.inoutInfo?.stockStateErrCode = regsMem.tTtllog.t100600Sts.chgStockStateErr;
    // ファンクションキーコード
    para.inoutInfo?.fncCode = regsMem.tTtllog.t105100.pickCd;
    // 回収方法選択ボタン
    para.inoutInfo?.pickBtn = regsMem.tTtllog.t105100Sts.cpickType;
    // 回収カセット金額
    para.inoutInfo?.pickCassette = regsMem.tTtllog.t105100Sts.cpickCassette;
    // 回収前釣機収納庫の枚数
    para.inoutInfo?.bfrHolder10000 = regsMem.tTtllog.t100600Sts.bfreStockSht10000;
    para.inoutInfo?.bfrHolder05000 = regsMem.tTtllog.t100600Sts.bfreStockSht5000;
    para.inoutInfo?.bfrHolder02000 = regsMem.tTtllog.t100600Sts.bfreStockSht2000;
    para.inoutInfo?.bfrHolder01000 = regsMem.tTtllog.t100600Sts.bfreStockSht1000;
    para.inoutInfo?.bfrHolder00500 = regsMem.tTtllog.t100600Sts.bfreStockSht500;
    para.inoutInfo?.bfrHolder00100 = regsMem.tTtllog.t100600Sts.bfreStockSht100;
    para.inoutInfo?.bfrHolder00050 = regsMem.tTtllog.t100600Sts.bfreStockSht50;
    para.inoutInfo?.bfrHolder00010 = regsMem.tTtllog.t100600Sts.bfreStockSht10;
    para.inoutInfo?.bfrHolder00005 = regsMem.tTtllog.t100600Sts.bfreStockSht5;
    para.inoutInfo?.bfrHolder00001 = regsMem.tTtllog.t100600Sts.bfreStockSht1;
    // 回収前釣機金庫の枚数
    para.inoutInfo?.bfrOverflow10000 = regsMem.tTtllog.t100600Sts.bfreStockPolSht10000;
    para.inoutInfo?.bfrOverflow05000 = regsMem.tTtllog.t100600Sts.bfreStockPolSht5000;
    para.inoutInfo?.bfrOverflow02000 = regsMem.tTtllog.t100600Sts.bfreStockPolSht2000;
    para.inoutInfo?.bfrOverflow01000 = regsMem.tTtllog.t100600Sts.bfreStockPolSht1000;
    para.inoutInfo?.bfrOverflow00500 = regsMem.tTtllog.t100600Sts.bfreStockPolSht500;
    para.inoutInfo?.bfrOverflow00100 = regsMem.tTtllog.t100600Sts.bfreStockPolSht100;
    para.inoutInfo?.bfrOverflow00050 = regsMem.tTtllog.t100600Sts.bfreStockPolSht50;
    para.inoutInfo?.bfrOverflow00010 = regsMem.tTtllog.t100600Sts.bfreStockPolSht10;
    para.inoutInfo?.bfrOverflow00005 = regsMem.tTtllog.t100600Sts.bfreStockPolSht5;
    para.inoutInfo?.bfrOverflow00001 = regsMem.tTtllog.t100600Sts.bfreStockPolSht1;
    // 回収後残枚数
    para.inoutInfo?.resvHolder10000 = regsMem.tTtllog.t100600Sts.bfreStockSht10000;
    para.inoutInfo?.resvHolder05000 = regsMem.tTtllog.t100600Sts.bfreStockSht5000;
    para.inoutInfo?.resvHolder02000 = regsMem.tTtllog.t100600Sts.bfreStockSht2000;
    para.inoutInfo?.resvHolder01000 = regsMem.tTtllog.t100600Sts.bfreStockSht1000;
    para.inoutInfo?.resvHolder00500 = regsMem.tTtllog.t100600Sts.bfreStockSht500;
    para.inoutInfo?.resvHolder00100 = regsMem.tTtllog.t100600Sts.bfreStockSht100;
    para.inoutInfo?.resvHolder00050 = regsMem.tTtllog.t100600Sts.bfreStockSht50;
    para.inoutInfo?.resvHolder00010 = regsMem.tTtllog.t100600Sts.bfreStockSht10;
    para.inoutInfo?.resvHolder00005 = regsMem.tTtllog.t100600Sts.bfreStockSht5;
    para.inoutInfo?.resvHolder00001 = regsMem.tTtllog.t100600Sts.bfreStockSht1;
    // 回収後残枚数
    para.inoutInfo?.resvDrawdata00500 = regsMem.tTtllog.t100600Sts.bfreStockPolSht500;
    para.inoutInfo?.resvDrawdata00100 = regsMem.tTtllog.t100600Sts.bfreStockPolSht100;
    para.inoutInfo?.resvDrawdata00050 = regsMem.tTtllog.t100600Sts.bfreStockPolSht50;
    para.inoutInfo?.resvDrawdata00010 = regsMem.tTtllog.t100600Sts.bfreStockPolSht10;
    para.inoutInfo?.resvDrawdata00005 = regsMem.tTtllog.t100600Sts.bfreStockPolSht5;
    para.inoutInfo?.resvDrawdata00001 = regsMem.tTtllog.t100600Sts.bfreStockPolSht1;
    //従業員精算フラグ
    para.inoutInfo?.closeFlg = regsMem.tTtllog.t105100.closeFlg;
    // 回収タイプ
    para.inoutInfo?.pickTyp = regsMem.tTtllog.t105100.pickTyp;
    // 操作従業員コード
    para.inoutInfo?.opeStaffCode = regsMem.tTtllog.t105100.opeStaffCd;
    // 回収結果エラー番号
    para.inoutInfo?.cPickErrNo = regsMem.tTtllog.t105100Sts.cpickErrno;
    // 分割出金フラグ
    para.inoutInfo?.kindoutPrnFlg = regsMem.tTtllog.t105100Sts.kindoutPrnFlg;
    // 分割出金ステータス
    para.inoutInfo?.kindoutPrnStat1 = regsMem.tTtllog.t105100Sts.kindoutPrnStat1;
    para.inoutInfo?.kindoutPrnStat2 = regsMem.tTtllog.t105100Sts.kindoutPrnStat2;
    para.inoutInfo?.kindoutPrnStat3 = regsMem.tTtllog.t105100Sts.kindoutPrnStat3;
    para.inoutInfo?.kindoutPrnStat4 = regsMem.tTtllog.t105100Sts.kindoutPrnStat4;
    para.inoutInfo?.kindoutPrnStat5 = regsMem.tTtllog.t105100Sts.kindoutPrnStat5;
    para.inoutInfo?.kindoutPrnStat6 = regsMem.tTtllog.t105100Sts.kindoutPrnStat6;
    para.inoutInfo?.kindoutPrnStat7 = regsMem.tTtllog.t105100Sts.kindoutPrnStat7;
    para.inoutInfo?.kindoutPrnStat8 = regsMem.tTtllog.t105100Sts.kindoutPrnStat8;
    para.inoutInfo?.kindoutPrnStat9 = regsMem.tTtllog.t105100Sts.kindoutPrnStat9;
    para.inoutInfo?.kindoutPrnStat10 = regsMem.tTtllog.t105100Sts.kindoutPrnStat10;
    // 分割出金エラー番号
    para.inoutInfo?.kindoutPrnErrNo1 = regsMem.tTtllog.t105100Sts.kindoutPrnErrno1;
    para.inoutInfo?.kindoutPrnErrNo2 = regsMem.tTtllog.t105100Sts.kindoutPrnErrno2;
    para.inoutInfo?.kindoutPrnErrNo3 = regsMem.tTtllog.t105100Sts.kindoutPrnErrno3;
    para.inoutInfo?.kindoutPrnErrNo4 = regsMem.tTtllog.t105100Sts.kindoutPrnErrno4;
    para.inoutInfo?.kindoutPrnErrNo5 = regsMem.tTtllog.t105100Sts.kindoutPrnErrno5;
    para.inoutInfo?.kindoutPrnErrNo6 = regsMem.tTtllog.t105100Sts.kindoutPrnErrno6;
    para.inoutInfo?.kindoutPrnErrNo7 = regsMem.tTtllog.t105100Sts.kindoutPrnErrno7;
    para.inoutInfo?.kindoutPrnErrNo8 = regsMem.tTtllog.t105100Sts.kindoutPrnErrno8;
    para.inoutInfo?.kindoutPrnErrNo9 = regsMem.tTtllog.t105100Sts.kindoutPrnErrno9;
    para.inoutInfo?.kindoutPrnErrNo10 = regsMem.tTtllog.t105100Sts.kindoutPrnErrno10;

    CalcResultChanger retData;
    if (!RcClxosCommon.validClxos) {
      // チェックの時も返ってくるデータは同じなのでチェックパターンはなし.
      retData = await stabChangerPick();
    } else {
      final stopWatch = Stopwatch();
      stopWatch.start();
      retData = await CalcApi.changerPick(para);
      stopWatch.stop();
      debugPrint('Clxos CalcApi.changerRef() ${stopWatch.elapsedMilliseconds}[ms]');
    }
    return retData;
  }

  /// 下記はWindowsのみの処理
  static Future<CalcResultChanger> stabChangerIn() async {
    CalcResultChanger result = CalcResultChanger(retSts: 0, errMsg: "", digitalReceipt: null);
    try {
      String tempRetData = "";
      final File file = File("/pj/tprx/testData/test_changerIn.txt"); // 適宜、ファイル名と内容を編集
      if (file.existsSync()) {
        tempRetData = file.readAsStringSync();
      } else {
        tempRetData =
        r'''{"RetSts":0,"ErrMsg":"","TotalData":{"Amount":0,"Payment":0,"Change":0,"RefundFlag":0},"DigitalReceipt":{"Transaction":{"ReceiptDateTime":"2024-07-11T23:37:52+09:00","WorkstationID":"3","ReceiptNumber":"157","TransactionID":"2024071000000000100001031000000000301570176","TRKReceiptImage":[{"LineSpace":6,"PrintType":"Line","CutType":"PartialCut","ReceiptLine":["@bitmap@Logo\/receipt.bmp@\/bitmap@","                                  ","店No:000010310      ﾚｼﾞNo:000003  ","2024年 7月11日(木曜日)  23時37分  ","000999999ﾒﾝﾃﾅﾝｽ      ﾚｼｰﾄNo:0157  ","                                  ","-------------入金1-------------   ","                                  ","入金合計              \\7,777,777  "],"PageParts":{}}]}}}''';
      }
      result = CalcResultChanger.fromJson(jsonDecode(tempRetData));
      result.retSts = 0;
    } catch (e) {}
    return (result);
  }

  /// 下記はWindowsのみの処理
  static Future<CalcResultChanger> stabChangerOut() async {
    CalcResultChanger result = CalcResultChanger(retSts: 0, errMsg: "", digitalReceipt: null);
    try {
      String tempRetData = "";
      final File file = File("/pj/tprx/testData/test_changerOut.txt"); // 適宜、ファイル名と内容を編集
      if (file.existsSync()) {
        tempRetData = file.readAsStringSync();
      } else {
        tempRetData =
        r'''{"RetSts":0,"ErrMsg":"","TotalData":{"Amount":0,"Payment":0,"Change":0,"RefundFlag":0},"DigitalReceipt":{"Transaction":{"ReceiptDateTime":"2024-07-11T23:37:06+09:00","WorkstationID":"3","ReceiptNumber":"156","TransactionID":"2024071000000000100001031000000000301560175","TRKReceiptImage":[{"LineSpace":6,"PrintType":"Line","CutType":"PartialCut","ReceiptLine":["@bitmap@Logo\/receipt.bmp@\/bitmap@","                                  ","店No:000010310      ﾚｼﾞNo:000003  ","2024年 7月11日(木曜日)  23時37分  ","000999999ﾒﾝﾃﾅﾝｽ      ﾚｼｰﾄNo:0156  ","                                  ","-------------支払1-------------   ","                                  ","支払合計              \\7,777,777  "],"PageParts":{}}]}}}''';
      }
      result = CalcResultChanger.fromJson(jsonDecode(tempRetData));
      result.retSts = 0;
    } catch (e) {}
    return (result);
  }

  /// 下記はWindowsのみの処理
  static Future<CalcResultChanger> stabChangerRef() async {
    CalcResultChanger result = CalcResultChanger(retSts: 0, errMsg: "", digitalReceipt: null);
    try {
      String tempRetData = "";
      final File file = File("/pj/tprx/testData/test_changerRef.txt"); // 適宜、ファイル名と内容を編集
      if (file.existsSync()) {
        tempRetData = file.readAsStringSync();
      } else {
        tempRetData =
        '''{"RetSts":0,"ErrMsg":"","TotalData":{"Amount":0,"Payment":0,"Change":0,"RefundFlag":0,"TotalQty":0},"DigitalReceipt":{"Transaction":{"ReceiptDateTime":"2024-07-29T14:48:21+09:00","WorkstationID":"3","ReceiptNumber":"42","TransactionID":"2024072900000000100001032000000000300420050","TRKReceiptImage":[{"LineSpace":6,"PrintType":"Line","CutType":"PartialCut","ReceiptLine":["@bitmap@Logo\/receipt.bmp@\/bitmap@","                                  ","店No:000010320      ﾚｼﾞNo:000003  ","2024年 7月29日(月曜日)  14時48分  ","000999999ﾒﾝﾃﾅﾝｽ      ﾚｼｰﾄNo:0042  ","                                  ","------------釣機参照------------  ","                                  ","金種   収納 金庫 計   合計金額    ","10000円   0   0   0枚...........0 "," 5000円   0   0   0枚...........0 "," 2000円   0   0   0枚...........0 "," 1000円   0   0   0枚...........0 ","  500円   0   0   0枚...........0 ","  100円   0   0   0枚...........0 ","   50円   0   0   0枚...........0 ","   10円   0   0   0枚...........0 ","    5円   0   0   0枚...........0 ","    1円   0   0   0枚...........0 ","紙幣その他  ---   0   ----------  ","硬貨その他  ---   0   ----------  ","紙幣合計金額        ...........0  ","硬貨合計金額        ...........0  ","釣銭合計金額        ...........0  ","--------------------------------  ","収納合計金額        ...........0  ","金庫合計金額        ...........0  ","--------------------------------  "],"PageParts":{}}]}}}''';
      }
      result = CalcResultChanger.fromJson(jsonDecode(tempRetData));
      result.retSts = 0;
    } catch (e) {}
    return (result);
  }

  /// 下記はWindowsのみの処理
  static Future<CalcResultChanger> stabChangerPick() async {
    CalcResultChanger result = CalcResultChanger(retSts: 0, errMsg: "", digitalReceipt: null);
    try {
      String tempRetData = "";
      final File file = File("/pj/tprx/testData/test_changerPick.txt"); // 適宜、ファイル名と内容を編集
      if (file.existsSync()) {
        // tempRetData = file.readAsStringSync();
      } else {
        // tempRetData =
        // '''{"RetSts":0,"ErrMsg":"","TotalData":{"Amount":0,"Payment":0,"Change":0,"RefundFlag":0,"TotalQty":0},"DigitalReceipt":{"Transaction":{"ReceiptDateTime":"2024-07-29T14:48:21+09:00","WorkstationID":"3","ReceiptNumber":"42","TransactionID":"2024072900000000100001032000000000300420050","TRKReceiptImage":[{"LineSpace":6,"PrintType":"Line","CutType":"PartialCut","ReceiptLine":["@bitmap@Logo\/receipt.bmp@\/bitmap@","                                  ","店No:000010320      ﾚｼﾞNo:000003  ","2024年 7月29日(月曜日)  14時48分  ","000999999ﾒﾝﾃﾅﾝｽ      ﾚｼｰﾄNo:0042  ","                                  ","------------釣機参照------------  ","                                  ","金種   収納 金庫 計   合計金額    ","10000円   0   0   0枚...........0 "," 5000円   0   0   0枚...........0 "," 2000円   0   0   0枚...........0 "," 1000円   0   0   0枚...........0 ","  500円   0   0   0枚...........0 ","  100円   0   0   0枚...........0 ","   50円   0   0   0枚...........0 ","   10円   0   0   0枚...........0 ","    5円   0   0   0枚...........0 ","    1円   0   0   0枚...........0 ","紙幣その他  ---   0   ----------  ","硬貨その他  ---   0   ----------  ","紙幣合計金額        ...........0  ","硬貨合計金額        ...........0  ","釣銭合計金額        ...........0  ","--------------------------------  ","収納合計金額        ...........0  ","金庫合計金額        ...........0  ","--------------------------------  "],"PageParts":{}}]}}}''';
      }
      result = CalcResultChanger.fromJson(jsonDecode(tempRetData));
      result.retSts = 0;
    } catch (e) {}
    return (result);
  }

  /// クラウドPOSからの返り値から、エラーコードを返す.
  static int getErrId(CalcResultChanger resultData) {
    if((resultData.retSts != null && resultData.retSts != 0)
    || (resultData.errMsg != null && resultData.errMsg != "")){
      return  DlgConfirmMsgKind.MSG_INPUTERR.dlgId;
    }
   
    return 0;
  }
}
