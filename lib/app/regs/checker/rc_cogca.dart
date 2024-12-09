/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class RcCogca {
  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_cogca.c - rcKy_Cogca_Deposit()
  static void rcKyCogcaDeposit () {
    return ;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rc_cogca.c - rcCheck_Cogca_Deposit_Item()
  static int rcCheckCogcaDepositItem(int flg) {
    return 0;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rc_cogca.c - rcKy_Cogca_In()
  static void rcKyCogcaIn(){
    return;
  }

  // TODO:00011 周 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rc_cogca.c - rcCogca_DspFlg_Chk()
  static int rcCogcaDspFlgChk() {
    return 0;
  }

  // TODO checker関数実装のため、定義のみ追加
  /// 関連tprxソース: rc_cogca.c - rcKy_Cogca_Ref()
  static void rcKyCogcaRef() {
    return;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rc_cogca.c - rcCogca_After_Reserv_Call
  static void rcCogcaAfterReservCall() {
    return;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rc_cogca.c - rcKy_Cogca_Sales
  static int rcKyCogcaSales(int){
    return 0;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rc_cogca.c - rcCogca_Dsp
  static void rcCogcaDsp(){
    return ;
  }


  
}