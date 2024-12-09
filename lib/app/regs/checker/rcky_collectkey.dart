/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class RckyCollectKey{
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rcky_collectkey.c - rcCollectKey_Disp_Refresh2()
  static void rcCollectKeyDispRefresh2(String call_func){
    return;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rc_ext.h - rcCollectKey_Disp_Refresh()
  static void rcCollectKeyDispRefresh(){
    rcCollectKeyDispRefresh2("rcCollectKeyDispRefresh");
  }







}

///  関連tprxソース: rcky_collectkey.h - WINDOW_DISP_STATUS
enum WindowDispStatus {
  WINDOW_DISP_NON(0),
  WINDOW_DISP_SHOW(1),
  WINDOW_DISP_HIDE(2);

  final int value;

  const WindowDispStatus(this.value);
}