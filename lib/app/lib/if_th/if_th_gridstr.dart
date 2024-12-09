/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../if/common/interface_define.dart';
import '../../inc/sys/tpr_type.dart';
import '../cm_sys/cm_cksys.dart';
import 'aa/if_th_prnstr.dart';
import 'if_th_prnstr.dart';
import 'if_thlib.dart';

/// 関連tprxソース: if_th_gridstr.c
class IfThGridStr {
  
  /// Usage:		if_th_GridString( TPRTID src, int font, int col, int line, int off_x, int off_y,
  ///         int wAttr, int iAFontId, int iKFontId, char *ptString )
  /// Functions:	Setup font bitmap data of string by specify column/line
  /// Parameters:	(IN)	src	: APL-ID
  ///       font	: Font size(IF_TH_FW8 or IF_TH_FW12)
  ///       col	: Column position
  ///       line	: Line position
  ///       off_x	: X offset from left most position
  ///       off_y	: Y space between line
  ///       wAttr	: Print attribute
  ///       iAFontId: Font id for ASCII character
  ///       iKFontId: Font id for KANJI character
  ///       ptString: Pointer to print string
  /// Return value:	IF_TH_POK	: Normal end
  ///     IF_TH_PERPARAM	: Generic parameter error
  ///     IF_TH_PERXYSTART: X or Y start position error
  ///     IF_TH_PERCNVSJIS: Character code conversion error
  ///     IF_TH_PERGETBITMAP : Error on VF_GetBitmap2
  ///     IF_TH_PERALLOC	: Memory allocation error
  ///     IF_TH_PERXRANGE	: X range over error
  ///     IF_TH_PERYRANGE	: Y range over error
  ///     IF_TH_PERROTATE	: Error on VF_RotatedBitmap
  /// 関連tprxソース: if_th_gridstr.c - if_th_GridString
  static Future<int> ifThGridString(
    TprTID src, 
    int font, 
    int col, 
    int line, 
    int offX, 
    int offY, 
    int wAttr, 
    int iAFontId, 
    int iKFontId, 
    String ptString
  ) async {
    int	wXpos;			/* Adjusted X position */
    int	wYpos;			/* Adjusted Y position */
    int	ret;			/* Return value */

    src = await CmCksys.cmQCJCCPrintAid(src);

    /* First, check column and line parameters */
    if ( (col < 1) || (line < 1) ) {
      // コンパイルスイッチのシンボル定義なし
      // #ifdef	DEBUG_UT
      //   printf( "if_th_GridString : Col or line parameter is less than 1!\n" );
      // #endif
      return InterfaceDefine.IF_TH_PERPARAM;
    }

    /* Second, check offset parameters */
    if ( (offX < 0) || (offY < 0) ) {
      // コンパイルスイッチのシンボル定義なし
      // #ifdef	DEBUG_UT
      //   printf( "if_th_GridString : off_x or off_y is negative!\n" );
      // #endif
      return InterfaceDefine.IF_TH_PERPARAM;
    }
    
    /* Third, check font parameter */
    if ( InterfaceDefine.IF_TH_FW8 == font ) {
      wXpos = ( (col - 1) * IfThLib.IF_TH_X_8 ) + offX;
      wYpos = ( line * ( IfThLib.IF_TH_Y_8 + ((line - 1) * offY) ) ) - IfThLib.IF_TH_OFFY_8;
    } else if ( InterfaceDefine.IF_TH_FW12 == font ) {
      wXpos = ( (col - 1) * IfThLib.IF_TH_X_12 ) + offX;
      wYpos = ( line * ( IfThLib.IF_TH_Y_12 + ((line - 1) * offY) ) ) - IfThLib.IF_TH_OFFY_12;
    } else {
      // コンパイルスイッチのシンボル定義なし
      // #ifdef	DEBUG_UT
      //   printf( "if_th_GridString : font parameter error!\n" );
      // #endif
      return InterfaceDefine.IF_TH_PERPARAM;
    }
    
    /* Last, call if_th_PrintString */
    ret = await IfThPrnStr.ifThPrintString( src, wXpos, wYpos, wAttr, iAFontId, iKFontId, ptString );

    // コンパイルスイッチのシンボル定義なし
    // #ifdef	DEBUG_UT
    //   if ( ret != 0 )
    //     printf( "if_th_GridString : Error on if_th_PrintString! ret(%d)\n", ret );
    // #endif

    return ret;
  }

}