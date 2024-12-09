/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../clxos/calc_api_result_data.dart';
import '../../../../inc/apl/rxregmem_define.dart';
import '../../../../inc/apl/t_item_log.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';
import '../../detail_modifi/basepage/p_purchase_detail_modify.dart';
import '../controller/c_register_change.dart';
import '../controller/c_registerbody_controller.dart';
import '../model/m_registermodels.dart';

enum PurchaseType {
  /// 先頭の大きい明細
  top,
  /// 2行目以降の小さい明細
  normal,
}

class DiscountType {
  /// 特売
  static const specialSale = 1;
  /// MM
  static const mm = 2;
  /// SM
  static const sm = 3;
  /// 分類一括
  static const bulkClass = 4;
  /// 値引
  static const reduction = 5;
  /// 割引
  static const discount = 6;
  /// 売価変更値引
  static const priceChange = 7;
  /// 会員
  static const member = 8;
}

/// スキャン一覧の1つにエリア
abstract class PurchaseWidgetBase extends StatelessWidget {
  /// コンストラクタ
  PurchaseWidgetBase(
      {super.key,
      required this.index,
      required this.type,
      required this.length});

  /// 割引情報一行分の高さ
  static const discountLineHeight = 24.0;

  /// 大きい明細の割引情報を除いた高さ
  static const discountLastLineBaseHeight = 110;

  /// 小さい明細の割引情報を除いた高さ
  static const discountLineBaseHeight = 96;

  /// 購入データのアイテムログを取得
  TItemLog get itemLog => bodyctrl.purchaseData.value[index].itemLog;

  ///購入データ取得
  Purchase get data => bodyctrl.purchaseData.value[index];

  ///割引情報の高さ
  final discountHeight = (discountLineHeight * 2).obs;

  ///インデックス
  final int index;

  ///明細の種別(top: 大きい明細、normal: 小さい明細)
  final PurchaseType type;

  ///明細の数
  final int length;

  ///レイアウト用の比率とサイズ定数
  ///番号のFlex比率
  static const numberFlex = 6;

  ///データのFlex比率
  static const dataFlex = 83;

  ///変更ボタンのFlex比率
  static const changeButtonFlex = 11;

  ///左角丸
  static const double leftRadius = 5;

  /// 商品明細の値下げタイトル
  String discountTitle = "";

  /// 商品明細の値下げ額
  String discountPrice = "";


  ///コントローラー
  RegisterBodyController bodyctrl = Get.find();

  ///seqNoのwidget
  Widget seqNoWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 7),
      alignment: Alignment.centerRight,
      child: FittedBox(
        child: Text(
          '${itemLog.getSeqNo()}',
          style: const TextStyle(fontSize: BaseFont.font18px),
        ),
      ),
    );
  }

  ///割引リスト
  Widget discountWidgetList() {
    return Obx(
      () => bodyctrl.getShowDiscountList(data).isNotEmpty
          /// 割引情報が二行以上ある場合
          ? (bodyctrl.getShowDiscountList(data).length > 1
              ? Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                      for (var discountInfo in bodyctrl.getShowDiscountList(data))
                        _discountWidget(discountInfo)
                    ]
      )
              /// 割引情報が一行の場合
              : Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                      _discountWidget(bodyctrl.getShowDiscountList(data).first),
                      Container(height: discountLineHeight,),
                    ]
      )
      )
          /// 割引情報がない場合
          : Container(height: (discountLineHeight * 2),
            ),
    );
  }

  /// 処理概要：値下げ額の表示設定
  /// パラメータ：String price
  /// 戻り値：なし
  void setDiscountPrice(String price) {
    if (RegsMem().refundFlag) {
      discountPrice = "¥$price";
    } else {
      discountPrice = "¥-$price";
    }
  }

  /// 処理概要：値下げタイトルの表示設定
  /// パラメータ：int formedFlg
  ///           String title
  ///           String price
  /// 戻り値：なし
  void setDiscountParts(int formedFlg, String title, String price) {
    if (formedFlg == 1) {
      setDiscountPrice(price);
    } else {
      discountTitle = title;
      discountPrice = "";
    }
  }

  ///割引
  Widget _discountWidget(DiscountData discountInfo) {
    switch (discountInfo.type) {
      case DiscountType.specialSale:   // 特売
        discountPrice = "";
        break;
      case DiscountType.mm:   // MM
        setDiscountParts(
            discountInfo.formedFlg ?? 0,
            "まとめ対象",
            (discountInfo.discountPrice ?? 0).toString());
        break;
      case DiscountType.sm:   // SM
        setDiscountParts(
            discountInfo.formedFlg ?? 0,
            "セット対象",
            (discountInfo.discountPrice ?? 0).toString());
        break;
      case DiscountType.bulkClass:   // 分類一括
        setDiscountPrice(
            (discountInfo.discountPrice ?? 0).toString());
        break;
      case DiscountType.reduction:   // 値引
        setDiscountPrice(
            (discountInfo.discountPrice ?? 0).toString());
        break;
      case DiscountType.discount:   // 割引
        setDiscountPrice(
            (discountInfo.discountPrice ?? 0).toString());
        break;
      case DiscountType.priceChange:   // 売価変更値引
        setDiscountPrice(
            (discountInfo.discountPrice ?? 0).toString());
        break;
      case DiscountType.member:   // 会員
        discountPrice = "";
        break;
      default:
        break;
    }

    return Container(
      margin: const EdgeInsets.only(right: 16),
      alignment: Alignment.topRight,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(
              bottom: 4,
            ),
            alignment: Alignment.center,
            width: 80,
            height: 20,
            color: BaseColor.registDiscountBackColor,
            child: Text(
              discountInfo.name!,
              style: const TextStyle(
                  fontSize: BaseFont.font14px,
                  color: BaseColor.attentionColor),
            ),
          ),
          // TODO: 値下げしたパーセント系.DiscountDataにない.
          // Container(
          //   margin: EdgeInsets.only(
          //     left: 10,
          //     right: 10,
          //   ),
          //   child: Text(
          //     '${data.value.discountData[i].percent}',
          //     style: TextStyle(
          //         fontSize: BaseFont.font18px,
          //         fontFamily: 'TucN3m',
          //         color:
          //             BaseColor.attentionColor),
          //   ),
          // ),
          const SizedBox(width: 8,),
          Container(
            margin: const EdgeInsets.only(
              bottom: 4,
            ),
            alignment: Alignment.centerRight,
            width: 72.w,
            height: 20,
            child:
            Text(
              discountPrice,
              style: const TextStyle(
                  fontSize: BaseFont.font16px, color: BaseColor.attentionColor),
            ),
          ),
        ],
      ),
    );
  }

  /// 自身が最新の商品情報か（大きい明細）
  bool isTopPurchase() {
    return type == PurchaseType.top;
  }
}

/// 購入商品明細 個数変更アップダウンボタン
class PurchaseNumUpDownWidget extends StatelessWidget {
  ///コンストラクタ
  PurchaseNumUpDownWidget({
    super.key,
    required this.index,
    required this.quantity,
    required this.oncallbackadd,
    required this.oncallbackpull,
    required this.isDeleted,
    required this.isEditable,
  });

  /// 登録画面コントローラー.
  final RegisterBodyController bodyctrl = Get.find();

  // 購入商品index.
  final int index;
  final int quantity;

  final bool isDeleted;

  ///個数変更できるかどうか
  final bool isEditable;

  // callback
  final Function oncallbackadd;
  final Function oncallbackpull;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isDeleted,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          if (isEditable)
          Material(
              type: MaterialType.button,
              color: BaseColor.accentsColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
              child: SoundInkWell(
                onTap: () => oncallbackpull(),
                callFunc: runtimeType.toString(),
                child: SizedBox(
                  height: 48.h,
                  width: 48.w,
                  child: const Icon(
                    Icons.remove,
                    size: 30,
                    color: BaseColor.someTextPopupArea,
                  ),
                ),
              )),
          Container(
            alignment: Alignment.center,
            height: 48.h,
            width: 48.w,
            decoration: BoxDecoration(
              color: BaseColor.someTextPopupArea,
              border: Border(
                  top: BorderSide(width: 1.w, color: BaseColor.accentsColor),
                  bottom: BorderSide(width: 1.w, color: BaseColor.accentsColor)),
            ),
            child: Text(
              '$quantity',
              style: const TextStyle(
                  fontSize: BaseFont.font22px, color: BaseColor.accentsColor),
            ),
          ),
          if (isEditable)
          Material(
            type: MaterialType.button,
            color: BaseColor.accentsColor,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
            child: SoundInkWell(
              onTap: () => oncallbackadd(),
              callFunc: runtimeType.toString(),
              child: SizedBox(
                height: 48.h,
                width: 48.w,
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: BaseColor.someTextPopupArea,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 購入商品の変更ボタンのWidget
class PurchaseChangeWidget extends StatelessWidget {
  ///コンストラクタ
  PurchaseChangeWidget({
    super.key,
    required this.idx,
    required this.isDeleted,
  });

  // 変更文字とアイコンの隙間.
  static const double padding = 12;

  ///インデックス
  final int idx;

  final bool isDeleted;

  ///コントローラー
  RegisterBodyController bodyCtrl = Get.find();
  RegisterChangeController rchgCtrl = Get.put(RegisterChangeController());

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isDeleted,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              BaseColor.registMemverDetailStartColor,
              BaseColor.registMemverDetailEndColor,
            ],
          ),
        ),

        child: Material(
          type: MaterialType.button,
          color: BaseColor.transparent,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(PurchaseWidgetBase.leftRadius),
              bottomRight: Radius.circular(PurchaseWidgetBase.leftRadius)),
          child: SoundInkWell(
            onTap: () async {
              /// purchaseData更新前にバックアップを取得
              bodyCtrl.setPurchaseDataBackup(idx);
              /// 変更するアイテムの情報をセット
              rchgCtrl.initDataSet(idx);
              await Get.to(
                  () => PurchaseDetailModifyScreen(
                        title: '明細変更',
                        purchaseDataIndex: idx,
                        enabledCancelButton: true,
                        setForcus: DetailModifyFocusType.focusNone,
                        addInfo: '※この取引きのみに適用されます',
                      ),
                  );
              return;
            },
            callFunc: runtimeType.toString(),
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.center,
              direction: Axis.vertical,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/icon_open_1.svg',
                      width: 36,
                      height: 36,
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/icon_open_2.svg',
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
