/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../regs/checker/liblary.dart';

class CmAry {


  /// cmFilを呼ぶ。引数の[data]配列の中身を指定サイズまで0でリセットする。
  /// 配列の中身すべてを0にする場合はsizeはdata.length
  /// #define	cm_clr(dst,size)	cm_fil(dst,(char)0,size)
  ///  関連tprxソース: cm_ary.h - cm_clr
  static void  cmClr(List<int> data, int listSize){
    return Liblary.cmFil(data,0,listSize);
  }

  /// String型に指定した数の0を入れる
  static String setStringZero(int length){
    return Liblary.setStringData('0', length);
  }
}
