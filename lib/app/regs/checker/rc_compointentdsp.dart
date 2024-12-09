/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class RcCompointentdsp{
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// ポイント利用画面表示チェック
  /// 関連tprxソース:C rc_compointentdsp.c - rc_ComPoint_EntDsp_Skip()
  /// 引数: ファンクションキーコード
  /// 戻り値: true: ポイント利用画面表示可能, false: ポイント利用画面表示不可
  static bool rcComPointEntDspSkip(int code){
    return false;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// ポイント利用が可能かチェックする
  /// 関連tprxソース:C rc_compointentdsp.c - rc_ComPoint_UseCheck()
  /// 引数: int pntTyp: ポイント種別
  /// 戻り値: true: 利用可能, false: 利用不可
  static int rcComPointUseCheck(int pntTyp){
    return 0;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// ポイント利用画面エラーチェック
  /// 関連tprxソース:C rc_compointentdsp.c - rc_ComPoint_EntDsp
  /// 引数: int pntTyp: ポイント種別
  /// 戻り値: エラーコード
  static int rcComPointEntDsp(int pntTyp){
    return 0;
  }

}
