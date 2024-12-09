/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import 'package:get/get.dart';
/// sioデータ表示用

class SioGroup{
  String header;
  RxBool isVisible = true.obs;
  List<SioEntry> entries;

  SioGroup({required this.header,required this.entries});
}

class SioEntry{
  RxString title;
  RxString label;
  RxString value;
  final bool hasButton;
  RxBool isVisible;

  SioEntry({
    required this.title,
    String label = '',
    String value = '',
    this.hasButton = true,
}):this.label = (label ?? '').obs,
  this.value = (value ?? '').obs,
  this.isVisible = true.obs;
}