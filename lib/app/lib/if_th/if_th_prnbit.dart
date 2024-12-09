/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_type.dart';

/// 関連tprxソース: if_th_prnbit.c
class IfThPrnbit {
  
  /// 関連tprxソース: if_th.h - if_th_PrintBitmap_CmLogo
  static int ifThPrintBitmapCmLogo(TprTID src, int recmsgCd, int flashFlg) {
    return ifThPrintBitmapCmLogo2(src, recmsgCd, flashFlg, 0);
  }

  /// Usage:		if_th_PrintBitmap_CmLogo2( TPRTID src, int recmsg_cd )
  /// Function:	Setup bitmap data of bitmap on print buffer
  /// Parameters:	(IN)	src	: APL-ID
  ///       recmsg_cd	: receipt  message group no.
  ///       prn_type	: MEM->tHeader.prn_typ
  /// Return value:	IF_TH_POK	: Normal end
  ///     IF_TH_PERPARAM	: Generic parameter error
  ///     IF_TH_PERXYSTART: X or Y start position error
  ///     IF_TH_PERALLOC	: Memory allocate error
  /// 関連tprxソース: if_th_prnbit.c - if_th_PrintBitmap_CmLogo2
  /// TODO:00015 江原 定義のみ追加
  static int ifThPrintBitmapCmLogo2(TprTID src, int recmsgCd, int flashFlg, int prnType ) {
    return Typ.OK;
  }

}