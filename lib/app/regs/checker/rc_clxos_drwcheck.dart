/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/regs/checker/rc_clxos.dart';
import 'package:flutter_pos/app/regs/checker/rc_clxos_payment.dart';

import '../../../clxos/calc_api.dart';
import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';

/// クラウドPOSを利用する場合の差異チェック処理の関連のクラス.
class RcClxosDrawerCheck{
  /// クラウドPOS（差異チェック）を呼び出す
  static Future<CalcResultDrwchkWithRawJson> rcDrawerCheck(RxCommonBuf pCom) async {
    CalcRequestDrwchk para = CalcRequestDrwchk(compCd: pCom.dbRegCtrl.compCd, streCd: pCom.dbRegCtrl.streCd, macNo: pCom.dbRegCtrl.macNo);
    RegsMem regsMem = SystemFunc.readRegsMem();
    para.opeMode = regsMem.tHeader.ope_mode_flg;

    para.inoutInfo = InoutInfo();
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

    CalcResultDrwchkWithRawJson retData;
    if (!RcClxosCommon.validClxos) {
      retData = await stabCheckDrw();
    } else {
      final stopWatch = Stopwatch();
      stopWatch.start();
      retData = await CalcApi.checkDrw(para);
      stopWatch.stop();
      debugPrint(
          'Clxos CalcApi.checkDrw()  ${stopWatch.elapsedMilliseconds}[ms]');
    }
    return retData;
  }

  /// 下記はWindowsのみの処理
  static Future<CalcResultDrwchkWithRawJson> stabCheckDrw() async {
    String rawJson = '';
    CalcResultDrwchk result =  CalcResultDrwchk(retSts: 0,errMsg: "",paychkDataList: null,cashInfoData: null,chaInfoData: null,chkInfoData: null);

    try {
      String tempRetData = "";
      final File file = File("/pj/tprx/testData/test_checkDrw.txt"); // 適宜、ファイル名と内容を編集
      if (file.existsSync()) {
        tempRetData = file.readAsStringSync();
      } else {
        tempRetData =
        r'''{"RetSts":0,"ErrMsg":"","PayList":[{"GroupID":1,"Code":14,"Name":"預り\/現計","Order":0,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":15,"Name":"その他金券","Order":0,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":16,"Name":"ギフト券","Order":1,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":2,"Code":17,"Name":"iD","Order":0,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":2,"Code":18,"Name":"プリカ","Order":1,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":19,"Name":"売掛","Order":2,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":2,"Code":20,"Name":"ﾊﾞｰｺｰﾄﾞ決済","Order":2,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":21,"Name":"買物券","Order":3,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":2,"Code":22,"Name":"QUICPay","Order":3,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":23,"Name":"ｵﾌｸﾚ","Order":4,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":2,"Code":24,"Name":"ｸﾚｼﾞｯﾄ","Order":4,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":384,"Name":"会計11","Order":5,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":385,"Name":"会計12","Order":6,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":386,"Name":"会計13","Order":7,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":387,"Name":"会計14","Order":8,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":388,"Name":"会計15","Order":9,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":389,"Name":"会計16","Order":10,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":390,"Name":"会計17","Order":11,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":391,"Name":"会計18","Order":12,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":392,"Name":"会計19","Order":13,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":393,"Name":"会計20","Order":14,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":394,"Name":"会計21","Order":15,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":395,"Name":"会計22","Order":16,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":396,"Name":"会計23","Order":17,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":397,"Name":"会計24","Order":18,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":398,"Name":"会計25","Order":19,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":399,"Name":"会計26","Order":20,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":400,"Name":"会計27","Order":21,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":401,"Name":"会計28","Order":22,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":402,"Name":"会計29","Order":23,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":403,"Name":"会計30","Order":24,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":26,"Name":"品券1","Order":25,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":27,"Name":"品券2","Order":26,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":28,"Name":"品券3","Order":27,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":29,"Name":"品券4","Order":28,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0},{"GroupID":3,"Code":30,"Name":"品券5","Order":29,"TheoryAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0}],"CashInfo":{"TotalAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0,"OtherAmt":0},"ChaInfo":{"TotalAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0,"OtherAmt":0},"ChkInfo":{"TotalAmt":0,"LoanAmt":0,"InAmt":0,"OutAmt":0,"PickAmt":0,"OtherAmt":0}}''';
      }
      result = CalcResultDrwchk.fromJson(jsonDecode(tempRetData));
      result.retSts = 0;
    } catch (e) {}
    return CalcResultDrwchkWithRawJson(rawJson: rawJson, result:  result);
  }
}
/// UIにJSONデータを返せるように新しい返り値の定義
class CalcResultDrwchkWithRawJson {
  // クラウドPOS（差異チェック）のレスポンスJSONデータ
  final String rawJson;
  // クラウドPOS（差異チェック）のレスポンスデータ
  final CalcResultDrwchk result;

  CalcResultDrwchkWithRawJson({required this.rawJson, required this.result});
}
