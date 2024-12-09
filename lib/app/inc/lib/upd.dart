/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース: upd.h
class Upd {
  static const String UPD_ERLOG_MV_FNAME = "%s/log/Upd_erlog_history%06d%04d%02d%02d%02d%02d%02d";
  static const String UPD_ERLOG_MV_TARNAME = "%s/log/Updall%s%06d%04d%02d%02d%02d%02d%02d.tar.gz";
  static const String UPD_ERLOG_MV_LISTNAME = "%s/log/Updall%s%06d%04d%02d%02d%02d%02d%02d.list";

  static const String UPDERRLOG_CREATE_DATA = "%04d-%02d-%02d %02d:%02d:%02d\t%d\t%d\t%s\n";

  static const int VOID_RETRY_CNT = 25;
  static const int VOID_RETRY_WAIT = 200000;
  static const int VOID_RESULT_WAIT = 300000;
  static const int VOID_RESULT_CNT = 30;

  static const int VOID_CONF_TIMEOUT = 15;

  static const String ZIP_PASSWD = "tera0893";

  static const int HASH_LENGTH = 32;
}