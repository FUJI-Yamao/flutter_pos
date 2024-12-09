/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../inc/sys/tpr_type.dart';

/// メカキータスクステータス
///  関連tprxソース：\drv\mkey_2800\tprdrv_msr_2800.h - MSR_INFO
class MsrInfo {
  static const MSR_RCVBUF_SIZE_MAX = 300;
  static const MSR_JISBUF_SIZE_MAX = 200;

  int sysPipe = 0; /* Sys task's pipe fds (write)  */
  List<TprDID> myDid = [0, 0]; /* My device id	*/
  List<String> readBufSave =
      List.generate(MSR_RCVBUF_SIZE_MAX + 1, (_) => ""); /* 比較用通信データバッファ */
  int compCnt = 0;
  int compCntMax = 0;
  List<String> jis1Save =
      List.generate(MSR_JISBUF_SIZE_MAX, (_) => ""); /* 比較用ＪＩＳ１バッファ */
  List<String> jis2Save =
      List.generate(MSR_JISBUF_SIZE_MAX, (_) => ""); /* 比較用ＪＩＳ２バッファ */
  int device = 0; /* 通信ログ書き込み先ファイル指定 */
  bool msrFlg = false;

  static final MsrInfo _instance = MsrInfo._internal();
  factory MsrInfo() {
    return _instance;
  }
  MsrInfo._internal();
}

/// 磁気カードリーダから読み取った入力データ
///  関連tprxソース：\drv\mkey_2800\tprdrv_msr_2800.h - INPUT
class MsrInput {
  List<int> code = List.generate(MsrInfo.MSR_RCVBUF_SIZE_MAX, (_) => 0);

  static final MsrInput _instance = MsrInput._internal();
  factory MsrInput() {
    return _instance;
  }
  MsrInput._internal();
}
