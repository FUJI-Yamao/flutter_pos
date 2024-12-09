/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'tpr_def.dart';

///
/// 関連tprxソース:tprdid.h
///

/// TPR-X ID List.
class TprDidDef {
  static const TPRTIDSCPU = 0x0000F000; /* sub cpu */
  static const TPRTIDMECKEY = 0x00000100; /* mechanical key */
  static const TPRTIDTOUKEY = 0x00000200; /* touch key */
  //static const reserved 	        = 0x00000300;
  static const TPRTIDSPEAKER = 0x00000400; /* speaker */
  static const TPRTIDFIP = 0x00000500; /* FIP */
  static const TPRTIDLCDDSP = 0x00000600; /* LCD */
  static const TPRTIDSCANNER = 0x00000700; /* scanner */
  static const TPRTIDWDSCAN = 0x00000800; /* wand scanner */
  static const TPRTIDCHANGER = 0x00000900; /* changer */
  static const TPRTIDCOMUSB = 0x00000A00; /* usb com convert */
  static const TPRTIDRECEIPT = 0x00000B00; /* Receipt prt+Drawe */
  static const TPRTIDTOKYURW = 0x00000C00; /* TOKYU Rewite card */
  static const TPRTIDDEBIT = 0x00000D00; /* debit card */
  static const TPRTIDGLORYCARD = 0x00000E00; /* Glory point card */
  static const TPRTIDVISMAC = 0x00000F00; /* VIMAC card */
  static const TPRTIDPRSP = 0x00001000; /* sp printer */
  static const TPRTIDMGC1JIS = 0x00001100; /* magnetic card jis1 */
  static const TPRTIDMGC2JIS = 0x00001200; /* magnetic card jis2 */
  static const TPRTIDGCAT = 0x00001300; /* G-CAT */
  static const TPRTIDPRT = 0x00001400; /* Print */
  static const TPRTIDLCDBRT = 0x00001500; /* LCD bright */
  static const TPRTIDPMOUSE = 0x00001600; /* pseudo mouse */
  static const TPRTIDSCALE = 0x00001700; /* scale */
  static const TPRTIDORC = 0x00001800; /* OKI rewrite card */
  static const TPRTIDSGSCALE = 0x00001900; /* self-gate scale */
  static const TPRTIDSEGDISP = 0x00001A00; /* Segment Display */
  static const TPRTIDCALLSW = 0x00001B00; /* Clerk Call Switch */
  static const TPRTIDDETECT = 0x00001C00; /* Detect Sencer */
  static const TPRTIDSIGNP = 0x00001D00; /* Signp Pole */
  static const TPRTIDEDY = 0x00001E00; /* Edy rewrite card */
  static const TPRTIDCRWP = 0x00001F00; /* Glory Card Read/Write Printer */
  static const TPRTIDSTPR = 0x00002000; /* Station Printer */
  static const TPRTIDPANA = 0x00002100; /* Pana Code */
  static const TPRTIDGP = 0x00002200; /* GP */
  static const TPRTIDS2PR = 0x00002000; /* S2tation Printer */
  static const TPRTIDPWRCTRL = 0x00002300; /* Power Control */
  static const TPRTIDPW = 0x00002400; /* PW410 */
  static const TPRTIDCCR = 0x00002500; /* CCR <2004.07.09> mn */
  static const TPRTID57VFD = 0x00002600; /* 5x7VFD */
  static const TPRTIDDISH = 0x00002700; /* dish */
  static const TPRTIDAIV = 0x00002800; /* HD AIVoice */
  static const TPRTIDYOMOCA = 0x00002900; /* Yomoca */
  static const TPRTIDSMTPLUS = 0x00002A00; /* Smartplus */
  static const TPRTIDSUICA = 0x00002B00; /* SUICA */
  static const TPRTIDRFID = 0x00002C00; /* RFID Tag Reader/Writer */
  static const TPRTIDDISHT = 0x00002D00; /* dish(TAKAYA); */
  static const TPRTIDARSTTS = 0x00002E00; /* AR-STTS-01 */
  static const TPRTIDMCP = 0x00002F00; /* MCP200 */
  static const TPRTIDFCL = 0x00003000; /* FCL */
  static const TPRTIDDRW = 0x00003100; /* Drawer */
  static const TPRTIDABSV31 = 0x00003200; /* ABS-V31 */
  static const TPRTIDYAMATO = 0x00003300; /* Yamato e-money */
  static const TPRTIDUSBCAM = 0x00003400; /* USB Camera */
  static const TPRTIDCCT = 0x00003500; /* CCT Credit */
  static const TPRTIDMASR = 0x00003600; /* Magnetic Auto Slide Reader */
  static const TPRTIDJMUPS = 0x00003700; /* J-Mups Credit */
  static const TPRTIDSQRC = 0x00003800; /* SQRC Ticket */
  static const TPRTIDICCARD = 0x00003900; /* IC CARD Reader */
  static const TPRTIDMST = 0x00003A00; /* MST */
  static const TPRTIDPOWLI = 0x00003B00; /* POWLI */
  static const TPRTIDSCALERM = 0x00003C00; /* RM-5900 */
  static const TPRTIDPSENSOR = 0x00004100; /* Proximity Sensor */
  static const TPRTIDAPBF = 0x00004200; /* Auto Plastic Bag Feeder */
  static const TPRTIDEXC = 0x00004400;	/* EXC-2500 IC CARD Reader */
  static const TPRTIDAMI = 0x00004500;      /* AMI2000 IC CARD Reader */
  static const TPRTIDHITOUCH = 0x00004600;      /* Hitouch */
  static const TPRTIDSCALE_SKS = 0x00004700;	/* Scale sks*/
  static const TPRTIDAIBOX = 0x00004800;	/* EE Corp AI BOX communication task */

  /// input or output
  static const TPRDEVIN = 1; /* device input */
  static const TPRDEVOUT = 2; /* device output */

  /// result
  static const TPRDEVRESULTOK = 0; /* OK */
  static const TPRDEVRESULTTIMEOUT = 1; /* Timeout */
  static const TPRDEVRESULTWERR = 2; /* write err */
  static const TPRDEVRESULTEERR = 3; /* Exclusive err */
  static const TPRDEVRESULTRERR = 4; /* read err */
  static const TPRDEVRESULTOFFLINE = 5; /* OFF line */
  static const TPRDEVRESULTPWOFF = 6; /* power off */
  static const TPRDEVRESULTGIVEUP = 7; /* give up... */
  static const TPRDEVRESULTTIMNOTSRT = 8; /* timer not start */
  static const TPRDEVRESULTCRCERR = 9; /* crc check error */
  static const TPRDEVRESULTRETRYOVER = 10; /* retry over */
  static const TPRDEVRESULTNOTOPEN = 11; /* device not open */

  /// device id
  static const TPRDIDSCPU1 = (TPRTIDSCPU | TprDef.TPRSCPU1);
  static const TPRDIDSCPU2 = (TPRTIDSCPU | TprDef.TPRSCPU2);
  static const TPRDIDSCPU3 = (TPRTIDSCPU | TprDef.TPRSCPU3);
  static const TPRDIDSCPU4 = (TPRTIDSCPU | TprDef.TPRSCPU4);
  static const TPRDIDSCPU5 = (TPRTIDSCPU | TprDef.TPRSCPU5);
  static const TPRDIDSCPU6 = (TPRTIDSCPU | TprDef.TPRSCPU6);

  static const TPRDIDMECKEY1 = (TPRTIDMECKEY | TprDef.TPRSCPU1);
  static const TPRDIDMECKEY2 = (TPRTIDMECKEY | TprDef.TPRSCPU2);
  static const TPRDIDMECKEY3 = (TPRTIDMECKEY | TprDef.TPRSCPU3);
  static const TPRDIDMECKEY4 = (TPRTIDMECKEY | TprDef.TPRSCPU4);
  static const TPRDIDMECKEY5 = (TPRTIDMECKEY | TprDef.TPRSCPU5);
  static const TPRDIDMECKEY6 = (TPRTIDMECKEY | TprDef.TPRSCPU6);

  static const TPRDIDTOUKEY1 = (TPRTIDTOUKEY | TprDef.TPRSCPU1);
  static const TPRDIDTOUKEY2 = (TPRTIDTOUKEY | TprDef.TPRSCPU2);
  static const TPRDIDTOUKEY3 = (TPRTIDTOUKEY | TprDef.TPRSCPU3);
  static const TPRDIDTOUKEY4 = (TPRTIDTOUKEY | TprDef.TPRSCPU4);
  static const TPRDIDTOUKEY5 = (TPRTIDTOUKEY | TprDef.TPRSCPU5);
  static const TPRDIDTOUKEY6 = (TPRTIDTOUKEY | TprDef.TPRSCPU6);

  static const TPRDIDSPEAKER1 = (TPRTIDSPEAKER | TprDef.TPRSCPU1);
  static const TPRDIDSPEAKER2 = (TPRTIDSPEAKER | TprDef.TPRSCPU2);
  static const TPRDIDSPEAKER3 = (TPRTIDSPEAKER | TprDef.TPRSCPU3);
  static const TPRDIDSPEAKER4 = (TPRTIDSPEAKER | TprDef.TPRSCPU4);
  static const TPRDIDSPEAKER5 = (TPRTIDSPEAKER | TprDef.TPRSCPU5);
  static const TPRDIDSPEAKER6 = (TPRTIDSPEAKER | TprDef.TPRSCPU6);

  static const TPRDIDFIP1 = (TPRTIDFIP | TprDef.TPRSCPU1);
  static const TPRDIDFIP2 = (TPRTIDFIP | TprDef.TPRSCPU2);
  static const TPRDIDFIP3 = (TPRTIDFIP | TprDef.TPRSCPU3);
  static const TPRDIDFIP4 = (TPRTIDFIP | TprDef.TPRSCPU4);
  static const TPRDIDFIP5 = (TPRTIDFIP | TprDef.TPRSCPU5);
  static const TPRDIDFIP6 = (TPRTIDFIP | TprDef.TPRSCPU6);

  static const TPRDIDLCDDSP1 = (TPRTIDLCDDSP | TprDef.TPRSCPU1);
  static const TPRDIDLCDDSP2 = (TPRTIDLCDDSP | TprDef.TPRSCPU2);
  static const TPRDIDLCDDSP3 = (TPRTIDLCDDSP | TprDef.TPRSCPU3);
  static const TPRDIDLCDDSP4 = (TPRTIDLCDDSP | TprDef.TPRSCPU4);
  static const TPRDIDLCDDSP5 = (TPRTIDLCDDSP | TprDef.TPRSCPU5);
  static const TPRDIDLCDDSP6 = (TPRTIDLCDDSP | TprDef.TPRSCPU6);

  static const TPRDIDSCANNER1 = (TPRTIDSCANNER | TprDef.TPRSCPU1);
  static const TPRDIDSCANNER2 = (TPRTIDSCANNER | TprDef.TPRSCPU2);
  static const TPRDIDSCANNER3 = (TPRTIDSCANNER | TprDef.TPRSCPU3);
  static const TPRDIDSCANNER4 = (TPRTIDSCANNER | TprDef.TPRSCPU4);
  static const TPRDIDSCANNER5 = (TPRTIDSCANNER | TprDef.TPRSCPU5);
  static const TPRDIDSCANNER6 = (TPRTIDSCANNER | TprDef.TPRSCPU6);

  static const TPRDIDWDSCAN1 = (TPRTIDWDSCAN | TprDef.TPRSCPU1);
  static const TPRDIDWDSCAN2 = (TPRTIDWDSCAN | TprDef.TPRSCPU2);
  static const TPRDIDWDSCAN3 = (TPRTIDWDSCAN | TprDef.TPRSCPU3);
  static const TPRDIDWDSCAN4 = (TPRTIDWDSCAN | TprDef.TPRSCPU4);
  static const TPRDIDWDSCAN5 = (TPRTIDWDSCAN | TprDef.TPRSCPU5);
  static const TPRDIDWDSCAN6 = (TPRTIDWDSCAN | TprDef.TPRSCPU6);

  static const TPRDIDCHANGER1 = (TPRTIDCHANGER | TprDef.TPRSCPU1);
  static const TPRDIDCHANGER2 = (TPRTIDCHANGER | TprDef.TPRSCPU2);
  static const TPRDIDCHANGER3 = (TPRTIDCHANGER | TprDef.TPRSCPU3);
  static const TPRDIDCHANGER4 = (TPRTIDCHANGER | TprDef.TPRSCPU4);
  static const TPRDIDCHANGER5 = (TPRTIDCHANGER | TprDef.TPRSCPU5);
  static const TPRDIDCHANGER6 = (TPRTIDCHANGER | TprDef.TPRSCPU6);

  static const TPRDIDCOMUSB1 = (TPRTIDCOMUSB | TprDef.TPRSCPU1);
  static const TPRDIDCOMUSB2 = (TPRTIDCOMUSB | TprDef.TPRSCPU2);
  static const TPRDIDCOMUSB3 = (TPRTIDCOMUSB | TprDef.TPRSCPU3);
  static const TPRDIDCOMUSB4 = (TPRTIDCOMUSB | TprDef.TPRSCPU4);
  static const TPRDIDCOMUSB5 = (TPRTIDCOMUSB | TprDef.TPRSCPU5);
  static const TPRDIDCOMUSB6 = (TPRTIDCOMUSB | TprDef.TPRSCPU6);

  static const TPRDIDRECEIPT1 = (TPRTIDRECEIPT | TprDef.TPRSCPU1);
  static const TPRDIDRECEIPT2 = (TPRTIDRECEIPT | TprDef.TPRSCPU2);
  static const TPRDIDRECEIPT3 = (TPRTIDRECEIPT | TprDef.TPRSCPU3);
  static const TPRDIDRECEIPT4 = (TPRTIDRECEIPT | TprDef.TPRSCPU4);
  static const TPRDIDRECEIPT5 = (TPRTIDRECEIPT | TprDef.TPRSCPU5);
  static const TPRDIDRECEIPT6 = (TPRTIDRECEIPT | TprDef.TPRSCPU6);

  static const TPRDIDTOKYURW1 = (TPRTIDTOKYURW | TprDef.TPRSCPU1);
  static const TPRDIDTOKYURW2 = (TPRTIDTOKYURW | TprDef.TPRSCPU2);
  static const TPRDIDTOKYURW3 = (TPRTIDTOKYURW | TprDef.TPRSCPU3);
  static const TPRDIDTOKYURW4 = (TPRTIDTOKYURW | TprDef.TPRSCPU4);
  static const TPRDIDTOKYURW5 = (TPRTIDTOKYURW | TprDef.TPRSCPU5);
  static const TPRDIDTOKYURW6 = (TPRTIDTOKYURW | TprDef.TPRSCPU6);

  static const TPRDIDDEBIT1 = (TPRTIDDEBIT | TprDef.TPRSCPU1);
  static const TPRDIDDEBIT2 = (TPRTIDDEBIT | TprDef.TPRSCPU2);
  static const TPRDIDDEBIT3 = (TPRTIDDEBIT | TprDef.TPRSCPU3);
  static const TPRDIDDEBIT4 = (TPRTIDDEBIT | TprDef.TPRSCPU4);
  static const TPRDIDDEBIT5 = (TPRTIDDEBIT | TprDef.TPRSCPU5);
  static const TPRDIDDEBIT6 = (TPRTIDDEBIT | TprDef.TPRSCPU6);

  static const TPRDIDGLORYCARD1 = (TPRTIDGLORYCARD | TprDef.TPRSCPU1);
  static const TPRDIDGLORYCARD2 = (TPRTIDGLORYCARD | TprDef.TPRSCPU2);
  static const TPRDIDGLORYCARD3 = (TPRTIDGLORYCARD | TprDef.TPRSCPU3);
  static const TPRDIDGLORYCARD4 = (TPRTIDGLORYCARD | TprDef.TPRSCPU4);
  static const TPRDIDGLORYCARD5 = (TPRTIDGLORYCARD | TprDef.TPRSCPU5);
  static const TPRDIDGLORYCARD6 = (TPRTIDGLORYCARD | TprDef.TPRSCPU6);

  static const TPRDIDVISMAC1 = (TPRTIDVISMAC | TprDef.TPRSCPU1);
  static const TPRDIDVISMAC2 = (TPRTIDVISMAC | TprDef.TPRSCPU2);
  static const TPRDIDVISMAC3 = (TPRTIDVISMAC | TprDef.TPRSCPU3);
  static const TPRDIDVISMAC4 = (TPRTIDVISMAC | TprDef.TPRSCPU4);
  static const TPRDIDVISMAC5 = (TPRTIDVISMAC | TprDef.TPRSCPU5);
  static const TPRDIDVISMAC6 = (TPRTIDVISMAC | TprDef.TPRSCPU6);

  static const TPRDIDPRSP1 = (TPRTIDPRSP | TprDef.TPRSCPU1);
  static const TPRDIDPRSP2 = (TPRTIDPRSP | TprDef.TPRSCPU2);
  static const TPRDIDPRSP3 = (TPRTIDPRSP | TprDef.TPRSCPU3);
  static const TPRDIDPRSP4 = (TPRTIDPRSP | TprDef.TPRSCPU4);
  static const TPRDIDPRSP5 = (TPRTIDPRSP | TprDef.TPRSCPU5);
  static const TPRDIDPRSP6 = (TPRTIDPRSP | TprDef.TPRSCPU6);

  static const TPRDIDMGC1JIS1 = (TPRTIDMGC1JIS | TprDef.TPRSCPU1);
  static const TPRDIDMGC2JIS1 = (TPRTIDMGC1JIS | TprDef.TPRSCPU2);
  static const TPRDIDMGC3JIS1 = (TPRTIDMGC1JIS | TprDef.TPRSCPU3);
  static const TPRDIDMGC4JIS1 = (TPRTIDMGC1JIS | TprDef.TPRSCPU4);
  static const TPRDIDMGC5JIS1 = (TPRTIDMGC1JIS | TprDef.TPRSCPU5);
  static const TPRDIDMGC6JIS1 = (TPRTIDMGC1JIS | TprDef.TPRSCPU6);

  static const TPRDIDMGC1JIS2 = (TPRTIDMGC2JIS | TprDef.TPRSCPU1);
  static const TPRDIDMGC2JIS2 = (TPRTIDMGC2JIS | TprDef.TPRSCPU2);
  static const TPRDIDMGC3JIS2 = (TPRTIDMGC2JIS | TprDef.TPRSCPU3);
  static const TPRDIDMGC4JIS2 = (TPRTIDMGC2JIS | TprDef.TPRSCPU4);
  static const TPRDIDMGC5JIS2 = (TPRTIDMGC2JIS | TprDef.TPRSCPU5);
  static const TPRDIDMGC6JIS2 = (TPRTIDMGC2JIS | TprDef.TPRSCPU6);

  static const TPRDIDGCAT1 = (TPRTIDGCAT | TprDef.TPRSCPU1);
  static const TPRDIDGCAT2 = (TPRTIDGCAT | TprDef.TPRSCPU2);
  static const TPRDIDGCAT3 = (TPRTIDGCAT | TprDef.TPRSCPU3);
  static const TPRDIDGCAT4 = (TPRTIDGCAT | TprDef.TPRSCPU4);
  static const TPRDIDGCAT5 = (TPRTIDGCAT | TprDef.TPRSCPU5);
  static const TPRDIDGCAT6 = (TPRTIDGCAT | TprDef.TPRSCPU6);

  static const TPRDIDPRT1 = (TPRTIDPRT | TprDef.TPRSCPU1);
  static const TPRDIDPRT2 = (TPRTIDPRT | TprDef.TPRSCPU2);
  static const TPRDIDPRT3 = (TPRTIDPRT | TprDef.TPRSCPU3);
  static const TPRDIDPRT4 = (TPRTIDPRT | TprDef.TPRSCPU4);
  static const TPRDIDPRT5 = (TPRTIDPRT | TprDef.TPRSCPU5);
  static const TPRDIDPRT6 = (TPRTIDPRT | TprDef.TPRSCPU6);

  static const TPRDIDLCDBRT1 = (TPRTIDLCDBRT | TprDef.TPRSCPU1);
  static const TPRDIDLCDBRT2 = (TPRTIDLCDBRT | TprDef.TPRSCPU2);
  static const TPRDIDLCDBRT3 = (TPRTIDLCDBRT | TprDef.TPRSCPU3);
  static const TPRDIDLCDBRT4 = (TPRTIDLCDBRT | TprDef.TPRSCPU4);
  static const TPRDIDLCDBRT5 = (TPRTIDLCDBRT | TprDef.TPRSCPU5);
  static const TPRDIDLCDBRT6 = (TPRTIDLCDBRT | TprDef.TPRSCPU6);

  static const TPRDIDPMOUSE1 = (TPRTIDPMOUSE | TprDef.TPRSCPU1);
  static const TPRDIDPMOUSE2 = (TPRTIDPMOUSE | TprDef.TPRSCPU2);
  static const TPRDIDPMOUSE3 = (TPRTIDPMOUSE | TprDef.TPRSCPU3);
  static const TPRDIDPMOUSE4 = (TPRTIDPMOUSE | TprDef.TPRSCPU4);
  static const TPRDIDPMOUSE5 = (TPRTIDPMOUSE | TprDef.TPRSCPU5);
  static const TPRDIDPMOUSE6 = (TPRTIDPMOUSE | TprDef.TPRSCPU6);

  static const TPRDIDSCALE1 = (TPRTIDSCALE | TprDef.TPRSCPU1);
  static const TPRDIDSCALE2 = (TPRTIDSCALE | TprDef.TPRSCPU2);
  static const TPRDIDSCALE3 = (TPRTIDSCALE | TprDef.TPRSCPU3);
  static const TPRDIDSCALE4 = (TPRTIDSCALE | TprDef.TPRSCPU4);
  static const TPRDIDSCALE5 = (TPRTIDSCALE | TprDef.TPRSCPU5);
  static const TPRDIDSCALE6 = (TPRTIDSCALE | TprDef.TPRSCPU6);

  static const TPRDIDORC1 = (TPRTIDORC | TprDef.TPRSCPU1);
  static const TPRDIDORC2 = (TPRTIDORC | TprDef.TPRSCPU2);
  static const TPRDIDORC3 = (TPRTIDORC | TprDef.TPRSCPU3);
  static const TPRDIDORC4 = (TPRTIDORC | TprDef.TPRSCPU4);
  static const TPRDIDORC5 = (TPRTIDORC | TprDef.TPRSCPU5);
  static const TPRDIDORC6 = (TPRTIDORC | TprDef.TPRSCPU6);

  static const TPRDIDSGSCALE1 = (TPRTIDSGSCALE | TprDef.TPRSCPU1);
  static const TPRDIDSGSCALE2 = (TPRTIDSGSCALE | TprDef.TPRSCPU2);
  static const TPRDIDSGSCALE3 = (TPRTIDSGSCALE | TprDef.TPRSCPU3);
  static const TPRDIDSGSCALE4 = (TPRTIDSGSCALE | TprDef.TPRSCPU4);
  static const TPRDIDSGSCALE5 = (TPRTIDSGSCALE | TprDef.TPRSCPU5);
  static const TPRDIDSGSCALE6 = (TPRTIDSGSCALE | TprDef.TPRSCPU6);

  static const TPRDIDSEGDISP1 = (TPRTIDSEGDISP | TprDef.TPRSCPU1);
  static const TPRDIDSEGDISP2 = (TPRTIDSEGDISP | TprDef.TPRSCPU2);
  static const TPRDIDSEGDISP3 = (TPRTIDSEGDISP | TprDef.TPRSCPU3);
  static const TPRDIDSEGDISP4 = (TPRTIDSEGDISP | TprDef.TPRSCPU4);
  static const TPRDIDSEGDISP5 = (TPRTIDSEGDISP | TprDef.TPRSCPU5);
  static const TPRDIDSEGDISP6 = (TPRTIDSEGDISP | TprDef.TPRSCPU6);

  static const TPRDIDCALLSW1 = (TPRTIDCALLSW | TprDef.TPRSCPU1);
  static const TPRDIDCALLSW2 = (TPRTIDCALLSW | TprDef.TPRSCPU2);
  static const TPRDIDCALLSW3 = (TPRTIDCALLSW | TprDef.TPRSCPU3);
  static const TPRDIDCALLSW4 = (TPRTIDCALLSW | TprDef.TPRSCPU4);
  static const TPRDIDCALLSW5 = (TPRTIDCALLSW | TprDef.TPRSCPU5);
  static const TPRDIDCALLSW6 = (TPRTIDCALLSW | TprDef.TPRSCPU6);

  static const TPRDIDDETECT1 = (TPRTIDDETECT | TprDef.TPRSCPU1);
  static const TPRDIDDETECT2 = (TPRTIDDETECT | TprDef.TPRSCPU2);
  static const TPRDIDDETECT3 = (TPRTIDDETECT | TprDef.TPRSCPU3);
  static const TPRDIDDETECT4 = (TPRTIDDETECT | TprDef.TPRSCPU4);
  static const TPRDIDDETECT5 = (TPRTIDDETECT | TprDef.TPRSCPU5);
  static const TPRDIDDETECT6 = (TPRTIDDETECT | TprDef.TPRSCPU6);

  static const TPRDIDSIGNP1 = (TPRTIDSIGNP | TprDef.TPRSCPU1);
  static const TPRDIDSIGNP2 = (TPRTIDSIGNP | TprDef.TPRSCPU2);
  static const TPRDIDSIGNP3 = (TPRTIDSIGNP | TprDef.TPRSCPU3);
  static const TPRDIDSIGNP4 = (TPRTIDSIGNP | TprDef.TPRSCPU4);
  static const TPRDIDSIGNP5 = (TPRTIDSIGNP | TprDef.TPRSCPU5);
  static const TPRDIDSIGNP6 = (TPRTIDSIGNP | TprDef.TPRSCPU6);

  static const TPRDIDEDY1 = (TPRTIDEDY | TprDef.TPRSCPU1);
  static const TPRDIDEDY2 = (TPRTIDEDY | TprDef.TPRSCPU2);
  static const TPRDIDEDY3 = (TPRTIDEDY | TprDef.TPRSCPU3);
  static const TPRDIDEDY4 = (TPRTIDEDY | TprDef.TPRSCPU4);
  static const TPRDIDEDY5 = (TPRTIDEDY | TprDef.TPRSCPU5);
  static const TPRDIDEDY6 = (TPRTIDEDY | TprDef.TPRSCPU6);

  static const TPRDIDCRWP1 = (TPRTIDCRWP | TprDef.TPRSCPU1);
  static const TPRDIDCRWP2 = (TPRTIDCRWP | TprDef.TPRSCPU2);
  static const TPRDIDCRWP3 = (TPRTIDCRWP | TprDef.TPRSCPU3);
  static const TPRDIDCRWP4 = (TPRTIDCRWP | TprDef.TPRSCPU4);
  static const TPRDIDCRWP5 = (TPRTIDCRWP | TprDef.TPRSCPU5);
  static const TPRDIDCRWP6 = (TPRTIDCRWP | TprDef.TPRSCPU6);

  static const TPRDIDSTPR1 = (TPRTIDSTPR | TprDef.TPRSCPU1);
  static const TPRDIDSTPR2 = (TPRTIDSTPR | TprDef.TPRSCPU2);
  static const TPRDIDSTPR3 = (TPRTIDSTPR | TprDef.TPRSCPU3);
  static const TPRDIDSTPR4 = (TPRTIDSTPR | TprDef.TPRSCPU4);
  static const TPRDIDSTPR5 = (TPRTIDSTPR | TprDef.TPRSCPU5);
  static const TPRDIDSTPR6 = (TPRTIDSTPR | TprDef.TPRSCPU6);

  static const TPRDIDPANA1 = (TPRTIDPANA | TprDef.TPRSCPU1);
  static const TPRDIDPANA2 = (TPRTIDPANA | TprDef.TPRSCPU2);
  static const TPRDIDPANA3 = (TPRTIDPANA | TprDef.TPRSCPU3);
  static const TPRDIDPANA4 = (TPRTIDPANA | TprDef.TPRSCPU4);
  static const TPRDIDPANA5 = (TPRTIDPANA | TprDef.TPRSCPU5);
  static const TPRDIDPANA6 = (TPRTIDPANA | TprDef.TPRSCPU6);

  static const TPRDIDGP1 = (TPRTIDGP | TprDef.TPRSCPU1);
  static const TPRDIDGP2 = (TPRTIDGP | TprDef.TPRSCPU2);
  static const TPRDIDGP3 = (TPRTIDGP | TprDef.TPRSCPU3);
  static const TPRDIDGP4 = (TPRTIDGP | TprDef.TPRSCPU4);
  static const TPRDIDGP5 = (TPRTIDGP | TprDef.TPRSCPU5);
  static const TPRDIDGP6 = (TPRTIDGP | TprDef.TPRSCPU6);

  static const TPRDIDS2PR1 = (TPRTIDS2PR | TprDef.TPRSCPU1);
  static const TPRDIDS2PR2 = (TPRTIDS2PR | TprDef.TPRSCPU2);
  static const TPRDIDS2PR3 = (TPRTIDS2PR | TprDef.TPRSCPU3);
  static const TPRDIDS2PR4 = (TPRTIDS2PR | TprDef.TPRSCPU4);
  static const TPRDIDS2PR5 = (TPRTIDS2PR | TprDef.TPRSCPU5);
  static const TPRDIDS2PR6 = (TPRTIDS2PR | TprDef.TPRSCPU6);

  static const TPRDIDPWRCTRL1 = (TPRTIDPWRCTRL | TprDef.TPRSCPU1);
  static const TPRDIDPWRCTRL2 = (TPRTIDPWRCTRL | TprDef.TPRSCPU2);
  static const TPRDIDPWRCTRL3 = (TPRTIDPWRCTRL | TprDef.TPRSCPU3);
  static const TPRDIDPWRCTRL4 = (TPRTIDPWRCTRL | TprDef.TPRSCPU4);
  static const TPRDIDPWRCTRL5 = (TPRTIDPWRCTRL | TprDef.TPRSCPU5);
  static const TPRDIDPWRCTRL6 = (TPRTIDPWRCTRL | TprDef.TPRSCPU6);

  static const TPRDIDPW1 = (TPRTIDPW | TprDef.TPRSCPU1);
  static const TPRDIDPW2 = (TPRTIDPW | TprDef.TPRSCPU2);
  static const TPRDIDPW3 = (TPRTIDPW | TprDef.TPRSCPU3);
  static const TPRDIDPW4 = (TPRTIDPW | TprDef.TPRSCPU4);
  static const TPRDIDPW5 = (TPRTIDPW | TprDef.TPRSCPU5);
  static const TPRDIDPW6 = (TPRTIDPW | TprDef.TPRSCPU6);

  static const TPRDIDCCR1 = (TPRTIDCCR | TprDef.TPRSCPU1);
  static const TPRDIDCCR2 = (TPRTIDCCR | TprDef.TPRSCPU2);
  static const TPRDIDCCR3 = (TPRTIDCCR | TprDef.TPRSCPU3);
  static const TPRDIDCCR4 = (TPRTIDCCR | TprDef.TPRSCPU4);
  static const TPRDIDCCR5 = (TPRTIDCCR | TprDef.TPRSCPU5);
  static const TPRDIDCCR6 = (TPRTIDCCR | TprDef.TPRSCPU6);

  static const TPRDID57VFD1 = (TPRTID57VFD | TprDef.TPRSCPU1);
  static const TPRDID57VFD2 = (TPRTID57VFD | TprDef.TPRSCPU2);
  static const TPRDID57VFD3 = (TPRTID57VFD | TprDef.TPRSCPU3);
  static const TPRDID57VFD4 = (TPRTID57VFD | TprDef.TPRSCPU4);
  static const TPRDID57VFD5 = (TPRTID57VFD | TprDef.TPRSCPU5);
  static const TPRDID57VFD6 = (TPRTID57VFD | TprDef.TPRSCPU6);

  static const TPRDIDDISH1 = (TPRTIDDISH | TprDef.TPRSCPU1);
  static const TPRDIDDISH2 = (TPRTIDDISH | TprDef.TPRSCPU2);
  static const TPRDIDDISH3 = (TPRTIDDISH | TprDef.TPRSCPU3);
  static const TPRDIDDISH4 = (TPRTIDDISH | TprDef.TPRSCPU4);
  static const TPRDIDDISH5 = (TPRTIDDISH | TprDef.TPRSCPU5);
  static const TPRDIDDISH6 = (TPRTIDDISH | TprDef.TPRSCPU6);

  static const TPRDIDAIV1 = (TPRTIDAIV | TprDef.TPRSCPU1);
  static const TPRDIDAIV2 = (TPRTIDAIV | TprDef.TPRSCPU2);
  static const TPRDIDAIV3 = (TPRTIDAIV | TprDef.TPRSCPU3);
  static const TPRDIDAIV4 = (TPRTIDAIV | TprDef.TPRSCPU4);
  static const TPRDIDAIV5 = (TPRTIDAIV | TprDef.TPRSCPU5);
  static const TPRDIDAIV6 = (TPRTIDAIV | TprDef.TPRSCPU6);

  static const TPRDIDYOMOCA1 = (TPRTIDYOMOCA | TprDef.TPRSCPU1);
  static const TPRDIDYOMOCA2 = (TPRTIDYOMOCA | TprDef.TPRSCPU2);
  static const TPRDIDYOMOCA3 = (TPRTIDYOMOCA | TprDef.TPRSCPU3);
  static const TPRDIDYOMOCA4 = (TPRTIDYOMOCA | TprDef.TPRSCPU4);
  static const TPRDIDYOMOCA5 = (TPRTIDYOMOCA | TprDef.TPRSCPU5);
  static const TPRDIDYOMOCA6 = (TPRTIDYOMOCA | TprDef.TPRSCPU6);

  static const TPRDIDSMTPLUS1 = (TPRTIDSMTPLUS | TprDef.TPRSCPU1);
  static const TPRDIDSMTPLUS2 = (TPRTIDSMTPLUS | TprDef.TPRSCPU2);
  static const TPRDIDSMTPLUS3 = (TPRTIDSMTPLUS | TprDef.TPRSCPU3);
  static const TPRDIDSMTPLUS4 = (TPRTIDSMTPLUS | TprDef.TPRSCPU4);
  static const TPRDIDSMTPLUS5 = (TPRTIDSMTPLUS | TprDef.TPRSCPU5);
  static const TPRDIDSMTPLUS6 = (TPRTIDSMTPLUS | TprDef.TPRSCPU6);

  static const TPRDIDSUICA1 = (TPRTIDSUICA | TprDef.TPRSCPU1);
  static const TPRDIDSUICA2 = (TPRTIDSUICA | TprDef.TPRSCPU2);
  static const TPRDIDSUICA3 = (TPRTIDSUICA | TprDef.TPRSCPU3);
  static const TPRDIDSUICA4 = (TPRTIDSUICA | TprDef.TPRSCPU4);
  static const TPRDIDSUICA5 = (TPRTIDSUICA | TprDef.TPRSCPU5);
  static const TPRDIDSUICA6 = (TPRTIDSUICA | TprDef.TPRSCPU6);

  static const TPRDIDRFID1 = (TPRTIDRFID | TprDef.TPRSCPU1);
  static const TPRDIDRFID2 = (TPRTIDRFID | TprDef.TPRSCPU2);
  static const TPRDIDRFID3 = (TPRTIDRFID | TprDef.TPRSCPU3);
  static const TPRDIDRFID4 = (TPRTIDRFID | TprDef.TPRSCPU4);
  static const TPRDIDRFID5 = (TPRTIDRFID | TprDef.TPRSCPU5);
  static const TPRDIDRFID6 = (TPRTIDRFID | TprDef.TPRSCPU6);

  static const TPRDIDDISHT1 = (TPRTIDDISHT | TprDef.TPRSCPU1);
  static const TPRDIDDISHT2 = (TPRTIDDISHT | TprDef.TPRSCPU2);
  static const TPRDIDDISHT3 = (TPRTIDDISHT | TprDef.TPRSCPU3);
  static const TPRDIDDISHT4 = (TPRTIDDISHT | TprDef.TPRSCPU4);
  static const TPRDIDDISHT5 = (TPRTIDDISHT | TprDef.TPRSCPU5);
  static const TPRDIDDISHT6 = (TPRTIDDISHT | TprDef.TPRSCPU6);

  static const TPRDIDARSTTS1 = (TPRTIDARSTTS | TprDef.TPRSCPU1);
  static const TPRDIDARSTTS2 = (TPRTIDARSTTS | TprDef.TPRSCPU2);
  static const TPRDIDARSTTS3 = (TPRTIDARSTTS | TprDef.TPRSCPU3);
  static const TPRDIDARSTTS4 = (TPRTIDARSTTS | TprDef.TPRSCPU4);
  static const TPRDIDARSTTS5 = (TPRTIDARSTTS | TprDef.TPRSCPU5);
  static const TPRDIDARSTTS6 = (TPRTIDARSTTS | TprDef.TPRSCPU6);

  static const TPRDIDMCP1 = (TPRTIDMCP | TprDef.TPRSCPU1);
  static const TPRDIDMCP2 = (TPRTIDMCP | TprDef.TPRSCPU2);
  static const TPRDIDMCP3 = (TPRTIDMCP | TprDef.TPRSCPU3);
  static const TPRDIDMCP4 = (TPRTIDMCP | TprDef.TPRSCPU4);
  static const TPRDIDMCP5 = (TPRTIDMCP | TprDef.TPRSCPU5);
  static const TPRDIDMCP6 = (TPRTIDMCP | TprDef.TPRSCPU6);

  static const TPRDIDFCL1 = (TPRTIDFCL | TprDef.TPRSCPU1);
  static const TPRDIDFCL2 = (TPRTIDFCL | TprDef.TPRSCPU2);
  static const TPRDIDFCL3 = (TPRTIDFCL | TprDef.TPRSCPU3);
  static const TPRDIDFCL4 = (TPRTIDFCL | TprDef.TPRSCPU4);
  static const TPRDIDFCL5 = (TPRTIDFCL | TprDef.TPRSCPU5);
  static const TPRDIDFCL6 = (TPRTIDFCL | TprDef.TPRSCPU6);

  static const TPRDIDDRW1 = (TPRTIDDRW | TprDef.TPRSCPU1);
  static const TPRDIDDRW2 = (TPRTIDDRW | TprDef.TPRSCPU2);
  static const TPRDIDDRW3 = (TPRTIDDRW | TprDef.TPRSCPU3);
  static const TPRDIDDRW4 = (TPRTIDDRW | TprDef.TPRSCPU4);
  static const TPRDIDDRW5 = (TPRTIDDRW | TprDef.TPRSCPU5);
  static const TPRDIDDRW6 = (TPRTIDDRW | TprDef.TPRSCPU6);

  static const TPRDIDABSV311 = (TPRTIDABSV31 | TprDef.TPRSCPU1);
  static const TPRDIDABSV312 = (TPRTIDABSV31 | TprDef.TPRSCPU2);
  static const TPRDIDABSV313 = (TPRTIDABSV31 | TprDef.TPRSCPU3);
  static const TPRDIDABSV314 = (TPRTIDABSV31 | TprDef.TPRSCPU4);
  static const TPRDIDABSV315 = (TPRTIDABSV31 | TprDef.TPRSCPU5);
  static const TPRDIDABSV316 = (TPRTIDABSV31 | TprDef.TPRSCPU6);

  static const TPRDIDYAMATO1 = (TPRTIDYAMATO | TprDef.TPRSCPU1);
  static const TPRDIDYAMATO2 = (TPRTIDYAMATO | TprDef.TPRSCPU2);
  static const TPRDIDYAMATO3 = (TPRTIDYAMATO | TprDef.TPRSCPU3);
  static const TPRDIDYAMATO4 = (TPRTIDYAMATO | TprDef.TPRSCPU4);
  static const TPRDIDYAMATO5 = (TPRTIDYAMATO | TprDef.TPRSCPU5);
  static const TPRDIDYAMATO6 = (TPRTIDYAMATO | TprDef.TPRSCPU6);

  static const TPRDIDUSBCAM1 = (TPRTIDUSBCAM | TprDef.TPRSCPU1);
  static const TPRDIDUSBCAM2 = (TPRTIDUSBCAM | TprDef.TPRSCPU2);
  static const TPRDIDUSBCAM3 = (TPRTIDUSBCAM | TprDef.TPRSCPU3);
  static const TPRDIDUSBCAM4 = (TPRTIDUSBCAM | TprDef.TPRSCPU4);
  static const TPRDIDUSBCAM5 = (TPRTIDUSBCAM | TprDef.TPRSCPU5);
  static const TPRDIDUSBCAM6 = (TPRTIDUSBCAM | TprDef.TPRSCPU6);

  static const TPRDIDCCT1 = (TPRTIDCCT | TprDef.TPRSCPU1);
  static const TPRDIDCCT2 = (TPRTIDCCT | TprDef.TPRSCPU2);
  static const TPRDIDCCT3 = (TPRTIDCCT | TprDef.TPRSCPU3);
  static const TPRDIDCCT4 = (TPRTIDCCT | TprDef.TPRSCPU4);
  static const TPRDIDCCT5 = (TPRTIDCCT | TprDef.TPRSCPU5);
  static const TPRDIDCCT6 = (TPRTIDCCT | TprDef.TPRSCPU6);

  static const TPRDIDMASR1 = (TPRTIDMASR | TprDef.TPRSCPU1);
  static const TPRDIDMASR2 = (TPRTIDMASR | TprDef.TPRSCPU2);
  static const TPRDIDMASR3 = (TPRTIDMASR | TprDef.TPRSCPU3);
  static const TPRDIDMASR4 = (TPRTIDMASR | TprDef.TPRSCPU4);
  static const TPRDIDMASR5 = (TPRTIDMASR | TprDef.TPRSCPU5);
  static const TPRDIDMASR6 = (TPRTIDMASR | TprDef.TPRSCPU6);

  static const TPRDIDJMUPS1 = (TPRTIDJMUPS | TprDef.TPRSCPU1);
  static const TPRDIDJMUPS2 = (TPRTIDJMUPS | TprDef.TPRSCPU2);
  static const TPRDIDJMUPS3 = (TPRTIDJMUPS | TprDef.TPRSCPU3);
  static const TPRDIDJMUPS4 = (TPRTIDJMUPS | TprDef.TPRSCPU4);
  static const TPRDIDJMUPS5 = (TPRTIDJMUPS | TprDef.TPRSCPU5);
  static const TPRDIDJMUPS6 = (TPRTIDJMUPS | TprDef.TPRSCPU6);

  static const TPRDIDSQRC1 = (TPRTIDSQRC | TprDef.TPRSCPU1);
  static const TPRDIDSQRC2 = (TPRTIDSQRC | TprDef.TPRSCPU2);
  static const TPRDIDSQRC3 = (TPRTIDSQRC | TprDef.TPRSCPU3);
  static const TPRDIDSQRC4 = (TPRTIDSQRC | TprDef.TPRSCPU4);
  static const TPRDIDSQRC5 = (TPRTIDSQRC | TprDef.TPRSCPU5);
  static const TPRDIDSQRC6 = (TPRTIDSQRC | TprDef.TPRSCPU6);

  static const TPRDIDICCARD1 = (TPRTIDICCARD | TprDef.TPRSCPU1);
  static const TPRDIDICCARD2 = (TPRTIDICCARD | TprDef.TPRSCPU2);
  static const TPRDIDICCARD3 = (TPRTIDICCARD | TprDef.TPRSCPU3);
  static const TPRDIDICCARD4 = (TPRTIDICCARD | TprDef.TPRSCPU4);
  static const TPRDIDICCARD5 = (TPRTIDICCARD | TprDef.TPRSCPU5);
  static const TPRDIDICCARD6 = (TPRTIDICCARD | TprDef.TPRSCPU6);

  static const TPRDIDMST1 = (TPRTIDMST | TprDef.TPRSCPU1);
  static const TPRDIDMST2 = (TPRTIDMST | TprDef.TPRSCPU2);
  static const TPRDIDMST3 = (TPRTIDMST | TprDef.TPRSCPU3);
  static const TPRDIDMST4 = (TPRTIDMST | TprDef.TPRSCPU4);
  static const TPRDIDMST5 = (TPRTIDMST | TprDef.TPRSCPU5);
  static const TPRDIDMST6 = (TPRTIDMST | TprDef.TPRSCPU6);

  static const TPRDIDPOWLI1 = (TPRTIDPOWLI | TprDef.TPRSCPU1);
  static const TPRDIDPOWLI2 = (TPRTIDPOWLI | TprDef.TPRSCPU2);
  static const TPRDIDPOWLI3 = (TPRTIDPOWLI | TprDef.TPRSCPU3);
  static const TPRDIDPOWLI4 = (TPRTIDPOWLI | TprDef.TPRSCPU4);
  static const TPRDIDPOWLI5 = (TPRTIDPOWLI | TprDef.TPRSCPU5);
  static const TPRDIDPOWLI6 = (TPRTIDPOWLI | TprDef.TPRSCPU6);

  static const TPRDIDPSENSOR1 = (TPRTIDPSENSOR | TprDef.TPRSCPU1);
  static const TPRDIDPSENSOR2 = (TPRTIDPSENSOR | TprDef.TPRSCPU2);
  static const TPRDIDPSENSOR3 = (TPRTIDPSENSOR | TprDef.TPRSCPU3);
  static const TPRDIDPSENSOR4 = (TPRTIDPSENSOR | TprDef.TPRSCPU4);
  static const TPRDIDPSENSOR5 = (TPRTIDPSENSOR | TprDef.TPRSCPU5);
  static const TPRDIDPSENSOR6 = (TPRTIDPSENSOR | TprDef.TPRSCPU6);

  static const TPRDIDAPBF1 = (TPRTIDAPBF | TprDef.TPRSCPU1);
  static const TPRDIDAPBF2 = (TPRTIDAPBF | TprDef.TPRSCPU2);
  static const TPRDIDAPBF3 = (TPRTIDAPBF | TprDef.TPRSCPU3);
  static const TPRDIDAPBF4 = (TPRTIDAPBF | TprDef.TPRSCPU4);
  static const TPRDIDAPBF5 = (TPRTIDAPBF | TprDef.TPRSCPU5);
  static const TPRDIDAPBF6 = (TPRTIDAPBF | TprDef.TPRSCPU6);

  static const TPRDIDSCALERM1 = (TPRTIDSCALERM | TprDef.TPRSCPU1);
  static const TPRDIDSCALERM2 = (TPRTIDSCALERM | TprDef.TPRSCPU2);
  static const TPRDIDSCALERM3 = (TPRTIDSCALERM | TprDef.TPRSCPU3);
  static const TPRDIDSCALERM4 = (TPRTIDSCALERM | TprDef.TPRSCPU4);
  static const TPRDIDSCALERM5 = (TPRTIDSCALERM | TprDef.TPRSCPU5);
  static const TPRDIDSCALERM6 = (TPRTIDSCALERM | TprDef.TPRSCPU6);

  static const TPRDIDEXC1 = (TPRTIDEXC | TprDef.TPRSCPU1);
  static const TPRDIDEXC2 = (TPRTIDEXC | TprDef.TPRSCPU2);
  static const TPRDIDEXC3 = (TPRTIDEXC | TprDef.TPRSCPU3);
  static const TPRDIDEXC4 = (TPRTIDEXC | TprDef.TPRSCPU4);
  static const TPRDIDEXC5 = (TPRTIDEXC | TprDef.TPRSCPU5);
  static const TPRDIDEXC6 = (TPRTIDEXC | TprDef.TPRSCPU6);

  static const TPRDIDHITOUCH1 = (TPRTIDHITOUCH | TprDef.TPRSCPU1);
  static const TPRDIDHITOUCH2 = (TPRTIDHITOUCH | TprDef.TPRSCPU2);
  static const TPRDIDHITOUCH3 = (TPRTIDHITOUCH | TprDef.TPRSCPU3);
  static const TPRDIDHITOUCH4 = (TPRTIDHITOUCH | TprDef.TPRSCPU4);
  static const TPRDIDHITOUCH5 = (TPRTIDHITOUCH | TprDef.TPRSCPU5);
  static const TPRDIDHITOUCH6 = (TPRTIDHITOUCH | TprDef.TPRSCPU6);

  static const TPRDIDAMI1 = (TPRTIDAMI | TprDef.TPRSCPU1);
  static const TPRDIDAMI2 = (TPRTIDAMI | TprDef.TPRSCPU2);
  static const TPRDIDAMI3 = (TPRTIDAMI | TprDef.TPRSCPU3);
  static const TPRDIDAMI4 = (TPRTIDAMI | TprDef.TPRSCPU4);
  static const TPRDIDAMI5 = (TPRTIDAMI | TprDef.TPRSCPU5);
  static const TPRDIDAMI6 = (TPRTIDAMI | TprDef.TPRSCPU6);

  static const TPRDIDSCALE_SKS1 = (TPRTIDSCALE_SKS | TprDef.TPRSCPU1);
  static const TPRDIDSCALE_SKS2 = (TPRTIDSCALE_SKS | TprDef.TPRSCPU2);
  static const TPRDIDSCALE_SKS3 = (TPRTIDSCALE_SKS | TprDef.TPRSCPU3);
  static const TPRDIDSCALE_SKS4 = (TPRTIDSCALE_SKS | TprDef.TPRSCPU4);
  static const TPRDIDSCALE_SKS5 = (TPRTIDSCALE_SKS | TprDef.TPRSCPU5);
  static const TPRDIDSCALE_SKS6 = (TPRTIDSCALE_SKS | TprDef.TPRSCPU6);

  static const TPRDIDAIBOX1 = (TPRTIDAIBOX | TprDef.TPRSCPU1);
  static const TPRDIDAIBOX2 = (TPRTIDAIBOX | TprDef.TPRSCPU2);
  static const TPRDIDAIBOX3 = (TPRTIDAIBOX | TprDef.TPRSCPU3);
  static const TPRDIDAIBOX4 = (TPRTIDAIBOX | TprDef.TPRSCPU4);
  static const TPRDIDAIBOX5 = (TPRTIDAIBOX | TprDef.TPRSCPU5);
  static const TPRDIDAIBOX6 = (TPRTIDAIBOX | TprDef.TPRSCPU6);
}
