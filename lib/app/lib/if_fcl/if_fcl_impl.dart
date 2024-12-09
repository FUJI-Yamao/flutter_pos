/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class IfFclImpl {
  ///  QP日計コマンドを送信する
  ///  関連tprxソース: src\lib\if_fcl\if_fcl.c - if_fcl_qp_day_ttl
  static int ifFclQpDayTtl (int src) {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return 0;
  }

  ///  QP日計状況確認コマンドを送信する
  ///  関連tprxソース: src\lib\if_fcl\if_fcl.c - if_fcl_qp_day_ttl_chk
  static int ifFclQpDayTtlChk (int src) {
    // TODO:10121 QUICPay、iD 202404実装対象外
    return 0;
  }
}