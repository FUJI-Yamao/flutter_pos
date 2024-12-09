/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import '../../inc/sys/tpr_type.dart';
import '../../inc/apl/rxmem_define.dart';


/// FB Memo Library
///  関連tprxソース:lib_fb_memo.c
class LibFbMemo {
  /// 常駐メモ未読フラグセット
  ///  関連tprxソース:lib_fb_memo.c　lib_fb_memo_MemoReadFlgSet()
  static void memoReadFlgSet(
      TprMID tid, dynamic dbConnection, RxCommonBuf pCom) {
    // TODO:10029 常駐メモ
  }

  /// 連絡メモ未読フラグセット
  ///  関連tprxソース:lib_fb_memo.c　lib_fb_memo_TMemoReadFlgSet()
  static void tmemoReadFlgSet(
      TprMID tid, dynamic dbConnection, RxCommonBuf pCom) {
    // TODO:10053 連絡メモ
  }
}
