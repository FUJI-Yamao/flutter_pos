/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース:dbNumberConfirm.h
class DbNumberConfirm {
  static const DBNUMBER_TXT_C_COMP_MST = "企業ﾏｽﾀ";

  /* 1 */
  static const DBNUMBER_TXT_C_STRE_MST = "店舗ﾏｽﾀ";
  static const DBNUMBER_TXT_C_REGCTRL_MST = "ﾚｼﾞｺﾝﾄﾛｰﾙﾏｽﾀ";
  static const DBNUMBER_TXT_MACADDR_MST = "機器ｱﾄﾞﾚｽﾏｽﾀ";
  static const DBNUMBER_TXT_REGOPT_MST = "ﾚｼﾞｵﾌﾟｼｮﾝﾏｽﾀ";
  static const DBNUMBER_TXT_C_GRP_MST = "分類ｸﾞﾙｰﾌﾟﾏｽﾀ";
  static const DBNUMBER_TXT_C_LRGCLS_MST = "大分類ﾏｽﾀ";
  static const DBNUMBER_TXT_C_STRELRG_MST = "店舗大分類ﾏｽﾀ";
  static const DBNUMBER_TXT_C_MDLCLS_MST = "中分類ﾏｽﾀ";
  static const DBNUMBER_TXT_C_STREMDL_MST = "店舗中分類ﾏｽﾀ";
  static const DBNUMBER_TXT_C_SMLCLS_MST = "小分類ﾏｽﾀ";
  static const DBNUMBER_TXT_C_STRESML_MST = "店舗小分類ﾏｽﾀ";

  /* 10 */
  static const DBNUMBER_TXT_C_TNYCLS_MST = "ｸﾗｽﾏｽﾀ";
  static const DBNUMBER_TXT_C_STRETNY_MST = "店舗ｸﾗｽﾏｽﾀ";
  static const DBNUMBER_TXT_C_PLU_MST = "PLUﾏｽﾀ";
  static const DBNUMBER_TXT_C_SCANPLU_MST = "ｽｷｬﾆﾝｸﾞPLUﾏｽﾀ";
  static const DBNUMBER_TXT_C_CASEITEM_MST = "ｹｰｽPLUﾏｽﾀ";
  static const DBNUMBER_TXT_C_BRGNSCH_MST = "特売ｽｹｼﾞｭｰﾙﾏｽﾀ";
  static const DBNUMBER_TXT_C_BRGNITEM_MST = "特売商品ﾏｽﾀ";
  static const DBNUMBER_TXT_C_BDLSCH_MST = "MM･BDLｽｹｼﾞｭｰﾙﾏｽﾀ";
  static const DBNUMBER_TXT_C_BDLITEM_MST = "MM･BDL商品ﾏｽﾀ";
  static const DBNUMBER_TXT_C_STMSCH_MST = "SMｽｹｼﾞｭｰﾙﾏｽﾀ";

  /* 20 */
  static const DBNUMBER_TXT_C_STMITEM_MST = "SM商品ﾏｽﾀ";
  static const DBNUMBER_TXT_C_CAT_DSC_MST = "ｶﾃｺﾞﾘｰ値引ﾏｽﾀ";
  static const DBNUMBER_TXT_C_TAX_MST = "税ﾃｰﾌﾞﾙﾏｽﾀ";
  static const DBNUMBER_TXT_C_STAFF_MST = "従業員ﾏｽﾀ";
  static const DBNUMBER_TXT_C_STAFFOPEN_MST = "従業員ｵｰﾌﾟﾝ情報ﾏｽﾀ";
  static const DBNUMBER_TXT_C_IMG_MST = "ｲﾒｰｼﾞﾏｽﾀ";
  static const DBNUMBER_TXT_C_KOPTTRAN_MST = "ｷｰｵﾌﾟｼｮﾝﾄﾗﾝｻﾞｸｼｮﾝﾏｽﾀ";
  static const DBNUMBER_TXT_C_KOPTINOUT_MST = "ｷｰｵﾌﾟｼｮﾝ入金支払ﾏｽﾀ";
  static const DBNUMBER_TXT_C_KOPTDISC_MST = "ｷｰｵﾌﾟｼｮﾝ値引割引ﾏｽﾀ";
  static const DBNUMBER_TXT_C_KOPTREF_MST = "ｷｰｵﾌﾟｼｮﾝ返品ﾏｽﾀ";

  /* 30 */
  static const DBNUMBER_TXT_C_KOPTOTH_MST = "ｷｰｵﾌﾟｼｮﾝその他ﾏｽﾀ";
  static const DBNUMBER_TXT_C_PRESET_MST = "ﾌﾟﾘｾｯﾄｷｰﾏｽﾀ";
  static const DBNUMBER_TXT_C_TRM_MST = "ﾀｰﾐﾅﾙﾏｽﾀ";
  static const DBNUMBER_TXT_C_INSTRE_MST = "ｲﾝｽﾄｱﾏｰｷﾝｸﾞﾏｽﾀ";
  static const DBNUMBER_TXT_C_CTRL_MST = "共通ｺﾝﾄﾛｰﾙﾏｽﾀ";
  static const DBNUMBER_TXT_C_PRCCHG_MST = "売価変更ﾏｽﾀ";
  static const DBNUMBER_TXT_C_OPENCLOSE_MST = "ﾚｼﾞ開閉店ﾏｽﾀ";
  static const DBNUMBER_TXT_C_TMP_MST = "仮登録ﾏｽﾀ";
  static const DBNUMBER_TXT_HISTLOG_MST = "履歴ﾛｸﾞﾏｽﾀ";
  static const DBNUMBER_TXT_HISTLOG_CNT = "履歴ﾛｸﾞｶｳﾝﾀ";

  /* 40 */
  static const DBNUMBER_TXT_C_BATREPO_MST = "予約ﾚﾎﾟｰﾄﾏｽﾀ";
  static const DBNUMBER_TXT_C_RECMSG_MST = "ﾚｼｰﾄﾒｯｾｰｼﾞﾏｽﾀ";
  static const DBNUMBER_TXT_REPORT_CNT = "ﾚﾎﾟｰﾄｶｳﾝﾀ";
  static const DBNUMBER_TXT_C_ITEMLOG = "ｱｲﾃﾑﾛｸﾞ";
  static const DBNUMBER_TXT_C_EJLOG = "電子ｼﾞｬｰﾅﾙﾛｸﾞ";
  static const DBNUMBER_TXT_C_BDLLOG = "M/M･BDLﾛｸﾞ";
  static const DBNUMBER_TXT_C_STMLOG = "ｾｯﾄﾏｯﾁﾛｸﾞ";
  static const DBNUMBER_TXT_C_TTLLOG = "ﾄｰﾀﾙﾛｸﾞ";
  static const DBNUMBER_TXT_C_CUST_LOG = "会員ﾛｸﾞ";
  static const DBNUMBER_TXT_C_CUST_TRM_MST = "会員ﾀｰﾐﾅﾙﾏｽﾀ";

  /* 50 */
  static const DBNUMBER_TXT_C_CUST_MST = "会員ﾏｽﾀ";
  static const DBNUMBER_TXT_C_CUST_ENQ_TBL = "会員問い合わせﾃｰﾌﾞﾙ";
  static const DBNUMBER_TXT_C_SVS_CLS_MST = "ｻｰﾋﾞｽ分類ﾏｽﾀ";
  static const DBNUMBER_TXT_C_FSPPLAN_PLU_TBL = "FSP企画商品ﾃｰﾌﾞﾙ";
  static const DBNUMBER_TXT_C_FSPPLAN_LRGCLS_TBL = "FSP企画大分類ﾃｰﾌﾞﾙ";
  static const DBNUMBER_TXT_C_FSPPLAN_MDLCLS_TBL = "FSP企画中分類ﾃｰﾌﾞﾙ";
  static const DBNUMBER_TXT_C_FSPPLAN_SMLCLS_TBL = "FSP企画小分類ﾃｰﾌﾞﾙ";
  static const DBNUMBER_TXT_C_FSPPLAN_TNYCLS_TBL = "FSP企画ｸﾗｽﾃｰﾌﾞﾙ";
  static const DBNUMBER_TXT_C_ANVKIND_MST = "記念日種別ﾏｽﾀ";
  static const DBNUMBER_TXT_C_CRDT_DEMAND_TBL = "ｸﾚｼﾞｯﾄ会社請求ﾃｰﾌﾞﾙ";

  /* 60 */
  static const DBNUMBER_TXT_C_CRDT_ACTUAL_LOG = "ｸﾚｼﾞｯﾄ請求実績ﾛｸﾞ";
  static const DBNUMBER_TXT_REG_MLY_DEAL = "ﾚｼﾞ・扱者月別取引";
  static const DBNUMBER_TXT_REG_DLY_DEAL = "ﾚｼﾞ・扱者日別取引";
  static const DBNUMBER_TXT_REG_MLY_FLOW = "ﾚｼﾞ・扱者月別在高";
  static const DBNUMBER_TXT_REG_DLY_FLOW = "ﾚｼﾞ・扱者日別在高";
  static const DBNUMBER_TXT_REG_MLY_INOUT = "ﾚｼﾞ・扱者月別入出金";
  static const DBNUMBER_TXT_REG_DLY_INOUT = "ﾚｼﾞ・扱者日別入出金";
  static const DBNUMBER_TXT_REG_DLY_ACR = "ﾚｼﾞ日別釣銭機";
  static const DBNUMBER_TXT_REG_MLY_LRG = "大分類月別販売";
  static const DBNUMBER_TXT_REG_DLY_LRG = "大分類日別販売";

  /* 70 */
  static const DBNUMBER_TXT_REG_MLY_MDL = "中分類月別販売";
  static const DBNUMBER_TXT_REG_DLY_MDL = "中分類日別販売";
  static const DBNUMBER_TXT_REG_MLY_SML = "小分類月別販売";
  static const DBNUMBER_TXT_REG_DLY_SML = "小分類日別販売";
  static const DBNUMBER_TXT_REG_MLY_TNY = "クラス月別販売";
  static const DBNUMBER_TXT_REG_DLY_TNY = "クラス日別販売";
  static const DBNUMBER_TXT_REG_MLY_PLU = "商品月別販売";
  static const DBNUMBER_TXT_REG_DLY_PLU = "商品日別販売";
  static const DBNUMBER_TXT_REG_MLY_CAT = "ｶﾃｺﾞﾘｰ値引月別販売";
  static const DBNUMBER_TXT_REG_DLY_CAT = "ｶﾃｺﾞﾘｰ値引日別販売";

  /* 80 */
  static const DBNUMBER_TXT_REG_SCH_BRGN = "単品企画別特売";
  static const DBNUMBER_TXT_REG_DLY_BRGN = "単品日別特売";
  static const DBNUMBER_TXT_REG_SCH_MACH = "企画別組み合せ";
  static const DBNUMBER_TXT_REG_DLY_MACH = "日別組み合せ";
  static const DBNUMBER_TXT_M_CUST_LOG = "会員ﾛｸﾞ(MS)";
  static const DBNUMBER_TXT_C_FSPSCH_MST = "FSPｽｹｼﾞｭｰﾙﾏｽﾀ";
  static const DBNUMBER_TXT_DEC_RBT_TBL = "確定割戻率ﾏｽﾀ";
  static const DBNUMBER_TXT_ZIPCODE_MST = "郵便番号ﾏｽﾀ";
  static const DBNUMBER_TXT_ZONE_MST = "地区ﾏｽﾀ";
  static const DBNUMBER_TXT_REG_DLY_ZONE = "地区日別実績";

  /* 90 */
  static const DBNUMBER_TXT_REG_MLY_ZONE = "地区月別実績";
  static const DBNUMBER_TXT_REG_DLY_SVS = "ｻｰﾋﾞｽ分類日別実績";
  static const DBNUMBER_TXT_REG_MLY_SVS = "ｻｰﾋﾞｽ分類月別実績";
  static const DBNUMBER_TXT_REG_DMLY_CUST = "会員日+月別実績";
  static const DBNUMBER_TXT_REG_MLY_CUST = "会員月別実績";
  static const DBNUMBER_TXT_REG_DLY_FSPPLU = "FSPPLU日別実績";
  static const DBNUMBER_TXT_REG_MLY_FSPPLU = "FSPPLU月別実績";
  static const DBNUMBER_TXT_REG_DLY_FSPSML = "FSP小分類日別実績";
  static const DBNUMBER_TXT_REG_MLY_FSPSML = "FSP小分類月別実績";
  static const DBNUMBER_TXT_REG_DLY_FSPMDL = "FSP中分類日別実績";

  /* 100 */
  static const DBNUMBER_TXT_REG_MLY_FSPMDL = "FSP中分類月別実績";
  static const DBNUMBER_TXT_REG_DLY_FSPTTL = "FSP合計日別実績";
  static const DBNUMBER_TXT_REG_MLY_FSPTTL = "FSP合計月別実績";
  static const DBNUMBER_TXT_C_PRESET_IMG_MST = "画像ﾌﾟﾘｾｯﾄﾏｽﾀ";

  static const DBNUMBER_TXT_C_PLUSCH_MST = "商品ﾎﾟｲﾝﾄ加算ｽｹｼﾞｭｰﾙﾏｽﾀ";
  static const DBNUMBER_TXT_C_PLUITEM_MST = "商品ﾎﾟｲﾝﾄ加算商品ﾏｽﾀ";
  static const DBNUMBER_TXT_C_MDLSCH_MST = "中分類値下ｽｹｼﾞｭｰﾙﾏｽﾀ";
  static const DBNUMBER_TXT_C_MDLITEM_MST = "中分類値下中分類ﾏｽﾀ";
  static const DBNUMBER_TXT_C_SMLSCH_MST = "小分類値下ｽｹｼﾞｭｰﾙﾏｽﾀ";
  static const DBNUMBER_TXT_C_SMLITEM_MST = "小分類値下小分類ﾏｽﾀ";

  /* 110 */
  static const DBNUMBER_TXT_C_SCHCTRL_MST = "ｽｹｼﾞｭｰﾙ管理ﾏｽﾀ";
  static const DBNUMBER_TXT_C_PROM_MST = "ﾌﾟﾛﾓｰｼｮﾝﾏｽﾀ";
  static const DBNUMBER_TXT_C_BATPRCCHG_MST = "予約売価変更ﾏｽﾀ";
  static const DBNUMBER_TXT_C_SPRK_MST = "伝票ﾌﾟﾘﾝﾀﾌｫｰﾏｯﾄﾏｽﾀ";

  static const DBNUMBER_TXT_C_MCSPEC_MST = "Mｶｰﾄﾞｽﾍﾟｯｸﾏｽﾀ";
  static const DBNUMBER_TXT_C_MCKIND_MST = "Mｶｰﾄﾞ種別ﾃｰﾌﾞﾙ";
  static const DBNUMBER_TXT_C_MCNEGA_MST = "Mｶｰﾄﾞ診断ﾃｰﾌﾞﾙ";

  static const DBNUMBER_TXT_C_SCHMSG_MST = "ﾚｼｰﾄﾒｯｾｰｼﾞｽｹｼﾞｭｰﾙﾏｽﾀ";
  static const DBNUMBER_TXT_C_FIPSCH_MST = "FIPｽｸﾛｰﾙﾒｯｾｰｼﾞ予約ﾏｽﾀ";
  static const DBNUMBER_TXT_C_FIPMSG_MST = "FIPｽｸﾛｰﾙﾒｯｾｰｼﾞﾏｽﾀ";

  /* 120 */
  static const DBNUMBER_TXT_C_MAKER_MST = "産地･ﾒｰｶｰﾏｽﾀ";

  static const DBNUMBER_TXT_C_TIMESCH_MST = "時間料金ｽｹｼﾞｭｰﾙﾏｽﾀ";
  static const DBNUMBER_TXT_C_TIMEITEM_MST = "時間料金ﾏｽﾀ";
  static const DBNUMBER_TXT_C_CONDIMENT_TBL = "付加商品ﾃｰﾌﾞﾙ";
  static const DBNUMBER_TXT_C_LGPCLS_MST = "大ｸﾞﾙｰﾌﾟﾏｽﾀ";
  static const DBNUMBER_TXT_C_GRPCLS_MST = "ｸﾞﾙｰﾌﾟﾏｽﾀ";
  static const DBNUMBER_TXT_C_STRELGP_MST = "店舗大ｸﾞﾙｰﾌﾟﾏｽﾀ";
  static const DBNUMBER_TXT_C_STREGRP_MST = "店舗ｸﾞﾙｰﾌﾟﾏｽﾀ";
  static const DBNUMBER_TXT_C_TNYSCH_MST = "ｸﾗｽ値下ｽｹｼﾞｭｰﾙﾏｽﾀ";
  static const DBNUMBER_TXT_C_TNYITEM_MST = "ｸﾗｽ値下ｽｹｼﾞｭｰﾙｸﾗｽﾏｽﾀ";
  static const DBNUMBER_TXT_C_DUTY_LOG = "出退勤ﾛｸﾞ";
  static const DBNUMBER_TXT_HOLIDAY_TBL = "休日ﾏｽﾀ";
  static const DBNUMBER_TXT_PAY_HOUR_TBL = "時給ﾏｽﾀ";
  static const DBNUMBER_TXT_CUST_ITEMLOG = "会員ｱｲﾃﾑﾛｸﾞ";
  static const DBNUMBER_TXT_CUST_TTLLOG = "会員ﾄｰﾀﾙﾛｸﾞ";

  static const DBNUMBER_TXT_KCSRCVMK = "無効ｶｰﾄﾞ情報ﾌｧｲﾙ";

  static const DBNUMBER_TXT_C_STMSCH2_MST = "ｸﾞﾙｰﾌﾟSMｽｹｼﾞｭｰﾙﾏｽﾀ";
  static const DBNUMBER_TXT_C_STMITEM2_MST = "ｸﾞﾙｰﾌﾟSM商品ﾏｽﾀ";

  static const DBNUMBER_TXT_RESERV_TBL = "予約ﾃｰﾌﾞﾙ";
  static const DBNUMBER_TXT_RESERV_LOG = "予約ﾛｸﾞ(ﾛｰｶﾙ)";
  static const DBNUMBER_TXT_M_RESERV_LOG = "予約ﾛｸﾞ";
  static const DBNUMBER_TXT_C_ITEMLOG_RESERV = "予約ｱｲﾃﾑﾛｸﾞ";
  static const DBNUMBER_TXT_C_TTLLOG_RESERV = "予約ﾄｰﾀﾙﾛｸﾞ";
  static const DBNUMBER_TXT_C_BDLLOG_RESERV = "予約ﾊﾞﾝﾄﾞﾙﾛｸﾞ";
  static const DBNUMBER_TXT_C_STMLOG_RESERV = "予約ｾｯﾄﾏｯﾁﾛｸﾞ";
  static const DBNUMBER_TXT_C_CRDT_ACTUAL_LOG_RESERV = "予約ｸﾚｼﾞｯﾄ請求実績ﾛｸﾞ";

  static const DBNUMBER_TXT_PBCHG_BALANCE_TBL = "公共料金残高情報";
  static const DBNUMBER_TXT_PBCHG_STRE_TBL = "公共料金店舗情報";
  static const DBNUMBER_TXT_PBCHG_CORP_TBL = "公共料金収納企業情報";
  static const DBNUMBER_TXT_PBCHG_NCORP_TBL = "公共料金端末別収納不可企業情報";
  static const DBNUMBER_TXT_PBCHG_NTTE_TBL = "公共料金NTT東日本局番情報";
  static const DBNUMBER_TXT_PBCHG_LOG = "公共料金収納ﾛｸﾞ(ﾛｰｶﾙ)";
  static const DBNUMBER_TXT_M_PBCHG_LOG = "公共料金収納ﾛｸﾞ(ﾏｽﾀ)";

  static const DBNUMBER_TXT_REASON_MST = "理由区分ﾏｽﾀ";

  static const DBNUMBER_TXT_C_KOPTCMN_MST = "ｷｰｵﾌﾟｼｮﾝ共通ﾏｽﾀ";
  static const DBNUMBER_TXT_BACKYARD_GRP_MST = "ﾊﾞｯｸﾔｰﾄﾞ機器ﾏｽﾀ";
  static const DBNUMBER_TXT_PASSPORT_MST = "ﾊﾟｽﾎﾟｰﾄ情報ﾏｽﾀ";

  /// 件数確認対象
  static const FILE_KCSRCVMK = "tmp/KCSRCVMK";

  static const List<String?> ncTableName0 = [
    "c_stre_mst",
    "c_regctrl_mst",
    "macaddr_mst",
    "regopt_mst",
    "c_grp_mst",
    "c_lrgcls_mst",
    "c_strelrg_mst",
    "c_mdlcls_mst",
    "c_stremdl_mst",
    "c_smlcls_mst",
    "c_stresml_mst",
    "c_tnycls_mst",
    "c_stretny_mst",
    "c_plu_mst",
    "c_scanplu_mst",
    "c_caseitem_mst",
    "c_brgnsch_mst",
    "c_brgnitem_mst",
    "c_bdlsch_mst",
    "c_bdlitem_mst",
    "c_stmsch_mst",
    "c_stmitem_mst",
    "c_cat_dsc_mst",
    "c_tax_mst",
    "c_staff_mst",
    "c_staffopen_mst",
    "c_img_mst",
    "c_kopttran_mst",
    "c_koptinout_mst",
    "c_koptdisc_mst",
    "c_koptref_mst",
    "c_koptoth_mst",
    "c_koptcmn_mst",
    "c_preset_mst",
    "c_trm_mst",
    "c_instre_mst",
    "c_ctrl_mst",
    "c_prcchg_mst",
    "c_openclose_mst",
    "c_tmp_mst",
    "histlog_mst",
    "c_histlog_chg_cnt",
    "c_batrepo_mst",
    "c_msg_mst",
    "c_report_cnt",
    "c_itemlog",
    "c_ej_log",
    "c_bdllog",
    "c_stmlog",
    "c_ttllog",
    "c_cust_log",
    "c_cust_trm_mst",
    "c_cust_mst",
    "c_cust_enq_tbl",
    "c_svs_cls_mst",
    "c_fspplan_plu_tbl",
    "c_fspplan_lrgcls_tbl",
    "c_fspplan_mdlcls_tbl",
    "c_fspplan_smlcls_tbl",
    "c_fspplan_tnycls_tbl",
    "c_anvkind_mst",
    "c_crdt_demand_tbl",
    "c_crdt_actual_log",
    "c_fspsch_mst",
    "dec_rbt_tbl",
    "zipcode_mst",
    "zone_mst",
    "c_preset_img_mst",
    "c_plusch_mst",
    "c_pluitem_mst",
    "c_mdlsch_mst",
    "c_mdlitem_mst",
    "c_smlsch_mst",
    "c_smlitem_mst",
    "c_schctrl_mst",
    "c_prom_mst",
    "c_batprcchg_mst",
    "c_mcspec_mst",
    "c_mckind_tbl",
    "c_mcnega_tbl",
    "c_schmsg_mst",
    "c_fipsch_mst",
    "c_msg_mst",
    "maker_mst",
    "c_timesch_mst",
    "c_timeitem_mst",
    "c_condiment_tbl",
    "c_lgpcls_mst",
    "c_grpcls_mst",
    "c_strelgp_mst",
    "c_stregrp_mst",
    "c_tnysch_mst",
    "c_tnyitem_mst",
    "c_duty_log",
    "holiday_tbl",
    "pay_hour_tbl",
    "cust_itemlog",
    "cust_ttllog",
    "c_stmsch2_mst",
    "c_stmitem2_mst",
    "reserv_tbl",
    "c_reserv_log",
    "p_pbchg_balance_tbl",
    "p_pbchg_stre_tbl",
    "p_pbchg_corp_tbl",
    "p_pbchg_ncorp_tbl",
    "p_pbchg_ntte_tbl",
    "c_pbchg_log",
    "c_divide_mst",
    "s_backyard_grp_mst",
    "c_passport_info_mst",
    null
  ];

  static const List<String?> ncTableName1123 = [
    "c_comp_mst",
    "c_stre_mst",
    "c_regctrl_mst",
    "macaddr_mst",
    "regopt_mst",
    "c_grp_mst",
    "c_lrgcls_mst",
    "c_strelrg_mst",
    "c_mdlcls_mst",
    "c_stremdl_mst",
    "c_smlcls_mst",
    "c_stresml_mst",
    "c_tnycls_mst",
    "c_stretny_mst",
    "c_plu_mst",
    "c_scanplu_mst",
    "c_caseitem_mst",
    "c_brgnsch_mst",
    "c_brgnitem_mst",
    "c_bdlsch_mst",
    "c_bdlitem_mst",
    "c_stmsch_mst",
    "c_stmitem_mst",
    "c_cat_dsc_mst",
    "c_tax_mst",
    "c_staff_mst",
    "c_staffopen_mst",
    "c_img_mst",
    "c_kopttran_mst",
    "c_koptinout_mst",
    "c_koptdisc_mst",
    "c_koptref_mst",
    "c_koptoth_mst",
    "c_koptcmn_mst",
    "c_preset_mst",
    "c_trm_mst",
    "c_instre_mst",
    "c_ctrl_mst",
    "c_prcchg_mst",
    "c_openclose_mst",
    "c_tmp_mst",
    "histlog_mst",
    "c_histlog_chg_cnt",
    "c_batrepo_mst",
    "c_msg_mst",
    "c_report_cnt",
    "c_itemlog",
    "c_ej_log",
    "c_bdllog",
    "c_stmlog",
    "c_ttllog",
    "c_cust_log",
    "c_cust_trm_mst",
    "c_cust_mst",
    "c_cust_enq_tbl",
    "c_svs_cls_mst",
    "c_fspplan_plu_tbl",
    "c_fspplan_lrgcls_tbl",
    "c_fspplan_mdlcls_tbl",
    "c_fspplan_smlcls_tbl",
    "c_fspplan_tnycls_tbl",
    "c_anvkind_mst",
    "c_crdt_demand_tbl",
    "c_crdt_actual_log",
    "reg_mly_deal",
    "reg_dly_deal",
    "reg_mly_flow",
    "reg_dly_flow",
    "reg_mly_inout",
    "reg_dly_inout",
    "reg_dly_acr",
    "reg_mly_lrg",
    "reg_dly_lrg",
    "reg_mly_mdl",
    "reg_dly_mdl",
    "reg_mly_sml",
    "reg_dly_sml",
    "reg_mly_tny",
    "reg_dly_tny",
    "reg_mly_plu",
    "reg_dly_plu",
    "reg_mly_cat",
    "reg_dly_cat",
    "reg_sch_brgn",
    "reg_dly_brgn",
    "reg_sch_mach",
    "reg_dly_mach",
    "c_fspsch_mst",
    "dec_rbt_tbl",
    "zipcode_mst",
    "zone_mst",
    "reg_mly_zone",
    "reg_dly_zone",
    "reg_mly_svs",
    "reg_dly_svs",
    "reg_mly_cust",
    "reg_dmly_cust",
    "reg_mly_fspplu",
    "reg_dly_fspplu",
    "reg_mly_fspsml",
    "reg_dly_fspsml",
    "reg_mly_fspmdl",
    "reg_dly_fspmdl",
    "reg_mly_fspttl",
    "reg_dly_fspttl",
    "m_cust_log",
    "c_preset_img_mst",
    "c_plusch_mst",
    "c_pluitem_mst",
    "c_mdlsch_mst",
    "c_mdlitem_mst",
    "c_smlsch_mst",
    "c_smlitem_mst",
    "c_schctrl_mst",
    "c_prom_mst",
    "c_batprcchg_mst",
    "c_mcspec_mst",
    "c_mckind_tbl",
    "c_mcnega_tbl",
    "c_schmsg_mst",
    "c_fipsch_mst",
    "c_msg_mst",
    "maker_mst",
    "c_timesch_mst",
    "c_timeitem_mst",
    "c_condiment_tbl",
    "c_lgpcls_mst",
    "c_grpcls_mst",
    "c_strelgp_mst",
    "c_stregrp_mst",
    "c_tnysch_mst",
    "c_tnyitem_mst",
    "c_duty_log",
    "holiday_tbl",
    "pay_hour_tbl",
    "cust_itemlog",
    "cust_ttllog",
    FILE_KCSRCVMK,
    "c_stmsch2_mst",
    "c_stmitem2_mst",
    "reserv_tbl",
    "reserv_log",
    "p_pbchg_balance_tbl",
    "p_pbchg_stre_tbl",
    "p_pbchg_corp_tbl",
    "p_pbchg_ncorp_tbl",
    "p_pbchg_ntte_tbl",
    "c_pbchg_log",
    "c_divide_mst",
    "c_passport_info_mst",
    null
  ];

  static const List<String?> ncJName0 = [
    DBNUMBER_TXT_C_STRE_MST,
    DBNUMBER_TXT_C_REGCTRL_MST,
    DBNUMBER_TXT_MACADDR_MST,
    DBNUMBER_TXT_REGOPT_MST,
    DBNUMBER_TXT_C_GRP_MST,
    DBNUMBER_TXT_C_LRGCLS_MST,
    DBNUMBER_TXT_C_STRELRG_MST,
    DBNUMBER_TXT_C_MDLCLS_MST,
    DBNUMBER_TXT_C_STREMDL_MST,
    DBNUMBER_TXT_C_SMLCLS_MST,
    DBNUMBER_TXT_C_STRESML_MST,
    DBNUMBER_TXT_C_TNYCLS_MST,
    DBNUMBER_TXT_C_STRETNY_MST,
    DBNUMBER_TXT_C_PLU_MST,
    DBNUMBER_TXT_C_SCANPLU_MST,
    DBNUMBER_TXT_C_CASEITEM_MST,
    DBNUMBER_TXT_C_BRGNSCH_MST,
    DBNUMBER_TXT_C_BRGNITEM_MST,
    DBNUMBER_TXT_C_BDLSCH_MST,
    DBNUMBER_TXT_C_BDLITEM_MST,
    DBNUMBER_TXT_C_STMSCH_MST,
    DBNUMBER_TXT_C_STMITEM_MST,
    DBNUMBER_TXT_C_CAT_DSC_MST,
    DBNUMBER_TXT_C_TAX_MST,
    DBNUMBER_TXT_C_STAFF_MST,
    DBNUMBER_TXT_C_STAFFOPEN_MST,
    DBNUMBER_TXT_C_IMG_MST,
    DBNUMBER_TXT_C_KOPTTRAN_MST,
    DBNUMBER_TXT_C_KOPTINOUT_MST,
    DBNUMBER_TXT_C_KOPTDISC_MST,
    DBNUMBER_TXT_C_KOPTREF_MST,
    DBNUMBER_TXT_C_KOPTOTH_MST,
    DBNUMBER_TXT_C_KOPTCMN_MST, // キーオプション共通マスタ
    DBNUMBER_TXT_C_PRESET_MST,
    DBNUMBER_TXT_C_TRM_MST,
    DBNUMBER_TXT_C_INSTRE_MST,
    DBNUMBER_TXT_C_CTRL_MST,
    DBNUMBER_TXT_C_PRCCHG_MST,
    DBNUMBER_TXT_C_OPENCLOSE_MST,
    DBNUMBER_TXT_C_TMP_MST,
    DBNUMBER_TXT_HISTLOG_MST,
    DBNUMBER_TXT_HISTLOG_CNT,
    DBNUMBER_TXT_C_BATREPO_MST,
    DBNUMBER_TXT_C_RECMSG_MST,
    DBNUMBER_TXT_REPORT_CNT,
    DBNUMBER_TXT_C_ITEMLOG,
    DBNUMBER_TXT_C_EJLOG,
    DBNUMBER_TXT_C_BDLLOG,
    DBNUMBER_TXT_C_STMLOG,
    DBNUMBER_TXT_C_TTLLOG,
    DBNUMBER_TXT_C_CUST_LOG,
    DBNUMBER_TXT_C_CUST_TRM_MST,
    DBNUMBER_TXT_C_CUST_MST,
    DBNUMBER_TXT_C_CUST_ENQ_TBL,
    DBNUMBER_TXT_C_SVS_CLS_MST,
    DBNUMBER_TXT_C_FSPPLAN_PLU_TBL,
    DBNUMBER_TXT_C_FSPPLAN_LRGCLS_TBL,
    DBNUMBER_TXT_C_FSPPLAN_MDLCLS_TBL,
    DBNUMBER_TXT_C_FSPPLAN_SMLCLS_TBL,
    DBNUMBER_TXT_C_FSPPLAN_TNYCLS_TBL,
    DBNUMBER_TXT_C_ANVKIND_MST,
    DBNUMBER_TXT_C_CRDT_DEMAND_TBL,
    DBNUMBER_TXT_C_CRDT_ACTUAL_LOG,
    DBNUMBER_TXT_C_FSPSCH_MST,
    /* 2002/10/01 */
    DBNUMBER_TXT_DEC_RBT_TBL,
    /* 2002/10/01 */
    DBNUMBER_TXT_ZIPCODE_MST,
    /* 2002/10/01 */
    DBNUMBER_TXT_ZONE_MST,
    /* 2002/10/01 */
    DBNUMBER_TXT_C_PRESET_IMG_MST,
    /* 2002/10/01 */
    DBNUMBER_TXT_C_PLUSCH_MST,
    DBNUMBER_TXT_C_PLUITEM_MST,
    DBNUMBER_TXT_C_MDLSCH_MST,
    DBNUMBER_TXT_C_MDLITEM_MST,
    DBNUMBER_TXT_C_SMLSCH_MST,
    DBNUMBER_TXT_C_SMLITEM_MST,
    DBNUMBER_TXT_C_SCHCTRL_MST,
    DBNUMBER_TXT_C_PROM_MST,
    DBNUMBER_TXT_C_BATPRCCHG_MST,
    DBNUMBER_TXT_C_MCSPEC_MST,
    DBNUMBER_TXT_C_MCKIND_MST,
    DBNUMBER_TXT_C_MCNEGA_MST,
    DBNUMBER_TXT_C_SCHMSG_MST,
    DBNUMBER_TXT_C_FIPSCH_MST,
    DBNUMBER_TXT_C_FIPMSG_MST,
    DBNUMBER_TXT_C_MAKER_MST,
    DBNUMBER_TXT_C_TIMESCH_MST,
    DBNUMBER_TXT_C_TIMEITEM_MST,
    DBNUMBER_TXT_C_CONDIMENT_TBL,
    DBNUMBER_TXT_C_LGPCLS_MST,
    DBNUMBER_TXT_C_GRPCLS_MST,
    DBNUMBER_TXT_C_STRELGP_MST,
    DBNUMBER_TXT_C_STREGRP_MST,
    DBNUMBER_TXT_C_TNYSCH_MST,
    DBNUMBER_TXT_C_TNYITEM_MST,
    DBNUMBER_TXT_C_DUTY_LOG,
    DBNUMBER_TXT_HOLIDAY_TBL,
    DBNUMBER_TXT_PAY_HOUR_TBL,
    DBNUMBER_TXT_CUST_ITEMLOG,
    DBNUMBER_TXT_CUST_TTLLOG,
    DBNUMBER_TXT_C_STMSCH2_MST,
    DBNUMBER_TXT_C_STMITEM2_MST,
    DBNUMBER_TXT_RESERV_TBL,
    DBNUMBER_TXT_RESERV_LOG,
    DBNUMBER_TXT_PBCHG_BALANCE_TBL,
    DBNUMBER_TXT_PBCHG_STRE_TBL,
    DBNUMBER_TXT_PBCHG_CORP_TBL,
    DBNUMBER_TXT_PBCHG_NCORP_TBL,
    DBNUMBER_TXT_PBCHG_NTTE_TBL,
    DBNUMBER_TXT_PBCHG_LOG,
    DBNUMBER_TXT_REASON_MST, // 理由区分マスタ
    DBNUMBER_TXT_BACKYARD_GRP_MST,
    DBNUMBER_TXT_PASSPORT_MST,
    null
  ];

  static const List<String?> ncJName1123 = [
    DBNUMBER_TXT_C_COMP_MST,
    DBNUMBER_TXT_C_STRE_MST,
    DBNUMBER_TXT_C_REGCTRL_MST,
    DBNUMBER_TXT_MACADDR_MST,
    DBNUMBER_TXT_REGOPT_MST,
    DBNUMBER_TXT_C_GRP_MST,
    DBNUMBER_TXT_C_LRGCLS_MST,
    DBNUMBER_TXT_C_STRELRG_MST,
    DBNUMBER_TXT_C_MDLCLS_MST,
    DBNUMBER_TXT_C_STREMDL_MST,
    DBNUMBER_TXT_C_SMLCLS_MST,
    DBNUMBER_TXT_C_STRESML_MST,
    DBNUMBER_TXT_C_TNYCLS_MST,
    DBNUMBER_TXT_C_STRETNY_MST,
    DBNUMBER_TXT_C_PLU_MST,
    DBNUMBER_TXT_C_SCANPLU_MST,
    DBNUMBER_TXT_C_CASEITEM_MST,
    DBNUMBER_TXT_C_BRGNSCH_MST,
    DBNUMBER_TXT_C_BRGNITEM_MST,
    DBNUMBER_TXT_C_BDLSCH_MST,
    DBNUMBER_TXT_C_BDLITEM_MST,
    DBNUMBER_TXT_C_STMSCH_MST,
    DBNUMBER_TXT_C_STMITEM_MST,
    DBNUMBER_TXT_C_CAT_DSC_MST,
    DBNUMBER_TXT_C_TAX_MST,
    DBNUMBER_TXT_C_STAFF_MST,
    DBNUMBER_TXT_C_STAFFOPEN_MST,
    DBNUMBER_TXT_C_IMG_MST,
    DBNUMBER_TXT_C_KOPTTRAN_MST,
    DBNUMBER_TXT_C_KOPTINOUT_MST,
    DBNUMBER_TXT_C_KOPTDISC_MST,
    DBNUMBER_TXT_C_KOPTREF_MST,
    DBNUMBER_TXT_C_KOPTOTH_MST,
    DBNUMBER_TXT_C_KOPTCMN_MST, // キーオプション共通マスタ
    DBNUMBER_TXT_C_PRESET_MST,
    DBNUMBER_TXT_C_TRM_MST,
    DBNUMBER_TXT_C_INSTRE_MST,
    DBNUMBER_TXT_C_CTRL_MST,
    DBNUMBER_TXT_C_PRCCHG_MST,
    DBNUMBER_TXT_C_OPENCLOSE_MST,
    DBNUMBER_TXT_C_TMP_MST,
    DBNUMBER_TXT_HISTLOG_MST,
    DBNUMBER_TXT_HISTLOG_CNT,
    DBNUMBER_TXT_C_BATREPO_MST,
    DBNUMBER_TXT_C_RECMSG_MST,
    DBNUMBER_TXT_REPORT_CNT,
    DBNUMBER_TXT_C_ITEMLOG,
    DBNUMBER_TXT_C_EJLOG,
    DBNUMBER_TXT_C_BDLLOG,
    DBNUMBER_TXT_C_STMLOG,
    DBNUMBER_TXT_C_TTLLOG,
    DBNUMBER_TXT_C_CUST_LOG,
    DBNUMBER_TXT_C_CUST_TRM_MST,
    DBNUMBER_TXT_C_CUST_MST,
    DBNUMBER_TXT_C_CUST_ENQ_TBL,
    DBNUMBER_TXT_C_SVS_CLS_MST,
    DBNUMBER_TXT_C_FSPPLAN_PLU_TBL,
    DBNUMBER_TXT_C_FSPPLAN_LRGCLS_TBL,
    DBNUMBER_TXT_C_FSPPLAN_MDLCLS_TBL,
    DBNUMBER_TXT_C_FSPPLAN_SMLCLS_TBL,
    DBNUMBER_TXT_C_FSPPLAN_TNYCLS_TBL,
    DBNUMBER_TXT_C_ANVKIND_MST,
    DBNUMBER_TXT_C_CRDT_DEMAND_TBL,
    DBNUMBER_TXT_C_CRDT_ACTUAL_LOG,
    DBNUMBER_TXT_REG_MLY_DEAL,
    DBNUMBER_TXT_REG_DLY_DEAL,
    DBNUMBER_TXT_REG_MLY_FLOW,
    DBNUMBER_TXT_REG_DLY_FLOW,
    DBNUMBER_TXT_REG_MLY_INOUT,
    DBNUMBER_TXT_REG_DLY_INOUT,
    DBNUMBER_TXT_REG_DLY_ACR,
    DBNUMBER_TXT_REG_MLY_LRG,
    DBNUMBER_TXT_REG_DLY_LRG,
    DBNUMBER_TXT_REG_MLY_MDL,
    DBNUMBER_TXT_REG_DLY_MDL,
    DBNUMBER_TXT_REG_MLY_SML,
    DBNUMBER_TXT_REG_DLY_SML,
    DBNUMBER_TXT_REG_MLY_TNY,
    DBNUMBER_TXT_REG_DLY_TNY,
    DBNUMBER_TXT_REG_MLY_PLU,
    DBNUMBER_TXT_REG_DLY_PLU,
    DBNUMBER_TXT_REG_MLY_CAT,
    DBNUMBER_TXT_REG_DLY_CAT,
    DBNUMBER_TXT_REG_SCH_BRGN,
    DBNUMBER_TXT_REG_DLY_BRGN,
    DBNUMBER_TXT_REG_SCH_MACH,
    DBNUMBER_TXT_REG_DLY_MACH,
    DBNUMBER_TXT_C_FSPSCH_MST,
    DBNUMBER_TXT_DEC_RBT_TBL,
    DBNUMBER_TXT_ZIPCODE_MST,
    DBNUMBER_TXT_ZONE_MST,
    DBNUMBER_TXT_REG_MLY_ZONE,
    DBNUMBER_TXT_REG_DLY_ZONE,
    DBNUMBER_TXT_REG_MLY_SVS,
    DBNUMBER_TXT_REG_DLY_SVS,
    DBNUMBER_TXT_REG_MLY_CUST,
    DBNUMBER_TXT_REG_DMLY_CUST,
    DBNUMBER_TXT_REG_MLY_FSPPLU,
    DBNUMBER_TXT_REG_DLY_FSPPLU,
    DBNUMBER_TXT_REG_MLY_FSPSML,
    DBNUMBER_TXT_REG_DLY_FSPSML,
    DBNUMBER_TXT_REG_MLY_FSPMDL,
    DBNUMBER_TXT_REG_DLY_FSPMDL,
    DBNUMBER_TXT_REG_MLY_FSPTTL,
    DBNUMBER_TXT_REG_DLY_FSPTTL,
    DBNUMBER_TXT_M_CUST_LOG,
    DBNUMBER_TXT_C_PRESET_IMG_MST,
    DBNUMBER_TXT_C_PLUSCH_MST,
    DBNUMBER_TXT_C_PLUITEM_MST,
    DBNUMBER_TXT_C_MDLSCH_MST,
    DBNUMBER_TXT_C_MDLITEM_MST,
    DBNUMBER_TXT_C_SMLSCH_MST,
    DBNUMBER_TXT_C_SMLITEM_MST,
    DBNUMBER_TXT_C_SCHCTRL_MST,
    DBNUMBER_TXT_C_PROM_MST,
    DBNUMBER_TXT_C_BATPRCCHG_MST,
    DBNUMBER_TXT_C_MCSPEC_MST,
    DBNUMBER_TXT_C_MCKIND_MST,
    DBNUMBER_TXT_C_MCNEGA_MST,
    DBNUMBER_TXT_C_SCHMSG_MST,
    DBNUMBER_TXT_C_FIPSCH_MST,
    DBNUMBER_TXT_C_FIPMSG_MST,
    DBNUMBER_TXT_C_MAKER_MST,
    DBNUMBER_TXT_C_TIMESCH_MST,
    DBNUMBER_TXT_C_TIMEITEM_MST,
    DBNUMBER_TXT_C_CONDIMENT_TBL,
    DBNUMBER_TXT_C_LGPCLS_MST,
    DBNUMBER_TXT_C_GRPCLS_MST,
    DBNUMBER_TXT_C_STRELGP_MST,
    DBNUMBER_TXT_C_STREGRP_MST,
    DBNUMBER_TXT_C_TNYSCH_MST,
    DBNUMBER_TXT_C_TNYITEM_MST,
    DBNUMBER_TXT_C_DUTY_LOG,
    DBNUMBER_TXT_HOLIDAY_TBL,
    DBNUMBER_TXT_PAY_HOUR_TBL,
    DBNUMBER_TXT_CUST_ITEMLOG,
    DBNUMBER_TXT_CUST_TTLLOG,
    DBNUMBER_TXT_KCSRCVMK,
    DBNUMBER_TXT_C_STMSCH2_MST,
    DBNUMBER_TXT_C_STMITEM2_MST,
    DBNUMBER_TXT_RESERV_TBL,
    DBNUMBER_TXT_RESERV_LOG,
    DBNUMBER_TXT_PBCHG_BALANCE_TBL,
    DBNUMBER_TXT_PBCHG_STRE_TBL,
    DBNUMBER_TXT_PBCHG_CORP_TBL,
    DBNUMBER_TXT_PBCHG_NCORP_TBL,
    DBNUMBER_TXT_PBCHG_NTTE_TBL,
    DBNUMBER_TXT_PBCHG_LOG,
    DBNUMBER_TXT_REASON_MST, // 理由区分マスタ
    DBNUMBER_TXT_PASSPORT_MST,
    null
  ];

  /// ＴＳレジ用
  /// table struct
  /// 関連tprxソース:dbNumberConfirm.h - NCparam_0
  static List<NcSetting> ncParam0() {
    List<NcSetting> ncParam0 = List.empty(growable: true); /* TS */
    NcSetting ncSettingBuf = NcSetting();
    for (int i = 0; i < ncTableName0.length; i++) {
      if (ncTableName0[i] != null && ncJName0[i] != null) {
        ncSettingBuf.tableName = ncTableName0[i]!;
        ncSettingBuf.jName = ncJName0[i]!;
        ncParam0.add(ncSettingBuf);
      }
    }
    return ncParam0;
  }

  /// ＭＳ仕様レジ(Ｍレジ、ＢＳレジ、Ｓレジ、ＳＴレジ)用
  /// table struct
  /// 関連tprxソース:dbNumberConfirm.h - NCparam_1_123
  static List<NcSetting> ncParam1123() {
    List<NcSetting> ncParam0 = List.empty(growable: true); /* TS */
    NcSetting ncSettingBuf = NcSetting();
    for (int i = 0; i < ncTableName1123.length; i++) {
      if (ncTableName1123[i] != null && ncJName1123[i] != null) {
        ncSettingBuf.tableName = ncTableName1123[i]!;
        ncSettingBuf.jName = ncJName1123[i]!;
        ncParam0.add(ncSettingBuf);
      }
    }
    return ncParam0;
  }
}

/// 関連tprxソース:dbNumberConfirm.h - ncsetting
class NcSetting {
  String? tableName = '';
  String? jName = '';
}
