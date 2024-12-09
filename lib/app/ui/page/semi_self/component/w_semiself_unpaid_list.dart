/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/number_util.dart';
import '../../../../regs/checker/rcky_qcselect.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../controller/c_unpaid_controller.dart';

///未精算一覧の左部分
class UnpaidListLeftSection extends StatelessWidget {
  final UnPaidListController unPaidCtrl = Get.find<UnPaidListController>();

  ///精算機のコンテナー色設定
  Color _getMachineColor(int mac_no) {
    switch(mac_no) {
      case 1:
        return Colors.yellow[300]!;
      case 2:
        return Colors.blueGrey[100]!;
      case 3:
        return Colors.purple[100]!;
      default:
        return Colors.yellow[300]!;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '呼び戻したい未精算取引を選択してください',
          style: TextStyle(
            fontSize: BaseFont.font22px,
            color: BaseColor.baseColor,
          ),
        ),
        const Text(
          '(右側には取引の詳細が表示されます)',
          style: TextStyle(
            fontSize: BaseFont.font22px,
            color: BaseColor.baseColor,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Obx(() {
          return Column(
            children: unPaidCtrl.outputList.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> item = entry.value;

              bool isSelected = unPaidCtrl.selectedIndex.value == index;

              if (index >= unPaidCtrl.outputList.length) {
                return Container();
              }

              return GestureDetector(
                onTap: () {
                  unPaidCtrl.selectedItem(index);
                },
                child: Container(
                  width: 550.w,
                  height: 65.h,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected
                          ? Colors.blue
                          : BaseColor.baseColor,
                      width: isSelected ? 3 : 1,
                    ),
                    color: isSelected
                        ? Colors.grey[300]
                        : BaseColor.transparent,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 65.w,
                        height: 65.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: BaseColor.backColor),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${index + unPaidCtrl.viewOffset.value + 1}',
                          style: const TextStyle(
                            fontSize: 24,
                            color: BaseColor.baseColor,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 10, top: 3, bottom: 3),
                                child: Text(
                                  item['time'],
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: BaseColor.baseColor,
                                  ),
                                ),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        item['receiptnumber'],
                                        style: const TextStyle(
                                          fontSize: 24,
                                          color: BaseColor.baseColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${item['quantity']}点',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        color: BaseColor.baseColor,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(
                                        NumberFormatUtil.formatAmount(item['amount']),
                                        style: const TextStyle(
                                          fontSize: 24,
                                          color: BaseColor.baseColor,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ],
                          )),
                      Container(
                        width: 120.w,
                        height: 65,
                        color: _getMachineColor(item['mac_no']),
                        alignment: Alignment.center,
                        child: Text(
                          RckyQcSelect.getMacNameByMacNo(item['mac_no']),
                          style: const TextStyle(
                            fontSize: 24,
                            color: BaseColor.baseColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        })
      ],
    );
  }
}
