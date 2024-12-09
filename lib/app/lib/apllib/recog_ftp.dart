/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */



import '../cm_sys/cm_cksys.dart';

/// 承認キー関連クラス
///  関連tprxソース:\lib\apllib\recog_ftp.c
class RecogFtp {

  /// 承認キーファイルFTP送信
  /// 関連tprxソース:recog_ftp.c　rxRecogFtpPut()
  static int rxRecogFtpPut(){
    if(CmCksys.cmMmSystem() == 0){
      return 0;
    }

    // TODO:10095 webAPI 上位サーバ連携
    return 0;
  }

  /// 承認キーファイルFTP削除
  /// 関連tprxソース:recog_ftp.c　rxRecogFtpDel()
  static int rxRecogFtpDel(){
    if(CmCksys.cmMmSystem() == 0){
      return 0;
    }

    // TODO:10095 webAPI 上位サーバ連携
    return 0;
  }
}

