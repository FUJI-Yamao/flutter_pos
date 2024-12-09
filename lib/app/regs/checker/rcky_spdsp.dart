/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'rcstllcd.dart';
import 'rcsyschk.dart';

class RckySpDsp {

  static SpritDispInfo SP = SpritDispInfo();

  // TODO:00002 佐野 - rcClr2ndMbrClr()実装の為、定義のみ追加
  /// 引数:画像コード
  ///  関連tprxソース: rcky_spdsp.c - rcSP_CncelDsp_Prg
  static void rcSPCncelDspPrg(int imgCd) {}

  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// 引数:画像コード
  ///  関連tprxソース: rcky_spdsp.c - rcSP_ChangDsp_Prg
  static void rcSPChangDspPrg(int wCtrl) {
    if (wCtrl == RcStlLcd.FSTLLCD_RESET_ITEMINDEX) {
      if (RcSysChk.rcCheckSpMode_KY_STL()) {
        RcStlLcd.rcStlLcdEntry(EntryPart.ET_CLEAR.index, SP.spritSubttl);
        RcStlLcd.rcStlLcdChange(ChangePart.CT_DSCPDSC.index, SP.spritSubttl);
      } else {
        RcStlLcd.rcStlLcdChange(ChangePart.CT_CLEAR.index, SP.spritSubttl);
      }
      RcStlLcd.rcStlLcdTend(TendData.TD_STDATA.index, SP.spritSubttl);
    }
    else if (wCtrl == RcStlLcd.FSTLLCD_NOCHGRESET_ITEMINDEX) {
      RcStlLcd.rcStlLcdChange(ChangePart.CT_CLEAR.index, SP.spritSubttl);
    } else {
      RcStlLcd.rcStlLcdChange(ChangePart.CT_CHANGE.index, SP.spritSubttl);
    }
  }
}

///  関連tprxソース: rcky_spdsp.c - struct Sprit_Disp_Info
class SpritDispInfo {
  /*
  GtkWidget   *window;
  GtkWidget   *wFixed;
  GtkWidget   *TitleBar;
  GtkWidget   *ExitBtn;
  GtkWidget   *NextBtn;
   */
  int dispFlg = 0;        /* display flg      */
  int tranList = 0;       /* tran list flg    */
  int trnPage = 0;        /* 金種選択画面頁   */
  SubttlInfo spritSubttl = SubttlInfo();
}