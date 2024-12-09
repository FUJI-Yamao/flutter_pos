/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース: rc_repica.h - 構造体REPICA
class Repica{
  // int	biz_type;
  int fncCode = 0;
  // long	zan_before;
  // long	lack_card_balance;
  // char	before_void_cnt;
  // short	tc_step;
  // char	old_card_num[sizeof(((repica_mcd_fmt *)NULL)->preca_cd)];
  // long	old_card_pin;
  // long	input_value;
  // short   scan_flg;               /* レピカバーコードスキャンチェック用フラグ TRUE:レピカバーコードをスキャンした、FALSE:レピカバーコード以外のスキャン */
  // short	err_bkup;		/* エラー番号のバックアップ */
  // long	combi_chg_amt;		/* 品券・会計併用時のお釣り額 */
  // RXMEM_REPICA_CARD work_card;	/* カード情報一時格納 */
  // long	pnt_before;		/* 取引前ポイント残高 */
  // long	lack_point_balance;	/* ポイント */
  // char	card_auth_info[16+1];	/* PIN番号/ワンタイムトークン */
}

class RcRepica {
  static Repica repica = Repica();

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_repica.c - rcKy_Repica_Deposit()
  static void rcKyRepicaDeposit () {
    return ;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rc_repica.c - rcCheck_Repica_Deposit_Item
  static int rcCheckRepicaDepositItem(int flg) {
    return 0;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rc_repica.c - rcKy_Repica_In
  static void rcKyRepicaIn(){
    return;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rc_repica.c - rcKy_Repica_Point_Sales(short biztype)
  static int rcKyRepicaPointSales(int bizTyp){
    return 0;
  }

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_repica.c - rc_RepicaPoint_StartCalc
  static void rcRepicaPointStartCalc(int bizType) {
    return;
  }

  // TODO: checker 関数実装のため、定義のみ追加
  /// 関連tprxソース: rc_repica.c - rcKy_Repica_Ref
  static void rcKyRepicaRef() {
    return;
  }


  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rc_repica.c - rcKy_Repica_Sales
  static int rcKyRepicaSales(int){
    return 0;
  }

}

/// 関連tprxソース: rc_repica.h - REPICA_BIZ_TYPE
enum REPICA_BIZ_TYPE{
  // 先頭メンバのREPICA_REFはREPICA_REF(REPICA_MAX_SUB + 1)なので、
  // REPICA_MAX_SUBの値を確認して数値を記入すること
  // ()の中に数式REPICA_MAX_SUB + 1が記入できなかったため
  REPICA_REF(16),
  REPICA_IN(17),
  //	REPICA_SALES,
  REPICA_DEPOSIT_CHANGE(18),
  REPICA_DEPOSIT_ITEM(19),
  //	REPICA_SALES_VOID,
  REPICA_DEPOSIT_CHANGE_VOID(20),
  REPICA_DEPOSIT_ITEM_VOID(21),
  //	REPICA_BEFORE_VOID,
  REPICA_ACTIVATE(22),
  REPICA_SALES_SPLIT(23),	/* スプリット支払登録 */
  REPICA_IN_REF(24),		/* レピカ宣言時の残高照会 */
  REPICA_POINT_ADD1(25),		/* ポイント加算1 */
  REPICA_POINT_ADD1_VOID(26),		/* ポイント加算1取消 */
  REPICA_POINT_ADD2(27),		/* ポイント加算2 */
  REPICA_POINT_ADD2_MINUS(28),	/* ポイント加算2(マイナス) */
  REPICA_POINT_SUBT(29),		/* ポイント減算 */
  REPICA_POINT_SUBT_VOID(30),		/* ポイント減算取消 */
  REPICA_POINT_SALES_SPLIT(31);	/* スプリット支払登録(ポイント支払) */

  final int repicaBizTypeCd;
  const REPICA_BIZ_TYPE(this.repicaBizTypeCd);

  static REPICA_BIZ_TYPE getDefine(int cd) {
    REPICA_BIZ_TYPE def = REPICA_BIZ_TYPE.values.firstWhere((element) {
      return element.repicaBizTypeCd == cd;
    }, orElse: () => REPICA_BIZ_TYPE.REPICA_REF);
    return def;
  }
}

/// 関連tprxソース: rc_repica.h - REPICA_SUB
enum REPICA_SUB{
  REPICA_NOT_SUB(0),
  REPICA_BALANCE(1),
  REPICA_CHARGE(2),
  REPICA_CHARGE_VOID(3),
  REPICA_SALES(4),
  REPICA_SALES_VOID(5),
  REPICA_TRANSFER_CARD(6),
  REPICA_TRANSACTION_QUERY(7),
  REPICA_BEFORE_VOID(8),
  REPICA_CONFIRM_REQUEST(9),
  REPICA_POINT_CALC(10),		/* ポイント加算1 */
  REPICA_POINT_CALC_VOID(11),		/* ポイント加算1取消 */
  REPICA_POINT_ADD(12),		/* ポイント加算2 */
  REPICA_POINT_SUB(13),		/* ポイント減算 */
  REPICA_POINT_SUB_VOID(14),		/* ポイント減算取消 */
  REPICA_MAX_SUB(15);

  final int repicaSubCd;
  const REPICA_SUB(this.repicaSubCd);

  static REPICA_SUB getDefine(int cd) {
    REPICA_SUB def = REPICA_SUB.values.firstWhere((element) {
      return element.repicaSubCd == cd;
    }, orElse: () => REPICA_SUB.REPICA_NOT_SUB);
    return def;
  }
}