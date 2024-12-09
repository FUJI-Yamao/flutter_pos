/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース:rc_gtkutil.h - DSP_INFO
class DspInfo {
  int ChgFlg = 0; // 変更フラグ 下記のdefine参照
  int Width = 0; // 幅
  int Height = 0; // 高さ*/
  Object? Window;
// GtkWidget  *Window;                // window
// GtkWidget  *Fixed;                 // Fixed
  int F_Color = 0; // ウィンド背景色  default:LightGray*/
  String Msg1 = ""; // ボタン1テキスト*/
  String Msg2 = ""; // ボタン2テキスト*/
  String Msg3 = ""; // ボタン3テキスト*/
  int B_Color1 = 0; // ボタン1色  default:Red*/
  int B_Color2 = 0; // ボタン2色  default:Navy*/
  late Function func1;
  late Function func2;
  late Function func3;
  int T_Imgcd = 0; // タイトルイメージNo
  String G_msg = ""; // ガイダンス
  int G_Color = 0; // ガイダンスキスト色
// GtkWidget  *Label1;
// GtkWidget  *Label2;
// GtkWidget	*Label3;
// GtkWidget	*Label4;
// GtkWidget  *Entry1;
// GtkWidget  *Entry2;
// GtkWidget	*jan_cd;
// GtkWidget	*mdl_btn;
// GtkWidget	*mdl_cd;
// GtkWidget	*mdl_name;
// GtkWidget	*sml_btn;
// GtkWidget	*sml_cd;
// GtkWidget	*sml_name;
// GtkWidget	*prc_img;
// GtkWidget	*sub_prc_img;
// GtkWidget	*inst_prc_img;
// GtkWidget	*inst_prc;
// GtkWidget	*Tax_Lbl;
// GtkWidget	*Tax_Btn;
  int dual_dsp = 0;
}

/// 関連tprxソース:rc_gtkutil.c
class RcGtkUtil {

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: rc_gtkutil.c - rcDrawLabel
  static Object? rcDrawLabel(Object? top, int color, String image, String name) {
    return null;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: rc_gtkutil.c - rcDrawButton
  static Object? rcDrawButton(Object? top, int bcolor, int tcolor, String image, String name, int size) {
    return null;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: rc_gtkutil.c - rcDrawEntry
  static Object? rcDrawEntry(Object? top, int ecolor, int mcolor, String name, int size, int textField) {
    return null;
  }

  // TODO:10154 釣銭機UI関連　中間 定義のみ追加
  ///  関連tprxソース: rc_gtkutil.c - rcDrawFix
  static Object? rcDrawFix(Object? top, int color, String name, int size) {
    return null;
  }
}