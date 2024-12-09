/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/apl/fnc_code.dart';

/// 関連tprxソース:rc_sm65_ryubo.c
class RcSm65Ryubo {
  // 社員割引会計キー
  static const STLSTAFFPDSC_CHA = 21;  //FuncKey.KY_CHA7.keyId;
  //
  static const RYUBOTMBR_DSCKEY = 48;  //FuncKey.KY_PM5.keyId;
  // 社員掛売会計キー
  static const STAFFACCOUNT_CHA = 400;  //FuncKey.KY_CHA27.keyId;
  // 一般掛売会計キー
  static const NOMBRACCOUNT_CHA = 17;  //FuncKey.KY_CHA3.keyId;
  // 卸掛売会計キー
  static const SHOPACCOUNT_CHA = 394;  //FuncKey.KY_CHA21.keyId;
}