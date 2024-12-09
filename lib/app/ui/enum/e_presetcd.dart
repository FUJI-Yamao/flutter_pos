/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:ui';
import '../colorfont/c_basecolor.dart';

/// プリセットデータ
enum PresetCd {
  ///　登録画面商品リスト
  productList1(20101),
  productList2(20201),
  productList3(20301),
  productList4(20401),
  productList5(20501),
  productList6(20601),
  productList7(20701),

  /// 登録サポート
  loginSupport(25001),

  /// 業務画面
  operationList1(25002),
  operationList2(25003),
  operationList3(25004),
  operationList4(25005),

  /// 小計サポート
  subtotalSupport(26001),

  /// 支払一覧
  paymentList(26002),

  /// 小計値下一覧
  discountList(26003),

  /// 電子マネー
  electronicMoney(26781),

  /// 商品券
  giftVoucher(26782);

  ///　プリセットコードの値
  final int value;

  ///　コンストラクタ
  const PresetCd(this.value);

  ///　登録画面商品リスト
  static const productPresets = [
    PresetCd.productList1,
    PresetCd.productList2,
    PresetCd.productList3,
    PresetCd.productList4,
    PresetCd.productList5,
    PresetCd.productList6,
    PresetCd.productList7,
  ];

  ///プリセットボタンカラー
  static const Map<int, Color> buttonColor = {
    101: BaseColor.presetColorCd101,
    102: BaseColor.presetColorCd102,
    103: BaseColor.presetColorCd103,
    104: BaseColor.presetColorCd104,
    105: BaseColor.presetColorCd105,
    106: BaseColor.presetColorCd106,
    107: BaseColor.presetColorCd107,
    108: BaseColor.presetColorCd108,
    109: BaseColor.presetColorCd109,
    110: BaseColor.presetColorCd110,
    201: BaseColor.presetColorCd201,
    202: BaseColor.presetColorCd202,
    203: BaseColor.presetColorCd203,
    204: BaseColor.presetColorCd204,
    205: BaseColor.presetColorCd205,
    206: BaseColor.presetColorCd206,
    207: BaseColor.presetColorCd207,
    208: BaseColor.presetColorCd208,
    209: BaseColor.presetColorCd209,
    210: BaseColor.presetColorCd210,
    211: BaseColor.presetColorCd211,
    212: BaseColor.soundUnSelectInColor,
  };

  /// ボタン色取得
  static Color getBtnColor(int presetCd) {
    return buttonColor[presetCd] ?? BaseColor.transparent;
  }

  /// ラベルなし場合ボタン色
  static const int transColorCd = 212;
}
