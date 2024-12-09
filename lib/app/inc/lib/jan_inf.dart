/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース: \inc\lib\jan_inf.h - JAN_inf構造体の変数部分
class JANInf {
  String code = '';       /* JAN code(ASCII) */
  int flagDigit = 0;              /* digit number of "Flag" */
  String flag = '';                   /* JAN flag */
  JANInfConsts type = JANInfConsts.JANtype;    /* JAN code type */
  int format = 0;                               /* Format Number */
  int price = 0;                                /* Price */
  int code2 = 0;                                /* Code2 */
  String itfCode = '';
  int clsCode = 0;
}

/// 関連tprxソース: \inc\lib\jan_inf.h - JAN_inf構造体の#define文部分
enum JANInfConsts {
  JANtype(value:0),					            		/* undecided */
  JANtypePlu6(value:1),							        /* Lower 6 digit PLU */
  JANtypeJan8(value:11),					      		/*  8 digit JAN */
  JANtypeJan13(value:12),					      		/* 13 digit JAN */
  JANtypeJan261(value:21),				    			/* 26 digit JAN 1st. 13 digits */
  JANtypeJan262(value:22),						    	/* 26 digit JAN 2nd. 13 digits */
  JANtypeNonPlu8(value:31),							    /*  8 digit NON-PLU */
  JANtypeNonPlu13(value:32),							  /* 13 digit NON-PLU */
  JANtypeWeightPlu13(value:42),							/* 13 digit Weight-PLU */
  JANtypeMagazine13(value:52),							/* 13 digit Magazine */
  JANtypeMagazine18(value:53),							/* 13 digit Magazine */
  JANtypeBook261(value:61),							    /* 26 digit Book 1st. 13 digits */
  JANtypeBook262(value:62),							    /* 26 digit Book 2nd. 13 digits */
  JANtypeClerk(value:71),					      		/* 13 digit CLERK */
  JANtypeClerk2(value:76),							    /* 13 digit CLERK */
  JANtypeClerk3(value:329),							    /* 13 digit CLERK */
  JANtypeCouponDate(value:74),							/* 13 digit Coupon Discount Date Barcode */
  JANtypePrcCpn(value:81),							    /* 13 digit JAN Prc Coupon */
  JANtypeDscCpn(value:82),							    /* 13 digit JAN Discount Coupon */
  JANtypeBenefitcoupon(value:83),						/* 13 digit special coupon Barcode */
  JANtypeCardforget1(value:84),							/* 13 digit card forget Barcode 1st. */
  JANtypeCardforget2(value:85),							/* 13 digit card forget Barcode 2nd. */
  JANtypeFresh261(value:91),							  /* Fresh 1st. 13 digits */
  JANtypeFresh262(value:92),						  	/* Fresh 2nd. 13 digits */
  JANtypePcFresh262(value:93),							/* Fresh 2nd. 13 digits */
  JANtypeDscFresh262(value:94),							/* Fresh 2nd. 13 digits */
  JANtypePdscFresh262(value:95),						/* Fresh 2nd. 13 digits */
  JANtypeDscPlu1(value:96),						    	/* Discount 1st. 13 digits */
  JANtypeDscPlu2(value:97),						    	/* Discount 2nd. 13 digits */
  JANtypeUpcE(value:101),						      	/* UPC-E version 8 digits */
  JANtypeUpcA(value:102),						      	/* UPC-A version 12 digits */
  JANtypeItf18(value:111),							    /* ITF18 digit Barcode */
  JANtypeItf14(value:112),							    /* ITF14 digit Barcode */
  JANtypeItf16(value:113),							    /* ITF16 digit Barcode */
  JANtypeMbr8(value:201),						      	/* 8 digit MBR Flag 2 digits */
  JANtypeMbr82(value:202),				    			/* 8 digit MBR Flag 1 degits */
  JANtypeMbr13(value:211),						    	/* 13 digit MBR */
  JANtypeMbrNw7L(value:212),				  			/* 15 digit MBR(for NW-7 LAWSON) */
  JANtypeMbr19Ikea(value:213),							/* 19 digit IKEA MBR (Input:19 digit > Apl:10 digit) */
  JANtypeCashRecycleOut(value:214),					/* 30 digit Cash Recycle OUT Barcode */
  JANtypeCashRecycleIn(value:215),					/* 30 digit Cash Recycle IN  Barcode */
  JANtypeCashRecycleInout(value:216),				/* 30 digit Cash Recycle INOUT  Barcode */
  JANtypeProm(value:301),						      	/* 13 digit PROM */
  JANtypeRcptBar1(value:141),						  	/* Receipt Barcode 1st. 13 digits */
  JANtypeRcptBar2(value:142),					  		/* Receipt Barcode 2nd. 13 digits */
  JANtypeRcptBar26(value:259),							/* 取引レシート管理バーコード26桁1段 */
  JANtypeGramx(value:151),							    /* 13 digit GramX Barcode */
  JANtypePrcTag1(value:161),							  /* 13 digit price tag Barcode 1st. */
  JANtypePrcTag2(value:162),							  /* 13 digit price tag Barcode 2nd. */
  JANtypeGiftCard1(value:171),							/* 13 digit gift card Barcode 1nd. */
  JANtypeGiftCard2(value:172),							/* 13 digit gift card Barcode 2nd. */
  JANtypePreset(value:181),							    /* 13 digit preset Barcode */
  JANtypeCoupon(value:191),							    /* 13 digit coupon Barcode */
  JANtypeFunckey(value:193),							  /* 13 digit function key Barcode */
  JANtypeTicket(value:194),							    /* 13 digit point ticket Barcode */
  JANtypeCouponcash(value:195),							/* 13 digit coupon ticket Barcode */
  JANtypeProducer(value:311),						  	/* 13 digit PROM */
  JANtypeProducer1(value:312),							/* 生産者バーコード1段目 */
  JANtypeProducer2(value:313),							/* 生産者バーコード2段目 */
  JANtypeIllOver(value:8000),							  /* Ilegal price overflow */
  JANtypeIllPcd(value:8001),							  /* Ilegal price check-digit */
  JANtypeIllCd(value:8002),							    /* Ilegal check-digit */
  JANtypeIllegal(value:8003),							  /* Ilegal code */
  JANtypeIllSys(value:8004),							  /* Ilegal system */
  JANtypeMobile(value:900),							    /* 13 digit MOBILE */
  JANtypeCatalina(value:401),							  /* 13 digit CATALINA SYSTEM */
  JANtypeCatalina2(value:402),							/* 13 digit CATALINA SYSTEM */
  JANtypeSalelmt1(value:501),							  /* Sale Limit 1st. 13 digits */
  JANtypeSalelmt2(value:502),							  /* Sale Limit 2nd. 13 digits */
  JANtypeGs1(value:7000),						      	/* GS1 Barcode               */
  JANtypeDrugrevFinish(value:7100),					/* Drug Revision Barcode Finish     */
  JANtypeDrugrevUnnes(value:7101),					/* Drug Revision Barcode Unnessary  */
  JANtypeReserv(value:7200),					  		/* reserv Barcode            */
  JANtypePntshiftBar1(value:601),						/* 13 digit Poiny shift Barcode */
  JANtypePntshiftBar2(value:602),						/* 13 digit Poiny shift Barcode */
  JANtypeMbrNw713(value:603),							  /* かすみ様13桁 MBR(NW-7　C/Dなし) */
  JANtypePbchg(value:7300),							    /* PBCHG Barcode            */
  JANformatFresh(value:137),						   	/* Fresh Barcode */
  JANtypeKomerigift(value:60),							/* Komeri 13 digit Komeri Gift Barcode */
  JANtypeTempcard(value:61),					  		/* Komeri 13 digit Komeri (Temporary) Card Barcode */
  JANtypeNamecard(value:64),					  		/* Komeri 13 digit Name Card Barcode */
  JANtypeWeborder(value:65),					  		/* Komeri 13 digit Web Order Barcode */
  JANtypeShopping(value:66),					  		/* Komeri 13 digit Shopping Card Barcode */
  JANtypeEmployee(value:67),					  		/* Komeri 13 digit Employee Shopping Card Barcode */
  JANtypeGoodsnum(value:73),							  /* SP Department 13 digit Goods Number Barcode */
  JANtypeGift(value:68),							      /* SP Department 13 digit Gift Barcode  */
  JANtypeRptag1(value:69),							    /* SP Department 13 digit Red Tag/Price Tag Barcode */
  JANtypeRptag2(value:70),				    			/* SP Department 13 digit Red Tag/Price Tag Barcode */
  JANtypeNetdoarsv(value:75),							  /* netDoA Reserv 13 digit netDoA Reserv Barcode */
  JANtypeQcpluadd(value:86),							  /* 13 digit QCashier PLU ADD Barcode */
  JANtypeCustomercard(value:251),						/* 18 digit Customer Card Barcode */
  JANtypeCosmosserv1(value:77),							/* 13 digit COSMOS Ticket Service Barcode 1st. */
  JANtypeCosmosserv2(value:78),							/* 13 digit COSMOS Ticket Service Barcode 2nd. */
  JANtypeCosmosdsc(value:79),							  /* 13 digit COSMOS Discount Barcode */
  JANtypeSalemente(value:7102),							/* 13 digit Sales Maintenance Barcode */
  JANtypeStfdiscnt(value:221),							/* 13 digit Staff Discount Barcode */
  JANtypePromPadd(value:302),						  	/* 13 digit PROM */
  JANtypeSalelmt26(value:503),							/* Sale Limit 26 digit */
  JANtypeAyahaGiftPoint(value:89),					/* プレゼントポイントバーコード */
  JANtypeTCoupon(value:90),							    /* Tポイントクーポンバーコード */
  JANtypeHinken(value:98),					    		/* 品券バーコード(紅屋商事様) */
  JANformatClothes1(value:16),							/* 衣料バーコード１段目 */
  JANtypeMyosiClothes1(value:323),					/* マルヨシ様用衣料バーコードタイプ１段目 */
  JANformatClothes2(value:17),							/* 衣料バーコード２段目 */
  JANtypeMyosiClothes2(value:324),					/* マルヨシ様用衣料バーコードタイプ２段目 */
  JANformatPrize1(value:75),							  /* マルヨシ様お買物管理バーコード１段目 */
  JANtypePrize1(value:321),							    /* マルヨシ様お買物管理バーコードタイプ１段目 */
  JANformatPrize2(value:76),							  /* マルヨシ様お買物管理バーコード２段目 */
  JANtypePrize2(value:322),							    /* マルヨシ様お買物管理バーコードタイプ２段目 */
  JANtypeFreshZfsp(value:255),							/* 全日食生鮮ZFSPバーコード  format_no */
  JANformatFreshZfsp(value:81),							/* 全日食生鮮ZFSPバーコード  format_typ */
  JANformatOnetoone(value:89),							/* One to One バーコード format_typ */
  JANtypeOnetoone(value:341),						  	/* One to One バーコード format_no */
  JANformatSvstckt(value:90),					  		/* サービス券バーコード format_typ */
  JANtypeSvstckt(value:260),				  			/* サービス券バーコード format_no */
  JANtypeCaseClothes1(value:342),						/* 特定クラス衣料バーコード１段目 */
  JANtypeCaseClothes2(value:343),						/* 特定クラス衣料バーコード２段目 */
  JANtypeDepoinplu(value:91),				  			/* デポジット商品付きバーコード format_typ */
  JANformatDepoinplu(value:348),						/* デポジット商品付きバーコード format_no  */
  JANtypeDepotbtlid(value:92),							/* 貸出瓶管理バーコード format_typ */
  JANformatDepotbtlid(value:350),		  			/* 貸出瓶管理バーコード format_no  */
  JANformatTnyclsClothes(value:150),				/* タカヤナギ様クラス衣料バーコードformat_no */
  JANformatChargeSlip(value:325),						/* 掛売バーコードformat_no */
  JANtypeCardforgetWs(value:99),			  	  /* WS様カード忘れバーコード format_typ */
  JANformatCardforgetWs(value:261),		  	  /* WS様カード忘れバーコード format_no  */
  JANtypeAccountReceivable(value:97),			  /* 売掛バーコード format_typ */
  JANformatAccountReceivable(value:354),		/* 売掛バーコード format_no  */
  JANtypeMente(value:98),						        /* メンテナンスバーコード format_typ */
  JANformatMente(value:355);					      /* メンテナンスバーコード format_no  */

  const JANInfConsts({required this.value});
  final int value;
}

/// 関連tprxソース: \inc\lib\jan_inf.h - Code128_inf
class Code128Inf {
  String orgCode = '';       /* Original 2 barcode */
  int digit = 0;            /* Enable digit */
  String code1 = '';         /* JAN code 1 (ASCII) */
  String code2 = '';         /* JAN code 2 (ASCII) */
  String orgCodeSalLmt = ''; /* Original 2 barcode */
  String salLmtDay = '';     /* Sale Limit Day       */
  String orgCodeProd = '';	 /* 20桁生産者バーコード */
}

/// 関連tprxソース: \inc\lib\jan_inf.h - Cash_Recycle_inf
class CashRecycleInf {
  String code = "";		/* barcode(CODE128 30digits) */
  int staffNo = 0;		/* 従業員番号 */
  int type = 0;				/* 区分 （アシストモニタ）0:ニアエンド 1:ニアフル
						                      （レジ）	  2:ニアエンド 3:ニアフル
						                  （自動精算）	  4:ニアエンド 5:ニアフル */
  int macNo1 = 0;			/* 出金レジ番号 */
  int macNo2 = 0;			/* 出金レジ番号 */
  int macNo3 = 0;			/* 入金レジ番号 */
  int acx5000Sht = 0;	/* 5000円枚数 */
  int acx1000Sht = 0; /* 1000円枚数 */
  int acx500Sht = 0;  /* 500円枚数 */
  int acx100Sht = 0;  /* 100円枚数 */
  int acx50Sht = 0;   /* 50円枚数 */
  int acx10Sht = 0;   /* 10円枚数 */
  int acx5Sht = 0;    /* 5円枚数 */
  int acx1Sht = 0;    /* 1円枚数 */
  int acx10000Sht = 0;  /* 10000円枚数 */
  int acx2000Sht = 0;  /* 2000円枚数 */
}

/// 関連tprxソース: \inc\lib\jan_inf.h 構造体内部などではない#Defineのconst定義
class JanInfDefine{
  static const cashRecycleCd = 32; // #define CASH_RECYCLE_CD 32
  static const pbchgCdMax = 44; // #define PBCHG_CD_MAX 44

  static const barTypCashRecycleOut = 65; // #define BAR_TYP_CASH_RECYCLE_OUT	65
  static const barTypCashRecycleIn = 66; // #define BAR_TYP_CASH_RECYCLE_IN		66
  static const barTypCashRecycleInout = 67; // #define BAR_TYP_CASH_RECYCLE_INOUT	67
  static const janTypeCashRecycle = 256; // #define JANtype_CASH_RECYCLE		256	//FF NNNNNNNNNN T OOOOOO HHMMSS IIIIII C/D
  static const barFormatCashRecycle2rcpt = 252; // #define BAR_FORMAT_CASH_RECYCLE_2RCPT	252
  static const barFormatCashRecycle1rcpt = 253; // #define BAR_FORMAT_CASH_RECYCLE_1RCPT	253	//F 000 NNNNNN T OOOOOO SSSSSS IIIIII C/D (現状は未使用)
  static const barFormatCashRecycle1rcpt2 = 254; // #define BAR_FORMAT_CASH_RECYCLE_1RCPT_2	254	//F 000 NNNNNN T OOOOOO HHMMSS IIIIII C/D
  static const barSizeFreshZfsp = 32; // #define BAR_SIZE_FRESH_ZFSP		32	//F 000 NNNNNN T OOOOOO HHMMSS IIIIII C/D
  static const barSizeSvstckt = 22; // #define BAR_SIZE_SVSTCKT		22	//FF IIIIIIIIIIIII YYMMDD C/D

  // /************************************************************************/
  // /*                         パスポートスキャン情報                       */
  // /************************************************************************/
  static const passportBarcodeCtlcode = 'P'; // #define PASSPORT_BARCODE_CTLCODE		"P"		// TYPEコード
  static const passportBarcodeLength = 88; // #define PASSPORT_BARCODE_LENGTH			88		// 総レングス
  static const passbarlengthType = 1; // #define PASSBARLENGTH_TYPE			1		// TYPE
  static const passbarlengthIssuingCountry = 3; // #define PASSBARLENGTH_ISSUING_COUNTRY		3		// 発行国
  static const passbarlengthName = 39; // #define PASSBARLENGTH_NAME			39		// 氏名
  static const passbarlengthNumber = 9; // #define PASSBARLENGTH_NUMBER			9		// 旅券番号
  static const passbarlengthNationality = 3; // #define PASSBARLENGTH_NATIONALITY		3		// 国籍
  static const passbarlengthBirthday = 6; // #define PASSBARLENGTH_BIRTHDAY			6		// 生年月日
  static const passbarlengthSex = 1; // #define PASSBARLENGTH_SEX			1		// 性別
  static const passbarlengthExpirydate = 6; // #define PASSBARLENGTH_EXPIRYDATE		6		// 有効期限満了日
  static const passbarlengthAddinfo = 14; // #define PASSBARLENGTH_ADDINFO			14		// 追加情報

  // /************************************************************************/
  // /*                        dポイント関連情報                             */
  // /************************************************************************/
  static const  dpointCardLength = 15; //   #define	DPOINT_CARD_LENGTH	15
  static const  dpntCardId = '6'; //   #define	DPNT_CARD_ID		'6'
  static const  dpntAssignNo1 = 6990; //   #define	DPNT_ASSIGN_NO1		6990
  static const  dpntAssignno2 = 6999; //   #define	DPNT_ASSIGN_NO2		6999
  static const  dcardAssignNo = 7988; //   #define	DCARD_ASSIGN_NO		7988

}

