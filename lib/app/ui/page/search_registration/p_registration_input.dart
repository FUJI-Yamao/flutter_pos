/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/component/w_inputbox.dart';
import 'package:flutter_pos/app/ui/page/search_registration/controller/c_registration_scan_ctrl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../common/basepage/common_base.dart';
import '../common/component/w_dicisionbutton.dart';
import '../subtotal/component/w_register_tenkey.dart';
import 'controller/c_registration_input_ctrl.dart';
import 'enum/e_registration_input_enum.dart';
import '../../../inc/sys/tpr_log.dart';

/// 通番訂正/検索領収書入力画面、実行画面
class RegistrationInputPageWidget extends CommonBasePage {
  ///　コンストラクタ
  RegistrationInputPageWidget({
    super.key,
  }) {
    List<dynamic> arg = Get.arguments;
    registInputCtrl = Get.put(RegistrationInputController(labels: []));
    registInputCtrl.initLabels(arg[1]);
    registInputCtrl.title = arg[0];
    title = arg[0];
    funcKey = arg[2];
    registInputCtrl.initValues = List.filled(_leftColumnsCount, '');
    /// TODO バーコードスキャン対応をバックエンドとの繋ぎこみ時に追加する
    // if(arg.length > 3){
    //   registInputCtrl.initValues = arg[3];
    //   TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'registInputCtrl.initValues:${registInputCtrl.initValues}');
    //   registInputCtrl.showDecisionButton.value = true;
    //   registInputCtrl.showRegisterTenkey.value = false;
    //   registInputCtrl.showRegisterTenkey.value = false;
    // }
  }

  /// 画面左側の入力欄の数(2つ)
  static const _leftColumnsCount = 2;

  final RegistrationScanController registScanCtrl = Get.find();

  /// コントローラー
  late final RegistrationInputController registInputCtrl;

  /// 各入力widgetの作成
  Widget _registrationListWidget(RegistrationInputFieldLabel labelEnum, int index, String initStringValue) {

    /// ラベルの取得
    String label = labelEnum.label;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 296.w,
          height: 32.h,
          alignment: Alignment.centerLeft,
          color: BaseColor.baseColor,
          padding: EdgeInsets.only(left: 16.w),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: BaseFont.font16px,
                fontFamily: BaseFont.familyDefault,
                color: BaseColor.someTextPopupArea),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          alignment: Alignment.centerLeft,
          child: InputBoxWidget(
              key: registInputCtrl.inputBoxList[index],
              width: 296.w,
              height: 56.h,
              fontSize: BaseFont.font28px,
              textAlign: TextAlign.right,
              padding: EdgeInsets.only(right: 32.w),
              cursorColor: BaseColor.baseColor,
              unfocusedBorder: BaseColor.inputFieldColor,
              focusedBorder: BaseColor.accentsColor,
              focusedColor: BaseColor.inputBaseColor,
              borderRadius: 4,
              blurRadius: 6,
              funcBoxTap: () {
                registInputCtrl.onInputBoxTap(index);
              },
              iniShowCursor: false,
          ),
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Obx(() {
      //2列表示するかを判断
      bool isTwoColumns = registInputCtrl.labels.length > _leftColumnsCount;
      return Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(56.w, 88.h, 344, 112.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: List.generate(
                      registInputCtrl.labels.length > _leftColumnsCount ? _leftColumnsCount : registInputCtrl.labels.length,
                          (index) {
                        RegistrationInputFieldLabel labelKey =
                        registInputCtrl.labels.elementAt(index);
                        return Column(
                          children: [
                            _registrationListWidget(labelKey, index, registInputCtrl.initValues[index]),
                            if (index != registInputCtrl.labels.length - 1 &&
                                index != 3)
                              const SizedBox(
                                height: 40,
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                if (isTwoColumns)
                  const SizedBox(
                    width: 32,
                  ),
                Expanded(
                  child: Column(
                    children: List.generate(
                      registInputCtrl.labels.length - _leftColumnsCount,
                          (index) {
                        int actualIndex = index + _leftColumnsCount;
                        RegistrationInputFieldLabel labelKey =
                        registInputCtrl.labels.elementAt(actualIndex);
                        return Column(
                          children: [
                            _registrationListWidget(labelKey, actualIndex,""),
                            if (actualIndex != registInputCtrl.labels.length - 1)
                              const SizedBox(
                                height: 40,
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          ///テンキー
          Obx(
                () {
              if (registInputCtrl.showRegisterTenkey.value) {
                return Positioned(
                  right: 0.04.sw,
                  bottom: 0.04.sh,
                  child: RegisterTenkey(onKeyTap: (key) {
                    registInputCtrl.inputKeyType(key);
                  }),
                );
              } else {
                return Container();
              }
            },
          ),

          ///実行ボタン
          Obx(
                () {
              if (registInputCtrl.showDecisionButton.value) {
                return Positioned(
                  right: 0.04.sw,
                  bottom: 0.04.sh,
                  child: DecisionButton(
                    oncallback: () async {
                      await registInputCtrl.onDecisionButtonPressed(funcKey);
                    },
                    text: '実行',
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      );
    });
  }
}
