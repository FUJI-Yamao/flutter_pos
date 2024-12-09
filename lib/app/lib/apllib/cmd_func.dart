/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io' as io;

/// OSへ直接命令するコマンド関数.
class CmdFunc {
  /// ファイル・ディレクトリの権限変更を行う.
  /// C言語chmodの置き換え関数
  static bool chmod(String path, dynamic mod) {
    // TODO:10008 ファイル/ディレクトリ権限操作
    // pathをプラットフォーム用に加工するTprxPlatform.getPlatformPath(path)
    return true;
  }

  /// ファイル・ディレクトリに全ての権限を付与する
  ///  関連tprxソース: chmod(dirname, S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IWGRP|S_IXGRP|S_IROTH|S_IWOTH|S_IXOTH) =
  static bool chmodAll(String path) {
    // 全ての権限を付与.
    // TODO:10008 ファイル/ディレクトリ権限操作
    chmod(path, null);
    return true;
  }

  /// プロセスIDを取得する
  ///  関連tprxソース:getpid
  int getPid() {
    return io.pid;
  }

  ///  lsコマンドの結果を取得する
  ///  関連tprxソース:getpid
  static String getLsResult(String path) {
    // TODO:10067 lsコマンド
    //ls -R /home/web2100/ など
    return "";
  }

  ///  C言語のsignal関数の代替
  ///  関連tprxソース: signal( SIGINT, (void *)sysSigInt ) == SIG_ERR
  static void signal() {
    // TODO:10069 シグナル関数
    //    signal( SIGINT, (void *)sysSigInt ) == SIG_ERRなど
  }

  ///  linux dfコマンドの代替
  ///  関連tprxソース: signal( SIGINT, (void *)sysSigInt ) == SIG_ERR
  static void df({String outputPath = ""}) {
    // TODO:10090 dfコマンド

    //    sprintf(cmd, "/bin/df &>%s/log/df.txt", SysHomeDirp);
  }
}
