/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/page/full_self/member_info_loading/component/w_full_self_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../colorfont/c_basecolor.dart';
import '../component/w_full_self_membercardload.dart';
import '../component/w_full_self_leftside.dart';

///会員情報読み込みページ
class FullSelfMemberCardSelectPage extends StatelessWidget {
  const FullSelfMemberCardSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.customerPageBackGroundColor,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FullSelfSideBarWidget(scenario: FullSelfSideBarWidget.selectPage),
          Expanded(
            child: Column(
              children: [
                const FullSelfHeaderTextWidget(
                  text: '会員カードはお持ちですか？下記からお選びください',
                ),
                SizedBox(height: 128.h),
                const ArcusApp(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
