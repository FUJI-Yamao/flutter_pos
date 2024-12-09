/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:json2yaml/json2yaml.dart';
import 'package:yaml/yaml.dart';
import 'package:path/path.dart' as path;
import '../../inc/sys/tpr_log.dart';

/// NetPlanControlの操作関数
class NetPlanControl {
  ///シングバターンの設定
  static final NetPlanControl _instance = NetPlanControl._internal();

  static const  String _windowsFilePath = "assets/conf/";
  static const  String _windowsFileName = "netplan.json";

  static const  String _linuxFilePath = "/etc/netplan/";
  static const  String linuxFileName = "99_config.yaml";


  //’enp0s3’を定数定義
  static const String defaultInterfaceName = 'enp0s3';

  static String get _fileDir =>
      Platform.isWindows ? _windowsFilePath : _linuxFilePath;

  static String get _fileName =>
      Platform.isWindows ? _windowsFileName : linuxFileName;


  static get filePath => path.join(_fileDir, _fileName);

  NetPlanControl._internal();

  //インスタンスの取得
  factory NetPlanControl() {
    return _instance;
  }

  void log(String message) {
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, message);
  }

  ///イーサネットの名前を取得
  Future<String?> getEthernetName() async {
    if (!Platform.isLinux) {
      debugPrint("Linuxではないので、イーサネットインタフェース取得をスキップします");
      return null;
    }

    try {
      var result = await Process.run('ip', ['link', 'show']);
      if (result.exitCode != 0) {
        debugPrint("ip コマンドの実行中にエラーが発生: ${result.stderr}");
        return null;
      }
      debugPrint("ip コマンドの実行成功");
      var lines = result.stdout.toString().split('\n');

      for (var line in lines) {
        debugPrint("解析行：　$line");
        if (line.trim().startsWith("2: ")) {
          var interfaceName = line.trim().split(' ')[1].split(':')[0];
          debugPrint("イーサネットの名前を取得: $interfaceName");
          return interfaceName;
        }
      }
    } catch (e) {
      debugPrint('Etherentインタフェース名を取得エラー: $e');
    }
    debugPrint('Etherentインタフェース名見つからない');
    return null;
  }

  ///netplan設定ファイルの読み込み
  Future<Map<String, dynamic>?> readNetPlan() async {
    File file = File(filePath);

    ///設定ファイル存在しない場合
    if (!file.existsSync()) {
      log("NetPlan ファイルが存在しません、作成します：$_fileDir");
      bool created = await _createLinuxConfig(file);
      if (!created) {
        log("デフォルトNetplanファイル作成できません");
        return null;
      }
    }

    ///設定ファイル内容読み込み
    ///YAMLをMapに変換する
    ///純粋のMapに変換する
    try {
      var fileContents = file.readAsStringSync();
      if (Platform.isWindows) {
        return json.decode(fileContents) as Map<String, dynamic>;
      } else if (Platform.isLinux) {
        var yamlMap = loadYaml(fileContents);

        var pureMap = convertToPureMap(yamlMap);

        if (pureMap is! Map) {
          throw const FormatException('netplanファイル形式無効');
        }
        log("netplanファイル読み込み成功");
        return Map<String, dynamic>.from(pureMap);
      }
      if (Platform.isAndroid) {
        log("AndroidプラットフォームにNetplanの設定読み取りをサポートしていません");
        return null;
      }
    } catch (e) {
      debugPrint("netplanファイル読み込み失敗: $e");
    }
    return null;
  }

  ///デフォルト設定ファイルを作成
  Future<bool> _createLinuxConfig(File file) async {
    try {
      String defaultConfig;
      if (Platform.isLinux) {
        String? firstInterface = await getEthernetName();
        String interfaceName = firstInterface ?? defaultInterfaceName;
        defaultConfig = '''
        network:
          version: 2
          renderer: NetworkManager
          ethernets:
           $interfaceName:
              dhcp4: false
              dhcp6: false
              addresses:
                - 10.0.2.15/24
              nameservers:
                addresses: [10.2.0.52, 10.101.5.101, 10.101.5.102]
              routes:
               - to: default
                 via: 10.0.2.2
        ''';
      } else {
        defaultConfig = '{}';
      }
      file.writeAsStringSync(defaultConfig);
      log("デフォルトnetplanファイル作成完了");
      return true;
    } catch (e) {
      log("デフォルトnetplanファイル作成エラー: $e");
      return false;
    }
  }

  ///インタフェースの設定を取得
  Future<Map<String, dynamic>?> getInterfaceConfig(String interfaceName) async {
    Map<String, dynamic>? netPlanData = await readNetPlan();
    return netPlanData?['network']['ethernets'][interfaceName];
  }

  ///設定ファイル内容書き込む
  bool writeNetPlan(Map<String, dynamic> data) {
    try {
      String fileContents;
      if (Platform.isAndroid) {
        log("AndroidプラットフォームにNetplanの設定書き込みをサポートしていません");
        return false;
      } else if (Platform.isWindows) {
        fileContents = json.encode(data);
      } else {
        fileContents = json2yaml(data);
        debugPrint("writeError");
        File(filePath).writeAsStringSync(fileContents);
      }
      log("netplanファイル書き成功");
      return true;
    } catch (e) {
      debugPrint('netplanファイル書き換え失敗: $e');
      return false;
    }
  }

  ///Netplan設定を適用する
  ///Ubuntu内ユーザーのsudoマンドのパスワードを無効化する手順が必要
  bool applyNetPlan() {
    if (Platform.isLinux) {
      try {
        var result = Process.runSync('sudo', ['netplan', 'apply']);
        if (result.exitCode != 0) {
          log("Linux NetPlan配置エラー: ${result.stderr}");
          return false;
        }
        log("Linux netplan配置成功");
        return true;
      } catch (e) {
        log("Linux netplan配置異常: $e");
        return false;
      }
    } else if (Platform.isWindows) {
      log("windows上Netplan配置コマンド実行しません");
      return true;
    } else if (Platform.isAndroid) {
      log("AndroidプラットフォームにNetplanの配置をサポートできない");
      return false;
    } else {
      log("サポートできないOS");
      return false;
    }
  }

  ///IPアドレスを更新する
  Future<bool> updateIPAddress(
      String interfaceName, String newIPAddress) async {
    var netPlan = await readNetPlan();
    if (netPlan == null) return false;

    ///現在IPアドレス設定を取得
    ///サブネットマスク部分を抽出する
    ///IPアドレス更新しつつCIDR部分を保持する
    var currentIpAddress =
        netPlan['network']['ethernets'][interfaceName]['addresses'][0];
    var currentCIDR = currentIpAddress.split('/')[1];
    netPlan['network']['ethernets'][interfaceName]['addresses'][0] =
        "$newIPAddress/$currentCIDR";

    ///更新した設定を書き込み適用
    return writeNetPlan(netPlan) && applyNetPlan();
  }

  ///サブネットマスク更新
  Future<bool> updateSubnetmask(
      String interfaceName, String newSubnetMask) async {
    var netPlan = await readNetPlan();
    if (netPlan == null) return false;

    ///指定インタフェースのアドレスを取得
    var addresses = netPlan['network']['ethernets'][interfaceName]['addresses'];
    if (addresses != null && addresses.isNotEmpty) {
      var currentIP = addresses[0].split('/')[0];

      ///新しいサブネットマスクをCIDR形式に変換する
      ///IPアドレスと新しいCIDRを組み合わせて更新する
      var newCIDR = _subnetMaskToCidr(newSubnetMask);
      addresses[0] = "$currentIP/$newCIDR";

      ///更新したNetplanを書き込みと実行する
      if (!writeNetPlan(netPlan)) return false;
      return applyNetPlan();
    }
    return false;
  }

  ///ゲートウェイ更新するメソッド
  Future<bool> updateGateway(String interfaceName, String newGateway) async {
    var netPlan = await readNetPlan();
    if (netPlan == null) return false;

    ///指定したインタフェースのルートを取得
    ///routeリストから　'via'キーを探す
    ///ありましたら新しいゲートウェイを設定、存在しない場合は新しいルートを追加
    var routes =
        netPlan['network']['ethernets'][interfaceName]['routes'] as List? ?? [];
    var route =
        routes.firstWhere((r) => r.containsKey('via'), orElse: () => {});
    if (route.isNotEmpty) {
      route['via'] = newGateway;
    } else {
      routes.add({'via': newGateway});
    }
    if (!writeNetPlan(netPlan)) return false;
    return applyNetPlan();
  }

  ///DNS更新するメソッド
  Future<bool> updateDNS(String interfaceName, List<String> newDNSAddresses) async {
    var netPlan = await readNetPlan();
    if (netPlan == null) return false;

    netPlan['network']['ethernets'][interfaceName]['nameservers']['addresses']= newDNSAddresses;

    return writeNetPlan(netPlan) && applyNetPlan();

  }


  ///サブネットマスクをCIDR形式に変換するメソッド
  String _subnetMaskToCidr(String subnetMask) {
    var bytes = subnetMask.split('.').map(int.parse).toList();
    var length =
        bytes.fold(0, (previous, element) => previous + _byteToLength(element));
    return length.toString();
  }

  int _byteToLength(int byte) {
    int length = 0;
    while (byte > 0) {
      length += byte & 1;
      byte >>= 1;
    }
    return length;
  }

  ///CIDRをサブネットマスクに変換するメソッド
  String cidrToSubnetMask(int cidr) {
    var maskBits = List.filled(32, '0');
    for (int i = 0; i < cidr; i++) {
      maskBits[i] = '1';
    }
    var bytes = maskBits.join().split('').toList();
    List<String> octets = [];
    for (int i = 0; i < bytes.length; i += 8) {
      String octet = bytes.sublist(i, i + 8).join();
      octets.add(int.parse(octet, radix: 2).toString());
    }
    return octets.join('.');
  }

  ///Yaml値をMapに変換する関数
  dynamic convertToPureMap(dynamic yamlValue) {
    if (yamlValue is YamlMap) {
      return yamlValue.keys.fold<Map<String, dynamic>>({}, (map, key) {
        String stringKey = key.toString();
        map[stringKey] = convertToPureMap(yamlValue[key]);
        return map;
      });
    } else if (yamlValue is YamlList) {
      return yamlValue.map(convertToPureMap).toList();
    } else {
      return yamlValue;
    }
  }
}
