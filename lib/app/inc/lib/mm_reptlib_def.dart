/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../../../postgres_library/src/pos_basic_table_access.dart';

/// レポートNo.
/// 関連tprxソース:mm_reptlib.h - Repotnumber
enum ReptNumber {
  NONE(MmReptlibDef.MMREPT00NM),
  MMREPT01(MmReptlibDef.MMREPT01NM),						/* 取引明細 */
  MMREPT02(MmReptlibDef.MMREPT02NM), 						/* 売計キー */
  MMREPT03(MmReptlibDef.MMREPT03NM), 						/* 入出金 */
  MMREPT04(MmReptlibDef.MMREPT04NM), 						/* 在高 */
  MMREPT05(MmReptlibDef.MMREPT05NM), 						/* 従業員別取引明細 */
  MMREPT06(MmReptlibDef.MMREPT06NM), 						/* レジ別釣り銭明細 */
  MMREPT07(MmReptlibDef.MMREPT07NM), 						/* 中分類別売上 */
  MMREPT08(MmReptlibDef.MMREPT08NM), 						/* 中分類別金額順売上 */
  MMREPT09(MmReptlibDef.MMREPT09NM), 						/* 中分類別粗利順売上 */
  MMREPT10(MmReptlibDef.MMREPT10NM), 						/* 小分類別売上 */
  MMREPT11(MmReptlibDef.MMREPT11NM), 						/* 小分類別金額順売上 */
  MMREPT12(MmReptlibDef.MMREPT12NM), 						/* 小分類別粗利順売上 */
  MMREPT13(MmReptlibDef.MMREPT13NM), 						/* 店舗時間帯 */
  MMREPT14(MmReptlibDef.MMREPT14NM), 						/* 中分類別時間帯 */
  MMREPT15(MmReptlibDef.MMREPT15NM), 						/* 小分類別時間帯 */
  MMREPT16(MmReptlibDef.MMREPT16NM), 						/* ＰＬＵ別時間帯 */
  MMREPT17(MmReptlibDef.MMREPT17NM), 						/* ＰＬＵ別売上 */
  MMREPT18(MmReptlibDef.MMREPT18NM), 						/* ＰＬＵ別金額順売上（小分類毎） */
  MMREPT19(MmReptlibDef.MMREPT19NM), 						/* ＰＬＵ別数量順売上（小分類毎） */
  MMREPT20(MmReptlibDef.MMREPT20NM), 						/* ＰＬＵ別金額順売上（カテゴリー毎） */
  MMREPT21(MmReptlibDef.MMREPT21NM), 						/* ＰＬＵ別数量順売上（カテゴリー毎） */
  MMREPT22(MmReptlibDef.MMREPT22NM), 						/* ＰＬＵ別値下売上 */
  MMREPT23(MmReptlibDef.MMREPT23NM), 						/* スケジュール別特売 */
  MMREPT24(MmReptlibDef.MMREPT24NM), 						/* ミックスマッチ */
  MMREPT25(MmReptlibDef.MMREPT25NM), 						/* セットマッチ */
  MMREPT26(MmReptlibDef.MMREPT26NM), 						/* カテゴリー */
  MMREPT27(MmReptlibDef.MMREPT27NM), 						/* 緊急メンテナンス */
  MMREPT28(MmReptlibDef.MMREPT28NM), 						/* ノンアクト商品 */
  MMREPT29(MmReptlibDef.MMREPT29NM), 						/* 商品台帳 */
  MMREPT30(MmReptlibDef.MMREPT30NM), 						/* セルフ時間帯 */
  MMREPT31(MmReptlibDef.MMREPT31NM), 						/* セルフ稼働時間 */
  MMREPT32(MmReptlibDef.MMREPT32NM), 						/* 再精査 */
  MMREPT33(MmReptlibDef.MMREPT33NM), 						/* 途中精算 */
  MMREPT34(MmReptlibDef.MMREPT34NM), 						/* 精算情報レポート */
  MMREPT35(MmReptlibDef.MMREPT35NM), 						/* レジ途中取引明細 */
  MMREPT36(MmReptlibDef.MMREPT36NM), 						/* 会計別税明細 */
  MMREPT37(MmReptlibDef.MMREPT37NM), 						/* 精算レポート WS様向け */
  MMREPT38(MmReptlibDef.MMREPT38NM),
  MMREPT39(MmReptlibDef.MMREPT39NM),
  MMREPT40(MmReptlibDef.MMREPT40NM), 						/* 会員合計 */
  MMREPT41(MmReptlibDef.MMREPT41NM), 						/* 地区 */
  MMREPT42(MmReptlibDef.MMREPT42NM), 						/* サービス分類 */
  MMREPT43(MmReptlibDef.MMREPT43NM), 						/* ＦＳＰ 合計 */
  MMREPT44(MmReptlibDef.MMREPT44NM), 						/* ＦＳＰ 中分類 */
  MMREPT45(MmReptlibDef.MMREPT45NM), 						/* ＦＳＰ 小分類 */
  MMREPT46(MmReptlibDef.MMREPT46NM), 						/* ＦＳＰ ＰＬＵ */
  MMREPT47(MmReptlibDef.MMREPT47NM), 						/* 買上ゼロ */
  MMREPT48(MmReptlibDef.MMREPT48NM), 						/* 記念日 */
  MMREPT49(MmReptlibDef.MMREPT49NM), 						/* 会員売価商品 */
  MMREPT50(MmReptlibDef.MMREPT50NM), 						/* 会員金額 */
  MMREPT51(MmReptlibDef.MMREPT51NM), 						/* 会員累計ポイント */
  MMREPT52(MmReptlibDef.MMREPT52NM), 						/* 会員可能ポイント */
  MMREPT53(MmReptlibDef.MMREPT53NM), 						/* 会員来店回数 */
  MMREPT54(MmReptlibDef.MMREPT54NM), 						/* 会員最終来店日付 */
  MMREPT55(MmReptlibDef.MMREPT55NM), 						/* 会員利用ポイント */
  MMREPT56(MmReptlibDef.MMREPT56NM), 						/* ＦＳＰ期間対象 */
  MMREPT57(MmReptlibDef.MMREPT57NM), 						/* ＦＳＰレベル別 */
  MMREPT58(MmReptlibDef.MMREPT58NM), 						/* 会員情報 */
  MMREPT59(MmReptlibDef.MMREPT59NM), 						/* 会員台帳 */
  MMREPT60(MmReptlibDef.MMREPT60NM), 						/* 一括(特定百貨店専用レポート) */
  MMREPT61(MmReptlibDef.MMREPT61NM),
  MMREPT62(MmReptlibDef.MMREPT62NM),
  MMREPT63(MmReptlibDef.MMREPT63NM),
  MMREPT64(MmReptlibDef.MMREPT64NM),
  MMREPT65(MmReptlibDef.MMREPT65NM),
  MMREPT66(MmReptlibDef.MMREPT66NM),
  MMREPT67(MmReptlibDef.MMREPT67NM),
  MMREPT68(MmReptlibDef.MMREPT68NM), 						/* 釣機入金再印字 */ //TODO:v12v14と番号が異なる(MMREPT88→MMREPT68)
  MMREPT69(MmReptlibDef.MMREPT69NM), 						/* 釣機払出再印字 */ //TODO:v12v14と番号が異なる(MMREPT89→MMREPT69)
  MMREPT70(MmReptlibDef.MMREPT70NM), 						/* 大分類別売上 */
  MMREPT71(MmReptlibDef.MMREPT71NM), 						/* クラス別売上 */
  MMREPT72(MmReptlibDef.MMREPT72NM), 						/* 売上商品バーコード印字 */
  MMREPT73(MmReptlibDef.MMREPT73NM), 						/* LAWSON 取引明細 */
  MMREPT74(MmReptlibDef.MMREPT74NM), 						/* LAWSON ＤＥＰＴ */
  MMREPT75(MmReptlibDef.MMREPT75NM), 						/* LAWSON ＣＬＡＳＳ */
  MMREPT76(MmReptlibDef.MMREPT76NM), 						/* お会計券未精算 */
  MMREPT77(MmReptlibDef.MMREPT77NM), 						/* 稼動時間帯 */
  MMREPT78(MmReptlibDef.MMREPT78NM), 						/* リサイクル入出金明細 */
  MMREPT79(MmReptlibDef.MMREPT79NM), 						/* リサイクル入出金履歴 */
  MMREPT80(MmReptlibDef.MMREPT80NM), 						/* ＦＳＰレベル決定 */
  MMREPT81(MmReptlibDef.MMREPT81NM), 						/* 確定ポイント割戻 */
  MMREPT82(MmReptlibDef.MMREPT82NM), 						/* 預り釣銭払出し */
  MMREPT83(MmReptlibDef.MMREPT83NM), 						/* カード切替 */
  MMREPT84(MmReptlibDef.MMREPT84NM), 						/* 顧客抽出 */
  MMREPT85(MmReptlibDef.MMREPT85NM), 						/* 従業員別入出金レポート */
  MMREPT86(MmReptlibDef.MMREPT86NM), 						/* 従業員別入出金履歴レポート */
  MMREPT87(MmReptlibDef.MMREPT87NM), 						/* 入出金結果 */
  MMREPT88(MmReptlibDef.MMREPT88NM), 						/* レジ従業員精算 */
  MMREPT89(MmReptlibDef.MMREPT89NM),
  MMREPT90(MmReptlibDef.MMREPT90NM), 						/* 従業員別簡易取引明細 *//* only TW */
  MMREPT91(MmReptlibDef.MMREPT91NM), 						/* メディア情報 */
  MMREPT92(MmReptlibDef.MMREPT92NM), 						/* クレジット控え */
  MMREPT93(MmReptlibDef.MMREPT93NM), 						/* シベール日計レポート */
  MMREPT94(MmReptlibDef.MMREPT94NM), 						/* クレジット会社別 */
  MMREPT95(MmReptlibDef.MMREPT95NM), 						/* 領収書控え */
  MMREPT96(MmReptlibDef.MMREPT96NM),
  MMREPT97(MmReptlibDef.MMREPT97NM),
  MMREPT98(MmReptlibDef.MMREPT98NM), 						/* 日計クリア */
  MMREPT99(MmReptlibDef.MMREPT99NM), 						/* 累計クリア */
  MMREPT100(MmReptlibDef.MMREPT100NM),
  MMREPT101(MmReptlibDef.MMREPT101NM), 					/* 顧客問い合わせテーブルクリア */
  MMREPT102(MmReptlibDef.MMREPT102NM), 					/* 顧客関連再生 */
  MMREPT103(MmReptlibDef.MMREPT103NM), 					/* 釣銭カード再発行 */
  MMREPT104(MmReptlibDef.MMREPT104NM), 					/* 釣銭カード修正 */
  MMREPT105(MmReptlibDef.MMREPT105NM), 					/* 釣銭額メンテナンス */
  MMREPT106(MmReptlibDef.MMREPT106NM), 					/* へそくり額メンテナンス */
  MMREPT107(MmReptlibDef.MMREPT107NM), 					/* 顧客自動生成 */
  MMREPT108(MmReptlibDef.MMREPT108NM), 					/* 会員番号変更 */
  MMREPT109(MmReptlibDef.MMREPT109NM), 					/* 画像変換 */
  MMREPT110(MmReptlibDef.MMREPT110NM), 					/* リライトカード再発行 */
  MMREPT111(MmReptlibDef.MMREPT111NM), 					/* 画像削除 */
  MMREPT112(MmReptlibDef.MMREPT112NM), 					/* 画像調整 */
  MMREPT113(MmReptlibDef.MMREPT113NM), 					/* 初期画像入替 */
  MMREPT114(MmReptlibDef.MMREPT114NM), 					/* 画像読込 */
  MMREPT115(MmReptlibDef.MMREPT115NM), 					/* テキストデータ保存 */
  MMREPT116(MmReptlibDef.MMREPT116NM),          /* テキストデータ再送信 */
  MMREPT117(MmReptlibDef.MMREPT117NM),          /* テキストデータ訂正送信 */
  MMREPT118(MmReptlibDef.MMREPT118NM), 					/* 強制Ｅｄｙログ送信 */
  MMREPT119(MmReptlibDef.MMREPT119NM), 					/* ポイント追加処理 */
  MMREPT120(MmReptlibDef.MMREPT120NM), 					/* 発券処理 */
  MMREPT121(MmReptlibDef.MMREPT121NM), 					/* 税種変更 */
  MMREPT122(MmReptlibDef.MMREPT122NM), 					/* テキストデータ読込 */
  MMREPT123(MmReptlibDef.MMREPT123NM), 					/* テキストデータ読込(12結果) */
  MMREPT124(MmReptlibDef.MMREPT124NM), 					/* テキストデータ再生 */
  MMREPT125(MmReptlibDef.MMREPT125NM), 					/* プリンタ待ちジョブ削除 */
  MMREPT126(MmReptlibDef.MMREPT126NM), 					/* 売価変更 */
  MMREPT127(MmReptlibDef.MMREPT127NM), 					/* 画像ＣＤ作成 */
  MMREPT128(MmReptlibDef.MMREPT128NM), 					/* 強制Ｍカード実績ログ */
  MMREPT129(MmReptlibDef.MMREPT129NM), 					/* 税種変更 テキストデータ復帰 */
  MMREPT130(MmReptlibDef.MMREPT130NM), 					/* NON-PLU税種変更 */
  MMREPT131(MmReptlibDef.MMREPT131NM), 					/* クローズレポート */
  MMREPT132(MmReptlibDef.MMREPT132NM), 					/* 現在売価 */
  MMREPT133(MmReptlibDef.MMREPT133NM), 					/* レシートメッセージスケジュール */
  MMREPT134(MmReptlibDef.MMREPT134NM), 					/* ビスマックカード復帰*/
  MMREPT135(MmReptlibDef.MMREPT135NM), 					/* 生産者バーコード自動設定 */
  MMREPT136(MmReptlibDef.MMREPT136NM), 					/* 生産者バーコード自動削除 */
  MMREPT137(MmReptlibDef.MMREPT137NM), 					/* Edy初期通信(13テストモード) */
  MMREPT138(MmReptlibDef.MMREPT138NM), 					/* 顧客情報データクリア */
  MMREPT139(MmReptlibDef.MMREPT139NM), 					/* 顧客マスタ */
  MMREPT140(MmReptlibDef.MMREPT140NM), 					/* 従業員マスタ */
  MMREPT141(MmReptlibDef.MMREPT141NM), 					/* バックアップデータ保存 */
  MMREPT142(MmReptlibDef.MMREPT142NM), 					/* 実績ログバックアップ */
  MMREPT143(MmReptlibDef.MMREPT143NM), 					/* ログバックアップ */
  MMREPT144(MmReptlibDef.MMREPT144NM), 					/* 記録確認 */
  MMREPT145(MmReptlibDef.MMREPT145NM), 					/* リライトカード復旧 */
  MMREPT146(MmReptlibDef.MMREPT146NM), 					/* 生産者一括設定 */
  MMREPT147(MmReptlibDef.MMREPT147NM), 					/* バックアップＣＤ再作成 */
  MMREPT148(MmReptlibDef.MMREPT148NM), 					/* クイック設定 */
  MMREPT149(MmReptlibDef.MMREPT149NM), 					/* クイック顧客設定 */
  MMREPT150(MmReptlibDef.MMREPT150NM), 					/* クイックセットアップ */
  MMREPT151(MmReptlibDef.MMREPT151NM), 					/* クイック設定 累計クリア */
  MMREPT152(MmReptlibDef.MMREPT152NM), 					/* ノンアクト商品 商品マスタ復帰 */
  MMREPT153(MmReptlibDef.MMREPT153NM), 					/* 日付＆時刻 */
  MMREPT154(MmReptlibDef.MMREPT154NM), 					/* オートセットアップ */
  MMREPT155(MmReptlibDef.MMREPT155NM), 					/* 周辺装置 */
  MMREPT156(MmReptlibDef.MMREPT156NM), 					/* ＳＩＯ */
  MMREPT157(MmReptlibDef.MMREPT157NM), 					/* 勤怠  */
  MMREPT158(MmReptlibDef.MMREPT158NM), 					/* 過不足日計レポート */
  MMREPT159(MmReptlibDef.MMREPT159NM), 					/* 部　売上 */
  MMREPT160(MmReptlibDef.MMREPT160NM), 					/* 部・セクション　売上１ */
  MMREPT161(MmReptlibDef.MMREPT161NM), 					/* 部・セクション　売上２ */
  MMREPT162(MmReptlibDef.MMREPT162NM), 					/* セクション　売上 */
  MMREPT163(MmReptlibDef.MMREPT163NM), 					/* セクション・品番　売上 */
  MMREPT164(MmReptlibDef.MMREPT164NM), 					/* 品番　売上 */
  MMREPT165(MmReptlibDef.MMREPT165NM), 					/* 品番・ＦＤ　売上 */
  MMREPT166(MmReptlibDef.MMREPT166NM), 					/* 場所別　品番・ＦＤ　売上 */
  MMREPT167(MmReptlibDef.MMREPT167NM), 					/* 未決伝票照会 */
  MMREPT168(MmReptlibDef.MMREPT168NM), 					/* マスタ取込 */
  MMREPT169(MmReptlibDef.MMREPT169NM), 					/* クリーニング */
  MMREPT170(MmReptlibDef.MMREPT170NM), 					/* マスタ保存(取込) */
  MMREPT171(MmReptlibDef.MMREPT171NM), 					/* 初期値設定 */
  MMREPT172(MmReptlibDef.MMREPT172NM), 					/* ＣＭロゴ読込 */
  MMREPT173(MmReptlibDef.MMREPT173NM), 					/* 顧客リアル問合せ予約設定 */
  MMREPT174(MmReptlibDef.MMREPT174NM), 					/* クイック予約復帰 */
  MMREPT175(MmReptlibDef.MMREPT175NM), 					/* 予約確認(一覧) */
  MMREPT176(MmReptlibDef.MMREPT176NM), 					/* 予約確認(商品件数) */
  MMREPT177(MmReptlibDef.MMREPT177NM), 					/* 予約確認(顧客情報設定) */
  MMREPT178(MmReptlibDef.MMREPT178NM), 					/* ノンアクト顧客ポイント削除 */
  MMREPT179(MmReptlibDef.MMREPT179NM), 					/* マスタ取込(開設処理結果) */
  MMREPT180(MmReptlibDef.MMREPT180NM), 					/* Edy(FCLｼﾘｰｽﾞ) */
  MMREPT181(MmReptlibDef.MMREPT181NM), 					/* 突合結果一覧 */
  MMREPT182(MmReptlibDef.MMREPT182NM), 					/* 収納精算書 */
  MMREPT183(MmReptlibDef.MMREPT183NM), 					/* エラー電文一覧 */
  MMREPT184(MmReptlibDef.MMREPT184NM), 					/* 未突合結果一覧 */
  MMREPT185(MmReptlibDef.MMREPT185NM), 					/* 残高取込 */
  MMREPT186(MmReptlibDef.MMREPT186NM), 					/* 付加情報 */
  MMREPT187(MmReptlibDef.MMREPT187NM), 					/* 整合性チェック */
  MMREPT188(MmReptlibDef.MMREPT188NM), 					/* 新クイックセットアップ */
  MMREPT189(MmReptlibDef.MMREPT189NM), 					/* キャッシュリサイクル */
  MMREPT190(MmReptlibDef.MMREPT190NM), 					/* 周辺装置[QCashierJ] */
  MMREPT191(MmReptlibDef.MMREPT191NM), 					/* 周辺装置[WebSpeezaC] */
  MMREPT192(MmReptlibDef.MMREPT192NM), 					/* 税種予約変更 */
  MMREPT193(MmReptlibDef.MMREPT193NM), 					/* 税率変更日付設定 */
  MMREPT194(MmReptlibDef.MMREPT194NM), 					/* ターミナル設定 */
  MMREPT195(MmReptlibDef.MMREPT195NM), 					/* 従業員権限 */
  MMREPT196(MmReptlibDef.MMREPT196NM), 					/* 従業員精算 */
  MMREPT197(MmReptlibDef.MMREPT197NM), 					/* クイック再セットアップ(14Verと1Verで値が違う) */
  MMREPT198(MmReptlibDef.MMREPT198NM), 					/* クイック立ち上げ支援 */
  MMREPT199(MmReptlibDef.MMREPT199NM), 					/* RT-300釣機在高不確定解除 */
  MMREPT200(MmReptlibDef.MMREPT200NM), 					/* 価格確認 */
  MMREPT201(MmReptlibDef.MMREPT201NM),          /* 取引別レポート */ /* フレスタ様向け */
  NUM_REPTNAMED('');

  /// コンストラクタ
  const ReptNumber(this.name);

  /// レポート名称
  final String name;
}

/// mm_reptlib Define
/// 関連tprxソース:mm_reptlib.h, L_mm_reptlib.h
class MmReptlibDef {
  static const MM_REPT_ETC_AST1 = "＊＊＊";
  static const MM_REPT_ETC_AST2 = "＊＊＊＊＊＊＊＊";
  static const MM_REPT_ETC_AST3 = "＊＊＊＊＊＊＊＊";
  // table number
  static const NUM_BATCH_FLGD = 21;
  static const NUM_REPT_FLGD = 11;
  static const NUM_REPT_FLG2D = 10;
  // DB:report_cnt
  static const REPT_CNT_DLY = 98;		/* 日計 */
  static const REPT_CNT_MLY = 99;		/* 累計 */
  static const REPT_CNT_MLY_BS = 100;		/* 累計(BS) */
  static const REPT_CNT_CUST_ENQ_CLR = 1000;		/* 顧客問い合わせテーブルクリア */
  static const REPT_CNT_DEC_RBT = 1001;		/* 確定ポイント割戻 */
  static const REPT_CNT_DEC_FSP_LVL = 1002;		/* ＦＳＰレベル決定 */
  static const REPT_CNT_CUST_PLAY = 1003;		/* 顧客関連再生 */
  static const REPT_CNT_CUST_ENQ_CLR_BS = 1004;		/* 顧客問い合わせテーブルクリア(BS) */
  static const REPT_CNT_TEXT_READ = 1005;		/* テキストデータ読込 */
  static const REPT_CNT_CUST_POINT_CLR = 1006;		/* ノンアクト顧客ポイント削除 */
  // report header
  static const PREADJDATE = "前回精算日時";			/* 2002/10/18 */
  static const PREADJCOUNT = "精算回数　　";
  static const PRESALEDATE = "営業日 : ";
  static const PRELASTSALEDATE = "前回営業日  ";			/* 2002/10/18 */
  static const PRE_ABJ_DATE = "途中精算日時  ";
  static const PRE_NO_OPN = "未開設";
  static const PRE_ASS_REPT = "＊ [%s]のレポートです ＊";
  // report title
  static const MMREPTTITLE1 = "＊＊＊売上速報＊＊＊";
  static const MMREPTTITLE2 = "＊＊＊売上点検＊＊＊";
  static const MMREPTTITLE3 = "＊＊＊売上精算＊＊＊";
  static const MMREPTTITLE4 = "＊＊メンテナンス＊＊";
  static const MMREPTTITLE5 = "＊＊＊ 登  録 ＊＊＊";
  static const MMREPTTITLE6 = "＊＊＊ 訓  練 ＊＊＊";
  static const MMREPTTITLE7 = "＊＊＊ 訂  正 ＊＊＊";
  static const MMREPTTITLE8 = "＊＊＊ 廃  棄 ＊＊＊";
  static const MMREPTTITLE9 = "＊＊ファイル確認＊＊";
  static const MMREPTTITLE10 = "＊＊＊ 設  定 ＊＊＊";
  static const MMREPTTITLE11 = "＊＊＊売価変更＊＊＊";
  static const MMREPTTITLE12 = "＊＊＊クローズ＊＊＊";
  static const MMREPTTITLE13 = "ユーザーセットアップ";
  static const MMREPTTITLE14 = "＊＊ カード保守 ＊＊";
  static const MMREPTTITLE15 = "＊クローズレポート＊";
  static const MMREPTTITLE16 = "＊ファイル初期設定＊";
  static const MMREPTTITLE17 = "＊＊＊ 勤  怠 ＊＊＊";
  static const MMREPTTITLE18 = "＊＊＊在高報告＊＊＊";
  static const MMREPTTITLE19 = "＊＊＊開設処理＊＊＊";
  static const MMREPTTITLE20 = "＊＊＊収納業務＊＊＊";
  static const MMREPTTITLE21 = "＊＊ 従業員精算 ＊＊";
  // report title (ej)
  static const MMREPTTITLE01EJ = "＊＊＊ 売上速報 ＊＊＊";
  static const MMREPTTITLE02EJ = "＊＊＊ 売上点検 ＊＊＊";
  static const MMREPTTITLE03EJ = "＊＊＊ 売上精算 ＊＊＊";
  static const MMREPTTITLE04EJ = "＊＊ メンテナンス ＊＊";
  static const MMREPTTITLE05EJ = "＊＊＊  登  録  ＊＊＊";
  static const MMREPTTITLE06EJ = "＊＊＊  訓  練  ＊＊＊";
  static const MMREPTTITLE07EJ = "＊＊＊  訂  正  ＊＊＊";
  static const MMREPTTITLE08EJ = "＊＊＊  廃  棄  ＊＊＊";
  static const MMREPTTITLE09EJ = "＊＊ ファイル確認 ＊＊";
  static const MMREPTTITLE10EJ = "＊＊＊  設  定  ＊＊＊";
  static const MMREPTTITLE11EJ = "＊＊＊ 売価変更 ＊＊＊";
  static const MMREPTTITLE12EJ = "＊＊＊ クローズ ＊＊＊";
  static const MMREPTTITLE13EJ = " ユーザーセットアップ ";
  static const MMREPTTITLE14EJ = "＊＊  カード保守  ＊＊";
  static const MMREPTTITLE15EJ = "＊クローズレポート＊＊";
  static const MMREPTTITLE16EJ = "＊ファイル初期設定＊＊";
  static const MMREPTTITLE17EJ = "＊＊＊  勤  怠  ＊＊＊";
  static const MMREPTTITLE19EJ = "＊＊＊ 開設処理 ＊＊＊";
  static const MMREPTTITLE20EJ = "＊＊＊ 収納業務 ＊＊＊";
  static const MMREPTTITLE21EJ = "＊＊＊従業員精算＊＊＊";
  // report type
  static const MMREPTFLG21 = "  ＜レジ日計レポート＞  ";
  static const MMREPTFLG22 = "  ＜店舗日計レポート＞  ";
  static const MMREPTFLG23 = "  ＜店舗累計レポート＞  ";
  static const MMREPTFLG24 = "    ＜一覧レポート＞    ";
  static const MMREPTFLG25 = "                        ";
  static const MMREPTFLG26 = "  ＜会員日計レポート＞  ";
  static const MMREPTFLG27 = "  ＜会員累計レポート＞  ";
  static const MMREPTFLG28 = "  ＜会員関連レポート＞  ";
  static const MMREPTFLG29 = "  ＜会員精算レポート＞  ";
  static const MMREPTFLG30 = "＜精算レポート（日計）＞";
  // report name
  static const MMREPT00NM = "";
  static const MMREPT01NM = "取引明細";
  static const MMREPT02NM = "売計キー";
  static const MMREPT03NM = "入出金";
  static const MMREPT04NM = "在高";
  static const MMREPT05NM = "従業員別取引明細";
  static const MMREPT06NM = "レジ別釣り銭明細";
  static const MMREPT07NM = "中分類別売上";
  static const MMREPT07NM_2 = "部門別売上";
  static const MMREPT08NM = "中分類別金額順売上";
  static const MMREPT09NM = "中分類別粗利順売上";
  static const MMREPT10NM = "小分類別売上";
  static const MMREPT11NM = "小分類別金額順売上";
  static const MMREPT12NM = "小分類別粗利順売上";
  static const MMREPT13NM = "店舗時間帯";
  static const MMREPT14NM = "中分類別時間帯";
  static const MMREPT15NM = "小分類別時間帯";
  static const MMREPT16NM = "商品別時間帯";
  static const MMREPT17NM = "商品別売上";
  static const MMREPT18NM = "商品別金額順売上";
  static const MMREPT19NM = "商品別数量順売上";
  static const MMREPT20NM = "PLU別金額順売上(ｶﾃｺﾞﾘｰ毎)";
  static const MMREPT21NM = "PLU別数量順売上(ｶﾃｺﾞﾘｰ毎)";
  static const MMREPT22NM = "商品別値下売上";
  static const MMREPT23NM = "スケジュール別特売商品";
  static const MMREPT24NM = "ミックスマッチ";
  static const MMREPT25NM = "セットマッチ";
  static const MMREPT26NM = "カテゴリー";
  static const MMREPT27NM = "緊急メンテナンス";
  static const MMREPT28NM = "ノンアクト商品";
  static const MMREPT29NM = "商品台帳";
  static const MMREPT30NM = "セルフ時間帯";
  static const MMREPT31NM = "セルフ稼働時間";
  static const MMREPT32NM = "釣機再精査";
  static const MMREPT33NM = "途中精算";
  static const MMREPT34NM = "精算情報レポート";
  static const MMREPT35NM = "取引明細";	// レジ途中取引明細
  static const MMREPT36NM = "会計別税明細";
  static const MMREPT37NM = "精算レポート";
  static const MMREPT38NM = "";
  static const MMREPT39NM = "";
  static const MMREPT40NM = "会員合計";
  static const MMREPT41NM = "地区";
  static const MMREPT42NM = "サービス分類";
  static const MMREPT43NM = "ＦＳＰ合計";
  static const MMREPT44NM = "ＦＳＰ中分類";
  static const MMREPT45NM = "ＦＳＰ小分類";
  static const MMREPT46NM = "ＦＳＰ ＰＬＵ";
  static const MMREPT47NM = "買上ゼロ";
  static const MMREPT48NM = "記念日";
  static const MMREPT49NM = "会員売価商品";
  static const MMREPT50NM = "会員金額";
  static const MMREPT51NM = "会員累計ポイント";
  static const MMREPT52NM = "会員可能ポイント";
  static const MMREPT53NM = "会員来店回数";
  static const MMREPT54NM = "会員最終来店日付";
  static const MMREPT55NM = "会員利用ポイント";
  static const MMREPT56NM = "ＦＳＰ期間対象額";
  static const MMREPT57NM = "ＦＳＰレベル別";
  static const MMREPT58NM = "会員情報";
  static const MMREPT59NM = "会員台帳";
  static const MMREPT60NM = "一括";
  static const MMREPT61NM = "";
  static const MMREPT62NM = "";
  static const MMREPT63NM = "";
  static const MMREPT64NM = "";
  static const MMREPT65NM = "";
  static const MMREPT66NM = "";
  static const MMREPT67NM = "";
  static const MMREPT68NM = "釣機入金再印字";
  static const MMREPT69NM = "釣機払出再印字";
  static const MMREPT70NM = "大分類別売上";
  static const MMREPT71NM = "クラス別売上";
  static const MMREPT72NM = "売上商品バーコード印字";
  static const MMREPT73NM = "取引明細";
  static const MMREPT74NM = "ＤＥＰＴ";
  static const MMREPT75NM = "ＣＬＡＳＳ";
  static const MMREPT76NM = "お会計券未精算レポート";
  static const MMREPT77NM = "稼動時間帯";
  static const MMREPT78NM = "リサイクル入出金明細";
  static const MMREPT79NM = "リサイクル入出金履歴";
  static const MMREPT80NM = "ＦＳＰレベル決定";
  static const MMREPT81NM = "確定ポイント割戻";
  static const MMREPT82NM = "預り釣銭払出し";
  static const MMREPT83NM = "カード切替";
  static const MMREPT84NM = "会員抽出";
  static const MMREPT85NM = "";
  static const MMREPT86NM = "";
  static const MMREPT87NM = "入出金結果";
  static const MMREPT88NM = "レジ従業員精算";
  static const MMREPT89NM = "";
  static const MMREPT90NM = "従業員別簡易取引明細";
  static const MMREPT91NM = "メディア情報";
  static const MMREPT92NM = "クレジット控え";
  static const MMREPT93NM = "シベール日計レポート";
  static const MMREPT94NM = "クレジット会社別";
  static const MMREPT95NM = "領収書控え";
  static const MMREPT96NM = "";
  static const MMREPT97NM = "";
  static const MMREPT98NM = "日計クリア";
  static const MMREPT99NM = "累計クリア";
  static const MMREPT100NM = "キャッシャークローズ";
  static const MMREPT101NM = "会員ENQ関連クリア";
  static const MMREPT102NM = "会員関連再生";
  static const MMREPT103NM = "釣銭カード再発行";
  static const MMREPT104NM = "釣銭カード修正";
  static const MMREPT105NM = "釣銭額メンテナンス";
  static const MMREPT106NM = "へそくり額メンテナンス";
  static const MMREPT107NM = "会員自動生成";
  static const MMREPT108NM = "会員番号変更";
  static const MMREPT109NM = "画像変換";
  static const MMREPT110NM = "リライトカード再発行";
  static const MMREPT111NM = "画像削除";
  static const MMREPT112NM = "画像調整";
  static const MMREPT113NM = "初期画像入替";
  static const MMREPT114NM = "画像読込";
  static const MMREPT115NM = "テキストデータ保存";
  static const MMREPT116NM = "テキストデータ再送信";
  static const MMREPT117NM = "テキストデータ訂正送信";
  static const MMREPT118NM = "強制Ｅｄｙログ送信";
  static const MMREPT119NM = "ポイント追加処理";
  static const MMREPT120NM = "発券処理";
  static const MMREPT121NM = "税種変更";
  static const MMREPT122NM = "テキストデータ読込";
  static const MMREPT123NM = "テキストデータ読込(結果)";
  static const MMREPT124NM = "テキストデータ復帰";
  static const MMREPT125NM = "ﾌﾟﾘﾝﾀ待ちｼﾞｮﾌﾞ削除";
  static const MMREPT126NM = "売価変更";
  static const MMREPT127NM = "画像ＣＤ作成";
  static const MMREPT128NM = "強制Ｍカード実績ログ";
  static const MMREPT129NM = "税種変換 テキストデータ復帰";
  static const MMREPT130NM = "NON-PLU税種変更";
  static const MMREPT131NM = "クローズレポート";
  static const MMREPT132NM = "現在売価";
  static const MMREPT133NM = "レシートメッセージスケジュール";
  static const MMREPT134NM = "ビスマックカード復帰";
  static const MMREPT135NM = "生産者バーコード自動設定";
  static const MMREPT136NM = "生産者バーコード自動削除";
  static const MMREPT137NM = "Ｅｄｙ（ＳＩＰシリーズ）初期通信";
  static const MMREPT138NM = "会員情報データクリア";
  static const MMREPT139NM = "会員マスタ";
  static const MMREPT140NM = "従業員マスタ";
  static const MMREPT141NM = "バックアップデータ保存";
  static const MMREPT142NM = "実績ログバックアップ";
  static const MMREPT143NM = "ログバックアップ";
  static const MMREPT144NM = "記録確認";
  static const MMREPT145NM = "リライトカード復旧";
  static const MMREPT146NM = "生産者一括設定";
  static const MMREPT147NM = "バックアップＣＤ再作成";
  static const MMREPT148NM = "クイック設定";
  static const MMREPT149NM = "クイック会員設定";
  static const MMREPT150NM = "クイックセットアップ";
  static const MMREPT151NM = "クイック設定 累計クリア";
  static const MMREPT152NM = "ノンアクト商品 商品マスタ復帰";
  static const MMREPT153NM = "日付＆時刻";
  static const MMREPT154NM = "固定ＩＰセットアップ";
  static const MMREPT155NM = "周辺装置";
  static const MMREPT156NM = "ＳＩＯ";
  static const MMREPT157NM = "勤怠";
  static const MMREPT158NM = "過不足日計レポート";
  static const MMREPT159NM = "部売上";
  static const MMREPT160NM = "部・セクション売上１";
  static const MMREPT161NM = "部・セクション売上２";
  static const MMREPT162NM = "セクション売上";
  static const MMREPT163NM = "セクション・品番売上";
  static const MMREPT164NM = "品番売上";
  static const MMREPT165NM = "品番・ＦＤ売上";
  static const MMREPT166NM = "場所別　品番・ＦＤ売上";
  static const MMREPT167NM = "未決伝票照会";
  static const MMREPT168NM = "マスタ取込";
  static const MMREPT169NM = "クリーニング";
  static const MMREPT170NM = "マスタ保存(取込)";
  static const MMREPT171NM = "初期値設定";
  static const MMREPT172NM = "ＣＭロゴ読込";
  static const MMREPT173NM = "会員リアル問合せ予約設定";
  static const MMREPT174NM = "クイック予約復帰";
  static const MMREPT175NM = "予約確認(一覧)";
  static const MMREPT176NM = "予約確認(商品件数)";
  static const MMREPT177NM = "予約確認(会員情報設定)";
  static const MMREPT178NM = "ノンアクト会員ポイント削除";
  static const MMREPT179NM = "マスタ取込(開設処理結果)";
  static const MMREPT180NM = "Edy(FCLｼﾘｰｽﾞ)";
  static const MMREPT181NM = "突合結果一覧";
  static const MMREPT182NM = "収納精算書";
  static const MMREPT183NM = "エラー電文一覧";
  static const MMREPT184NM = "未突合結果一覧";
  static const MMREPT185NM = "残高取込";
  static const MMREPT186NM = "付加情報";
  static const MMREPT187NM = "";
  static const MMREPT188NM = "新クイックセットアップ";
  static const MMREPT189NM = "";
  static const MMREPT190NM = "周辺装置 [QCashierJ]";
  static const MMREPT191NM = "周辺装置 [WebSpeezaC]";
  static const MMREPT192NM = "税種予約変更";
  static const MMREPT193NM = "税率変更日付設定";
  static const MMREPT194NM = "ターミナル設定";
  static const MMREPT195NM = "";
  static const MMREPT196NM = "";
  static const MMREPT197NM = "クイック再セットアップ";
  static const MMREPT198NM = "クイック立ち上げ支援";
  static const MMREPT199NM = "";
  static const MMREPT200NM = "価格確認";
  static const MMREPT201NM = "取引別";	// フレスタ様向け
  static const MMREPTAUTO = "[自動]";
  // mm_rept76.c
  static const MMREPT_QRPAID_TITLE = "お会計券未精算";
  static const MMREPT_TIME = "時間";
  static const MMREPT_MAC_NO = "ﾚｼﾞ番号";
  static const MMREPT_RECEIPT = "ﾚｼｰﾄNo.";
  static const MMREPT_UNPAID_QTY = "点数";
  static const MMREPT_UNPAID_AMOUNT = "金額";
  static const MMREPT_CASE = "件";
  static const MMREPT_DEL = "消";
  static const MMREPT_TWOCNCT = "連";
  static const MMREPT_TICKET = "券";
  static const MMREPT_LOAD = "読";
  static const MMREPT_WIZ = "ハ";
  static const MMREPT_TENKEN = "点検";
  static const MMREPT_SEISAN = "精算";
  // UpdErr_Chk()
  static const MM_REPT_UPDERR0 = "＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊";
  static const MM_REPT_UPDERR1 = "実績の書き込みに問題が生じました";
  static const MM_REPT_UPDERR2 = "サービスマンにご連絡ください　　";
  static const MM_REPT_UPDERR0_EJ = "＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊";
  static const MM_REPT_UPDERR1_EJ = "　　　　　$MM_REPT_UPDERR1";
  static const MM_REPT_UPDERR2_EJ = "　　　　　$MM_REPT_UPDERR2" ;
  static const MM_REPT_ASS_REPT_EJ = "＊　　　　　[%s]のレポートです　　　　　　　＊";
  static const MM_REPT_UPDERR_1 = "未集計の売上が";
  static const MM_REPT_UPDERR_2 = "           %d 件あります！！";
  static const MM_REPT_UPDERR_1_EJ = "　　　　　$MM_REPT_UPDERR_1";
  static const MM_REPT_UPDERR_2_EJ = "　　　　　$MM_REPT_UPDERR_2";

  /* レポートエンド */
  static const MMREPT_RCT_END	= "レポートエンド";
  static const MMREPT_RCT_STOP = "レポート中断";
  static const MMREPT_CLSRCT_END = "クローズレポート終了";
  static const MMREPT_CLSRCT_STOP	= "クローズレポート中断";

  /* EJ TEXT */
  static const MMREPT_EJ_TEXT_MAX_LEN	=	(6000 * 190);
  static const MMREPT_EJ_TEXT = "mm_rept_ej.txt";
  static const MMREPT_EJ_TEXT2 = "mm_rept_ej2.txt";
}

/// プリンターステータス
/// 関連tprxソース:mm_reptlib.h
class PrinterPortStatus {
  static const BASEPORT = 0x378;   /* Printer Base Port         */
  static const XPRN_BSY = 0x80;    /* Printer Status:Busy       */
  static const XPRN_PE = 0x20;     /* Printer Status:Drawer open*/
  static const XPRN_SLCT = 0x10;   /* Printer Status:SLCT       */
  static const XPRN_ERR = 0x08;    /* Printer Status:Error      */
}

/// レポートデータ
/// 関連tprxソース:mm_reptlib.h - BATREPT_INFO
class BatReptInfo {
  int kind = 0;					// 0:メインメニュー 1:予約レポート設定 2:予約レポート出力
  int batchFlg = 0;     //  0:売上速報		  1:売上点検    2:売上精算    3:メンテナンス
  //  4:登録　　 	  5:訓練　　    6:訂正　　    7:廃棄
  //  8:ファイル確認	9:設定      10:売価変更   11:クローズ
  // 12:ユーザーセットアップ      13:カード保守   16:勤怠
  // 17:在高報告    18:開設処理  19:収納業務
  int reptFlg = 0;			//  0:レジ日計 　　   1:店舗日計  2:店舗累計  3:一覧　　  4:無し
  //  5:会員日計 　　   6:会員累計  7:会員関連  8:会員精算  9:途中精算
  // 10:売上照会(画面) 11:売上照会(レシート)
  CBatrepoMstColumns batReport = CBatrepoMstColumns();				// レポート情報
  String bfreReptOutAdd = '';			// For Old Report (YYYYMMDD)
  String saleDate = '';				    // 指定：営業日 (YYYY-MM-DD)
  int bfreReptTyp = 0;				    // For Old Report Type 1:TextData 2:MasterDB 3:Tranbackup
  bool shortCutFlag = false;      // ショートカットフラグ   false:通常  true:ショートカットしている
  // クローズレポート
  bool opnclsCshrOrChk = false;   // オープンクローズ　false:Cashier   true:Checker
  String opnclsOpentime = '';			// オープン時間(中身が空の場合は、c_staffopn_mstを使用)
  bool opnclsQcjcFlg = false;     // QCJC仕様   false:QCJC仕様ではない  true:QCJC仕様である。
  int opnclsMacNo = 0;				    // クローズレジ番号
  // MS仕様の店舗日計/店舗累計での日付指定 情報
  int	dateTyp = 0;				// 日付指定タイプ
  // 0:指定なし
  // << 店舗日計 >>
  // 1:当日(営業日)
  // 2:前日(前回営業日)
  // 3:範囲指定(カレンダー入力)
  // << 店舗累計 >>
  // 4:当月
  // 5:前月
  // 6:範囲指定(カレンダー入力)
  int weekTyp = 0;				// 曜日指定タイプ(=3:日付指定の場合のみ)
  // 0:指定なし
  // 1:日曜のみ (SQL:0)
  // 2:月曜のみ (SQL:1)
  // 3:火曜のみ (SQL:2)
  // 4:水曜のみ (SQL:3)
  // 5:木曜のみ (SQL:4)
  // 6:金曜のみ (SQL:5)
  // 7:土曜のみ (SQL:6)
  String sdate = '';			// 開始日付 YYYY/MM/DD
  String edate = '';			// 終了日付 YYYY/MM/DD
  int menuID = 0;					// 表示中のメニューID
}