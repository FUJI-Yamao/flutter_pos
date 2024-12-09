/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import '../../../../../clxos/calc_api_data.dart';
import '../../../../../clxos/calc_api_result_data.dart';
import '../../../../common/environment.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/apl/rxregmem_define.dart';
import '../../../../inc/sys/tpr_log.dart';
import '../model/m_transaction_data.dart';

/// トランザクションデータの管理
class TransactionManagement {

  /// トランザクションデータのリスト
  TransactionDataList _transactionDataList = TransactionDataList(list: [TransactionData.init()]);

  /// 件数取得
  int get count => _transactionDataList.list.length;

  /// トランザクションデータを格納するフォルダ
  static const String _saveDir = 'tmp';

  /// トランザクションデータの保存ファイル名
  static const String _tmpFileName = 'transaction_data';
  /// トランザクションデータの保存ファイル名（訓練時）
  static const String _tmpFileNameForTraining = 'transaction_data_for_training';

  /// コンストラクタ
  TransactionManagement();

  /// 保留されているトランザクションデータの読み込み
  void load() {
    // トランザクションデータの読み込み
    _load(File(_getFileName()));
  }

  /// トランザクションデータの読み込み
  void _load(File file) {
    // ファイルが存在するか？
    if (file.existsSync()) {
      try {
        String json = file.readAsStringSync();
        _transactionDataList = TransactionDataList.fromJson(jsonDecode(json));
      } catch (e, s) {
        TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "TransactionData read error\n$e\n$s");
        // 読み込みに失敗した場合は、無視して続行させる
        _transactionDataList = TransactionDataList(list: [TransactionData.init()]);
      }
    } else {
      _transactionDataList = TransactionDataList(list: [TransactionData.init()]);
    }
  }

  /// 保存
  void save({
    required int index,
    required CalcRequestParaItem? lastRequestData,
    required CalcResultItem? lastResultData,
    required String refundDate,
    required bool? isAlreadyWarning
  }) {
    // 対象の要素を取得
    TransactionData transactionData = getAt(index);

    // リクエストデータとレスポンスデータが存在する時に、トランザクションデータに保存する
    if (lastRequestData != null && lastResultData != null) {
      // 返品操作時は保存しない
      if (lastRequestData.refundFlag == 0) {
        transactionData.set(
          lastRequestData: lastRequestData,
          lastResultData: lastResultData,
          refundDate: refundDate,
          isAlreadyWarning: isAlreadyWarning,
        );

        // ファイルに保存
        _saveFile();
      }
    } else {
      // 想定外
      throw AssertionError();
    }
  }

  /// 要素の取得
  TransactionData getAt(int index) {
    return _transactionDataList.list[index];
  }

  /// 要素の追加
  void add() {
    _transactionDataList.list.add(TransactionData.init());

    // 要素の追加時では、ファイルに保存しない
  }

  /// 要素の削除
  void removeAt(int index) {
    _transactionDataList.list.removeAt(index);

    // ファイルに保存
    _saveFile();
  }

  /// 初期化
  void clear() {
    assert(count == 1);
    _transactionDataList.list[0] = TransactionData.init();

    // ファイルに保存
    _saveFile();
  }

  /// ファイルに保存
  void _saveFile() {
    try {
      Map<String, dynamic> map = _transactionDataList.toJson();
      String json = jsonEncode(map);

      File file = File(_getFileName());
      file.writeAsStringSync(json);
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "TransactionData write error\n$e\n$s");
    }
  }

  /// トランザクションデータの保存ファイル名をFileクラスにして返す
  String _getFileName() {
    String fileName;
    if (RegsMem().tHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_TRAINING) {
      // 訓練モード
      fileName = _tmpFileNameForTraining;
    } else {
      // 登録モード
      fileName = _tmpFileName;
    }

    // ファイル名にプロセス名（画面名）を付加する
    fileName = '$fileName.${EnvironmentData().screenKind.commandParameterName}';

    return join(_getDirectoryName(), fileName);
  }

  /// トランザクションデータを格納するディレクトリ名を返す
  static String _getDirectoryName() {
    return join(EnvironmentData().sysHomeDir, _saveDir);
  }

  /// トランザクションデータが存在するか確認する（閉設画面遷移のチェック用）
  static bool isExist() {
    bool bRet = false;
    TransactionManagement transactionManagement = TransactionManagement();

    // \pj\tprx\tmp内の"transaction_data."で始まるファイルの一覧取得
    List<FileSystemEntity> entities = _getFiles('$_tmpFileName.');
    for (var entity in entities) {
      if (entity is File) {
        // トランザクションデータの読み込み
        transactionManagement._load(entity);
        // トランザクションデータが存在するか
        TransactionData transactionData = transactionManagement.getAt(0);
        if (transactionData.isExsitData()) {
          bRet = true;
          break;
        }
      }
    }
    return bRet;
  }

  /// トランザクションデータのファイル全てを取得する（閉設処理時のファイル削除用）
  static List<FileSystemEntity> getAllFiles() {
    // \pj\tprx\tmp内の"transaction_data"で始まるファイルの一覧取得
    return _getFiles(_tmpFileName);
  }

  /// トランザクションデータのファイル全てを取得する（閉設処理時のファイル削除用）
  static List<FileSystemEntity> _getFiles(String tagetName) {
    // \pj\tprx\tmp内の一覧を取得
    Directory directory = Directory(_getDirectoryName());
    List<FileSystemEntity> entities = directory.listSync();

    // ファイル、かつ、"transaction_data"で始まる文字列の取得
    return entities.where((e) => e is File && e.uri.pathSegments.last.startsWith(tagetName)).toList();
  }
}
