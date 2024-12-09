/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';

import 'package:flutter_pos/app/inc/apl/compflag.dart';

import '../../common/environment.dart';
import 'dart:io';
import '../../drv/scan/drv_scan_rcv.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_log_define.dart';
import '../../inc/sys/tpr_type.dart';

class QrRet {
  int ret = 0;
  String strBuf = "";
  int intBuf = 0;
}

const int QR_BIN_Q = 0x51;
const int QR_BIN_CR = 0x0D;

const int QR_STATUS_OFF	= 0;
const int QR_STATUS_ON =	1;

const int QR_3_DOT = 3;
const int QR_4_DOT = 4;

const String QR2TEXT_TEXT_NAME = "QR";
const String QR2TEXT_TEXT_DIR = "/tmp/";

const String CHK2TEXT_TEXT_NAME = "CK";
const String CHK2TEXT_TEXT_DIR = "/log/QR/";

const int QR_AI_JAN_EAN13 = 0;
const int QR_AI_JAN_EAN8 = 1;
const int QR_AI_UPCA = 2;
const int QR_AI_UPCE = 3;
const int QR_AI_ITF = 4;
const int QR_AI_Codabar = 5;
const int QR_AI_Code128 = 6;
const int QR_AI_Code39 = 7;
const int QR_AI_GS1_RSS_14 = 9;
const int QR_AI_GS1_RSS_Ltd = 10;
const int QR_AI_GS1_RSS_Exp = 11;
const int QR_AI_AJS_EMONEY_CODE = 20;
const int QR_AI_CHANGE_SELECTITEMS = 23;
const int QR_AI_SPTEND_SELECT_NO = 24;
const int QR_AI_MARUSYO_MBRSVCTK = 30; // 丸正総本店様対応、会員呼出時の割戻しポイント
//static const int QR_AI_TAXFREEIN_STATUS = 33;
const int QR_AI_DPOINT_INQINFO = 37; // dポイント照会情報
const int QR_AI_DPOINT_ORGDATA = 38; // dポイント元取引情報
const int QR_AI_DPOINT_UPDINFO = 39; // dポイント更新情報
const int QR_AI_REPICAPNT_CODE = 40;
const int QR_AI_REPICAPNT_CODE2 = 41;
const int QR_AI_REPICAPNT_CODE3 = 42;
const int QR_AI_REPICAPNT_ADD_CODE	= 43;
const int QR_AI_KEY = 50;
const int QR_AI_KEY_PLU = 51;
const int QR_AI_KEY_MG = 52;
const int QR_AI_KEY_MUL = 53;
const int QR_AI_KEY_PRC = 54;
const int QR_AI_KEY_DSC = 55;
const int QR_AI_KEY_PDSC = 56;
const int QR_AI_KEY_MAG = 57;
const int QR_AI_KEY_SCRVOID = 58;
const int QR_AI_KEY_CHA_CHK = 59;
const int QR_AI_KEY_CHG_QTY = 60;
const int QR_AI_KEY_STLCNCL = 61;
const int QR_AI_KEY_PLUSCNCL = 62;
const int QR_AI_KEY_RBTCNCL = 63;
const int QR_AI_CSHR_NO = 64;
const int QR_AI_CUST_READ = 69;
const int QR_AI_TRM_INFO = 70;
const int QR_AI_CUST_READ_HT2980 = 71;
const int QR_AI_SCALE = 72;
const int QR_AI_CUST_READ_FELICA = 73;
const int QR_AI_EDY_CD = 74;
const int QR_AI_ARCS_MBR_JIS2 = 75;
const int QR_AI_BDLONELIMIT = 76;
const int QR_AI_CUST_READ_LONG = 77;
const int QR_AI_CUST_READ_MATGN = 78;
const int QR_AI_CUST_RWC_WRITE_PNT	= 79; // リライト書込済ポイント
const int QR_AI_ICHIYAMA_BDL_SLCT = 80;
const int QR_AI_REG_STARTTIME = 81;
const int QR_AI_RCPT_RATE4 = 82;
const int QR_AI_RCPT_RATE5 = 83;
const int QR_AI_COGCA_CODE = 84;
const int QR_AI_SALE_LMTBAR26 = 85;
const int QR_AI_MAMMY_CHK_STAFFCD = 86;
const int QR_AI_VALUECARD_CODE = 89;
const int QR_AI_CHGAMT = 90;
const int QR_AI_REPICA_CODE = 94;
const int QR_AI_PRECA_AUTO_SALES = 97;
const int QR_AI_NOTUSE = 99;
const int QR_AI_ZHQ_MBR_CD = 100;
const int QR_AI_ZHQ_NONPFL = 101;
const int QR_AI_ZHQ_MGNON = 102;
const int QR_AI_RESIDUAL_AMT = 103;
const int QR_AI_DLG_PLUVOID = 104;
const int QR_AI_HEADER_CODE = 9999;

const String QR_AI_CHK_JAN_EAN13 = "000";
const String QR_AI_CHK_JAN_EAN8 = "001";
const String QR_AI_CHK_UPCA = "002";
const String QR_AI_CHK_UPCE = "003";
const String QR_AI_CHK_ITF = "004";
const String QR_AI_CHK_Codabar = "005";
const String QR_AI_CHK_Code128 = "006";
const String QR_AI_CHK_Code39 = "007";
const String QR_AI_CHK_GS1_RSS_14 = "009";
const String QR_AI_CHK_GS1_RSS_Ltd = "010";
const String QR_AI_CHK_GS1_RSS_Exp = "011";
const String QR_AI_CHK_AJS_EMONEY_CODE = "020";
const String QR_AI_CHK_CHANGE_SELECTITEMS = "023";
const String QR_AI_CHK_SPTEND_SELECT_NO = "024";
const String QR_AI_CHK_MARUSYO_MBRSVCTK = "030"; // 丸正総本店様対応、会員呼出時の割戻しポイント
//static const String QR_AI_CHK_TAXFREEIN_STATUS = "033"
const String QR_AI_CHK_DPOINT_INQINFO = "037"; // dポイント照会情報
const String QR_AI_CHK_DPOINT_ORGDATA = "038"; // dポイント元取引情報
const String QR_AI_CHK_DPOINT_UPDINFO = "039"; // dポイント更新情報
const String QR_AI_CHK_REPICAPNT_CODE = "040";
const String QR_AI_CHK_REPICAPNT_CODE2 = "041";
const String QR_AI_CHK_REPICAPNT_CODE3 = "042";
const String QR_AI_CHK_REPICAPNTADD_CODE = "043";
const String QR_AI_CHK_KEY = "050";
const String QR_AI_CHK_KEY_PLU = "051";
const String QR_AI_CHK_KEY_MG = "052";
const String QR_AI_CHK_KEY_MUL = "053";
const String QR_AI_CHK_KEY_PRC = "054";
const String QR_AI_CHK_KEY_DSC = "055";
const String QR_AI_CHK_KEY_PDSC = "056";
const String QR_AI_CHK_KEY_MAG = "057";
const String QR_AI_CHK_KEY_SCRVOID = "058";
const String QR_AI_CHK_KEY_CHA_CHK = "059";
const String QR_AI_CHK_KEY_CHG_QTY = "060";
const String QR_AI_CHK_KEY_STLCNCL = "061";
const String QR_AI_CHK_KEY_PLUSCNCL = "062";
const String QR_AI_CHK_KEY_RBTCNCL = "063";
const String QR_AI_CHK_CSHR_NO = "064";
const String QR_AI_CHK_CUST_READ = "069";
const String QR_AI_CHK_TRM_INFO = "070";
const String QR_AI_CHK_CUST_READ_HT2980 = "071";
const String QR_AI_CHK_SCALE = "072";
const String QR_AI_CHK_CUST_READ_FELICA = "073";
const String QR_AI_CHK_EDY_CD = "074";
const String QR_AI_CHK_ARCS_MBR_JIS2 = "075";
const String QR_AI_CHK_BDLONELIMIT = "076";
const String QR_AI_CHK_CUST_READ_LONG = "077";
const String QR_AI_CHK_CUST_READ_MATGN = "078";
const String QR_AI_CHK_CUST_RWC_WRITE_PNT = "079";	// リライト書込済ポイント
const String QR_AI_CHK_ICHIYAM_BDL_SLCT = "080";
const String QR_AI_CHK_REG_STARTTIME = "081";
const String QR_AI_CHK_RCPT_RATE4 = "082";
const String QR_AI_CHK_RCPT_RATE5 = "083";
const String QR_AI_CHK_COGCA_CODE = "084";
const String QR_AI_CHK_SALE_LMTBAR26 = "085";
const String QR_AI_CHK_MAMMY_CHK_STAFFCD = "086";
const String QR_AI_CHK_VALUECARD_CODE = "089";
const String QR_AI_CHK_CHGAMT = "090";
const String QR_AI_CHK_REPICA_CODE = "094";
const String QR_AI_CHK_PRECA_AUTO_SALES = "097";
const String QR_AI_CHK_NOTUSE = "099";
const String QR_AI_CHK_ZHQ_MBR_CD = "100";
const String QR_AI_CHK_ZHQ_NONPFL = "101";
const String QR_AI_CHK_ZHQ_MGNON = "102";
const String QR_AI_CHK_RESIDUAL_AMT = "103";
const String QR_AI_CHK_DLG_PLUVOID = "104";
const String QR_AI_CHK_HEADER_CODE = "9999";
const int QR_AI_CHK_DIGIT = 3;
const int QR_AI_CHK_COM_DIGIT = 5;

const int QR_AI_JAN_EAN13_digit = 13;
const int QR_AI_JAN_EAN8_digit = 8;
const int QR_AI_UPCA_digit = 12;
const int QR_AI_UPCE_digit = 6;
const int QR_AI_MAGAZIN18_digit = 18;
const int QR_AI_Code39_IKEA_19_digit = 19;
const int QR_AI_Code128_20_digit = 20;
const int QR_AI_GS1_RSS_14_digit = 16;
const int QR_AI_GS1_RSS_Ltd_digit = 16;
const int QR_AI_KEY_digit = 3;
const int QR_AI_KEY_digit_COM = 1;
const int QR_AI_KEY_digit_PLU = 13;
const int QR_AI_KEY_digit_MG = 6;
const int QR_AI_KEY_digit_MUL = 3;
const int QR_AI_KEY_digit_PRC = 7;
const int QR_AI_KEY_digit_DSC = 10;
const int QR_AI_KEY_digit_PDSC = 5;
const int QR_AI_KEY_digit_MAG = 18;
const int QR_AI_KEY_digit_SCRVOID = 9;
const int QR_AI_KEY_digit_CHA_CHK = 10;
const int QR_AI_KEY_digit_CHG_QTY = 13;
const int QR_AI_CHANGE_SELECTITEMS_digit = 42;
const int QR_AI_SPTEND_SELECT_NO_digit = 2;
const int QR_AI_CSHR_NO_digit = 10;
const int QR_AI_CUST_MBRCD_digit = 13;
const int QR_AI_CUST_MBRCD_digit_HT2980 = 19;
const int QR_AI_CUST_MBRCD_digit_LONG = 16;
const int QR_AI_CUST_MBRINPUT_digit = 2;
const int QR_AI_CUST_TTLPNT_digit = 8;
const int QR_AI_CUST_READ_digit = QR_AI_CUST_MBRCD_digit + QR_AI_CUST_MBRINPUT_digit + (QR_AI_CUST_TTLPNT_digit *2);
const int QR_AI_CUST_READ_digit_HT2980 = QR_AI_CUST_MBRCD_digit_HT2980 + QR_AI_CUST_MBRINPUT_digit + (QR_AI_CUST_TTLPNT_digit *3);
const int QR_AI_SCALE_digit = 5;
const int QR_AI_CUST_READ_digit_FELICA = QR_AI_CUST_MBRCD_digit + QR_AI_CUST_MBRINPUT_digit + (QR_AI_CUST_TTLPNT_digit *5);
const int QR_AI_EDY_CD_digit = 16;
const int QR_AI_ARCS_MBR_JIS2_digit = 69;
const int QR_AI_REPICA_OBR_digit = 32;
const int QR_AI_ONEBDLLIMIT_digit = 6;
const int QR_AI_CUST_READ_digit_LONG = QR_AI_CUST_MBRCD_digit_LONG + QR_AI_CUST_MBRINPUT_digit + (QR_AI_CUST_TTLPNT_digit *2);
const int QR_AI_MBR_TYP_digit = 2;
const int QR_AI_CUST_READ_digit_MATGN = QR_AI_CUST_MBRCD_digit + QR_AI_CUST_MBRINPUT_digit + QR_AI_MBR_TYP_digit + (QR_AI_CUST_TTLPNT_digit *2);
const int QR_AI_CUST_RWC_WRITE_PNT_DIGIT = 8;
const int QR_AI_COGCA_TYP_digit = 2;
const int QR_AI_COGCA_CODE_digit = 16;
const int QR_AI_VALUECARD_TYP_digit = 2;
const int QR_AI_VALUECARD_CODE_digit = 16;
const int QR_AI_REPICA_TYP_digit = 2;
const int QR_AI_REPICA_CODE_digit = 16;
const int QR_AI_AJS_EMONEY_TYP_digit = 2;
const int QR_AI_AJS_EMONEY_CODE_digit = 16;
const int QR_AI_AJS_EMONEY_JIS1_digit = 39;
const int QR_AI_SALE_LMTBAR26_digit = 26;
const int QR_AI_MAMMY_CHK_STAFFCD_digit = 6;
const int QR_AI_CHK_MARUSYO_MBRSVCTK_digit = 8; // 丸正総本店様対応、会員呼出時の割戻しポイント
const int QR_AI_CHK_TRM_STL_DSC_digit = 2;
const int QR_AI_CHK_TRM_CUST_STL_DSC_digit = 2;
const int QR_AI_CHK_TRM_INFO_digit = QR_AI_CHK_TRM_STL_DSC_digit + QR_AI_CHK_TRM_CUST_STL_DSC_digit;
const int QR_AI_ICHIYAMA_BDLCD_digit = 9;
const int QR_AI_ICHIYAMA_BDLTYP_digit = 1;
const int QR_AI_ICHIYAMA_BDL_digit = QR_AI_ICHIYAMA_BDLCD_digit + QR_AI_ICHIYAMA_BDLTYP_digit;
const int QR_AI_REG_STARTTIME_D_digit = 19;
const int QR_AI_REG_STARTTIME_W_digit = 1;
const int QR_AI_REG_STARTTIME_digit = QR_AI_REG_STARTTIME_D_digit + QR_AI_REG_STARTTIME_W_digit;
//static const int QR_AI_TAXFREEIN_STATUS_digit = 2;
const int QR_AI_DLG_PLUVOID_digit = 2;
const int QR_AI_DPOINT_INQINFO_digit = 35;
const int QR_AI_DPOINT_ORGDATA_digit = 22;
const int QR_AI_DPOINT_UPDINFO_digit = 56;

const int QR_AI_RCPT_RATE_digit4 = 4;
const int QR_AI_RCPT_RATE_digit5 = 5;

const int QR_AI_CHK_CHGAMT_digit = 7;
const int QR_AI_CHK_RESIDUAL_AMT_digit = 7;

const int QR_AI_DATA_digit_SCRVOID = 4;
const int QR_AI_DATA_digit_SCRVOID2 = 2;

const int QR_AI_DATA_digit_CHA_CHK = 7;
const int QR_AI_DATA_digit_CHG_QTY = 3;
const int QR_AI_ZHQ_MBR_CD_digit = 17;
const int QR_AI_ZHQ_NONPFL_digit = 33;
const int QR_AI_ZHQ_MGNON_digit = 16;

const int QR_AI_REPICAPNT_PAY_digit = 49;
const int QR_AI_REPICAPNT_PAY_digit2 = 56;
const int QR_AI_REPICAPNT_PAY_digit3 = 48;
const int QR_AI_REPICAPNT_ADD_digit = 3;

const int QR_HEADER_NAME_DIGIT = 2;
const int QR_HEADER_CODE_DIGIT = 4;
const int QR_HEADER_PRINTER_DIGIT = 1;
const int QR_HEADER_OPEMODE_DIGIT = 5;
const int QR_HEADER_SALEDATE_DIGIT = 8;
const int QR_HEADER_DATE_DIGIT = 8;
const int QR_HEADER_TIME_DIGIT = 4;
const int QR_HEADER_MACNO_DIGIT = 6;
const int QR_HEADER_RCPT_DIGIT = 4;
const int QR_HEADER_JARNAL_DIGIT = 4;
const int QR_HEADER_TTLQTY_DIGIT = 4;
const int QR_HEADER_SALEAMT_DIGIT = 8;
const int QR_HEADER_PAGE_DIGIT = 2;
const int QR_HEADER_TTL_DIGIT = (QR_HEADER_CODE_DIGIT + QR_HEADER_SALEDATE_DIGIT + QR_HEADER_PRINTER_DIGIT + QR_HEADER_OPEMODE_DIGIT + QR_HEADER_DATE_DIGIT + QR_HEADER_TIME_DIGIT + QR_HEADER_MACNO_DIGIT + QR_HEADER_RCPT_DIGIT + QR_HEADER_JARNAL_DIGIT + QR_HEADER_TTLQTY_DIGIT + QR_HEADER_SALEAMT_DIGIT + QR_HEADER_PAGE_DIGIT + QR_HEADER_PAGE_DIGIT);

const int OK = 0;
const int NG = 1;

  // #if SS_CR2
const int CR40_HEADER_MACNO_DIGIT = 9;
const int CR40_HEADER_RCPT_DIGIT = 9;
const int CR40_HEADER_NAME_DIGIT = 2;
const int CR40_HEADER_TTL_DIGIT = (QR_HEADER_CODE_DIGIT + QR_HEADER_SALEDATE_DIGIT + QR_HEADER_PRINTER_DIGIT + QR_HEADER_OPEMODE_DIGIT + QR_HEADER_DATE_DIGIT + QR_HEADER_TIME_DIGIT + CR40_HEADER_MACNO_DIGIT + CR40_HEADER_RCPT_DIGIT + QR_HEADER_JARNAL_DIGIT + QR_HEADER_TTLQTY_DIGIT + QR_HEADER_SALEAMT_DIGIT + QR_HEADER_PAGE_DIGIT + QR_HEADER_PAGE_DIGIT);

const String CR40_AI_CHK_HEADER_CODE = "QR";
  // #endif

const String QR_CHMOD666 = "/bin/chmod 666 ";
const String QR_MV_TXT = "/bin/mv ";

const int QR_ARCS_MBR_JIS2 = QR_AI_ARCS_MBR_JIS2 + 1000;
const int QR_REG_STARTTIME  = QR_AI_REG_STARTTIME + 1000;

/// QRファイル内のスプリット変更タイプ
/// 関連tprxソース: qr2txt.h - QR_SptendChg_Type
enum QR_SptendChg_Type {
  QR_SPTEND_NORMAL,	// なにもしない
  QR_SPTEND_DELETE,	// 任意のスプリット段を削除する
  QR_SPTEND_CHANGE,	// 任意のスプリット段を変更する
  QR_STRING_INSERT,	// 任意のスプリット段の前に任意の文字列を追加する
}

/// 乗算方法
/// 関連tprxソース: qr2txt.h - QR_SptendChg_OpeType
enum QR_SptendChg_OpeType {
	QR_SPTEND_OPE_NORMAL,	// ターミナルでの乗算タイプ
	QR_SPTEND_OPE_ETC,		// ユーザーコードでの乗算タイプ
}

/// QRファイル内のスプリット変更のための構造体
/// 関連tprxソース: qr2txt.h - QR_SptendChg_Param
class QR_SptendChg_Param {
	QR_SptendChg_Type	    Type;		  // スプリットの変更タイプ
	QR_SptendChg_OpeType	OpeType;	// 乗算方法
	int			      Step;		// 変更したいスプリット段数
	int			      Code;		// 変更後のスプリットコード
	int			      Amt;		// 変更後のスプリット金額(券面額)
	int			      Sht;		// 変更後のスプリット枚数
	List<String>	OpeStr;	// 操作内容
	String	      InsStr;	// 追加する操作内容

  QR_SptendChg_Param({
    required this.Type,
    required this.OpeType,
    required this.Step,
    required this.Code,
    required this.Amt,
    required this.Sht,
    required this.OpeStr,
    required this.InsStr,
  });
}

class Qr2Txt {
  /*---------------------------------------------------------------------------*
   * Prototype Definitions
   *---------------------------------------------------------------------------*/
  int	name_status = 0;
  int	ai_flg = QR_STATUS_OFF;
  int	digit = 0;
  int	ai_code = 0;
  int	ai_line_cnt = 0;
  int	ai_digit_cnt = 0;
  String	QRReadBuf = "";  /* QR Code Read Message buffer */
  String	qr_txt_path = "";
  int	QR_prn_length = 0;
  EnvironmentData envData = EnvironmentData();


  /// QRコードの内容をファイルに書き込む
  ///
  /// 引数：log 　QRコードの文字列
  ///
  ///      filename　ファイル名
  ///
  ///      log_size　QRコードの文字列長
  ///
  /// 戻値：成否（0：成功（OK）、1：失敗（NG））
  ///
  ///  関連tprxソース:qr2txt.c - cmQrToTxtWrite()
  Future<int> cmQrToTxtWrite(String log, String filename, int log_size) async {

    /*** FILE PATH CREATE ***/
    if( name_status == 0 ) {
      if(await TextPathCreate(filename) != 0) {
        return NG;
      }
      digit = 0;
      ai_line_cnt = 0;
      ai_digit_cnt = 0;
      ai_flg = QR_STATUS_OFF;
    }

    /*** FILE OPEN ***/
    final File fp = File(qr_txt_path);
    try {
      if (fp.existsSync() == false) {
        fp.writeAsStringSync("");
      }
    } catch(e) {
      return NG;
    }

    if( name_status == 0 ) {
      name_status = 1;
    }

    /*** LOG EDIT ***/
    try {
      QrRet qrRet = TextEdit(log, log_size);
      if (qrRet.ret == OK) {
        await fp.writeAsString(
            qrRet.strBuf, mode: FileMode.append, encoding: utf8, flush: false);
      }
    } catch(e) {
      return NG;
    }
    return OK;
  }

  /// QRコードの内容を書き込むテキストファイルのパスを生成する。
  ///
  /// 引数：なし
  ///
  /// 戻値：なし
  ///
  ///  関連tprxソース:qr2txt.c - TextEdit()
  Future<int> TextPathCreate(String filename) async {
    qr_txt_path = EnvironmentData().sysHomeDir +
        QR2TEXT_TEXT_DIR + QR2TEXT_TEXT_NAME + filename + ".TXT";
    return OK;
  }

  /// QRコードの文字列を１文字ずつ取得し、所定の位置で改行コードを差し込む編集を行う。
  ///
  /// 引数：QRコードの文字列（１文字）
  ///
  /// 戻値：編集結果（qrRet：成否、および編集後の文字列）
  ///
  /// 関連tprxソース:qr2txt.c - TextEdit()
  QrRet TextEdit(String data, int data_size) {
    //String	asc = "";
    int	ai_chk = 0;
    int	ai_digit = 0;
    QrRet qrRet = QrRet();

    qrRet.strBuf = data;

    if( ai_line_cnt == 0) {
      QRReadBuf = "";
    }
    QRReadBuf += data;
    ai_line_cnt ++;

    ai_chk = cmQrToTxtChkAi(QRReadBuf);

    if (ai_flg == 0) {
      if (ai_chk != 0) {
        ai_code = int.parse(QRReadBuf);
        ai_flg = QR_STATUS_ON;
        if (QRReadBuf == QR_AI_CHK_HEADER_CODE) {
          ai_line_cnt = QR_HEADER_CODE_DIGIT;
          ai_digit_cnt = 2;
        } else {
          ai_line_cnt = 0;
          ai_digit_cnt = 0;
        }
      }
    }

    if (ai_flg != 0) {
      if( (ai_digit_cnt == 2) && (digit == 0) ) {
        ai_line_cnt = 0;
        digit = int.parse(QRReadBuf);
      } else if( digit == 0 )	{
        ai_digit_cnt++;
        return qrRet;
      }

      switch( ai_code ) {
        case QR_AI_HEADER_CODE:
          if( ai_line_cnt == QR_HEADER_CODE_DIGIT ) {
            ai_digit = QR_HEADER_CODE_DIGIT;
            qrRet.strBuf += "\n";
          } else if ( ai_line_cnt == (ai_digit + QR_HEADER_PRINTER_DIGIT) ) {
            ai_digit = ai_digit + QR_HEADER_PRINTER_DIGIT;
            qrRet.strBuf += "\n";
          } else if ( ai_line_cnt == (ai_digit + QR_HEADER_OPEMODE_DIGIT) ) {
            ai_digit = ai_digit + QR_HEADER_OPEMODE_DIGIT;
            qrRet.strBuf += "\n";
          } else if ( ai_line_cnt == (ai_digit + QR_HEADER_SALEDATE_DIGIT) ) {
            ai_digit = ai_digit + QR_HEADER_SALEDATE_DIGIT;
            qrRet.strBuf += "\n";
          } else if ( ai_line_cnt == (ai_digit + QR_HEADER_DATE_DIGIT) ) {
            ai_digit = ai_digit + QR_HEADER_DATE_DIGIT;
            qrRet.strBuf += "\n";
          } else if ( ai_line_cnt == (ai_digit + QR_HEADER_TIME_DIGIT) ) {
            ai_digit = ai_digit + QR_HEADER_TIME_DIGIT;
            qrRet.strBuf += "\n";
          } else if ( ai_line_cnt == (ai_digit + QR_HEADER_MACNO_DIGIT) ) {
            ai_digit = ai_digit + QR_HEADER_MACNO_DIGIT;
            qrRet.strBuf += "\n";
          } else if ( ai_line_cnt == (ai_digit + QR_HEADER_RCPT_DIGIT) ) {
            ai_digit = ai_digit + QR_HEADER_RCPT_DIGIT;
            qrRet.strBuf += "\n";
          } else if ( ai_line_cnt == (ai_digit + QR_HEADER_JARNAL_DIGIT) ) {
            ai_digit = ai_digit + QR_HEADER_JARNAL_DIGIT;
            qrRet.strBuf += "\n";
          } else if ( ai_line_cnt == (ai_digit + QR_HEADER_TTLQTY_DIGIT) ) {
            ai_digit = ai_digit + QR_HEADER_TTLQTY_DIGIT;
            qrRet.strBuf += "\n";
          } else if ( ai_line_cnt == (ai_digit + QR_HEADER_SALEAMT_DIGIT) ) {
            ai_digit = ai_digit + QR_HEADER_SALEAMT_DIGIT;
            qrRet.strBuf += "\n";
          } else if ( ai_line_cnt == (ai_digit + QR_HEADER_PAGE_DIGIT) ) {
            ai_digit = ai_digit + QR_HEADER_PAGE_DIGIT;
            qrRet.strBuf += "\n";
          } else if ( ai_line_cnt == (ai_digit + QR_HEADER_PAGE_DIGIT) ) {
            qrRet.strBuf = TextEdit_Init(qrRet.strBuf);
          }
          break;
        default:
          if( ai_line_cnt == digit ) {
            qrRet.strBuf = TextEdit_Init(qrRet.strBuf);
          }
          break;
      }
    }
    if(data == ScanRcv.CRcode) {
      qrRet.strBuf += "\n";
      name_status = 0;
    }
    return qrRet;
  }

  /// QRコードのファイルに書き込み処理のパラメータ初期化
  ///
  /// 引数：log 　QRコードの文字列
  ///
  /// 戻値：文字列
  ///
  ///  関連tprxソース:qr2txt.c - TextEdit_Init()
  String TextEdit_Init(String log) {
    log += "\n";
    digit = 0;
    ai_line_cnt = 0;
    ai_digit_cnt = 0;
    ai_flg = QR_STATUS_OFF;
    return log;
  }

  /// chmod起動
  ///
  /// 引数：なし
  ///
  /// 戻値：なし
  ///
  ///  関連tprxソース:qr2txt.c - cm_qr_to_txt_chmod()
  void cmQrToTxtChmod() {

    name_status = 0;
    String cmd = QR_CHMOD666 + qr_txt_path;   // "/bin/chmod 666 " + getenv("TPRX_HOME")

    // TODO:system() ⇒　別のプログラムを起動する。　・・・　どうやって？
    // int ret = system(cmd);

    return;
  }

  /// 引数で渡された文字列中に特定の文字パターンが有った場合、存在有無を返す
  ///
  /// 引数：buf　QRコードの文字列
  ///
  /// 戻値：存在有無（0：なし（OK）、1：あり）
  ///
  ///  関連tprxソース:qr2txt.c - cm_qr_to_txt_chk_ai()
  int cmQrToTxtChkAi(String buf) {
    try {
      if (buf.length < QR_AI_CHK_DIGIT) {
        return (0);
      }
      if ((buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_JAN_EAN13) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_UPCA) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_UPCE) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_ITF) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_Codabar) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_Code128) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_Code39) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_GS1_RSS_14) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_GS1_RSS_Ltd) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_GS1_RSS_Exp) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_KEY) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_KEY_PLU) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_KEY_MG) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_KEY_MUL) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_KEY_PRC) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_KEY_DSC) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_KEY_PDSC) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_KEY_MAG) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_KEY_SCRVOID) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_KEY_CHA_CHK) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_KEY_CHG_QTY) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_KEY_STLCNCL) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_KEY_PLUSCNCL) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_KEY_RBTCNCL) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_CSHR_NO) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_NOTUSE) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_CUST_READ) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_TRM_INFO) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_CUST_READ_HT2980) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_SCALE) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_CHGAMT) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_CUST_READ_FELICA) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_EDY_CD) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_ARCS_MBR_JIS2) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_BDLONELIMIT) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_CUST_READ_LONG) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_CUST_READ_MATGN) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_CUST_RWC_WRITE_PNT) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_ICHIYAM_BDL_SLCT) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_REG_STARTTIME) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_RCPT_RATE4) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_RCPT_RATE5) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_COGCA_CODE) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_SALE_LMTBAR26) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_MAMMY_CHK_STAFFCD) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_REPICA_CODE) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_AJS_EMONEY_CODE) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_PRECA_AUTO_SALES) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_ZHQ_MBR_CD) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_ZHQ_NONPFL) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_ZHQ_MGNON) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_RESIDUAL_AMT) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_CHANGE_SELECTITEMS) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_SPTEND_SELECT_NO) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_MARUSYO_MBRSVCTK) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_DLG_PLUVOID) ||
//      (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_TAXFREEIN_STATUS) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_DPOINT_INQINFO) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_DPOINT_ORGDATA) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_DPOINT_UPDINFO) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_REPICAPNT_CODE) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_REPICAPNT_CODE2) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_REPICAPNT_CODE3) ||
          (buf.substring(0, QR_AI_CHK_DIGIT) == QR_AI_CHK_REPICAPNTADD_CODE) ||
          (buf.substring(0, QR_HEADER_CODE_DIGIT) == QR_AI_CHK_HEADER_CODE)) {
        return (1);
      } else {
        return (0);
      }
    } catch(e) {
      return (0);
    }
  }


// /*---------------------------------------------------------------------------*
//  * Program cmQrToTxtWrite(uchar log, uchar filename, int log_size)
//  * return : OK / NG
//  *---------------------------------------------------------------------------*/
///関連tprxソース:qr2txt.c - cm_Chk_to_txt_write
int	cm_Chk_to_txt_write(String log, String writePath) {
  try {
    File file = File(writePath);
    file.writeAsStringSync(log, mode: FileMode.append);
  } catch(e) {
    TprLog().logAdd(
          Tpraid.TPRAID_CHK, LogLevelDefine.error, "cm_Chk_to_txt_write NG[$log]\n");
    return NG;
  }

  return OK;
}

//
// /*---------------------------------------------------------------------------*
//  * Program cm_QR_Select_Dot_Size(uchar log, long receipt_no)
//  * return : OK / NG
//  *---------------------------------------------------------------------------*/
// int	cm_QR_Select_Dot_Size( void )
// {
// //	if( cm_Receipt_QR_system() ) {
// if( QR_prn_length > 1500)
// return QR_3_DOT;
// else
// return QR_4_DOT;
// //	}
// //	else
// //		return QR_4_DOT;
// }
//
// /*---------------------------------------------------------------------------*
//  *   Wiz精算仕様 ＆ WizWiFi仕様関連Lib
//  *---------------------------------------------------------------------------*/
// static int cm_WizAdj_DataChk_RG(const struct dirent *fileList)
// {
// int i, cnt;
// /* ヘッダ部が 9999 でないデータは無視する */
// if((fileList->d_name[0] == '9') &&
// (fileList->d_name[1] == '9') &&
// (fileList->d_name[2] == '9') &&
// (fileList->d_name[3] == '9') &&
// (fileList->d_name[5] == '1')) {
// return(1);
// }
// else if((fileList->d_name[0]  == 'P') &&
// (fileList->d_name[1]  == 'H') &&
// (fileList->d_name[2]  == '_') &&
// (fileList->d_name[17] == '.')) {
// for(cnt = 0, i = 18; i < 36; i ++) {
// if(fileList->d_name[i]  == '.') {
// cnt ++;
// }
// if(cnt == 4) {
// break;
// }
// }
// if(fileList->d_name[i+6]  == '1')
// return(1);
// else
// return(0);
// }
// return(0);
// }
//
// static int cm_WizAdj_DataChk_TR(const struct dirent *fileList)
// {
// int i, cnt;
// /* ヘッダ部が 9999 でないデータは無視する */
// if((fileList->d_name[0] == '9') &&
// (fileList->d_name[1] == '9') &&
// (fileList->d_name[2] == '9') &&
// (fileList->d_name[3] == '9') &&
// (fileList->d_name[5] == '2')) {
// return(1);
// }
// else if((fileList->d_name[0]  == 'P') &&
// (fileList->d_name[1]  == 'H') &&
// (fileList->d_name[2]  == '_') &&
// (fileList->d_name[17] == '.')) {
// for(cnt = 0, i = 18; i < 36; i ++) {
// if(fileList->d_name[i]  == '.') {
// cnt ++;
// }
// if(cnt == 4) {
// break;
// }
// }
// if(fileList->d_name[i+6]  == '2')
// return(1);
// else
// return(0);
// }
// return(0);
// }
//
// extern void cm_WizAdj_QRTxtData_Make(TPRMID tid, int ope_mode)
// {
// /* QR仕様のPGを使う為に、元テキストの中を1Byteずつ抽出し、QR仕様のPGで使えるテキストを作る */
//   char   dirname[TPRMAXPATHLEN];
//   char   fname[TPRMAXPATHLEN];
//   char   mname[TPRMAXPATHLEN];
//   char   wifi[TPRMAXPATHLEN];
//   struct dirent  **fileList;
// struct stat    statbuf;
// int    ret;
//   int    i;
//   FILE   *fp;
//   int    read_data;
//   char   devmsg_dummy;
//   short  data_cnt;
//   char   erlog[128];
//   int    s, cnt;
//
//   name_status = 0;   /* 念の為、イニシャルする */
//   memset(dirname, 0x0, sizeof(dirname));
//   snprintf(dirname, sizeof(dirname), "%s%s", getenv("TPRX_HOME"), QR2TEXT_TEXT_DIR);
//   switch(ope_mode)
//   {
//   case OPE_MODE_REG : /* 登録 */
//   ret = scandir(dirname, &fileList, cm_WizAdj_DataChk_RG, alphasort);
//   break;
//   case OPE_MODE_TRAINING : /* 訓練 */
//   ret = scandir(dirname, &fileList, cm_WizAdj_DataChk_TR, alphasort);
//   break;
//   default:
//   snprintf(erlog, sizeof(erlog), "%s : ope_mode_flg[%d] NG\n", __FUNCTION__, ope_mode);
//   TprLibLogWrite(tid, TPRLOG_ERROR, -1, erlog);
//   return;
//   }
//   if(ret <= 0) {
//   snprintf(erlog, sizeof(erlog), "%s : scandir ret = [%d]\n", __FUNCTION__, ret);
//   TprLibLogWrite(tid, TPRLOG_ERROR, -1, erlog);
//
//   for(i = 0; i < ret; i++) {
//   free(fileList[i]);
//   }
//   free(fileList);
//
//   return;
//   }
//
//   for(i = 0; i < ret; i++) {
// memset(fname, 0x0, sizeof(fname));
// snprintf(fname, sizeof(fname), "%s%s", dirname, fileList[i]->d_name);
//
// memset(mname, 0x0, sizeof(mname));
// snprintf(mname, sizeof(mname), "%s/%s%s", getenv("TPRX_HOME"), CHK2TEXT_TEXT_DIR, fileList[i]->d_name);
// stat(fname, &statbuf);
// if(statbuf.st_mode & S_IWOTH) {
// if((fileList[i]->d_name[0] == 'P') && (fileList[i]->d_name[1] == 'H')) {
// for(cnt = 0, s = 18; i < 36; s ++) {
// if(fileList[i]->d_name[s]  == '.') {
// cnt ++;
// }
// if(cnt == 4) {
// break;
// }
// }
// memset(wifi, 0x0, sizeof(wifi));
// if(fileList[i]->d_name[s+5] == '1') {
// sprintf(wifi, "%sWIZ_%s.TXT", dirname, fileList[i]->d_name);
// }
// else {
// sprintf(wifi, "%sPOS_%s.TXT", dirname, fileList[i]->d_name);
// }
// rxFileCopy(wifi, fname);
// }
// else {
// if((fp = fopen(fname, "r")) != NULL) {
// data_cnt = 0;
// while((read_data = fgetc(fp)) != EOF) {
// devmsg_dummy = (char)read_data;
// data_cnt ++;
// if(data_cnt > 56) {
// /* ヘッダ部のデータ 56Byte は、QR仕様のLibで利用できない */
// cm_WizAdj_Txt_Write(tid, devmsg_dummy, fileList[i]->d_name, 1, 0);
// }
// }
// }
// if(fp != NULL)
// fclose(fp);
// }
// rxFileMove(mname, fname);
// }
// else {
// snprintf(erlog, sizeof(erlog), "%s : st_mode error [%s]\n", __FUNCTION__, fileList[i]->d_name);
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, erlog);
// }
// }
//
//   for(i = 0; i < ret; i++) {
// free(fileList[i]);
// }
//   free(fileList);
// }
//
// static void cm_WizAdj_Txt_Write(TPRMID tid, char data, char *filename, int size, short stat)
// {
// FILE  *fp;
// char *buf;
// char  erlog[128];
//
// memset(qr_txt_path, 0x00, sizeof(qr_txt_path));
// if(stat == 1) {   /* カスタマーカード */
// sprintf(qr_txt_path, "%s%s%s%s", getenv("TPRX_HOME"), QR2TEXT_TEXT_DIR, filename, ".TXT");
// }
// else {
// if(filename[4] == '1')
// sprintf(qr_txt_path, "%s%s%s%s%s", getenv("TPRX_HOME"), QR2TEXT_TEXT_DIR, "WIZ", filename, ".TXT");
// else
// sprintf(qr_txt_path, "%s%s%s%s%s", getenv("TPRX_HOME"), QR2TEXT_TEXT_DIR, "POS", filename, ".TXT");
// }
// if(name_status == 0) {
// digit        = 0;
// ai_line_cnt  = 0;
// ai_digit_cnt = 0;
// ai_flg       = QR_STATUS_OFF;
// }
//
// if((fp = fopen(qr_txt_path, "a")) == NULL) {
// snprintf(erlog, sizeof(erlog), "%s : fopen error\n", __FUNCTION__);
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, erlog);
// return;
// }
//
// if((buf = malloc(128)) == NULL) {
// fclose(fp);
// snprintf(erlog, sizeof(erlog), "%s : malloc error\n", __FUNCTION__);
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, erlog);
// return;
// }
//
// if(name_status == 0) {
// name_status = 1;
// }
//
// memset(buf, 0x00, size);
// if(TextEdit(buf, data, size) == OK) {
// fprintf(fp, buf);
// }
//
// fclose(fp);
// free(buf);
// }
//
// extern void cm_WizCustomer_QRTxtData_Make(TPRMID tid, char *file_name)
// {
// /* QR仕様のPGを使う為に、元テキストの中を1Byteずつ抽出し、QR仕様のPGで使えるテキストを作る */
// char   dirname[TPRMAXPATHLEN];
// char   fname[TPRMAXPATHLEN];
// char   mname[TPRMAXPATHLEN];
// FILE   *fp;
// int    read_data;
// char   devmsg_dummy;
// short  data_cnt;
//
// name_status = 0;   /* 念の為、イニシャルする */
// memset(dirname, 0x0, sizeof(dirname));
// snprintf(dirname, sizeof(dirname), "%s%s", getenv("TPRX_HOME"), QR2TEXT_TEXT_DIR);
//
// memset(fname, 0x0, sizeof(fname));
// snprintf(fname, sizeof(fname), "%s/%s", dirname, file_name);
//
// memset(mname, 0x0, sizeof(mname));
// snprintf(mname, sizeof(mname), "%s/%s/%s", getenv("TPRX_HOME"), CHK2TEXT_TEXT_DIR, file_name);
// if((fp = fopen(fname, "r")) != NULL) {
// data_cnt = 0;
// while((read_data = fgetc(fp)) != EOF) {
// devmsg_dummy = (char)read_data;
// data_cnt ++;
// if(data_cnt > 56) {
// /* ヘッダ部のデータ 56Byte は、QR仕様のLibで利用できない */
// cm_WizAdj_Txt_Write(tid, devmsg_dummy, file_name, 1, 1);
// }
// }
// }
// if(fp != NULL)
// fclose(fp);
// rxFileMove(mname, fname);
// }
//
// static int cm_WizAdj_DataChk_WIZ(const struct dirent *fileList)
// {
// /* ヘッダ部が WIZ でないデータは無視する */
// if((fileList->d_name[0] == 'W') &&
// (fileList->d_name[1] == 'I') &&
// (fileList->d_name[2] == 'Z')) {
// return(1);
// }
// return(0);
// }
//
// extern void cm_WizAdj_ErrFile_Move(TPRMID tid)
// {
//   char   dirname[TPRMAXPATHLEN];
//   char   fname[TPRMAXPATHLEN];
//   char   mname[TPRMAXPATHLEN];
//   struct dirent  **fileList;
// int    ret;
// int    i;
// char   erlog[128];
//
// memset(dirname, 0x0, sizeof(dirname));
// snprintf(dirname, sizeof(dirname), "%s%s", getenv("TPRX_HOME"), QR2TEXT_TEXT_DIR);
// ret = scandir(dirname, &fileList, cm_WizAdj_DataChk_WIZ, alphasort);
// if(ret <= 0) {
// snprintf(erlog, sizeof(erlog), "%s : scandir ret = [%d]\n", __FUNCTION__, ret);
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, erlog);
//
// for(i = 0; i < ret; i++) {
// free(fileList[i]);
// }
// free(fileList);
//
// return;
// }
//
// for(i = 0; i < ret; i++) {
// memset(fname, 0x0, sizeof(fname));
// snprintf(fname, sizeof(fname), "%s/%s", dirname, fileList[i]->d_name);
//
// memset(mname, 0x0, sizeof(mname));
// snprintf(mname, sizeof(mname), "%s/%s/NG_%s", getenv("TPRX_HOME"), CHK2TEXT_TEXT_DIR, fileList[i]->d_name);
// rxFileMove(mname, fname);
// }
//
//   for(i = 0; i < ret; i++) {
// free(fileList[i]);
// }
//   free(fileList);
// }
//
// #define	QR_DEL_READ_SIZE	16384	// 1度に読み込むバッファサイズ
// #define	QR_DEL_LOOP_MAX		2049	// 最大ループ回数(無限ループ回避用)
// //	関数:	cm_qr_sptend_chg()
// //	機能:	QRファイルのスプリット情報を削除, または, 変更する関数
// //		元ファイルであるpathの中身を精査していき, テンポラリファイルにスプリット以外, 及び, 変更の場合はスプリットの変更分を書き込み,
// //		最終的にテンポラリファイルを元ファイルにリネームして終了させる.
// //		スプリット行は, ファイルの最後から読み込んでいく.
// //	引数:	path: 対象QRファイル
// //		spChg: 変更データを格納する構造体
// extern	int	cm_qr_sptend_chg(TPRTID tid, char *path, QR_SptendChg_Param *spChg)
// {
    // FILE	*rFp;
    // FILE	*wFp;
    // char	log[128];
    // char	tempPath[128];
    // char	buf[QR_DEL_READ_SIZE + 1];
    // char	buf2[QR_DEL_READ_SIZE + 1];
    // int	ret;
    // long	readSize;	// 1回に読み込むバッファサイズ
    // long	endPosi;	// ファイル内を精査するときの最終位置	
    // long	fileSize = 0;	// ファイルサイズ
    // long	chkPosi = 0;
    // char	*chkPnt;
    // char	*resPnt;
    // int	nlinePosi;	// 改行位置. 次回読み込み開始位置は改行からでないと抜けが生じるため.
    // long	passSize;
    // long	sptStartPosi = -1;	// スプリット変更の最初の位置(ファイルの先頭の位置)
    // long	sptEndPosi = -1;	// スプリット変更の最後の位置
    // char	*pntStart;
    // char	*pntEnd;
    // int	num;
    // int	qrKeyCd;
    // int	qrSptendCnt;
// // キーリストはスプリット操作の部分を判断するために必要. これ以外の操作が絡む場合は修正が必要.
// short	keyList[] =
// {
// KY_CASH,
// KY_CHA1, KY_CHA2, KY_CHA3, KY_CHA4, KY_CHA5, KY_CHA6, KY_CHA7, KY_CHA8, KY_CHA9, KY_CHA10,
// KY_CHK1, KY_CHK2, KY_CHK3, KY_CHK4, KY_CHK5,
// KY_CHA11, KY_CHA12, KY_CHA13, KY_CHA14, KY_CHA15, KY_CHA16, KY_CHA17, KY_CHA18, KY_CHA19, KY_CHA20,
// KY_CHA21, KY_CHA22, KY_CHA23, KY_CHA24, KY_CHA25, KY_CHA26, KY_CHA27, KY_CHA28, KY_CHA29, KY_CHA30,
// -1,
// };
// short	keyNumList[] =
// {
// KY_1, KY_2, KY_3, KY_4, KY_5, KY_6, KY_7, KY_8, KY_9, KY_0, KY_00, KY_000,
// -1,
// };
// short	keyMul = KY_MUL;	// 乗算
    // short	mulSkipFlag;		// QR_SPTEND_OPE_ETC用
    // short	*keyChkList;		// スプリットキーといっしょに使うキーリスト
    // int	size;
    // long	loopCnt = 0L;
    // int	len;
    // char	codeChk[32];
//
// snprintf(log, sizeof(log), "%s : delete or change start file[%s] [%d] [%d]\n", __FUNCTION__, path, spChg->Type, spChg->OpeType );
// TprLibLogWrite(tid, TPRLOG_NORMAL, 0, log);
//
// snprintf( tempPath, sizeof(tempPath), "%s%stemp_QR_move.txt", getenv("TPRX_HOME"), CHK2TEXT_TEXT_DIR );
//
// rFp = AplLibFileOpen(tid, path, "r");
// wFp = AplLibFileOpen(tid, tempPath, "w");
// if (   (rFp == NULL)
// || (wFp == NULL) )
// {
// AplLibFileClose(tid, rFp);
// AplLibFileClose(tid, wFp);
// return -1;
// }
//
// size = ((sizeof(keyNumList) + sizeof(keyMul)) / sizeof(short))  + 1;
// keyChkList = (short *)malloc( sizeof(short) * size );
// if (keyChkList == NULL)
// {
// AplLibFileClose(tid, rFp);
// AplLibFileClose(tid, wFp);
//
// snprintf(log, sizeof(log), "%s : malloc error[%d] \n", __FUNCTION__, errno );
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, log);
// return -1;
// }
//
// memset( keyChkList, 0x00, size );
//
// size = 0;
// for ( num = 0; keyNumList[num] != -1; num++ )
// {
// keyChkList[num] = keyNumList[num];
// size ++;
// }
//
// if (spChg->OpeType != QR_SPTEND_OPE_ETC)
// {
// keyChkList[size] = keyMul;
// size ++;
// }
//
// keyChkList[size] = -1;
//
// // テキストの現在位置を終端に移動させる. テキストの後ろから検索するため.
// ret = fseek( rFp, 0, SEEK_END );
// if ( ret != 0 )
// {
// snprintf(log, sizeof(log), "%s : fseek error errno[%d]\n", __FUNCTION__, errno);
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, log);
// ret = -1;
// }
//
// // テキストファイルの終端の位置を取得 = ファイルサイズ
// if ( ret == 0 )
// {
// ret = fgetpos( rFp, (fpos_t *)&chkPosi );
// if ( ret != 0 )
// {
// snprintf(log, sizeof(log), "%s : fgetpos error errno[%d]\n", __FUNCTION__, errno);
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, log);
// ret = -1;
// }
// else if ( chkPosi == 0 )
// {
// snprintf(log, sizeof(log), "%s : fileSize is 0\n", __FUNCTION__ );
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, log);
// ret = -1;
// }
// }
//
// readSize = QR_DEL_READ_SIZE;
// qrSptendCnt = 0;
// endPosi = chkPosi;
// fileSize = chkPosi;
// if ( ret == 0 )
// {
// // 対象となるスプリット段の行部分をテキストの後ろから検索する.
// while ( 1 )
// {
// if ( endPosi < readSize )
// {
// readSize = endPosi;
// }
//
// // readSize分, 現在位置から前に(テキストの最初の方に向かって)位置を移動させる
// ret = fseek( rFp, (readSize * -1), SEEK_CUR );
// if ( ret != 0 )
// {
// snprintf(log, sizeof(log), "%s : fseek[SEEK_CUR] error errno[%d] [%ld][%ld][%ld]\n", __FUNCTION__, errno, readSize, endPosi, fileSize);
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, log);
// ret = -1;
// break;
// }
//
// ret = fgetpos( rFp, (fpos_t *)&chkPosi );
// if ( ret != 0 )
// {
// snprintf(log, sizeof(log), "%s : fgetpos error errno[%d]\n", __FUNCTION__, errno);
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, log);
// ret = -1;
// break;
// }
//
// // 移動した分だけバッファを読み込みする
// memset( buf, 0x00, sizeof(buf) );
// ret = fread( buf, sizeof(char), readSize, rFp );
// if ( ret < readSize )
// {
// if ( ferror(rFp) != 0 )
// {
// snprintf(log, sizeof(log), "%s : fread error error[%d] [%ld][%ld][%ld]\n", __FUNCTION__, ferror(rFp), readSize, endPosi, fileSize);
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, log);
// ret = -1;
// break;
// }
// }
//
// // 後ろから1行ずつ取り出し, 削除対象のスプリットを検索する.
// chkPnt = buf;
// ret = 0;
// mulSkipFlag = 0;
// loopCnt = 0;
// while ( 1 )
// {
// // 改行コードと改行コードの間のデータを取り出していく
// memset( buf2, 0x00, sizeof(buf2) );
// pntEnd = strrchr( chkPnt, '\n' );
// if (pntEnd == NULL)
// {
// if (readSize == endPosi)
// {
// strncpy( buf2, chkPnt, sizeof(buf2) - 1 );
// pntStart = chkPnt;
// }
// else
// {
// break;
// }
// }
// else
// {
// // 改行コード部分をNULにして, その位置からまた改行コードを検索することで, 1行データとして取り扱う.
// *pntEnd = 0x00;
// pntStart = strrchr( chkPnt, '\n' );
// if (pntStart != NULL)
// {
// strncpy( buf2, pntStart + 1, sizeof(buf2) - 1 );
// }
// }
//
// // スプリット段数が同一のものを検索 -> (削除 変更行の最後)
// // それが完了したら, 前に検索を進め, keyOptListに当てはまらないキーまでを検索 -> (削除 変更行の最初)
// if ( strncmp(buf2, QR_AI_CHK_KEY, strlen(QR_AI_CHK_KEY)) == 0 )
// {
// memset( codeChk, 0x00, sizeof(codeChk) );
// strncpy( codeChk, &buf2[strlen(QR_AI_CHK_KEY)], 2 );
// len = strtol( codeChk, NULL, 10 );
//
// qrKeyCd = strtol(&buf[strlen(buf) - len], NULL, 10);
// if (sptEndPosi == -1)
// {
// if (   (spChg->OpeType == QR_SPTEND_OPE_ETC)
// && (qrKeyCd == keyMul) )
// {
// if ( spChg->Step == qrSptendCnt )
// {
// sptEndPosi = chkPosi + pntStart - buf + strlen(buf2) + (strlen("\n") * 2);
// }
// mulSkipFlag = 1;
// qrSptendCnt ++;
// }
// else
// {
// for (num = 0; keyList[num] != -1; num++ )
// {
// if (qrKeyCd == keyList[num])
// {
// if ( spChg->Step == qrSptendCnt )
// {
// sptEndPosi = chkPosi + pntStart - buf + strlen(buf2) + (strlen("\n") * 2);
// }
//
// if (mulSkipFlag != 1)
// {
// qrSptendCnt ++;
// }
// mulSkipFlag = 0;
// break;
// }
// }
// }
// }
// else
// {
// if (mulSkipFlag == 1)
// {
// for (num = 0; keyList[num] != -1; num++ )
// {
// if (qrKeyCd == keyList[num])
// {
// mulSkipFlag = 0;
// break;
// }
// }
// continue;
// }
//
// for (num = 0; keyChkList[num] != -1; num++ )
// {
// if (qrKeyCd == keyChkList[num])
// {
// qrKeyCd = -1;
// break;
// }
// }
//
// if (qrKeyCd != -1)
// {
// sptStartPosi = chkPosi + pntStart - buf + strlen(buf2) + (strlen("\n") * 2);
// break;
// }
// }
// }
// else if(strncmp(buf2, QR_AI_CHK_SPTEND_SELECT_NO, strlen(QR_AI_CHK_SPTEND_SELECT_NO)) != 0)
// {
// // キー以外の操作行の場合、検索を終了する
// // ただし、スプリット選択の操作行の場合、検索を続行する
// if ( strlen(buf2) != 0 )
// {
// if (sptStartPosi == -1)
// {
// sptStartPosi = chkPosi + pntStart - buf + strlen(buf2) + (strlen("\n") * 2);
// }
// break;
// }
// }
//
// if (   (readSize == endPosi)
// && (pntStart == chkPnt) )
// {
// snprintf(log, sizeof(log), "%s : loop check end\n", __FUNCTION__);
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, log);
// break;
// }
//
// loopCnt ++;
// if ( loopCnt > QR_DEL_LOOP_MAX )
// {
// snprintf(log, sizeof(log), "%s : loop max end\n", __FUNCTION__);
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, log);
// break;
// }
// }
//
// if ( ret == -1 )
// {
// break;
// }
//
// if (   (sptStartPosi > 0)
// && (sptEndPosi > 0) )
// {
// snprintf(log, sizeof(log), "%s : Delete Between [%ld] - [%ld]\n", __FUNCTION__, sptStartPosi, sptEndPosi );
// TprLibLogWrite(tid, TPRLOG_NORMAL, 0, log);
// ret = 0;
// if ( spChg->Type == QR_STRING_INSERT )
// sptEndPosi = sptStartPosi;
// break;
// }
//
// if ( readSize == endPosi )
// {
// snprintf(log, sizeof(log), "%s : No Such sptend[%ld][%ld][%ld]\n", __FUNCTION__, endPosi, readSize, fileSize);
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, log);
// ret = -1;
// break;
// }
//
// // 次の読み込み開始位置は改行部分からが良いため, その位置を検索する.
// // なお, 改行コードは0x00に変換しているので, 検索できない場合は, そのサイズを取る.
// nlinePosi = 0;
// resPnt = strstr( buf, "\n" );
// if ( resPnt != NULL )
// {
// nlinePosi = resPnt - buf;
// }
// else
// {
// nlinePosi = strlen(buf);
// }
//
// ret = fseek( rFp, (readSize - nlinePosi) * -1, SEEK_CUR );
// if ( ret != 0 )
// {
// snprintf(log, sizeof(log), "%s : fseek[SEEK_CUR + nline] error errno[%d] [%ld][%ld][%ld]\n", __FUNCTION__, errno, readSize, endPosi, fileSize);
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, log);
// ret = -1;
// break;
// }
//
// endPosi -= readSize - nlinePosi;
// if (endPosi <= 0 )
// {
// snprintf(log, sizeof(log), "%s : No Such Str [%ld][%ld][%ld]\n", __FUNCTION__, readSize, endPosi, fileSize);
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, log);
// ret = -1;
// break;
// }
// }
// }
//
// // テキストの現在位置を先頭に移動させる. テキストの先頭からテンポラリファイルに書き込むため
// if ( ret == 0 )
// {
// ret = fseek( rFp, 0, SEEK_SET );
// if ( ret != 0 )
// {
// snprintf(log, sizeof(log), "%s : fseek[SEEK_SET] error errno[%d] [%ld][%ld]\n", __FUNCTION__, errno, readSize, fileSize);
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, log);
// ret = -1;
// }
// }
//
// if ( ret == 0 )
// {
// passSize = 0;
// while ( 1 )
// {
// // 変更, 削除の開始位置までのサイズをまず読み込んでいく.
// // 読み込み終わったら, 終了位置まで移動させる.
// if ( sptStartPosi > 0 )
// {
// if ( sptStartPosi > (passSize + QR_DEL_READ_SIZE) )
// {
// readSize = QR_DEL_READ_SIZE;
// }
// else
// {
// readSize = sptStartPosi - passSize;
// sptStartPosi = -1;
// }
// }
// else if (sptEndPosi > 0)
// {
// ret = fseek( rFp, sptEndPosi, SEEK_SET );
// if ( ret != 0 )
// {
// snprintf(log, sizeof(log), "%s : fseek[SEEK_SET sptEndPosi] error errno[%d] [%ld]\n", __FUNCTION__, errno, sptEndPosi );
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, log);
// ret = -1;
// break;
// }
// sptEndPosi = -1;
//
// if ( spChg->Type == QR_SPTEND_CHANGE )
// {
// for ( num = 0; strlen(spChg->OpeStr[num]) != 0; num++ )
// {
// if(fprintf(wFp, "%s\n", spChg->OpeStr[num]) < 0)
// {
// snprintf(log, sizeof(log), "%s : OpeStr Write NG [%s][%d]\n", __FUNCTION__, spChg->OpeStr[num], num);
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, log);
// ret = -1;
// break;
// }
// }
// }
// else if ( spChg->Type == QR_STRING_INSERT )
// {
// if(fprintf(wFp, "%s\n", spChg->InsStr) < 0)
// {
// snprintf(log, sizeof(log), "%s : OpeStr Write NG [%s][%d]\n", __FUNCTION__, spChg->OpeStr[num], num);
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, log);
// ret = -1;
// break;
// }
// }
//
// if ( ret == -1 )
// {
// break;
// }
// continue;
// }
// else
// {
// readSize = QR_DEL_READ_SIZE;
// }
//
// memset( buf, 0x00, sizeof(buf) );
// ret = fread( buf, sizeof(char), readSize, rFp );
// if ( ret < readSize )
// {
// if ( ferror(rFp) != 0 )
// {
// snprintf(log, sizeof(log), "%s : fread error error[%d] [%ld]\n", __FUNCTION__, ferror(rFp), readSize );
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, log);
// ret = -1;
// break;
// }
// }
//
// if ( ret > 0 )
// {
// if(fprintf(wFp, "%s", buf) < 0)
// {
// snprintf(log, sizeof(log), "%s : buf Write NG [%s]\n", __FUNCTION__, buf);
// TprLibLogWrite(tid, TPRLOG_ERROR, -1, log);
// ret = -1;
// break;
// }
// }
//
// passSize += readSize;
//
// if ( feof(rFp) )
// {
// snprintf(log, sizeof(log), "%s : EOF break \n", __FUNCTION__);
// TprLibLogWrite(tid, TPRLOG_NORMAL, 0, log);
// ret = 0;
// break;
// }
//
// }
// }
//
// AplLibFileClose(tid, rFp);
// AplLibFileClose(tid, wFp);
// free( keyChkList );
//
// if (ret == -1)
// {
// AplLibRemove( tid, tempPath );
// ret = -1;
// }
// else
// {
// AplLibRename( tid, tempPath, path );
// }
//
// return (ret);
// }

  /// QRコードの内容をファイルに書き込む（CR40）
  ///
  /// 引数：log 　QRコードの文字列
  ///
  ///      filename　ファイル名
  ///
  ///      log_size　QRコードの文字列長
  ///
  /// 戻値：成否（0：成功（OK）、1：失敗（NG））
  ///
  ///  関連tprxソース:qr2txt.c - cm_qr_to_txt_write_cr40()
  Future<int> cmQrToTxtWriteCr40(String log, String filename, int log_size) async {
    if (CompileFlag.SS_CR2) {
      File fp = File(filename);
      /*** FILE OPEN ***/
      try {
        if (fp.existsSync() == false) {
          fp.writeAsStringSync("");
        }
      } catch(e) {
        return NG;
      }
      /*** WRITE ***/
      try {
          await fp.writeAsString(
              log, mode: FileMode.append, encoding: utf8, flush: false);
      } catch(e) {
        return NG;
      }
    }
    return OK;
  }

// extern int cm_WizAdj_QRTxtData_Check(TPRMID tid, short ope_mode)
// {
//   int    ret;
//   struct dirent  **fileList;
// char   dirname[TPRMAXPATHLEN];
// char   erlog[128];
//
// ret = 0;
// memset(dirname, 0x0, sizeof(dirname));
// snprintf(dirname, sizeof(dirname), "%s%s", getenv("TPRX_HOME"), QR2TEXT_TEXT_DIR);
// switch(ope_mode)
//   {
//   case 1 : /* 登録 */
//   ret = scandir(dirname, &fileList, cm_WizAdj_DataChk_RG, alphasort);
//   free(fileList);
//   break;
//   case 2 : /* 訓練 */
//   ret = scandir(dirname, &fileList, cm_WizAdj_DataChk_TR, alphasort);
//   free(fileList);
//   break;
//   default:
//   snprintf(erlog, sizeof(erlog), "%s : ope_mode_flg[%d] NG\n", __FUNCTION__, ope_mode);
//   TprLibLogWrite(tid, TPRLOG_ERROR, -1, erlog);
//   break;
//   }
//
//   return(ret);
// }
}