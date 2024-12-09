/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../postgres_library/src/db_manipulation_ps.dart';

/// 関連tprxソース: rcmbrkytcktmain.c
class RcMbrKyTcktMain {
  /// Display Position: customer number (input for 10.4in LCD)
  static const LCDCUSTINP = 1;
  /// Display Position: ticket issue (management for 10.4in LCD)
  static const LCDTKISSSU = 2;
  /// Display Position: customer number (input for 5.7in LCD)
  static const SLCDCUSTINP = 3;
  /// Display Position: ticket issue (management for 5.7in LCD)
  static const SLCDTKISSU = 4;

  static TcktIssuInfo tkIssu = TcktIssuInfo();

  /// 5.7in - 10.4in チケット発行LCD画面判定チェック
  /// 戻り値: 0=5.7 LCD  1=10.4 LCD
  /// 関連tprxソース: rcmbrkytcktmain.c - rcmbrChkTcktIssuMode
  static int rcmbrChkTcktIssuMode() {
    if ((tkIssu.display == LCDCUSTINP) || (tkIssu.display == LCDTKISSSU)) {
      return 1;
    }
    return 0;
  }
}

/// 関連tprxソース: rcmbrkytcktmain.h - Tcktissu_Info
class TcktIssuInfo {
  //GtkWidget      *window_custin;
  //GtkWidget      *window_tkissu;
  //GtkWidget      *TitleBar;
  //GtkWidget      *button1;
  //GtkWidget      *button2;
  //GtkWidget      *button3;
  //GtkWidget      *button4;
  //GtkWidget      *button5;/* add 07.04.26 */
  //GtkWidget      *entry1;
  //GtkWidget      *entry2;
  //GtkWidget      *entry3;
  //GtkWidget      *entry4;
  //GtkWidget      *entry5;/* add 07.04.26 */
  //GtkWidget      *entry6;
  //GtkWidget      *com1;
  //GtkWidget      *com2;
  //GtkWidget      *com3;
  //GtkWidget      *com4;
  //GtkWidget      *com5;
  //GtkWidget      *IntBtn;
  //GtkWidget      *ExecBtn;
  //GtkWidget      *ExitBtn;
  //GtkWidget      *RegularBtn;
  //GtkWidget      *wFixed;
  //GtkWidget      *Label;
  //GtkWidget      *lblbirth;
  /// 呼出番号（会員入力画面）
  String entryText1 = "";
  /// 電話番号（会員入力画面）
  String entryText2 = "";
  /// 会員番号（会員入力画面）
  String entryText3 = "";
  /// 磁気カード（会員入力画面）
  String entryText4 = "";
  /// Input point entry text
  String entryText5 = "";
  /// 誕生月（顧客リアルサーバー時会員入力画面）
  String entryText6 = "";
  /// 誕生月（顧客リアルサーバー時会員入力画面）
  String entryText7 = "";
  /// Customer name text
  String comText1 = "";
  /// 期間対象額（買上追加画面）
  String comText2 = "";
  /// 期間対象ポイント（買上追加画面）
  String comText3 = "";
  /// Term issue text
  String comText4 = "";
  /// Term after text
  String comText5 = "";
  /// Position number
  ///  0 - Call number btn position
  ///  1 - Telephone number btn position
  ///  2 - Cust numbe btn position
  ///  3 - Magnetic card btn position
  ///  4 - Customer input display (push input key position)
  ///  5 - Point input btn position
  int posNo = 0;
  /// Now display position
  int display = 0;
  /// Function Code
  int fncCode = 0;
  /// Input Customer Code
  int mbrInput = 0;
  /// Title
  String title = "";
  /// DB - 顧客マスタ (c_mbrcard_mst)
  CCustMst cust = CCustMst();
  /// DB - 顧客別累計購買情報テーブル (s_cust_ttl_tbl)
  SCustTtlTbl enq = SCustTtlTbl();
  /// DB - 顧客別累計購買情報テーブル (s_cust_ttl_tbl)
  SCustTtlTbl enqParent = SCustTtlTbl();
  /// DB - プロモーションスケジュールマスタ (p_promsch_mst)
  PPromschMst svs = PPromschMst();
  ///
  int skTotalBuyRslt = 0;
  ///
  int skTotalPoint = 0;
  ///
  String cardDataJis2 = "";
  //GtkWidget *CogcaIcBtn;		/* CoGCa IC顧客読込ボタン */
  /// CoGCa IC顧客読み画面フラグ
  int	icdspFlg = 0;
  //GtkWidget      *MsReadBtn;           /* 磁気読込ボタン */
}