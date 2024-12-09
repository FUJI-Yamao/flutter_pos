/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


/// 関連tprxソース: 関連tprxソース: rxmemqcConnect.h

class ConstQxConnect {
  static const QCCONNECT_MAX = 4;
}

class RxMemQcConnectData {
  int qcIdx = 0;
  String  qcStatus = "";	// QCashierレジの状態: QCSTATUS_TYPEをセット
  int  intrpMode = 0;	// 中断モード: QC_INTERRUPT_PROCCESS_MODEをセット
  String  cautionStatus = "";	// プリンター, 釣銭釣札機の警告状態: QC_CAUTION_STATUSをセット
  int  custWait = 0;	// QC指定による待ち客数
  int  opeMode = 0;	// 登録画面でのmac_info.ini(mode)
  int  macNo = 0;		// マシン番号
  int  recNo = 0;		// レシート番号
  String ipAddr = "";	// IPアドレス
  int  autocall_receipt_no = 0;	// 連続取引のレシート番号
  int  autocall_mac_no = 0;	// 連続取引のマシン番号
  int  acbdata = 0;		// 釣機状態（入金など）
  int  e_money_data = 0;		// 決済端末の状態（カードタッチ待ちなど）
}
