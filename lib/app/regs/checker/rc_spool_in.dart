/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import '../spool/rsmain.dart';
import '../../ui/socket/client/register2_socket_client.dart';

/// 関連tprxソース:rcspooli.c
class RcSpoolIn {
  /// 関連tprxソース:rcspooli.c - rcSpoolIn
  static Future<void> rcSpoolIn() async {

    // データ送出
    String buf = await RsMain.rsReadTempFile();
    if (await RsMain.isSpoolFileSend()) {
      if (buf.isNotEmpty) {
        Register2SocketClient().sendDualModeItemRegister(buf);
      }
    }

    return;
  }
}