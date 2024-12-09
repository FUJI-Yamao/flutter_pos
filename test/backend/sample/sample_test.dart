library;

/// テスト対象のdartファイルはpackage:flutter_pos 形式でimportしてください
/// testフォルダ配下のソースはこの記載ができず、
/// コンパイルが通らなくなるのでNG形式の記載になっています。
/// 
/// OK）import 'package:flutter_pos/sample.dart';
/// NG) import 'sample.dart';
import 'sample.dart';
//import 'package:flutter_pos/sample.dart';

import 'package:flutter_test/flutter_test.dart';

/// モックを使わないテストのサンプル
void main() {
  /// グループはテストのまとまりを表すため、メソッドごとにグループを作ったり、
  /// テストの種類（）ごとにグループを作ったりします。
  group('Sample_NoMock', () {
    final testCases = [
      {'input': '5', 'expected': true, 'desc': '数字1文字'},
      {'input': '-5', 'expected': false, 'desc': 'マイナス'},
      {'input': '', 'expected': false, 'desc': '空文字'},
      {'input': ' ', 'expected': false, 'desc': '半角スペース'},
      {'input': ' 5', 'expected': false, 'desc': '半角スペース＋数字'},
    ];

    for (var testCase in testCases) {
      test('${testCase['desc']}', () {
        expect(Sample.isNumeric(testCase['input'] as String),
            testCase['expected']);

        // タグはbackend, ut（ユニットテスト）は必ずつけておく。
        // その他、環境やDBの要否などでタグ付けする。
        // sampleタグはこのテストがサンプルであることを示すので
        // 実コードにはつけないようにしてください
        // 使用するタグはdart_test.yamlファイルに記載しておく必要があります
      }, tags: ['backend', 'ut', 'sample']);
    }
  });
}
