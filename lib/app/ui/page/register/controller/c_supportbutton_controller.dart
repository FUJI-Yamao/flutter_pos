/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../../regs/checker/rc_touch_key.dart';

///暫定登録サポートボタン押されたのロジック
void onSuportButtonPressed(int keyId, dynamic presetInfo) {
  // FuncKeyに対応する処理を実行
  TchKeyDispatch.rcDTchByKeyId(keyId, presetInfo);
}
