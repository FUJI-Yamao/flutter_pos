/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'dart:io';

import '../app/common/environment.dart';


/// POS専用にFileを拡張する.
extension PosFile on File {
  /// パスをプラットフォームに適したパスに変換してFileオブジェクトを作成する
  /// 通常のcopy関数だとAndroidでパスにアクセスできずにエラーになる可能性がある
  Future<File>  copy4Pos(String path) {
    // まずは半角文字列に変換.
    String pltPath =  TprxPlatform.getPlatformPath(path);

    return copy(pltPath);
  }
}
