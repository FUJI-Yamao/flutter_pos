/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
///
/// 関連tprxソース: sysparam.h - RX_SYSPARAM
class RxSysParam {
  String myIp = "";
  String svrIp = "";
  String subIp = "";
  String mblIp = "";
  String custsvrIp = ""; // 顧客(予約)DBサーバー IP
  String wsHqIp = "";
  String localdbname = "";
  String localdbuser = "";
  String localdbpass = "";
  String hostdbname = "";
  String hostdbuser = "";
  String hostdbpass = "";
  String csvrMstIp = "";
  String csvrTrnIp = "";
  String csvrDbname = "";
  String csrvDbuser = "";
  String csrvDbpass = "";
  String custsvrDbname = ""; // 顧客(予約)DBサーバー ログイン情報
  String custsvrDbuser = "";
  String custsvrDbpass = "";
  String wsHqDbname = "";
  String wsHqDbuser = "";
  String wsHqDbpass = "";
  String hostdbuserTscs = "";
  int paConectTyp = 0;
  // TODO:10006 DBサーバーへの接続.sqliteなので不要?webAPIへの置き換え?
  String dbSvrIp = "";
  int dbConnectTimeout = 0;
}
