/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../../../../common/cls_conf/qcashierJsonFile.dart';
import '../../model/m_specfile.dart';
import '../m_specfile_common.dart';

/// QCashier設定（共通部）画面の項目と処理
class QCashierCommon extends SpecRowDispCommon {

  /// 表示項目
  static const String fConTblMsgQcCommon11 = 'FCONTBL_MSG_QC_COMMON11';                                        // 初期言語選択
  static const String fConTblMsgQcChgInfo1 = 'FCONTBL_MSG_QC_CHGINFO1';                                        // 釣銭釣札機のニアエンドによる休止
  static const String fConTblMsgQcChgInfo2 = 'FCONTBL_MSG_QC_CHGINFO2';                                        // 釣銭機ニアフル差分枚数
  static const String fConTblMsgQcChgInfo3 = 'FCONTBL_MSG_QC_CHGINFO3';                                        // 釣銭機ニアフルサインポール点灯差分枚数
  static const String fConTblMsgQcCommon27 = 'FCONTBL_MSG_QC_COMMON27';                                        // 領収書発行ボタン表示
  static const String fConTblMsgQcCommon34 = 'FCONTBL_MSG_QC_COMMON34';                                        // 合計額＝お預かり金額時　一定時間経過後の動作
  static const String fConTblMsgQcCommon35 = 'FCONTBL_MSG_QC_COMMON35';                                        // 合計額＝お預かり金額時 経過時間（秒）
  static const String fConTblMsgQcCommon36 = 'FCONTBL_MSG_QC_COMMON36';                                        // 合計額＜お預かり金額時 経過時間（秒）
  static const String fConTblMsgQcCommon54 = 'FCONTBL_MSG_QC_COMMON54';                                        // 取消ボタン表示
  static const String expCommonPrecaChargeOnly = 'EXP_COMMON_PRECA_CHARGE_ONLY';                               // プリカチャージのみの実施
  static const String fConTblMsgQcCommon55 = 'FCONTBL_MSG_QC_COMMON55';                                        // クリニックモード
  static const String fConTblMsgQcCommon56 = 'FCONTBL_MSG_QC_COMMON56';                                        // クリニックモード レシート印字
  static const String fConTblMsgQcCommon57 = 'FCONTBL_MSG_QC_COMMON57';                                        // クリニックモード あいさつ画面
  static const String fConTblMsgQcCommon58 = 'FCONTBL_MSG_QC_COMMON58';                                        // クリニックモード あいさつ画面音声
  static const String fConTblMsgQcCommon60 = 'FCONTBL_MSG_QC_COMMON60';                                        // マイバッグ仕様時 登録開始画面の１ボタン表示
  static const String fConTblMsgQcCommon61 = 'FCONTBL_MSG_QC_COMMON61';                                        // 登録開始画面のスキャナ読込
  static const String fConTblMsgQcCommon70 = 'FCONTBL_MSG_QC_COMMON70';                                        // Verifone端末でNFCクレジットを利用
  static const String fConTblMsgQcCommon71 = 'FCONTBL_MSG_QC_COMMON71';                                        // HappySelf 店員側の表示
  static const String fConTblMsgQcCommon73 = 'FCONTBL_MSG_QC_COMMON73';                                        // Happyフルセルフ登録画面での登録操作無時警告
  static const String fConTblMsgQcCommon74 = 'FCONTBL_MSG_QC_COMMON74';                                        // 登録操作無時、ｻｲﾝﾎﾟｰﾙ点灯までの経過時間（秒）
  static const String fConTblMsgQcCommon75 = 'FCONTBL_MSG_QC_COMMON75';                                        // 登録操作無時、ｻｲﾝﾎﾟｰﾙ点灯後、音声案内までの経過時間（秒）
  static const String fConTblMsgQcCommon76 = 'FCONTBL_MSG_QC_COMMON76';                                        // 登録操作無時音
  static const String fConTblMsgQcCommon79 = 'FCONTBL_MSG_QC_COMMON79';                                        // レセコンバーコード読み取り後会計画面に自動遷移
  // TODO: ベルジョイス仕様
  static const String fConTblMsgQcCommon86 = 'FCONTBL_MSG_QC_COMMON86';                                        // マイバッグ仕様 PLUコード
  static const String fConTblMsgQcSagUseClass = 'FCONTBL_MSG_QC_SAG_USE_CLASS';                                // 部門登録時の分類キー
  static const String fConTblMsgQcCommon91 = 'FCONTBL_MSG_QC_COMMON91';                                        // フルセルフ イートイン対応
  static const String fConTblMsgQcCommon92 = 'FCONTBL_MSG_QC_COMMON92';                                        // フルセルフ 無操作時、登録内容の自動取消
  static const String fConTblMsgQcCommon98 = 'FCONTBL_MSG_QC_COMMON98';                                        // レジ袋入力画面表示タイミング
  static const String fConTblMsgQcCommon99 = 'FCONTBL_MSG_QC_COMMON99';                                        // レジ袋入力画面 戻るボタン表示
  static const String fConTblMsgQcCommon100 = 'FCONTBL_MSG_QC_COMMON100';                                      // フルセルフ 合計点数 音声読み上げ
  static const String fConTblMsgQcCommon102 = 'FCONTBL_MSG_QC_COMMON102';                                      // プリカ残高照会ボタン表示
  static const String fConTblMsgQcCommon103 = 'FCONTBL_MSG_QC_COMMON103';                                      // フルセルフ スタート画面の背景色変更
  static const String fConTblMsgQcCommon104 = 'FCONTBL_MSG_QC_COMMON104';                                      // フルセルフ 登録画面のガイダンス変更
  static const String fConTblMsgQcCommon105 = 'FCONTBL_MSG_QC_COMMON105';                                      // フルセルフ 同一商品連続スキャン時、警告表示
  static const String fConTblMsgQcCommon106 = 'FCONTBL_MSG_QC_COMMON106';                                      // フルセルフ・精算機 現金入金時に入金額を読み上げ
  static const String fConTblMsgQcCommon114 = 'FCONTBL_MSG_QC_COMMON114';                                      // 未精算時に再生する警告音を変更
  static const String fConTblMsgQcCommonFsBagSetDsp = 'FCONTBL_MSG_QC_COMMON_FS_BAG_SET_DSP';                  // フルセルフ レジ袋セット画面表示
  static const String fConTblMsgQcCommonCashlessDspShow = 'FCONTBL_MSG_QC_COMMON_CASHLESS_DSP_SHOW';           // フルセルフ キャッシュレス案内画面表示
  static const String fConTblMsgQcCommon117 = 'FCONTBL_MSG_QC_COMMON117';                                      // フルセルフ 登録開始時プリセット画面に自動遷移
  static const String fConTblMsgQcCommon119 = 'FCONTBL_MSG_QC_COMMON119';                                      // 現金対応レジ案内画面の表示時間(秒)
  static const String fConTblMsgQcCommon124 = 'FCONTBL_MSG_QC_COMMON124';                                      // 店員呼出ボタンを表示（G3のみ）
  static const String fConTblMsgQcCommon187 = 'FCONTBL_MSG_QC_COMMON187';                                      // フルセルフ 金種商品の登録許可
  static const String fConTblMsgQcCommon188 = 'FCONTBL_MSG_QC_COMMON188';                                      // フルセルフ 商品登録画面で画面訂正する(G3縦型のみ)
  static const String fConTblMsgQcCommon189 = 'FCONTBL_MSG_QC_COMMON189';                                      // 年齢確認商品登録時に再生する音声を変更
  static const String fConTblMsgQcCommon169 = 'FCONTBL_MSG_QC_COMMON169';                                      // G3フルセルフ プリセットグループボタンの任意設定
  static const String fConTblMsgQcCommon170 = 'FCONTBL_MSG_QC_COMMON170';                                      // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ1のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
  static const String fConTblMsgQcCommon171 = 'FCONTBL_MSG_QC_COMMON171';                                      // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ2のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
  static const String fConTblMsgQcCommon172 = 'FCONTBL_MSG_QC_COMMON172';                                      // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ3のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
  static const String fConTblMsgQcCommon173 = 'FCONTBL_MSG_QC_COMMON173';                                      // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ4のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
  static const String fConTblMsgQcCommon174 = 'FCONTBL_MSG_QC_COMMON174';                                      // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ5のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
  static const String fConTblMsgQcCommon175 = 'FCONTBL_MSG_QC_COMMON175';                                      // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ6のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
  static const String fConTblMsgQcCommon176 = 'FCONTBL_MSG_QC_COMMON176';                                      // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ7のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
  static const String fConTblMsgQcCommon177 = 'FCONTBL_MSG_QC_COMMON177';                                      // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ8のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
  static const String fConTblMsgQcCommonArcsPaymentMbrRead = 'FCONTBL_MSG_QC_COMMON_ARCS_PAYMENT_MBR_READ';    // フルセルフ及びShop&Go 後会員仕様
  static const String fConTblMsgQcCommon192 = 'FCONTBL_MSG_QC_COMMON192';                                      // G3フルセルフでマッピングを画面上部に表示
  static const String fConTblMsgQcCommon197 = 'FCONTBL_MSG_QC_COMMON197';                                      // 待機中サインポール点灯色
  static const String fConTblMsgQcCommon208 = 'FCONTBL_MSG_QC_COMMON208';                                      // キャッシュバック 無操作時、登録内容の自動取消(秒)
  static const String fConTblMsgQcCommon209 = 'FCONTBL_MSG_QC_COMMON209';                                      // 年齢確認端末での年齢確認を強制(G3縦型のみ)
  static const String qCashierIniInputRegBagClsCD = 'QCASHIER_INI_INPUT_REGBAG_CLSCD';                         // レジ袋の分類コード
  static const String fConTblMsgQcCommon215= 'FCONTBL_MSG_QC_COMMON215';                                       // 会計選択画面でのバーコード読取制御
  static const String fConTblMsgQcCommon216 = 'FCONTBL_MSG_QC_COMMON216';                                      // キャッシュバック 従業員呼出金額(円)
  static const String fConTblMsgQcCommon217 = 'FCONTBL_MSG_QC_COMMON217';                                      // プリペイドの選択ボタンの画像対応
  static const String fConTblMsgQcCommon218 = 'FCONTBL_MSG_QC_COMMON218';                                      // 精算機/フルセルフ取引レシート印字
  static const String fConTblMsgQcCommon219 = 'FCONTBL_MSG_QC_COMMON219';                                      // 合計金額の音声読み上げ
  static const String fConTblMsgQcCommon220 = 'FCONTBL_MSG_QC_COMMON220';                                      // 釣銭精査必要時のサインポール黄色と水色点滅(LED型のみ)

  /// 表示項目のリスト
  @override
  List<SpecFileDispRow> get rowList => [
    const SpecFileDispRow(
      key: fConTblMsgQcCommon11,
      title: '初期言語選択',
      description: "初期言語選択\n　日本語／英語／中国語／韓国語",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("日本語", 0),
        SelectionSetting("英語", 1),
        SelectionSetting("中国語", 2),
        SelectionSetting("韓国語", 3),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcChgInfo1,
      title: '釣銭釣札機のニアエンドによる休止',
      description: "釣銭釣札機のニアエンドによる休止\n  しない/する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcChgInfo2,
      title: '釣銭機ニアフル差分枚数',
      description: "釣銭機ニアフル差分枚数\n　０～９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(0, 99),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcChgInfo3,
      title: '釣銭機ニアフルサインポール点灯差分枚数',
      description: "釣銭機ニアフルサインポール点灯差分枚数\n　０～９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(0, 99),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon27,
      title: '領収書発行ボタン表示',
      description: "領収書発行ボタン表示\n　しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon34,
      title: '合計額＝お預かり金額時　一定時間経過後の動作',
      description: "合計額＝お預かり金額時　一定時間経過後の動作  動作なし／\n  おわり押下(ﾚｼｰﾄあり)／おわり押下(ﾚｼｰﾄなし)／店員呼出",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("動作なし", 0),
        SelectionSetting("おわり押下(レシートあり)", 1),
        SelectionSetting("おわり押下(レシートなし)", 2),
        SelectionSetting("店員呼出", 3),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon35,
      title: '合計額＝お預かり金額時 経過時間（秒）',
      description: "合計額＝お預かり金額時 経過時間（秒）\n　０～９９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(0, 999),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon36,
      title: '合計額＜お預かり金額時 経過時間（秒）',
      description: "合計額＜お預かり金額時 経過時間（秒）\n　０～９９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(0, 999),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon54,
      title: '取消ボタン表示',
      description: "取消ボタン表示\n しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: expCommonPrecaChargeOnly,
      title: 'プリカチャージのみの実施',
      description: "プリカチャージのみの実施\n しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon55,
      title: 'クリニックモード',
      description: "クリニックモード\n  しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon56,
      title: 'クリニックモード レシート印字',
      description: "クリニックモード レシート印字\n  しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon57,
      title: 'クリニックモード あいさつ画面',
      description: "クリニックモード あいさつ画面\n  なし／あり",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("なし", 0),
        SelectionSetting("あり", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon58,
      title: 'クリニックモード あいさつ画面音声',
      description: "クリニックモード あいさつ画面音声\n  なし／あり",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("なし", 0),
        SelectionSetting("あり", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon60,
      title: 'マイバッグ仕様時 登録開始画面の１ボタン表示',
      description: "マイバッグ仕様時 登録開始画面の１ボタン表示\n  しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon61,
      title: '登録開始画面のスキャナ読込',
      description: "登録開始画面のスキャナ読込\n  無効／有効",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("無効", 0),
        SelectionSetting("有効", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon70,
      title: 'Verifone端末でNFCクレジットを利用',
      description: "Verifone端末でNFCクレジットを利用\n しない／する(含MS)／する(除MS)",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する(含MS)", 1),
        SelectionSetting("する(除MS)", 2),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon71,
      title: 'HappySelf 店員側の表示',
      description: "HappySelf 店員側の表示\n  しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon73,
      title: 'Happyフルセルフ登録画面での登録操作無時警告',
      description: "Happyフルセルフ登録画面での登録操作無時警告\n（ｻｲﾝﾎﾟｰﾙ・音声）　しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon74,
      title: '登録操作無時、ｻｲﾝﾎﾟｰﾙ点灯までの経過時間（秒）',
      description: "登録操作無時、ｻｲﾝﾎﾟｰﾙ点灯\nまでの経過時間（秒）\n　０～９９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(0, 999),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon75,
      title: '登録操作無時、ｻｲﾝﾎﾟｰﾙ点灯後、音声案内までの経過時間（秒）',
      description: "登録操作無時、ｻｲﾝﾎﾟｰﾙ点灯後、\n音声案内までの経過時間（秒）\n　０～９９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(0, 999),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon76,
      title: '登録操作無時音',
      description: "登録操作無時音\n　音声／警告音",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("音声", 0),
        SelectionSetting("警告音", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon79,
      title: 'レセコンバーコード読み取り後会計画面に自動遷移',
      description: "レセコンバーコード読み取り後会計画面に自動遷移\n  しない／する(クリニックモードのみ)",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    // TODO: ベルジョイス仕様
    const SpecFileDispRow(
      key: fConTblMsgQcCommon86,
      title: 'マイバッグ仕様 PLUコード',
      description: "マイバッグ仕様 PLUｺｰﾄﾞ\n(商品加算ﾎﾟｲﾝﾄ付与)\n　13桁まで",
      editKind: SpecFileEditKind.PLUCode,
      setting: NumInputSetting(0, 9999999999999),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcSagUseClass,
      title: '部門登録時の分類キー',
      description: "部門登録時の分類キー\n 小分類／中分類",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("小分類", 0),
        SelectionSetting("中分類", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon91,
      title: 'フルセルフ イートイン対応',
      description: "フルセルフ イートイン対応\n しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon92,
      title: 'フルセルフ 無操作時、登録内容の自動取消',
      description: "フルセルフ 無操作時、登録内容の自動取消\n しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon98,
      title: 'レジ袋入力画面表示タイミング',
      description: "レジ袋入力画面表示タイミング\n 商品登録後／商品登録前",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("商品登録後", 0),
        SelectionSetting("商品登録前", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon99,
      title: 'レジ袋入力画面 戻るボタン表示',
      description: "レジ袋入力画面 戻るボタン表示\n しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon100,
      title: 'フルセルフ 合計点数 音声読み上げ',
      description: "フルセルフ 合計点数 音声読み上げ\n しない／する(合計のみ)/する(単品と合計)",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する(合計のみ)", 1),
        SelectionSetting("する(単品と合計)", 2),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon102,
      title: 'プリカ残高照会ボタン表示',
      description: "プリカ残高照会ボタン表示\n しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon103,
      title: 'フルセルフ スタート画面の背景色変更',
      description: "フルセルフ スタート画面の背景色変更\n しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon104,
      title: 'フルセルフ 登録画面のガイダンス変更',
      description: "フルセルフ 登録画面のガイダンス変更\n しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon105,
      title: 'フルセルフ 同一商品連続スキャン時、警告表示',
      description: "フルセルフ 同一商品連続スキャン時、警告表示\n しない／する／登録確認／音声のみ1/音声のみ2",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
        SelectionSetting("登録確認", 2),
        SelectionSetting("音声のみ1", 3),
        SelectionSetting("音声のみ2", 4),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon106,
      title: 'フルセルフ・精算機 現金入金時に入金額を読み上げ',
      description: "フルセルフ・精算機 現金入金時に入金額を読み上げ\n しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon114,
      title: '未精算時に再生する警告音を変更',
      description: "未精算時に再生する警告音を変更\n しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommonFsBagSetDsp,
      title: 'フルセルフ レジ袋セット画面表示',
      description: "フルセルフ レジ袋セット画面表示\n しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    // TODO: 表示しなくても良いとのこと
    // 　→処理も含め残しているが、最終的に不要なら削除予定
    // const SpecFileDispRow(
    //   key: fConTblMsgQcCommonCashlessDspShow,
    //   title: 'フルセルフ キャッシュレス案内画面表示',
    //   description: "フルセルフ キャッシュレス案内画面表示\n しない／する",
    //   editKind: SpecFileEditKind.selection,
    //   setting: [
    //     SelectionSetting("しない", 0),
    //     SelectionSetting("する", 1),
    //   ],
    // ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon117,
      title: 'フルセルフ 登録開始時プリセット画面に自動遷移',
      description: "フルセルフ 登録開始時プリセット画面に自動遷移\n しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon119,
      title: '現金対応レジ案内画面の表示時間(秒)',
      description: "現金対応レジ案内画面\n表示時間(秒)\n　０～９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(0, 99),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon124,
      title: '店員呼出ボタンを表示（G3のみ）',
      description: "店員呼出ボタンを表示（G3のみ）\n しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon187,
      title: 'フルセルフ 金種商品の登録許可',
      description: "フルセルフ 金種商品の登録許可\n  しない/する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon188,
      title: 'フルセルフ 商品登録画面で画面訂正する(G3縦型のみ)',
      description: "フルセルフ 商品登録画面で画面訂正する(G3縦型のみ)\n  しない/直前のみ/全て",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("直前のみ", 1),
        SelectionSetting("全て", 2),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon189,
      title: '年齢確認商品登録時に再生する音声を変更',
      description: "年齢確認商品登録時に再生する音声を変更\n しない／パターン１／パターン２",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("パターン１", 1),
        SelectionSetting("パターン２", 2),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon169,
      title: 'G3フルセルフ プリセットグループボタンの任意設定',
      description: "G3フルセルフ プリセットグループボタンの任意設定\n しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon170,
      title: 'ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ1のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄﾞ',
      description: "ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ1の\nﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄﾞ\n　０～９９９９９９",
      editKind: SpecFileEditKind.presetGroupCode,
      setting: NumInputSetting(0, 999999),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon171,
      title: 'ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ2のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄﾞ',
      description: "ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ2の\nﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄﾞ\n　０～９９９９９９",
      editKind: SpecFileEditKind.presetGroupCode,
      setting: NumInputSetting(0, 999999),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon172,
      title: 'ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ3のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄﾞ',
      description: "ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ3の\nﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄﾞ\n　０～９９９９９９",
      editKind: SpecFileEditKind.presetGroupCode,
      setting: NumInputSetting(0, 999999),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon173,
      title: 'ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ4のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄﾞ',
      description: "ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ4の\nﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄﾞ\n　０～９９９９９９",
      editKind: SpecFileEditKind.presetGroupCode,
      setting: NumInputSetting(0, 999999),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon174,
      title: 'ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ5のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄﾞ',
      description: "ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ5の\nﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄﾞ\n　０～９９９９９９",
      editKind: SpecFileEditKind.presetGroupCode,
      setting: NumInputSetting(0, 999999),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon175,
      title: 'ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ6のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄﾞ',
      description: "ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ6の\nﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄﾞ\n　０～９９９９９９",
      editKind: SpecFileEditKind.presetGroupCode,
      setting: NumInputSetting(0, 999999),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon176,
      title: 'ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ7のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄﾞ',
      description: "ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ7の\nﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄﾞ\n　０～９９９９９９",
      editKind: SpecFileEditKind.presetGroupCode,
      setting: NumInputSetting(0, 999999),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon177,
      title: 'ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ8のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄﾞ',
      description: "ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ8の\nﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄﾞ\n　０～９９９９９９",
      editKind: SpecFileEditKind.presetGroupCode,
      setting: NumInputSetting(0, 999999),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommonArcsPaymentMbrRead,
      title: 'フルセルフ及びShop&Go 後会員仕様',
      description: "フルセルフ及びShop&Go 後会員仕様\n  しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon192,
      title: 'G3フルセルフでマッピングを画面上部に表示',
      description: "G3フルセルフでマッピングを画面上部に表示\n  しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon197,
      title: '待機中サインポール点灯色',
      description: "待機中サインポール点灯色\n　緑色(従来)／青色／赤色／黄色／紫色／水色／白色／消灯",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("緑色(従来)", 0),
        SelectionSetting("青色", 1),
        SelectionSetting("赤色", 2),
        SelectionSetting("黄色", 3),
        SelectionSetting("紫色", 4),
        SelectionSetting("水色", 5),
        SelectionSetting("白色", 6),
        SelectionSetting("消灯", 7),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon208,
      title: 'キャッシュバック 無操作時、登録内容の自動取消(秒)',
      description: "キャッシュバック 無操作時\n登録内容の自動取消(秒)\n　０～９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(0, 99),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon209,
      title: '年齢確認端末での年齢確認を強制(G3縦型のみ)',
      description: "年齢確認端末での年齢確認を強制 (G3縦型のみ) \n しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: qCashierIniInputRegBagClsCD,
      title: 'レジ袋の分類コード',
      description: "レジ袋の分類コード\n　０～９９９９９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(0, 999999),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon215,
      title: '会計選択画面でのバーコード読取制御',
      description: "会計選択画面でのバーコード読取制御\n  しない／する(従業員バーコード以外の読取音を鳴らさない)",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon216,
      title: 'キャッシュバック 従業員呼出金額(円)',
      description: "キャッシュバック\n従業員呼出金額(円)\n　０～９９９９９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(0, 999999),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon217,
      title: 'プリペイドの選択ボタンの画像対応',
      description: "プリペイドの選択ボタンの画像対応\n　しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon218,
      title: '精算機/フルセルフ取引レシート印字',
      description: "精算機/フルセルフ取引レシート印字\n 釣銭取得後印字/釣銭同時印字",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("釣銭取得後印字", 0),
        SelectionSetting("釣銭同時印字", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon219,
      title: '合計金額の音声読み上げ',
      description: "合計金額の音声読み上げ\n しない/する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcCommon220,
      title: '釣銭精査必要時のサインポール黄色と水色点滅(LED型のみ)',
      description: "釣銭精査必要時のサインポール黄色と水色点滅(LED型のみ)\n しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
  ];

  /// 設定ファイルを読み込んで、表示項目毎の設定値を取得する
  /// dispRowDataには、非表示項目は含まれない
  @override
  Future<Map<SpecFileDispRow, SettingData>> loadJsonData(List<SpecFileDispRow> dispRowData) async {
    // 表示項目と設定値の組み合わせ
    Map<SpecFileDispRow, SettingData> specSubData = {};

    // QcashierJsonFileの読み込み
    QcashierJsonFile qcashierJsonFile = QcashierJsonFile();
    await qcashierJsonFile.load();

    // 表示項目のループ
    for (var data in dispRowData) {
      // 設定ファイルから設定値を取得
      var value = _getJsonData(qcashierJsonFile, data.key);
      specSubData[data] = SettingData(before: value, after: value);
    }

    return specSubData;
  }

  /// 表示項目毎の設定値を、設定ファイルに保存する
  @override
  Future<void> saveJsonData(Map<SpecFileDispRow, SettingData> specSubData) async {
    // QcashierJsonFileの読み込み
    QcashierJsonFile qcashierJsonFile = QcashierJsonFile();
    await qcashierJsonFile.load();

    for (var data in specSubData.keys) {
      // 設定ファイルに設定値を設定
      _setJsonData(qcashierJsonFile, data.key, specSubData[data]!.after);
    }

    // QcashierJsonFileへ保存
    await qcashierJsonFile.save();
  }

  /// 設定ファイルから設定値を取得
  dynamic _getJsonData(QcashierJsonFile qcashierJsonFile, String key) {
    switch (key) {
      case fConTblMsgQcCommon11:                                // 初期言語選択
        return qcashierJsonFile.common.language_typ;
      case fConTblMsgQcChgInfo1:                                // 釣銭釣札機のニアエンドによる休止
        return qcashierJsonFile.chg_info.chg_info;
      case fConTblMsgQcChgInfo2:                                // 釣銭機ニアフル差分枚数
        return qcashierJsonFile.chg_info.chg_info_full_chk;
      case fConTblMsgQcChgInfo3:                                // 釣銭機ニアフルサインポール点灯差分枚数
        return qcashierJsonFile.chg_info.chg_signp_full_chk;
      case fConTblMsgQcCommon27:                                // 領収書発行ボタン表示
        return qcashierJsonFile.common.rfm_receipt;
      case fConTblMsgQcCommon34:                                // 合計額＝お預かり金額時　一定時間経過後の動作
        return qcashierJsonFile.common.autocash_operation;
      case fConTblMsgQcCommon35:                                // 合計額＝お預かり金額時 経過時間（秒）
        return qcashierJsonFile.common.autocash_equaltime;
      case fConTblMsgQcCommon36:                                // 合計額＜お預かり金額時 経過時間（秒）
        return qcashierJsonFile.common.autocash_overtime;
      case fConTblMsgQcCommon54:                                // 取消ボタン表示
        return qcashierJsonFile.common.cancel_btn_dsp;
      case expCommonPrecaChargeOnly:                            // プリカチャージのみの実施
        return qcashierJsonFile.common.preca_charge_only;
      case fConTblMsgQcCommon55:                                // クリニックモード
        return qcashierJsonFile.common.clinic_mode;
      case fConTblMsgQcCommon56:                                // クリニックモード レシート印字
        return qcashierJsonFile.common.clinic_receipt;
      case fConTblMsgQcCommon57:                                // クリニックモード あいさつ画面
        return qcashierJsonFile.common.clinic_greeting;
      case fConTblMsgQcCommon58:                                // クリニックモード あいさつ画面音声
        return qcashierJsonFile.common.clinic_greeting_sound;
      case fConTblMsgQcCommon60:                                // マイバッグ仕様時 登録開始画面の１ボタン表示
        return qcashierJsonFile.common.startdsp_btn_single;
      case fConTblMsgQcCommon61:                                // 登録開始画面のスキャナ読込
        return qcashierJsonFile.common.startdsp_scan_enable;
      case fConTblMsgQcCommon70:                                // Verifone端末でNFCクレジットを利用
        return qcashierJsonFile.common.verifone_nfc_crdt;
      case fConTblMsgQcCommon71:                                // HappySelf 店員側の表示
        return qcashierJsonFile.common.hs_dualdisp_chk;
      case fConTblMsgQcCommon73:                                // Happyフルセルフ登録画面での登録操作無時警告
        return qcashierJsonFile.common.NoOperationWarning;
      case fConTblMsgQcCommon74:                                // 登録操作無時、ｻｲﾝﾎﾟｰﾙ点灯までの経過時間（秒）
        return qcashierJsonFile.common.NoOperationSignpaul_time;
      case fConTblMsgQcCommon75:                                // 登録操作無時、ｻｲﾝﾎﾟｰﾙ点灯後、音声案内までの経過時間（秒）
        return qcashierJsonFile.common.NoOperationVoicesound_time;
      case fConTblMsgQcCommon76:                                // 登録操作無時音
        return qcashierJsonFile.common.NoOperationSound;
      case fConTblMsgQcCommon79:                                // レセコンバーコード読み取り後会計画面に自動遷移
        return qcashierJsonFile.common.clinic_auto_stl;
      case fConTblMsgQcCommon86:                                // マイバッグ仕様 PLUコード
      // TODO: ベルジョイス仕様
        return qcashierJsonFile.common.mybag_plu_point_add;
      case fConTblMsgQcSagUseClass:                             // 部門登録時の分類キー
        return qcashierJsonFile.common.regs_use_class;
      case fConTblMsgQcCommon91:                                // フルセルフ イートイン対応
        return qcashierJsonFile.common.sg_eatin_chk;
      case fConTblMsgQcCommon92:                                // フルセルフ 無操作時、登録内容の自動取消
        return qcashierJsonFile.common.selfmode1_auto_cancel;
      case fConTblMsgQcCommon98:                                // レジ袋入力画面表示タイミング
        return qcashierJsonFile.common.regbag_timing;
      case fConTblMsgQcCommon99:                                // レジ袋入力画面 戻るボタン表示
        return qcashierJsonFile.common.regbag_disp_back_btn;
      case fConTblMsgQcCommon100:                               // フルセルフ 合計点数 音声読み上げ
        return qcashierJsonFile.common.selfmode1_wav_qty;
      case fConTblMsgQcCommon102:                               // プリカ残高照会ボタン表示
        return qcashierJsonFile.common.self_disp_preca_ref;
      case fConTblMsgQcCommon103:                               // フルセルフ スタート画面の背景色変更
        return qcashierJsonFile.common.fs_cashless_dsp_change;
      case fConTblMsgQcCommon104:                               // フルセルフ 登録画面のガイダンス変更
        return qcashierJsonFile.common.hs_fs_scanning_guide;
      case fConTblMsgQcCommon105:                               // フルセルフ 同一商品連続スキャン時、警告表示
        return qcashierJsonFile.common.hs_fs_twice_read_stop;
      case fConTblMsgQcCommon106:                               // フルセルフ・精算機 現金入金時に入金額を読み上げ
        return qcashierJsonFile.common.cashin_sound;
      case fConTblMsgQcCommon114:                               // 未精算時に再生する警告音を変更
        return qcashierJsonFile.common.sound_change_flg;
      case fConTblMsgQcCommonFsBagSetDsp:                       // フルセルフ レジ袋セット画面表示
        return qcashierJsonFile.common.fs_bag_set_dsp;
      case fConTblMsgQcCommonCashlessDspShow:                   // フルセルフ キャッシュレス案内画面表示
        return qcashierJsonFile.common.cashless_dsp_show;
      case fConTblMsgQcCommon117:                               // フルセルフ 登録開始時プリセット画面に自動遷移
        return qcashierJsonFile.common.hs_fs_auto_preset_dsp;
      case fConTblMsgQcCommon119:                               // 現金対応レジ案内画面の表示時間(秒)
        return qcashierJsonFile.common.cashless_dsp_return;
      case fConTblMsgQcCommon124:                               // 店員呼出ボタンを表示（G3のみ）
        return qcashierJsonFile.common.g3_employee_call_btn;
      case fConTblMsgQcCommon187:                               // フルセルフ 金種商品の登録許可
        return qcashierJsonFile.common.rg_self_noteplu_perm;
      case fConTblMsgQcCommon188:                               // フルセルフ 商品登録画面で画面訂正する(G3縦型のみ)
        return qcashierJsonFile.common.g3_self_itemlist_scrvoid;
      case fConTblMsgQcCommon189:                               // 年齢確認商品登録時に再生する音声を変更
        return qcashierJsonFile.common.callBuzzer_sound_change_flg;
      case fConTblMsgQcCommon169:                               // G3フルセルフ プリセットグループボタンの任意設定
        return qcashierJsonFile.common.g3_fs_presetgroup_custom;
      case fConTblMsgQcCommon170:                               // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ1のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
        return qcashierJsonFile.common.g3_fs_presetgroup_btn1;
      case fConTblMsgQcCommon171:                               // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ2のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
        return qcashierJsonFile.common.g3_fs_presetgroup_btn2;
      case fConTblMsgQcCommon172:                               // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ3のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
        return qcashierJsonFile.common.g3_fs_presetgroup_btn3;
      case fConTblMsgQcCommon173:                               // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ4のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
        return qcashierJsonFile.common.g3_fs_presetgroup_btn4;
      case fConTblMsgQcCommon174:                               // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ5のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
        return qcashierJsonFile.common.g3_fs_presetgroup_btn5;
      case fConTblMsgQcCommon175:                               // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ6のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
        return qcashierJsonFile.common.g3_fs_presetgroup_btn6;
      case fConTblMsgQcCommon176:                               // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ7のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
        return qcashierJsonFile.common.g3_fs_presetgroup_btn7;
      case fConTblMsgQcCommon177:                               // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ8のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
        return qcashierJsonFile.common.g3_fs_presetgroup_btn8;
      case fConTblMsgQcCommonArcsPaymentMbrRead:                // フルセルフ及びShop&Go 後会員仕様
        return qcashierJsonFile.common.arcs_payment_mbr_read;
      case fConTblMsgQcCommon192:                               // G3フルセルフでマッピングを画面上部に表示
        return qcashierJsonFile.common.top_map_display;
      case fConTblMsgQcCommon197:                               // 待機中サインポール点灯色
        return qcashierJsonFile.common.idle_signp_state;
      case fConTblMsgQcCommon208:                               // キャッシュバック 無操作時、登録内容の自動取消(秒)
        return qcashierJsonFile.common.cashback_auto_cancel;
      case fConTblMsgQcCommon209:                               // 年齢確認端末での年齢確認を強制(G3縦型のみ)
        return qcashierJsonFile.common.force_agecheck;
      case qCashierIniInputRegBagClsCD:                         // レジ袋の分類コード
        return qcashierJsonFile.common.regbag_clscd;
      case fConTblMsgQcCommon215:                               // 会計選択画面でのバーコード読取制御
        return qcashierJsonFile.common.select_dsp_scan_ctrl;
      case fConTblMsgQcCommon216:                               // キャッシュバック 従業員呼出金額(円)
        return qcashierJsonFile.common.cashback_call_limit;
      case fConTblMsgQcCommon217:                               // プリペイドの選択ボタンの画像対応
        return qcashierJsonFile.common.preca_image_btn;
      case fConTblMsgQcCommon218:                               // 精算機/フルセルフ取引レシート印字
        return qcashierJsonFile.common.change_after_receipt;
      case fConTblMsgQcCommon219:                               // 合計金額の音声読み上げ
        return qcashierJsonFile.common.total_amt_voice_ctrl;
      case fConTblMsgQcCommon220:                               // 釣銭精査必要時のサインポール黄色と水色点滅(LED型のみ)
        return qcashierJsonFile.common.check_change_signp;
    }
  }

  /// 設定ファイルに設定値を設定
  void _setJsonData(QcashierJsonFile qcashierJsonFile, String key, dynamic value) {
    switch (key) {
      case fConTblMsgQcCommon11:                                // 初期言語選択
        qcashierJsonFile.common.language_typ = value;
      case fConTblMsgQcChgInfo1:                                // 釣銭釣札機のニアエンドによる休止
        qcashierJsonFile.chg_info.chg_info = value;
      case fConTblMsgQcChgInfo2:                                // 釣銭機ニアフル差分枚数
        qcashierJsonFile.chg_info.chg_info_full_chk = value;
      case fConTblMsgQcChgInfo3:                                // 釣銭機ニアフルサインポール点灯差分枚数
        qcashierJsonFile.chg_info.chg_signp_full_chk = value;
      case fConTblMsgQcCommon27:                                // 領収書発行ボタン表示
        qcashierJsonFile.common.rfm_receipt = value;
      case fConTblMsgQcCommon34:                                // 合計額＝お預かり金額時　一定時間経過後の動作
        qcashierJsonFile.common.autocash_operation = value;
      case fConTblMsgQcCommon35:                                // 合計額＝お預かり金額時 経過時間（秒）
        qcashierJsonFile.common.autocash_equaltime = value;
      case fConTblMsgQcCommon36:                                // 合計額＜お預かり金額時 経過時間（秒）
        qcashierJsonFile.common.autocash_overtime = value;
      case fConTblMsgQcCommon54:                                // 取消ボタン表示
        qcashierJsonFile.common.cancel_btn_dsp = value;
      case expCommonPrecaChargeOnly:                            // プリカチャージのみの実施
        qcashierJsonFile.common.preca_charge_only = value;
      case fConTblMsgQcCommon55:                                // クリニックモード
        qcashierJsonFile.common.clinic_mode = value;
      case fConTblMsgQcCommon56:                                // クリニックモード レシート印字
        qcashierJsonFile.common.clinic_receipt = value;
      case fConTblMsgQcCommon57:                                // クリニックモード あいさつ画面
        qcashierJsonFile.common.clinic_greeting = value;
      case fConTblMsgQcCommon58:                                // クリニックモード あいさつ画面音声
        qcashierJsonFile.common.clinic_greeting_sound = value;
      case fConTblMsgQcCommon60:                                // マイバッグ仕様時 登録開始画面の１ボタン表示
        qcashierJsonFile.common.startdsp_btn_single = value;
      case fConTblMsgQcCommon61:                                // 登録開始画面のスキャナ読込
        qcashierJsonFile.common.startdsp_scan_enable = value;
      case fConTblMsgQcCommon70:                                // Verifone端末でNFCクレジットを利用
        qcashierJsonFile.common.verifone_nfc_crdt = value;
      case fConTblMsgQcCommon71:                                // HappySelf 店員側の表示
        qcashierJsonFile.common.hs_dualdisp_chk = value;
      case fConTblMsgQcCommon73:                                // Happyフルセルフ登録画面での登録操作無時警告
        qcashierJsonFile.common.NoOperationWarning = value;
      case fConTblMsgQcCommon74:                                // 登録操作無時、ｻｲﾝﾎﾟｰﾙ点灯までの経過時間（秒）
        qcashierJsonFile.common.NoOperationSignpaul_time = value;
      case fConTblMsgQcCommon75:                                // 登録操作無時、ｻｲﾝﾎﾟｰﾙ点灯後、音声案内までの経過時間（秒）
        qcashierJsonFile.common.NoOperationVoicesound_time = value;
      case fConTblMsgQcCommon76:                                // 登録操作無時音
        qcashierJsonFile.common.NoOperationSound = value;
      case fConTblMsgQcCommon79:                                // レセコンバーコード読み取り後会計画面に自動遷移
        qcashierJsonFile.common.clinic_auto_stl = value;
      case fConTblMsgQcCommon86:                                // マイバッグ仕様 PLUコード
      // TODO: ベルジョイス仕様
        qcashierJsonFile.common.mybag_plu_point_add = value;
      case fConTblMsgQcSagUseClass:                             // 部門登録時の分類キー
        qcashierJsonFile.common.regs_use_class = value;
      case fConTblMsgQcCommon91:                                // フルセルフ イートイン対応
        qcashierJsonFile.common.sg_eatin_chk = value;
      case fConTblMsgQcCommon92:                                // フルセルフ 無操作時、登録内容の自動取消
        qcashierJsonFile.common.selfmode1_auto_cancel = value;
      case fConTblMsgQcCommon98:                                // レジ袋入力画面表示タイミング
        qcashierJsonFile.common.regbag_timing = value;
      case fConTblMsgQcCommon99:                                // レジ袋入力画面 戻るボタン表示
        qcashierJsonFile.common.regbag_disp_back_btn = value;
      case fConTblMsgQcCommon100:                               // フルセルフ 合計点数 音声読み上げ
        qcashierJsonFile.common.selfmode1_wav_qty = value;
      case fConTblMsgQcCommon102:                               // プリカ残高照会ボタン表示
        qcashierJsonFile.common.self_disp_preca_ref = value;
      case fConTblMsgQcCommon103:                               // フルセルフ スタート画面の背景色変更
        qcashierJsonFile.common.fs_cashless_dsp_change = value;
      case fConTblMsgQcCommon104:                               // フルセルフ 登録画面のガイダンス変更
        qcashierJsonFile.common.hs_fs_scanning_guide = value;
      case fConTblMsgQcCommon105:                               // フルセルフ 同一商品連続スキャン時、警告表示
        qcashierJsonFile.common.hs_fs_twice_read_stop = value;
      case fConTblMsgQcCommon106:                               // フルセルフ・精算機 現金入金時に入金額を読み上げ
        qcashierJsonFile.common.cashin_sound = value;
      case fConTblMsgQcCommon114:                               // 未精算時に再生する警告音を変更
        qcashierJsonFile.common.sound_change_flg = value;
      case fConTblMsgQcCommonFsBagSetDsp:                         // フルセルフ レジ袋セット画面表示
        qcashierJsonFile.common.fs_bag_set_dsp = value;
      case fConTblMsgQcCommonCashlessDspShow:                     // フルセルフ キャッシュレス案内画面表示
        qcashierJsonFile.common.cashless_dsp_show = value;
      case fConTblMsgQcCommon117:                               // フルセルフ 登録開始時プリセット画面に自動遷移
        qcashierJsonFile.common.hs_fs_auto_preset_dsp = value;
      case fConTblMsgQcCommon119:                               // 現金対応レジ案内画面の表示時間(秒)
        qcashierJsonFile.common.cashless_dsp_return = value;
      case fConTblMsgQcCommon124:                               // 店員呼出ボタンを表示（G3のみ）
        qcashierJsonFile.common.g3_employee_call_btn = value;
      case fConTblMsgQcCommon187:                               // フルセルフ 金種商品の登録許可
        qcashierJsonFile.common.rg_self_noteplu_perm = value;
      case fConTblMsgQcCommon188:                               // フルセルフ 商品登録画面で画面訂正する(G3縦型のみ)
        qcashierJsonFile.common.g3_self_itemlist_scrvoid = value;
      case fConTblMsgQcCommon189:                               // 年齢確認商品登録時に再生する音声を変更
        qcashierJsonFile.common.callBuzzer_sound_change_flg = value;
      case fConTblMsgQcCommon169:                               // G3フルセルフ プリセットグループボタンの任意設定
        qcashierJsonFile.common.g3_fs_presetgroup_custom = value;
      case fConTblMsgQcCommon170:                               // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ1のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
        qcashierJsonFile.common.g3_fs_presetgroup_btn1 = value;
      case fConTblMsgQcCommon171:                               // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ2のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
        qcashierJsonFile.common.g3_fs_presetgroup_btn2 = value;
      case fConTblMsgQcCommon172:                               // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ3のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
        qcashierJsonFile.common.g3_fs_presetgroup_btn3 = value;
      case fConTblMsgQcCommon173:                               // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ4のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
        qcashierJsonFile.common.g3_fs_presetgroup_btn4 = value;
      case fConTblMsgQcCommon174:                               // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ5のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
        qcashierJsonFile.common.g3_fs_presetgroup_btn5 = value;
      case fConTblMsgQcCommon175:                               // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ6のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
        qcashierJsonFile.common.g3_fs_presetgroup_btn6 = value;
      case fConTblMsgQcCommon176:                               // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ7のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
        qcashierJsonFile.common.g3_fs_presetgroup_btn7 = value;
      case fConTblMsgQcCommon177:                               // ﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟﾎﾞﾀﾝ8のﾌﾟﾘｾｯﾄｸﾞﾙｰﾌﾟｺｰﾄ
        qcashierJsonFile.common.g3_fs_presetgroup_btn8 = value;
      case fConTblMsgQcCommonArcsPaymentMbrRead:             // フルセルフ及びShop&Go 後会員仕様
        qcashierJsonFile.common.arcs_payment_mbr_read = value;
      case fConTblMsgQcCommon192:                               // G3フルセルフでマッピングを画面上部に表示
        qcashierJsonFile.common.top_map_display = value;
      case fConTblMsgQcCommon197:                               // 待機中サインポール点灯色
        qcashierJsonFile.common.idle_signp_state = value;
      case fConTblMsgQcCommon208:                               // キャッシュバック 無操作時、登録内容の自動取消(秒)
        qcashierJsonFile.common.cashback_auto_cancel = value;
      case fConTblMsgQcCommon209:                               // 年齢確認端末での年齢確認を強制(G3縦型のみ)
        qcashierJsonFile.common.force_agecheck = value;
      case qCashierIniInputRegBagClsCD:                         // レジ袋の分類コード
        qcashierJsonFile.common.regbag_clscd = value;
      case fConTblMsgQcCommon215:                               // 会計選択画面でのバーコード読取制御
        qcashierJsonFile.common.select_dsp_scan_ctrl = value;
      case fConTblMsgQcCommon216:                               // キャッシュバック 従業員呼出金額(円)
        qcashierJsonFile.common.cashback_call_limit = value;
      case fConTblMsgQcCommon217:                               // プリペイドの選択ボタンの画像対応
        qcashierJsonFile.common.preca_image_btn = value;
      case fConTblMsgQcCommon218:                               // 精算機/フルセルフ取引レシート印字
        qcashierJsonFile.common.change_after_receipt = value;
      case fConTblMsgQcCommon219:                               // 合計金額の音声読み上げ
        qcashierJsonFile.common.total_amt_voice_ctrl = value;
      case fConTblMsgQcCommon220:                               // 釣銭精査必要時のサインポール黄色と水色点滅(LED型のみ)
        qcashierJsonFile.common.check_change_signp = value;
    }
  }
}
