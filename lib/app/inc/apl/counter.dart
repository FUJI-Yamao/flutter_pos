/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../lib/apllib/competition_ini.dart';
import '../sys/tpr_type.dart';

///  関連tprxソース: counter.h
class Counter {
  ///  関連tprxソース: counter.h - #define	competition_get_rcptno
  static Future<int> competitionGetRcptNo(TprTID tid) async {
    CompetitionIniRet ret = await CompetitionIni.competitionIniGetRcptNo(tid);
    return ret.isSuccess ? ret.value : 0;
  }

  ///  関連tprxソース: counter.h - #define	competition_get_printno
  static Future<int> competitionGetPrintNo(TprTID tid) async {
    CompetitionIniRet ret = await CompetitionIni.competitionIniGetPrintNo(tid);
    return ret.isSuccess ? ret.value : 0;
  }
}

///  関連tprxソース: counter.h - COMPETITION_INI_LISTS
enum CompetitionIniModel {
  /// strncpy
  COMPETITION_INI_MODEL_CHAR,

  /// strncpy
  COMPETITION_INI_MODEL_UCHAR,

  /// memcpy 2013/02/12
  COMPETITION_INI_MODEL_MCHAR,

  /// memcpy2013/02/12
  COMPETITION_INI_MODEL_MUCHAR,
  COMPETITION_INI_MODEL_SHORT,
  COMPETITION_INI_MODEL_USHORT,
  COMPETITION_INI_MODEL_INT,
  COMPETITION_INI_MODEL_LONG,
  COMPETITION_INI_MODEL_LONG_LONG,
}

///  関連tprxソース: counter.h - COMPETITION_INI_LISTS
enum CompetitionIniLists {
  COMPETITION_INI_MAC_NO,
  // DBから値を取得する方針になったため、値の取得にはcompetitionIniGetRcptNoを使用すること
  // COMPETITION_INI_RCPT_NO,
  // DBから値を取得する方針になったため、値の取得にはcompetitionIniGetPrintNoを使用すること
  // COMPETITION_INI_PRINT_NO,
  COMPETITION_INI_SALE_DATE,
  COMPETITION_INI_LAST_SALE_DATE,
  COMPETITION_INI_RECEIPT_NO,
  COMPETITION_INI_DEBIT_NO,
//	COMPETITION_INI_LASTLOGIN,
  COMPETITION_INI_CREDIT_NO,
  COMPETITION_INI_LAST_EJ_BKUP,
  COMPETITION_INI_LAST_DATA_BKUP,
  COMPETITION_INI_GUARANTEE_NO,
  COMPETITION_INI_POS_NO,
  COMPETITION_INI_ONETIME_NO,
  COMPETITION_INI_CARDCASH_NO,
  COMPETITION_INI_NOCARDCASH_NO,
  COMPETITION_INI_CARDFEE_NO,
  COMPETITION_INI_OTHCRDT_NO,
  COMPETITION_INI_OWNCRDT_NO,
  COMPETITION_INI_CRDTCAN_NO,
  COMPETITION_INI_POPPY_CNT,
  COMPETITION_INI_NTTASP_CREDIT_NO,
  COMPETITION_INI_NTTASP_CORR_STAT,
  COMPETITION_INI_NTTASP_CORR_RENO,
  COMPETITION_INI_NTTASP_CORR_DATE,
  COMPETITION_INI_EAT_IN_NOW,
  COMPETITION_INI_TW_NO,
  COMPETITION_INI_EDY_POS_ID,
  COMPETITION_INI_SIP_POS_KY,
  COMPETITION_INI_ENCRYPT_PIDNEW,
  COMPETITION_INI_ENCRYPT_ERK1DI,
  COMPETITION_INI_ENCRYPT_SEND_DATE,
  COMPETITION_INI_ENCRYPT_CREDIT_NO,
  COMPETITION_INI_ENCRYPT_SUICA_IDTR,
  COMPETITION_INI_ENCRYPT_SUICA_KYTR,
  COMPETITION_INI_DELIV_RCT_NO,
  COMPETITION_INI_ORDER_NO,
  COMPETITION_INI_SLIP_NO,
  COMPETITION_INI_COM_SEQ_NO,
  COMPETITION_INI_QS_AT_CLSTIME,
  COMPETITION_INI_QS_AT_WAITTIMER,
  COMPETITION_INI_QS_AT_OPNDATETIME,
  COMPETITION_INI_FCL_DLL_FIX_TIME,
  COMPETITION_INI_END_SALETIME,
  COMPETITION_INI_QS_AT_CLS,
  COMPETITION_INI_MBRDSCTCKT_NO,
  COMPETITION_INI_HT2980_SEQ_NO,
  COMPETITION_INI_DUTY_EJ_COUNT,
  COMPETITION_INI_LAST_CLR_TOTAL,
  COMPETITION_INI_CAPS_PQVIC_AES_KEY,
  COMPETITION_INI_SPECIAL_USER_COUNT,
  COMPETITION_INI_MBR_PRIZE_NO,
  COMPETITION_INI_RCT_DNS,
  COMPETITION_INI_RCT_LF_PLUS,
  COMPETITION_INI_RCT_TB_CUT,
  COMPETITION_INI_RCT_CUT_TYPE,
  COMPETITION_INI_RCT_CUT_TYPE2,
  COMPETITION_INI_ERR_RPR_TIMER,
  COMPETITION_INI_RCT_NEAREND_CHK,
  COMPETITION_INI_SQRC_TCT_CNT,
  COMPETITION_INI_P11_PRIZE_COUNTER,
  COMPETITION_INI_P7_PRIZE_COUNTER,
  COMPETITION_INI_P11_PRIZE_GROUP_COUNTER,
  COMPETITION_INI_ZHQ_CPNRCT_SHARE,
  COMPETITION_INI_CRPNO_NO,
  COMPETITION_INI_SHPNO_NO,
  // TODO:10022 コンパイルスイッチ(SS_CR2)
// COMPETITION_INI_CR2_CHGCIN,
// COMPETITION_INI_CR2_CHGOUT,

  COMPETITION_INI_NOW_OPEN_DATETIME,
  COMPETITION_INI_CERTIFICATE_NO,
  COMPETITION_INI_CCT_SEQ_NO,
  COMPETITION_INI_DPOINT_PROC_NO,
  COMPETITION_INI_FRESTA_SLIP_NO,
  COMPETITION_INI_MAX;

  /// メモリーから取得したり、セット出来るデータか.
  ///  関連tprxソース: competition_ini.c - competition_ini()
  bool canUseMemory() {
    switch (this) {
      case COMPETITION_INI_LAST_SALE_DATE:
      case COMPETITION_INI_RECEIPT_NO:
      case COMPETITION_INI_DEBIT_NO:
      case COMPETITION_INI_LAST_EJ_BKUP:
      case COMPETITION_INI_LAST_DATA_BKUP:
      case COMPETITION_INI_GUARANTEE_NO:
      case COMPETITION_INI_CERTIFICATE_NO:
      case COMPETITION_INI_POPPY_CNT:
      case COMPETITION_INI_LAST_CLR_TOTAL:
      case COMPETITION_INI_CRPNO_NO:
      case COMPETITION_INI_SHPNO_NO:
        return false;
      default:
        return true;
    }
  }

  /// 設定ファイルから取得したり、セット出来るデータか.
  /// 関連tprxソース: competition_ini.c - competition_ini()
  bool canUseJson() {
    switch (this) {
      case COMPETITION_INI_ENCRYPT_SUICA_IDTR:
      case COMPETITION_INI_ENCRYPT_SUICA_KYTR:
      case COMPETITION_INI_CAPS_PQVIC_AES_KEY:
        return false;
      default:
        return true;
    }
  }
}

///  関連tprxソース: counter.h - COMPETITION_INI_TYPS
enum CompetitionIniType {
  COMPETITION_INI_GETMEM,
  COMPETITION_INI_GETSYS,
  COMPETITION_INI_SETMEM,
  COMPETITION_INI_SETSYS,
  // Only QCJC_C
  COMPETITION_INI_GETMEM_JC_C,
  COMPETITION_INI_GETSYS_JC_C,
  COMPETITION_INI_SETMEM_JC_C,
  COMPETITION_INI_SETSYS_JC_C,
  COMPETITION_INI_GETMEM_JC_J,
  COMPETITION_INI_GETSYS_JC_J,
  COMPETITION_INI_SETMEM_JC_J,
  COMPETITION_INI_SETSYS_JC_J;

  /// メモリーから取得orセット.
  /// 関連tprxソース: competition_ini.c - competition_ini()
  bool isUseMemory() {
    switch (this) {
      case COMPETITION_INI_GETMEM:
      case COMPETITION_INI_SETMEM:
      case COMPETITION_INI_GETMEM_JC_C:
      case COMPETITION_INI_SETMEM_JC_J:
      case COMPETITION_INI_GETMEM_JC_C:
      case COMPETITION_INI_SETMEM_JC_C:
        return true;
      default:
        return false;
    }
  }

  /// 設定ファイルから取得orセット.
  ///  関連tprxソース: competition_ini.c - competition_ini()
  bool isUseJson() {
    switch (this) {
      case COMPETITION_INI_GETSYS:
      case COMPETITION_INI_SETSYS:
        return true;
      default:
        return false;
    }
  }
  /// 値をセットするタイプ.
  ///  関連tprxソース: competition_ini.c - competition_ini()
  bool isSetValue() {
    switch (this) {
      case COMPETITION_INI_SETMEM:
      case COMPETITION_INI_SETSYS:
      case COMPETITION_INI_SETMEM_JC_C:
      case COMPETITION_INI_SETSYS_JC_C:
      case COMPETITION_INI_SETMEM_JC_J:
      case COMPETITION_INI_SETSYS_JC_J:
        return true;
      default:
        return false;
    }
  }
}

///  関連tprxソース: counter.h - COMPETITION_INI__RET_ENUMS
enum CompetitionIniRetEnums{
  COMPETITION_INI_ERROR(-1),
  COMPETITION_INI_OK(0);

  final int keyId;
  const CompetitionIniRetEnums(this.keyId);
}
