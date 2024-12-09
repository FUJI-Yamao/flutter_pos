/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース: if_smscl.h
class IfSmScl {
  static const int SMSCL_NEWSCALE = 1;

  static const String SMSCL_CMD_XON = '\x11';
  static const String SMSCL_CMD_XOFF = '\x13';
  static const String SMSCL_CMD_WRITE = 'W';
  static const String SMSCL_CMD_READ = 'R';

  static const String SMSCL_CMD_SPEC = 'C';
  static const String SMSCL_CMD_VERSION = 'F';
  static const String SMSCL_CMD_ATTESTNUMBER = 'S';
  static const String SMSCL_CMD_SPANADJDATA = 'D';
  static const String SMSCL_CMD_ZEROADJ = 'X';
  static const String SMSCL_CMD_SPANADJ = 'P';
  static const String SMSCL_CMD_SPANADJCOMP = 'p';
  static const String SMSCL_CMD_TAREAUTO = 'T';
  static const String SMSCL_CMD_TAREDIGITAL = 'U';
  static const String SMSCL_CMD_TAREPRESET = 'u';
  static const String SMSCL_CMD_ZERORESET = 'Z';
  static const String SMSCL_CMD_ZERORESETINIT = 'z';
  static const String SMSCL_CMD_DEFAULT = 'f';
  static const String SMSCL_CMD_INTERNALCOUNT = 'I';
  static const String SMSCL_CMD_MEASUREMENT = 'N';
  static const String SMSCL_CMD_BOOT = 'G';

  static const String SMSCL_CMD_WEIGHTREAD = 'r';
  static const String SMSCL_CMD_WEIGHTREAD_NOT = 'n';

  static const String SC_CMD_LED = 'f';
  static const String SC_CMD_BLED = 'g';
  static const String SC_CMD_DETECT_ENABLE = 'e';
  static const String SC_CMD_DETECT_DISABLE = 'd';
  static const String SC_CMD_DETECT_STATE = 'a';
  static const String SC_CMD_LED2 = 'i';

  static const String SMSCL_HEAD_WEIGHT = '\x02\x30'; /* STX+'0' */
  static const String SMSCL_HEAD_TARE = '\x0d\x34'; /* CR+'4'  */
  static const String SMSCL_HEAD_ADCOUNT1 = '\x0d\x61'; /* CR+'a'  */
  static const String SMSCL_HEAD_ADCOUNT2 = '\x02\x61'; /* STX+'a' */
  static const String SMSCL_HEAD_INTERNALCOUNT = '\x0d\x69'; /* CR+'i'  */
  static const String SMSCL_HEAD_STATUS = '\x0d\x0a'; /* CR+LF   */

  static const int SMSCL_SPECSIZE = 40;
}

/// 関連tprxソース: if_smscl.h - enum
enum SmScl {
  SMSCL_NORMAL(0),
  SMSCL_SENDERR(1),

  SMSCL_TIMEOVER(2),
  SMSCL_OFFLINE(3),
  SMSCL_RETRYERR(4),
  SMSCL_BUSY(5),
  SMSCL_SYSERR(6),

  SMSCL_CHKSUMERR(7),
  SMSCL_CMDERR(8),
  SMSCL_TAREERR(9),
  SMSCL_ZERORESETERR(10),
  SMSCL_SPANSWERR(11),
  SMSCL_OTHERERR(12),

  SMSCL_UNBALANCE(13);

  final int value;
  const SmScl(this.value);
}

/// 関連tprxソース: if_smscl.h - detect_command
enum DetectCommand {
  CMD_ENABLE("\x00"),
  CMD_DISABLE("\x01"),
  CMD_REQUEST("\x42");

  final String value;
  const DetectCommand(this.value);
}
