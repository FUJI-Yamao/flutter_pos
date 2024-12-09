/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:math';

import '../../inc/lib/cm_nedit.dart';

class Liblary{
  static const HI = 1;
  static const EQ = 0;
  static const LO = -1;

  // /// 関連tprxソース:liblary.c - cm_bcdtol
  // // TODO:00012 平野 checker関数実装のため、定義のみ追加
  // static int cmBcdtol(int index)
  // {
  //   return 0;
  // }

  /// 関連tprxソース:liblary.c - cm_chk_zero0
  static int cmChkZero0(String dst, int size) {
    int disit;
    for (disit = size * 2; size > 0; size--, dst = dst.substring(1)) {
      if (dst.codeUnitAt(0) & 0xF0 != 0) {
        break;
      }
      disit--;
      if (dst.codeUnitAt(0) & 0x0F != 0) {
        break;
      }
      disit--;
    }
    return disit;
  }

  /// int型の配列[list]の全ての要素を[data]にする.
  /// 関連tprxソース:liblary.c - cm_fil()
  static void cmFil(List<int> list,int data,int listSize){
    if(listSize <= 0){
      return;
    }
    int changeSize = min(list.length , listSize);
    list.fillRange(0,changeSize,data);
  }

  /// 関連tprxソース:liblary.c - cm_ucmp
  /// [dst] : top of destination BCD buffer
  /// [src] : top of source BCD buffer
  static int cmUcmp(List<int> dst, List<int> src) {
    int result = EQ;
    int size = dst.length < src.length ? dst.length : src.length;

    for (int i = 0; i < size; i++) {
      if (dst[i] < src[i]) {
        result = HI;
        break;
      }
      if (dst[i] > src[i]) {
        result = LO;
        break;
      }
    }
    return result;
  }

  /// String型に指定した数の文字列strを入れる
  static String setStringData(String str, int length){
    String result = '';
    for (int i = 0; i < length; i++) {
      result += str;
    }
    return result;
  }

  /// 関連tprxソース:liblary.c - cm_Edit_TotalPrice()
  // TODO:00013 三浦 保留
  static int cmEditTotalPrice(CmEditCtrl fCtrl, String pBufBot, int wBufSize, int lData){
    return 0;
  }

  /// 関連tprxソース:liblary.c - cm_Edit_Binary()
  // TODO:00013 三浦 保留
  static int cmEditBinary(CmEditCtrl fCtrl, String pBufBot, int wBufSize, int lData, int wDataDigits){
    return 0;
  }
}