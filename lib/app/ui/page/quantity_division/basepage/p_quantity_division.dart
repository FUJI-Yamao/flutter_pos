/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_inputbox.dart';
import '../../../component/w_sound_buttons.dart';
import '../../common/basepage/common_base.dart';
import '../../detail_modifi/controller/c_purchase_detail_modify_controller.dart';
import '../../register/component/w_purchasewidget_base.dart';
import '../../register/controller/c_register_change.dart';
import '../../register/pixel/c_pixel.dart';
import '../controller/c_quantity_division.dart';

///todo:現在保留の分割画面ページ
class QuantityDivisionScreen extends CommonBasePage {
  QuantityDivisionScreen({
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  });

  @override
  Widget buildBody(BuildContext context) {
    return QuantityDivisionWidget(
      backgroundColor: backgroundColor,
    );
  }
}

class QuantityDivisionWidget extends StatefulWidget {

  final Color backgroundColor;

  const QuantityDivisionWidget({super.key, required this.backgroundColor});

  @override
  QuantityDivisionState createState() => QuantityDivisionState();
}

class QuantityDivisionState extends State<QuantityDivisionWidget> {
  late final DetailModifyInputController detailModifyInputCtrl;

  ///コントローラー
  late QuantityDivisionInputController quantityDivisionInputCtrl = Get.find();

  List<String> labels = [
    // 数量
    'test'
  ];

  @override
  void initState() {
    super.initState();
    List<GlobalKey<InputBoxWidgetState>> inputBoxKeys =
    labels.map((_) => GlobalKey<InputBoxWidgetState>()).toList();
    quantityDivisionInputCtrl = QuantityDivisionInputController(
      quantityDivisionBoxList: inputBoxKeys,
      labels: labels,
    );
    Get.put(quantityDivisionInputCtrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(88.h),

        // TODO:各項目の表示や配置などは暫定
        child: Flex(
          direction: Axis.vertical,
          children: [
            Container(
              color: BaseColor.someTextPopupArea.withOpacity(0.7),
              padding: const EdgeInsets.all(20),
              width: 1024.w,
              alignment: Alignment.center,
              child: const Text(
                  "分割する数量を入力してください",
                  style: TextStyle(
                    color: BaseColor.baseColor,
                    fontSize: BaseFont.font22px,
                    fontFamily: BaseFont.familyDefault,
                  ),
                  textAlign: TextAlign.center,
                )
              ),
            Flex(
              direction: Axis.horizontal,
              children: [
                /// 数量変更の表示エリア
                Container(
                  width: 724.w,
                  height: double.infinity,
                  child: Flex(
                    direction: Axis.vertical,
                    children: [

                      /// 個数分割エリア
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: Flex(
                            direction: Axis.vertical,
                            children: [

                              /// 分割前エリア
                              Container(
                                alignment: Alignment.center,
                                width: 200.w,
                                height: 280.h,
                                color: BaseColor.storeOpenCloseWhiteColor,
                                child: const Text(
                                  "分割前エリア",
                                  style: TextStyle(
                                    fontSize: BaseFont.font18px,
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: BaseFont.familyDefault,
                                  ),
                                ),
                              ),

                              /// 矢印表示エリア
                              Container(
                                alignment: Alignment.center,
                                width: 80.w,
                                height: 136.h,
                                child: const Text(
                                  "矢印エリア",
                                  style: TextStyle(
                                    fontSize: BaseFont.font18px,
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: BaseFont.familyDefault,
                                  ),
                                ),
                              ),

                              /// 分割後エリア
                              Container(
                                alignment: Alignment.centerRight,
                                width: 200.w,
                                height: 280.h,
                                color: BaseColor.storeOpenCloseWhiteColor,
                                child: const Text(
                                  "分割後エリア",
                                  style: TextStyle(
                                    fontSize: BaseFont.font18px,
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: BaseFont.familyDefault,
                                  ),
                                ),
                              ),
                            ]
                        ),
                      ),

                      ///　前の画面に戻るボタン
                      Container(
                        padding: const EdgeInsets.only(top: 500),
                        alignment: Alignment.centerLeft,
                        child:SizedBox(
                          width: 200.w,
                          height: 56.h,
                          child: SoundElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF606F80),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              shadowColor: BaseColor.dropShadowColor,
                              elevation: 3,
                            ),
                            callFunc: runtimeType.toString(),
                            onPressed: () {
                              Get.back();
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/icon_open.svg',
                                  width: 32.w,
                                  height: 32.h,
                                ),
                                const Text(
                                  "前の画面に戻る",
                                  style: TextStyle(
                                    fontSize: BaseFont.font18px,
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: BaseFont.familyDefault,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /// テンキー表示エリア
                Container(
                  width: 300.w,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: Colors.green
                  ),
                  child: const Text(
                    "テンキー表示エリア"
                  )
                ),
              ],
            )
          ]
        ),
      ),
    );
  }
}