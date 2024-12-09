/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/ui/controller/c_common_controller.dart';
import 'package:get/get.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';

/// イメージラベル取得
class ImageLabelDbCall {
  ///　イメージコードとイメージデータを格納するマップ
  Map<int, String> imageLabeMap = {};

  /// DBから全てのイメージデータ取得
  Future<Map<int, String>> getAllImageLabels() async {
    ///　データベース操作用のオブジェクトを初期化
    DbManipulationPs db = DbManipulationPs();
    var results = await db.dbCon.execute('SELECT * FROM c_img_mst');
    try {
      if (results.isEmpty) {
        debugPrint('イメージマスタは空');
      } else {
        // 必要な部分だけを抽出
        for (var result in results) {
          Map<String, dynamic> data = result.toColumnMap();
          int imgCd = int.tryParse(data["img_cd"].toString()) ?? 0;
          imageLabeMap[imgCd] = data["img_data"]?? "";
        }
      }
    } catch (e) {
      debugPrint('error fetching image labels:$e');
    }
    return imageLabeMap;
  }

  /// イメージコードに基づいてイメージラベルを取得
  String getImageData(int imgCd, CommonController commonCtrl) {
    return commonCtrl.imgLblRtn[imgCd] ?? '';
  }
}

///　イメージラベルextensionクラス
extension ImageLabelEx on int {
  String get imageData {
    CommonController commonCtrl = Get.find();
    return ImageLabelDbCall().getImageData(this, commonCtrl);
  }
}
