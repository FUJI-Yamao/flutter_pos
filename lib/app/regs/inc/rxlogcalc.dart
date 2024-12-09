/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース:rxlogcalc.h - enum MBR_CLS_DSC_FLG
enum MbrClsDscFlg {
  NORMAL_CLS_PRC(1),
  NORMAL_CLS_DSC(2),
  NORMAL_CLS_PDSC(3),
  NORMAL_CLS_PRCDSC(4),
  MBR_CLS_PRC(5),
  MBR_CLS_DSC(6),
  MBR_CLS_PDSC(7),
  MBR_CLS_PRCDSC(8);

  final int value;
  const MbrClsDscFlg(this.value);
}