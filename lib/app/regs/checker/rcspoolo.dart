/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get.dart' as getx;

import '../inc/rc_regs.dart';
import '../spool/rsmain.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_log_define.dart';
import '../../ui/page/register/controller/c_registerbody_controller.dart';
import '../../../clxos/calc_api_result_data.dart';
import 'rc_chgitm_dsp.dart';
import 'rcsyschk.dart';

class RcSpoolo {
  ///  関連tprxソース: rcspoolo.c - rcSpoolOut
  static Future<void> rcSpoolOut() async {
    if (await RcSysChk.rcKySelf() != RcRegs.KY_DUALCSHR) {
      return;
    }
    int count = await RsMain.getSpoolCount();
    // スプールファイルに読み込む
    if (count > 0) {
      ResultRsMem result = RsMain.rsReadSpoolFile(RsMain.spoolMin);
      if( result.ret == RsMain.RS_OK && result.buf != '' ){
        RsMain.downSpoolCount();
        RsMain.rsShiftFile(count);

        // 商品登録の処理
        try {
          CalcResultItem calcResultItem = CalcResultItem.fromJson(jsonDecode(result.buf));
          if (calcResultItem.retSts == 0) {
            RegisterBodyController bodyCtrl = Get.find();
            if (bodyCtrl.purchaseData.isEmpty) {
              List<ResultItemData> itemList = calcResultItem.calcResultItemList!;
              for(int i=0;i<itemList.length; i++) {
                if (itemList[i].retSts == 0) {
                  if (itemList[i].barcode != null) {
                    await bodyCtrl.selectedPlu(itemList[i].barcode!, 1);
                    //明細変更の処理
                    int prcChgVal = 0;
                    int dscType   = 0;
                    int dscValue  = 0;
                    int dscCode   = 0;
                    int qty       = 0;
                    int type      = 0;
                    if(itemList[i].prcChgVal != null) {
                      prcChgVal = itemList[i].prcChgVal!;
                    }
                    if(itemList[i].itemDscType != null) {
                      dscType = itemList[i].itemDscType!;
                    }
                    if(itemList[i].itemDscVal != null) {
                      dscValue = itemList[i].itemDscVal!;
                    }
                    if(itemList[i].itemDscCode != null) {
                      dscCode = itemList[i].itemDscCode!;
                    }
                    if(itemList[i].qty != null) {
                      qty = itemList[i].qty!;
                    }
                    if(itemList[i].type != null) {
                      type = itemList[i].type!;
                    }
                    final resultWithJson = await RcKeyChangeItem.rcChgItmCalcMain(
                        i,
                        prcChgVal: prcChgVal,             // 売価変更金額
                        dscType: DscChangeType.values.firstWhere((element) =>
                            element.index == dscType),    // 値下タイプ
                        dscValue: dscValue,               // 値下額
                        dscCode: dscCode,                 // 値下コード
                        qty: qty,                         // 登録点数
                        type: type);                      // 0:通常　1:取消　2:カゴ抜け　　3:期限切れ
                  }
                }
              }
            }
          }
        } catch (e) {
          TprLog().logAdd(
            Tpraid.TPRAID_NONE, LogLevelDefine.error,
            "rcSpoolOut JsonDecode(mapData['result.buf']) Error $e",
          );
          return;
        }

      }
    }
    
    return ;
  }
}