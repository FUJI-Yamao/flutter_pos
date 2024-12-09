/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class RcHcardDsp {
  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rchcard_dsp.c - rcYao_St_WorkTyp
  static int rcYaoStWorkTyp() {
    return 0;
  }

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rchcard_dsp.c - rcYao_Update_Start
  static void rcYaoUpdateStart(int rtryFlg, int funcCd) {
    return;
  }
}