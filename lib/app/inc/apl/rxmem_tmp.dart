/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'rx_cnt_list.dart';
import 'rxmem_ajsemoney.dart';
import 'rxmem_assort.dart';
import 'rxmem_bdl.dart';
import 'rxmem_clsdsc.dart';
import 'rxmem_dpoint.dart';
import 'rxmem_void.dart';
import 'rxmemayaha.dart';
import 'rxmemcard.dart';
import 'rxmemcogca.dart';
import 'rxmemvaluecard.dart';

class RxMemTmp {
  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース:rxmemtmp.h - RXMEMTMP構造体
  RxMemCard	rcarddata = RxMemCard();
  RxMemRepica repica = RxMemRepica();
  List<RxMemAssort> assort = List.generate(CntList.itemMax, (_) => RxMemAssort());
  int chkrNo = 0;
  String chkrName = '';
  int opeModeFlgBak = 0;
  int reservMode = 0;
  int reservTyp = 0;
  int workInType = 0;
  int nimocaPointOut = 0;
  int prombmpNonfile = 0;
  int multiTimeout = 0;
  int notepluTtlamt = 0;
  int notepluTtlqty = 0;
  int manualMixcd = 0;
  List<int?> manualmixqty = List.filled(5+1, 0);	//条件１～５＋平均単価
  int rcptvoidFlg = 0;		/* 通番訂正フラグ */
  //#if CATALINA_SYSTEM
  int	catalinaStartflg = 0;
  int	catalinaSendcnt = 0;
  int	catalinaSeqcnt = 0;
  int	catalinaTtlamt = 0;
  int	catalinaTtlqty = 0;
  int	catalinaStore = 0;
  int	catalinaManufact = 0;
  int	catalinaStoreqty = 0;
  int	catalinaManufactqty = 0;
  //#endif
  int beniyaTtlamt = 0;
  int reservTaxChgFlg = 0;
  int reservItmlogCnt = 0;
  String reservMember = '';
  int reservCashTyp = 0;
  RxMemDPointData dPointData = RxMemDPointData();
  int	autoCallReceiptNo = 0;
  int	autoCallMacNo = 0;
  RxMemAjsEmoneyCard ajsEmoneyCard = RxMemAjsEmoneyCard();
  RxMemAjsEmoneyRx ajsEmoneyRxData = RxMemAjsEmoneyRx();
  RxMemAyaha ayaha = RxMemAyaha();
  List<RxMemVoid> voidbp = List.generate(CntList.itemMax, (_) => RxMemVoid());
  List<RxMemClsDsc> rcClspdsc = List.generate(CntList.itemMax, (_) => RxMemClsDsc());
  int	ajsEMoneyAutoCallFlg = 0;	/* AJSマネー 通常レジの先入金取引の状態をチェックするフラグ */
  RxMemCogcaCard cogcaCard = RxMemCogcaCard();
  RxMemCogcaBfrBal cogcaBrfBal = RxMemCogcaBfrBal();
  RxMemValueCard valueCard = RxMemValueCard();

  int cpnPrnQty = 0;		// クーポン発行枚数
  int lotPrnQty = 0;		// 抽選券発行枚数
  int wizNonfilePlu = 0;
  int selpluadjFlg = 0;
  List<RxMemBdl>	bdlLimit = List.generate(CntList.itemMax, (_) => RxMemBdl());
}

class RepicaPntErr {
  String cardType = ""; // カード種別
  int repicaErrFlg = 0; // ポイント加算1エラーフラグ
  int repicaErrFlg2 = 0; // ポイント減算エラーフラグ
  int repicaTargetPrice = 0; // ポイント対象額
  int pointSub = 0; // ポイント処理
  int repicaPntInquFlag = 0; // 通信済みフラグ
}
const int nameSize = 128+1;

class PassportData {
  int	inpFlg = 0;	/* 0x01:記録票　0x02:誓約書 */
  List<String> typeJp = List.filled(nameSize, "");
  List<String> typeEx = List.filled(nameSize, "");
  List<String> number = List.filled(20+1, "");
  List<String> name =  List.filled(39+1, "");
  List<String> birthday = List.filled(8+1, "");
  List<String> country = List.filled(10+1, "");
  List<String> residenJp = List.filled(nameSize, "");
  List<String> residenEx = List.filled(nameSize, "");
  List<String> land = List.filled(8+1, "");
  List<String> purchaseDay = List.filled(8+1, "");
  List<String> addName = List.filled(5+1, "");
  List<String> sex = List.filled(1+1, "");
  List<String> purchaseTime = List.filled(30, "");
}

/// 関連tprxソース: rxmemrepica.h - RXMEM_REPICA
class RxMemRepica {
  RxMemRepicaCard card = RxMemRepicaCard();
  // RXMEM_REPICA_TX tx_data;
  RxMemRepicaRx rxData = RxMemRepicaRx();
  // int order;
  // int sub;
  // int stat;
  // int ss_crdtlog_cnt;	// 複数枚対応でQC指定時のクレジットログカウント退避
}

/// 関連tprxソース: rxmemrepica.h - RXMEM_REPICA_CARD
class RxMemRepicaCard {
  int typ = 0;  /* card type  0:non 1:Repica Prepaid Card */
  int dev = 0;  /* カード情報を読込んだデバイス種別(D_OBR or D_MCD2)*/
  String jis2 = "";  /* Additional data */
  String precaCd = "";  /* scan card check code */
  List<String> barcode = List.filled(2, "");
  String stdCode = "";  // レピカ（アララ）標準 Code128 or QR
}


/// 関連tprxソース: rxmemrepica.h - RXMEM_REPICA_RX
class RxMemRepicaRx {
// // 共通要求属性
// char	message_version[2+1];
// char	request_type[80+1];
// char	request_id[20+1];
// char	client_signature[80+1];
// char	transaction_type[1+1];
// char	retry_count[1+1];
// char	terminal_ymd[8+1];
// char	terminal_hms[6+1];
//
// // 共通応答属性
// char	auth_ymd[8+1];
// char	auth_hms[6+1];
// char	message_log_id[10+1];
// char	error_code[3+1];
// char	message1[23*4+1];
// char	message2[23*4+1];
//
// // カード取引要求属性
// char	request_id_cancel[20+1];
// char	input_value[8+1];
// char	input_point[8+1];
// char	pos_receipt_code[20+1];
// char	member_code[16+1];
// char	card_auth_type[1+1];
// char	card_auth_info[1024+1];
// char	is_default_service[1+1];
// char	default_service[1+1];
// char	sales_to_calculate[8+1];
// char	sales_amount[8+1];
// char	request_id_reserve[20+1];
//
// // カード取引応答属性
// char	auth_no[8+1];
// char	expire_date[8+1];
// char	card_name[32*4+1];
// char	old_value[8+1];
// char	value_premium[8+1];
// char	discount[8+1];
// char	value[8+1];
// char	new_value[8+1];
// char	value_max[8+1];
// char	value_min_charge[8+1];
// char	value_unit_charge[8+1];
// char	old_point[8+1];
// char	converted_value[8+1];
// char	new_point[8+1];
// char	point_premium[8+1];
// char	point_max[8+1];
// char	activate_flag[1+1];
String cardType = '';
// char	old_charge_value_balance[8+1];
// char	old_premium_value_balance[8+1];
// char	old_present_value_balance[8+1];
// char	charge_premium_value[8+1];
// char	present_premium_value[8+1];
// char	charge_value[8+1];
// char	new_charge_value_balance[8+1];
// char	new_premium_value_balance[8+1];
// char	new_present_value_balance[8+1];
// char	old_premium_point_balance[8+1];
// char	old_payment_point_balance[8+1];
// char	old_present_point_balance[8+1];
// char	premium_point[8+1];
// char	payment_point[8+1];
// char	present_point[8+1];
// char	new_premium_point_balance[8+1];
// char	new_payment_point_balance[8+1];
// char	new_present_point_balance[8+1];
//
// // 取引結果取得応答属性
// //	char	input_value;
// //	char	input_point;
// //	char	member_code[16+1];
// //	char	sales_to_calculate;
//
// // カード付替応答属性
// char	orig_card_number[16+1];
// char	expire_ymd[8+1];
// char	orig_card_value_balance[8+1];
// char	orig_card_charge_value_balance[8+1];
// char	orig_card_premium_value_balance[8+1];
// char	orig_card_present_value_balance[8+1];
// char	orig_card_point_balance[8+1];
// char	orig_card_premium_point_balance[8+1];
// char	orig_card_payment_point_balance[8+1];
// char	orig_card_present_point_balance[8+1];
// char	orig_card_status[8+1];
// char	target_card_number[16+1];
// char	target_card_value_balance[8+1];
// char	target_card_charge_value_balance[8+1];
// char	target_card_premium_value_balance[8+1];
// char	target_card_present_value_balance[8+1];
// char	target_card_point_balance[8+1];
// char	target_card_premium_point_balance[8+1];
// char	target_card_payment_point_balance[8+1];
// char	target_card_present_point_balance[8+1];
// char	target_card_status[8+1];
//
// // 2フェーズコミット要否
// char	need_to_confirm[1+1];
//
// // アプリ用取引前残高
// long	value_before;
//
// short   orderResult;            /* 通信のオーダー結果を保存 */
//
// // レピカポイント残高
// long	point_before;
}