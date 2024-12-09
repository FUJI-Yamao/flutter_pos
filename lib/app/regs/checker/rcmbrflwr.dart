/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/rxmemprn.dart';

class RcMbrFlWr {
  /// 処理概要：顧客ログデータのアップデート
  ///   オンライン時はTS-2100に書込．オフライン時はWeb2100に書き込む．
  /// パラメータ：tTlLog トータルログデータ
  /// 戻り値：true 正常
  ///        false 異常
  /// 関連tprxソース: rcmbrflwr.c - rcmbrCustlogUpdate
  // TODO:00016 佐藤 定義のみ追加
  static bool rcMbrCustLogUpdate(TTtlLog tTlLog, RxMemPrn prnBuf) {
    return false;
  }
}
