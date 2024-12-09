/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_HI_MBR_REC
// TODO:00014 日向 checker関数実装のため、定義のみ追加
class RXMEMCUSTREAL2_HI_MBR_REC {
  int			syori_sts = 0;		// 処理ｽﾃｰﾀｽ
  String	kaiin_sts = '';		// 会員ｽﾃｰﾀｽ
  String	kaiin_category = '';		// 会員分類ｺｰﾄﾞ
  String	kaiin_club = '';		// 倶楽部会員ﾌﾗｸﾞ
  String	kaiin_name = '';		// 会員名
  int			zndk = 0;			// P残高
  String	pt_yuko_kigen = '';	// P有効期限
  int			kikan_zndk = 0;		// 現在限定P残高
  String	uriage_no = '';		// 売上NO
  int			fuyo_pt = 0;		// 付与P数
  int			riyo_pt = 0;		// 利用P数
  int			kikan_riyo_pt = 0;		// 限定利用P数
  int			cancel_pt = 0;		// ｷｬﾝｾﾙP数
  int			cancel_kikan_pt = 0;	// ｷｬﾝｾﾙ限定P数
  int			fusoku_pt = 0;		// 不足P数
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_DATA
class RxMemCustReal2Data {
  RXMEMCUSTREAL2_WEBSER webser = RXMEMCUSTREAL2_WEBSER();
  RXMEMCUSTREAL2_UID uid = RXMEMCUSTREAL2_UID();
  RXMEMCUSTREAL2_OP op = RXMEMCUSTREAL2_OP();
  RXMEMCUSTREAL2_PARTIST partist = RXMEMCUSTREAL2_PARTIST();
  RXMEMCUSTREAL2_TPOINT tpoint = RXMEMCUSTREAL2_TPOINT();
  RXMEMCUSTREAL2_PTACTIX ptactix = RXMEMCUSTREAL2_PTACTIX();
  RXMEMCUSTREAL2_HI_MBR himbr = RXMEMCUSTREAL2_HI_MBR();
  RXMEMCUSTREAL2_HI_SVC hisvc = RXMEMCUSTREAL2_HI_SVC();
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_WEBSER_REQ
class RXMEMCUSTREAL2_WEBSER_REQ {
  List<int> card_no = [];
  int price = 0;
  List<int> hist_no = [];
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_WEBSER_REC
class RXMEMCUSTREAL2_WEBSER_REC {
  List<String> err_cd = [];
  String err_msg = '';
  String cust_name = '';
  int ttl_point = 0;
  int add_point = 0;
  List<String> hist_no = [];
  int exp_point = 0;  /* 失効ポイント*/
  List<String> exp_date = [];  /* 失効予定日 */
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_WEBSER
class RXMEMCUSTREAL2_WEBSER {
  RXMEMCUSTREAL2_WEBSER_REQ req = RXMEMCUSTREAL2_WEBSER_REQ();
  RXMEMCUSTREAL2_WEBSER_REC rec = RXMEMCUSTREAL2_WEBSER_REC();
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_UID_REQ
class RXMEMCUSTREAL2_UID_REQ {
  int card_no = 0;
  int add_point = 0;
  int use_point = 0;
  int price = 0;
  int staff_cd = 0;
  int receipt_no = 0;
  int sale_date = 0;
  int ope_mode = 0;
  String ope_kind = '';
  int plu_point = 0;
  int stamp_point1 = 0;
  int stamp_point2 = 0;
  int stamp_point3 = 0;
  int stamp_point4 = 0;
  int stamp_point5 = 0;
  int card_stop_flg = 0;
  int card_kind = 0;
  int mag_ttl_point = 0;
  int seq_no = 0;
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_UID_REC
class RXMEMCUSTREAL2_UID_REC {
  int err_cd = 0;
  String err_msg = '';
  int card_stop_flg = 0;
  int card_stat_flg = 0;
  int card_dupli_flg = 0;
  int ttl_point = 0;
  int mly_price = 0;
  int mly_count = 0;
  int dly_price = 0;
  int dly_count_flg = 0;
  String now_rank_name = '';
  String next_rank_name = '';
  int next_rank_price = 0;
  int next_rank_count = 0;
  int next_rank_flg = 0;
  int sum_point = 0;
  List<String> parent_card_no = [];
  int seq_no = 0;
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_UID
class RXMEMCUSTREAL2_UID {
  RXMEMCUSTREAL2_UID_REQ req = RXMEMCUSTREAL2_UID_REQ();
  RXMEMCUSTREAL2_UID_REC rec = RXMEMCUSTREAL2_UID_REC();
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_OP_REQ
class RXMEMCUSTREAL2_OP_REQ {
  int ope_mode = 0;
  int tran_type = 0;
  int stre_cd = 0;
  int mac_no = 0;
  int slip_no = 0;
  int point_price = 0;
  int add_point = 0;
  int use_point = 0;
  int staff_cd = 0;
  int card_flg = 0;
  List<int> card_data = [];
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_OP_REC
class RXMEMCUSTREAL2_OP_REC {
  int err_cd = 0;
  String err_msg = '';
  int ttl_point = 0;
  int bef_yr_point = 0;
  String add_limit = '';
  String use_limit = '';
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_OP
class RXMEMCUSTREAL2_OP {
  RXMEMCUSTREAL2_OP_REQ req = RXMEMCUSTREAL2_OP_REQ();
  RXMEMCUSTREAL2_OP_REC rec = RXMEMCUSTREAL2_OP_REC();
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_PARTIST_REQ
class RXMEMCUSTREAL2_PARTIST_REQ {
  List<int> cardNo = [];  /* ｶｰﾄﾞ番号 */
  List<int> haseiDay = [];  /* 取引日付 */
  List<int> haseiTime = [];  /* 取引日時 */
  int tenpoCode = 0;  /* 店舗ｺｰﾄﾞ */
  int termNo = 0;  /* 端末番号 */
  int seqNo = 0;  /* 取引通番 */
  int jiyuCode = 0;  /* 事由ｺｰﾄﾞ */
  int amountIncTax = 0;  /* 税込金額 */
  int amountExcTax = 0;  /* 税抜金額 */
  int amountTax = 0;  /* 税額 */
  int totalPoint = 0;  /* ﾎﾟｲﾝﾄ数 */
  int usePoint = 0;  /* 利用ﾎﾟｲﾝﾄ数 */
  int TotalPointKin = 0;  /* ﾎﾟｲﾝﾄ対象金額 */
  int UriageTensuu = 0;  /* 買上点数 */
  int KaiagePointSyukei = 0;  /* 買上ﾎﾟｲﾝﾄ */
  int ECouponPoint = 0;  /* 電子ｸｰﾎﾟﾝﾎﾟｲﾝﾄ */
  int BirthdayPoint = 0;  /* ﾊﾞｰｽﾃﾞｰﾎﾟｲﾝﾄ */
  int Eco1Point = 0;  /* ｴｺﾛｼﾞｰ1ﾎﾟｲﾝﾄ */
  int Eco2Point = 0;  /* ｴｺﾛｼﾞｰ2ﾎﾟｲﾝﾄ */
  int Eco3Point = 0;  /* ｴｺﾛｼﾞｰ3ﾎﾟｲﾝﾄ */
  int Eco4Point = 0;  /* ｴｺﾛｼﾞｰ4ﾎﾟｲﾝﾄ */
  int Eco5Point = 0;  /* ｴｺﾛｼﾞｰ5ﾎﾟｲﾝﾄ */
  int cardExcFlag = 0;  /* 排他ﾌﾗｸﾞ */
  int ticketIssue = 0;  /* 割引券発行枚数 */
  int ticketIssuePoint = 0;  /* 割引券発行ポイント */
  int fuyoPoint = 0;  /* 本部付与ポイント */
  int inTaxAmt = 0;  /* 内税金額 */
  int outTaxAmt = 0;  /* 外税金額 */
  int cshrNo = 0;  /* レジ操作責任者 */
  String saleDate = '';  /* 営業日       */
  int lastTotalPoint = 0;  /* 前回累計ポイント */
  int TotalPoint = 0;  /* 累計ポイント */
  int Eco1PointCnt = 0;  /* ｴｺﾛｼﾞｰ1枚数 */
  int Eco2PointCnt = 0;  /* ｴｺﾛｼﾞｰ2枚数 */
  int Eco3PointCnt = 0;  /* ｴｺﾛｼﾞｰ3枚数 */
  int Eco4PointCnt = 0;  /* ｴｺﾛｼﾞｰ4枚数 */
  int Eco5PointCnt = 0;  /* ｴｺﾛｼﾞｰ5枚数 */
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_PARTIST_REC
class RXMEMCUSTREAL2_PARTIST_REC {
  int statusCode = 0;  /* 処理ｽﾃｰﾀｽ */
  int cardStatusCode = 0;  /* 会員状態ｺｰﾄﾞ */
  int cardEnableFlag = 0;  /* ｶｰﾄﾞ可否ﾌﾗｸﾞ */
  int ruikeiPoint = 0;  /* 累計ﾎﾟｲﾝﾄ */
  String lastCardUseTime = '';  /* 最終購入日 */
  List<String> BirthDay = [];  /* 誕生日 */
  String MemberName = '';  /* 顧客名称 */
  int ThisRank = 0;  /* 今回ｻｲｸﾙ優待ﾚﾍﾞﾙ(1-5) */
  int ThisMonthTotalAmount = 0;  /* 今回ｻｲｸﾙ累計購入金額(当月) */
  int LastRank = 0;  /* 前回ｻｲｸﾙ優待ﾚﾍﾞﾙ(1-5) */
  int LastMonthTotalAmount = 0;  /* 前回ｻｲｸﾙ累計購入金額(前月) */
  int fuyoPoint = 0;  /* 本部付与ポイント */
  int exp_point = 0;  /* 失効ポイント */
  List<int> exp_date = [];  /* ポイント失効日 */
  int BirthSts = 0;  /* 誕生日ポイントステータス */
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_PARTIST_PROM
class RXMEMCUSTREAL2_PARTIST_PROM {
  int BirthdayRecptNo = 0;	/* 誕生日ﾚｼｰﾄNO */
  int RankHnskRecptNo = 0;	/* 販促ﾚｼｰﾄNO */
  int KbtHnskRcptNo1Hakko = 0;	/* 個別販促ﾚｼｰﾄ1NO */
  int KbtHnskRcptNo2Hakko = 0;	/* 個別販促ﾚｼｰﾄ2NO */
  int KbtHnskRcptNo3Hakko = 0;	/* 個別販促ﾚｼｰﾄ3NO */
  int KbtHnskRcptNo4Hakko = 0;	/* 個別販促ﾚｼｰﾄ4NO */
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_PARTIST
class RXMEMCUSTREAL2_PARTIST {
  RXMEMCUSTREAL2_PARTIST_REQ req = RXMEMCUSTREAL2_PARTIST_REQ();
  RXMEMCUSTREAL2_PARTIST_REC rec = RXMEMCUSTREAL2_PARTIST_REC();
  RXMEMCUSTREAL2_PARTIST_PROM prom = RXMEMCUSTREAL2_PARTIST_PROM();
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_TPOINT_REQ
class RXMEMCUSTREAL2_TPOINT_REQ {
  List<int> kaiin_id = []; // 会員ID
  int kaiin_no_yomitori_kbn = 0; // 会員番号読取区分
  int coupon_info = 0; // クーポン情報検索
  int royalty_info = 0; // グレード情報検索
  List<int> serial_no = []; // シリアル番号
  int register_no = 0; // レジNo
  int denpyo_no = 0; // 伝票No
  int retry_kbn = 0; // リトライ区分
  int point_kbn = 0; // ポイント操作区分
  List<int> moto_date = []; // 元取引使用年月日
  List<int> moto_serial_no = []; // 元取引シリアル番号
  int kangen_point = 0; // 還元ポイント数
  int uriage_kin = 0; // 売上金額
  List<int> shori_date = []; // 使用年月日
  List<int> shori_time = []; // 使用時刻
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_TPOINT_REC
class RXMEMCUSTREAL2_TPOINT_REC {
  int return_cd = 0; // ﾘﾀｰﾝｺｰﾄﾞ
  int point = 0; // 利用可能ﾎﾟｲﾝﾄ数
  int coupon_count = 0; // クーポン数

  int c1_couponno = 0; // (1)クーポン番号
  String c1_ankenno = ''; // (1)プロモーション番号
  String c1_jancd = ''; // (1)JANコード
  String c1_kanrino = ''; // (1)管理番号
  int c1_keihyou = 0; // (1)景表法金額
  String c1_note1 = ''; // (1)注意事項1(会員番号印字フラグ)
  String c1_note2 = ''; // (1)注意事項2(発券店舗名印字フラグ)

  int c2_couponno = 0; // (2)クーポン番号
  String c2_ankenno = ''; // (2)プロモーション番号
  String c2_jancd = ''; // (2)JANコード
  String c2_kanrino = ''; // (2)管理番号
  int c2_keihyou = 0; // (2)景表法金額
  String c2_note1 = ''; // (2)注意事項1(会員番号印字フラグ)
  String c2_note2 = ''; // (2)注意事項2(発券店舗名印字フラグ)

  int c3_couponno = 0; // (3)クーポン番号
  String c3_ankenno = ''; // (3)プロモーション番号
  String c3_jancd = ''; // (3)JANコード
  String c3_kanrino = ''; // (3)管理番号
  int c3_keihyou = 0; // (3)景表法金額
  String c3_note1 = ''; // (3)注意事項1(会員番号印字フラグ)
  String c3_note2 = ''; // (3)注意事項2(発券店舗名印字フラグ)
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_TPOINT
class RXMEMCUSTREAL2_TPOINT {
  RXMEMCUSTREAL2_TPOINT_REQ req = RXMEMCUSTREAL2_TPOINT_REQ();
  RXMEMCUSTREAL2_TPOINT_REC rec = RXMEMCUSTREAL2_TPOINT_REC();
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_PTACTIX_REQ
class RXMEMCUSTREAL2_PTACTIX_REQ {
  String StoreCode = ''; // 店舗コード
  String TerminalID = ''; // 端末コード
  String ComSerial = ''; // 通信通番
  String MemberNo = ''; // 会員番号
  String TranSerial = ''; // 取引通番
  String TranTime = ''; // 現地取引日時
  String OrgTranSerial = ''; // 元取引通番
  String OrgTranDate = ''; // 元取引日付
  int Amount = 0; // 利用金額
  int Points = 0; // ポイント数
  String Ex1 = ''; // 予備1
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_PTACTIX_REC
class RXMEMCUSTREAL2_PTACTIX_REC {
  String ResultCode = ''; // 結果コード
  int Points = 0; // ポイント
  int PointsBefTran = 0; // 取引前ポイント残高
  int PointsAftTran = 0; // ポイント残高計
  String Ex1 = ''; // 予備1
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_PTACTIX
class RXMEMCUSTREAL2_PTACTIX {
  RXMEMCUSTREAL2_PTACTIX_REQ req = RXMEMCUSTREAL2_PTACTIX_REQ();
  RXMEMCUSTREAL2_PTACTIX_REC rec = RXMEMCUSTREAL2_PTACTIX_REC();
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_HI_MBR_REQ
class RXMEMCUSTREAL2_HI_MBR_REQ {
  int kaiin_no = 0; // 会員NO
  int term_no = 0; // 取引端末
  int denpyo_no = 0; // 取引番号
  int torihiki_bi = 0; // 取引日付(YYYYMMDD)
  int torihiki_time = 0; // 取引時刻(HHMMSS)
  int fuyo_pt = 0; // 付与P数
  int riyo_pt = 0; // 利用P数
  int uriage_no = 0; // 売上NO
  int kaiin_category = 0; // 会員分類ｺｰﾄﾞ
  int moto_kaiin_no = 0; // 統合元会員NO
  int saki_kaiin_no = 0; // 統合先会員NO
  int tougou_riyu = 0; // 統合理由
  int tel_no = 0; // 電話番号
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_HI_MBR
class RXMEMCUSTREAL2_HI_MBR {
  RXMEMCUSTREAL2_HI_MBR_REQ req = RXMEMCUSTREAL2_HI_MBR_REQ();
  RXMEMCUSTREAL2_HI_MBR_REC rec = RXMEMCUSTREAL2_HI_MBR_REC();
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_HI_SVC_REQ
class RXMEMCUSTREAL2_HI_SVC_REQ {
  String searchno = ''; // 検索用番号
  String knrno = ''; // 管理番号
  String jancd = ''; // JANｺｰﾄﾞ
  String kaiincd = ''; // 会員番号
  int cpncd = 0; // 企画ｺｰﾄﾞ
  int hkksu = 0; // 発行・使用回数
  int tencd = 0; // 店舗ｺｰﾄﾞ
  int rejino = 0; // ﾚｼﾞ番号
  int jobdt = 0; // 業務日付
  String denno = ''; // 伝票番号
  int total = 0; // 合計金額（券面金額）
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_HI_SVC_REC
class RXMEMCUSTREAL2_HI_SVC_REC {
  int syori_sts = 0; // 処理ｽﾃｰﾀｽ
  String jancd = ''; // JANｺｰﾄﾞ
  String hinak = ''; // 品名(ｶﾅ)
  String kikak = ''; // 規格(ｶﾅ)
  String hinkj = ''; // 品名(漢字)
  String kikkj = ''; // 規格(漢字)
  int bmncd = 0; // 部門ｺｰﾄﾞ
  int daicd = 0; // 大分類ｺｰﾄﾞ
  int chucd = 0; // 中分類ｺｰﾄﾞ
  int shocd = 0; // 小分類ｺｰﾄﾞ
  int bkazei = 0; // 売価課税区分
  int zerit = 0; // 消費税率
  int baika = 0; // 売単価
  int cpncd = 0; // 企画ｺｰﾄﾞ
  int jotaikbn = 0; // 状態区分
  int riyoukbn = 0; // 利用区分
  int cpnsbt = 0; // 企画種別
  int cpnkin = 0; // 券面金額
}

/// 関連tprxソース:C: rxmemcustreal2.h - RXMEMCUSTREAL2_HI_SVC
class RXMEMCUSTREAL2_HI_SVC {
  RXMEMCUSTREAL2_HI_SVC_REQ req = RXMEMCUSTREAL2_HI_SVC_REQ();
  RXMEMCUSTREAL2_HI_SVC_REC rec = RXMEMCUSTREAL2_HI_SVC_REC();
}