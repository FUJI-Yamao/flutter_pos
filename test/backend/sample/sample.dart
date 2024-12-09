import 'dart:io';

/// テスト対象のクラス例（このクラスを作ったのでテストを作る）
/// testフォルダに格納されていますが、本来はlibフォルダに格納されているものです
class Sample {
  /// staticメソッドの例
  static bool isNumeric(String dst) {
    // 正規表現を使ってすべての文字が0～9の数字であるかどうかを判定する
    return RegExp(r'^[0-9]+$').hasMatch(dst);
  }

  /// テスト対象のクラスのコンストラクタで受け取るオブジェクト
  final File _file;
  /// モックを使う場合はコンストラクタで受け取る必要がある
  Sample(this._file);

  /// 外部のクラスを使っているメソッドの例
  /// コンストラクタで受け取ったFileオブジェクトを使って処理をしている
  Future<String> getNameDI() async {
    final name = await _file.readAsString();
    return '$nameさん';
  }

  // モックでテストができない例（ここではFileクラスとしています）
  // メソッド内部でモック化する必要があるオブジェクトを生成していると、
  // テストすることができないため、コンスタラクタで受け取れるようにする
  // 必要があります。
  Future<String> getName() async {
    final File file = File('test.txt');
    final name = await file.readAsString();
    return '$nameさん';
  }
}
