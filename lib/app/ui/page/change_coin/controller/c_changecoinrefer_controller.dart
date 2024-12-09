/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/apl/rxregmem_define.dart';
import 'package:flutter_pos/app/inc/lib/if_acx.dart';
import 'package:flutter_pos/app/regs/inc/rc_mem.dart';
import 'package:get/get.dart';
import '../../../../lib/if_acx/acx_com.dart';
import '../../../../regs/checker/rc_acracb.dart';
import '../../../../regs/checker/rc_cash_recycle.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../component/w_inputbox.dart';
import '../model/m_changemodels.dart';

/// 釣機入金画面のコントローラ
class ChangeCoinReferController extends GetxController {
  /// 釣り機情報（収納庫）
  List<ChangeData> storageChangeData = List.generate(10, (index) =>
      ChangeData(
          billCoinType: BillCoinType.coin,
          amount: 0,
          count: 0,
          kindFlg:HolderFlagList.HOLDER_NON,
          percentage: 0,
          color: BaseColor.changeCoinBillCoinColor,
          barColor: BaseColor.transparentColor,
      ));

  /// 釣り機情報（金庫）
  List<ChangeData> safeChangeData = List.generate(10, (index) =>
      ChangeData(
        billCoinType: BillCoinType.coin,
        amount: 0,
        count: 0,
        kindFlg:HolderFlagList.HOLDER_NON,
        percentage: 0,
        color: BaseColor.changeCoinBillCoinColor,
        barColor: BaseColor.transparentColor,
      ));

  /// 収納庫の合計額
  var storageSumAmount = 0.obs;
  /// 金庫の合計額
  var safeSumAmount = 0.obs;

  var stockStat = 0.obs;

  /// 紙幣の種類数
  final int billCount = CoinBillKindList.CB_KIND_01000.id + 1;
  /// 紙幣/硬貨の種類数
  final int billCoinCount = CoinBillKindList.CB_KIND_MAX.id;

  /// 紙幣/硬貨の金額
  static const List<int> amountList = [10000, 5000, 2000, 1000, 500, 100, 50, 10, 5, 1];

  @override
  void onInit() {
    super.onInit();
  }

  /// 釣り機情報を取得する
  Future<void> getChangeData() async {
    AcMem cMem = SystemFunc.readAcMem();
    await RcAcracb.rcAcrAcbBeforeMemorySet(cMem.coinData);

    setStorageChangeData();
    setSafeChangeData();
    updateStockStat();
  }

  /// 動作確認用データ作成（収納庫）
  void setStorageChangeData() {
    RxMemRet xRet1 = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet1.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet1.object;
    RxMemRet xRet2 = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet2.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet2.object;

    storageSumAmount.value = 0;
    RegsMem mem = RegsMem();

    List<int> count = [
      mem.tTtllog.t100600Sts.bfreStockSht10000,
      mem.tTtllog.t100600Sts.bfreStockSht5000,
      mem.tTtllog.t100600Sts.bfreStockSht2000,
      mem.tTtllog.t100600Sts.bfreStockSht1000,
      mem.tTtllog.t100600Sts.bfreStockSht500,
      mem.tTtllog.t100600Sts.bfreStockSht100,
      mem.tTtllog.t100600Sts.bfreStockSht50,
      mem.tTtllog.t100600Sts.bfreStockSht10,
      mem.tTtllog.t100600Sts.bfreStockSht5,
      mem.tTtllog.t100600Sts.bfreStockSht1,
    ];

    int i = 0;
    while (i < billCoinCount) {
      BillCoinType billCoinType = BillCoinType.bill;
      if (i >= billCount) {
        billCoinType = BillCoinType.coin;
      }

      // 状態を示す文字色
      Color color = BaseColor.transparentColor;  // 黒
      if (tsBuf.acx.holderStatus.kindFlg[i] == HolderFlagList.HOLDER_NON) {
        color = BaseColor.changeCoinBillCoinColor;  // グレー
      }
      else if ((tsBuf.acx.holderStatus.kindFlg[i] == HolderFlagList.HOLDER_EMPTY)
            || (tsBuf.acx.holderStatus.kindFlg[i] == HolderFlagList.HOLDER_NEAR_END)) {
        color = BaseColor.attentionColor;  // 赤
      }
      else if ((tsBuf.acx.holderStatus.kindFlg[i] == HolderFlagList.HOLDER_NEAR_FULL)
            || (tsBuf.acx.holderStatus.kindFlg[i] == HolderFlagList.HOLDER_NEAR_FULL_BFR_ALERT)
            || (tsBuf.acx.holderStatus.kindFlg[i] == HolderFlagList.HOLDER_FULL)) {
        color = BaseColor.changeCoinCollectFontColor;  // 黄土色
      }

      // バー、枠線の色
      Color barColor = BaseColor.accentsColor;            // 青
      if ((tsBuf.acx.holderStatus.kindFlg[i] == HolderFlagList.HOLDER_EMPTY) ||
          (tsBuf.acx.holderStatus.kindFlg[i] == HolderFlagList.HOLDER_NEAR_END)) {
        barColor = BaseColor.attentionColor;             // 赤
      }
      else if((tsBuf.acx.holderStatus.kindFlg[i] == HolderFlagList.HOLDER_FULL)
           || (tsBuf.acx.holderStatus.kindFlg[i] == HolderFlagList.HOLDER_NEAR_FULL)
           || (tsBuf.acx.holderStatus.kindFlg[i] == HolderFlagList.HOLDER_NEAR_FULL_BFR_ALERT)) {
        barColor = BaseColor.changeCoinCollectBarColor;  // 黄色
      }

      storageChangeData[i].billCoinType   = billCoinType;
      storageChangeData[i].amount         = amountList[i];
      storageChangeData[i].count          = count[i];
      storageChangeData[i].kindFlg        = tsBuf.acx.holderStatus.kindFlg[i];
      storageChangeData[i].percentage     = tsBuf.acx.holderStatus.percentage[i];
      storageChangeData[i].color          = color;
      storageChangeData[i].barColor       = barColor;
      storageSumAmount.value += count[i] * amountList[i];
      i++;
    }
  }

  /// 動作確認用データ作成（金庫）
  void setSafeChangeData() {
    safeSumAmount.value = 0;
    RegsMem mem = RegsMem();

    List<int> count = [
      mem.tTtllog.t100600Sts.bfreStockPolSht10000,
      mem.tTtllog.t100600Sts.bfreStockPolSht5000,
      mem.tTtllog.t100600Sts.bfreStockPolSht2000,
      mem.tTtllog.t100600Sts.bfreStockPolSht1000,
      mem.tTtllog.t100600Sts.bfreStockPolSht500,
      mem.tTtllog.t100600Sts.bfreStockPolSht100,
      mem.tTtllog.t100600Sts.bfreStockPolSht50,
      mem.tTtllog.t100600Sts.bfreStockPolSht10,
      mem.tTtllog.t100600Sts.bfreStockPolSht5,
      mem.tTtllog.t100600Sts.bfreStockPolSht1,
    ];

    List<int> percentage = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    int i = 0;
    while (i < billCoinCount) {
      BillCoinType billCoinType = BillCoinType.bill;
      if (i >= billCount) {
        billCoinType = BillCoinType.coin;
      }

      // 状態を示す文字色
      Color color = BaseColor.changeCoinBillCoinColor;

      // バー、枠線の色
      Color barColor = BaseColor.transparentColor;

      safeChangeData[i].billCoinType   = billCoinType;
      safeChangeData[i].amount         = amountList[i];
      safeChangeData[i].count          = count[i];
      safeChangeData[i].kindFlg        =
        (count[i] > 0 ? HolderFlagList.HOLDER_NORMAL: HolderFlagList.HOLDER_NON);
      safeChangeData[i].percentage     = percentage[i];
      safeChangeData[i].color          = color;
      safeChangeData[i].barColor       = barColor;
      safeSumAmount.value += count[i] * amountList[i];
      i++;
    }
  }

  /// 紙幣収納庫、硬貨収納庫のどちらかが不確定であれば、不確定を編訳する。
  /// 0:確定／1:不確定
  void updateStockStat() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      stockStat.value = 1;
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    stockStat.value = AcxCom.ifAcxStockStateChk(tsBuf.acx.stockState);
  }
}
