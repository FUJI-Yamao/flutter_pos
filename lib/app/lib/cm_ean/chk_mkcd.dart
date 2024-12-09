/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'cdigt.dart';
import 'mk_cdig.dart';
import 'set_cdig.dart';

class ChkMkcd {
  /// チェックディジットのチェック
  /// 引数:[ean] コード
  /// 引数:[zeroMkCdigit] チェックディジット付与フラグ
  /// 引数:[digit] ディジット長
  /// 戻り値: true=OK  false=NG
  /// 関連tprxソース:chk_mkcd.c - cm_chk_mk_cdigit_variable()
  static bool cmChkMkCdigitVariable(String ean, int zeroMkCdigit, int digit) {
    String tmpEan = ean;
    if (zeroMkCdigit != 0) {
      tmpEan = MkCdig.cmMkCdigitVariable(ean, digit);
    }
    return (Cdigt.cmCdigitVariable(tmpEan, digit) ==
        (SetCdig.cmSetCdigitVariable(tmpEan, digit).codeUnitAt(0) - 0x30));
  }

  /// T会員番号のチェックデジットが正しいかチェックする
  /// 引数: 16桁のT会員番号
  /// 戻り値: true=OK  false=NG
  /// 関連tprxソース:chk_mkcd.c - cm_chk_mk_cdigit_Tpoint()
  static int cmChkMkCdigitTpoint(String id16) {
    String bufId = id16.substring(0, 15) + Cdigt.cmcdigitTpoint(id16).toString();  // T会員番号のコピー用配列
    return id16.compareTo(bufId);
  }
}