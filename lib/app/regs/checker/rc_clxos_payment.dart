/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../clxos/calc_api.dart';
import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';

import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';

import '../../inc/sys/tpr_log.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_clxos.dart';
import 'rcky_erctfm.dart';
import 'rckycrdtvoid.dart';
import 'rcsyschk.dart';

/// クラウドPOSを利用する場合の支払い処理の関連のクラス.
class RcClxosPayment {
  /// クイックペイ、iD用のPaydata作成
  static Future<PayData> getMultiPayData(
      int index, RxTaskStatBuf tsBuf, RxCommonBuf pCom, FuncKey key, bool isCheck, TTtlLog tTtlLog) async {
    // tsBuf.multi.fclData.rcvData.dateTimeはyymmddhhmmssの形式.yymmddへ直す.
    String datetime = "";
    PayData data;
    if (tsBuf.multi.fclData.rcvData.dateTime.length >= 6) {
      datetime = tsBuf.multi.fclData.rcvData.dateTime.substring(0, 6);
    }

      data = PayData(
        payCode: tTtlLog.t100100[index].sptendCd,
        amount: tTtlLog.t100100[index].sptendData,

        memberCode: tsBuf.multi.fclData.rcvData.cardId,
        saleyymmdd: datetime,
        recognizeNo: tsBuf.multi.fclData.rcvData.recognNo.toString(),
        // yymm .limitDateは数字型のため最初の0は足しておく.
        goodThru:
            tsBuf.multi.fclData.rcvData.limitDate.toString().padLeft(4, "0"),
        posRecognizeNo: key == FuncKey.KY_CHA8
            ? pCom.ini_multi.QP_tid
            : key == FuncKey.KY_CHA3
                ? pCom.ini_multi.iD_tid
                : null,
        posReceiptNo: tsBuf.multi.fclData.rcvData.slipNo.toString(),

        seqInqNo: tsBuf.multi.fclData.rcvData.icNo.toString(),
      );
    return data;
  }

  static Future<CalcResultPay> payment(RxCommonBuf pCom,
      {bool isCheck = false, CalcRequestParaPay? requestParaPay}) async {

    CalcRequestParaPay payPara = await makeRequestParaPayment(pCom, isCheck, requestParaPay: requestParaPay);

    CalcResultPay retData;
    if (!RcClxosCommon.validClxos) {
//    if (true) { // テストデータを読み込む.
      // チェックの時も返ってくるデータは同じなのでチェックパターンはなし.
      retData = await RcClxosPayment.stabPay(payPara);
    } else {
      final stopWatch = Stopwatch();
      stopWatch.start();
      if (isCheck) {
        retData = await CalcApi.paymentCheck(payPara);
      } else {
        retData = await CalcApi.payment(payPara);
      }

      stopWatch.stop();
      debugPrint(
          'Clxos CalcApi.payment()  ${stopWatch.elapsedMilliseconds}[ms]');
    }
    return retData;
  }

  /// QC指定クラウドPOS処理呼び出し
  static Future<CalcResultPay> qcSelect(RxCommonBuf pCom, int macNo, String macName, String uuid) async {

    CalcResultPay retData = CalcResultPay(retSts: null,errMsg: null,posErrCd: null,totalData: null,digitalReceipt: null);
    CalcRequestParaPay payPara = await funcKeyCheck(pCom, true);
    payPara.qcSendMacNo = macNo;
    payPara.qcSendMacName = macName;

    if (!RcClxosCommon.validClxos) {
      retData = await RcClxosPayment.stabQcSelect(payPara, uuid);
    } else {
      final stopWatch = Stopwatch();
      stopWatch.start();
      retData = await CalcApi.qcSelect(payPara, uuid);

      stopWatch.stop();
      debugPrint(
          'Clxos CalcApi.qcSelect()  ${stopWatch.elapsedMilliseconds}[ms]');
    }
    return retData;
  }

  // TODO:00011 周 下記はWindowsの暫定処理
  static Future<CalcResultPay> stabPay(CalcRequestParaPay para) async {
    CalcResultPay result = CalcResultPay(
        retSts: 0,
        errMsg: "",
        posErrCd: null,
        totalData: null,
        digitalReceipt: null);
    try {
      String tempRetData = "";
//      final File file = File("/pj/tprx/testData/test_receipt.txt");
      final File file = File("/pj/tprx/testData/領収書付レシート.txt");
      if (file.existsSync()) {
        tempRetData = file.readAsStringSync();
      } else {
        tempRetData =
            '''{"RetSts":0,"ErrMsg":"","TotalData":{"Amount":210,"Payment":210,"Change":210,"RefundFlag":0,"TotalQty":1,"CompCd":1,"StreCd":10320,"MacNo":3,"ReceiptNo":483,"PrintNo":497,"CashierNo":999999,"EndTime":"2023-11-13 18:46:03","SerialNo":"2023111000000000100001031000000000300250026","UUID":""},},"DigitalReceipt":{"Transaction":{"ReceiptDateTime":"2023-11-13T18:46:03+09:00","WorkstationID":"3","ReceiptNumber":"25","TransactionID":"2023111000000000100001031000000000300250026","TRKReceiptImage":[{"LineSpace":6,"PrintType":"Line","CutType":"PartialCut","ReceiptLine":["@bitmap@Logo/receipt.bmp@/bitmap@","　　スーパーアークス　月寒東店    ","　　　　TEL (011)851-5115         ","本日はご来店有難うございます。    ","　                                ","　                                ","　　　　　＜領収書＞              ","                                  ","店No:000010310      ﾚｼﾞNo:000003  ","2023年11月13日(月曜日)  17時22分  ","                     ﾚｼｰﾄNo:0024  ","                                  ","＊＊＊＊＊＊訓練ﾓ-ﾄﾞ＊＊＊＊＊＊  ","外8  逸品　アボカド         ￥195　","----------- 訓練ﾓ-ﾄﾞ -----------  ","--------------------------------  "," 小計                       ￥195  ","(外税8%対象額               ￥195) "," 外税額            8%        ￥15  "," 買上点数                    1点  ","--------------------------------  ","@fontsizeH@合計        ￥210 @/fontsizeH@","@fontsizeH@            ￥210 @/fontsizeH@","           (内消費税等       ￥15) ","@fontsizeH@お釣り        ￥0 @/fontsizeH@","                                  ","外8内8は軽減税率対象商品です      ","@barC128_HNC@98231110002400000000300253@/barC128_HNC@","                                  ","@bitmap@cmlogo00000119.bmp@/bitmap@"]}]}}}''';
      }
      result = CalcResultPay.fromJson(jsonDecode(tempRetData));
      if (para.refundFlag != 0) {
        result.totalData!.refundFlag = 1;
      }
      result.retSts = 0;
    } catch (e) {}
    return (result);
  }

  // TODO:00007 梶原 下記はWindowsの暫定処理 tempRetDataはstabPayのまま
  static Future<CalcResultVoid> stabPayVoid(CalcRequestParaVoid para) async {
    CalcResultVoid result = CalcResultVoid(
        retSts: 0,
        errMsg: "",
        posErrCd: null,
        totalData: null,
        digitalReceipt: null);
    try {
      String tempRetData = "";
      final File file = File("/pj/tprx/testData/test_receipt.txt");
      if (file.existsSync()) {
        tempRetData = file.readAsStringSync();
      } else {
        tempRetData =
            '''{"RetSts":0,"ErrMsg":"","TotalData":{"Amount":210,"Payment":210,"Change":210},"DigitalReceipt":{"Transaction":{"ReceiptDateTime":"2023-11-13T18:46:03+09:00","WorkstationID":"3","ReceiptNumber":"25","TransactionID":"2023111000000000100001031000000000300250026","TRKReceiptImage":[{"LineSpace":6,"PrintType":"Line","CutType":"PartialCut","ReceiptLine":["@bitmap@Logo/receipt.bmp@/bitmap@","　　スーパーアークス　月寒東店    ","　　　　TEL (011)851-5115         ","本日はご来店有難うございます。    ","　                                ","　                                ","　　　　　＜領収書＞              ","                                  ","店No:000010310      ﾚｼﾞNo:000003  ","2023年11月13日(月曜日)  17時22分  ","                     ﾚｼｰﾄNo:0024  ","                                  ","＊＊＊＊＊＊訓練ﾓ-ﾄﾞ＊＊＊＊＊＊  ","外8  逸品　アボカド         ￥195　","----------- 訓練ﾓ-ﾄﾞ -----------  ","--------------------------------  "," 小計                       ￥195  ","(外税8%対象額               ￥195) "," 外税額            8%        ￥15  "," 買上点数                    1点  ","--------------------------------  ","@fontsizeH@合計        ￥210 @/fontsizeH@","@fontsizeH@            ￥210 @/fontsizeH@","           (内消費税等       ￥15) ","@fontsizeH@お釣り        ￥0 @/fontsizeH@","                                  ","外8内8は軽減税率対象商品です      ","@barC128_HNC@98231110002400000000300253@/barC128_HNC@","                                  ","@bitmap@cmlogo00000119.bmp@/bitmap@"]}]}}}''';
      }
      result = CalcResultVoid.fromJson(jsonDecode(tempRetData));
      result.retSts = 0;
    } catch (e) {}
    return (result);
  }

  // TODO:00011 小出 下記はWindowsの暫定処理
  static Future<CalcResultPay> stabQcSelect(CalcRequestParaPay para, String uuid) async {
    CalcResultPay result = CalcResultPay(retSts: null,errMsg: null,posErrCd: null,totalData: null,digitalReceipt: null);
    try {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        return result;
      }
      RxCommonBuf pCom = xRet.object;
      DateTime dt = DateTime.now();
      DbManipulationPs db = DbManipulationPs();
      String serialNo = "2024092500000000100001032000000000321972500";

      String tempRetData = '''{"RetSts":0,"ErrMsg":"","TotalData":{"Amount":210,"Payment":0,"Change":0,"RefundFlag":0,"TotalQty":1,"CompCd":${pCom.iniMacInfoCrpNoNo},"StreCd":${pCom.iniMacInfoShopNo},"MacNo":${pCom.iniMacInfoMacNo},"ReceiptNo":2197,"PrintNo":2500,"CashierNo":999999,"EndTime":"${dt.year}-${dt.month}-${dt.day} ${dt.hour}:${dt.minute}:${dt.second}","SerialNo":"${serialNo}","UUID":""},"DigitalReceipt":{"Transaction":{"ReceiptDateTime":"${dt.year}-${dt.month}-${dt.day}T${dt.hour}:${dt.minute}:${dt.second}+09:00","WorkstationID":"3","ReceiptNumber":"2197","TransactionID":"${serialNo}","TRKReceiptImage":[]}}}''';
      result = CalcResultPay.fromJson(jsonDecode(tempRetData));
      Map<String, dynamic>? delValues = {"serialNo": serialNo};
      Map<String, dynamic>? insValues = {"comp_cd" : pCom.iniMacInfoCrpNoNo, "stre_cd" : pCom.iniMacInfoShopNo, "mac_no" : pCom.iniMacInfoMacNo, "serialNo": serialNo};
      String deleteCEjLog = "delete from c_ej_log where serial_no = @serialNo;";
      String insertCEjLog = 'insert into c_ej_log  (serial_no,comp_cd,stre_cd,mac_no,print_no,seq_no,receipt_no,end_rec_flg,only_ejlog_flg,cshr_no,chkr_no,now_sale_datetime,sale_date,ope_mode_flg,print_data,sub_only_ejlog_flg,trankey_search,etckey_search)values('
          '@serialNo,@comp_cd,@stre_cd,@mac_no,44,1,44,1,0,999999,0,' "timezone('JST',now()),timezone('JST',now()),1100,"
          "' **** ${dt.year}年${dt.month}月 ${dt.day}日(火)${dt.hour}:${dt.minute} #000003 R0044 J0044 *****+"
          "  000999999 ﾒﾝﾃﾅﾝｽ                                      +"
          "                                                        +"
          "    P2501012001644 S0117   ほうれん草           \585外8 +"
          "                           (    3個 x          @195)    +"
          "                                                        +"
          "  ------------------------------------------------------+"
          "                           小計                   \585  +"
          "  (外税8%対象額       \585)外税額        8%        \46  +"
          "  (買上点数            3点)合計                   \631  +"
          "                                                        +"
          "  ＊＊＊＊＊＊＊＊＊＊＊お会計券＊＊＊＊＊＊＊＊＊＊＊  +"
          "  ＊＊＊＊＊＊＊＊＊＊バーコード印字＊＊＊＊＊＊＊＊＊＊+"
          "                                                        +"
          "                                                        '"
          ",0,'','');";
        // レジ情報グループ管理マスタから予約レポートのグループコードを取得
      await db.dbCon.execute(Sql.named(deleteCEjLog), parameters: delValues);
      await db.dbCon.execute(Sql.named(insertCEjLog), parameters: insValues);
      result.retSts = 0;
    } catch (e, s) {
      TprLog().logAdd(0, LogLevelDefine.error, "stabQcSelect error\n${e}\n${s}");
    }
    return (result);
  }

  ///通番訂正　クラウドPOS処理呼び出し
  static Future<CalcResultVoid> payvoid(RxCommonBuf pCom) async {
    CalcResultVoid retData = CalcResultVoid(
        retSts: 0,
        errMsg: "",
        posErrCd: null,
        totalData: null,
        digitalReceipt: null);

    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "payvoid(): rxMemRead error");
      return retData;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    List<PayVoidData> payVoidList1 = <PayVoidData>[];
    PayVoidData payVoidData1 = PayVoidData();
    payVoidData1.memberCode = tsBuf.multi.fclData.rcvData.cardId; //"11";
    if (tsBuf.multi.fclData.rcvData.dateTime.isNotEmpty) {
      String saleyymmddBase =
      tsBuf.multi.fclData.rcvData.dateTime.substring(0, 6);
      payVoidData1.saleyymmdd =
      '20${saleyymmddBase.substring(0, 2)}-${saleyymmddBase.substring(2, 4)}-${saleyymmddBase.substring(4, 6)}';
    }
    payVoidData1.recognizeNo =
        tsBuf.multi.fclData.rcvData.recognNo.toString(); //"234";
    // yymm .limitDateは数字型のため最初の0は足しておく.
    if (tsBuf.multi.fclData.rcvData.limitDate != 0) {
      payVoidData1.goodThru = tsBuf.multi.fclData.rcvData.limitDate
          .toString()
          .padLeft(4, "0") ?? ""; //"2409";
    }
    payVoidData1.posReceiptNo = (tsBuf.multi.fclData.rcvData.slipNo).toString();
    payVoidData1.seqInqNo = (tsBuf.multi.fclData.rcvData.icNo).toString();

    payVoidList1 = List.filled(1, payVoidData1);
    // TODO:00007 梶原 通番訂正230419　検定対応　opeModeに基づいて設定値修正
    int opeMode1 = OpeModeFlagList
        .OPE_MODE_REG; //RegsMem().tHeader.ope_mode_flg; 資料だとこれを設定するが、訂正だと3000となるため1000に修正している
    switch (cMem.stat.opeMode) {
      case RcRegs.VD:
        opeMode1 = OpeModeFlagList.OPE_MODE_REG;
        break;
      case RcRegs.TR:
        opeMode1 = OpeModeFlagList.OPE_MODE_TRAINING;
        break;
    }

    print(
        "通番訂正payvoid compCd:${pCom.dbRegCtrl.compCd},streCd:${pCom.dbRegCtrl.streCd},macNo:${pCom.dbRegCtrl.macNo},uuid:XXX,opeMode:${opeMode1},voidMacNo:${RcKyCrdtVoid.crdtVoid.macNo},voidSaleDate:${RcKyCrdtVoid.crdtVoid.date},voidReceiptNo:${RcKyCrdtVoid.crdtVoid.recNo},voidPrintNo:${RcKyCrdtVoid.crdtVoid.printNo},voidPosReceiptNo:${RcKyCrdtVoid.crdtVoid.slipNo}");
    print(
        "通番訂正payvoid payVoidList1 memberCode:${payVoidData1.memberCode},saleyymmdd:${payVoidData1.saleyymmdd},recognizeNo:${payVoidData1.recognizeNo},goodThru:${payVoidData1.goodThru},posReceiptNo:${payVoidData1.posReceiptNo},seqInqNo:${payVoidData1.seqInqNo}");
    //voidReceiptNoに画面入力のレシート番号、voidPosReceiptNoに画面入力の伝票番号を入れる,posReciptNoにはc_header_logから取得のものを入れている
    CalcRequestParaVoid req = CalcRequestParaVoid(
        compCd: pCom.dbRegCtrl.compCd,
        streCd: pCom.dbRegCtrl.streCd,
        macNo: pCom.dbRegCtrl.macNo,
        uuid: 'XXX',
        opeMode: opeMode1,
        voidMacNo: RcKyCrdtVoid.crdtVoid.macNo,
        voidSaleDate: RcKyCrdtVoid.crdtVoid.date,
        voidReceiptNo: RcKyCrdtVoid.crdtVoid.recNo,
        voidPrintNo: RcKyCrdtVoid.crdtVoid.printNo,
        voidPosReceiptNo: (RcKyCrdtVoid.crdtVoid.slipNo).toString(),
        payVoidList: payVoidList1);

    if (!RcClxosCommon.validClxos) {
      retData = await RcClxosPayment.stabPayVoid(req);
    } else {
      final stopWatch = Stopwatch();
      stopWatch.start();
      retData = await CalcApi.payVoid(req);
      stopWatch.stop();
      debugPrint(
          'Clxos CalcApi.payvoid()  ${stopWatch.elapsedMilliseconds}[ms]');
    }
    return retData;
  }

  ///検索領収書　クラウドPOS処理呼び出し
  static Future<CalcResultSearchReceipt> searchReceipt(RxCommonBuf pCom) async {
    CalcResultSearchReceipt retData = CalcResultSearchReceipt(
        retSts: 0,
        errMsg: "",
        posErrCd: null,
        totalData: null,
        digitalReceipt: null);

    int localPastSet = 0; // 上位サーバから取引実績を取得できたかのフラグ(TODO:暫定的にローカル参照を設定)
    CalcRequestParaSearchReceipt req = CalcRequestParaSearchReceipt(
        compCd: pCom.dbRegCtrl.compCd,
        streCd: pCom.dbRegCtrl.streCd,
        macNo: pCom.dbRegCtrl.macNo,
        uuid: 'XXX',
        opeMode: RckyErctfm.eRctfm.opeModeFlg,
        voidMacNo: RckyErctfm.eRctfm.macNo,
        voidSaleDate: RckyErctfm.eRctfm.date,
        voidReceiptNo: RckyErctfm.eRctfm.recNo,
        voidPrintNo: RckyErctfm.eRctfm.printNo,
        voidPastSet: localPastSet);

    if (!RcClxosCommon.validClxos) {
      retData = await stabPaySearchReceipt(req);
    } else {
      final stopWatch = Stopwatch();
      stopWatch.start();
      retData = await CalcApi.searchReceipt(req);
      stopWatch.stop();
      debugPrint(
          'Clxos CalcApi.payvoid()  ${stopWatch.elapsedMilliseconds}[ms]');
    }
    return retData;
  }

  static Future<CalcResultSearchReceipt> stabPaySearchReceipt(CalcRequestParaSearchReceipt para) async {
    CalcResultSearchReceipt result = CalcResultSearchReceipt(
        retSts: 0,
        errMsg: "",
        posErrCd: null,
        totalData: null,
        digitalReceipt: null);
    try {
      String tempRetData = "";
      final File file = File("/pj/tprx/testData/test_receipt.txt");
      if (file.existsSync()) {
        tempRetData = file.readAsStringSync();
      } else {
        tempRetData =
        '''{"RetSts":0,"ErrMsg":"","TotalData":{"Amount":210,"Payment":210,"Change":210},"DigitalReceipt":{"Transaction":{"ReceiptDateTime":"2023-11-13T18:46:03+09:00","WorkstationID":"3","ReceiptNumber":"25","TransactionID":"2023111000000000100001031000000000300250026","TRKReceiptImage":[{"LineSpace":6,"PrintType":"Line","CutType":"PartialCut","ReceiptLine":["@bitmap@Logo/receipt.bmp@/bitmap@","　　スーパーアークス　月寒東店    ","　　　　TEL (011)851-5115         ","本日はご来店有難うございます。    ","　                                ","　                                ","　　　　　＜領収書＞              ","                                  ","店No:000010310      ﾚｼﾞNo:000003  ","2023年11月13日(月曜日)  17時22分  ","                     ﾚｼｰﾄNo:0024  ","                                  ","＊＊＊＊＊＊訓練ﾓ-ﾄﾞ＊＊＊＊＊＊  ","外8  逸品　アボカド         ￥195　","----------- 訓練ﾓ-ﾄﾞ -----------  ","--------------------------------  "," 小計                       ￥195  ","(外税8%対象額               ￥195) "," 外税額            8%        ￥15  "," 買上点数                    1点  ","--------------------------------  ","@fontsizeH@合計        ￥210 @/fontsizeH@","@fontsizeH@            ￥210 @/fontsizeH@","           (内消費税等       ￥15) ","@fontsizeH@お釣り        ￥0 @/fontsizeH@","                                  ","外8内8は軽減税率対象商品です      ","@barC128_HNC@98231110002400000000300253@/barC128_HNC@","                                  ","@bitmap@cmlogo00000119.bmp@/bitmap@"]}]}}}''';
      }
      result = CalcResultSearchReceipt.fromJson(jsonDecode(tempRetData));
      result.retSts = 0;
    } catch (e) {}
    return (result);
  }

  /// 支払いの種類によってpayListを作成
  static Future<CalcRequestParaPay> funcKeyCheck(RxCommonBuf pCom, bool isCheck,
      {CalcRequestParaPay? requestParaPay}) async {
    CalcRequestParaItem req;
    CalcRequestParaPay payPara = CalcRequestParaPay(
        compCd: pCom.dbRegCtrl.compCd, streCd: pCom.dbRegCtrl.streCd);
    payPara.macNo = pCom.dbRegCtrl.macNo;
    TTtlLog tTtlLog = TTtlLog();
    int opeModeFlg = 0;

    // 再発行、領収書ではバックアップデータを使用する為の分岐
    // 追加変数がRegsMemの値の場合は会計時の方にRegsMemの値、再発行、領収書の方にバックアップデータを追加
    if (requestParaPay != null) {
      payPara.qcSendMacNo = requestParaPay.macNo;
      payPara.itemList = requestParaPay.itemList;
      tTtlLog = RegsMem().tTtllog;
      opeModeFlg = OpeModeFlagList.OPE_MODE_REG;
      payPara.subttlList = requestParaPay.subttlList;
    } else if (RegsMem().lastRequestData != null) {
      // 会計時はRegsMemのデータを使用
      req = RegsMem().lastRequestData!;
      req.macNo = pCom.dbRegCtrl.macNo;
      payPara.itemList = RegsMem().lastRequestData!.itemList;
      tTtlLog = RegsMem().tTtllog;
      opeModeFlg = RegsMem().tHeader.ope_mode_flg;
      // 小計値引き情報の設定
      payPara.subttlList = req.subttlList;
    } else {
      // 再発行、領収書の場合はバックアップデータを使用
      req = pCom.bkLastRequestData!;
      req.macNo = pCom.dbRegCtrl.macNo;
      payPara.itemList = pCom.bkLastRequestData!.itemList;
      tTtlLog = pCom.bkTtlLog;
      opeModeFlg = pCom.bkTHeader.ope_mode_flg;
      // 小計値引き情報の設定
      payPara.subttlList = req.subttlList;
    }

    for (int i = 0; i < tTtlLog.t100001Sts.sptendCnt; i++) {
      FuncKey key = FuncKey.getKeyDefine(tTtlLog.t100100[i].sptendCd);
      switch (key) {
        case FuncKey.KY_CASH:
          payPara.payList.add(PayData(
              payCode: tTtlLog.t100100[i].sptendCd,
              amount: tTtlLog.t100100[i].sptendData));
          break;
        case FuncKey.KY_CHA8:
        case FuncKey.KY_CHA3:
          RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
          if (xRet.isValid()) {
            RxTaskStatBuf tsBuf = xRet.object;
            payPara.payList
                .add((await getMultiPayData(i, tsBuf, pCom, key, isCheck, tTtlLog)));
          }
          break;
        // TODO:10158 商品券支払い　[暫定対応]
        //  固定キーではなく、商品券設定のキーを判定する仕組みにする必要あり
        case FuncKey.KY_CHK1:
        case FuncKey.KY_CHK2:
        case FuncKey.KY_CHK3:
        case FuncKey.KY_CHK4:
        case FuncKey.KY_CHK5:
        case FuncKey.KY_CHA30:
          if (tTtlLog.t100100[i].sptendSht > 1) {
            // 品券枚数が２枚以上の場合に枚数(sheet)をセットする
            // 支払い金額(amount)は券面額になる
            // 例：500円品券を4枚使って2000円支払いの場合、amount=500、sheet=4となる。
            payPara.payList.add(PayData(
                payCode: tTtlLog.t100100[i].sptendCd,
                amount: tTtlLog.t100100[i].sptendFaceAmt,
                sheet: tTtlLog.t100100[i].sptendSht));
          } else {
            payPara.payList.add(PayData(
              payCode: tTtlLog.t100100[i].sptendCd,
              amount: tTtlLog.t100100[i].sptendData,
            ));
          }
          break;
        default:
      }
    }

    payPara.opeMode = opeModeFlg;

    // 返品か
    if (RegsMem().refundFlag) {
      // 返品時は、返品フラグを立てて、返品日付を設定する
      payPara.refundFlag = 1;
      payPara.refundDate = RegsMem().refundDate;
    }

    payPara.posSpec = 0; // 通常.

    return payPara;
  }

  static Future<CalcRequestParaPay> getQcRequestParaPay(RxCommonBuf pCom,
      {bool isCheck = false}) async {
    CalcRequestParaPay payPara = await funcKeyCheck(pCom, isCheck);
    return payPara;
  }

  /// 支払いの種類に応じてpayListを作成.
  static Future<CalcRequestParaPay> makePayList(CalcRequestParaItem req,
      CalcRequestParaPay payPara, RxCommonBuf pCom, TTtlLog tTtlLog, CHeaderLog cHeaderLog) async {
    for (int i = 0; i < tTtlLog.t100001Sts.sptendCnt; i++) {
      FuncKey key = FuncKey.getKeyDefine(tTtlLog.t100100[i].sptendCd);
      switch (key) {
        case FuncKey.KY_CASH:
          payPara.payList.add(PayData(
              payCode: tTtlLog.t100100[i].sptendCd,
              amount: tTtlLog.t100100[i].sptendData));
          break;
        case FuncKey.KY_CHA8:
        case FuncKey.KY_CHA3:
          RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
          if (xRet.isValid()) {
            RxTaskStatBuf tsBuf = xRet.object;
            payPara.payList.add((await RcClxosPayment.getMultiPayData(
                i, tsBuf, pCom, key, false, tTtlLog)));
          }
          break;
      // TODO:10158 商品券支払い　[暫定対応]
      //  固定キーではなく、商品券設定のキーを判定する仕組みにする必要あり
        case FuncKey.KY_CHK1:
        case FuncKey.KY_CHK2:
        case FuncKey.KY_CHK3:
        case FuncKey.KY_CHK4:
        case FuncKey.KY_CHK5:
        case FuncKey.KY_CHA30:
          if (tTtlLog.t100100[i].sptendSht > 1) {
            // 品券枚数が２枚以上の場合に枚数(sheet)をセットする
            // 支払い金額(amount)は券面額になる
            // 例：500円品券を4枚使って2000円支払いの場合、amount=500、sheet=4となる。
            payPara.payList.add(PayData(
                payCode: tTtlLog.t100100[i].sptendCd,
                amount: tTtlLog.t100100[i].sptendFaceAmt,
                sheet: tTtlLog.t100100[i].sptendSht));
          } else {
            payPara.payList.add(PayData(
              payCode: tTtlLog.t100100[i].sptendCd,
              amount: tTtlLog.t100100[i].sptendData,
            ));
          }
        default:
      }
    }
    payPara.opeMode = cHeaderLog.ope_mode_flg;
    // 返品か
    if (RegsMem().refundFlag) {
      // 返品時は、返品フラグを立てて、返品日付を設定する
      payPara.refundFlag = 1;
      payPara.refundDate = RegsMem().refundDate;
    }
    payPara.posSpec = 0; // 通常.

    return payPara;
  }

  /// 支払操作.
  /// クラウドPOSに渡すリクエストパラメータを作成.
  static Future<CalcRequestParaPay> makeRequestParaPayment(RxCommonBuf pCom, bool isCheck,
      {CalcRequestParaPay? requestParaPay}) async {
    CalcRequestParaItem req = RegsMem().lastRequestData!;
    req.macNo = pCom.dbRegCtrl.macNo;
    CalcRequestParaPay payPara = CalcRequestParaPay(
        compCd: pCom.dbRegCtrl.compCd, streCd: pCom.dbRegCtrl.streCd);
    payPara.macNo = pCom.dbRegCtrl.macNo;
    payPara.itemList = RegsMem().lastRequestData!.itemList;
    TTtlLog tTtlLog = RegsMem().tTtllog;
    CHeaderLog cHeaderLog = RegsMem().tHeader;

    payPara = await makePayList(req, payPara, pCom, tTtlLog, cHeaderLog);

    return payPara;
  }

  /// 再発行操作.
  /// クラウドPOSに渡すリクエストパラメータを作成.
  static Future<CalcRequestParaPay> makeRequestParaReprint(RxCommonBuf pCom, bool isCheck,
      {CalcRequestParaPay? requestParaPay}) async {
    CalcRequestParaItem req = pCom.bkLastRequestData!;
    req.macNo = pCom.dbRegCtrl.macNo;
    CalcRequestParaPay payPara = CalcRequestParaPay(
        compCd: pCom.dbRegCtrl.compCd, streCd: pCom.dbRegCtrl.streCd);
    payPara.macNo = pCom.dbRegCtrl.macNo;
    payPara.itemList = pCom.bkLastRequestData!.itemList;
    TTtlLog tTtlLog = pCom.bkTtlLog;
    CHeaderLog cHeaderLog = pCom.bkTHeader;

    payPara = await makePayList(req, payPara, pCom, tTtlLog, cHeaderLog);

    return payPara;
  }

  /// 領収書操作.
  /// クラウドPOSに渡すリクエストパラメータを作成.
  static Future<CalcRequestParaPay> makeRequestParaReceipt(RxCommonBuf pCom, bool isCheck,
      {CalcRequestParaPay? requestParaPay}) async {
    CalcRequestParaItem req = pCom.bkLastRequestData!;
    req.macNo = pCom.dbRegCtrl.macNo;
    CalcRequestParaPay payPara = CalcRequestParaPay(
        compCd: pCom.dbRegCtrl.compCd, streCd: pCom.dbRegCtrl.streCd);
    payPara.macNo = pCom.dbRegCtrl.macNo;
    payPara.itemList = pCom.bkLastRequestData!.itemList;
    TTtlLog tTtlLog = pCom.bkTtlLog;
    CHeaderLog cHeaderLog = pCom.bkTHeader;

    payPara = await makePayList(req, payPara, pCom, tTtlLog, cHeaderLog);

    return payPara;
  }
}
