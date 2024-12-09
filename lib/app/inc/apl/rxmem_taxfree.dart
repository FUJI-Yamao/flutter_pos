/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///  関連tprxソース:rxmemtaxfree.h - 免税用メモリ
enum TaxfreeOrder {
  TAXFREE_NOT_ORDER(0),		//待機
  TAXFREE_ORDER_END(1),		//正常終了
  TAXFREE_ORDER_ERR_END(2),		//異常終了
  TAXFREE_ORDER_PING(3),		//疎通確認
  TAXFREE_ORDER_LICENCE_GET(4),	//通信認証
  TAXFREE_ORDER_MASTER_GET(5),	//マスターデータ取得
  TAXFREE_ORDER_CHECK_SALES(6),	//売上データ登録確認
  TAXFREE_ORDER_ADD_SALES(7),	//売上データ登録
  TAXFREE_ORDER_ADD_SUM__SALES(8),	//売上データ合算
  TAXFREE_ORDER_CNCL_SALES(9),	//売上データ取消
  TAXFREE_ORDER_GET_SALES(10),	//売上データ参照
  TAXFREE_ORDER_SEND(11),		//未送信ファイル送信
  TAXFREE_ORDER_CNTGET(12),		//未送信異常ファイル件数更新
  TAXFREE_ORDER_MODECHG(13),		//接続先変更（訓練モード)
  TAXFREE_ORDER_MAX(14);

  final int id;
  const TaxfreeOrder(this.id);
}

class RxMemTaxfree {
  //  タスク状態(stat)
  static final int TAXFREE_TASK_LICENCE_REQ = 0x01;	//認証要求
  static final int TAXFREE_TASK_OK = 0x02;
  static final int TAXFREE_TASK_SEND = 0x04;	//自動送信中
  static final int TAXFREE_TASK_SEND_STOP = 0x08;	//自動送信停止
  static final int TAXFREE_TASK_LICE_BUSI_OK = 0x10;	//商用認証済み
  static final int TAXFREE_TASK_LICE_DEMO_OK = 0x20;	//デモ認証済み
}