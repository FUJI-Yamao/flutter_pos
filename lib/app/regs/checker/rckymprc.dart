/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';

import 'rcsyschk.dart';
/// 会員価格
///  関連tprxソース: rckymprc.c
class RckyMprc {
  static int cardForgotBtnFlg = 0; // 会員選択画面(QC/セルフ)にてカード忘れボタン押下フラグ

  /// 会員選択画面(QC/セルフ)にてカード忘れボタン押下フラグ確認
  /// 戻り値: 0=カード忘れ処理を行っていない, 1=カード忘れ処理を行っている
  ///  関連tprxソース: rckymprc.c - rcMprc_Card_Forgot_Btn_Flag_Check
  static int rcMprcCardForgotBtnFlagCheck() {
    int ret = 0;
    // カード忘れ処理が有効のユーザー仕様確認
    if (RcSysChk.rcChkCustrealFrestaSystem()) {
      // カード忘れボタン押下フラグ確認
      if (cardForgotBtnFlg != 0) {
        ret = 1;
      }
    }

    return ret;
  }
}