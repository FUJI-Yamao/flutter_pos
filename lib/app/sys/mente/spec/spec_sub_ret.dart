/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../inc/sys/tpr_dlg.dart';

/// スペックファイル画面各処理共通の戻り値クラス
/// retFlg:デフォルトtrue(正常終了)
/// confirmMsg:デフォルトMSG_NONE(表示メッセージなし)
class SpecSubRet {
  bool retFlg = true;
  DlgConfirmMsgKind confirmMsg = DlgConfirmMsgKind.MSG_NONE;
}
