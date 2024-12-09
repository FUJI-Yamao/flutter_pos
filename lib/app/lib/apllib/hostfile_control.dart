/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///  ホストファイルの操作関数軍.
class HostFileControl {
  /// ホストファイルに記載されているホスト名を取得する.
  /// C言語のgethostnameの代替.
  static String getHostName() {
    // TODO:10004 ホストファイル　各OSで対応する処理.
    return "";
  }

  /// 指定のhostNameのIPアドレスの文字列を返す.
  /// 取得できなかったときは空文字列.
  static String getHostByNameStr(
    String hostName,
  ) {
    List<int> strIpAddress = getHostByName(hostName);
    return strIpAddress.join(","); // 取得できたらtrue/
  }

  /// 指定のhostNameのIPアドレスのリスト[retIpAdress]を返す.
  /// 取得できなかったときは空のリスト.取得できた時はサイズ4のリストを返す.
  static List<int> getHostByName(
    String hostName,
  ) {
    // TODO:10004 ホストファイル　 各OSで対応する処理.
    List<int> retIpAddress = [];
    return retIpAddress; // 取得できたらtrue/
  }
}
