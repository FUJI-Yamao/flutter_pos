/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:io' show File, FileMode, Platform, RandomAccessFile;

import 'package:sprintf/sprintf.dart';

import '../../common/environment.dart';
import '../../inc/sys/tpr_log.dart';


///  resolv.confファイルの操作関数軍.
class ResolvFileControl {

  /// 各OSのDNS設定ファイルのパスを取得する.
  static String _getPathResolvConf(){
    if (Platform.isLinux) {
      return "/etc/resolv.conf";

    }
    if (Platform.isWindows) {
      // TODO:10105 resolv.confファイル　windowsのファイル格納場所
      return "C:/pj/tprx/resolv/resolv.conf";
    }
    // TODO:10105 resolv.confファイル　androidのファイル格納場所 & 権限？
    return "";
  }

  /// 指定のresolv.confNameのDNSの文字列を返す.
  /// 取得できなかったときは空文字列.
  static Future<String> getResolvStr(int kind) async {
    List<String> strLines = await getResolvByList();
    //読み込んだファイルからnameserverのアドレスを取得する。
    //ループ処理でkindの１，２をそれぞれ分けて取得できるようにする。
    int count = 0;
    String dnsAddress = "0.0.0.0";
    late List<String> lines = strLines;
    for (String line in lines) {
      List<String> data = line.split(' ');
      if (data[0] != "nameserver" || data.length < 2) {
        continue;
      }
      String name = data[0];
      String dns = data[1];
      count += 1;
      if (name == "nameserver" && kind == count) {
        dnsAddress = dns;
        return dnsAddress;
      }
    }
    return dnsAddress; //DNSを返す
  }

  /// 指定のresolv.confファイル内容を返す.
  /// 取得できなかったときは空の文字列を返す
  static Future<List<String>> getResolvByList() async {

    File resolvFile = File(_getPathResolvConf());
    if(!Platform.isLinux){
      // TODO:10105 resolv.confファイル　linux以外は存在しないので仮作成. 各OS対応が必要
      resolvFile.createSync(recursive: true);
    }


    //1行ずつ読み込み、listに入れる。
    List<String> resolvList = await resolvFile.readAsLines();
    if(resolvList.isEmpty) { //空の場合エラー
      String spnetLog = "file(%s) open error !! ${_getPathResolvConf()}";
      TprLog().logAdd(0, LogLevelDefine.normal,spnetLog);
      return [];
    }
    return resolvList; // 取得できたらtrue/
  }

  ///resolv.confファイルの更新処理
  static Future<int> setDNSIPaddr(int kind, String netWorkDataNew) async {
    int ret = 0;
    if (await setResolv(netWorkDataNew, kind) == true) {
      ret = 0;
    } else {
      ret = -1;
    }
    return( ret );
  }
  static Future<bool> setResolv(String DNSIP, int kind) async {
    var SPEC_NETW_RESOLV = _getPathResolvConf();
    var SPEC_NETW_RESOLV_NEW;
    var SPEC_NETW_RESOLV_SAVE;
    String kCode = "";
    // 各OSの判定
    bool isLinux = Platform.isLinux;
    bool isWindows = Platform.isWindows;
    bool isAndroid = Platform.isAndroid;
    if (isLinux) {
      SPEC_NETW_RESOLV_NEW = "/tmp/resolv.dst";
      SPEC_NETW_RESOLV_SAVE = "/tmp/resolv.save";
      kCode = "\n";
    }
    if (isWindows) {
      // TODO:10105 resolv.confファイル　 windowsのファイル格納場所 windowsだとresolvファイルではない.仮対応
      kCode = "\r\n";
      SPEC_NETW_RESOLV_NEW = "C:/pj/tprx/tmp/resolv.dst";
      SPEC_NETW_RESOLV_SAVE = "C:/pj/tprx/tmp/resolv.save";
      // TODO:10105 resolv.confファイル　 エラー回避のために作っておく
      TprxPlatform.getFile(SPEC_NETW_RESOLV).createSync(recursive: true);
    }
    if (isAndroid) {
      // TODO:10105 resolv.confファイル　androidのファイル格納場所 & 権限？
      kCode = "\n";
      SPEC_NETW_RESOLV_NEW = "";
      SPEC_NETW_RESOLV_SAVE = "";
    }
    //resolvファイル読み込み
    late List<String> lines;
    try {
      lines = TprxPlatform.getFile(SPEC_NETW_RESOLV).readAsLinesSync();
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
          "netdoa_ip_set():file($SPEC_NETW_RESOLV) open error !!,$e,$s");
    }
    //dstファイルを開く
    RandomAccessFile distFile =
    TprxPlatform.getFile(SPEC_NETW_RESOLV_NEW).openSync(mode: FileMode.write);
    int count = 0;
    int writeFlg = 0;
    String dstBuff = "";
    for (String line in lines) {
      List<String> data = line.split(' '); // sscanf(src_buff, "%s %s %s", ipadr, name, name2);
      if (data.isEmpty) {
        continue;
      }
      String name = data[0];
      if (name == "nameserver") {
        count += 1;
        if (count == kind) {
          dstBuff = sprintf("%s %s %s", ["nameserver", DNSIP, kCode]);
          writeFlg = 1;
        } else {
          dstBuff = sprintf("%s %s", [line, kCode]);
        }
      } else {
        dstBuff = sprintf("%s %s", [line, kCode]);
      }
      try {
        distFile.writeStringSync(dstBuff);
      } catch (e, s) {
        distFile.closeSync();
        TprxPlatform.getFile(SPEC_NETW_RESOLV_NEW).delete();
        TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
            "netdoa_ip_set():file($SPEC_NETW_RESOLV_NEW) write error !!,$e,$s");
        return false;
      }
    }
    if (writeFlg == 0) {
      dstBuff = sprintf("%s %s %s", ["nameserver", DNSIP, kCode]);
      try {
        distFile.writeStringSync(dstBuff);
      } catch (e, s) {
        distFile.closeSync();
        TprxPlatform.getFile(SPEC_NETW_RESOLV_NEW).delete();
        TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.error,
            "netdoa_ip_set():file($SPEC_NETW_RESOLV_NEW) write error !!,$e,$s");
        return false;
      }
    }
    distFile.closeSync();
    //ファイルを上書き
    //TODO:linuxの場合しか考慮できていない
    TprxPlatform.getFile(SPEC_NETW_RESOLV).renameSync(SPEC_NETW_RESOLV_SAVE);
    TprxPlatform.getFile(SPEC_NETW_RESOLV_NEW).renameSync(SPEC_NETW_RESOLV);
    TprxPlatform.getFile(SPEC_NETW_RESOLV_SAVE).delete();
    return true;
  }
}
