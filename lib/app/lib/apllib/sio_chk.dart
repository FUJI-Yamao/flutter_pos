/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///  関連tprxソース:  src\inc\lib\sio_chk.h - SIO
enum Sio {
  SIO_NOTUSE_ZERO,
  SIO_NOTUSE,    /* button01 */
  SIO_AIV,           /* button02 */	/* 音声合成装置'HD AIVoice'			*/
  SIO_DISH,          /* button03 */
  SIO_STPR,          /* button04 */
  SIO_SCALE,         /* button05 */
  SIO_S2PR,          /* button06 */
  SIO_GP,            /* button07 */
  SIO_PWRCTRL,       /* button08 */
  SIO_YOMOCA,        /* button09 */
  SIO_ACR,           /* button10 */
  SIO_ACB10,         /* button11 */
  SIO_ACB20,         /* button12 */
  SIO_ACB50,         /* button13 */
  SIO_GCAT_CNCT,     /* button14 */
  SIO_PSP70,         /* button15 */
  SIO_REWRITE,       /* button16 */
  SIO_VISMAC,        /* button17 */
  SIO_OKI,           /* button18 */
  SIO_PSP60,         /* button19 */
  SIO_PANA,          /* button20 */
  SIO_PW410,         /* button21 */
  SIO_GCAT,          /* button22 */
  SIO_SIP60,         /* button23 */
  SIO_CCR,           /* button24 */
  SIO_SGSCALE1,      /* button25 */
  SIO_SGSCALE2,      /* button26 */
  SIO_SGSCALE,       /* button27 */
  SIO_SCAN_PLUS_1,   /* button28 */
  SIO_RFID,          /* button29 */
  SIO_AR_STTS_01,    /* button30 */	/* 音声合成装置'AR-STTS-01'			*/
  SIO_MCP200,        /* button31 */
  SIO_SCAN_PLUS_2,   /* button32 */
  SIO_BUTTON33,      /* button33 */
  SIO_SMTPLUS,       /* button34 */
  SIO_FCL,           /* button35 */
  SIO_JREM_MULTI,    /* button36 */
  SIO_SUICA,         /* button37 */
  SIO_DISHT,         /* button38 */
  SIO_HT2980,        /* button39 */
  SIO_ABSV31,        /* button40 */
  SIO_BUTTON41,      /* button41 */
  SIO_YAMATO,        /* button42 */
  SIO_CCT,           /* button43 */
  SIO_MASR,          /* button44 */
  SIO_JMUPS,         /* button45 */
  SIO_FAL2,          /* button46 */
  SIO_MST,           /* button47 */
  SIO_VEGA3000,      /* button48 */
  SIO_CASTLES,       /* button49 */
  SIO_PCT,           /* button50 */
  SIO_BUTTON51,      /* button51 */
  SIO_BUTTON52,      /* button52 */
  SIO_BUTTON53,      /* button53 */
  SIO_BUTTON54,      /* button54 */
  SIO_MAX
}

class SioChk {
  ///  関連tprxソース:  src\lib\apllib\sio_chk.c - sio_check()
  static int sioCheck(Sio sio) {
    // TODO:00011 周 qp_idの日計関連処理で呼び出される
    return 0;
  }

  // TODO:中身未実装
  ///  関連tprxソース: tprx\src\lib\apllib\sio_chk.c - short sio_cnct_check(SIO sio)
  static int sioCnctCheck(Sio sio) {
    return 0;
  }
}