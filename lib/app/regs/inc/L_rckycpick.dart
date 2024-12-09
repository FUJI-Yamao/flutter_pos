/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///  関連tprxソース: L_rckycpick.h
class LRcKyCPick {
  /// #define Image Datas
  static const CHGINOUT_ZEROP = "    0枚";
  static const ALLPICK_LABEL = "全て";
  static const RESERVEPICK_LABEL = "残置";
  static const MANPICK_LABEL = "万券";
  static const BILLPICK_LABEL = "紙幣";
  static const COINPICK_LABEL = "硬貨";
  static const USERDATAPICK_LABEL = "設定\nﾃﾞｰﾀ";
  static const FULLPICK_LABEL = "フル\n金種";
  static const CASETPICK_LABEL = "カセ\nット";
  static const ALLPICK_SELECT = "「全て」選択中";
  static const RESERVEPICK_SELECT = "「残置」選択中";
  static const MANPICK_SELECT = "「万券」選択中";
  static const BILLPICK_SELECT = "「紙幣」選択中";
  static const COINPICK_SELECT = "「硬貨」選択中";
  static const USERDATAPICK_SELECT = "「設定ﾃﾞｰﾀ」選択中";
  static const FULLPICK_SELECT = "「フル金種」選択中";
  static const CASETPICK_SELECT = "「カセット」選択中";
  static const CPICK_LABEL = "回収枚数";
  static const NOW_LABEL = "回収前";
  static const AFTER_LABEL = "回収後";
  static const ALLOW_LABEL = "-->";
  static const CPICK_ACRMSG = "回収金額";
  static const CPICK_TTLMSG = "回収合計";
  static const CPICK_CASSETTEMSG = "カセット内金額";
  static const CPICKKIND_LABEL = "回収方法";
  static const CPICKEND_WARN = "回収作業を行いました。お金を\n回収して処理を終了させて下さい。";
  static const CPICKEND_WARN2 = "釣機側の動作完了を確認後、\nお金を回収して処理を終了させて\n下さい。";
  static const CPICKEND_WARN3 = "釣機側の動作完了を確認後、\nお金を回収して下さい。";
  static const CPICKEND_WAIT = "回収動作中です。\n回収カセットには触れないで下さい";
  static const CPICK_ING = "%s処理中";
  static const CPICK_CASET_INCLUDE = "カセット内金額含む";
  static const CPICK_RCPT_STOP = "レシート印字を中断しますか？";
  static const CPICK_RESERV_PRINT = "残置過不足情報を印字しますか？";
  static const CPICK_CASET_FULL_DLG = "釣機のエラー復旧後、「回収続行」\nボタンを押下して下さい。";
  static const CPICK_CASET_FULL_CONTINUE = "回収続行";
  static const CPICK_CASET_FULL_END = "回収\n終了";

  static const MSG_YEN = "円";
  static const MSG_BILL = "紙幣";
  static const MSG_COIN = "硬貨";
  static const CPICK_UNIT_SHT = "%i枚回収";
  static const CPICK_ALL_SHT = "全回収";
  static const CPICK_RESERV_SHT = "(回収残枚数：%i枚)";
}