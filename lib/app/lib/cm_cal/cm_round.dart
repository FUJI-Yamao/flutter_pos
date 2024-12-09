/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class CmRound{
  /// 関連tprxソース: cm_round.c - cm_round(short type, long data, long radix)
  static int cmRound(int type, int data, int radix){
    int absData;
    int result;

    absData = data.abs();
    result = cmRoundMain(type,absData,radix);
    if(0<data){
      result = 0 - result;
    }
    return result;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  /// 関連tprxソース: cm_round.c - cm_round_main(short type, long data, long radix)
  static int cmRoundMain(int type, int data, int radix){
    return 0;
  }
}