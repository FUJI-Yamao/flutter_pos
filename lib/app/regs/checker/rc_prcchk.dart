/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../clxos/calc_api_result_data.dart';
import '../../common/cmn_sysfunc.dart';
import '../../ui/page/price_check/controller/c_price_check_controller.dart';
import '../../ui/page/price_check/model/m_mix_match_data.dart';
import '../../ui/page/price_check/model/m_price_check_data.dart';
import '../inc/rc_mem.dart';


/// 関連tprxソース: 機能の役割はrc_prcchk.cと同じ、ただし関係性が薄い
/// 価格確認　バックエンド
class RcPrcChk {

  /// 価格確認バックエンド　画面項目の処理
  /// 戻り値：（左から順番に）値引の有無、一般特売売価の有無、会員特売売価の有無、ミックスマッチの有無
  static (bool, bool, bool, bool) setPriceCheckData(CalcResultItem item) {
    /// 値引の有無　デフォルト値：値引なし
    bool discntFlg = false;
    /// 一般特売売価の有無　デフォルト値：一般特売売価なし
    bool brgnFlg = false;
    /// 会員特売売価の有無　デフォルト値：会員特売売価なし
    bool brgnCustFlg = false;
    /// ミックスマッチの有無　デフォルト値：ミックスマッチなし
    bool mixMatchFlg = false;

    try {
      AcMem cMem = SystemFunc.readAcMem();
      PriceCheckController priceCheckCtrl = Get.find();

      priceCheckCtrl.clearPriceData();
      /// 画面主要項目：商品表示名、JANコード、分類コード＆分類名称
      priceCheckCtrl.setPriceDataHeader(item.calcResultItemList![0].name!, cMem.working.janInf.code,
          '${(item.calcResultItemList![0].priceList![0].mdlClsCd!).toString().padLeft(6, '0')}:${item.calcResultItemList![0].priceList![0].mdlClsName!}　${(item.calcResultItemList![0].priceList![0].smlClsCd!).toString().padLeft(6, '0')}:${item.calcResultItemList![0].priceList![0].smlClsName!}');
      /// 適用売価
      PriceCheckData data = PriceCheckData(priceType: PriceType.nowPrice, price: item.calcResultItemList![0].priceList![0].posPrice!);
      if (null != item.calcResultItemList![0].discountList && item.calcResultItemList![0].discountList!.isNotEmpty) {
        // 値引の設定リストにデータが存在する場合のみ、値引関連項目を設定
        data.setDiscountValue(item.calcResultItemList![0].discountList![0].name!, item.calcResultItemList![0].discountList![0].discountPrice!);
        discntFlg = true;
      }
      priceCheckCtrl.addPriceCheckData(data);
      /// 一般通常売価
      data = PriceCheckData(priceType: PriceType.price, price: item.calcResultItemList![0].price!,);
      priceCheckCtrl.addPriceCheckData(data);
      if (0 != item.calcResultItemList![0].priceList![0].brgnPrice!) {
        /// 一般特売売価
        data = PriceCheckData(priceType: PriceType.bargainPrice, price: item.calcResultItemList![0].priceList![0].brgnPrice!,);
        priceCheckCtrl.addPriceCheckData(data);
        brgnFlg = true;
      }
      if (0 != item.calcResultItemList![0].priceList![0].brgnCustPrice!) {
        /// 会員特売売価
        data = PriceCheckData(priceType: PriceType.bargainMemberPrice, price: item.calcResultItemList![0].priceList![0].brgnCustPrice!,);
        priceCheckCtrl.addPriceCheckData(data);
        brgnCustFlg = true;
      }

      // ミックスマッチが表示されるかどうかを決める値（売価１～売価5、いずれも0の場合ならミックスマッチ非表示）
      int mixMatchFlgVal = item.calcResultItemList![0].priceList![0].bdlFormQty1!
          +item.calcResultItemList![0].priceList![0].bdlFormQty2!
          +item.calcResultItemList![0].priceList![0].bdlFormQty3!
          +item.calcResultItemList![0].priceList![0].bdlFormQty4!
          +item.calcResultItemList![0].priceList![0].bdlFormQty5!;
      if (0 != mixMatchFlgVal) {
        // ミックスマッチが表示されるようになる
        mixMatchFlg = true;
        late MixMatchItem mixMatchItem;
        List<MixMatchItem> mixMatchItems = <MixMatchItem>[];
        int mixMatchAvgStat = item.calcResultItemList![0].priceList![0].bdlFormPrc1!
            +item.calcResultItemList![0].priceList![0].bdlFormPrc2!
            +item.calcResultItemList![0].priceList![0].bdlFormPrc3!
            +item.calcResultItemList![0].priceList![0].bdlFormPrc4!
            +item.calcResultItemList![0].priceList![0].bdlFormPrc5!;
        int mixMatchAvgCustStat = item.calcResultItemList![0].priceList![0].bdlFormCustPrc1!
            +item.calcResultItemList![0].priceList![0].bdlFormCustPrc2!
            +item.calcResultItemList![0].priceList![0].bdlFormCustPrc3!
            +item.calcResultItemList![0].priceList![0].bdlFormCustPrc4!
            +item.calcResultItemList![0].priceList![0].bdlFormCustPrc5!;

        /// ミックスマッチ条件１
        if (0 != item.calcResultItemList![0].priceList![0].bdlFormQty1!) {
          mixMatchItem = MixMatchItem(conditionName: '条件1',
              generalQty: item.calcResultItemList![0].priceList![0].bdlFormQty1!,
              generalPrice: item.calcResultItemList![0].priceList![0].bdlFormPrc1!,
              memberQty: item.calcResultItemList![0].priceList![0].bdlFormQty1!,
              memberPrice: item.calcResultItemList![0].priceList![0].bdlFormCustPrc1!);
          mixMatchItems.add(mixMatchItem);
        }
        /// ミックスマッチ条件２
        if (0 != item.calcResultItemList![0].priceList![0].bdlFormQty2!) {
          mixMatchItem = MixMatchItem(conditionName: '条件2',
              generalQty: item.calcResultItemList![0].priceList![0].bdlFormQty2!,
              generalPrice: item.calcResultItemList![0].priceList![0].bdlFormPrc2!,
              memberQty: item.calcResultItemList![0].priceList![0].bdlFormQty2!,
              memberPrice: item.calcResultItemList![0].priceList![0].bdlFormCustPrc2!);
          mixMatchItems.add(mixMatchItem);
        }
        /// ミックスマッチ条件３
        if (0 != item.calcResultItemList![0].priceList![0].bdlFormQty3!) {
          mixMatchItem = MixMatchItem(conditionName: '条件3',
              generalQty: item.calcResultItemList![0].priceList![0].bdlFormQty3!,
              generalPrice: item.calcResultItemList![0].priceList![0].bdlFormPrc3!,
              memberQty: item.calcResultItemList![0].priceList![0].bdlFormQty3!,
              memberPrice: item.calcResultItemList![0].priceList![0].bdlFormCustPrc3!);
          mixMatchItems.add(mixMatchItem);
        }
        /// ミックスマッチ条件４
        if (0 != item.calcResultItemList![0].priceList![0].bdlFormQty4!) {
          mixMatchItem = MixMatchItem(conditionName: '条件4',
              generalQty: item.calcResultItemList![0].priceList![0].bdlFormQty4!,
              generalPrice: item.calcResultItemList![0].priceList![0].bdlFormPrc4!,
              memberQty: item.calcResultItemList![0].priceList![0].bdlFormQty4!,
              memberPrice: item.calcResultItemList![0].priceList![0].bdlFormCustPrc4!);
          mixMatchItems.add(mixMatchItem);
        }
        /// ミックスマッチ条件５
        if (0 != item.calcResultItemList![0].priceList![0].bdlFormQty5!) {
          mixMatchItem = MixMatchItem(conditionName: '条件5',
              generalQty: item.calcResultItemList![0].priceList![0].bdlFormQty5!,
              generalPrice: item.calcResultItemList![0].priceList![0].bdlFormPrc5!,
              memberQty: item.calcResultItemList![0].priceList![0].bdlFormQty5!,
              memberPrice: item.calcResultItemList![0].priceList![0].bdlFormCustPrc5!);
          mixMatchItems.add(mixMatchItem);
        }
        /// 成立後平均単価
        MixMatchData mixMatchData = MixMatchData(mixMatchItems: mixMatchItems,
            generalAverageUnitPrice: item.calcResultItemList![0].priceList![0].bdlAvg!,
            memberAverageUnitPrice: item.calcResultItemList![0].priceList![0].bdlCustAvg!,
            isGeneralExist: (0 != mixMatchAvgStat),
            isMemberExist: (0 != mixMatchAvgCustStat));
        priceCheckCtrl.setMixMatchData(mixMatchData);
      }
      return(discntFlg, brgnFlg, brgnCustFlg, mixMatchFlg);
    } catch(_)
    {
      debugPrint('setPriceCheckData() Error');
      return(false, false, false, false);
    }
  }
}