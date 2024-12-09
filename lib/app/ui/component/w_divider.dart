/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colorfont/c_basecolor.dart';

/// リスト隙間のdivider
class ListDivider extends StatelessWidget {
  const ListDivider({
    super.key,
    this.borderColor = BaseColor.dividerColor,
  });
 final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0,
      thickness: 1,
      color:borderColor,
    );
  }
}