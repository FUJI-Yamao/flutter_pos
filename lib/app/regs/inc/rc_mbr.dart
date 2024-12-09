/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';

/// 関連tprxソース:rcmbr.h - MBR_INPUT_TYPE
enum MbrInputType {
  nonInput,			//  0:入力なし
  barcodeInput,		//  1:バーコード入力
  magcardInput,		//  2:磁気カード入力
  mbrKeyInput,		//  3:会員呼出キー入力
  telnoInput,		//  4:電話番号入力
  mbrCodeInput,		//  5:会員コード呼出入力
  cardKeyInput,		//  6:カードキー入力
  rwCardInput,		//  7:R/Wカード入力
  vismacCardInput,	//  8:VISMAC入力
  pointCardInput,	//  9:ポイントカード入力
  pcardmngKeyInput,	// 10:ポイントカード扱いキー入力
  pcarduseKeyInput,	// 11:ポイントカード使用キー入力
  mbrprcKeyInput,	// 12:会員売価キー入力
  mcardInput,		// 13:Mカード入力
  sapporoPanaInput,	// 14:サッポロ/ジャックルパナカード入力
  felicaInput,		// 15:FeliCa入力
  mcp200Input,		// 16:Mcp200カード入力
  hitachiInput,		// 17:日立ブルーチップ入力
  absV31Input,		// 18:ABS-V31カード入力
  nimocaInput,		// 19:nimoca顧客入力
  psp70Input,		// 20:PSP-70入力
  barReceivInput;	// 21:売掛バーコード入力
}

/// 関連tprxソース:rcmbr.h
class RcMbr {
  /* 顧客仕様ステータスフラグ (rcmbrChkStat() の戻り値) */
  static const int RCMBR_STAT_COMMON = 1;   /* 顧客共通仕様 */
  static const int RCMBR_STAT_POINT = 2;		/* 顧客ポイント仕様 */
  static const int RCMBR_STAT_FSP = 4;		  /* 顧客FSP仕様 */
  static const int RCMBR_NON_READ = -102;    /* member data non read      */
  static const int RCMBR_TEL_LIST = -101;    /* Display Members Tel List */
  static const int RCMBR_NON_WAIT = 0;       /* member data read non wait */
  static const int RCMBR_WAIT = 1;           /* member data read wait */
  static const int RCMBR_MSGDSP = 0x10;      /* member read Dsp Mode      */
  static const int RCMBR_ENQ_READ = 1;	     /* Cust Enq Data Read        */
  static const int RCMBR_CUST_READ = 0; 	   /* Cust Data Read            */
  static const int RCMBR_CASHEND_READ = 2;
}