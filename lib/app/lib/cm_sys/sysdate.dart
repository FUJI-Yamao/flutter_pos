/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//import 'package:flutter_pos/app/drv/scan/drv_scan_main.dart';

class SysDate {

  /// システム時刻を返す。
  ///
  DateTime cmReadSysdate() {
    return DateTime.now();
  }

/*
	Foramt	: void cm_write_sysdate (tm *dt);
	Input	: tm	*dt		address of datetime buffer
					(defined in cm_sys.h)
*/
  void cm_write_sysdate() {
    // TODO:システム時刻を変更する。flutterでは不可能では？
    // void cm_write_sysdate ( struct tm *dt )
    // {
    //   time_t	aa ;
    //   struct timeval  tv_dt,  *tv ;
    //   struct timezone tz_dt,  *tz ;
    //
    //   tv =  &tv_dt ;
    //   tz =  &tz_dt ;
    //   gettimeofday ( tv, tz ) ;		/* get  tz's data */
    //
    //   if ( cm_ckdate(dt) )
    //   {
    //     aa = mktime ( dt ) ;			/* exchang  tm-->time_t */
    //     tv->tv_sec = aa ;				/* set  sec data */
    //     tv->tv_usec = 0 ;
    //     settimeofday ( tv, tz ) ;
    //   }
    // }
  }

/*
	Foramt	: void cm_make_sysdate (tm *dt);
	          tm構造体の要素がその正しい範囲にない場合、正規化される
	          (10月40日は11月9日に変更される)
	Input	: tm	*dt		address of datetime buffer
					(defined in cm_sys.h)
*/
  int cm_make_sysdate() {
    // TODO:
    // short cm_make_sysdate ( struct tm *dest, struct tm *src )
    // {
    //   time_t	aa ;
    //   struct	tm	*pp ;
    //
    //   if( (aa = mktime ( src )) != -1 ) 			/* exchang  tm-->time_t */
    //   {
    //     if( (pp = localtime ( &aa )) != NULL )
    //     {
    //       *dest = *pp;
    //       return( 1 );
    //     }
    //   }
    //   return( 0 );
    // }
    return (0);
  }

/****************************************************************************/
/*		Check Date and Setting Week Data (BCD 0-sun. -> 6-Sat.)				*/
/****************************************************************************/
  bool cm_ckdate (DateTime dt) {

    // bool cm_ckdate ( struct tm *tt )
    // {
    //   short	aDayTbl[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 } ;
    //   short	nYear ;		/* Appoint Year (Type short)  */
    //   short	nMonth ;	/* Appoint Month (Type short) */
    //   short	cIdx ;		/* Loop Index				  */
    //   short	cTmpCnt ;	/* Week Compute				  */
    //
    //   nYear  =  tt->tm_year + 1900 ;
    //   nMonth =  tt->tm_mon ;
    //
    //   /* Hour Check */
    //   if ( ( (short)(tt->tm_hour) < 0 ) ||
    //     ( (short)(tt->tm_hour) > 23 ) ) 	return ( FALSE ) ;
    //
    //   /* Minute Check */
    //   if ( ( (short)(tt->tm_min ) < 0 ) ||
    //   ( (short)(tt->tm_min ) > 59 ) )	return ( FALSE ) ;
    //
    //   /* Second Check */
    //   if ( ( (short)(tt->tm_sec) < 0 ) ||
    //   ( (short)(tt->tm_sec) > 59 ) ) 	return ( FALSE ) ;
    //
    //   /* Month Check */
    //   if ( ( nMonth <  0 ) || ( nMonth > 11 ) )	return ( FALSE ) ;
    //
    //   /* Setting Day Table Index (0-jan. -> 11-Dec.) */
    //   if ( leap ( nYear ) )		aDayTbl[1]++ ;		/* 28 ---> 29 */
    //
    //   /* day Check */
    //   if ( ( tt->tm_mday < 1 ) || ( tt->tm_mday > aDayTbl[nMonth] ) )	return ( FALSE ) ;
    //
    //   /* Set Week Data Check */
    //   if ( tt->tm_wday == 0xFF )
    //   {
    //   /* Add Year */
    //   cTmpCnt = 0;
    //   for ( cIdx = 1 ;  cIdx < nYear ;  cIdx++ )
    //   {
    //   if ( leap ( cIdx ) )	cTmpCnt++ ;
    //   }
    //   cTmpCnt = cTmpCnt + nYear - 1 ;
    //
    //   /* Add Month */
    //   for ( cIdx = 0 ;  cIdx < nMonth ;  cIdx++ )
    //   {
    //   cTmpCnt = cTmpCnt + aDayTbl[cIdx] ;
    //   }
    //   /* Add Day */
    //   cTmpCnt = cTmpCnt + tt->tm_mday ;
    //
    //   /* Set Week Data (0-Sun. -> 6-Sat.) */
    //   tt->tm_wday = (uchar)( cTmpCnt % 7 ) ;
    //   }
    //   return ( TRUE ) ;
    // }

    return (true) ;
  }
}