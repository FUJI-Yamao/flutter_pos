/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class RcEdy{

  static const KEY_EDY_FINAL = "確認終了";

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static void rcEdyKyFinal(){}

  // TODO:中身未実装
  // 関連tprxソース: rc_edy.c - rcEdy_Set_DateTimeTestFlag
  static int rcEdySetDateTimeTestFlag() {
    return 0;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:C:rc_edy.c -rcEdy_Ky_Cha()
  static int rcEdyKyCha(){
    return 0;
  }
}

