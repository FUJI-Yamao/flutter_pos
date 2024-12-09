/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

// TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
class RcMbrRealsvr {
  static const CUSTREAL_MBRDSP_START = 1;

  static int custrealMbrdspFlg = 0;

  /// 関連tprxソース:rc_mbr_realsvr.c - rcCustRealOthUseMsgDsp()
  static void rcCustRealOthUseMsgDsp() {
    return;
  }

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース:rcmbrrealsvr.c - CustRealSvr_WaitChk()
  static int custRealSvrWaitChk() {
    return 0;
  }

  /// 関連tprxソース:rcmbrrealsvr.c - CustReal_MbrDspChk()
  static bool custRealMbrDspChk() {
    return (custrealMbrdspFlg == CUSTREAL_MBRDSP_START);
  }
}