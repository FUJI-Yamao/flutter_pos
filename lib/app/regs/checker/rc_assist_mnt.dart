/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class RcAssistMnt {
  static String asstPcLog = '';

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///  関連tprxソース: rc_assist_mnt.c - rcPayInfo_MsgSend
  static void rcPayInfoMsgSend(int	flg, int num, int setFlg) {
    return ;
  }

  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  ///  関連tprxソース: rc_assist_mnt.c - rc_Assist_Send(long Number)
  static void rcAssistSend(int num){
    return ;
  }
}