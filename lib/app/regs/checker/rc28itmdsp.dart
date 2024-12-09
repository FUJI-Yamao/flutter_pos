/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/cm_nedit.dart';
import 'rcstllcd.dart';

///関連tprxソース: rc28itmdsp.c
class Rc28ItmDsp {
  ///関連tprxソース: rc28itmdsp.c - rcQty_Clr
  static void rcQty28Clr() {
    String buf = '';
    CmEditCtrl fCtrl = CmEditCtrl();

    fCtrl.SignEdit = 1;
    fCtrl.SignSize = 1;
    fCtrl.DataSize = 1;

    // TODO:00013 三浦 実装必要？
    // gtk_widget_hide(Tran.ten_entrye_pbchg);
    // gtk_widget_show(Tran.ten_entrye);
    // rcSet_Str_BothEnd(fCtrl, buf, sizeof(buf), 0, TTLQTY_END, 0L, NULL, 0L, NULL );
    // gtk_label_set(GTK_LABEL(Tran.ten_entrye), buf);
  }

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// [人数]のマークを画面下部に表示する.  [人数   X] という表示となる. 人数はイメージ
  /// 引数: NULL=登録画面  NULL以外=小計画面(1人制タワーの卓上側を含む)
  /// 関連tprxソース: rc28itmdsp.c - rcPersonMark_28Lcd
  static void rcPersonMark28Lcd(SubttlInfo pSubttl) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// 顧客マークを表示する
  /// 関連tprxソース: rc28itmdsp.c - rcDspMbrmk_28LCD
  static void rcDspMbrmk28Lcd() {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// 関連tprxソース: rc28itmdsp.c - rc_ReservInfoDspClr
  static void rcReservInfoDspClr(SubttlInfo pSubttl) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// 関連tprxソース: rc28itmdsp.c - rcCardForgot_28ItmLCD
  static void rcCardForgot28ItmLcd() {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// LCD Member Name & Point Set and Display Process
  /// 関連tprxソース: rc28itmdsp.c - rcmbrDsp28LCD
  static void rcmbrDsp28Lcd() {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// LCD Mark Buffer Set and Display Process
  /// 関連tprxソース: rc28itmdsp.c - rcDspClrmk_28LCD
  static void rcDspClrmk28Lcd() {}

  // TODO: 鈴木 定義のみ追加
  ///関連tprxソース: rc28itmdsp.c - rcDspManualMMCnt_28LCD
  static void rcDspManualMMCnt28LCD(int dspFlg) {
    return;
  }
}
