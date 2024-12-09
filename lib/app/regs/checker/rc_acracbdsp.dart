/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:collection/collection.dart';

///  関連tprxソース: rc_acracbdsp.h ACX_NOMINALDISP_NOMINAL_TYPE
enum AcxNominaldispNominalType {
  NOMINAL_Y10000,
  NOMINAL_Y5000,
  NOMINAL_Y2000,
  NOMINAL_Y1000,
  NOMINAL_Y500,
  NOMINAL_Y100,
  NOMINAL_Y50,
  NOMINAL_Y10,
  NOMINAL_Y5,
  NOMINAL_Y1,
  NOMINAL_MAX,
}


/// 変更するラベル部を示す
///  関連tprxソース: rc_acracbdsp.h ACX_NOMINALDISP_LABEL_TYPE
enum AcxNominaldispLabelType{
ACX_NOMINALDISP_ENTRY,	// 入力部 (非選択)
ACX_NOMINALDISP_STOCK,		// 在高部
ACX_NOMINALDISP_AFTER,		// 結果部
ACX_NOMINALDISP_ENTRY_SELECT,	// 入力部 (選択)
}

class RcAcrAcbDsp {
  static int CREF_WINDOW_X = 640;
  static int CREF_WINDOW_Y = 480;
  static int CREF_WINDOW_BORDER = 2;
  static int CREF_FIL = 2;
  static int CREF_FIXED_X = (CREF_WINDOW_X - (CREF_WINDOW_BORDER + CREF_FIL));
  static int CREF_FIXED_Y = (CREF_WINDOW_Y - (CREF_WINDOW_BORDER + CREF_FIL));
  static int CREF_BTN_X = 44;
  static int CREF_BTN_Y = CREF_BTN_X;
  static int CREF_TITLEB_X = (CREF_FIXED_X - ((CREF_WINDOW_BORDER + CREF_FIL) * 2));
  static int CREF_TITLEB_Y = 40;
  static int CREF_TITLEB_F_X = 1;
  static int CREF_TITLEB_F_Y = 6;
  static int CREF_BTN_F_X = (CREF_WINDOW_X - CREF_BTN_X - (CREF_WINDOW_BORDER + CREF_FIL));
  static int CREF_PRNTBTN_F_X = CREF_BTN_F_X;
  static int CREF_PRNTBTN_F_Y = (CREF_WINDOW_Y - ((CREF_BTN_Y + (CREF_WINDOW_BORDER + CREF_FIL)) * 3));
  static int CREF_ENDBTN_F_X = CREF_BTN_F_X;
  static int CREF_ENDBTN_F_Y = (CREF_WINDOW_Y - (CREF_BTN_Y + (CREF_WINDOW_BORDER + CREF_FIL)));


  static int CREF_PRICE1_X = 100;
  static int CREF_PRICE1_F_X = (CREF_ENTRY1_X - (CREF_PRICE1_X + ((CREF_WINDOW_BORDER + CREF_FIL) * 2)));
  static int CREF_PRICE2_X = CREF_PRICE1_X;
  static int CREF_PRICE2_F_X = (CREF_ENTRY2_X - (CREF_PRICE2_X + ((CREF_WINDOW_BORDER + CREF_FIL) * 2)));
  static int CREF_PRICE_Y = 28;
  static int CREF_PRICE_F_Y = 2;
  static int CREF_STATUS1_X = 80;
  static int CREF_STATUS1_F_X = (CREF_ENTRY1_X - (CREF_STATUS1_X + ((CREF_WINDOW_BORDER + CREF_FIL) * 2)));
  static int CREF_STATUS2_X = 40;
  static int CREF_STATUS2_F_X = (CREF_ENTRY2_X - (CREF_STATUS2_X + ((CREF_WINDOW_BORDER + CREF_FIL) * 2)));
  static int CREF_STATUS_Y = CREF_PRICE_Y;
  static int CREF_STATUS_F_Y = CREF_PRICE_F_Y;
  static int CREF_SHEET1_X = 95;
  static int CREF_SHEET1_F_X = (CREF_STATUS1_F_X - (CREF_SHEET1_X + ((CREF_WINDOW_BORDER + CREF_FIL))));
  static int CREF_SHEET2_X = CREF_SHEET1_X;
  static int CREF_SHEET2_F_X = (CREF_STATUS2_F_X - (CREF_SHEET2_X + ((CREF_WINDOW_BORDER + CREF_FIL))));
  static int CREF_SHEET_Y = CREF_PRICE_Y;
  static int CREF_SHEET_F_Y = CREF_PRICE_F_Y;
  static int CREF_OFF1_X = 100;
  static int CREF_OFF1_F_X = (CREF_ENTRY1_X - (CREF_OFF1_X + ((CREF_WINDOW_BORDER + CREF_FIL) * 2)));
  static int CREF_OFF2_X = CREF_OFF1_X;
  static int CREF_OFF2_F_X = (CREF_ENTRY2_X - (CREF_OFF2_X + ((CREF_WINDOW_BORDER + CREF_FIL) * 2)));
  static int CREF_OFF_Y = CREF_PRICE_Y;
  static int CREF_OFF_F_Y = CREF_PRICE_F_Y;
  static int CREF_ENTRY1_X = (100 + CREF_STATUS1_X + CREF_SHEET1_X + ((CREF_WINDOW_BORDER + CREF_FIL) * 4));
  static int CREF_ENTRY1_F_X = 10;
  static int CREF_ENTRY2_X = (100 + CREF_STATUS2_X + CREF_SHEET2_X + ((CREF_WINDOW_BORDER + CREF_FIL) * 4));
  static int CREF_ENTRY2_F_X = (CREF_ENTRY1_F_X + (CREF_ENTRY1_X + CREF_WINDOW_BORDER + CREF_FIL) + CREF_ENTRY1_F_X);
  static int CREF_ENTRY_Y = 36;
  static int CREF_ENTRY_F_Y = 52;

  static int CREF_STOCK_X = 200;
  static int CREF_STOCK_Y = 35;
  static int CREF_STOCK_F_X = 200;
  static int CREF_STOCK_F_Y = 5;

/*---------------------------------------------------------------------------*
 * ChgDrw Disp
 *---------------------------------------------------------------------------*/
  static int CHGDRW_WINDOW_W = 500;
  static int CHGDRW_WINDOW_H = 350;
  static int CHGDRW_LABEL_W = 400;
  static int CHGDRW_LABEL_H = 200;
  static int CHGDRW_LABEL_X = 50;
  static int CHGDRW_LABEL_Y = 75;
  static int CHGDRW_CLOSE_BTN_X = 350;
  static int CHGDRW_CLOSE_BTN_Y = 290;
  static int CHGDRW_CCIN_BTN_X = 50;
  static int CHGDRW_CCIN_BTN_Y = 290;
  static int CHGDRW_TITLE_W = CHGDRW_WINDOW_W-6;
  static int CHGDRW_TITLE_H = 40;
  static int CHGDRW_TITLE_X = 3;
  static int CHGDRW_TITLE_Y = 3;
  static int CHGDRW_ACX_STATUS_W = 60;
  static int CHGDRW_ACX_STATUS_H = 46;
  static int CHGDRW_ACX_STATUS_X = 100;
  static int CHGDRW_ACX_STATUS_Y = CHGDRW_CCIN_BTN_Y;

  static int CHG_1LINE = 4;
  static int CHG_2LINE = 10;
  static int CHGINOUT_DIF_IMG_MAX = 16;
}

/// 関連tprxソース: rc_acracbdsp.h KindPick_Info
class KindPickInfo {
  int typ = 0; //金種別出金　0：しない　1：硬貨のみ
  int bkKind = 0; //前金種
  int nowKind = 0; //現在実行中金種種別
  List<int> kindFlg = List.generate(10, (_) => 0); //金種出金対象　0:非対象　 1:対象
  int firstKind = 0; //最初回収金種
  int lastKind = 0; //最終回収金種
  int stat = 0; //出金状態 1:出金中　2：出金完了
  int coinPickAll = 0; //硬貨全回収 1:全回収
  int pickSht = 0; //各金種出金枚数
  List<int> resvSht = List.generate(ChgInOutDisp.CHGINOUT_DIF_MAX.value,
          (_) => 0); //各金種出金残枚数（出金総枚数ーすでに出金した枚数）
  List<int> ttlSht =
  List.generate(ChgInOutDisp.CHGINOUT_DIF_MAX.value, (_) => 0); //各金種総出金枚数
  List<int> orgSht =
  List.generate(ChgInOutDisp.CHGINOUT_DIF_MAX.value, (_) => 0); //各金種出金枚数セーブ
  int bkresvsht = 0;
  int pickmth = 0; //0:残出金枚数全回収　1：棒金単位で回収
  String kindMsg = ''; //出金金種名
  List<int> overSht = List.generate(
      ChgInOutDisp.CHGINOUT_DIF_MAX.value, (_) => 0); //金種別出金戻し入れで払出済み金種の入金枚数
}

/// 関連tprxソース: rc_acracbdsp.h CHGINOUT_DISP
enum ChgInOutDisp {
  CHGINOUT_Y0(-1),
  CHGINOUT_Y10000(0),
  CHGINOUT_Y5000(1),
  CHGINOUT_Y2000(2),
  CHGINOUT_Y1000(3),
  CHGINOUT_Y500(4),
  CHGINOUT_Y100(5),
  CHGINOUT_Y50(6),
  CHGINOUT_Y10(7),
  CHGINOUT_Y5(8),
  CHGINOUT_Y1(9),
  CHGINOUT_DIF_MAX(10);

  final int value;

  const ChgInOutDisp(this.value);

  static ChgInOutDisp getDefine(int value) {
    ChgInOutDisp? define =
    ChgInOutDisp.values.firstWhereOrNull((a) => a.value == value);
    define ??= ChgInOutDisp.CHGINOUT_Y0; // 定義されているものになければnoneを入れておく.
    return define;
  }
}

/// 関連tprxソース: rc_acracbdsp.h ChgInOut_Disp
class StrChgInOutDisp {
  int total = 0;
  int cassette = 0;
  int fncCode = 0;
  int nowPosition = 0;
  int nowDisplay = 0;
  String title = '';
  List<ChgInOutKind> btn =
  List.generate(ChgInOutDisp.CHGINOUT_DIF_MAX.value, (_) => ChgInOutKind());
  int cashRecycle = 0; //キャッシュリサイクル両替出金フラグ
}

/// 関連tprxソース: rc_acracbdsp.h ChgInOutKind
class ChgInOutKind {
  int position = 0;
  int subXpt = 0;
  int subYpt = 0;
  String entryText = '';
  int acrCount = 0;
  int cPickCount = 0;
  int afterCount = 0;
  int amount = 0;
}

/// 関連tprxソース: rc_acracbdsp.h KindOut_Count_Make
enum KindOutCountMake {
  KINDOUT_COUNT_CLEAR,
  KINDOUT_COUNT_SAVE,
  KINDOUT_COUNT_LOAD,
}

/// 関連tprxソース: rc_acracbdsp.h KindOut_Prn
enum KindOutPrn {
  KINDOUT_PRN_STAT,
  KINDOUT_PRN_ERR,
}
