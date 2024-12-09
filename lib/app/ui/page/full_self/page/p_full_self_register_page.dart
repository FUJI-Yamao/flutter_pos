/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/number_util.dart';
import '../../../../if/if_drv_control.dart';
import '../../../../inc/apl/fnc_code.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/sys/tpr_aid.dart';
import '../../../../regs/checker/rc_key.dart';
import '../../../../regs/checker/rcky_plu.dart';
import '../../../../regs/checker/rcky_stl.dart';
import '../../../../regs/checker/rcsyschk.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_trainingModeText.dart';
import '../../../controller/c_drv_controller.dart';
import '../../../language/l_languagedbcall.dart';
import '../../common/component/w_msgdialog.dart';
import '../component/w_full_self_footer.dart';
import '../component/w_full_self_register_footer_upper.dart';
import '../component/w_full_self_sumArea.dart';
import '../component/w_full_self_topbar.dart';
import '../controller/c_full_self_register_controller.dart';
import '../enum/e_full_self_kind.dart';

/// フルセルフの商品登録画面
class FullSelfRegisterPage extends StatelessWidget  with RegisterDeviceEvent {
   FullSelfRegisterPage({super.key}) {
    Get.put(FullSelfRegisterController());
    registrationEvent();
  }

   //訓練モード判定
  final bool isTrainingMode = RcSysChk.rcTROpeModeChk();

  /// 最新の商品明細欄の高さ
  static const double newItemHeight = 88.0;
  /// 商品明細欄の高さ
  static const double oldItemHeight = 64.0;

  /// 商品明細の商品名の領域(+12は調整分)
  static const double merchandiseNameWidth = (24 * 22) + 12;
  /// 商品明細の商品点数の領域(+4は調整分)
  static const double merchandiseQtyWidth = (16 * 4) + 4;
  /// 最新の商品明細の商品点数の単位の横領域
  static const double newMerchandiseQtyUnitWidth = 32 * 1;
  /// 最新の商品明細の商品点数の単位の縦領域
   /// 最新の商品明細の高さ - 内側に設けた縦余白の合計
  static const double newMerchandiseQtyUnitHeight = newItemHeight - 31.0;
  /// 最新以外の商品明細の商品点数の単位の横領域
  static const double oldMerchandiseQtyUnitWidth = 24 * 1;
  /// 最新以外の商品明細の商品点数の単位の縦領域
   /// 最新以外の商品明細の高さ - 内側に設けた縦余白の合計
  static const double oldMerchandiseQtyUnitHeight = oldItemHeight - 16.0;
  /// 商品明細の商品点数の単位の余白の領域
  static const double merchandiseUnitSpace = 8;
  /// 商品明細の"値下済"の文字の領域
  static const double merchandiseDiscountWidth = 22 * 3;
  /// 商品明細の"値下済"と金額の間の余白
  static const double discountAndPriceSpace = 16;
  /// 商品明細の金額の領域(+6は調整分)
  static const double merchandisePriceWidth = (16 * 9) + 6;

  @override
  Widget build(BuildContext context) {
    FullSelfRegisterController controller = Get.find();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: BaseColor.customerPageBackGroundColor,
            child: Column(
              children: [
                // タイトルバー
                Obx(() => FullSelfTopGreyBar(title: 'l_full_self_reg_guidance'.trns),),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    child: Center(
                      child: Column(
                        children: [
                          // 合計金額欄
                          SumArea(controller: controller),
                          const SizedBox(height: 8.0,),
                          // 商品明細一覧
                          allItems(controller),
                          const SizedBox(height: 8.0,),
                          // カメラ画像とボタン
                          const FullSelfFooter(
                            fullSelfKind: DisplayingFooterFullSelfKind.register,
                            upperRow: RegisterFooterUpperButtons(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // TODO:7月末の検定では不要なのでコメントアウトする。あとで復活させる
          // // 隠しボタン
          // HiddenButton(
          //   onTap: () => controller.toMaintenance(),
          //   alignment: Alignment.topLeft,
          // ),
          //訓練モードの時表示する半透明テキスト
          if(isTrainingMode) TrainingModeText(),
        ],
      ),
    );
  }

  /// 商品明細一覧とオプションエリア
  Widget allItems(FullSelfRegisterController controller) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // oldItemMaxCountの数を計算する
          int oldItemMaxCount = controller.calcOldItemMaxCount(constraints.maxHeight, newItemHeight, oldItemHeight);
          return Column(
            children: [
              GetBuilder<FullSelfRegisterController>(
                builder: (controller) {
                  // 最新の商品明細で表示される値引の数を取得する
                  int discountCount = controller.getDisplayedNewItemDiscountCount();
                  // 値引きありならoldItemMaxCountからdiscountCountを減らした数だけoldItemを表示
                  int oldItemRowCount = oldItemMaxCount - discountCount;
                  return Column(
                    children: [
                      if (controller.merchandiseDataList.isNotEmpty) ... {
                        // 最新の商品明細
                        newItem(controller, discountCount),
                        for (int oldItemRow = 1; oldItemRow <= oldItemRowCount; oldItemRow++) ... {
                          // 商品明細
                          oldItem(controller, oldItemRow, discountCount),
                        },
                      } else ... {
                        // TODO: アニメーション
                        SizedBox(
                          height: newItemHeight + (oldItemHeight * oldItemRowCount),
                          width: double.infinity,
                          child: Center(
                            child: Obx(() => Text(
                              'l_full_self_scan_barcode'.trns,
                              style: const TextStyle(
                                fontSize: BaseFont.font24px,
                              ),
                            ),),
                          ),
                        ),
                      },
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  /// 最新の商品明細
  Widget newItem(FullSelfRegisterController controller, int discountCount) {
    return Stack(
      children: [
        newItemWholeDesign(
          controller: controller,
          discountCount: discountCount,
          newItemColumn: Column(
            children: [
              // 最新の商品明細
              Container(
                // newItemHeight - 上下の枠(8*2)
                height: 72.0,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                color: controller.refundFlag.value
                    ? BaseColor.customerPageRefundOddsPurchaseColor
                    : BaseColor.customerPageNewPurchaseBackGroundColor,
                child: controller.merchandiseDataList.isNotEmpty
                    ? newItemDetail(controller)
                    : Container(),
              ),
              // 最新の商品明細の値引き情報
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: controller.refundFlag.value
                      ? BaseColor.customerPageRefundOddsPurchaseColor
                      : BaseColor.customerPageDiscountBackGroundColor,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: newItemDiscount(controller, discountCount),
              ),
            ],
          ),
        ),
        // 取り消しがあったかどうかを判定
        if (controller.merchandiseDataList.isNotEmpty && controller.judgeCancel(0)) ... {
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: BaseColor.customerPageCancelBackGroundColor.withOpacity(0.8),
              ),
              child: Center(
                child: Obx(() => Text(
                  'l_full_self_cancelled'.trns,
                  style: const TextStyle(
                    color: BaseColor.customerPageDiscountTextColor,
                    fontSize: BaseFont.font22px,
                  ),
                ),),
              ),
            ),
          ),
        }
      ],
    );
  }

   /// 最新の商品明細の全体の見た目
   Widget newItemWholeDesign({
     required FullSelfRegisterController controller,
     required int discountCount,
     required Widget newItemColumn,
   }) {
     if (controller.refundFlag.value) {
       return Container(
         // 最新の商品明細 + 値引きの数
         height: newItemHeight + (oldItemHeight * discountCount),
         width: double.infinity,
         padding: const EdgeInsets.all(6.0),
         decoration: BoxDecoration(
           border: Border.all(
             width: 2.0,
             color: BaseColor.customerPageDiscountTextColor,
           ),
           borderRadius: BorderRadius.circular(4.0),
           color: BaseColor.customerPageRefundOddsPurchaseColor,
         ),
         child: newItemColumn,
       );
     } else {
       return Container(
         // 最新の商品明細 + 値引きの数
         height: newItemHeight + (oldItemHeight * discountCount),
         width: double.infinity,
         padding: const EdgeInsets.all(8.0),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(4.0),
           color: BaseColor.customerPageNewPurchaseBackGroundColor,
         ),
         child: newItemColumn,
       );
     }
   }

  /// 最新の商品明細の詳細
  Widget newItemDetail(FullSelfRegisterController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 最新の商品明細の商品名
          Expanded(
            // 34px * 15文字だが、商品明細一覧に合わせ24px * 22文字 + 調整分
            flex: merchandiseNameWidth.toInt(),
            child: _newItemMerchandiseName(controller),
          ),
          // ・・・と最新商品明細の点数の先頭との差
          const SizedBox(width: 16.0),
          // 最新の商品明細の商品点数
          Expanded(
            // (16px*4文字 + 調整分) + 余白8px + 32px*1文字
            // 文字数の領域分の割合に+してwindows起動時の画面サイズでも文字がscaledownしないようにした
            flex: (merchandiseQtyWidth
                + merchandiseUnitSpace
                + newMerchandiseQtyUnitWidth).toInt(),
            child: _newItemMerchandiseQty(controller),
          ),
          const SizedBox(width: 16.0),
          // 最新の商品明細の金額
          Expanded(
            // 商品明細一覧に合わせ、
            // 値下済66px + 余白16px + (数値16px*9文字 + 調整分)
            flex: (merchandiseDiscountWidth
                + discountAndPriceSpace
                + merchandisePriceWidth).toInt(),
            child: _newItemMerchandisePrice(controller),
          ),
        ],
      ),
    );
  }

  /// 最新の商品明細の商品名
  Widget _newItemMerchandiseName(FullSelfRegisterController controller) {
    return SizedBox(
      height: 34.0,
      child: Text(
        controller.merchandiseDataList[0].name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: controller.refundFlag.value
              ? BaseColor.customerPageDiscountTextColor
              : BaseColor.customerPageSumAndNewPurchaseTextColor,
          fontSize: BaseFont.font34px,
        ),
      ),
    );
  }

  /// 最新の商品明細の商品点数
  Widget _newItemMerchandiseQty(FullSelfRegisterController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: SizedBox(
            height: 32.0,
            child: FittedBox(
              alignment: Alignment.bottomRight,
              fit: BoxFit.scaleDown,
              child: Text(
                controller.formatNumber(controller.merchandiseDataList[0].qty),
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: controller.refundFlag.value
                      ? BaseColor.customerPageDiscountTextColor
                      : BaseColor.customerPageSumAndNewPurchaseTextColor,
                  fontSize: BaseFont.font32px,
                  fontFamily: BaseFont.familyNumber,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: newMerchandiseQtyUnitWidth,
          height: newMerchandiseQtyUnitHeight,
          margin: const EdgeInsets.only(left: merchandiseUnitSpace),
          child: Obx(() => FittedBox(
            alignment: Alignment.bottomRight,
            fit: BoxFit.scaleDown,
            child: Text(
              'l_full_self_unit'.trns,
              style: TextStyle(
                color: controller.refundFlag.value
                    ? BaseColor.customerPageDiscountTextColor
                    : BaseColor.customerPageSumAndNewPurchaseTextColor,
                fontSize: BaseFont.font32px,
              ),
            ),
          ),),
        ),
      ],
    );
  }

  /// 最新の商品明細の金額
  Widget _newItemMerchandisePrice(FullSelfRegisterController controller) {
    return SizedBox(
      height: 42.0,
      child: FittedBox(
        alignment: Alignment.bottomRight,
        fit: BoxFit.scaleDown,
        child: Text(
          // 商品の金額をフォーマットされた文字列に変換する
          controller.getStrMerchandisePrice(itemRow: 0),
          style: TextStyle(
            color: controller.refundFlag.value
                ? BaseColor.customerPageDiscountTextColor
                : BaseColor.customerPageSumAndNewPurchaseTextColor,
            fontSize: BaseFont.font42px,
            fontFamily: BaseFont.familyNumber,
          ),
        ),
      ),
    );
  }

  /// 最新の商品明細の値引き
  Widget newItemDiscount(FullSelfRegisterController controller, int discountCount) {
    return Column(
      children: [
        for (int i = 0; i < discountCount; i++)... {
          SizedBox(
            height: oldItemHeight,
            child: Row(
              children: [
                Expanded(
                  /*
                    商品明細一覧に合わせ、
                    24px * 22文字 + 調整分
                    　→実際の文字数は48px左に余白を設けていることから20文字
                   */
                  flex: merchandiseNameWidth.toInt(),
                  child: Container(
                    // 24px * 2文字
                    margin: const EdgeInsets.only(left: 48.0),
                    child: Text(
                      // 最新の商品明細の値引情報を取得する
                      controller.getModelDiscountData(i).discountName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: BaseColor.customerPageDiscountTextColor,
                        fontSize: BaseFont.font24px,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  // 最新の商品明細に合わせ、
                  // (16px*4文字 + 調整分) + 余白8px + 32px*1文字
                  flex: (merchandiseQtyWidth
                      + merchandiseUnitSpace
                      + newMerchandiseQtyUnitWidth).toInt(),
                  child: Container(),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  // 商品明細一覧に合わせ、
                  // 値下済66px + 余白16px + (数値16px*9文字 + 調整分)
                  flex: (merchandiseDiscountWidth
                      + discountAndPriceSpace
                      + merchandisePriceWidth).toInt(),
                  // 最新の商品明細の金額
                  child: SizedBox(
                      height: 32.0,
                      // 値引タイプが特売でなく会員でないか、を判定
                      child: (controller.judgeDiscountType(i))
                          ? FittedBox(
                        alignment: Alignment.bottomRight,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          // 値引き額を計算する
                          NumberFormatUtil.formatAmount((controller.getDisplayedDiscountPrice(i))),
                          style: const TextStyle(
                            color: BaseColor.customerPageDiscountTextColor,
                            fontSize: BaseFont.font32px,
                            fontFamily: BaseFont.familyNumber,
                          ),
                        ),
                      )
                          : Container()
                  ),
                ),
              ],
            ),
          ),
        }
      ],
    );
  }

  /// 商品明細
  Widget oldItem(FullSelfRegisterController controller, int oldItemRow, int discountCount) {
    return Stack(
      children: [
        Container(
            height: oldItemHeight,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            // 商品明細の背景色
            color: oldItemColor(controller, oldItemRow, discountCount),
            // oldItemRowをmerchandiseDataListのindexとして扱う
            child: controller.merchandiseDataList.length > oldItemRow
                ? oldItemDetail(controller, oldItemRow)
                : Container()
        ),
        // oldItemRowをmerchandiseDataListのindexとして扱う
        // 取り消しがあったかどうかを判定
        if (controller.merchandiseDataList.length > oldItemRow && controller.judgeCancel(oldItemRow)) ... {
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: BaseColor.customerPageCancelBackGroundColor.withOpacity(0.7),
              ),
              child: Center(
                child: Obx(() => Text(
                  'l_full_self_cancelled'.trns,
                  style: const TextStyle(
                    color: BaseColor.customerPageDiscountTextColor,
                    fontSize: BaseFont.font22px,
                  ),
                ),),
              ),
            ),
          ),
        },
      ],
    );
  }

   /// 商品明細の背景色
   // 商品明細の背景を奇数と偶数で塗り分けている
   Color oldItemColor(FullSelfRegisterController controller, int oldItemRow, int discountCount) {
     // 商品明細欄全体として何行目かを求める
     // +1は商品明細欄全体の行を1スタートにしたいため
     int currentRow = oldItemRow + discountCount + 1;
     if (currentRow % 2 == 0) {
       // 偶数行目
       return BaseColor.customerPageEvensPurchaseColor;
     } else {
       // 奇数行目
       if (controller.refundFlag.value) {
         // 返品時
         return BaseColor.customerPageRefundOddsPurchaseColor;
       } else {
         // 通常時
         return BaseColor.customerPageOddsPurchaseColor;
       }
     }
   }

  /// 商品明細の詳細
  Widget oldItemDetail(FullSelfRegisterController controller, int oldItemRow) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 商品明細の商品名
          Expanded(
            // 24px * 22文字 + 調整分
            // 文字数の領域分の割合に+してwindows起動時の画面サイズでも22文字表示できるようにした
            flex: merchandiseNameWidth.toInt(),
            child: _oldItemMerchandiseName(controller, oldItemRow),
          ),
          // ・・・と最新商品明細の点数の先頭との差
          const SizedBox(width: 16.0),
          // 商品明細の商品点数
          Expanded(
            // 最新の商品明細に合わせ、
            // (16px*4文字 + 調整分) + 余白8px + 32px*1文字
            flex: (merchandiseQtyWidth
                + merchandiseUnitSpace
                + newMerchandiseQtyUnitWidth).toInt(),
            child: _oldItemMerchandiseQty(controller, oldItemRow),
          ),
          const SizedBox(width: 16.0),
          // 商品明細の値下済の文字と金額
          Expanded(
            // 値下済66px + 余白16px + (数値16px*9文字 + 調整分)
            // 文字数の領域分の割合に+してwindows起動時の画面サイズでも文字がscaledownしないようにした
            flex: (merchandiseDiscountWidth
                + discountAndPriceSpace
                + merchandisePriceWidth).toInt(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 商品明細の値下済
                _oldItemMerchandiseDiscount(controller, oldItemRow),
                // デザインは32だがマイナス分の16減らした
                const SizedBox(width: discountAndPriceSpace,),
                // 商品明細の金額
                _oldItemMerchandisePrice(controller, oldItemRow),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 商品明細の商品名
  Widget _oldItemMerchandiseName(FullSelfRegisterController controller, int oldItemRow) {
    return Text(
      controller.merchandiseDataList[oldItemRow].name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: controller.refundFlag.value
            ? BaseColor.customerPageDiscountTextColor
            : BaseColor.customerPageBaseTextColor,
        fontSize: BaseFont.font24px,
      ),
    );
  }

  /// 商品明細の商品点数
  Widget _oldItemMerchandiseQty(FullSelfRegisterController controller, int oldItemRow) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: SizedBox(
            height: 24.0,
            child: FittedBox(
              alignment: Alignment.bottomRight,
              fit: BoxFit.scaleDown,
              child: Text(
                controller.formatNumber(controller.merchandiseDataList[oldItemRow].qty),
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: controller.refundFlag.value
                      ? BaseColor.customerPageDiscountTextColor
                      : BaseColor.customerPageBaseTextColor,
                  fontSize: BaseFont.font24px,
                  fontFamily: BaseFont.familyNumber,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: oldMerchandiseQtyUnitWidth,
          height: oldMerchandiseQtyUnitHeight,
          margin: const EdgeInsets.only(left: merchandiseUnitSpace),
          child: Obx(() => FittedBox(
            alignment: Alignment.bottomRight,
            fit: BoxFit.scaleDown,
            child: Text(
              'l_full_self_unit'.trns,
              style: TextStyle(
                color: controller.refundFlag.value
                    ? BaseColor.customerPageDiscountTextColor
                    : BaseColor.customerPageBaseTextColor,
                fontSize: BaseFont.font24px,
              ),
            ),
          ),),
        ),
      ],
    );
  }

  /// 商品明細の"値下済"の文字
  Widget _oldItemMerchandiseDiscount(FullSelfRegisterController controller, int oldItemRow) {
    return SizedBox(
        width: merchandiseDiscountWidth,
        child: controller.merchandiseDataList[oldItemRow].discountList.isNotEmpty
            ? Obx(() => FittedBox(
                alignment: Alignment.bottomCenter,
                fit: BoxFit.scaleDown,
                child: Text(
                  'l_full_self_discount'.trns,
                  style: const TextStyle(
                    color: BaseColor.customerPageDiscountTextColor,
                    fontSize: BaseFont.font22px,
                  ),
                ),
              ),)
            : Container()
    );
  }

  /// 商品明細の金額
  Widget _oldItemMerchandisePrice(FullSelfRegisterController controller, int oldItemRow) {
    return Expanded(
      child: SizedBox(
        height: 32.0,
        child: FittedBox(
          alignment: Alignment.bottomRight,
          fit: BoxFit.scaleDown,
          child: Text(
            // 商品の金額をフォーマットされた文字列に変換する
            controller.getStrMerchandisePrice(itemRow: oldItemRow),
            style: TextStyle(
              color: controller.refundFlag.value
                  ? BaseColor.customerPageDiscountTextColor
                  : BaseColor.customerPageBaseTextColor,
              fontSize: BaseFont.font32px,
              fontFamily: BaseFont.familyNumber,
            ),
          ),
        ),
      ),
    );
  }
  

  /// キーコントローラ取得
  @override
  KeyDispatch? getKeyCtrl() {
     
    KeyDispatch keyCon = KeyDispatch(Tpraid.TPRAID_CHK);
    keyCon.funcMap[FuncKey.KY_STL] = () async {
      final FullSelfRegisterController controller = Get.find();
      int errNo = await RckyStl.rcKyStlError();
      if (errNo != 0) {
        MsgDialog.show(
            MsgDialog.singleButtonDlgId(
              type: MsgDialogType.error,
              dialogId: errNo,
            )
        );
      } else {
        // お支払方法選択画面
        controller.toSelectPay();
      }
    };

    keyCon.funcMap[FuncKey.KY_PLU] = (pluCd) async {
          final FullSelfRegisterController controller = Get.find();
          RcKyPlu plu = RcKyPlu(pluCd, 1);
          final (isSuccess,errId, data) = await plu.rcKyPlu();
          if(isSuccess){
            if (data != null) {
              controller.setData(data);
            }
          }else{
             MsgDialog.show(
            MsgDialog.singleButtonDlgId(
              type: MsgDialogType.error,
              dialogId: errId,
            )
        );
      }
    };
    return keyCon;
  }

  ///スキャンコントローラ取得
  @override
  Function(RxInputBuf)? getScanCtrl() {
    return (data) {
      // アドオンコードが含まれている場合は、バーコードデータの末尾に付与する
      String barData = data.devInf.barData;
      if (data.devInf.adonCd.isNotEmpty) {
        barData += data.devInf.adonCd;
      }
      IfDrvControl()
          .mkeyIsolateCtrl
          .dispatch
          ?.rcDKeyByKeyId(data.funcCode, barData);
    };
  }
  
  @override
  IfDrvPage getTag() {
      return IfDrvPage.register;
  }

}