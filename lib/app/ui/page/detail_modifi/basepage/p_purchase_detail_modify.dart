/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/language/l_languagedbcall.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../clxos/calc_api_result_data.dart';
import '../../../../inc/apl/fnc_code.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../regs/checker/rc_chgitm_dsp.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_inputbox.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../menu/register/m_menu.dart';
import '../../common/basepage/common_base.dart';
import '../../common/component/w_dicisionbutton.dart';
import '../../common/component/w_msgdialog.dart';
import '../../quantity_division/component/w_quantityrow.dart';
import '../../register/controller/c_register_change.dart';
import '../../register/controller/c_registerbody_controller.dart';
import '../../subtotal/component/w_register_tenkey.dart';
import '../component/w_changeprice_widget.dart';
import '../component/w_discount_widget.dart';
import '../component/w_unitprice_widget.dart';
import '../controller/c_purchase_detail_modify_controller.dart';
import '../enum/e_purchase_detail_modify_enum.dart';

/// 明細変更画面オープン時のフォーカス設定
enum DetailModifyFocusType {
  /// フォーカスなし
  focusNone,
  /// 売価変更フォーカス
  priceChg,
  /// 値引き/割引きフォーカス
  discount
}

///明細変更ベースページ画面
class PurchaseDetailModifyScreen extends CommonBasePage {
  final int purchaseDataIndex;
  final bool enabledCancelButton;
  final DetailModifyFocusType setForcus;

  PurchaseDetailModifyScreen({
    super.key,
    required super.title,
    required this.purchaseDataIndex,
    required this.enabledCancelButton,
    required this.setForcus,
    super.backgroundColor = BaseColor.receiptBottomColor,
    super.addInfo,
  });

  @override
  Widget buildBody(BuildContext context) {
    Get.put(RegisterChangeController());

    return PurchaseDetailModifyWidget(
      backgroundColor: backgroundColor,
      purchaseDataIndex: purchaseDataIndex,
      setForcus: setForcus,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    String callFunc = 'buildActions';
    return <Widget>[
      Visibility(
        visible: enabledCancelButton,
        child: SoundTextButton(
          onPressed: () {
            var ctrl = Get.find<RegisterBodyController>();
            ctrl.resetResultItemData(purchaseDataIndex);
            Get.back();
          },
          callFunc: '$callFunc ${'l_cmn_cancel'.trns}',
          child: Row(
            children: <Widget>[
              const Icon(Icons.close,
                  color: BaseColor.someTextPopupArea, size: 45),
              SizedBox(
                width: 19.w,
              ),
              Text('l_cmn_cancel'.trns,
                  style: const TextStyle(
                      color: BaseColor.someTextPopupArea,
                      fontSize: BaseFont.font18px)),
            ],
          ),
        ),
      ),
    ];
  }
}

class PurchaseDetailModifyWidget extends StatefulWidget {
  final Color backgroundColor;
  final int purchaseDataIndex;
  final DetailModifyFocusType setForcus;

  const PurchaseDetailModifyWidget({
    super.key,
    required this.backgroundColor,
    required this.purchaseDataIndex,
    required this.setForcus,
  });

  @override
  PurchaseDetailModifyState createState() => PurchaseDetailModifyState();
}

class PurchaseDetailModifyState extends State<PurchaseDetailModifyWidget> {
  late final DetailModifyInputController detailModifyInputCtrl;

  RegisterBodyController bodyctrl = Get.find();

  ///商品名
  late final String itemName;

  ///商品単価
  late final int itemPrice;

  ///削除できるかどうか
  bool isDeleted = false;

  ///コントローラー
  final RegisterChangeController registerChangeCtrl = Get.find();

  List<PurchaseDetailModifyLabel> labels = [
    // 数量
    PurchaseDetailModifyLabel.quantity,
    // 単価
    PurchaseDetailModifyLabel.price,
    // 単価（金額）
    PurchaseDetailModifyLabel.money,
    // 売値変更
    PurchaseDetailModifyLabel.modification,
    // 引
    PurchaseDetailModifyLabel.discount,
    // ポイント倍率
    PurchaseDetailModifyLabel.point,
    // 倍
    PurchaseDetailModifyLabel.magnification,
    // 商品名
    PurchaseDetailModifyLabel.name,
  ];

  @override
  void initState() {
    super.initState();
    List<GlobalKey<InputBoxWidgetState>> inputBoxKeys =
    labels.map((_) => GlobalKey<InputBoxWidgetState>()).toList();

    detailModifyInputCtrl = DetailModifyInputController(
      detailModifyInputBoxList: inputBoxKeys,
      labels: labels,
      purchaseDataIndex: widget.purchaseDataIndex,
      registerChangeCtrl: registerChangeCtrl,
    );
    Get.put(detailModifyInputCtrl);
  }

  @override
  Widget build(BuildContext context) {
    ///itemType ＝ 30又は31の場合は個数変更できない
    bool isQuantityEditable =
    bodyctrl.checkPurchaseQuantityChange(widget.purchaseDataIndex);

    ///PrcChgFlg ＝ 2 の場合は売価変更できない
    bool isPriceEditable =
    bodyctrl.checkPriceChangeFlag(widget.purchaseDataIndex);

    ///DisChgFlg ＝ 2 の場合は値引き割引できない
    bool isDiscountEditable =
    bodyctrl.checkDiscountAvailable(widget.purchaseDataIndex);

    return Scaffold(
        backgroundColor: widget.backgroundColor,
        appBar: buildAppBar(),
        body: Stack(
          children: [

            /// 明細変更項目の表示エリア
            buildDetailArea(
                isQuantityEditable, isPriceEditable, isDiscountEditable, widget.setForcus),

            /// テンキー表示
            Obx(() {
              if (detailModifyInputCtrl.showRegisterTenKey.value) {
                return Positioned(
                  right: 32.w,
                  bottom: 32.h,
                  child: RegisterTenkey(
                    onKeyTap: (key) {
                      detailModifyInputCtrl.inputKeyType(key);
                    },
                  ),
                );
              } else {
                return Container();
              }
            }),

            /// 確定ボタン
            Obx(() {
              if (detailModifyInputCtrl.enableConfirmButton.value) {
                return Positioned(
                  right: 32.w,
                  bottom: 32.h,
                  child: DecisionButton(
                    oncallback: () {
                      // クラウドPOSへの送信処理
                      registerChangeCtrl.changeListData();
                      // 登録画面へ戻る
                      Get.back(result: "completed");
                    },
                    text: '確定する',
                  ),
                );
              } else {
                return Container();
              }
            }),
          ],
        ));
  }

  ///商品名APPBAR
  PreferredSizeWidget buildAppBar() {
    String callFunc = 'buildAppBar';
    return PreferredSize(
      preferredSize: Size.fromHeight(88.h),
      child: Flex(direction: Axis.vertical, children: [

        /// 商品名取得／削除ボタン
        Container(
          color: BaseColor.someTextPopupArea.withOpacity(0.7),
          width: 1024.w,
          height: 88.h,
          child: Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(48, 33, 0, 33),
                  child: Text(
                    '${bodyctrl.purchaseData[widget.purchaseDataIndex].itemLog
                        .itemData.name}',
                    style: const TextStyle(
                      color: BaseColor.baseColor,
                      fontSize: BaseFont.font22px,
                      fontFamily: BaseFont.familyDefault,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 16, 104, 16),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      SoundElevatedIconTextButton(
                        onPressed: () {
                          MsgDialog.show(MsgDialog.twoButtonDlgId(
                            dialogId: DlgConfirmMsgKind.MSG_TEXT93.dlgId,
                            type: MsgDialogType.info,
                            leftBtnTxt: "戻る",
                            leftBtnFnc: () {
                              Get.back();
                            },
                            rightBtnTxt: "取消",
                            rightBtnFnc: () {
                              //商品取り消しの関数
                              if (registerChangeCtrl.updateRtype(
                                  widget.purchaseDataIndex, 1)) {
                                // クラウドPOSへの送信処理
                                registerChangeCtrl.changeListData();
                                // 登録画面まで戻る
                                SetMenu1.navigateToRegisterPage();
                              } else {
                                // todo: 暫定削除できない場合この商品は変更出来ませんのダイアログ
                                Get.dialog(
                                  MsgDialog.singleButtonDlgId(
                                    type: MsgDialogType.error,
                                    dialogId: DlgConfirmMsgKind
                                        .MSG_CHGTAX_BEFORE_NOT.dlgId,
                                  ),
                                  barrierDismissible: false,
                                );
                              }
                            },
                          ));
                        },
                        callFunc: callFunc,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: BaseColor.attentionColor,
                            minimumSize: Size(168.w, 56.h)),
                        icon: const Icon(
                          Icons.delete_forever_rounded,
                          size: BaseFont.font34px,
                          color: BaseColor.someTextPopupArea,
                        ),
                        label: const Text(
                          "商品を削除",
                          style: TextStyle(
                            fontSize: BaseFont.font18px,
                            fontFamily: BaseFont.familyDefault,
                            color: BaseColor.someTextPopupArea,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ]),
    );
  }

  ///明細変更各項目のウイジェット（数量変更、単価表示、売価変更、値引き割引変更）
  Widget buildDetailArea(bool isQuantityEditable, bool isPriceEditable,
      bool isDiscountEditable, DetailModifyFocusType setForcus) {
    ResultItemData itemData = bodyctrl.getpurchaseItemData(
        widget.purchaseDataIndex);
    String prcChgVal = '';
    String initItemDscVal = '';
    DscChangeType initItemDscType = DscChangeType.none;
    FuncKey initItemFuncKey = FuncKey.KY_NONE;

    if (itemData.prcChgVal != null) {
      prcChgVal = itemData.prcChgVal.toString();
    }

    if (itemData.itemDscVal != null) {
      initItemDscVal = itemData.itemDscVal.toString();
      if (itemData.itemDscType == 1) {
        initItemDscType = DscChangeType.dsc;
      } else if (itemData.itemDscType == 2) {
        initItemDscType = DscChangeType.pdsc;
      }
      initItemFuncKey =
          FuncKey.getKeyDefine(itemData.itemDscCode ?? FuncKey.KY_NONE.keyId);
    }
    return Column(children: [
      QuantityRowWidget(
        registerChangeCtrl: registerChangeCtrl,
        bodyctrl: bodyctrl,
        detailModifyInputCtrl: detailModifyInputCtrl,
        isEditable: isQuantityEditable,
        index: widget.purchaseDataIndex,
        onQuantityChanged: () =>
        {
          detailModifyInputCtrl.showConfirmButton(),
        },
      ),
      DividerWidget(),
      UnitPriceRowWidget(purchaseDataIndex: widget.purchaseDataIndex),
      ChangePriceRowWidget(
          detailModifyInputCtrl: detailModifyInputCtrl,
          isEditable: isPriceEditable,
          prcChgVal: prcChgVal,
          focus: setForcus == DetailModifyFocusType.priceChg,
      ),
      DividerWidget(),
      DiscountWidget(
          detailModifyInputCtrl: detailModifyInputCtrl,
          isEditable: isDiscountEditable,
          initItemDscVal: initItemDscVal,
          initItemDscType: initItemDscType,
          initItemFuncKey: initItemFuncKey,
          focus: setForcus == DetailModifyFocusType.discount,
      )
    ]);
  }
}

///罫線　Widget
class DividerWidget extends StatelessWidget {
  DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(48, 16, 324, 0),
      child: const Divider(
        color: BaseColor.edgeBtnTenkeyColor,
        thickness: 1,
      ),
    );
  }
}
