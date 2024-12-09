/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import '../../inc/sys/tpr_aid.dart';
import '../apllib/recog.dart';

class CmCkFjss{
  /// 特定衣料FTP送信仕様のフラグを返す
  /// 戻値：0:非特定衣料FTP送信仕様 / 1:特定衣料FTP送信仕様
  /// 関連tprxソース:cm_ckfjss.c - cm_fjss_system()
  static Future<int> cmFjssSystem() async {
    int recog1 = 0;
    int recog2 = 0;

    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CLOTHES_BARCODE,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO)  {
      recog1 = 1;
    }
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_FJSS,
        RecogTypes.RECOG_GETMEM)).result != RecogValue.RECOG_NO) {
      recog2 = 1;
    }
    if (recog1 != 0 && recog2 != 0) {
      return 1;
    }
    return 0;
  }
}