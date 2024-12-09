/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース:mm_reptlib.h
class  MmReptLibDef{
  /* FONTSIZE */
  static const int MMREPTFS16	=	0;   					/* フォント　16 x 16 */
  static const int MMREPTFS24	=	1;	  				/* フォント　24 x 24 */
  static const int MMREPTFS24_48 = 2;					/* フォント　24 x 48 */
  static const int MMREPTFS48_24 = 3; 				/* フォント　48 x 24 */
  static const int MMREPTFS48_48 = 4;					/* フォント　48 x 48 */

  /* print roop count */
  static const int PRINT_CNT_MAX = 200; 			/* Print Roop Count */
}