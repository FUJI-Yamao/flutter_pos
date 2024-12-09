/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import '../../../../colorfont/c_basecolor.dart';
import '/app/ui/page/maintenance/specfile/model/m_widgetsetting.dart';

/// 説明表示用ダイアログ
class DiscriptionDialog extends StatelessWidget {
  const DiscriptionDialog({super.key, required this.discription});

  final String discription;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:  BaseColor.maintainBaseColor,
      content: Container(

        decoration: const BoxDecoration(color:  BaseColor.maintainBaseColor,),
        child: Text(
          discription,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
