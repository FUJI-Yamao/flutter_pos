/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// フッターが表示されるフルセルフ画面の種類
enum DisplayingFooterFullSelfKind {
  start,          // スタート画面
  register,       // 登録画面
  preset,         // プリセット画面
  selectPayment,  // 支払い方法選択画面
  amount,         // 個数入力画面
  semiSelf;      //セミセルフの場合
}