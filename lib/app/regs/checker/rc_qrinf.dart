/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

enum QrTxtStatus {
  QR_TXT_STATUS_INIT(0),
  QR_TXT_STATUS_CHK(1),
  QR_TXT_STATUS_NEXT(2),
  QR_TXT_STATUS_READ(3);
  final int id;
  const QrTxtStatus(this.id);
}

///  関連tprxソース: rc_qrinf.h
class RcQrinf {
   static int qrSrcregFlg = 0;
}

///  関連tprxソース: rc_qrinf.h
class RcQrinfConst {
  static const int QRTXT_PAGE_MAX = 100;
}

/// 関連tprxソース: rc_qrinf.h QRTXT_PAGE
class QrtxtPage {
  int macNo = 0;
  int reciptNo = 0;
  int page = 0;
  int readFlg = 0;
  String qrTxtPath = "";
}

/// 関連tprxソース: rc_qrinf.h QRTXT_INFO
class QrtxtInfo {
  int maxPage = 0;
  int nowReadPage = 0;
  int bfrReadPage = 0;
  List<QrtxtPage> data =
      List.filled(RcQrinfConst.QRTXT_PAGE_MAX, QrtxtPage());
}
