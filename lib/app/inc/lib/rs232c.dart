/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
enum Rs232cCommKind {
  RS232C_SEND(0),
  RS232C_RCV(1);

  final int id;
  const Rs232cCommKind(this.id);
}

/// RS232C デバイス
///  関連tprxソース:rs232c.h
class Rs232cDev {
  static const RS232C_PANA = 0;
  static const RS232C_GP = 1;
  static const RS232C_SMSCL1 = 2;
  static const RS232C_SMSCL2 = 3;
  static const RS232C_SMSCLSC = 4;
  static const RS232C_STPR = 5;
  static const RS232C_PW = 6;
  static const RS232C_CCR = 7;
  static const RS232C_GCAT = 8;
  static const RS232C_CRWP = 9;
  static const RS232C_DISH = 10;
  static const RS232C_ACX = 11;
  static const RS232C_AIV = 12;
  static const RS232C_YOMOCA = 13;
  static const RS232C_SMTPLUS = 14;
  static const RS232C_SUICA = 15;
  static const RS232C_SMSCLSC2 = 16;
  static const RS232C_RFID = 17;
  static const RS232C_MSR2300D = 18;
  static const RS232C_DISHT = 19;
  static const RS232C_MSR2300T = 20;
  static const RS232C_SCAND = 21;
  static const RS232C_SCANT = 22;
  static const RS232C_ARSTTS = 23;
  static const RS232C_MCP = 24;
  static const RS232C_FCL232 = 25;
  static const RS232C_FCL100 = 26;
  static const RS232C_VMC = 27;
  static const RS232C_MSR2800D = 28;
  static const RS232C_MSR2800T = 29;
  static const RS232C_TQRWCD = 30;
  static const RS232C_ABSV31 = 31;
  static const RS232C_ACX_TRANDATA = 32;
  static const RS232C_YAMATO = 33;
  static const RS232C_CCT = 34;
  static const RS232C_MASR = 35;
  static const RS232C_JMUPS = 36;
  static const RS232C_MST = 37;
  static const RS232C_SCANA = 38;
  static const RS232C_PSENSOR = 39;
  static const RS232C_SCANP = 40;
  static const RS232C_APBF = 41;
  static const RS232C_DEVICE_MAX = 42;
}