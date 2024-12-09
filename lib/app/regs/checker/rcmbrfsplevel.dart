/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../db_library/src/db_manipulation.dart';
import '../../inc/apl/trm_list.dart';

class RcmbrFspLevel {
  // TODO:00002 佐野 - checker関数実装の為、定義のみ追加
  /// 複数売価優待レベルを取得する
  /// 引数:[custinq] 顧客問い合わせテーブル
  /// 引数:[custterm] 顧客ターミナル
  /// 戻り値: 優待レベル (S:5, A:4, B:3, C:2, D:1, Other:0)
  /// 関連tprxソース: rcmbrfsplevel.c - rcmbrGetFspLevel
  static int rcmbrGetFspLevel(SCustTtlTbl custinq, TrmList custterm) {
    return 0;
  }
}