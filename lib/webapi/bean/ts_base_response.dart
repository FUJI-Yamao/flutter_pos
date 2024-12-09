/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
 /// WebAPIレスポンス格納用クラス
 class TsBaseResponse {
  /// 返答ステータス
  final String retSts;
  /// エラーメッセージ
  final String errMsg;

  TsBaseResponse({required this.retSts, required this.errMsg});

  factory TsBaseResponse.fromJson(Map<String, dynamic> json) {
    return TsBaseResponse(
      retSts: json['RetSts'],
      errMsg: json['ErrMsg']
    );
  }
}