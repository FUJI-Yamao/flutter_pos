/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

// Common Functions for Check Digit
// チェックデジット設定用共通関数
// 関連tprxソース:set_cdig.c

import 'package:flutter/cupertino.dart';

class Cdigt {

  // 関連tprxソース:set_cdig.c   cm_cdigit_variable()
  static int cmCdigitVariable(String ean, int digit)
  {
    int total = 0;  /* sigma calculated digit */
    int cd = 0;     /* check digit */
    int i = 0;      /* loop counter */
    int start = 0;
    int index = 0;

    if((digit % 2) > 0) {
      start = 1;
    } else {
      start = 0;
    }

    for (i = (digit / 2).toInt(); i > 0; i--) {
      if (start > 0) {
        total += (ean.codeUnitAt(index) - 0x30) * 1;
        index++;
      }
      total += (ean.codeUnitAt(index) - 0x30) * 3;
      index++;
      start = 1;
    }
    cd = (total % 10);       /* digit1 */
    if(cd != 0) {
      cd = (10 - cd); /* 10 - (digit1) */
    }
    return (cd);               /* digit #1 */
  }


  static int cmCdigit(String ean)
  {
    int  total = 0;  /* sigma calculated digit */
    int  cd = 0;     /* check digit */
    int  i = 0;      /* loop counter */
    int index = 0;

    total = 0;
    for(i = 6; i > 0; i--) {
      total += (ean.codeUnitAt(index) - 0x30) * 1;
      index++;
      total += (ean.codeUnitAt(index) - 0x30) * 3;
      index++;
    }
    cd = (total % 10);  /* digit1 */
    if(cd != 0) {
      cd = (10 - cd);   /* 10 - (digit1) */
    }
    return (cd);        /* digit #1 */
  }


// /*
//    Foramt : char cm_w2_modulas10 (uchar *b_card, uchar *b_wait, int size);
//    Input  : uchar *b_card - address of bottom Card No. (ASCII)
//           : uchar *b_wait - address of bottom Wait Data(ASCII)
//           : int    size   - Card No. size(include c/d)
//    Output : char
//
//            Card No  "4 5 3 4 1 0 4 0 0 3 8 2 1 0 1 1"
//                      x x x x x x x x x x x x x x x
//            Wait     "2 1 2 1 2 1 2 1 2 1 2 1 2 1 2  "
//                      | | | | | | | | | | | | | | |
//                      8+5+6+4+2+0+8+0+0+3+1+2+2+0+2 = 49
//                                          +
//                                          6
//                      49 / 10 = 4...9 （余り９）
//                      10 -  9 = 1　　（チェックデジット１）
//                      但し余りが０の場合はチェックデジットは無条件で０です
// */
// extern
// char cm_w2_modulas10 (uchar *b_card, uchar *b_wait, int size)
// {
// uchar *p,*q;    /* pointer as card for calc. */
// uint  total;   /* sigma calculated digit */
// uchar  cd;      /* check digit */
// uchar  chk10;
// char   i;       /* loop counter */
//
// total = 0;
// p = b_card;
// q = b_wait;
// i = size;
// i--;                /* チェックデジット分をサイズから引く */
// p--;                /* 計算エリアからチェックデジットを外す */
// for( ; i > 0; i-- )
// {
// /* digit * wait */
// chk10 = ((*p & (uchar)0x0f) * (*q & (uchar)0x0f));
// total += (chk10 < 10) ? chk10 : ((chk10 / 10) + (chk10 % 10));
// p--;  q--;       /* ポインターを進める */
// }
//
// cd = (uchar)(10 - (total % 10));    /* digit1        */
// if(cd >= (uchar)10)
// cd = (uchar)0;                   /* 10 - (digit1) */
//
// return((char)cd);                   /* digit #1      */
// }

  /// モジュラス10　ウエイト3　チェックディジット算出
  /// Foramt : char cmW3Modulas10 (uchar *b_card, uchar *b_wait, int size);
  /// Input  : uchar *b_card - address of bottom Card No. (ASCII)
  ///        : uchar *b_wait - address of bottom Wait Data(ASCII)
  ///        : int    size   - Card No. size(include c/d)
  /// Output : char
  static int cmW3Modulas10 (String b_card, String b_weight, [int size = 0]) {
    List<String> data = b_card.split("");
    List<String> weight = b_weight.split("");
    int total = 0;
    int j = 0;
    for(int i = (b_card.length - 1); i >= 0; i--) {
      total += int.parse(data[i]) * int.parse(weight[j++]);  /* digit * weight */
    }
    int cd = (10 - (total % 10)) % 10;
    return cd;
  }

// /*
//    Foramt : char cm_mkcd_deptstre ( char chk_typ, uchar *code, int size )
//    Input  : char  chk_type - check modulas type
//           : uchar *ean     - Code No. (ASCII)
//           : int    size    - Code No. size(No c/d)
//    Output : char           - 0~9 : OK -1:NG (BINARY)
// */
// extern
// char cm_mkcd_deptstre ( char chk_typ, uchar *code, int size )
// {
//
// char  cd = -1;
// char wt[25];
// char m11[25];
// char c[25];
// long  value;
//
// if( size > 24 ) {
// return( cd );
// }
//
// switch( chk_typ ) {
// case CHKTYP_M10W2:               /* modulas 10 wait 2 */
// /* make wait */
// memset( wt, 0, sizeof(wt) );
// strncpy( wt, "121212121212121212121212", sizeof(wt)-1 );
//
// /* copy code */
// memset( c, 0, sizeof(c) );
// memset( c, ' ', size+1 );
// memcpy( c, code, size );
//
// cd = cm_w2_modulas10( (uchar *)&c[size], (uchar *)&wt[23], size+1 );
// break;
//
// case CHKTYP_M11W27:              /* modulas 11 wait 2~7 */
// /* make wait */
// memset( m11, 0, sizeof(m11) );
// strncpy( m11, "765432765432765432765432", sizeof(m11)-1 );
//
// /* copy wait */
// memset( wt, 0, sizeof(wt) );
// strncpy( wt, &m11[24-size], size );
//
// cd = cm_w27_modulas11( code, (uchar *)wt, size );
// break;
//
// case CHKTYP_M11W72:              /* modulas 11 wait 7~2 */
// /* make wait */
// memset( m11, 0, sizeof(m11) );
// strncpy( m11, "234567234567234567234567", sizeof(m11)-1 );
//
// /* copy wait */
// memset( wt, 0, sizeof(wt) );
// //         strncpy( wt, &m11[24-size], size );
// strncpy( wt, &m11[0], size ); /* 2006/12/19 */
//
// cd = cm_w27_modulas11( code, (uchar *)wt, size );
// break;
//
// case CHKTYP_7CHK:                /* 7 check */
// value = atol( (char *)code );
// cd = value % 7;
// break;
//
// }
//
// return( cd );
//
// }
//
// /*
//    Foramt : char cm_w27_modulas11 ( uchar *b_card , uchar *b_wait, int size );
//    Input  : char  chk_type - check modulas type
//    Input  : uchar *b_card - address of bottom Card No. (ASCII)
//           : uchar *b_wait - address of bottom Wait Data(ASCII)
//           : int    size   - Card No. size(No c/d)
//    Output : char
// */
// extern
// char cm_w27_modulas11( uchar *b_card , uchar *b_wait, int size )
// {
// char  *p;                              /* pointer as ean for calc. */
// char  *w;                              /* pointer as b_wait for calc. */
// uint  total = 0;                       /* sigma calculated digit */
// char  cd;                              /* check digit */
// int   i;                               /* loop counter */
//
// p = b_card;
// w = b_wait;
//
// for( i = 0; i < size; i++, p++, w++ ) {
// total += ( *p & 0x0f ) * ( *w & 0x0f );
// }
//
// cd = 11 - ( total % 11 );                /* digit1 */
// if( cd >= 10 )
// cd = 0;                            /* 11 - (digit1) */
//
// return( cd );
// }
//
// extern
// char cm_w4_modulas10 (uchar *b_card, uchar *b_wait, int size)
// {
// uchar *p,*q;    /* pointer as card for calc. */
// uint  total;   /* sigma calculated digit */
// uchar  cd;      /* check digit */
// uchar  chk10;
// char   i;       /* loop counter */
//
// total = 0;
// p = b_card;
// q = b_wait;
// i = size;
// i--;                /* チェックデジット分をサイズから引く */
// p--;                /* 計算エリアからチェックデジットを外す */
// for( ; i > 0; i-- )
// {
// /* digit * wait */
// chk10 = ((*p & (uchar)0x0f) * (*q & (uchar)0x0f));
// total += chk10;
// p--;  q--;       /* ポインターを進める */
// }
//
// cd = (uchar)(10 - (total % 10));    /* digit1        */
// if(cd >= (uchar)10)
// cd = (uchar)0;                   /* 10 - (digit1) */
//
// return((char)cd);                   /* digit #1      */
// }

  /****************************************************************************/
  /*	名前																	*/
  /*		cm_mkcd_modulas10sp1			ﾓｼﾞｭﾗｽ10特のﾁｪｯｸﾃﾞｼﾞｯﾄ1算出			*/
  /*	書式																	*/
  /*		#include "cm_ean.h"													*/
  /*		char cm_mkcd_modulas10sp1(											*/
  /*			char	*ean);				ｶｰﾄﾞ番号の先頭ｱﾄﾞﾚｽ					*/
  /*	説明																	*/
  /*		ﾓｼﾞｭﾗｽ10特のﾁｪｯｸﾃﾞｼﾞｯﾄ1を算出する。									*/
  /*	返り値																	*/
  /*		ﾁｪｯｸﾃﾞｼﾞｯﾄ1の値														*/
  /****************************************************************************/
  /* ﾓｼﾞｭﾗｽ10特のﾁｪｯｸﾃﾞｼﾞｯﾄ1算出		*/
  static int cmMkcdModulas10sp1(String ean)
  {
    int		cd1 = 0;						/* ﾁｪｯｸﾃﾞｼﾞｯﾄ1の値					*/
    String	wait1 = "54321543215432";	/* ｳｴｲﾄ1							*/

    /************************************************************************/
    /* ﾁｪｯｸﾃﾞｼﾞｯﾄ算出1:会員番号の値集計										*/
    /************************************************************************/
    cd1 = cmCdigitSub1(ean, wait1, wait1.length - 1);

    /************************************************************************/
    /* ﾁｪｯｸﾃﾞｼﾞｯﾄ算出2:会員番号の集計値をﾁｪｯｸﾃﾞｼﾞｯﾄ1(1桁)に変換				*/
    /************************************************************************/

    /* ﾁｪｯｸﾃﾞｼﾞｯﾄを10で割った余りの値に更新する								*/
    cd1 = (cd1 % 11);

    /* 余りの値によってさらにﾁｪｯｸﾃﾞｼﾞｯﾄを更新								*/
    switch (cd1) {
      case 0  : cd1 = 1       ; break;	/* 余りが0なら1に設定				*/
      case 1  : cd1 = 0       ; break;	/* 余りが1なら0に設定				*/
      default : cd1 = 11 - cd1; break;	/* 余りがその他なら11-余りに設定	*/
    }

    /************************************************************************/
    /* 終了処理																*/
    /************************************************************************/
    /* ﾁｪｯｸﾃﾞｼﾞｯﾄ1の値を返して終了											*/
    return cd1;
  }

  /****************************************************************************/
  /*	名前																	*/
  /*		cm_mkcd_modulas10sp2			ﾓｼﾞｭﾗｽ10特のﾁｪｯｸﾃﾞｼﾞｯﾄ2算出			*/
  /*	書式																	*/
  /*		#include "cm_ean.h"													*/
  /*		char cm_mkcd_modulas10sp2(											*/
  /*			char	*ean);				ｶｰﾄﾞ番号の先頭ｱﾄﾞﾚｽ					*/
  /*	説明																	*/
  /*		ﾓｼﾞｭﾗｽ10特のﾁｪｯｸﾃﾞｼﾞｯﾄ2を算出する。									*/
  /*	返り値																	*/
  /*		ﾁｪｯｸﾃﾞｼﾞｯﾄ2の値														*/
  /****************************************************************************/
  static int cmMkcdModulas10sp2(String	ean) {
    int		cd2;						/* ﾁｪｯｸﾃﾞｼﾞｯﾄの値					*/
    String	wait2 = "212121212121212";/* ｳｴｲﾄ2							*/

    /************************************************************************/
    /* ﾁｪｯｸﾃﾞｼﾞｯﾄ算出1:会員番号とﾁｪｯｸﾃﾞｼﾞｯﾄ1の値集計						*/
    /************************************************************************/
    cd2 = cmCdigitSub2(ean, wait2, wait2.length - 1);

    /************************************************************************/
    /* ﾁｪｯｸﾃﾞｼﾞｯﾄ算出2:会員番号とﾁｪｯｸﾃﾞｼﾞｯﾄ1の集計値をﾁｪｯｸﾃﾞｼﾞｯﾄ2(1桁)に変換*/
    /************************************************************************/

    /* ﾁｪｯｸﾃﾞｼﾞｯﾄを10で割った余りの値に更新する								*/
    cd2 = (cd2 % 10);

    /* 余りの値によってさらにﾁｪｯｸﾃﾞｼﾞｯﾄを更新								*/
    switch (cd2) {
      case 0  : cd2 = 0       ; break;	/* 余りが0なら0に設定				*/
      default : cd2 = 10 - cd2; break;	/* 余りが0以外なら10-余りに設定		*/
    }

    /************************************************************************/
    /* 終了処理																*/
    /************************************************************************/
    /* ﾁｪｯｸﾃﾞｼﾞｯﾄ2の値を返して終了											*/
    return cd2;
  }

  /****************************************************************************/
  /*	名前                                                                     */
  /*		cmCdigitSub1					ﾁｪｯｸﾃﾞｼﾞｯﾄ算出ｻﾌﾞ1					*/
  /*	書式																	*/
  /*		int cmCdigitSub1(													*/
  /*			char	*ean,				ｶｰﾄﾞ番号の先頭ｱﾄﾞﾚｽ					*/
  /*			char	*wait,				ｳｴｲﾄの先頭ｱﾄﾞﾚｽ						*/
  /*			int		size);				桁数								*/
  /*	説明																	*/
  /*		ｶｰﾄﾞ番号にｳｴｲﾄをかけた値を算出する。								*/
  /*		(例)																*/
  /*			size : 4														*/
  /*			ean  :"3262" → 3    2    6    2								*/
  /*			                x    x    x    x								*/
  /*			wait :"2941" → 2    9    4    1								*/
  /*							|    |    |    |								*/
  /*							6 + 18 + 24 +  2 = 50(返り値)					*/
  /*	返り値																	*/
  /*		算出した値															*/
  /****************************************************************************/
  static int cmCdigitSub1(String ean, String wait, int size) {
    int		pos = 0;  /* 算出位置   */
    int		rtn = 0;  /* 返り値    */
    int		mul = 0;  /* 乗算の結果 */
    /************************************************************************/
    /* ｶｰﾄﾞ番号にｳｴｲﾄをかけた値を算出                                            */
    /************************************************************************/
    /* 指定桁数分のループ													*/
    for (pos = 0; pos < size; ++pos) {
      /* ｶｰﾄﾞ番号にｳｴｲﾄをかける											*/
      mul = (ean.codeUnitAt(pos) - 0x30) * (wait.codeUnitAt(pos) - 0x30);
      /* 結果を返り値に加算する											*/
      rtn += mul;
    }
    /************************************************************************/
    /* 終了処理                                                               */
    /************************************************************************/
    /* 算出した値を返して終了												*/
    return rtn;
  }

  /// バーコードのチェックデジットとの整合性をチェックする。
  /// 引数:[data] 対象データ
  /// 引数:[len] 対象データ長
  /// 戻り値：true = チェックOK
  ///       false = チェックNG
  // https://www.gs1jp.org/code/jan/check_digit.html

  /****************************************************************************/
  /*	名前																	*/
  /*		cmCdigitSub2					ﾁｪｯｸﾃﾞｼﾞｯﾄ算出ｻﾌﾞ2					*/
  /*	書式																	*/
  /*		int cmCdigitSub2(													*/
  /*			char	*ean,				ｶｰﾄﾞ番号の先頭ｱﾄﾞﾚｽ					*/
  /*			char	*wait,				ｳｴｲﾄの先頭ｱﾄﾞﾚｽ						*/
  /*			int		size);				桁数								*/
  /*	説明																	*/
  /*		ｶｰﾄﾞ番号にｳｴｲﾄをかけた値を算出する。								*/
  /*		(例)																*/
  /*			size : 4														*/
  /*			ean  :"3262" → 3    2    6    2								*/
  /*			                x    x    x    x								*/
  /*			wait :"2941" → 2    9    4    1								*/
  /*							|    |    |    |								*/
  /*							6   18   24    2								*/
  /*							6 +1+8 +2+4 +  2 = 23(返り値)					*/
  /*	返り値																	*/
  /*		算出した値															*/
  /****************************************************************************/
  static int cmCdigitSub2(String ean, String wait, int size) {
    int pos = 0;   /* 算出位置    */
    int rtn = 0;   /* 返り値      */
    int mul = 0;    /* 乗算の結果   */

    /************************************************************************/
    /* ｶｰﾄﾞ番号にｳｴｲﾄをかけた値を算出                                            */
    /************************************************************************/
    /* 指定桁数分のループ */
    for (pos = 0; pos < size; ++pos) {
      /* ｶｰﾄﾞ番号にｳｴｲﾄをかける	*/
      mul = (ean.codeUnitAt(pos) - 0x30) * (wait.codeUnitAt(pos)- 0x30);
      /* 結果が2桁以上の場合は10の位の値と1の位の値を加算する */
      if (mul >= 10) {
        mul = (mul / 10).toInt() + (mul % 10);
      }
      /* 結果を返り値に加算する */
      rtn += mul;
    }

    /************************************************************************/
    /* 終了処理                                                              */
    /************************************************************************/
    /* 算出した値を返して終了 */
    return rtn;
  }

// extern
// char cm_w3_9_modulas10 (uchar *addon, ushort digit)
// {
// uchar *p;     /* pointer as ean for calc. */
// uint  total;  /* sigma calculated digit */
// uchar cd;     /* check digit */
// uchar i;      /* loop counter */
// short start;
//
// if(digit % 2)
// start = 1;
// else
// start = 0;
// p = (uchar *)addon;
//
// total = 0;
// for(i = digit; i > 0; ) {
// if(start) {
// total += (*p - (uchar)0x30) * (uchar)3;
// p++;
// i--;
// if(i <= 0)
// break;
// }
// total += (*p - (uchar)0x30) * (uchar)9;
// p++;
// start = 1;
// i--;
// }
//
// // printf("total[%d]\n", total);
// cd = (uchar)(total % 10);       /* digit1 */
// return((char)cd);               /* digit #1 */
// }
//
// extern char cm_mkcd_modulas10sp3(		/* ﾓｼﾞｭﾗｽ10特のﾁｪｯｸﾃﾞｼﾞｯﾄ1算出		*/
// char	*ean						/* ｶｰﾄﾞ番号の先頭ｱﾄﾞﾚｽ				*/
// ) {
// int		cd1;						/* ﾁｪｯｸﾃﾞｼﾞｯﾄ1の値					*/
// char	wait1[] = "137937937937937";	/* ｳｴｲﾄ1							*/
//
// /************************************************************************/
// /* ﾁｪｯｸﾃﾞｼﾞｯﾄ算出1:会員番号の値集計										*/
// /************************************************************************/
// cd1 = cmCdigitSub1(ean, wait1, sizeof(wait1) - 1);
//
// /************************************************************************/
// /* ﾁｪｯｸﾃﾞｼﾞｯﾄ算出2:会員番号の集計値をﾁｪｯｸﾃﾞｼﾞｯﾄ1(1桁)に変換				*/
// /************************************************************************/
//
// /* ﾁｪｯｸﾃﾞｼﾞｯﾄを10で割った余りの値に更新する								*/
// cd1 = (cd1 % 10);
//
// /************************************************************************/
// /* 終了処理																*/
// /************************************************************************/
// /* ﾁｪｯｸﾃﾞｼﾞｯﾄ1の値を返して終了											*/
// return (cd1);
// }
//
// extern char cm_mkcd_nw7(char *ean)      /* ｺｰﾄﾞの先頭ｱﾄﾞﾚｽ                  */
// {                                       /* ｾﾌﾞﾝﾁｪｯｸ時のﾁｪｯｸﾃﾞｼﾞｯﾄ算出       */
// int     cd;                         /* ﾁｪｯｸﾃﾞｼﾞｯﾄの値                   */
// char    wait7[] = "46231546231";    /* ｳｴｲﾄ                             */
//
// /************************************************************************/
// /* ﾁｪｯｸﾃﾞｼﾞｯﾄ算出1:ｺｰﾄﾞの値集計                                         */
// /************************************************************************/
// cd = cmCdigitSub1(ean, wait7, sizeof(wait7) - 1);
//
// /************************************************************************/
// /* ﾁｪｯｸﾃﾞｼﾞｯﾄ算出2:ｺｰﾄﾞの値集計を7で割った余りがﾁｪｯｸﾃﾞｼﾞｯﾄの値          */
// /************************************************************************/
// return (cd % 7);
// }


  /// 関数名　　　：cm_cdigit_Tpoint
  /// 機能概要　　：#include "cm_ean.h"
  ///             ：cm_cdigit_Tpoint(char *;
  /// 呼出方法    ：#include "cm_ean.h"
  /// 　　　　　　　：cm_cdigit_Tpoint(char *id16);
  static int cmcdigitTpoint(String id16) {
    int cdigit = 0; // チェックデジット用変数
    int cnt = 0; // ループ用変数
    int va = 0; // チェックデジット計算中の値を格納する変数
    List<String> chr = List.filled(2, ""); // T会員番号の各桁の数値を一時的に格納する配列
    String bufId = ""; // T会員番号のコピー用配列
    List<int> weight = [
      4,
      9,
      2,
      1,
      1,
      7,
      8,
      3,
      8,
      2,
      6,
      5,
      9,
      7,
      5
    ]; // チェックデジット計算用のウェイト

    bufId = id16.padRight(17, '0').substring(0, 16);

    for (cnt = 0; cnt < bufId.length; cnt++) {
      chr[0] = bufId[cnt];
      va += int.parse(chr[0]) * weight[cnt];
    }

    cdigit = 9 - (va - ((va ~/ 9) * 9));

    return cdigit;
  }

// /*
//  * 関数名　　：cm_cdigit_ValueCard
//  * 機能概要　：バリューカード番号のチェックデジットを計算する
//  * 呼出方法　：#include "cm_ean.h"
//  * 　　　　　：cm_cdigit_ValueCard(char *id16, short weight);
//  * パラメータ：引数id16：１６桁のカード番号
//  *           ：引数weight：ウエイト
//  * 戻り値　　：チェックデジット
//  */
// extern short cm_cdigit_ValueCard(char *id16, short weight)
// {
// int	cdigit = 0;
// int	cnt = 0;
// int	var = 0;
// char 	chr[2] = "";
// char 	buf_id[17] = "";
//
// memset(buf_id,  0 , sizeof(buf_id));
// memset(buf_id, '0', sizeof(buf_id) - 1);
// memcpy(buf_id, id16, sizeof(buf_id) - 3);
//
// /* 14桁目まで */
// for(cnt = 0; cnt < sizeof(buf_id) - 3; cnt++)
// {
// memcpy(chr, &buf_id[cnt], 1);
// /* ウエイト */
// var += atoi(chr) * weight;
// }
//
// /* モジュラス(パターンF:99) */
// cdigit = 99 - (var % 99);
//
// return (cdigit);
// }
//
// /*
//  * 関数名　　：cm_cdigit_Code128TypeB_data_to_char
//  * 機能概要　：ＣＯＤＥ１２８タイプＢのデータから可読文字を返す
//  * 呼出方法　：#include "cm_ean.h"
//  * 　　　　　：cm_cdigit_Code128TypeB_data_to_char(short data);
//  * パラメータ：引数data：
//  * 戻り値　　：文字コード
//  * 備考　　　：可読文字以外(データ値９５以上)は'0'(0x30)を返す
//  */
// extern char cm_cdigit_Code128TypeB_data_to_char(short data)
// {
// /* 可読文字以外は'0'にする */
// if ((data >= 95) || (data < 0))
// {
// data = 16;
// }
//
// /* Code128_TypeBのコードセットは文字コード順で並んでいる */
// /* 制御文字の３２文字分をずらすことで、対応する文字コードとなる */
// return ((char)(data + 32));
// }
//
// #if SS_CR2
// /*
//  * 関数名　　：cm_cdigit_Code128TypeB
//  * 機能概要　：ＣＯＤＥ１２８タイプＢのチェックデジットを計算する
//  * 呼出方法　：#include "cm_ean.h"
//  * 　　　　　：cm_cdigit_Code128TypeB(char *id14);
//  * パラメータ：引数id14：
//  * 戻り値　　：チェックデジット
//  */
// extern short cm_cdigit_Code128TypeB(char *id14)
// {
// int	cdigit = 0;
// int	cnt = 0;
// int	var = 0;
// int 	chr = 0;
// char	buf[2];
// int	weight[13] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13};	//チェックデジット計算用のウェイト
//
// // スタートコード
// var = 104 * 1;
//
// /* 13桁目まで */
// for(cnt = 0; cnt < 13; cnt++)
// {
// memset( buf, 0x00, sizeof(buf));
// memcpy( buf, &id14[cnt], 1);
//
// if (strcmp( buf, "0" ) == 0)
// chr = 16;
// else if (strcmp( buf, "1" ) == 0)
// chr = 17;
// else if (strcmp( buf, "2" ) == 0)
// chr = 18;
// else if (strcmp( buf, "3" ) == 0)
// chr = 19;
// else if (strcmp( buf, "4" ) == 0)
// chr = 20;
// else if (strcmp( buf, "5" ) == 0)
// chr = 21;
// else if (strcmp( buf, "6" ) == 0)
// chr = 22;
// else if (strcmp( buf, "7" ) == 0)
// chr = 23;
// else if (strcmp( buf, "8" ) == 0)
// chr = 24;
// else if (strcmp( buf, "9" ) == 0)
// chr = 25;
// else if (strcmp( buf, "P" ) == 0)
// chr = 48;
// else if (strcmp( buf, "S" ) == 0)
// chr = 51;
// else if (strcmp( buf, "T" ) == 0)
// chr = 52;
// else if (strcmp( buf, "U" ) == 0)
// chr = 53;
// else if (strcmp( buf, "V" ) == 0)
// chr = 54;
//
// /* ウエイト */
// var += chr * weight[cnt];
// }
//
// /* モジュラス(パターンF:99) */
// cdigit = var % 103;
//
// // 95以上は0(スペース)に変換
// if (cdigit > 94)
// {
// cdigit = 16;
// }
//
// return (cdigit);
// }
//
// #endif
//
}
// /* end of cdigit.c */
