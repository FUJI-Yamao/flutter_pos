/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../postgres_library/src/pos_basic_table_access.dart';
import '../../common/date_util.dart';

///  関連tprxソース:rxtbl_buff.h - REGGRP_LISTS
enum REGGRP_LISTS {
  REGGRP_CLS(1), // 分類グループ
  REGGRP_TRM(2), // ターミナルグループ
  REGGRP_PRESET(3), // プリセットグループ
  REGGRP_KOPT(4), // キーオプショングループ
  REGGRP_BATCH(5), // 予約レポートグループ
  REGGRP_IMG(6), // イメージグループ
  REGGRP_MSG(7), // メッセージグループ
  REGGRP_CASHRECYCLE(8), // キャッシュリサイクル(マネージメント)グループ
  REGGRP_CARDCOMP(9), // カード企業コード
  REGGRP_CARDSTRE(10), // カード店舗コード
  REGGRP_STROPNCLS(11), // 自動開閉店グループ
  REGGRP_FORCESTRCLS(12); // 自動強制閉設グループ

  final int typeCd;
  const REGGRP_LISTS(this.typeCd);
}

/// レジ情報データ
/// c_reginfo_mst, c_reginfo_grp_mstの情報を持つ
///  関連tprxソース:rxtbl_buff.h - reginfo_buff
class RegInfoBuff {
  int macTyp = 0; // レジタイプ
  int setOwnerFlg = 0; // セグメント番号
  int macRole1 = 0; // レジ役割
  int macRole2 = 0; // レジ役割
  int macRole3 = 0; // レジ役割
  int pbchgFlg = 0; // 収納代行実施フラグ
  int compCd = 0; // 企業コード
  int streCd = 0; // 店舗コード
  int macNo = 0; // レジ番号
  int orgMacNo = 0; // 元レジ番号
  int clsGrpCd = 0; // 分類グループ
  int trmGrpCd = 0; // ターミナルグループ
  int presetGrpCd = 0; // プリセットグループ
  int koptGrpCd = 0; // キーオプショングループ
  int batchGrpCd = 0; // 予約レポートグループ
  int imgGrpCd = 0; // イメージグループ
  int msgGrpCd = 0; // メッセージグループ
  int cashrecycleGrpCd = 0; // キャッシュリサイクル(マネージメント)グループ
  int cardCompCd = 0; // カード企業コード
  int cardStreCd = 0; // カード店舗コード
  int stropnclsGrpCd = 0; // 自動開閉店グループ
  int forcestrclsGrpCd = 0; // 自動強制閉設グループ
  DateTime startDatetime = DateUtil.invalidDate; // 開始日時
  DateTime endDatetime = DateUtil.invalidDate; // 終了日時
  DateTime? insDatetime = DateUtil.invalidDate; // 作成日時
  DateTime? updDatetime = DateUtil.invalidDate; // 更新日時
  String crdtTrmCd = ""; // クレジット端末コード
  String macAddr = ""; // MACアドレス
  String ipAddr = ""; // IPアドレス
  String ipAddr2 = ""; // IPアドレス２
  String brdcastAddr = ""; // ブロードキャストアドレス
  String brdcastAddr2 = ""; // ブロードキャストアドレス２
  int autoOpnCshrCd = 0; //自動開店キャッシャー従業員コード
  int autoOpnChkrCd = 0; //自動開店チェッカー従業員コード
  int autoClsCshrCd = 0; //自動閉店キャッシャー従業員コード
}

/// 共通コントロール情報構造体
/// c_reginfo_mst, c_reginfo_grp_mstの情報を持つ
///  関連tprxソース:rxtbl_buff.h - ctrl_buff
class CtrlBuff {
  int costPerCls = 0;
  int nonactCls = 0;
  int dscCls = 0;
  int rbtClsFlg = 0;
  int prcchgFlg = 0;
  int stldscFlg = 0;
  int regsaleCls = 0;
  int taxtblCls = 0;
  int treatClsFlg = 0;
  int wghCdBaseFlg = 0;
  int wghCdRndFlg = 0;
  int udtBothFlg = 0;
  int regTenantFlg = 0;
  int multprcCls = 0;
  int presetImgClsFlg = 0;
  int stlplusFlg = 0;
  int pctrTcktCls = 0;
  int clothingCls = 0;
  int alertCls = 0;
  int chgCktCls = 0;
  int kitchenPrnCls = 0;
  int pricingCls = 0;
  int couponCls = 0;
  int selfWeightCls = 0;
  int msgCls = 0;
  int popCls = 0;
  int custDetailCls = 0;
  int magazineCls = 0;
  int taxExemptionCls = 0;
  int bookCls = 0;
  int custUnlock = 0;
  int clsPointsFlg = 0;
  int sub1PointsFlg = 0;
  int sub1StldscFlg = 0;
  int sub1StlplusFlg = 0;
  int sub1PctrTcktCls = 0;
  int sub2PointsFlg = 0;
  int sub2StldscFlg = 0;
  int sub2StlplusFlg = 0;
  int sub2PctrTcktCls = 0;
  int dpntAddClsFlg = 0;
  int dpntUseClsFlg = 0;
  int volCdRndFlg = 0;
}

enum CtrlCodeList {
  CTRLNO_COST_NONE(0),
  CTRLNO_COST_PER_CLS(1),
  CTRLNO_NONACT_CLS(2),
  CTRLNO_DSC_CLS(3),
  CTRLNO_RBT_CLS_FLG(4),
  CTRLNO_PRCCHG_FLG(5),
  CTRLNO_STLDSC_FLG(6),
  CTRLNO_REGSALE_CLS(7),
  CTRLNO_TAXTBL_CLS(8),
  CTRLNO_TREAT_CLS_FLG(9),
  CTRLNO_WGH_CD_BASE_FLG(11),
  CTRLNO_WGH_CD_RND_FLG(12),
  CTRLNO_UDT_BOTH_FLG(13),
  CTRLNO_REG_TENANT_FLG(14),
  CTRLNO_MULTPRC_CLS(15),
  CTRLNO_PRESET_IMG_CLS_FLG(16),
  CTRLNO_STLPLUS_FLG(17),
  CTRLNO_PCTR_TCKT_CLS(18),
  CTRLNO_CLOTHING_CLS(19),
  CTRLNO_ALERT_CLS(20),
  CTRLNO_CHG_CKT_CLS(21),
  CTRLNO_KITCHEN_PRN_CLS(22),
  CTRLNO_PRICING_CLS(23),
  CTRLNO_COUPON_CLS(24),
  CTRLNO_SELF_WEIGHT_CLS(25),
  CTRLNO_MSG_CLS(26),
  CTRLNO_POP_CLS(27),
  CTRLNO_CUST_DETAIL_CLS(28),
  CTRLNO_MAG_CLS(29),
  CTRLNO_TAX_EXEMPTION_CLS(30),
  CTRLNO_BOOK_CLS(31),
  CTRLNO_CUST_UNLOCK(32),
  CTRLNO_CLS_POINTS_FLG(33),
  CTRLNO_SUB1_POINTS_FLG(34),
  CTRLNO_SUB1_STLDSC_FLG(35),
  CTRLNO_SUB1_STLPLUS_FLG(36),
  CTRLNO_SUB1_PCTR_TCKT_CLS(37),
  CTRLNO_SUB2_POINTS_FLG(38),
  CTRLNO_SUB2_STLDSC_FLG(39),
  CTRLNO_SUB2_STLPLUS_FLG(40),
  CTRLNO_SUB2_PCTR_TCKT_CLS(41),
  CTRLNO_DPNT_ADD_CLS_FLG(42),
  CTRLNO_DPNT_USE_CLS_FLG(43),
  CTRLNO_VOL_CD_RND_FLG(44);

  final int ctrlCd;
  const CtrlCodeList(this.ctrlCd);

  static CtrlCodeList getDefine(int cd) {
    CtrlCodeList def = CtrlCodeList.values.firstWhere((element) {
      return element.ctrlCd == cd;
    }, orElse: () => CtrlCodeList.CTRLNO_COST_NONE);
    return def;
  }
}

//***************************************************************************************************
//	ターミナル企画番号マスタ情報  格納構造体
//***************************************************************************************************
/// ターミナル企画番号用のフラグ
///  関連tprxソース: rxtbl_buff.h - TRMPLAN_ACCT_FLG
enum TrmPlanAcctFl {
  TRMPLAN_ACCT_NORMAL, // 通常
  TRMPLAN_ACCT_MANU, // 手動割戻
  TRMPLAN_ACCT_AUTO, // 値引
  TRMPLAN_ACCT_TCKT, // チケット
  TRMPLAN_ACCT_PORTAL_AUTO, // ポータルサイト値引
  TRMPLAN_ACCT_PORTAL_TCKT, // ポータルサイトチケット
  TRMPLAN_ACCT_PORTAL_MANU, // ポータルサイト手動割戻
}

///  関連tprxソース: rxtbl_buff.h - trmplan_buff
class TrmPlanBuff {
  int acctCd = 0;
  int acctFlg = 0;
  String promoExtId = "";
}

//***************************************************************************************************
//	メッセージマスタ情報  格納構造体
//***************************************************************************************************
/// c_msg_mst, c_c_msglayout_mstの情報を持つ
/// 関連tprxソース: rxtbl_buff.h - msg_mst_data
class MsgMstData {
  int msg_cd = 0; //  メッセージコード
  int msg_kind = 0; //  メッセージ種別
  String msg_data_1 = ""; //  メッセージ内容１行目
  String msg_data_2 = ""; //  メッセージ内容２行目
  String msg_data_3 = ""; //  メッセージ内容３行目
  String msg_data_4 = ""; //  メッセージ内容４行目
  String msg_data_5 = ""; //  メッセージ内容５行目
  int msggrp_cd = 0; //  メッセージグループコード
  int msg_typ = 0; //  メッセージタイプ
  int target_typ = 0; //  対象
  int msg_size_1 = 0; //  メッセージサイズ1行目
  int msg_size_2 = 0; //  メッセージサイズ2行目
  int msg_size_3 = 0; //  メッセージサイズ3行目
  int msg_size_4 = 0; //  メッセージサイズ4行目
  int msg_size_5 = 0; //  メッセージサイズ5行目
  int msg_color_1 = 0; //  メッセージカラー1行目
  int msg_color_2 = 0; //  メッセージカラー2行目
  int msg_color_3 = 0; //  メッセージカラー3行目
  int msg_color_4 = 0; //  メッセージカラー4行目
  int msg_color_5 = 0; //  メッセージカラー5行目
  int back_color = 0; //  背景色
  int back_pict_typ = 0; //  背景画像タイプ
  int second = 0; //  表示秒数
  int flg_01 = 0; //  フラグ01
  int flg_02 = 0; //  フラグ02
  int flg_03 = 0; //  フラグ03
  int flg_04 = 0; //  フラグ04
  int flg_05 = 0; //  フラグ05
  // TODO:10052 コンパイルスイッチ(EXPAND_MSGMST)
  // EXPAND_MSGMSTが有効だったときに下記変数が有効になる.
  String msg_data_6 = ""; //  メッセージ内容６行目
  String msg_data_7 = ""; //  メッセージ内容７行目
  String msg_data_8 = ""; //  メッセージ内容８行目
  String msg_data_9 = ""; //  メッセージ内容９行目
  String msg_data_10 = ""; //  メッセージ内容10行目
  int msg_size_6 = 0; //  メッセージサイズ6行目
  int msg_size_7 = 0; //  メッセージサイズ7行目
  int msg_size_8 = 0; //  メッセージサイズ8行目
  int msg_size_9 = 0; //  メッセージサイズ9行目
  int msg_size_10 = 0; //  メッセージサイズ10行目
  int msg_color_6 = 0; //  メッセージカラー6行目
  int msg_color_7 = 0; //  メッセージカラー7行目
  int msg_color_8 = 0; //  メッセージカラー8行目
  int msg_color_9 = 0; //  メッセージカラー9行目
  int msg_color_10 = 0; //  メッセージカラー10行目
  int flg_06 = 0; //  フラグ06
  int flg_07 = 0; //  フラグ07
  int flg_08 = 0; //  フラグ08
  int flg_09 = 0; //  フラグ09
  int flg_10 = 0; //  フラグ10
  // ----
}

//***************************************************************************************************
//	実績用
//***************************************************************************************************

/// 割戻フラグ
///  関連tprxソース: rxtbl_buff.h - TTLBUF_REBATE_LIST()
enum TtlBufRebateList {
  TTLBUF_REBATE_NOT, // しない
  TTLBUF_REBATE_MANU_DSC, // 手動 + 値引
  TTLBUF_REBATE_MANU, // 手動(ポイント減算のみ)
  TTLBUF_REBATE_AUTO_DSC, // 自動 + 値引
  TTLBUF_REBATE_AUTO, // 自動(ポイント減算のみ)
  TTLBUF_REBATE_TCKT, // チケット発行
}

/// キャッシュリサイクル管理マスタ
///  関連tprxソース: rxtbl_buff.h - cashrecycle_buff()
class CashrycycleBuff {
//キャッシュリサイクル管理マスタ
  late CCashrecycleInfoMstColumns cashrycycleInfo =
      CCashrecycleInfoMstColumns();

//キャッシュリサイクルマスタ(設定）
  int btnOftenShow = 0; //釣銭情報ボタン常時表示
  int btnColor = 0; //釣銭情報ボタン色
  int btnColorExit = 0; //釣銭情報あり時ボタン色
  int btnColorAlert = 0; //在高異常通知時釣銭情報ボタン色
  int allotMethod = 0; //充当方法
  int rollUnitInout = 0; //事務所から充当時、単位指定枚数入出金
  int rollUnit10000 = 0; //単位枚数　10000円(0～99)
  int rollUnit5000 = 0; //単位枚数　5000円(0～99)
  int rollUnit2000 = 0; //単位枚数　1000円(0～99)
  int rollUnit1000 = 0; //単位枚数　1000円(0～99)
  int rollUnit500 = 0; //単位枚数　500円(0～99)
  int rollUnit100 = 0; //単位枚数　100円(0～99)
  int rollUnit50 = 0; //単位枚数　50円(0～99)
  int rollUnit10 = 0; //単位枚数　10円(0～99)
  int rollUnit5 = 0; //単位枚数　5円(0～99)
  int rollUnit1 = 0; //単位枚数　1円(0～99)
  int allotRef = 0; //充当基準枚数
  int allotRefSht10000 = 0; //充当基準枚数  10000円(0～99)
  int allotRefSht5000 = 0; //充当基準枚数  5000円(0～99)
  int allotRefSht2000 = 0; //充当基準枚数  2000円(0～99)
  int allotRefSht1000 = 0; //充当基準枚数  1000円(0～99)
  int allotRefSht500 = 0; //充当基準枚数  500円(0～99)
  int allotRefSht100 = 0; //充当基準枚数  100円(0～99)
  int allotRefSht50 = 0; //充当基準枚数  50円(0～99)
  int allotRefSht10 = 0; //充当基準枚数  10円(0～99)
  int allotRefSht5 = 0; //充当基準枚数  5円(0～99)
  int allotRefSht1 = 0; //充当基準枚数  1円(0～99)
  int keepSht = 0; //最低保持枚数
  int keepSht10000 = 0; //差分枚数　10000円(0～50)
  int keepSht5000 = 0; //差分枚数　5000円(0～50)
  int keepSht2000 = 0; //差分枚数　2000円(0～50)
  int keepSht1000 = 0; //差分枚数　1000円(0～50)
  int keepSht500 = 0; //差分枚数　500円(0～50)
  int keepSht100 = 0; //差分枚数　100円(0～50)
  int keepSht50 = 0; //差分枚数　50円(0～50)
  int keepSht10 = 0; //差分枚数　10円(0～50)
  int keepSht5 = 0; //差分枚数　5円(0～50)
  int keepSht1 = 0; //差分枚数　1円(0～50)
  int btnShtShow = 0; //充当レジボタン枚数表示
  int rcpPrn = 0; //レジ間移動指示レシート印字内容
  int confStampPrn = 0; //確認欄印字
  int staffInput = 0; //入金登録操作時従業員入力
  int reinPrn = 0; //再入金指示レシート発行
  int cinCncl = 0; //入金取消禁止
  int cchg = 0; //事務所一括時の両替
  int manInout = 0; //万券入出金

  void setValueCashrycycleMst(int code, int data) {
    CashrecycleList codeDef = CashrecycleList.getDefine(code);
    switch (codeDef) {
      case CashrecycleList.CASHRECYCLE_BTN_OFTEN_SHOW: //釣銭情報ボタン常時表示
        btnOftenShow = data;
        break;
      case CashrecycleList.CASHRECYCLE_BTN_COLOR: //釣銭情報ボタン色
        btnColor = data;
        break;
      case CashrecycleList.CASHRECYCLE_BTN_COLOR_EXIT: //釣銭情報あり時ボタン色
        btnColorExit = data;
        break;
      case CashrecycleList.CASHRECYCLE_BTN_COLOR_ALERT: //在高異常通知時釣銭情報ボタン色
        btnColorAlert = data;
        break;
      case CashrecycleList.CASHRECYCLE_ALLOT_METHOD: //充当方法
        allotMethod = data;
        break;
      case CashrecycleList.CASHRECYCLE_ROLL_UNIT_INOUT: //事務所から充当時、単位指定枚数入出金
        rollUnitInout = data;
        break;
      case CashrecycleList.CASHRECYCLE_ROLL_UNIT_10000: //単位枚数　10000円(0～99)
        rollUnit10000 = data;
        break;
      case CashrecycleList.CASHRECYCLE_ROLL_UNIT_5000: //単位枚数　5000円(0～99)
        rollUnit5000 = data;
        break;
      case CashrecycleList.CASHRECYCLE_ROLL_UNIT_2000: //単位枚数　1000円(0～99)
        rollUnit2000 = data;
        break;
      case CashrecycleList.CASHRECYCLE_ROLL_UNIT_1000: //単位枚数　1000円(0～99)
        rollUnit1000 = data;
        break;
      case CashrecycleList.CASHRECYCLE_ROLL_UNIT_500: //単位枚数　500円(0～99)
        rollUnit500 = data;
        break;
      case CashrecycleList.CASHRECYCLE_ROLL_UNIT_100: //単位枚数　100円(0～99)
        rollUnit100 = data;
        break;
      case CashrecycleList.CASHRECYCLE_ROLL_UNIT_50: //単位枚数　50円(0～99)
        rollUnit50 = data;
        break;
      case CashrecycleList.CASHRECYCLE_ROLL_UNIT_10: //単位枚数　10円(0～99)
        rollUnit10 = data;
        break;
      case CashrecycleList.CASHRECYCLE_ROLL_UNIT_5: //単位枚数　5円(0～99)
        rollUnit5 = data;
        break;
      case CashrecycleList.CASHRECYCLE_ROLL_UNIT_1: //単位枚数　1円(0～99)
        rollUnit1 = data;
        break;
      case CashrecycleList.CASHRECYCLE_ALLOT_REF: //充当基準枚数
        allotRef = data;
        break;
      case CashrecycleList
          .CASHRECYCLE_ALLOT_REF_SHT_10000: //充当基準枚数  10000円(0～99)
        allotRefSht10000 = data;
        break;
      case CashrecycleList.CASHRECYCLE_ALLOT_REF_SHT_5000: //充当基準枚数  5000円(0～99)
        allotRefSht5000 = data;
        break;
      case CashrecycleList.CASHRECYCLE_ALLOT_REF_SHT_2000: //充当基準枚数  2000円(0～99)
        allotRefSht2000 = data;
        break;
      case CashrecycleList.CASHRECYCLE_ALLOT_REF_SHT_1000: //充当基準枚数  1000円(0～99)
        allotRefSht1000 = data;
        break;
      case CashrecycleList.CASHRECYCLE_ALLOT_REF_SHT_500: //充当基準枚数  500円(0～99)
        allotRefSht500 = data;
        break;
      case CashrecycleList.CASHRECYCLE_ALLOT_REF_SHT_100: //充当基準枚数  100円(0～99)
        allotRefSht100 = data;
        break;
      case CashrecycleList.CASHRECYCLE_ALLOT_REF_SHT_50: //充当基準枚数  50円(0～99)
        allotRefSht50 = data;
        break;
      case CashrecycleList.CASHRECYCLE_ALLOT_REF_SHT_10: //充当基準枚数  10円(0～99)
        allotRefSht10 = data;
        break;
      case CashrecycleList.CASHRECYCLE_ALLOT_REF_SHT_5: //充当基準枚数  5円(0～99)
        allotRefSht5 = data;
        break;
      case CashrecycleList.CASHRECYCLE_ALLOT_REF_SHT_1: //充当基準枚数  1円(0～99)
        allotRefSht1 = data;
        break;
      case CashrecycleList.CASHRECYCLE_KEEP_SHT: //最低保持枚数
        keepSht = data;
        break;
      case CashrecycleList.CASHRECYCLE_KEEP_SHT_10000: //差分枚数　10000円(0～50)
        keepSht10000 = data;
        break;
      case CashrecycleList.CASHRECYCLE_KEEP_SHT_5000: //差分枚数　5000円(0～99)
        keepSht5000 = data;
        break;
      case CashrecycleList.CASHRECYCLE_KEEP_SHT_2000: //差分枚数　2000円(0～99)
        keepSht2000 = data;
        break;
      case CashrecycleList.CASHRECYCLE_KEEP_SHT_1000: //差分枚数　1000円(0～99)
        keepSht1000 = data;
        break;
      case CashrecycleList.CASHRECYCLE_KEEP_SHT_500: //差分枚数　500円(0～99)
        keepSht500 = data;
        break;
      case CashrecycleList.CASHRECYCLE_KEEP_SHT_100: //差分枚数　100円(0～99)
        keepSht100 = data;
        break;
      case CashrecycleList.CASHRECYCLE_KEEP_SHT_50: //差分枚数　50円(0～99)
        keepSht50 = data;
        break;
      case CashrecycleList.CASHRECYCLE_KEEP_SHT_10: //差分枚数　10円(0～99)
        keepSht10 = data;
        break;
      case CashrecycleList.CASHRECYCLE_KEEP_SHT_5: //差分枚数　5円(0～99)
        keepSht5 = data;
        break;
      case CashrecycleList.CASHRECYCLE_KEEP_SHT_1: //差分枚数　1円(0～99)
        keepSht1 = data;
        break;
      case CashrecycleList.CASHRECYCLE_BTN_SHT_SHOW: //充当レジボタン枚数表示
        btnShtShow = data;
        break;
      case CashrecycleList.CASHRECYCLE_RCP_PRN: //レジ間移動指示レシート印字内容
        rcpPrn = data;
        break;
      case CashrecycleList.CASHRECYCLE_CONF_STAMP_PRN: //確認欄印字
        confStampPrn = data;
        break;
      case CashrecycleList.CASHRECYCLE_STAFF_INPUT: //入金登録操作時従業員入力
        staffInput = data;
        break;
      case CashrecycleList.CASHRECYCLE_REIN_PRN: //再入金指示レシート発行
        reinPrn = data;
        break;
      case CashrecycleList.CASHRECYCLE_CIN_CLCL: //入金取消禁止
        cinCncl = data;
        break;
      case CashrecycleList.CASHRECYCLE_CCHG: //事務所一括時の両替
        cchg = data;
        break;
      case CashrecycleList.CASHRECYCLE_MAN_INOUT: //万券入出金
        manInout = data;
        break;
      default:
        break;
    }
  }
}

/// キャッシュリサイクル管理マスタ
///  関連tprxソース: rxtbl_buff.h - cashrecycle_buff()
enum CashrecycleList {
  CASHRECYCLE_BTN_NONE(-1),
  CASHRECYCLE_BTN_OFTEN_SHOW(1), //釣銭情報ボタン常時表示
  CASHRECYCLE_BTN_COLOR(100), //釣銭情報ボタン色
  CASHRECYCLE_BTN_COLOR_EXIT(150), //釣銭情報あり時ボタン色
  CASHRECYCLE_BTN_COLOR_ALERT(200), //在高異常通知時釣銭情報ボタン色
  CASHRECYCLE_ALLOT_METHOD(300), //充当方法
  CASHRECYCLE_ROLL_UNIT_INOUT(400), //事務所から充当時、単位単位入出金
  CASHRECYCLE_ROLL_UNIT_10000(500), //単位枚数　10000円(0～99)
  CASHRECYCLE_ROLL_UNIT_5000(501), //単位枚数　5000円(0～99)
  CASHRECYCLE_ROLL_UNIT_2000(502), //単位枚数　1000円(0～99)
  CASHRECYCLE_ROLL_UNIT_1000(503), //単位枚数　1000円(0～99)
  CASHRECYCLE_ROLL_UNIT_500(504), //単位枚数　500円(0～99)
  CASHRECYCLE_ROLL_UNIT_100(505), //単位枚数　100円(0～99)
  CASHRECYCLE_ROLL_UNIT_50(506), //単位枚数　50円(0～99)
  CASHRECYCLE_ROLL_UNIT_10(507), //単位枚数　10円(0～99)
  CASHRECYCLE_ROLL_UNIT_5(508), //単位枚数　5円(0～99)
  CASHRECYCLE_ROLL_UNIT_1(509), //単位枚数　1円(0～99)
  CASHRECYCLE_ALLOT_REF(600), //充当基準枚数
  CASHRECYCLE_ALLOT_REF_SHT_10000(700), //充当基準枚数  10000円(0～99)
  CASHRECYCLE_ALLOT_REF_SHT_5000(701), //充当基準枚数  5000円(0～99)
  CASHRECYCLE_ALLOT_REF_SHT_2000(702), //充当基準枚数  2000円(0～99)
  CASHRECYCLE_ALLOT_REF_SHT_1000(703), //充当基準枚数  1000円(0～99)
  CASHRECYCLE_ALLOT_REF_SHT_500(704), //充当基準枚数  500円(0～99)
  CASHRECYCLE_ALLOT_REF_SHT_100(705), //充当基準枚数  100円(0～99)
  CASHRECYCLE_ALLOT_REF_SHT_50(706), //充当基準枚数  50円(0～99)
  CASHRECYCLE_ALLOT_REF_SHT_10(707), //充当基準枚数  10円(0～99)
  CASHRECYCLE_ALLOT_REF_SHT_5(708), //充当基準枚数  5円(0～99)
  CASHRECYCLE_ALLOT_REF_SHT_1(709), //充当基準枚数  1円(0～99)
  CASHRECYCLE_KEEP_SHT(800), //最低保持枚数
  CASHRECYCLE_KEEP_SHT_10000(900), //差分枚数　10000円(0～50)
  CASHRECYCLE_KEEP_SHT_5000(901), //差分枚数　5000円(0～50)
  CASHRECYCLE_KEEP_SHT_2000(902), //差分枚数　2000円(0～50)
  CASHRECYCLE_KEEP_SHT_1000(903), //差分枚数　1000円(0～50)
  CASHRECYCLE_KEEP_SHT_500(904), //差分枚数　500円(0～50)
  CASHRECYCLE_KEEP_SHT_100(905), //差分枚数　100円(0～50)
  CASHRECYCLE_KEEP_SHT_50(906), //差分枚数　50円(0～50)
  CASHRECYCLE_KEEP_SHT_10(907), //差分枚数　10円(0～50)
  CASHRECYCLE_KEEP_SHT_5(908), //差分枚数　5円(0～50)
  CASHRECYCLE_KEEP_SHT_1(909), //差分枚数　1円(0～50)
  CASHRECYCLE_BTN_SHT_SHOW(1000), //充当レジボタン枚数表示
  CASHRECYCLE_RCP_PRN(1100), //レジ間移動指示レシート印字内容
  CASHRECYCLE_CONF_STAMP_PRN(1200), //確認欄印字
  CASHRECYCLE_STAFF_INPUT(1400), //入金登録操作時従業員入力
  CASHRECYCLE_REIN_PRN(1500), //再入金指示レシート発行
  CASHRECYCLE_CIN_CLCL(1600), //入金取消禁止
  CASHRECYCLE_CCHG(1700), //事務所一括時の両替
  CASHRECYCLE_MAN_INOUT(1800); //万券入出金

  final int cd;
  const CashrecycleList(this.cd);

  static CashrecycleList getDefine(int cd) {
    CashrecycleList def = CashrecycleList.values.firstWhere((element) {
      return element.cd == cd;
    }, orElse: () => CashrecycleList.CASHRECYCLE_BTN_NONE);
    return def;
  }
}

///関連tprxソース: rxtbl_buff.h - kopttran_buff
/// 変数を増やす場合はClrKoptTran()にも同様の変数の設定を行うこと
class KopttranBuff{
  int  tranCd = 0;
  int  frcCustCallFlg = 0;  // 会員呼出の強制  0:しない 1:する
  int  stlMinusFlg = 0;    // 小計額マイナス額の操作  0:しない 1:する
  int  frcStlkyFlg = 0;    // 小計キーの使用を強制  0:しない 1:する
  int  stlOverFlg = 0;    // 小計額を越える登録  0:禁止 1:有効 2:確認表示
  int  splitEnbleFlg = 0;  // 小計額未満の登録  0:禁止 1:有効
  int  frcEntryFlg = 0;    // 預り金額の置数強制  0:しない 1:する 2:確定処理 3:券面のみ
  int  mulFlg = 0;    // 乗算登録  0:禁止 1:有効
  int  acbDrwFlg = 0;    // 釣銭機使用時のドロア  0:禁止 1:有効 2:払出エラー時のみ
  int  tranUpdateFlg = 0;  // 実績の在高加算方法  0:通常加算 1:現金加算
  int  crdtEnbleFlg = 0;    // 掛売登録  0:しない 1:する
  int  crdtTyp = 0;    // 掛売の種類
  int  ticketCollectFlg = 0;  // チケット回収  0:しない 1:する
  int  frcStlkyChkrFlg = 0;  // チェッカーの小計キーを強制  0:しない 1:する
  int  digit = 0;      // 置数金額の桁制限
  int  nochgFlg = 0;    // 釣り銭支払  0:あり 1:なし 2:確認表示 3:使用不可
  int  restmpFlg = 0;    // 収入印紙発行  0:する 1:しない
  int  chkAmt = 0;    // 券面金額
  int  cashlessFlg = 0;    // キャッシュレス還元対象　0:非対象 1:対象
  int  cashlessTyp = 0;    // キャッシュレス還元の扱い　0:しない 1:自動還元 2:返品還元
  int  unreadCashTyp = 0;  //未読現金  0：しない  1：する (多慶屋様特注)
  int  campaignDscntOpe = 0;    //割引操作  0：しない  1：する (多慶屋様特注 キャンペーン値引き)
  int  campaignDscntRate = 0;  //割引率 (多慶屋様特注 キャンペーン値引き)
  int  campaignUprlmtAmt = 0;  //上限金額 (多慶屋様特注 キャンペーン値引き)
  int  campaignLowlmtAmt = 0;  //操作下限額 (多慶屋様特注 キャンペーン値引き)
}

///  関連tprxソース: rxtbl_buff.h - SPTEND_PRN_KIND
enum SPTEND_STATUS_LISTS{
  SPTEND_STATUS_SMARTPLUS(4),           // Smartplus
  SPTEND_STATUS_ID(5),                  // iD
  SPTEND_STATUS_PREPAID(6),             // プリペイド
  SPTEND_STATUS_SUICA(7),               // Suica
  SPTEND_STATUS_OFFCREDIT(8),           // オフクレジット
  SPTEND_STATUS_QUICPAY(9),             // QUICPay
  SPTEND_STATUS_PITAPA(10),             // PiTaPa
  SPTEND_STATUS_TUO(11),                // Tuo
  SPTEND_STATUS_NCR_WAON(12),           // Waon(NCR)
  SPTEND_STATUS_NCR_SUICA(13),          // Suica(NCR)
  SPTEND_STATUS_NCR_ID(14),             // iD(NCR)
  SPTEND_STATUS_FCL_VISA(15),           // VisaTouch(FCL)
  SPTEND_STATUS_RESERV(16),             // 予約
  SPTEND_STATUS_GINREN(17),             // 銀聯
  SPTEND_STATUS_MULTI_EDY(18),          // Edy(マルチ)
  SPTEND_STATUS_MULTI_QUICPAY(19),      // QUICPay(マルチ)
  SPTEND_STATUS_MULTI_ID(20),           // iD(マルチ)
  SPTEND_STATUS_WAON(21),               // WAON
  SPTEND_STATUS_NANACO(22),             // nanaco
  SPTEND_STATUS_EMONEY(23),             // 電子マネー
  SPTEND_STATUS_CHOICE(24),             // 端末で選択
  SPTEND_STATUS_MULTI_PITAPA(25),       // PiTaPa(マルチ)
  SPTEND_STATUS_MULTI_SUICA(26),        // 交通系(マルチ)
  SPTEND_STATUS_URIKAKE(27),            // 売掛伝票
  SPTEND_STATUS_RESERV_CREDIT(28),      // 予約（売掛)
  SPTEND_STATUS_RESERV_DELIVERY(29),    // 予約(配達)
  SPTEND_STATUS_RESERV_ESTIMATE(30),    // 予約(見積り)
  SPTEND_STATUS_REPICA(37),             // レピカ
  SPTEND_STATUS_PRECAPNT(39),           // レピカポイント
  SPTEND_STATUS_EMPLOYEE_CARD(40),      // 社員証
  SPTEND_STATUS_PREPAID2(41),           // プリペイド2
  SPTEND_STATUS_COCONA(42),             // cocona
  SPTEND_STATUS_WAONP(43),              // WAON POINT
  SPTEND_STATUS_GIFT_CARD(44),          // ギフトカード
  SPTEND_STATUS_AEON_TCKT(45),          // イオクレお買物券
  SPTEND_STATUS_DGTL_TCKT(46),          // デジタルお買物券
  SPTEND_STATUS_TOMOCARD(47),           // 友の会カード
  SPTEND_STATUS_SP_TCKT(48);            // 特殊商品券

  final int typeCd;
  const SPTEND_STATUS_LISTS(this.typeCd);
}

///  関連tprxソース:rxtbl_buff.h - REC_MTHD_FLG_LIST
enum REC_MTHD_FLG_LIST{
  PLU_REC(1),	// PLUレコード
  JAN_REC(2),	// JANレコード
  SMCLS_REC(3),	// 小分類レコード
  OUT_MDLCLS_REC(4), 	// 部門外商品レコード
  STLDSC_REC(5),	// 小計値引レコード
  STLPDSC_REC(6),	// 小計割引レコード
  MBRRBT_REC(7),	// 割戻入力操作レコード
  BTLTAX_REC(8),	// 返瓶商品（税対象減算せず）
  BTLMG_REC(9),	// 返瓶MG商品（税対象減算する）
  BTLNOTAX_REC(10),	// 返瓶商品（税対象減算する）
  DROWER_REC(11),	// ドロアー入力レコード
  STAMP_REC(12),	// スタンプ入力レコード
  MDLCLS_REC(16),	// 中分類キーレコード
  MDLCLS_OUT_REC(18),	// 中分類部門外商品レコード
  LRGCLS_REC(19),	// 大分類キーレコード
  LRGCLS_OUT_REC(20),	// 大分類部門外商品レコード
  CATALINA_REC(21),	// カタリナクーポンレコード
  //#if SALELMT_BAR
  SALELMTOVER_REC(22),	// 販売期限切れ商品レコード
  //#endif
  NONFILE_REC(23),	// Nonファイル商品レコード
  COUPONCASH_RE(24),	// クーポン商品券レコード
  NOTE_REC_CHA1(25),	// 金種商品（会計1）レコード
  NOTE_REC_CHA2(26),	// 金種商品（会計2）レコード
  NOTE_REC_CHA3(27),	// 金種商品（会計3）レコード
  NOTE_REC_CHA4(28),	// 金種商品（会計4）レコード
  NOTE_REC_CHA5(29),	// 金種商品（会計5）レコード
  NOTE_REC_CHA6(30),	// 金種商品（会計6）レコード
  NOTE_REC_CHA7(31),	// 金種商品（会計7）レコード
  NOTE_REC_CHA8(32),	// 金種商品（会計8）レコード
  NOTE_REC_CHA9(33),	// 金種商品（会計9）レコード
  NOTE_REC_CHA10(34),	// 金種商品（会計10）レコード
  NOTE_REC_CHK1(35),	// 金種商品（品券1）レコード
  NOTE_REC_CHK2(36),	// 金種商品（品券2）レコード
  NOTE_REC_CHK3(37),	// 金種商品（品券3）レコード
  NOTE_REC_CHK4(38),	// 金種商品（品券4）レコード
  NOTE_REC_CHK5(39),	// 金種商品（品券5）レコード
  CATALINA_STLDSC_REC(40),	// カタリナ小計値引レコード
  CATALINA_STLPDSC_REC(41),	// カタリナ小計割引レコード
  BARCODE_STLDSC_REC(42),	// バーコード小計値引レコード
  BARCODE_STLPDSC_REC(43),	// バーコード小計割引レコード
  TCOUPON_REC(44),	// Tクーポンレコード
  HINKEN_BAR_REC(45),	// 品券バーコード用レコード（紅屋商事様）
  BARCODE_MEMBER_STLPDSC_REC(46),// バーコード小計割引レコード
  PBCHG_REC(50),	// 収納代行レコード
  PBCHG_FEE1_REC(51),	// 収納代行手数料1レコード
  PBCHG_FEE2_REC(52),	// 収納代行手数料2レコード
  BC_TICKET_REC(60),	// BC券商品レコード
  NOTE_REC_CHA11(70),	// 金種商品（会計11）レコード
  NOTE_REC_CHA12(71),	// 金種商品（会計12）レコード
  NOTE_REC_CHA13(72),	// 金種商品（会計13）レコード
  NOTE_REC_CHA14(73),	// 金種商品（会計14）レコード
  NOTE_REC_CHA15(74),	// 金種商品（会計15）レコード
  NOTE_REC_CHA16(75),	// 金種商品（会計16）レコード
  NOTE_REC_CHA17(76),	// 金種商品（会計17）レコード
  NOTE_REC_CHA18(77),	// 金種商品（会計18）レコード
  NOTE_REC_CHA19(78),	// 金種商品（会計19）レコード
  NOTE_REC_CHA20(79),	// 金種商品（会計20）レコード
  NOTE_REC_CHA21(80),	// 金種商品（会計21）レコード
  NOTE_REC_CHA22(81),	// 金種商品（会計22）レコード
  NOTE_REC_CHA23(82),	// 金種商品（会計23）レコード
  NOTE_REC_CHA24(83),	// 金種商品（会計24）レコード
  NOTE_REC_CHA25(84),	// 金種商品（会計25）レコード
  NOTE_REC_CHA26(85),	// 金種商品（会計26）レコード
  NOTE_REC_CHA27(86),	// 金種商品（会計27）レコード
  NOTE_REC_CHA28(87),	// 金種商品（会計28）レコード
  NOTE_REC_CHA29(88),	// 金種商品（会計29）レコード
  NOTE_REC_CHA30(89),	// 金種商品（会計30）レコード
  TAIYO_REC_COUPON_POINT(90),	// クーポン券レコード（タイヨー様）
  TAIYO_REC_TICKET_COUPON(91),	// クーポン券レコード（タイヨー様）
  TAIYO_REC_KYOSAN_COUPON(92),	// クーポン券レコード（タイヨー様）
  TAIYO_REC_POINT_TICKET(93),	// クーポン券レコード（タイヨー様）
  TAIYO_REC_COUPON_TICKET(94),	// クーポン券レコード（タイヨー様）
  TAIYO_REC_FINE_COUPON(95),	// クーポン券レコード（タイヨー様）
  TAIYO_REC_RAIN_COUPON(96),	// クーポン券レコード（タイヨー様）
  ZFSP_POINT_REC(97),	// 生鮮ZFSPポイントレコード
  ONETOONE_BARCODE_REC(98);	// One to One バーコードレコード

  final int typeCd;
  const REC_MTHD_FLG_LIST(this.typeCd);
}

// スプリットテンダリング印紙タイプ
enum SPTEND_PRN_KIND{
  SPTEND_PRN_KIND_NOSET(0),	// セット無し
  SPTEND_PRN_KIND_CASH(1),	// 現金
  SPTEND_PRN_KIND_PNTDSC(2),	// ポイント
  SPTEND_PRN_KIND_CRDT(3),	// クレジット
  SPTEND_PRN_KIND_OTHER(4),	// その他
  SPTEND_PRN_KIND_MAX(5);

  final int typeCd;
  const SPTEND_PRN_KIND(this.typeCd);
}

// スプリットテンダリング会計タイプ
enum SPTEND_KIND_LISTS{
  SPTEND_KIND_CASH(1),		// 手動現金
  SPTEND_KIND_NO_CHA(2),		// 掛売なし(品券または会計の掛売タイプがしない)
  SPTEND_KIND_CHARGE(3),		// 掛売
  SPTEND_KIND_ACX(4),		// 釣機現金
  SPTEND_KIND_ACX_MANUAL(5);	// 釣機あり時の手動現金

  final int typeCd;
  const SPTEND_KIND_LISTS(this.typeCd);
}

// 印紙申告課税限度額判断
enum KEY_RFM_LIMIT_LIST {
  KEY_RFM_LIMIT_TAX_OFF(0),	// 税抜
  KEY_RFM_LIMIT_ALL(1);		// 額面

  final int value;
  const KEY_RFM_LIMIT_LIST(this.value);
}

//***************************************************************************************************
//	自動開閉店情報  格納構造体
//***************************************************************************************************
///  関連tprxソース: rxtbl_buff.h - stropncls_buff
class StrOpnClsBuf {
  int stropn_auto = 0;
  int stropn_wait_time = 0;
  int stropn_checker_login = 0;
  int stropn_cashier_login = 0;
  int stropn_chgloan = 0;
  int stropn_chgref = 0;
  int stropn_drwchk = 0;
  int stropn_drwchk_print = 0;
  int strcls_auto = 0;
  int strcls_manal = 0;
  int strcls_passwd = 0;
  int strcls_acx_rcalc = 0;
  int strcls_recal_repo = 0;
  int strcls_repo = 0;
  int strcls_repo_sel1 = 0;
  int strcls_repo_sel2 = 0;
  int strcls_repo_sel3 = 0;
  int strcls_repo_sel4 = 0;
  int strcls_repo_sel5 = 0;
  int strcls_repo_sel6 = 0;
  int strcls_repo_sel7 = 0;
  int strcls_repo_sel8 = 0;
  int strcls_repo_sel9 = 0;
  int strcls_repo_auto = 0;
  int strcls_cashier_login = 0;
  int strcls_acx_overflow_mente = 0;
  int strcls_acx_overflow_mente_print = 0;
  int strcls_acx_overflow_mente_cin = 0;
  int strcls_drwchk = 0;
  int strcls_drwchk_print = 0;
  int strcls_pick = 0;
  int strcls_pick_bill = 0;
  int strcls_pick_coin = 0;
  int strcls_pick_other = 0;
  int strcls_pick_chgbill = 0;
  int strcls_pick_chgcoin = 0;
  int strcls_close_pick = 0;
  int strcls_pick_auto = 0;
  int strcls_pick_print = 0;
  int strcls_cash_recycle = 0;
  int strcls_cpick = 0;
  int strcls_cpick_skip = 0;
  int strcls_cpick_print = 0;
  int strcls_cpick_coin_positn = 0;
  int strcls_repo_after = 0;
  int strcls_repo_after_sel1 = 0;
  int strcls_repo_after_sel2 = 0;
  int strcls_repo_after_sel3 = 0;
  int strcls_repo_after_sel4 = 0;
  int strcls_repo_after_sel5 = 0;
  int strcls_repo_after_sel6 = 0;
  int strcls_repo_after_sel7 = 0;
  int strcls_repo_after_sel8 = 0;
  int strcls_repo_after_sel9 = 0;
  int strcls_repo_after_auto = 0;
  int strcls_end_repo = 0;
  int strcls_wait_time = 0;
  int strcls_time_sel = 0;
  int strcls_acx_rcalc_g = 0;
  int stropncls_manual = 0;		//開閉設手動操作
  int strcls_dlg_time = 0;		//アシストモニター精算業務指示ダイアログの表示時間
  int forcestrcls_wait = 0;		//強制閉設ダイアログの表示時間(1〜99分)
  int forcestrcls_limit = 0;		//強制閉設複数回実行
}

///  関連tprxソース: rxtbl_buff.h - STROPNCLS_CODE_LIST
enum StrOpnClsCodeList {
  STROPN_AUTO(1),		//開店準備自動化
  STROPN_WAIT_TIME(100),		//開店処理実行の待ち時間
  STROPN_CHECKER_LOGIN(200),	//開店時チェッカー従業員のログイン
  STROPN_CASHIER_LOGIN(300),	//開店時キャッシャー従業員のログイン
  STROPN_CHGLOAN(400),		//釣準備
  STROPN_CHGREF(500),		//釣参照
  STROPN_DRWCHK(600),		//開店差異チェック
  STROPN_DRWCHK_PRINT(700),	//開店差異チェックレポート印字
  STRCLS_AUTO(800),		//精算業務
  STRCLS_CHKDLG_TIME(810),	//アシストモニター精算業務指示ダイアログの表示時間
  STRCLS_MANAL(900),		//精算単体実行
  STRCLS_PASSWD(1000),		//精算業務ボタン押下時パスワード入力
  STRCLS_ACX_RCALC(1100),	//在高確定時の釣機再精査(ECS接続時のみ)
  STRCLS_RECAL_REPO(1200),	//釣機再精査レポート印字
  STRCLS_ACX_RCALC_G(1250),	//RT-300釣機在高不確定解除処理
  STRCLS_REPO(1300),		//精算前予約レポート印字
  STRCLS_REPO_SEL1(1400),	//精算前出力予約レポート１
  STRCLS_REPO_SEL2(1500),	//精算前出力予約レポート2
  STRCLS_REPO_SEL3(1600),	//精算前出力予約レポート3
  STRCLS_REPO_SEL4(1700),	//精算前出力予約レポート4
  STRCLS_REPO_SEL5(1800),	//精算前出力予約レポート5
  STRCLS_REPO_SEL6(1900),	//精算前出力予約レポート6
  STRCLS_REPO_SEL7(2000),	//精算前出力予約レポート7
  STRCLS_REPO_SEL8(2100),	//精算前出力予約レポート8
  STRCLS_REPO_SEL9(2200),	//精算前出力予約レポート9
  STRCLS_REPO_AUTO(2300),	//精算前予約レポート自動発行
  STRCLS_CASHIER_LOGIN(2350),	//精算時キャッシャー従業員のログイン
  STRCLS_OVERFLOW_MENTE(2370),	//ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ
  STRCLS_OVERFLOW_MENTE_PRINT(2371),	//ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ印字
  STRCLS_OVERFLOW_MENTE_CIN(2372),	//ｵｰﾊﾞｰﾌﾛｰ庫硬貨が釣銭機に収納可能な場合は補充
  STRCLS_DRWCHK(2400),		//精算差異チェック
  STRCLS_DRWCHK_PRINT(2500),	//精算差異チェックレポート印字
  STRCLS_PICK(2600),		//売上回収
  STRCLS_PICK_BILL(2700),	//差異チェックから売上回収に引継ぐデータ（ドロア紙幣）
  STRCLS_PICK_COIN(2800),	//差異チェックから売上回収に引継ぐデータ（ドロア硬貨）
  STRCLS_PICK_OTHER(2900),	//差異チェックから売上回収に引継ぐデータ（品券／会計）
  STRCLS_PICK_CHGBILL(3000),	//差異チェックから売上回収に引継ぐデータ（釣機紙幣）
  STRCLS_PICK_CHGCOIN(3100),	//差異チェックから売上回収に引継ぐデータ（釣機硬貨）
  STRCLS_CLOSE_PICK(3150),	//従業員精算処理
  STRCLS_PICK_AUTO(3200),	//差異チェックデータ引継ぐ時売上回収自動実行
  STRCLS_PICK_PRINT(3300),	//売上回収レポート印字
  STRCLS_CASH_RECYCLE(3400),	//上位サーバー接続時キャッシュリサイクル実行
  STRCLS_CPICK(3500),		//釣機回収
  STRCLS_CPICK_SKIP(3550),	//釣機回収スキップ操作
  STRCLS_CPICK_PRINT(3600),	//釣機回収レポート印字
  STRCLS_CPICK_COIN_POSITN(3650),	//釣機回収硬貨搬送先
  STRCLS_REPO_AFTER(3700),	//精算後予約レポート印字
  STRCLS_REPO_AFTER_SEL1(3800),	//精算後出力予約レポート１
  STRCLS_REPO_AFTER_SEL2(3900),	//精算後出力予約レポート２
  STRCLS_REPO_AFTER_SEL3(4000),	//精算後出力予約レポート３
  STRCLS_REPO_AFTER_SEL4(4100),	//精算後出力予約レポート４
  STRCLS_REPO_AFTER_SEL5(4200),	//精算後出力予約レポート５
  STRCLS_REPO_AFTER_SEL6(4300),	//精算後出力予約レポート６
  STRCLS_REPO_AFTER_SEL7(4400),	//精算後出力予約レポート７
  STRCLS_REPO_AFTER_SEL8(4500),	//精算後出力予約レポート８
  STRCLS_REPO_AFTER_SEL9(4600),	//精算後出力予約レポート９
  STRCLS_REPO_AFTER_AUTO(4700),	//精算後予約レポート自動発行
  STRCLS_END_REPO(4800),		//閉設時精算レポート出力
  STRCLS_WAIT_TIME(4900),	//閉設処理実行の待ち時間（１～10分） 0:手動
  STRCLS_TIME_SEL(5000),		//閉設処理実行時間 0:待ち時間　1：指定時刻
  STRCLSOPNCLS_MANUAL(10000),	//開閉設手動操作
  FORCESTRCLS_WAIT(20000),	//強制閉設ダイアログの表示時間(1〜99分)
  FORCESTRCLS_LIMIT(21000);	//強制閉設複数回実行

  final int value;
  const StrOpnClsCodeList(this.value);
}

/// テンプレートID
///  関連tprxソース: rxtbl_buff.h - CPNREPRN_TEMPLATE_*
class CpnRePrnTemp {
  // テンプレートID
  static const STD = "0";
  static const DRAWTCKT_GODAI = "1";
  static const TCOUPON_BITMAP = "2";
  static const STD_BITMAP = "3";
  static const POINTTCKT_FRESTA = "4";

  static const SERVICE = "10010";
  static const BITMAP = "10020";
  static const MAKER = "10030";
  static const SURVEY = "10040";
  static const FRESH = "10050";
  static const QUITSTOP = "10051";	// 離反防止クーポン

// ワールドスポーツ様用テンプレートID
  static const CPNPIC_PC = "1001";
  static const CPNPIC_POS = "1002";
  static const LOTTCKT_PC = "1003";
  static const LOTTCKT_POS = "1004";
}

// プロモーションの対象顧客
///  関連tprxソース: rxtbl_buff.h - LOY_TGTCUST_TYPE
enum LoyTgtCustType {
  ONE,	// 指定会員
  MBR,	// 会員全て
  ALL,	// 会員以外をふくめ全て
  BCD_ONE,	// 指定会員(バーコード)
  BCD_MBR,	// 会員全て(バーコード)
  BCD_ALL,	// 会員以外をふくめ全て(バーコード)
}


//***************************************************************************************************
//	One to One プロモーション用
//***************************************************************************************************
/// 固定アカウント番号
///  関連tprxソース: rxtbl_buff.h - enum ACCT_FIX_CODE_LIST
enum AcctFixCodeList {
  ACCT_CODE_BASIC_PNT(100),  // 基本ポイント
  ACCT_CODE_BASIC_PNT_R(101),  // 基本ポイント(楽天ポイント用)
  ACCT_CODE_BASIC_PNT_T(102),  // 基本ポイント(Tポイント用)
  ACCT_CODE_BASIC_PNT_D(103),  // 基本ポイント(dポイント用)
  ACCT_CODE_MM_PNT(210),  // ミックスマッチ加算ポイント
  ACCT_CODE_MONTH_AMT(300),  // 月間累計購買金額
  ACCT_CODE_TARGET_AMT_R(301),  // ポイント対象額(楽天ポイント用)
  ACCT_CODE_TARGET_AMT_T(302),  // ポイント対象額(Tポイント用)
  ACCT_CODE_TARGET_AMT_D(303),  // ポイント対象額(dポイント用)
  ACCT_CODE_TODAY_PNT(800),  // 本日累計ポイント
  ACCT_CODE_TODAY_PNT_R(801),  // 本日累計ポイント(楽天ポイント用)
  ACCT_CODE_TODAY_PNT_T(802),  // 本日累計ポイント(Tポイント用)
  ACCT_CODE_TODAY_PNT_D(803),  // 本日累計ポイント(dポイント用)
  ACCT_CODE_TOTAL_AMT(2000);  // ボーナスポイント

  final int value;
  const AcctFixCodeList(this.value);
}

/// アカウント集計タイプ
///  関連tprxソース: rxtbl_buff.h - enum ACCT_ADD_TYPE_LIST
enum AcctAddTypeList {
  ACCT_ADD_TYPE_NONE, // 何もしない
  ACCT_ADD_TYPE_PNT, // ポイント加算
  ACCT_ADD_TYPE_AMT, // 金額加算
  ACCT_ADD_TYPE_QTY, // 個数加算
}

/// 外部会員サーバー接続タイプ
///  関連tprxソース: rxtbl_buff.h - enum EXT_MBR_SVR_TYP
enum ExtMbrSvrTyp {
  EXT_MBR_SVR_NA,		// 外部会員サーバー接続しない
  EXT_MBR_SVR_U1,			// 特定ユーザー1
  EXT_MBR_SVR_CRM,		// 寺岡CRM
}