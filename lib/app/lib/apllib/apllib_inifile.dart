/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_type.dart';

class AplLibIniFile {
  // TODO: 中間 釣機関数実装のため、定義のみ追加
  ///  関連tprxソース: AplLib_IniFile.c - AplLib_IniFile
  static int aplLibIniFile(TprMID tid, int getSet, int dirTyp, String file,
      String section, String key, String buf) {
    return Typ.OK;
  }
}
