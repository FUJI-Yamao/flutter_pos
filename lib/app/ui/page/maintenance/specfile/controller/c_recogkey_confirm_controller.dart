/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import '../../../../../sys/recogkey/recogkey_sub.dart';

import 'package:get/get.dart';


/// 承認キー 解放される機能確認画面コントローラー.
class RecogkeyConfirmController extends GetxController {
  RecogkeyConfirmController({required int bi,required String recogkeySaveDes}){
    recogkeySub =
        RecogkeySub(bi, recogkeySaveDes);
  }
  /// 承認キー解放確認画面と対応するバックエンドクラス.
  late final  RecogkeySub recogkeySub;
  ///  解放される機能名リスト
  final dispRecogkeyList = <String>[].obs;


  @override
  Future<void> onReady() async {
    super.onReady();
    // 解放されるキーを取得する.
    final (bool success,List<String> listData)  = await recogkeySub.getRecogKeyFuncList();
    if(!success){
      return ;
    }
    dispRecogkeyList.value = listData;
    dispRecogkeyList.refresh();
  }

}
