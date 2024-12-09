/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class RcMbrZHQFlrd{
  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rcmbr_ZHQflrd.c - rcmbr_ZHQ_UpdatePoints()
  static int rcmbrZHQUpdatePoints(){
    return 0;
  }

  /// TODO:00002 佐野 - 顧客呼出のため、先行して構築
  /// TSに顧客のロック解除指示を行う
  /// 引数: マシン番号
  /// 関連tprxソース: rcmbr_ZHQflrd.c - rcmbr_ZHQ_Cust_UnLock
  static void rcmbrZHQCustUnlock(int macNo) {
  }
}
