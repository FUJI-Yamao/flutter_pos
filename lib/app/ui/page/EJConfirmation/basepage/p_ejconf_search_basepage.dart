/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/component/w_inputbox.dart';
import 'package:flutter_pos/app/ui/page/EJConfirmation/controller/c_ejconf_controller.dart';
import 'package:flutter_pos/app/ui/page/common/basepage/common_base.dart';
import 'package:flutter_pos/app/ui/page/subtotal/component/w_register_tenkey.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../colorfont/c_basecolor.dart';
import '../component/w_ejconf_search_container.dart';
import '../enum/e_EJconf_enum.dart';

///記録確認の取引を検索するページ
class EJConfirmationSearchScreen extends CommonBasePage {
  EJConfirmationSearchScreen({
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  });

  @override
  Widget buildBody(BuildContext context) {
    return EJConfirmationSearchWidget(
      backgroundColor: backgroundColor,
    );
  }
}

class EJConfirmationSearchWidget extends StatefulWidget {
  final Color backgroundColor;

  const EJConfirmationSearchWidget({super.key, required this.backgroundColor});

  @override
  EJConfirmationSearchState createState() => EJConfirmationSearchState();
}

class EJConfirmationSearchState extends State<EJConfirmationSearchWidget> {
  late final EJconfInputController ejconfCtrl;


  @override
  void initState() {
    super.initState();
    List<GlobalKey<InputBoxWidgetState>> inputBoxKeys =
        labels.map((_) => GlobalKey<InputBoxWidgetState>()).toList();
    ejconfCtrl = EJconfInputController(
      ejconfinputBoxList: inputBoxKeys,
      labels: labels,
    );
     Get.put(ejconfCtrl);
  }

  List<EJconfInputFieldLabel> labels = [
    EJconfInputFieldLabel.businessDay,
    EJconfInputFieldLabel.timeZoneOne,
    EJconfInputFieldLabel.timeZoneTwo,
    EJconfInputFieldLabel.receiptNum,
    EJconfInputFieldLabel.keyWord,
    EJconfInputFieldLabel.registerNum,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(88.h),
        child: Container(
          color: BaseColor.someTextPopupArea.withOpacity(0.7),
          child: const Center(
            child: Text(
              '検索の条件を入力してください',
              style: TextStyle(
                color: BaseColor.baseColor,
                fontSize: BaseFont.font22px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 72.w,
            top: 32.h,
            child: EJconfSearchContainerWidget(title: '記録確認', labels: labels),
          ),
          Obx(() {
            if (ejconfCtrl.showRegisterTenkey.value) {
              return Positioned(
                right: 32.w,
                bottom: 32.h,
                child: RegisterTenkey(
                  onKeyTap: (key) {
                    ejconfCtrl.inputKeyType(key);
                  },
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
}
