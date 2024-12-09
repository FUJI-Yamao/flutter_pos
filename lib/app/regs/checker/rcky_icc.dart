/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class RckyIcc{

  /// TODO:00014 日向 現計対応のため定義のみ先行追加
  /// 関連tprxソース: rcky_icc.c - rc_ICC_CashDeposit()
  static int rcICCCashDeposit(){
    return 0;
  }

  //実装は必要だがARKS対応では除外
/// 関連tprxソース:rcky_icc.c - rcChk_Sptend_crdt_enble_flg

    static int rcChkSptendCrdtEnbleFlg(int sptend_cd) {
      return 0;
    }
}

