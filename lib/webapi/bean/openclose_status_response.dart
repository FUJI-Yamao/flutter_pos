/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
 import 'ts_base_response.dart';

/// 開閉設状態確認用レスポンス格納用クラス
 class OpenCloseStatusResponse extends TsBaseResponse {
  /// 開店フラグ
  final bool openFlg;
  /// 閉店フラグ
  final bool closeFlg;
  
  OpenCloseStatusResponse({required super.retSts, required super.errMsg, required this.openFlg, required this.closeFlg});

  factory OpenCloseStatusResponse.fromJson(Map<String, dynamic> json) {
    return OpenCloseStatusResponse(
      retSts: json['RetSts'],
      errMsg: json['ErrMsg'],
      openFlg: json['OpenFlg'] == "1",
      closeFlg: json['CloseFlg'] == "1"
    );
  }
}