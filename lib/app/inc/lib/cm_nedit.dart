/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

// TODO:00012 平野 rcChgAmtMakeLcd()で使用するが、いったん保留
import 'dart:convert';
import 'dart:math';

import 'package:sprintf/sprintf.dart';

import '../../lib/apllib/apllib_strutf.dart';
import '../../lib/cm_chg/ltobcd.dart';
import 'apllib.dart';
import 'l_cm_nedit.dart';
import 'nedit_c.dart';

/// 関連tprxソース: cm_nedit.h - CmEditCtrl
class CmEditCtrl{
  int	DataSign = 0;
  int	DataSize = 0;
  int	DataNotZeroSuppress = 0;
  int	SignEdit = 0;
  int	SignSize = 0;
  int	DecimalPointEdit = 0;
  int	DecimalPointSize = 0;
  int	SeparatorEdit = 0;
  int	SeparatorSize = 0;
  int	CurrencyEdit = 0;
  int	CurrencySize = 0;
  int	CurrencyCharacter = 0;
  int	AtEdit = 0;
  int	AtSize = 0;
  int	WeightUnitEdit = 0;
  int	WeightEdit = 0;
  int	WeightSize = 0;
  int	filler = 0;
  int	LeftJustify = 0;
  int	NumberEdit = 0;
  int	AsteriskEdit = 0;
  int	AmpersandEdit = 0;	// 手入力金マークの付与を制御する値
}

class CmNedit {
  static const int BUF_SZ	= 60;

  /// 関連tprxソース: cm_nedit.c - cm_Edit_Binary_utf
  (int, int) cmEditBinaryUtf(CmEditCtrl fCtrl, List<int> pBuf, int wBufSize, int count,
      int lData, int wDataDigits, int bytes)
  {
    int eSize;
    String pBufStr;
    String wBcd;

    if (lData < 0) {
      wBcd = Ltobcd.cmLtobcd(0 - lData, 8);
    fCtrl.DataSign = 1;
    } else {
      wBcd = Ltobcd.cmLtobcd(lData, 8);
      fCtrl.DataSign = 0;
    }
    (eSize, bytes, pBufStr) = cmEditBcdUtf(fCtrl, pBuf, wBufSize, count, wBcd, 8, wDataDigits, bytes);
    return (eSize, bytes);
  }
  
  /// 関連tprxソース: cm_nedit.c - cm_Edit_Bcd_utf
  (int, int, String) cmEditBcdUtf(CmEditCtrl fCtrl, List<int> pBuf, int wBufSize, int count,
      String pData, int wDataSize, int wDataDigits, int bytes)
  {
    int		i, j;
    int		length;
    int		sep_point;
    int		f_point;
    int		width;
    int		pad_width;
    int		sep_len;
    int		e_size;
    int	upper_data = 0;
    int	lower_data = 0;
    int	data = 0;
    double fdata = 0;
    String fAscii = '';
    String buff_1 = '';
    String buff_2 = '';
    String buff_3 = '';
    List<int> wAscii = List.generate(BUF_SZ, (_) => 0);
    List<int> Ascii = List.generate(BUF_SZ, (_) => 0);
    String tmp_buff = '';
    String format = '';
    String format_upper = '';
    String format_lower = '';
    String format_p = '';
    String put_buff = '';
    String put_buff_2 = '';
    EucAdj adj = EucAdj();
    String pBufStr = "";
    List<String> pBufStrList = List.empty(growable: true);

    /* pDataを数字に切り分け	00...0123 -> '0','0',...'0','1','2','3' */
    var pData2 = pData.split('');
    List<int> pData3 = List.generate(pData2.length, (index) => 0);
    for (int i = 0; i < pData2.length; i++) {
      pData3[i] = int.tryParse(pData2[i]) ?? 0;
    }
    wAscii = List.generate(wDataSize*2, (index) => 0);
    for (int i = 0, j = 0 ; i < wDataSize ; i++, j+=2) {
      wAscii[j]     = (pData3[i] & 0xf0) ~/ 0x10 + '0'.codeUnitAt(0);
      wAscii[j + 1] = (pData3[i] & 0x0f) + '0'.codeUnitAt(0);
    }

    /* 頭の'0'を削除	'0','0',...'0','1','2','3' -> '1','2','3' */
    i = 0;
    for(int size = 0; size < wAscii.length; size++){
      if(wAscii[size] == '0'.codeUnitAt(0)){
        i++;
      }
    }

    length = 0;

    for (i; i < wAscii.length; i++) {
      Ascii.add(wAscii[i]);
      length++;
    }

    /* 小数指定がある場合は、小数部分を切り出して数値に	'1','2','3' 下２桁 -> 23 */
    i = length - fCtrl.DecimalPointEdit;
    if(i < 0) {
      i = 0;
    }
    j = 0;
    f_point = 1;
    sep_len = 3;
    fdata = 0;
    while((i != Ascii.length) && (j < fCtrl.DecimalPointEdit)) {
      fdata += (Ascii[i] - '0'.codeUnitAt(0)) / pow(10, f_point);
      Ascii[i] = 0;
      j++;
      i++;
      f_point++;
    }
    length -= j;

    if (length <= 12) {	/* １２桁以下の処理 */
      data = 0;
      for (i = 0 ; i < length ; i++) {
        data += ((Ascii[i] - '0'.codeUnitAt(0)) * pow(10, (length - i - 1))).toInt();
      }
      if ((fCtrl.SignEdit != 0) && (fCtrl.DataSign == 1)) {
        length++;
        sep_len = 4;
        data *= -1;
      }
      format = setFormat(fCtrl, wDataDigits);
      buff_1 = sprintf(format, [data]);
      put_buff = buff_1;
      if ((fCtrl.SeparatorEdit == 1) && (sep_len < length)) {
        put_buff = '${put_buff.substring(0,length - 3)},${put_buff.substring(length - 3)}';
      }
    }
    else {		/* １３桁以上の処理 */
      sep_point = length - 12;
      for (i = 0 ; i < sep_point ; i++) {
        upper_data += ((Ascii[i] - '0'.codeUnitAt(0)) * pow(10, (sep_point - i - 1))).toInt();
      }
      for (i = sep_point ; i < length ; i++) {
        lower_data += ((Ascii[i] - '0'.codeUnitAt(0)) * pow(10, (length - i - 1))).toInt();
      }
      if ((fCtrl.SignEdit != 0) && (fCtrl.DataSign == 1)) {
        length++;
        upper_data *= -1;
      }
      format_upper = setFormat2Upper(fCtrl, wDataDigits);
      format_lower = setFormat2Lower(fCtrl, wDataDigits);
      buff_1 = sprintf(format_upper, [upper_data]);
      buff_2 = sprintf(format_lower, [lower_data]);
      if (fCtrl.SeparatorEdit != 2) {
        put_buff = "$buff_1$buff_2";
        if (fCtrl.SeparatorEdit == 1) {
          put_buff = '${put_buff.substring(0,length - 3)},${put_buff.substring(length - 3)}';
        }
      } else {
        buff_2 = insertSep(buff_2);
        put_buff = "$buff_1,$buff_2";
      }
    }

    if (0 < fCtrl.DecimalPointEdit) {	/* 小数の処理 */
      format_p = setFormat3(fCtrl);
      buff_3 = sprintf(format_p, [fdata]);
      buff_3 = buff_3.substring(1);
      put_buff += buff_3;
    }

    if ((length <= 12) && (data == 0) && (fCtrl.SignEdit == 3)) {
      /* fCtrl.SignEdit = 3 で 0 の時に "-" 表示 */
      buff_1 = "-$put_buff";
      put_buff = buff_1;
    }
    e_size = put_buff.length;

    /* 半角を全角に置き換え */
    if (fCtrl.DataSize == 1) {
      (width, put_buff_2) = chgUtf(fCtrl, put_buff_2, put_buff, e_size);
    } else {
      put_buff_2 = put_buff;
      width = put_buff_2.length;
    }

    e_size = put_buff_2.length;

    if (wBufSize < e_size) {
      return (-1, bytes, pBufStr);
    }

    if (fCtrl.AtEdit == 1) {
      if (fCtrl.AtSize == 1) {			/* ＠ */
        tmp_buff = "${LCmNedit.AT_MARK_2}$put_buff_2";
        width += AplLibStrUtf.aplLibEntCnt(LCmNedit.AT_MARK_2);
      } else { 					/* @ */
        tmp_buff = "${NeditC.AT_MARK_1}$put_buff_2";
        width += 1;
      }
      put_buff_2 = tmp_buff;
    }

    switch (fCtrl.CurrencyEdit) {
      case 0:
      /* 値段マークなし */
        break;
      case 1:
      /* 値段マークを付ける */
        if (fCtrl.CurrencySize == 1) {		/* ￥ */
          tmp_buff = "${LCmNedit.CURRENCY_MARK_2}$put_buff_2";
          width += AplLibStrUtf.aplLibEntCnt(LCmNedit.CURRENCY_MARK_2);
        } else {
          tmp_buff = "${NeditC.CURRENCY_MARK_1}$put_buff_2";
          width += 1;
        }
        put_buff_2 = tmp_buff;
        break;
      case 2:
      /* 正の時値段マークを付ける */
        if ( (fCtrl.SignEdit == 0) || ( (fCtrl.SignEdit == 1) && (fCtrl.DataSign == 0) ) ) {
          if (fCtrl.CurrencySize == 1) {	/* ￥ */
            tmp_buff = "${LCmNedit.CURRENCY_MARK_2}$put_buff_2";
            width += AplLibStrUtf.aplLibEntCnt(LCmNedit.CURRENCY_MARK_2);
          } else {
            tmp_buff = "${NeditC.CURRENCY_MARK_1}$put_buff_2";
            width += 1;
          }
          put_buff_2 = tmp_buff;
        }
        break;
      case 3:
      /* データの後に値段マークを付ける */
        if (fCtrl.CurrencySize == 1) {
          if (fCtrl.CurrencyCharacter == 1) {	/* 円 */
            tmp_buff = "$put_buff_2${LCmNedit.CURRENCY_MARK_K}";
            width += AplLibStrUtf.aplLibEntCnt(LCmNedit.CURRENCY_MARK_K);
          } else {
            tmp_buff = "$put_buff_2${LCmNedit.CURRENCY_MARK_2}";
            width += AplLibStrUtf.aplLibEntCnt(LCmNedit.CURRENCY_MARK_2);
          }
        } else {
          tmp_buff = "$put_buff_2${NeditC.CURRENCY_MARK_1}";
          width += 1;
        }
        put_buff_2 = tmp_buff;
        break;
      case 4:
      /* 末尾に点マークを付ける */
      /* 点 */
        tmp_buff = "$put_buff_2${LCmNedit.POINT_LIB}";
        put_buff_2 = tmp_buff;
        width += AplLibStrUtf.aplLibEntCnt(LCmNedit.POINT_LIB);
        break;
      case 5:
      /* 末尾にPマークを付ける */
      /* Ｐ */
        tmp_buff = "$put_buff_2${LCmNedit.POINT_LIB2}";
        put_buff_2 = tmp_buff;
        width += AplLibStrUtf.aplLibEntCnt(LCmNedit.POINT_LIB2);
        break;
      case 6:
      /* 負の時値段マークを付ける */
        if(fCtrl.DataSign == 1) {
          /* ¥ */
          tmp_buff = "${LCmNedit.CURRENCY_MARK_3}$put_buff_2";
          width += AplLibStrUtf.aplLibEntCnt(LCmNedit.CURRENCY_MARK_3);
          put_buff_2 = tmp_buff;
        }
        break;
      case 7:
      /* 末尾に”枚”を付ける */
        tmp_buff = "$put_buff_2${LCmNedit.SHEET_MARK_2}";
        width += AplLibStrUtf.aplLibEntCnt(LCmNedit.SHEET_MARK_2);
        put_buff_2 = tmp_buff;
        break;
      case 8:
      /* 値段マーク(＄)を付ける */
        tmp_buff = "${LCmNedit.CURRENCY_MARK_D}$put_buff_2";
        width += AplLibStrUtf.aplLibEntCnt(LCmNedit.CURRENCY_MARK_D);
        put_buff_2 = tmp_buff;
        break;
      case 9:
      /* 末尾に”回”を付ける */
        tmp_buff = "$put_buff_2${LCmNedit.TIMES_MARK_2}";
        width += AplLibStrUtf.aplLibEntCnt(LCmNedit.TIMES_MARK_2);
        put_buff_2 = tmp_buff;
        break;
      case 10:
      /* 末尾に”％”を付ける */
        if (fCtrl.CurrencySize == 1) {
          /* ％ */
          tmp_buff = "$put_buff_2${LCmNedit.PERCENT_MARK_2}";
          width += AplLibStrUtf.aplLibEntCnt(LCmNedit.PERCENT_MARK_2);
        } else {
          /* % */
          tmp_buff = "$put_buff_2${NeditC.PERCENT_MARK_1}";
          width += 1;
        }
        put_buff_2 = tmp_buff;
        break;
      case 11:
      /* 末尾に”個”を付ける */
        tmp_buff = "$put_buff_2${LCmNedit.POINT_LIB3}";
        width += AplLibStrUtf.aplLibEntCnt(LCmNedit.POINT_LIB3);
        put_buff_2 = tmp_buff;
        break;
    }

    switch(fCtrl.NumberEdit) {
      case 0:	/* No.表示なし 00123 */
        break;
      case 1:	/* No.表示あり 00123 -> No.123 */
        put_buff_2 = NeditC.NUMBER_MARK_1 + put_buff_2;
        break;
    }
    if (fCtrl.WeightUnitEdit == 1) {
      /* 円/100g */
      tmp_buff = "$put_buff_2${LCmNedit.RATE_MARK}";
      put_buff_2 = tmp_buff;
      width += AplLibStrUtf.aplLibEntCnt(LCmNedit.RATE_MARK);
    }
    if (fCtrl.AsteriskEdit == 1) {
      /* * */
      tmp_buff = "$put_buff_2${NeditC.ASTERISK_MARK_1}";
      put_buff_2 = tmp_buff;
      width += 1;
    }
    /* 手入力金マーク'&'付与判定 */
    if (fCtrl.AmpersandEdit == 1) {	  // 手入力金マーク'&'の付与を行うか判定
      if (fCtrl.AsteriskEdit != 1) {	// 万券キーマークが付与されていないか判定
        /* 万券キーマークが付与されていない場合 */
        tmp_buff = "$put_buff_2' '";  // 万券キー表示位置に空白' 'をセット
        put_buff_2 = tmp_buff;		  	// 表示用変数にセット
        width += 1;								  	// 表示幅を調整
      }
      tmp_buff = "$put_buff_2${NeditC.AMPERSAND_MARK_1}";  // 手入力金マーク'&'をセット
      put_buff_2 = tmp_buff;							// 表示用変数にセット
      width += 1;													// 表示幅を調整
    }

    e_size = put_buff_2.length;
    pad_width = count - width;

    if (pad_width < 0) {
      adj = AplLibStrUtf.aplLibEucAdjustNeedCount(put_buff_2, width - count);
      put_buff_2 = put_buff_2.substring(adj.byte);
      pad_width = count - width + adj.count;
      e_size = put_buff_2.length;
    }

    if (wBufSize < e_size) {
      adj = AplLibStrUtf.aplLibEucAdjustNeedByte(put_buff_2, e_size - wBufSize);
      put_buff_2 = put_buff_2.substring(adj.byte);
      pad_width = count - width + adj.count;
      e_size = put_buff_2.length;
    }

    if (fCtrl.LeftJustify == 0) {
      /* 右寄せ　末尾のNULLなし */
      String sub = '';
      for (int i = 0; i < wBufSize; i++) {
        sub += ' ';
      }
      sub = sub += put_buff_2;
      pBufStr = sub;
    } else {
      /* 左寄せ　末尾のNULLあり */
      pBufStr = put_buff_2;
      pad_width = 0;
    }
    bytes = pad_width + e_size;
    return(e_size, bytes, pBufStr);
  }

  /// 関連tprxソース: cm_nedit.c - set_format
  static String setFormat(CmEditCtrl fCtrl, int wDataDigits) {
    String tmp;
    String format = "%";

    if (fCtrl.SeparatorEdit == 2) {
      format = "$format'";
    }
    if (fCtrl.SignEdit == 2) {
      format = "$format+";
    }
    if (fCtrl.DataNotZeroSuppress != 0) {
      tmp = "0$wDataDigits";
      format = format + tmp;
    }
    tmp = "d";
    format = format + tmp;
    return format;
  }

  /// 関連tprxソース: cm_nedit.c - set_format_2
  static String setFormat2Upper(CmEditCtrl fCtrl, int wDataDigits) {
    String tmp;
    String formatUpper = "%";

    if (fCtrl.SeparatorEdit == 2) {
      formatUpper = "$formatUpper'";
    }
    if (fCtrl.SignEdit == 2) {
      formatUpper = "$formatUpper+";
    }
    if (fCtrl.DataNotZeroSuppress != 0) {
      tmp = "0${wDataDigits - 12}";
      formatUpper = formatUpper + tmp;
    }
    tmp = "d";
    formatUpper = formatUpper + tmp;
    return formatUpper;
  }
  static String setFormat2Lower(CmEditCtrl fCtrl, int wDataDigits) {
    String tmp;
    String formatLower = "%";

    formatLower = "${formatLower}012";
    tmp = "d";
    formatLower = formatLower + tmp;
    return formatLower;
  }

  /// 関連tprxソース: cm_nedit.c - set_format_3
  static String setFormat3(CmEditCtrl fCtrl) {
    String formatP = "%%.${fCtrl.DecimalPointEdit}f";
    return formatP;
  }

  /// 関連tprxソース: cm_nedit.c - insert_sep
  static String insertSep(String buff) {
    /* １３桁以上の場合の下１２桁にセパレータを入れる処理 */
    String tmp = "";

    tmp += buff.substring(0, 3);
    tmp += ',';
    tmp += buff.substring(3, 6);
    tmp += ',';
    tmp += buff.substring(6, 9);
    tmp += ',';
    tmp += buff.substring(9, 12);

    buff = tmp;
    return buff;
  }

  /// 関連tprxソース: cm_nedit.c - chg_utf
  static (int, String) chgUtf(CmEditCtrl fCtrl, String out_buf, String in_buf, int in_size) {
    int i;
    int width = 0;
    out_buf = '';

    for(i = 0 ; i < in_size ; i++) {
      switch (in_buf[i]) {
        case '0':
          width += 2;
          out_buf += LCmNedit.DBL_0;
          break;
        case '1':
          width += 2;
          out_buf += LCmNedit.DBL_1;
          break;
        case '2':
          width += 2;
          out_buf += LCmNedit.DBL_2;
          break;
        case '3':
          width += 2;
          out_buf += LCmNedit.DBL_3;
          break;
        case '4':
          width += 2;
          out_buf += LCmNedit.DBL_4;
          break;
        case '5':
          width += 2;
          out_buf += LCmNedit.DBL_5;
          break;
        case '6':
          width += 2;
          out_buf += LCmNedit.DBL_6;
          break;
        case '7':
          width += 2;
          out_buf += LCmNedit.DBL_7;
          break;
        case '8':
          width += 2;
          out_buf += LCmNedit.DBL_8;
          break;
        case '9':
          width += 2;
          out_buf += LCmNedit.DBL_9;
          break;
        case '+':
          if (fCtrl.SignSize == 0) {
            width += 1;
            out_buf += "+";
          }
          else {
            width += 2;
            out_buf += LCmNedit.PLUS;
          }
          break;
        case '-':
          if (fCtrl.SignSize == 0) {
            width += 1;
            out_buf += "-";
          }
          else {
            width += 2;
            out_buf += LCmNedit.MINUS;
          }
          break;
        case '.':
          width += 1;
          out_buf += ".";
          break;
        case ',':
          width += 1;
          out_buf += ",";
          break;
        default:
          width += 1;
          out_buf += LCmNedit.DBL_SPACE;
          break;
      }
    }
    return (width, out_buf);
  }

  /// 関連tprxソース: cm_nedit.c - cm_Edit_Binary_ll_utf
  (int, int) cmEditBinaryLlUtf(
    CmEditCtrl fCtrl, 
    String pBuf, 
    int wBufSize, 
    int count, 
    int lData, 
    int wDataDigits, 
    int bytes
  ) {
    int	eSize = 0;
    String wBcd = "";//[16];
    String pBufStr = "";

    if (lData < 0)
    {
      wBcd = Ltobcd.cmLltobcd(0 - lData, 16);
      fCtrl.DataSign = 1;
    }
    else
    {
      wBcd = Ltobcd.cmLltobcd(lData, 16);
      fCtrl.DataSign = 0;
    }
    
    (eSize, bytes, pBufStr) = cmEditBcdUtf(fCtrl, utf8.encode(pBuf), wBufSize, count, wBcd, 16, wDataDigits, bytes);
    
    return (eSize, bytes);
  }

  /// 関連tprxソース: cm_nedit.c - cm_Edit_TotalPrice_utf
  (int, int) cmEditTotalPriceUtf (
  	CmEditCtrl	fCtrl,
	  List<int> pBuf, 
	  int wBufSize, 
	  int count, 
	  int lData, 
	  int bytes
  ) {
    int eSize = 0;
    
    // コンパイルスイッチのシンボル定義なし
    // #if CM_TOTALP_POINT1
    //   fCtrl.DecimalPointEdit = 0;
    // #elif CM_TOTALP_POINT2
    //   fCtrl.DecimalPointEdit = 1;
    // #elif CM_TOTALP_POINT3
    //   fCtrl.DecimalPointEdit = 2;
    // #elif CM_TOTALP_POINT4
    //   fCtrl.DecimalPointEdit = 3;
    // #endif

    fCtrl.DecimalPointSize = 0;
    fCtrl.DataNotZeroSuppress = 0;
    
    (eSize, bytes) = cmEditBinaryUtf(fCtrl, pBuf, wBufSize, count, lData, 0, bytes);

    return (eSize, bytes);
  }

  /// 関連tprxソース: cm_nedit.c - cm_Edit_UnitPrice_utf
  (int, int) cmEditUnitPriceUtf(
    CmEditCtrl fCtrl, 
    List<int> pBuf, 
    int wBufSize,
    int count, 
    int lData, 
    int bytes
  ) {
    int	eSize;
    
    // コンパイルスイッチのシンボル定義なし
    // #if CM_UNITPR_POINT1
    //   fCtrl.DecimalPointEdit = 0;
    // #elif CM_UNITPR_POINT2
    //   fCtrl.DecimalPointEdit = 1;
    // #elif CM_UNITPR_POINT3
    //   fCtrl.DecimalPointEdit = 2;
    // #elif CM_UNITPR_POINT4
    //   fCtrl.DecimalPointEdit = 3;
    // #endif
    //   fCtrl.DecimalPointSize = 0;
    // #if 0
    //   fCtrl.SeparatorEdit = 1;
    //   fCtrl.SeparatorSize = 0;
    // #endif
    fCtrl.DataNotZeroSuppress = 0;
    
    (eSize, bytes) = cmEditTotalPriceUtf(fCtrl, pBuf, wBufSize, count, lData, bytes);
    
    return (eSize, bytes);
  }

  /// 関連tprxソース: cm_nedit.c - cm_Edit_TotalPrice_ll_utf
  (int, int) cmEditTotalPriceLlUtf(
    CmEditCtrl	fCtrl, 
    List<int> pBuf, 
    int wBufSize, 
    int count, 
    int lData, 
    int bytes
  ) {
    int eSize;
    
    // コンパイルスイッチのシンボル定義なし
    // #if CM_TOTALP_POINT1
    //   fCtrl.DecimalPointEdit = 0;
    // #elif CM_TOTALP_POINT2
    //   fCtrl.DecimalPointEdit = 1;
    // #elif CM_TOTALP_POINT3
    //   fCtrl.DecimalPointEdit = 2;
    // #elif CM_TOTALP_POINT4
    //   fCtrl.DecimalPointEdit = 3;
    // #endif

    fCtrl.DecimalPointSize = 0;
    fCtrl.DataNotZeroSuppress = 0;
    
    (eSize, bytes) = cmEditBinaryUtf(fCtrl, pBuf, wBufSize, count, lData, 0, bytes);
    
    return (eSize, bytes);
  }

  /// 関連tprxソース: cm_nedit.c - cm_Edit_Weight_utf
  (int, int) cmEditWeightUtf(
    CmEditCtrl	fCtrl,
    List<int> pBuf,
    int wBufSize,
    int count,
    int lData,
    int bytes
  ) {
    int	eSize;
    EucAdj	adj;
    List<int> pbuf;
    
    // #if WT_WEIGHT_POINT1
    //   fCtrl.DecimalPointEdit = 0;
    // #elif WT_WEIGHT_POINT2
    //   fCtrl.DecimalPointEdit = 1;
    // #elif WT_WEIGHT_POINT3
    //   fCtrl.DecimalPointEdit = 2;
    // #elif WT_WEIGHT_POINT4
    //   fCtrl.DecimalPointEdit = 3;
    // #endif

    fCtrl.DecimalPointSize = 0;
    fCtrl.DataNotZeroSuppress = 0;

    if (fCtrl.WeightSize == 1)		/* 2byte character */
    {
      pbuf = utf8.encode(LCmNedit.WEIGHT_MARK_2);
      if (pbuf.length >= 60) {
        pbuf.removeRange(60 - 1, pbuf.length - 1);
      }
      (adj, pbuf) = AplLibStrUtf.aplLibByteArrayEucAdjust(pbuf, wBufSize, count);
      (eSize, bytes) = cmEditBinaryUtf(fCtrl, pBuf, wBufSize - adj.byte, count - adj.count, lData, 0, bytes);
      
      if (eSize < 0) {
        return (-1 , bytes);
      }
      pBuf.removeRange(bytes, pBuf.length);
      
      pBuf = pBuf + pbuf;
      bytes += adj.byte;
      return (eSize + adj.byte, bytes);
    } else {
      pbuf = utf8.encode(NeditC.WEIGHT_MARK_1);
      if (pbuf.length >= 60) {
        pbuf.removeRange(60 - 1, pbuf.length - 1);
      }
      (adj, pbuf) = AplLibStrUtf.aplLibByteArrayEucAdjust(pbuf, wBufSize, count);
      (eSize, bytes) = cmEditBinaryUtf(fCtrl, pBuf, wBufSize - adj.byte, count - adj.count, lData, 0, bytes);
      
      if (eSize < 0) {
        return ( -1, bytes );
      }
      pBuf.removeRange(bytes, pBuf.length);
      
      pBuf = pBuf + pbuf;
      bytes += adj.byte;
      return (eSize + adj.byte, bytes);
    }
  }

  /// 関連tprxソース: cm_nedit.c - cm_Edit_Volume_utf
  (int, int) cmEditVolumeUtf(
    CmEditCtrl	fCtrl, 
    List<int> pBuf, 
    int wBufSize, 
    int count, 
    int lData, 
    int bytes
  ) {
    int	eSize;
    EucAdj	adj;
    List<int> pbuf;
    
    // コンパイルスイッチのシンボル定義なし
    // #if WT_WEIGHT_POINT1
    //   fCtrl.DecimalPointEdit = 0;
    // #elif WT_WEIGHT_POINT2
    //   fCtrl.DecimalPointEdit = 1;
    // #elif WT_WEIGHT_POINT3
    //   fCtrl.DecimalPointEdit = 2;
    // #elif WT_WEIGHT_POINT4
    //   fCtrl.DecimalPointEdit = 3;
    // #endif

    // RM-3800で追加
    fCtrl.WeightSize = 1;					// Weight : [ml]

    fCtrl.DecimalPointSize = 0;
    fCtrl.DataNotZeroSuppress = 0;

    if (fCtrl.WeightSize == 1)		/* 2byte character */
    {
      pbuf = utf8.encode(LCmNedit.VOLUME_MARK_2);
      if (pbuf.length >= 60) {
        pbuf.removeRange(60 - 1, pbuf.length - 1);
      }
      (adj, pbuf) = AplLibStrUtf.aplLibByteArrayEucAdjust(pbuf, wBufSize, count);
      (eSize, bytes) = cmEditBinaryUtf(fCtrl, pBuf, wBufSize - adj.byte, count - adj.count, lData, 0, bytes);
      
      if(eSize < 0) {
        return ( -1, bytes );
      }
      pBuf.removeRange(bytes, pBuf.length);
      
      pBuf = pBuf + pbuf;
      bytes += adj.byte;
      return (eSize + adj.byte, bytes);
    } else {
      pbuf = utf8.encode(NeditC.VOLUME_MARK_1);
      if (pbuf.length >= 60) {
        pbuf.removeRange(60 - 1, pbuf.length - 1);
      }
      (adj, pbuf) = AplLibStrUtf.aplLibByteArrayEucAdjust(pbuf, wBufSize, count);
      (eSize, bytes) = cmEditBinaryUtf(fCtrl, pBuf, wBufSize - adj.byte, count - adj.count, lData, 0, bytes);
      
      if (eSize < 0) {
        return ( -1, bytes );
      }
      pBuf.removeRange(bytes, pBuf.length);
      
      pBuf = pBuf + pbuf;
      bytes += adj.byte;
      return(eSize + adj.byte, bytes);
    }
  }
}
