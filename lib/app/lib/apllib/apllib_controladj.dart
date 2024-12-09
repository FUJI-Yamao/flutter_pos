/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/lib/apllib.dart';

/// 関連tprxソース:AplLib_ControlAdj.c
class AplLibControlAdj {

  static CtrlAdj aplLibControlAdj(String pEuc, int maxSize) {
    CtrlAdj adj = CtrlAdj();
    String retChar = '';
    String maxChar = '';

    adj.res = -1;
    if (pEuc.contains('\\')) {
      maxChar = pEuc;
      while (maxChar.contains('\\')) {
        int index = maxChar.indexOf('\\');
        retChar += maxChar.substring(0, index);
        if (retChar.length + 2 >= maxSize) {
          adj.res = 1;
          adj.pChar = retChar;
          return adj;
        }
        retChar += '\\\\';
        maxChar = maxChar.substring(index + 1);
      }
      retChar += maxChar;
    }
    else {
      retChar = pEuc;
    }

    if (pEuc.contains('\'')) {
      maxChar = pEuc;
      while (maxChar.contains('\'')) {
        int index = maxChar.indexOf('\'');
        retChar += maxChar.substring(0, index);
        if (retChar.length + 2 >= maxSize) {
          adj.res = 1;
          adj.pChar = retChar;
          return adj;
        }
        retChar += '\\\'';
        maxChar = maxChar.substring(index + 1);
      }
      retChar += maxChar;
    }
    adj.res = 0;
    adj.pChar = retChar;
    return adj;
  }
}