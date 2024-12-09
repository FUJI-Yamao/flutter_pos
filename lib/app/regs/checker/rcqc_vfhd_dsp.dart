/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/environment.dart';

class RcQcVfhdDsp {
  static const QC_SAG_LABEL_JSON = "regs_sag_label.json";
  static const VFHD_WORD_SECTION_ARCSPAYDSP = "arcspay_dsp";

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加
  /// 言語によってフォントファイルを差し替える
  /// 引数: 言語
  ///  関連tprxソース: rcqc_vfhd_dsp.c - rcQC_SAG_Font_LangChg
  static void rcQcSagFontLangChg(int langTyp) {}

  /// 画面に表示する文言をiniから取得する
  /// 引数:[section] セクション
  /// 引数:[keyNo] キーワードの番号
  /// 戻り値: 表示文言
  ///  関連tprxソース: rcqc_vfhd_dsp.c - rcQC_SAG_Get_IniLabel, rcQC_Get_IniLabel
  static String rcQcSagGetIniLabel(String section, int keyNo) {
    String jsonFile = "${EnvironmentData().env['TPRX_HOME']}/conf/$QC_SAG_LABEL_JSON";
    String keyword = "label$keyNo";
    String ret = "";

    // TODO:10155 顧客呼出 実装対象外
    /*
    RegsSagLabelJson jsonFile = RegsSagLabelJson();
    await jsonFile.load();
    JsonRet jsonRet = await jsonFile.getValueWithName(section, keyword);
    String ptr = ret.value;
    ret = ptr.replaceAll('@', '\n');
     */
    return ret;
  }
}

/// 関連tprxソース: rcqc_vfhd_dsp.h - VFHD_ARCSPAYDSP_WORD_ELEMENT
enum VfhdArcsPayDspWordElement {
  VFHD_ARCSTPAYDSP_WORD_TITLE,	/* 業務宣言 */
  VFHD_ARCSPAYDSP_WORD_PRECA_PAY,		/* プリカ支払 */
  VFHD_ARCSPAYDSP_WORD_HOUSE_PAY,		/* ハウス支払 */
  VFHD_ARCSPAYDSP_WORD_CASH_PAY,		/* 現金支払 */
}