/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///  関連tprxソース: rcsg_dev.c
class RcsgDev {
  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcsg_dev.c - rcSGSnd_GtkTimerRemove
  static int rcSGSndGtkTimerRemove() {
    return 0;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rcsg_dev.c - rcSGSnd_GtkTimerAdd
  static int rcSGSndGtkTimerAdd(int timer, Function func) {
    return 0;
  }

  /// 関連tprxソース:rcsg_dev.c - rcSG_SignP_SignOn
  static void rcSGSignPSignOn(int color) {
    rcSGSignPSignOnFlg(color, 0);
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// 関連tprxソース:rcsg_dev.c - rcSG_SignP_SignOn_flg
  static void rcSGSignPSignOnFlg(int color, int type) {}
}