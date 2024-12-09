/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///メッセージ系の定義.
//関連tprxソース: rxmem.h

/// メッセージマスタインデックス
/// ※indexとidは別です.indexだと０始まりの値なので、idから値を取得してください.
///関連tprxソース: rxmem.h - DB_MSGMST_IDX
enum DbMsgMstId {
  DB_MSGMST_RCPTHEADER1(1), // レシートヘッダー1 100
  DB_MSGMST_RCPTHEADER2(2), // レシートヘッダー2 101
  DB_MSGMST_RCPTHEADER3(3), // レシートヘッダー3 102
  DB_MSGMST_RCPTFOOTER1(4), // レシートフッター1 200
  DB_MSGMST_RCPTFOOTER2(5), // レシートフッター2
  DB_MSGMST_RCPTFOOTER3(6), // レシートフッター3
  DB_MSGMST_GRNTHEADER1(7), // 保証書ヘッダー1
  DB_MSGMST_GRNTHEADER2(8), // 保証書ヘッダー2
  DB_MSGMST_SVCHEADER1(9), // サービスチケットヘッダー1
  DB_MSGMST_SVCHEADER2(10), // サービスチケットヘッダー2
  DB_MSGMST_SVCFOOTER1(11), // サービスチケットフッター1
  DB_MSGMST_SVCFOOTER2(12), // サービスチケットフッター2
  DB_MSGMST_BUYTCKT1(13), // 買上チケット1
  DB_MSGMST_BUYTCKT2(14), // 買上チケット2
  DB_MSGMST_REWRITECM1(15), // リライトカードCM1
  DB_MSGMST_REWRITECM2(16), // リライトカードCM2
  DB_MSGMST_NOTETCKT1(17), // 金券チケット1
  DB_MSGMST_NOTETCKT2(18), // 金券チケット2
  DB_MSGMST_CHGTCKT1(19), // 釣銭チケット1
  DB_MSGMST_CHGTCKT2(20), // 釣銭チケット2
  DB_MSGMST_HESOTCKT1(21), // へそくりチケット1
  DB_MSGMST_HESOTCKT2(22), // へそくりチケット2
  DB_MSGMST_RPRTHEADER(23), // レポートヘッダー
  DB_MSGMST_RSRVFOOTER1(24), // 予約レシートフッター1
  DB_MSGMST_RSRVFOOTER2(25), // 予約レシートフッター2
  DB_MSGMST_QCSELECTSTART(26), // QC指定専用時のスタートメッセージ
  DB_MSGMST_CUSTOFFLINE(27), // オフライン顧客印字
  DB_MSGMST_CUSTLOCK(28), // ロック中顧客印字
  DB_MSGMST_PORTAL_CONF1(29), // ポータル認証印字1
  DB_MSGMST_PORTAL_CONF2(30), // ポータル認証印字2
  DB_MSGMST_PORTAL_CONF3(31), // ポータル認証印字3
  DB_MSGMST_RFM_ISSUEINFO(32), // 領収書発行者情報
  DB_MSGMST_QCTICKETFOOTER(33), // お会計券フッター
  DB_MSGMST_QCTICKETCHANGEFOOTER(34), // お会計券おつりフッター
  DB_MSGMST_QCTICKETLOGO(35), // お会計券ロゴ
  DB_MSGMST_SPECIAL1(36), // 特注メッセージ印字用1
  DB_MSGMST_SPECIAL2(37), // 特注メッセージ印字用2
  DB_MSGMST_SPECIAL3(38), // 特注メッセージ印字用3
  DB_MSGMST_SPECIAL4(39), // 特注メッセージ印字用4
  DB_MSGMST_SPECIAL5(40), // 特注メッセージ印字用5
  DB_MSGMST_INOUTHEADER(41), // 入出金レシートヘッダー
  DB_MSGMST_CUSTLAY1(42), // 客層キー1での印字
  DB_MSGMST_CUSTLAY2(43), //   〃  2での印字
  DB_MSGMST_CUSTLAY3(44), //   〃  3での印字
  DB_MSGMST_CUSTLAY4(45), //   〃  4での印字
  DB_MSGMST_CUSTLAY5(46), //   〃  5での印字
  DB_MSGMST_CUSTLAY6(47), //   〃  6での印字
  DB_MSGMST_CUSTLAY7(48), //   〃  7での印字
  DB_MSGMST_CUSTLAY8(49), //   〃  8での印字
  DB_MSGMST_CUSTLAY9(50), //   〃  9での印字
  DB_MSGMST_CUSTLAY10(51), //   〃  10での印字
  DB_MSGMST_COPY_ERR_ATTEND(52), // 開設画面でマスタ取得が失敗した時のエラー印字
  DB_MSGMST_CERTHEADER(53), // 販売証明書ヘッダー
  DB_MSGMST_TAXFREE_OFFICE(54), // 免税所轄税務署
  DB_MSGMST_TAXFREE_PLACE(55), // 免税納税地
  DB_MSGMST_TAXFREE_SELLER(56), // 免税販売者氏名
  DB_MSGMST_TAXFREE_SELLINGPLACE(57), // 免税販売場所在地
  DB_MSGMST_CLASS1_MSG(58), // 第1類ﾒｯｾｰｼﾞ
  DB_MSGMST_HORIZONTAL_TCKT_MSG(59), // 横型ﾁｹｯﾄﾒｯｾｰｼﾞ
  DB_MSGMST_SAG_QR_DL_PRINT(60),
  DB_MSGMST_RCPT_MAIL_HEADER(61), // レシート電子メール本文ヘッダ
  DB_MSGMST_RCPT_MAIL_FOOTER(62), // レシート電子メール本文フッター
  DB_MSGMST_TPOINT1(63), // Tﾎﾟｲﾝﾄﾒｯｾｰｼﾞ1
  DB_MSGMST_TPOINT2(64), // Tﾎﾟｲﾝﾄﾒｯｾｰｼﾞ2
  DB_MSGMST_TPOINT3(65), // Tﾎﾟｲﾝﾄﾒｯｾｰｼﾞ3
  DB_MSGMST_TCOUPON(66), // Tｸｰﾎﾟﾝﾒｯｾｰｼﾞ
  DB_MSGMST_TMONEY(67), // Tﾏﾈｰﾒｯｾｰｼﾞ
  DB_MSGMST_MBRSCAN_GUIDE(68), //  対面客側顧客読取(案内)
  DB_MSGMST_MBRSCAN_REJECT(69), //  対面客側顧客読取(拒否)
  DB_MSGMST_MBRSCAN_INPUT(70); //  対面客側顧客読取(入力)

  // 100-109はFIP
  // 200-209はカラーFIP
  static get DB_MSGMST_MAX => DbMsgMstId.values.last.id + 1;

  final int id;
  const DbMsgMstId(this.id);
}

/// FIP.
///関連tprxソース: rxmem.h - DB_MSGMST_FIP_IDX
enum DbMsgMstFipId {
  DB_MSGMST_FIP1(0), // FIP1
  DB_MSGMST_FIP2(1), // FIP2
  DB_MSGMST_FIP3(2), // FIP3
  DB_MSGMST_FIP4(3), // FIP4
  DB_MSGMST_FIP5(4), // FIP5
  DB_MSGMST_FIP6(5), // FIP6
  DB_MSGMST_FIP7(6), // FIP7
  DB_MSGMST_FIP8(7), // FIP8
  DB_MSGMST_FIP9(8), // FIP9
  DB_MSGMST_FIP10(9); // FIP10

  // 100-109はFIP
  // 200-209はカラーFIP
  static get DB_MSGMST_FIP_MAX => DbMsgMstFipId.values.last.id + 1;

  // 100<= posi <=109 がFIP
  static get startPosi => 100;
  static get endPosi => 109;

  final int id;
  const DbMsgMstFipId(this.id);
  static bool isFipPosi(int posi) {
    return startPosi <= posi && posi <= endPosi;
  }

  static int getIdFromPosi(int posi) {
    switch (posi) {
      case 100:
        return DB_MSGMST_FIP1.id;
      case 101:
        return DB_MSGMST_FIP2.id;
      case 102:
        return DB_MSGMST_FIP3.id;
      case 103:
        return DB_MSGMST_FIP4.id;
      case 104:
        return DB_MSGMST_FIP5.id;
      case 105:
        return DB_MSGMST_FIP6.id;
      case 106:
        return DB_MSGMST_FIP7.id;
      case 107:
        return DB_MSGMST_FIP8.id;
      case 108:
        return DB_MSGMST_FIP9.id;
      case 109:
        return DB_MSGMST_FIP10.id;
      default:
        return posi;
    }
  }
}

/// カラーFIP.
///関連tprxソース: rxmem.h - DB_MSGMST_COLORDSP_IDX
enum DbMsgMstColorDspId {
  DB_MSGMST_COLORDSP1(0), // COLORFIP1
  DB_MSGMST_COLORDSP2(1), // COLORFIP2
  DB_MSGMST_COLORDSP3(2), // COLORFIP3
  DB_MSGMST_COLORDSP4(3), // COLORFIP4
  DB_MSGMST_COLORDSP5(4), // COLORFIP5
  DB_MSGMST_COLORDSP6(5), // COLORFIP6
  DB_MSGMST_COLORDSP7(6), // COLORFIP7
  DB_MSGMST_COLORDSP8(7), // COLORFIP8
  DB_MSGMST_COLORDSP9(8), // COLORFIP9
  DB_MSGMST_COLORDSP10(9); // COLORFIP10

  static get DB_MSGMST_COLORDSP_MAX => DbMsgMstColorDspId.values.last.id + 1;

  // 200<= posi <=209 がカラーFIP
  static get startPosi => 200;
  static get endPosi => 209;

  final int id;

  const DbMsgMstColorDspId(this.id);

  static bool isColorFipPosi(int posi) {
    return startPosi <= posi && posi <= endPosi;
  }

  static getIdFromPosi(int posi) {
    switch (posi) {
      case 200:
        return DB_MSGMST_COLORDSP1.id;
      case 201:
        return DB_MSGMST_COLORDSP2.id;
      case 202:
        return DB_MSGMST_COLORDSP3.id;
      case 203:
        return DB_MSGMST_COLORDSP4.id;
      case 204:
        return DB_MSGMST_COLORDSP5.id;
      case 205:
        return DB_MSGMST_COLORDSP6.id;
      case 206:
        return DB_MSGMST_COLORDSP7.id;
      case 207:
        return DB_MSGMST_COLORDSP8.id;
      case 208:
        return DB_MSGMST_COLORDSP9.id;
      case 209:
        return DB_MSGMST_COLORDSP10.id;
      default:
        return posi;
    }
  }
}

// メッセージ種別リスト
enum DbMsgMstKindId {
  DB_MSGMST_KIND_MSG(0), // 印字メッセージ
  DB_MSGMST_KIND_BMP(1), // ビットマップ名称
  DB_MSGMST_KIND_URL(2), // URL
  DB_MSGMST_KIND_BARCODE(3), // バーコード
  DB_MSGMST_KIND_FIP_REST(4), // 静止FIP
  DB_MSGMST_KIND_FIP_TIME(5), // 時刻FIP
  DB_MSGMST_KIND_FIP_ACT(6), // スクロールFIP
  DB_MSGMST_KIND_URL_CUST_PLUS(7), // URL+ 会員番号+ パスワード
  DB_MSGMST_KIND_RESERVE_LIST(8), // 予約時の対象印字リスト

  DB_MSGMST_KIND_COLORDSP_REST(10), // 静止(カラー客表)
  DB_MSGMST_KIND_COLORDSP_TIME(11), // 時刻(カラー客表)
  DB_MSGMST_KIND_COLORDSP_ACT(12), // スクロール(カラー客表)
  DB_MSGMST_KIND_COLORDSP_FLASH(13), // 点滅(カラー客表)
  DB_MSGMST_KIND_COLORDSP_PICT(14), // 画像(カラー客表)
  DB_MSGMST_KIND_COLORDSP_PICT_REST(15); // 画像+メッセージ(カラー客表)

  final int id;
  const DbMsgMstKindId(this.id);
}
