/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_atct.dart';

import '../../inc/apl/rxregmem_define.dart';

/// 関連tprxソース: rckyworkin.c
class RckyWorkin {

  /// 関連tprxソース: rckyworkin - rcWorkin_After_Proc()
  static void rcWorkinAfterProc() {
    ///TODO:00014 日向 現計対応のため定義のみ先行追加
    return;
  }

  /// 関連tprxソース: rckyworkin - rcKyWorkin()
  static int rcKyWorkin(int call_typ) {
    // TODO: 現計対応のため定義のみ先行追加
    return 0;
  }

  /// 関連tprxソース: rckyworkin - rcWorkin_Chk_WorkTyp()
  static int rcWorkinChkWorkType(TTtlLog tTtllog) {
    return 0;
  }
}

/// 関連tprxソース: rckyworkin.h - WK_TYP
enum WkTyp {
  WK_OTHER,
  WK_ORDER,			/* 予約承り */
  WK_SCREDIT,			/* 短期売掛 */
  WK_CASHDELIVERY,		/* 代引 */
  WK_PLUMVST,			/* 商品移動発生 */
  WK_PLUMVEND,			/* 商品移動結末 */
  WK_SUMUP_ORDER,			/* 予約承り計上 */
  WK_SUMUP_SCREDIT,		/* 短掛入金 */
  WK_SUMUP_CASHDELIVERY,		/* 代引計上 */
  WK_CRDITRECEIV,			/* 売掛入金 */
  WK_ADDDEPOSIT,			/* 追加内金 */
  WK_REMAINDERPAY,		/* 残入金 */
  WK_ANNUL_ORDER,			/* 予約承り解約 */
  WK_ANNUL_SCREDIT,		/* 短期売掛解約 */
  WK_ANNUL_CASHDELIVERY,		/* 代引解約 */
  WK_CNCL_ORDER,			/* 予約承り取消 */
  WK_CNCL_SCREDIT,		/* 短期売掛取消 */
  WK_CNCL_CASHDELIVERY,		/* 代引取消 */
  WK_CNCL_PLUMVST,		/* 商品移動発生取消 */
  WK_CNCL_PLUMVEND,		/* 商品移動結末取消 */
  WK_CNCL_SUMUP_ORDER,		/* 予約承り計上取消 */
  WK_CNCL_SUMUP_SCREDIT,		/* 短掛入金取消 */
  WK_CNCL_SUMUP_CASHDELIVERY,	/* 代引計上取消 */
  WK_CNCL_CRDITRECEIV,		/* 短掛入金取消 */
  WK_CNCL_ADDDEPOSIT,		/* 追加内金取消 */
  WK_CNCL_REMAINDERPAY,		/* 残入金取消 */
  WK_RET_CRDITRECEIV;		/* 売掛入金戻 */

  static WkTyp getDefine(int index) {
    WkTyp typ = WkTyp.values.firstWhere((element) {
      return element.index == index;
    }, orElse: () => WkTyp.WK_OTHER);
    return typ;
  }
}