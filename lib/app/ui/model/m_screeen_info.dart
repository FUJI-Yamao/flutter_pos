/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 画面情報
class ScreenInfo{
  ScreenInfo({
    required this.width,
    required this.height,
    required this.position,
    required this.address,
    required this.port,
  });

  /// 画面の幅
  double width;
  /// 画面の高さ
  double height;
  /// 画面の表示位置（オフセット）
  double position;
  /// IPアドレス
  String address;
  /// ポート番号
  int port;
}
