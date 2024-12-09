/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:collection/collection.dart';

enum MultiUseBrand {
  SPVT_OPERATION,
  EDY_OPERATION,
  QP_OPERATION,
  ID_OPERATION,
  PITAPA_OPERATION,
  PITAPA_REFOPERATION,
  SUICA_OPERATION,
  SUICA_REFOPERATION,
  SUICA_LACKOPERATION,
  SUICA_ALMOPERATION,
  SUICA_OBSOPERATION,
  NIMOCA_OPERATION;

  /// keyIdから対応するMultiUseBrandを取得する.
  static MultiUseBrand getDefine(int index) {
  MultiUseBrand? define =
  MultiUseBrand.values.firstWhereOrNull((a) => a.index == index);
  define ??= SPVT_OPERATION; // 定義されているものになければnoneを入れておく.
  return define;
  }
}

///関連tprxソース: rc_multi.h - MULTI_SUICA_TERMINAL
enum MultiSuicaTerminal {
  SUICA_NOT_USE,
  SUICA_PFM_USE,
  SUICA_VEGA_USE;
}

///関連tprxソース: rc_multi.h - MULTI_EDY_TERMINAL
enum MultiEdyTerminal {
  EDY_NOT_USE,
  EDY_FAP_USE,
  EDY_PFM_USE,
  EDY_UT_USE,
  EDY_VEGA_USE;
}

///関連tprxソース: rc_multi.h - MULTI_QP_TERMINAL
enum MultiQPTerminal {
  QP_NOT_USE,
  QP_FAP_USE,
  QP_PFM_USE,
  QP_UT_USE,
  QP_VEGA_USE;
  /// keyIdから対応するMultiQPTerminalを取得する.
  static MultiQPTerminal getDefine(int index) {
    MultiQPTerminal? define =
    MultiQPTerminal.values.firstWhereOrNull((a) => a.index == index);
    define ??= QP_NOT_USE; // 定義されているものになければnoneを入れておく.
    return define;
  }
}

///関連tprxソース: rc_multi.h - MULTI_ID_TERMINAL
enum MultiIDTerminal {
  ID_NOT_USE,
  ID_FAP_USE,
  ID_PFM_USE,
  ID_UT_USE,
  ID_VEGA_USE;
  /// keyIdから対応するMultiIDTerminalを取得する.
  static MultiIDTerminal getDefine(int index) {
    MultiIDTerminal? define =
    MultiIDTerminal.values.firstWhereOrNull((a) => a.index == index);
    define ??= ID_NOT_USE; // 定義されているものになければnoneを入れておく.
    return define;
  }
}
