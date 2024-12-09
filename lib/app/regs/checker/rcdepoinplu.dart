/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../inc/rc_mem.dart';

class Rcdepoinplu {
  /// 関連tprxソース:C:rcdepoinplu.c - rcChk_DepoBtl_ItemOnly()
  // TODO:00012 平野 checker関数実装のため、定義のみ追加
  static int rcChkDepoBtlItemOnly(){
    return 0;
  }

  /// 貸瓶付き商品情報クリア処理
  /// 関連tprxソース:rcdepoinplu.c - rcClear_DepoInPluBar()
  static void rcClearDepoInPluBar() {
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    cMem.depoinplu = DepoinpluBar();
    atSing.depoBrtInFlg = 0;  /* 瓶返却フラグ */
  }
}