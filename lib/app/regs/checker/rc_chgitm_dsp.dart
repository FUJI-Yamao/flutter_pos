/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../clxos/calc_api.dart';
import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_log.dart';
import '../../ui/page/register/controller/c_registerbody_controller.dart';
import '../../ui/socket/client/customer_socket_client.dart';
import '../inc/rc_regs.dart';
import '../spool/rsmain.dart';
import 'rc_clxos.dart';
import 'rcky_plu.dart';
import 'rcsyschk.dart';

enum DscChangeType {
  none,
  dsc, //1.単品値引き
  pdsc //2.単品割引
}

///　「明細変更」処理.
/// 関連tprxソース:rcchgitm_dsp.c
class RcKeyChangeItem {
  /// 明細変更の実行処理.
  ///  関連tprxソース: rcchgitm_dsp.c - rcChgItm_CalcMain()
  static Future<CalcResultWithRawJson> rcChgItmCalcMain(int index,
      {DscChangeType? dscType,
      int dscValue = 0,
      int dscCode = 0,
      int prcChgVal = 0,
      int qty = 0,
      int type = 0}) async {
    return await changeItemDataClxos(index,
        dscType: dscType,
        dscValue: dscValue,
        dscCode: dscCode,
        prcChgVal: prcChgVal,
        qty: qty,
        type: type);
  }

  /// 客表画面が開かれている場合はtrue
  static bool customerScreen = true;

  /// クラウドPOSへ商品情報変更データを送る.
  static Future<CalcResultWithRawJson> changeItemDataClxos(int index,
      {DscChangeType? dscType,
      int dscValue = 0,
      int dscCode = 0,
      int prcChgVal = 0,
      int qty = 0,
      int type = 0}) async {
    final RegisterBodyController regBodyCtrl = Get.find();
    if (RegsMem().tItemLog.length <= index ) {
      return CalcResultWithRawJson(
          rawJson: '',
          result: CalcResultItem(
              retSts: -1,
              errMsg: "変更できる商品データがありません",
              posErrCd: null,
              calcResultItemList: [],
              totalDataList: null,
              custData: null,
              subttlList:null));
    }

    CalcRequestParaItem req = RegsMem().lastRequestData!;
    // 成功しなかった場合はリセットsるうため、バックアップを取得.
    Map<String, dynamic> beforeData = req.itemList[index].toMap();
// 登録/取消/カゴ抜け.
    req.itemList[index].type = type;
    req.itemList[index].qty = qty;
    if (dscType != null && dscType != DscChangeType.none) {
      req.itemList[index].itemDscType = dscType.index;
      req.itemList[index].itemDscVal = dscValue;
      req.itemList[index].itemDscCode = dscCode;
    }
    if (prcChgVal != 0) {
      req.itemList[index].prcChgVal = prcChgVal;
    }
    req.opeMode = RegsMem().tHeader.ope_mode_flg;
    req.refundFlag = RegsMem().refundFlag ? 1 : 0;
    req.posSpec = 0;// 通常状態
    final stopWatch = Stopwatch();
    stopWatch.start();
    // 価格変更情報をクラウドPOSに送信

    CalcResultWithRawJson resultWithJson;
    if (!RcClxosCommon.validClxos) {
      resultWithJson =
          await RcClxosCommon.stabItem(req); // await CalcApi().item(req);
    } else {
      resultWithJson = await CalcApi.loadItem(req);
    }
    debugPrint(
        'Clxos CalcApi.loadItem()  ${stopWatch.elapsedMilliseconds}[ms]');
    int err = resultWithJson.result.getErrId();
    if (err != 0) {
      // 何らかのエラー.
      req.itemList[index] = ItemData.fromJson(beforeData);
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "ChangeItemData ${resultWithJson.result.errMsg}");
      return CalcResultWithRawJson(
          rawJson: '',
          result: CalcResultItem(
              retSts: -1,
              errMsg: resultWithJson.result.errMsg,
              posErrCd: null,
              calcResultItemList: [],
              totalDataList: null,
              custData: null,
              subttlList:null));
    } else {
      RcClxosCommon.settingMemResultData(resultWithJson.result);
      if (customerScreen) {
        // 客側に商品登録メッセージを送る
        CustomerSocketClient().sendItemRegister(resultWithJson.rawJson);
      }
      // スプールテンポラリファイル出力
      if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
        RsMain.rsWriteTempFile(resultWithJson.rawJson);
      }
    }

    return resultWithJson;
  }
}
