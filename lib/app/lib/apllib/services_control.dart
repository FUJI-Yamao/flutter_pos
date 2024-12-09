/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/common/cls_conf/services_windowsJsonFile.dart';

/// ServicesファイルControlの操作関数
class ServicesControl {
  final String servicesFilePath;
  final String windowsJsonFilePath;

  ServicesControl(
      {this.servicesFilePath = '/etc/services',
      this.windowsJsonFilePath = 'conf/services_windows.json'});

  ///実行中のプラットフォームを確認
  bool get isWindows => Platform.isWindows;

  bool get isLinux => Platform.isLinux;

  bool get isAndroid => Platform.isAndroid;

  ///メインの解析関数　プラットフォームに応じて解析関数を呼び出す
  Future<Map<String, Map<String, dynamic>>> parseServicesFile() async {
    if (isLinux) {
      return parseLinuxServicesFile();
    } else if (isWindows) {
      return parseWindowsJsonFile();
    } else if (isAndroid) {
      debugPrint('Androidプラットフォームでは、現時点何も実行しません');
      return {};
    } else {
      throw Exception('サポートされてないプラットフォームです');
    }
  }

  ///Linux側ファイルパス存在を確認する
  Future<File> _checkServicesFileExists() async {
    var filePath = isWindows ? windowsJsonFilePath : servicesFilePath;
    if (isWindows) {
      await Services_windowsJsonFile().load();
    }
    var file = File(filePath);
    if (!file.existsSync()) {
      throw Exception('サービスファイル見つかってません: $filePath');
    }
    return file;
  }

  ///　Linuxでファイル読み込み、データ解析
  Future<Map<String, Map<String, dynamic>>> parseLinuxServicesFile() async {
    var file = await _checkServicesFileExists();

    var servicesData = <String, Map<String, dynamic>>{};
    List<String> lines = await file.readAsLines();
    for (var line in lines) {
      if (line.startsWith('#') || line.trim().isEmpty) continue;

      var parts = line.split(RegExp(r'\s+'));
      if (parts.length >= 2) {
        var servicesName = parts[0];
        var portInfoParts = parts[1].split('/');
        var portNumber = portInfoParts.first;
        var protocolName = portInfoParts.length > 1 ? portInfoParts[1] : '';
        var aliases = parts.length > 2 ? parts.sublist(2).join(' ') : '';

        servicesData[servicesName] = {
          'PortNumber': portNumber,
          'ProtocalName': protocolName,
          'Aliases': aliases
        };
      }
    }
    debugPrint('サービスファイル読み込み完了しました');
    return servicesData;
  }

  /// Windowsプラットフォームで　Json　ファイルを解析する
  Future<Map<String, Map<String, dynamic>>> parseWindowsJsonFile() async {
    var file = File(windowsJsonFilePath);
    if (!file.existsSync()) {
      throw Exception('サービスファイル見つかってません: $windowsJsonFilePath');
    }

    var content = await file.readAsString();
    var jsonData = jsonDecode(content) as Map<String, dynamic>;
    var servicesData = <String, Map<String, dynamic>>{};

    jsonData.forEach((serviceName, servicesData) {
      servicesData[serviceName] = {
        'PortNumber': servicesData['PortNumber'],
        'ProtocalName': servicesData['ProtocalName'],
        'Aliases': servicesData['Aliases']
      };
    });
    debugPrint('Windows　Jsonファイル正常に読み込みました: $windowsJsonFilePath');
    return servicesData;
  }

  ///特定のservicesのポート番号を取得
  String getPortNumber(Map<String, Map<String, dynamic>> servicesData,
      String serviceName, String defaultPort) {
    if (servicesData.containsKey(serviceName)) {
      var port = servicesData[serviceName]?['PortNumber'];
      int portNumber = int.tryParse(port) ?? 0;
      if (portNumber >= 0 && portNumber < 65535) {
        return port;
      }
    }
    debugPrint('サービスネーム見つかりません $serviceName,'
        'デフォルトポート番号$defaultPortを使います');
    return defaultPort;
  }

  ///　/etc/services　ファイルに新しいデータを追加
  Future<void> appendNewServices() async {
    var file = await _checkServicesFileExists();
    var servicesData = await parseServicesFile();
    List<String> newServices = [];
    Map<String, String> servicesToAdd = {
      'comport':
          'comport         6200/tcp                       # web credit comc socket',
      'comport2':
          'comport2        0/tcp                          # web2100 credit compc socket',
      'pbchg1port':
          'pbchg1port      8201/tcp                       # web2100 PBCHG1 socket',
      'pbchg2port':
          'pbchg2port      8201/tcp                       # web2100 PBCHG2 socket'
    };

    servicesToAdd.forEach((servicesName, serviceEntry) {
      if (!servicesData.containsKey(servicesName)) {
        newServices.add(serviceEntry);
      }
    });

    if (newServices.isNotEmpty) {
      var fileSink = file.openWrite(mode: FileMode.append);
      for (var serviceEntry in newServices) {
        fileSink.writeln(serviceEntry);
        debugPrint('servicesファイル追加： $serviceEntry');
      }
      await fileSink.flush();
      await fileSink.close();
      debugPrint('新しいサービスファイル追加完了');
    } else {
      debugPrint('追加するサービスファイルありません');
    }
  }

  ///　特定のservicesポート番号更新する
  Future<bool> updatePortNumber(
      String serviceName, String newPortNumber) async {
    var servicesData = await parseServicesFile();
    if (!servicesData.containsKey(serviceName)) {
      debugPrint('services  $serviceName 存在しない');
      return false;
    }

    var existingServiceData = servicesData[serviceName];
    existingServiceData?['PortNumber'] = newPortNumber;

    return await writeServiesFile(servicesData);
  }

  ///更新した成功データを　/etc/services/ ファイルに書き込み
  Future<bool> writeServiesFile(
      Map<String, Map<String, dynamic>> servicesData) async {
    var buffer = StringBuffer();
    servicesData.forEach((serviceName, servicesData) {
      var portNumber = servicesData['PortNumber'];
      var protocolName = servicesData['ProtocolName'] ?? 'tcp';
      var aliases = servicesData['Aliases'];
      buffer.writeln('$serviceName $portNumber/$protocolName $aliases');
    });

    try {
      await File(servicesFilePath).writeAsString(buffer.toString());
      debugPrint('サービスファイル更新成功');
      return true;
    } catch (e) {
      debugPrint('サービスファイル更新失敗 $e');
      return false;
    }
  }
}
