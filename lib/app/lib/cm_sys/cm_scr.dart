/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_pos/type_extension/pos_file.dart';
import 'package:path/path.dart';

import '../../common/environment.dart';
import '../../inc/apl/rx_mbr_ata_chk.dart';

///  関連tprxソース: cm_scr.c
class CmScr{
  static const CRY_MAX = 6;
  static const BIT_MAX = 4;
  static const IFHWADDRLEN = 6;

  /// scrambling code check
  /// [key]:キーコード
  /// [bas]:scrambling code
  /// [bi]:effective bit
  ///  関連tprxソース: cm_scr.c - cm_scr_off2()
  static Future<CmScrRet> cmScrOff(String key, List<int> bas, int bi) async {
    // パラメータチェック.
    if(key.isEmpty || bas.isEmpty){
      return CmScrRet.PARAMETER_ERROR;
    }
    if(key.length < RecogKeyDefine.RECOG_ENTRY_LENGTH1 / 2){
      return CmScrRet.KEY_SHORT_ERROR;
    }
    List<int> sav = List.filled(CRY_MAX, 0);
    // 検証コード.
    List<int> org = bas.sublist(0, CRY_MAX);
    // bit shift loop rightward
    int loopMax = bi % 48;
    for(int i=0; i<loopMax; i++){
      sav[0] = ( org[0] << 7 ) & 0x80;
      org[0] = ( org[0] >> 1 ) & 0x7F;
      sav[1] = ( org[1] << 7 ) & 0x80;
      org[1] = ( org[1] >> 1 ) & 0x7F;
      sav[2] = ( org[2] << 7 ) & 0x80;
      org[2] = ( org[2] >> 1 ) & 0x7F;
      sav[3] = ( org[3] << 7 ) & 0x80;
      org[3] = ( org[3] >> 1 ) & 0x7F;
      sav[4] = ( org[4] << 7 ) & 0x80;
      org[4] = ( org[4] >> 1 ) & 0x7F;
      sav[5] = ( org[5] << 7 ) & 0x80;
      org[5] = ( org[5] >> 1 ) & 0x7F;
      // all bit shift.
      org[0] = org[0] | sav[5];
      org[1] = org[1] | sav[0];
      org[2] = org[2] | sav[1];
      org[3] = org[3] | sav[2];
      org[4] = org[4] | sav[3];
      org[5] = org[5] | sav[4];
    }
    List<int> bitData = List.filled(BIT_MAX, 0);
    // get bit data.
    for(int i=0; i<BIT_MAX; i++){
      bitData[3-i] = bi & 0x000000FF;
      bi >>= 8;
    }
    // XOR of bit data
    for(int i=0; i<BIT_MAX; i++){
      org[i] = org[i] ^ bitData[i];
    }
   // XOR of Key code
    List<int> keyCode = key.codeUnits;
    for(int i=0; i<CRY_MAX; i++){
      org[i] = org[i] ^ keyCode[i];
    }
    // Get Mac-Address
    String fileName = "";
    bool isSuccess = true;
    List<List<int>> mac = List<List<int>>.generate(0,
            (index) => List.generate(IFHWADDRLEN, (index) => 0));
    (isSuccess, mac) = await getMacAddr();
    if(!isSuccess){
      return CmScrRet.MAC_ADDRES_GET_ERROR;
    }
    // Key Check
    for (int i=0; i<mac.length; i++) {
      if(const ListEquality().equals(org, mac[i])){
        // コードが一致している.
        return CmScrRet.OK;
      }
    }

    // macアドレスと検証コードが一致しない.
    return CmScrRet.CODE_NOT_RIGHT;
  }

  /// マックアドレスを取得する
  /// 成功したかどうかと、取得したmacアドレスを返す.
  static Future<(bool,List<List<int>>)> getMacAddr() async {
    if(Platform.isLinux){
      return _getMacAddrLinux();
    } else if (Platform.isWindows) {
      return await _getMacAddrWindows();
    } else {
      List<List<int>> macAddr = List<List<int>>.generate(0,
              (index) => List.generate(IFHWADDRLEN, (index) => 0));
      return (false, macAddr);
    }
  }

  /// マックアドレスを取得する（Windows - コマンド実行して取得）
  /// 成功したかどうかと、取得したmacアドレスを返す.
  ///  関連tprxソース: cm_scr.c - get_macaddr()
  static Future<(bool,List<List<int>>)> _getMacAddrWindows() async {
    List<List<int>> macAddr = List<List<int>>.generate(0,
          (index) => List.generate(IFHWADDRLEN, (index) => 0));

    try {
      final process = await Process.run('getmac', []);
      // output data sort
      String str = process.stdout.replaceAll(" ", "");
      str = str.replaceAll("=", "");
      List<String> line = str.split("\r\n");
      line = line.sublist(3);

      // get mac address
      String addr = "";
      List<String> macAddrStr = List.filled(IFHWADDRLEN, "00");
      macAddr = List<List<int>>.generate(line.length-1,
              (index) => List.generate(IFHWADDRLEN, (index) => 0));
      for (int i=0; i<line.length-1; i++) {
        addr = line[i].substring(0, 17);
        macAddrStr = addr.split("-");
        for(int j=0; j<IFHWADDRLEN; j++){
          // 数値へ変換
          macAddr[i][j] = int.parse(macAddrStr[j], radix: 16);
        }
      }
    }catch(e){
      return (false, macAddr);
    }

    return (true, macAddr);
  }

  /// マックアドレスを取得する（Linux - ファイルから取得）
  /// 成功したかどうかと、取得したmacアドレスを返す.
  /// 関連tprxソース: cm_scr.c - get_macaddr_file_read()
  static (bool,List<List<int>>) _getMacAddrLinux() {
    String tgt = "/sys/class/net";
    List<FileSystemEntity> files = Directory(tgt).listSync();
    String intrface = "";
    String line = "";
    int i = 0;
    List<String> macAddrStr = List.filled(IFHWADDRLEN, "00");
    List<List<int>> macAddr = List<List<int>>.generate(files.length,
          (index) => List.generate(IFHWADDRLEN, (index) => 0));

    try {
      for(var file in files) {
        intrface = basename(file.path);
        if (intrface != "lo") {
          line = TprxPlatform.getFile("$tgt/$intrface/address").readAsStringSync();
          macAddrStr = line.split(":");
          for(int j=0; j<IFHWADDRLEN; j++){
            macAddr[i][j] = int.parse(macAddrStr[j], radix: 16);
          }
          i++;
        }
      }
    }catch(e){
      return (false, macAddr);
    }

    return (true, macAddr);
  }
}

enum CmScrRet{
  OK, // エラーなし.
  CODE_NOT_RIGHT, // コードが一致しない.
  PARAMETER_ERROR, // パラメータが不正.
  KEY_SHORT_ERROR, // キーが短い.
  MAC_ADDRES_GET_ERROR, // macアドレスが取得できなかった.
}
