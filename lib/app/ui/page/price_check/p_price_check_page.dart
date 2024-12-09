/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../common/environment.dart';
import '../../../common/number_util.dart';
import '../../../inc/apl/fnc_code.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../inc/sys/tpr_aid.dart';
import '../../../regs/checker/rc_key.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_sound_buttons.dart';
import '../../controller/c_common_controller.dart';
import '../../controller/c_drv_controller.dart';
import '../../enum/e_screen_kind.dart';
import '../../menu/register/m_menu.dart';
import '../common/basepage/common_base.dart';
import '../common/component/w_msgdialog.dart';
import '../manual_input/controller/c_keypresed_controller.dart';
import '../register/controller/c_registerbody_controller.dart';
import 'controller/c_price_check_controller.dart';
import 'controller/c_price_check_disp_controller.dart';
import 'controller/w_item_scroll_controller.dart';
import 'model/m_mix_match_data.dart';
import 'model/m_price_check_data.dart';

/// 動作概要
/// 起動方法： Get.to(() => PriceCheckPage(title: '価格確認')); など

/// 価格確認のページ
class PriceCheckPage extends CommonBasePage with RegisterDeviceEvent {
  PriceCheckPage({
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) {
    registrationEvent();
    PriceCheckController priceCheckCtrl = Get.find();
    priceCheckCtrl.isPrcChkView.value = true;
  }

  /// キーコントローラ取得
  @override
  KeyDispatch? getKeyCtrl() {
    KeyDispatch keyCon = KeyDispatch(Tpraid.TPRAID_CHK);

    keyCon.funcClr = () {
      Get.back();
    };

    keyCon.funcNum = (key) {
      // todo 入力したキーを手入力した値として扱うか確認
      /// 手入力操作用ウィジェット呼び出し
      /// 手入力操作用ウィジェット表示中の数値キー以外の操作はエラーとする
      Get.back();
    };

    keyCon.funcNum = (FuncKey key) {
      /// 手入力操作用ウィジェット呼び出し
      /// 手入力操作用ウィジェット表示中の数値キー以外の操作はエラーとする
      debugPrint('funcNum called with key: ${key.name}');
      // 登録画面に戻った上で今押されたキーをひきつがせる。
      SetMenu1.navigateToRegisterPage();

      String keyStr = key.getFuncKeyNumberStr();
      //手入力操作のコントローラ
      KeyPressController keyPressCtrl = Get.find();
      keyPressCtrl.updateKey(keyStr);
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

      RegisterBodyController registerBodyCtrl = Get.find();
      registerBodyCtrl.selectedPlu(barData, 1);
      debugPrint('getScanCtrl call');
    };
  }

  /// タグを取得
  @override
  IfDrvPage getTag() {
    return IfDrvPage.priceCheck;
  }

  @override
  Widget buildBody(BuildContext context) {
    return PriceCheckWidget(
      backgroundColor: backgroundColor,
    );
  }
}

class PriceCheckWidget extends StatefulWidget {
  final Color backgroundColor;

  const PriceCheckWidget({super.key, required this.backgroundColor});

  @override
  PriceCheckState createState() => PriceCheckState();
}

class PriceCheckState extends State<PriceCheckWidget> {
  /// 価格確認画面のデータコントローラ
  PriceCheckController priceCheckCtrl = Get.find();
  /// 価格確認画面の表示用コントローラ
  PriceCheckDispController priceCheckDispCtrl = Get.put(PriceCheckDispController());
  /// 共通コントローラクラス
  CommonController commonCtrl = Get.find();

  /// 価格情報行の高さ（先頭行）
  static const double topLineHeight = 80;

  /// 価格情報行の高さ（通常行）
  static const double normalLineHeight = 56;
  /// ミックスマッチ情報の各行の高さ
  static const double mixMatchLineHeight = 32;
  /// ミックスマッチ情報の行数
  static const int mixMatchLineNumber = 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 64, top: 49),
            child: Obx(
              () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        height: 22,
                        child: Text(
                          priceCheckCtrl.itemName.value,
                          style: const TextStyle(
                            color: BaseColor.baseColor,
                            fontSize: BaseFont.font22px,
                            fontFamily: BaseFont.familySub,
                          ),
                        )),
                    SizedBox(
                      height: 81.h,
                    ),
                    Container(
                      color: BaseColor.priceCheckNormalContentBackColor,
                      width: 848.w,
                      height: normalLineHeight.h,
                      child: buildCodeRow(
                        leftText: 'JANコード',
                        rightText: priceCheckCtrl.janCode.value,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      color: BaseColor.priceCheckNormalContentBackColor,
                      width: 848.w,
                      height: normalLineHeight.h,
                      child: buildCodeRow(
                        leftText: '分類コード',
                        rightText: priceCheckCtrl.clsCode.value,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: 848.w,
                      height: ItemScrollController.scrollHeight,
                      child: ScrollbarTheme(
                        data: ScrollbarThemeData(
                            thumbColor: MaterialStateProperty.all(
                              BaseColor.baseColor.withOpacity(0.5),
                            ),
                            thickness: MaterialStateProperty.all(5)),
                        child: Scrollbar(
                          controller: priceCheckDispCtrl.itemScrollCtrl,
                          thumbVisibility: true,
                          child: Obx(
                            () => ListView.separated(
                              controller: priceCheckDispCtrl.itemScrollCtrl,
                              itemCount:
                                  priceCheckCtrl.priceCheckItemData.length + (priceCheckDispCtrl.scrollBtnViewFlg.value ? 1 : 0),
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: 848.w,
                                  height: index == 0 ? topLineHeight : index == priceCheckCtrl.priceCheckItemData.length ? mixMatchLineHeight * mixMatchLineNumber : normalLineHeight,
                                  child: index < priceCheckCtrl.priceCheckItemData.length ? buildPriceRow(
                                      leftText: priceCheckCtrl
                                          .priceCheckItemData[index]
                                          .priceTypeName,
                                      rightText: NumberFormatUtil.formatAmount(
                                          priceCheckCtrl
                                              .priceCheckItemData[index].price),
                                      rightSubText1: priceCheckCtrl
                                          .priceCheckItemData[index].discountName,
                                      rightSubText2: priceCheckCtrl
                                          .priceCheckItemData[index].discountName.isNotEmpty
                                          ? NumberFormatUtil.formatMinusAmount(priceCheckCtrl
                                          .priceCheckItemData[index].discountPrice.abs())
                                          : '',
                                      boldLine: priceCheckCtrl
                                              .priceCheckItemData[index]
                                              .priceTypeName ==
                                          PriceCheckData.nowPriceItemName)
                                  : buildMixMatchRow(mixMatchData: priceCheckCtrl.mixMatchData.value),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 4);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),

          if (!(commonCtrl.isDualMode.value && EnvironmentData().screenKind == ScreenKind.register2))...{
            // 印字ボタン
            Obx(
                  () {
                if (priceCheckDispCtrl.printBtnViewFlg.value) {
                  return Positioned(
                      right: 272.w,
                      top: 32.h,
                      child: buildButtonWidget(
                          text: '印字',
                          oncallback: () async {
                            // todo ★★★バックエンド実装後に以下のコメントを復旧させること★★★
                            //priceCheckDispCtrl.printBtnViewFlg.value = false;
                            debugPrint('印字押下');
                            // todo 価格確認バックエンド処理１
                            // 印字処理
                            await printProcess();

                            // todo ★★★バックエンド実装後に以下のコメントを復旧させること★★★
                            //Get.back();
                          }));
                } else {
                  return Container();
                }
              },
            ),
            // 印字カットボタン
            Obx(
                  () {
                if (priceCheckDispCtrl.printBtnViewFlg.value) {
                  return Positioned(
                      right: 152.w,
                      top: 32.h,
                      child: buildButtonWidget(
                          text: '印字カット',
                          oncallback: () async {
                            // todo ★★★バックエンド実装後に以下のコメントを復旧させること★★★
                            //priceCheckDispCtrl.printBtnViewFlg.value = false;
                            debugPrint('印字カット押下');
                            // 印字カット処理
                            printCutProcess();

                            // todo ★★★バックエンド実装後に以下のコメントを復旧させること★★★
                            //Get.back();
                          }));
                } else {
                  return Container();
                }
              },
            ),
            // 印字終了ボタン
            Obx(
                  () {
                if (priceCheckDispCtrl.printBtnViewFlg.value) {
                  return Positioned(
                      right: 32.w,
                      top: 32.h,
                      child: buildButtonWidget(
                          text: '印字終了',
                          oncallback: () async {
                            // todo ★★★バックエンド実装後に以下のコメントを復旧させること★★★
                            //priceCheckDispCtrl.printBtnViewFlg.value = false;
                            debugPrint('印字終了押下');
                            // 印字処理
                            await printProcess();

                            // 価格確認モードの終了
                            // todo ★★★バックエンド実装後に以下のコメントを復旧させること★★★
                            //priceCheckCtrl.endPrcChkStatus();
                            //Get.back();
                          }));
                } else {
                  return Container();
                }
              },
            ),
          } else...{
            Container(),
          },
          // スクロールボタン
          Obx(() {
            if (priceCheckDispCtrl.scrollBtnViewFlg.value) {
              return Positioned(
                right: 0,
                top: 198,
                child: Column(
                  children: [
                    Opacity(
                      opacity: priceCheckDispCtrl.itemScrollCtrl.upOpacity.value,
                      child: Container(
                        width: 80.w,
                        height: 72.h,
                        decoration: const BoxDecoration(
                          color: BaseColor.otherButtonColor,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Material(
                          color: BaseColor.transparent,
                          child: SoundInkWell(
                            onTap: () {
                              // スクロールボタン△押下時のスクロール
                              priceCheckDispCtrl.itemScrollCtrl.scrollUp(
                                  pageHeight:
                                      ItemScrollController.scrollHeight);
                            },
                            callFunc: runtimeType.toString(),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/images/up.svg',
                                width: 30.w,
                                height: 18.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Opacity(
                      opacity: priceCheckDispCtrl.itemScrollCtrl.downOpacity.value,
                      child: Container(
                        width: 80.w,
                        height: 72.h,
                        decoration: const BoxDecoration(
                          color: BaseColor.otherButtonColor,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Material(
                          color: BaseColor.transparent,
                          child: SoundInkWell(
                            onTap: () {
                              // スクロールボタン△押下時のスクロール
                              priceCheckDispCtrl.itemScrollCtrl.scrollDown(
                                  pageHeight:
                                      ItemScrollController.scrollHeight);
                            },
                            callFunc: runtimeType.toString(),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/images/down.svg',
                                width: 30.w,
                                height: 18.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
        ],
      ),
    );
  }

  /// ボタンWidgetを作成する
  Widget buildButtonWidget(
      {required String text, required Function oncallback}) {
    return Container(
      width: 104.w,
      height: normalLineHeight.h,
      decoration: const BoxDecoration(
        color: BaseColor.otherButtonColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Material(
        color: BaseColor.transparent,
        child: SoundInkWell(
          onTap: () {
            oncallback();
          },
          callFunc: runtimeType.toString(),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: BaseColor.someTextPopupArea,
                fontSize: BaseFont.font18px,
                fontFamily: BaseFont.familySub,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 売価行を作成する
  /// leftText  左ラベルテキスト
  /// rightText 右ラベルテキスト
  /// rightSubText1 右列の補助テキスト1
  /// rightSubText2 右列の補助テキスト2
  /// boldLine ラベル列を青背景色とし、高さを高くする行かどうか
  Widget buildPriceRow(
      {String leftText = '',
      String rightText = '',
      String rightSubText1 = '',
      String rightSubText2 = '',
      bool boldLine = false}) {
    return SizedBox(
      height: boldLine ? topLineHeight : normalLineHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            color: boldLine
                ? BaseColor.priceCheckTopItemNameBackColor
                : BaseColor.baseColor,
            width: 200.w,
            child: Text(
              leftText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: BaseColor.someTextPopupArea,
                fontSize: BaseFont.font18px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            color: boldLine
                ? BaseColor.priceCheckTopContentBackColor
                : BaseColor.priceCheckNormalContentBackColor,
            width: 200.w,
            child: Text(
              rightText,
              style: TextStyle(
                color: BaseColor.baseColor,
                fontSize: boldLine ? BaseFont.font28px : BaseFont.font22px,
                fontFamily: BaseFont.familyNumber,
              ),
            ),
          ),
          Container(
            color: boldLine
                ? BaseColor.priceCheckTopContentBackColor
                : BaseColor.priceCheckNormalContentBackColor,
            width: 260.w,
          ),
          Container(
            alignment: Alignment.centerLeft,
            color: boldLine
                ? BaseColor.priceCheckTopContentBackColor
                : BaseColor.priceCheckNormalContentBackColor,
            width: 46.w,
            child: Text(
              rightSubText1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: BaseColor.baseColor,
                fontSize: BaseFont.font18px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            color: boldLine
                ? BaseColor.priceCheckTopContentBackColor
                : BaseColor.priceCheckNormalContentBackColor,
            width: 140.w,
            child: Padding(
              padding: const EdgeInsets.only(right: 60),
              child: Text(
                rightSubText2,
                style: const TextStyle(
                  color: BaseColor.baseColor,
                  fontSize: BaseFont.font22px,
                  fontFamily: BaseFont.familyNumber,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// コード行を作成する
  /// leftText  左ラベルテキスト
  /// rightText 右ラベルテキスト
  Widget buildCodeRow({String leftText = '', String rightText = ''}) {
    return SizedBox(
      height: normalLineHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            color: BaseColor.baseColor,
            width: 200.w,
            child: Text(
              leftText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: BaseColor.someTextPopupArea,
                fontSize: BaseFont.font18px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: 648.w,
            child: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                rightText,
                style: const TextStyle(
                  color: BaseColor.baseColor,
                  fontSize: BaseFont.font22px,
                  fontFamily: BaseFont.familyDefault,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ミックスマッチ行を作成する
  /// mixMatchData  ミックスマッチ情報
  Widget buildMixMatchRow(
      {required MixMatchData mixMatchData,}) {
    return Container(
      color: BaseColor.priceCheckNormalContentBackColor,
      height: mixMatchLineHeight * mixMatchLineNumber,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                color: BaseColor.baseColor,
                height: mixMatchLineHeight,
                width: 200.w,
                child: const Text(
                  MixMatchData.mixMatchItemName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: BaseColor.someTextPopupArea,
                    fontSize: BaseFont.font18px,
                    fontFamily: BaseFont.familyDefault,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: mixMatchLineHeight,
                alignment: Alignment.center,
                color: BaseColor.baseColor,
                width: 200.w,
              ),
              Container(
                alignment: Alignment.centerRight,
                color: BaseColor.priceCheckNormalContentBackColor,
                width: 120.w,
                height: mixMatchLineHeight,
                child: Text(
                  mixMatchData.isGeneralExist ? '個数' : '',
                  style: const TextStyle(
                    color: BaseColor.baseColor,
                    fontSize: BaseFont.font18px,
                    fontFamily: BaseFont.familyDefault,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                color: BaseColor.priceCheckNormalContentBackColor,
                width: 160.w,
                height: mixMatchLineHeight,
                child: Text(
                  mixMatchData.isGeneralExist ? '一般' : '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: BaseColor.baseColor,
                    fontSize: BaseFont.font18px,
                    fontFamily: BaseFont.familyDefault,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                color: BaseColor.priceCheckNormalContentBackColor,
                width: 120.w,
                height: mixMatchLineHeight,
                child: Text(
                  mixMatchData.isMemberExist ? '個数' : '',
                  style: const TextStyle(
                    color: BaseColor.baseColor,
                    fontSize: BaseFont.font18px,
                    fontFamily: BaseFont.familyDefault,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                color: BaseColor.priceCheckNormalContentBackColor,
                width: 160.w,
                height: mixMatchLineHeight,
                child: Text(
                  mixMatchData.isMemberExist ? '会員' : '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: BaseColor.baseColor,
                    fontSize: BaseFont.font18px,
                    fontFamily: BaseFont.familyDefault,
                  ),
                ),
              ),
            ],
          ),
          for (int i = 0; i < MixMatchData.mixMatchMaxItemNumber; i++) ...{
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // 条件名
                Container(
                  height: mixMatchLineHeight,
                  alignment: Alignment.center,
                  color: BaseColor.baseColor,
                  width: 200.w,
                  child: Text(
                    isViewTarget(i , true, mixMatchData) ? mixMatchData.mixMatchItems[i].conditionName : '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: BaseColor.someTextPopupArea,
                      fontSize: BaseFont.font18px,
                      fontFamily: BaseFont.familyDefault,
                    ),
                  ),
                ),
                // 一般部分－個数
                Container(
                  alignment: Alignment.centerRight,
                  color: BaseColor.priceCheckNormalContentBackColor,
                  width: 120.w,
                  height: mixMatchLineHeight,
                  child: Text(
                    (isViewTarget(i , mixMatchData.isGeneralExist, mixMatchData) && mixMatchData.mixMatchItems[i].generalQty != 0)
                    ? '${mixMatchData.mixMatchItems[i].generalQty.toString()}個' : '',
                    style: const TextStyle(
                      color: BaseColor.baseColor,
                      fontSize: BaseFont.font22px,
                      fontFamily: BaseFont.familyDefault,
                    ),
                  ),
                ),
                // 一般部分－価格
                Container(
                  alignment: Alignment.centerRight,
                  color: BaseColor.priceCheckNormalContentBackColor,
                  width: 160.w,
                  height: mixMatchLineHeight,
                  child: Text(
                    (isViewTarget(i , mixMatchData.isGeneralExist, mixMatchData) && mixMatchData.mixMatchItems[i].generalPrice != 0)
                    ? NumberFormatUtil.formatAmount(mixMatchData.mixMatchItems[i].generalPrice) : '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: BaseColor.baseColor,
                      fontSize: BaseFont.font22px,
                      fontFamily: BaseFont.familyNumber,
                    ),
                  ),
                ),
                // 会員部分－個数
                Container(
                  alignment: Alignment.centerRight,
                  color: BaseColor.priceCheckNormalContentBackColor,
                  width: 120.w,
                  height: mixMatchLineHeight,
                  child: Text(
                    (isViewTarget(i , mixMatchData.isMemberExist, mixMatchData) && mixMatchData.mixMatchItems[i].memberQty != 0)
                    ? '${mixMatchData.mixMatchItems[i].memberQty.toString()}個' : '',
                    style: const TextStyle(
                      color: BaseColor.baseColor,
                      fontSize: BaseFont.font22px,
                      fontFamily: BaseFont.familyDefault,
                    ),
                  ),
                ),
                // 会員部分－価格
                Container(
                  alignment: Alignment.centerRight,
                  color: BaseColor.priceCheckNormalContentBackColor,
                  width: 160.w,
                  height: mixMatchLineHeight,
                  child: Text(
                    (isViewTarget(i , mixMatchData.isMemberExist, mixMatchData) && mixMatchData.mixMatchItems[i].memberPrice != 0)
                    ? NumberFormatUtil.formatAmount(mixMatchData.mixMatchItems[i].memberPrice) : '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: BaseColor.baseColor,
                      fontSize: BaseFont.font22px,
                      fontFamily: BaseFont.familyNumber,
                    ),
                  ),
                ),
              ],
            ),
          },
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: mixMatchLineHeight,
                alignment: Alignment.center,
                color: BaseColor.baseColor,
                width: 200.w,
                child: const Text(
                  '成立後平均単価',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: BaseColor.someTextPopupArea,
                    fontSize: BaseFont.font18px,
                    fontFamily: BaseFont.familyDefault,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                color: BaseColor.priceCheckNormalContentBackColor,
                width: 280.w,
                height: mixMatchLineHeight,
                child: Text(
                  mixMatchData.isGeneralExist ? NumberFormatUtil.formatAmount(mixMatchData.generalAverageUnitPrice) : '',
                  style: const TextStyle(
                    color: BaseColor.baseColor,
                    fontSize: BaseFont.font22px,
                    fontFamily: BaseFont.familyNumber,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                color: BaseColor.priceCheckNormalContentBackColor,
                width: 280.w,
                height: mixMatchLineHeight,
                child: Text(
                  mixMatchData.isMemberExist ? NumberFormatUtil.formatAmount(mixMatchData.memberAverageUnitPrice) : '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: BaseColor.baseColor,
                    fontSize: BaseFont.font22px,
                    fontFamily: BaseFont.familyNumber,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ミックスマッチの各条件行が表示対象かどうかを判定する
  bool isViewTarget(int index, bool isTypeOk, MixMatchData mixMatchData) {
    return index < mixMatchData.validConditionNumber && isTypeOk;
  }

  /// 印字処理を行う
  Future<void> printProcess() async {
    // todo 価格確認バックエンド処理１
    // 印字処理

    // todo 印字関係の対応後は削除
    MsgDialog.showNotImplDialog();
  }

  /// 印字カット処理を行う
  void printCutProcess() {
    // todo 価格確認バックエンド処理２
    // 印字カット処理

    // todo 印字関係の対応後は削除
    MsgDialog.showNotImplDialog();
  }
}

