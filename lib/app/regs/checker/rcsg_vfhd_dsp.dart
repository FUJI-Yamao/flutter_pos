/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///  関連tprxソース: rcsg_vfhd_dsp.c
class RcsgVfhdDsp {
  static int aibox_prog_stop_flg = 0;	/* AIBOXへのステータスコード108, 109二度通知させない為のフラグ(0=通知NG, 1通知OK) */
  static int aibox_prog_start_flg = 0;	/* AIBOXプログラム起動中かどうか(0=未起動, 1=起動中) */
  static int total_scan_cnt = 0;

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側処理）
  /// 15.6インチフルセルフ用のアイテムリスト画面を表示する
  /// 関連tprxソース:rcsg_vfhd_dsp.c - rcSG_VFHD_ItemList_Dsp
  static void rcSGVFHDItemListDsp() {}
}