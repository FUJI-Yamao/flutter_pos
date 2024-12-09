/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../db_library/src/db_manipulation.dart';

/// 理由区分選択画面の為の引数構造体
///  関連tprxソース: dy_sel.h - struct ReasonSelStruct
class ReasonSelStruct {
  int kindCode = 0;  // 表示させる区分コード
  int titleBackColor = 0;  // 選択画面のタイトル背景色
  int dualMode = 0;  // 画面の表示タイプ (0:タワー側 1:卓上側)
  String titleName = "";  // 選択画面のタイトル
  String guidanceName = "";  // ガイダンス内容
  CDivideMstColumns reasonMst = CDivideMstColumns();  // 選択結果格納
  CDivide2MstColumns reasonMst2 = CDivide2MstColumns();  // 選択結果格納
  int nowDivCode = 0;  // 選択されている区分コード
  int div2Flg = 0;  // c_divide2_mstのデータを取得
}

