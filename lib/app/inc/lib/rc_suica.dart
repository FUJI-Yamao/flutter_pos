/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


///  関連tprxソース:rc_suica.h

/*----------------------------------------------------------------------*
 * Definition
 *----------------------------------------------------------------------*/

/*----------------------------------------------------------------------*
 * Definition order
 *----------------------------------------------------------------------*/

/// 関連tprxソース: rc_suica.h - SUICA_PAGE
enum SuicaPage{
    SUICA_NODSP._(0),
    SUICA_START._(1),
    SUICA_AFTER._(2),
    SUICA_LACK._(3),
    SUICA_RETRY._(4),
    SUICA_RETCH._(5);
  final int id;
  const SuicaPage._(this.id);
}


