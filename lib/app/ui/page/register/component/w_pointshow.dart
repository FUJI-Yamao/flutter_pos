/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../ui/colorfont/c_basefont.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../component/w_sound_buttons.dart';
import '../controller/c_registerbody_controller.dart';

/// ポイント表示部分
class PointShowWidget extends StatelessWidget {
  /// コンストラクタ
  const PointShowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ///コントローラー
    RegisterBodyController bodyCtrl = Get.find();
    /// ポイントNoが取得できていない場合は会員情報が取得できていないとみなす
    return Obx(() => !bodyCtrl.viewMemberInfo.value
      ? Container(
        height: 64,
        color: BaseColor.someTextPopupArea,
      )
      : Stack(
        children: [
          Container(
            height: 64,
            color: BaseColor.someTextPopupArea,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 93,
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Container(
                            width: 210,
                            padding: const EdgeInsets.only(left: 4, right: 5,
                                top: 6, bottom: 6),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: bodyCtrl.memberBackColor.value,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(2),
                                    topRight: Radius.circular(2),
                                    bottomLeft: Radius.circular(2),
                                    bottomRight: Radius.circular(2),
                                  ),
                                ),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    bodyCtrl.viewMemberIcon.value
                                    ? Center(
                                        child: SvgPicture.asset(
                                          'assets/images/icon_membership.svg',
                                          colorFilter: const ColorFilter.matrix([
                                            -1, 0, 0, 0, 255,
                                            0, -1, 0, 0, 255,
                                            0, 0, -1, 0, 255,
                                            0, 0, 0, 1, 0,
                                          ]),
                                          width: 36,
                                          height: 24,
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 24,
                                      )
                                    ,
                                    bodyCtrl.viewMemberIcon.value
                                    ? Center(
                                        child: Text(
                                          bodyCtrl.memberType.value,
                                          style: const TextStyle(
                                            fontFamily: BaseFont.familyDefault,
                                            fontSize: BaseFont.font14px,
                                          ),
                                        )
                                    )
                                    :
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          bodyCtrl.memberType.value,
                                          style: const TextStyle(
                                            fontFamily: BaseFont.familyDefault,
                                            fontSize: BaseFont.font14px,
                                          ),
                                        )
                                      ),
                                    ),
                                  ]
                                ),
                              ),
                          ),

                          Expanded(
                            flex: 218,
                            child: Container(
                              padding:
                              const EdgeInsets.only(right: 26),
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  textAlign: TextAlign.right,
                                  bodyCtrl.memberNo.value,
                                  style: const TextStyle(
                                    fontFamily: BaseFont.familyNumber,
                                    fontSize: BaseFont.font18px),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      bodyCtrl.viewMemberPoints.value
                      ? Flex(
                        direction: Axis.horizontal,
                        children:[
                            Container(
                            width: 97,
                            alignment: Alignment.centerLeft,
                            padding:
                            const EdgeInsets.only(left: 8),
                            child: const Text(
                              'ポイント累計',
                              style: TextStyle(
                                fontFamily: BaseFont.familyDefault,
                                fontSize: BaseFont.font14px,
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide(
                                        width: 1, color: BaseColor.edgeBtnColor)
                                    ),
                                  ),
                                  child: Container(
                                      padding:
                                      const EdgeInsets.only(bottom: 3),
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        bodyCtrl.pointCumulateTotal.value,
                                        style: const TextStyle(
                                          fontFamily: BaseFont.familyNumber,
                                          fontSize: BaseFont.font18px),
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 5,),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 218,
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Container()
                                // Expanded(
                                //   flex: 74,
                                //   child: Container(
                                //     padding : const EdgeInsets.only(right: 4),
                                //     alignment: Alignment.centerRight,
                                //     child: const Text('プリカ残高',
                                //       style:
                                //       TextStyle(fontSize: BaseFont.font14px)
                                //     ),
                                //   ),
                                // ),
                                // Expanded(
                                //   flex: 80,
                                //   child: Container(
                                //     padding: const EdgeInsets.only(right: 32),
                                //     child: Column(
                                //       children: [
                                //         Container(
                                //           decoration: const BoxDecoration(
                                //             border: Border(bottom: BorderSide(
                                //                 width: 1, color: BaseColor.edgeBtnColor)
                                //             ),
                                //           ),
                                //           child: Obx(() => Container(
                                //              padding:
                                //              const EdgeInsets.only(bottom: 3),
                                //             alignment: Alignment.topRight,
                                //             child: Text(
                                //                 bodyCtrl.prepaidCardBalance.value,
                                //                 textAlign: TextAlign.right,
                                //                 style: const TextStyle(
                                //                     fontFamily: BaseFont.familyNumber,
                                //                     fontSize: BaseFont.font18px)),
                                //           )),
                                //         ),
                                //         const SizedBox(height: 5),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ) : Container(),
                     ],
                  ),
                ),
                Stack(children: [
                  Container(
                      decoration: const BoxDecoration(
                        gradient:  LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            BaseColor.registMemverDetailStartColor,
                            BaseColor.registMemverDetailEndColor,
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                               topRight: Radius.circular(4),
                               bottomRight: Radius.circular(4),
                        ),
                      ),
                    alignment: Alignment.bottomCenter,
                    height: 64,
                    width: 48,
                    child: Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/images/icon_open_2.svg',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: BaseColor.transparentColor,
                      child: SoundInkWell(
                        onTap: () => {},
                        callFunc: runtimeType.toString(),
                        child: null,
                      ),
                    ),
                  )
                ]),
              ],
            ),
          ),
        ],
    ));
  }
}
