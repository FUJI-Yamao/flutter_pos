/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../colorfont/c_basecolor.dart';
import '../../../../component/w_inputbox.dart';
import '../../template/basepage/maintainbase.dart';
import '../model/m_specfile.dart';
import '/app/ui/page/maintenance/specfile/controller/c_ipaddress_controller.dart';
import '../../../common/component/w_msgdialog.dart';
import 'w_tenkey.dart';

/// IPアドレス入力画面
class IpaddressInputWidget extends MaintainBasePage {
  ///コンストラクタ
  IpaddressInputWidget({
    super.key,
    required super.title,
    required super.currentBreadcrumb,
    required this.settingName,
    required this.setting,
    required this.initValue,
  }) {
    controller = Get.put(IPAddressController(inputBoxList,
        minValue: setting.minValue, maxValue: setting.maxValue));
    controller.changeEditPosition(0);
  }

  ///入力ボックス個数
  static const int ipBoxNum = 4;

  ///IPアドレスの設定
  late IpAddressInputSetting setting;

  ///入力ボックスグローバルキーリスト
  final List<GlobalKey<InputBoxWidgetState>> inputBoxList =
      List.generate(ipBoxNum, (index) => GlobalKey<InputBoxWidgetState>());

  ///コントローラー
  late IPAddressController controller;

  ///設定項目名
  final String settingName;

  ///初期値
  final List<String> initValue;

  @override
  Widget body(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 120.w, left: 120.w),
      child: Flex(
        direction: Axis.vertical,
        children: [
          SizedBox(
            height: 10.h,
          ),

          /// 設定項目名を表示
          Container(
            width: 700.w,
            alignment: Alignment.center,
            child: Text(
              settingName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: BaseFont.font26px,
                  color: BaseColor.someTextPopupArea),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),

          ///IPアドレス入力ボックスとテンキーwidgetの配置
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: SizedBox(
                    height: 50.h,
                    width: 400.w,
                    child: Flex(
                        mainAxisAlignment: MainAxisAlignment.center,
                        direction: Axis.horizontal,
                        children: [
                          for (int i = 0; i < ipBoxNum; i++) ...{
                            InputBoxWidget(
                              key: inputBoxList[i],
                              width: 70.w,
                              height: 50.h,
                              fontSize: BaseFont.font26px,
                              initStr: initValue[i].toString(),
                              textAlign: TextAlign.left,
                              funcBoxTap: () {
                                controller.changeEditPosition(i);
                              },
                              iniShowCursor: i == 0,
                              mode: InputBoxMode.defaultMode,
                            ),
                            if (i != 3)
                              Container(
                                  alignment: Alignment.bottomCenter,
                                  height: 50.h,
                                  width: 20.w,
                                  child: const Text(
                                    ".",
                                    style: TextStyle(
                                        fontSize: BaseFont.font26px,
                                        color: BaseColor.someTextPopupArea),
                                  ))
                          },
                        ])),
              ),
              TenkeyWidget(
                controller: controller,
                dispTab: true,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),

          ///キャンセル・決定ボタン
          cancelDecideButton(onCancel: () {
            Get.back();
          }, onDecide: () {
            bool valid = controller.checkWithInRange();
            if (valid) {
              Get.back(result: controller.ipJoin());
            } else {

              MsgDialog.show(
                MsgDialog.singleButtonMsg(
                  type: MsgDialogType.error,
                  message: "[${setting.minValue.join(".")}]から[${setting.maxValue.join(".")}]の範囲内の値を入力してください",
                ),
              );

            }
          })
        ],
      ),
    );
  }
}
