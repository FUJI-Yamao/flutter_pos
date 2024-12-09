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
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'dart:io';

/// ここで、Fileクラスのモックを作る設定をしています。
/// 複数のクラスをモックにする場合は、[]内にクラスを追加していきます。
/// この設定を行い、`dart run build_runner build` を実行することで、
/// モッククラスの定義が sample_mock_test.mocks.dart に生成されます。
@GenerateNiceMocks([MockSpec<File>()])
import 'sample_mock_test.mocks.dart';

void main() {
  group('Sample_WithMock', () {
    test('モックを使ってgetNameDIメソッドの結果を検証する', () async {
      // Fileのモックを作成
      final mockFile = MockFile();

      // モックの振る舞いを設定する
      // ここではreadAsString()メソッドが呼ばれたときに'TestUser'を返す
      when(mockFile.readAsString()).thenAnswer((_) async => 'TestUser');

      // テスト対象クラスを生成（MockFileはFileを継承している）
      final sample = Sample(mockFile);

      // テスト対象のメソッドを実行する
      final result = await sample.getNameDI();
      // 期待値との比較（ここは通常のテストと同じ）
      expect(result, 'TestUserさん');


      // モックされたメソッドが呼び出されたらログ出力する（デバッグ用）
      logInvocations([mockFile]);
      // readAsStringが1度だけ呼び出されたかを検証する
      verify(mockFile.readAsString()).called(1);
      // verifyしていないメソッド（readAsString以外）が呼ばれていないかを検証する
      verifyNoMoreInteractions(mockFile);
    }, tags: ['backend', 'ut', 'sample']);
  });
}
