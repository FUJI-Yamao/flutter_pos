/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/component/w_arrowbtn.dart';
import 'package:flutter_pos/app/ui/component/w_btn.dart';
import '../../../../component/w_label.dart';
import '../../../../component/w_text.dart';

/// ラベル/テキスト/ボタン　3表示Widget
class SioListWidget extends StatelessWidget {
  const SioListWidget({
    super.key,
    required this.lblsetting,
    required this.txtsetting,
    required this.btnsetting,
    required this.axis,
    this.flex = 5,
  });

  final lblsetting;
  final txtsetting;
  final btnsetting;
  final axis;
  final int flex;

  @override
  Widget build(BuildContext context) {
    bool notUser = (lblsetting.value.text == "") && (txtsetting == null);
    int lastSecondFlex = 8 - flex;
    int lastFlex = 1;
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: SizedBox(
        child: Row(children: [
          if (notUser)
            const Row(children: [
              SizedBox(
                width: 10,
              ),
              Icon(Icons.remove, color: Colors.white, size: 20),
              SizedBox(
                width: 5,
              ),
            ])
          else if (txtsetting != null)
            const Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.remove, color: Colors.white, size: 20),
                SizedBox(
                  width: 5,
                ),
              ],
            )
          else if (btnsetting != null)
            const Row(
              children: [
                SizedBox(width: 10),
                RotatingLine(),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          Expanded(
            flex: flex,
            child: LabelBtnWidget(
              setting: lblsetting,
            ),
          ),
          if (txtsetting != null)
            Expanded(
              flex: lastSecondFlex,
              child: TextBtnWidget(
                setting: txtsetting,
              ),
            ),
          Expanded(
              flex: lastFlex,
              child: BtnWidget(
                setting: btnsetting,
              )),
        ]),
      ),
    );
  }
}
