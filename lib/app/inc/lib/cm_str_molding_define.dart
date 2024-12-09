/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'cm_nedit.dart';

/// 関連tprxソース:cm_str_molding.h
class CmStrMoldingDef {
  static int JNALWIDTH = 54;
  static int ANS_LINE_MAX = 2;
  static int LINE_BUFSIZ_MAX = ((JNALWIDTH * 4) + 1);
  static int JNALBUFSIZ = ((JNALWIDTH * 4) + 1);
  static int RCPTWIDTH = 32;
  static int RCPTBUFSIZ = (((RCPTWIDTH + 2) * 4) + 1);
  static int MOLDIGN_BUF_SIZE = 256;	// 両端に文字を配置する関数で使用する, 一方のバッファサイズ
  // static int MOLDING_MAX_CNT = MOLDIGN_BUF_SIZE / CHARCODE_BYTE;	// 上記で最大にセットされる半角文字数

  static int IMGDATAADD_MAX	= 10;

  static int DATA_COUNT_DISABLE	= -1;

  static const DATA_PTN_NONE = 0;
  static const DATA_PTN_ST = 0x0001;
  static const DATA_PTN_END = 0x0002;
  static const DATA_PTN_CD = 0x0004;
  static const DATA_PTN_TEN = 0x0008;
  static const DATA_PTN_CUT = 0x0010;
  static const DATA_PTN_ADD1SPC = 0x0020;
  static const DATA_PTN_ST_BRA = 0x0040;
  static const DATA_PTN_END_BRA = 0x0080;
}

/// 関連tprxソース:cm_str_molding.h - t_ImgDataAddAns()
class TImgDataAddAns {
  int line_num = 0;
  List<String> line = List.generate(CmStrMoldingDef.ANS_LINE_MAX, (index) => '');
}

/// 関連tprxソース:cm_str_molding.h - t_ImgDataAdd()
class TImgDataAdd {
  int ptn = 0;
  int width = 0;		//1行の文字数指定。0:指定なしはJMALWIDTHとなる。
  int print_type = 0;	//印字種類指定。縦倍、横倍等。
  List<TImgData> imgData = List.generate(CmStrMoldingDef.IMGDATAADD_MAX, (_) => TImgData());
}

/// 関連tprxソース:cm_str_molding.h - t_ImgData()
class TImgData {
  int ptn = 0;
  int posi = 0;
  CmEditCtrl fCtrl = CmEditCtrl();
  int Edit_typ = 0;
  int typ = 0;
  int count = 0;
  int data = 0;
  int	bcd_len = 0;	//BCDデータの大きさ
  int digit = 0;
}

/// 関連tprxソース:cm_str_molding.h - Edit_Typs()
enum EditTyps {
  EDIT_TYP_NONE(0),
  EDIT_TYP_BCD(1),
  EDIT_TYP_BINARY(2),
  EDIT_TYP_BINARY_LL(3),
  EDIT_TYP_WEIGHT(4),
  EDIT_TYP_TOTALPRICE(5),
  EDIT_TYP_TOTALPRICE_LL(6),
  EDIT_TYP_UNITPRICE(7),
  EDIT_TYP_VOLUME(8),
  EDIT_TYP_MAX(9);

  final int id;
  const EditTyps(this.id);
}

/// 関連tprxソース:cm_str_molding.h - Data_Typs()
enum DataTyps {
  DATA_TYP_SHORT(0),
  DATA_TYP_INT(1),
  DATA_TYP_LONG(2),
  DATA_TYP_DOUBLE(3),
  DATA_TYP_CHAR(4),
  DATA_TYP_LONGLONG(5),
  DATA_TYP_IMGCD(6),
  DATA_TYP_MAX(7);

  final int id;
  const DataTyps(this.id);
}

/// 関連tprxソース:cm_str_molding.h - Data_Posi_Center_Typs()
enum DataPosiCenterTyps {
  DATA_SPC(0),
  DATA_POSI_CENTER_ASTERISK(1),
  DATA_POSI_CENTER_HYPHEN(2);

  final int id;
  const DataPosiCenterTyps(this.id);
}

/// 関連tprxソース:cm_str_molding.h - Data_Posi_Typs()
enum DataPosiTyps {
  DATA_POSI_RIGHT(-2),
  DATA_POSI_CENTER(-1),
  DATA_POSI_LEFT(0);

  final int id;
  const DataPosiTyps(this.id);
}

enum EditCtrlTyps {
  EDITCTRL_TYP_NONE(-1),
  EDITCTRL_TYP_1(0),
  EDITCTRL_TYP_2(1),
  EDITCTRL_TYP_3(2),
  EDITCTRL_TYP_4(3),
  EDITCTRL_TYP_5(4),
  EDITCTRL_TYP_6(5),
  EDITCTRL_TYP_7(6),
  EDITCTRL_TYP_8(7),
  EDITCTRL_TYP_9(8),
  EDITCTRL_TYP_10(9),
  EDITCTRL_TYP_11(10),
  EDITCTRL_TYP_12(11),
  EDITCTRL_TYP_13(12),
  EDITCTRL_TYP_14(13),
  EDITCTRL_TYP_15(14),
  EDITCTRL_TYP_16(15),
  EDITCTRL_TYP_17(16),
  EDITCTRL_TYP_18(17),
  EDITCTRL_TYP_19(18),
  EDITCTRL_TYP_20(19),
  EDITCTRL_TYP_21(20),
  EDITCTRL_TYP_22(21),
  EDITCTRL_TYP_23(22),
  EDITCTRL_TYP_24(23),
  EDITCTRL_TYP_NUMERIC_GET(24),	// 半角, 桁区切り, マイナス符号付き, 左詰め+NULLストップ
  EDITCTRL_TYP_UNIT_POINTS(25),	// 半角, 桁区切り, マイナス符号付き, 最後に点
  EDITCTRL_TYP_UNIT_ITEMS(26),	// 半角, 桁区切り, マイナス符号付き, 最後に個
  EDITCTRL_TYP_UNIT_SHEETS(27),	// 半角, 桁区切り, マイナス符号付き, 最後に枚
  EDITCTRL_TYP_UNIT_RATE(28),		// 半角, マイナス符号付き, 最後に％
  EDITCTRL_TYP_UNIT_POINTS_P(29),	// 半角, 桁区切り, マイナス符号付き, 最後にＰ
  EDITCTRL_TYP_POINT_ASTERISK(30),	// 半角, 桁区切り, マイナス符号付き, 点orＰ,最後に*
  EDITCTRL_TYP_MAX(31);

  final int id;
  const EditCtrlTyps(this.id);
}