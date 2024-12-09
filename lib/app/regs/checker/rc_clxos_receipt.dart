/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/regs/checker/rc_clxos.dart';
import 'package:flutter_pos/app/regs/checker/rc_clxos_payment.dart';

import '../../../clxos/calc_api.dart';
import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../inc/apl/rxmem_define.dart';

class RcClxosRpr{
  static Future<CalcResultPay> receipt(RxCommonBuf pCom) async {

    CalcRequestParaPay payPara = await RcClxosPayment.makeRequestParaReceipt(pCom, false);

    CalcResultPay retData;
    if (!RcClxosCommon.validClxos) {
      retData = await RcClxosPayment.stabPay(payPara);
    } else {
      final stopWatch = Stopwatch();
      stopWatch.start();
      retData = await CalcApi.receipt(payPara);
      stopWatch.stop();
      debugPrint(
          'Clxos CalcApi.receipt()  ${stopWatch.elapsedMilliseconds}[ms]');
    }
    return retData;
  }

  static Future<CalcResultPay> reprint(RxCommonBuf pCom) async {

    CalcRequestParaPay payPara = await RcClxosPayment.makeRequestParaReprint(pCom, false);

    CalcResultPay retData;
    if (!RcClxosCommon.validClxos) {
      retData = await RcClxosPayment.stabPay(payPara);
    } else {
      final stopWatch = Stopwatch();
      stopWatch.start();
      retData = await CalcApi.reprint(payPara);
      stopWatch.stop();
      debugPrint(
          'Clxos CalcApi.reprint()  ${stopWatch.elapsedMilliseconds}[ms]');
    }
    return retData;
  }
}
