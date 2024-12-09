/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';
import '../../inc/apl/fnc_code.dart';

import '../../ui/page/difference_check/model/m_changemodels.dart';
import '../../ui/page/sales_collection/p_sales_collection.dart';

class RckySalesCollection {
  /// 売り上げ回収画面を開く
  /// 関連tprxソース: rckycref.c
  static void openSalesCollection(String title, FuncKey key) {
    // 現金以外表　リスト作成
    List<NonCashData> nonCashList = List.generate(
        35,
        (index) => NonCashData(
              title: "",
              value: 0,
            )).obs;

    // ドロア在高用リスト 作成
    List<ChangeData> valueList = List.generate(
        10,
        (index) => ChangeData(
              billCoinType: cashType[index] >= 1000
                  ? BillCoinType.bill
                  : BillCoinType.coin,
              amount: cashType[index],
              value: 0,
            )).obs;

    Get.to(() => SalesCollectionPage(
        title: title, funcKey: key, nonCash: nonCashList, cashData: valueList));
  }
}
