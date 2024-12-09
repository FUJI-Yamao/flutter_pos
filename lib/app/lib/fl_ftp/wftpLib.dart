/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:path/path.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/environment.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';

/// wftpファイルの存在や書き込みをチェックするためのパラメータ.
enum WftpNetrc {
  WFTP_CHECK_NETRC_FILE, // ファイルの存在チェック.
  WFTP_CHECK_NETRC_FILE_MAKE, // ファイル作成.
  WFTP_CHECK_NETRC_WRTE,
  WFTP_NETRC_FILE_NON, // ファイルが存在しない.
  WFTP_NETRC_FILE_EXIST, // ファイルが存在する.
  WFTP_NETRC_NOT_WRITE, //　指定文字列が記載されていない.
  WFTP_NETRC_ALREADY_WRITE, //　指定文字列が既に記載済み.
  WFTP_NETRC_WRITE_DATA_ERROR;

  int get WFTP_NETRC_WRITW_MAX => 100;
}

/// wftpファイルの管理クラス.
///  関連tprxソース:WftpLib.c
class WFtpLib {
  static const int FNAME_LEN = 512;
  static const int CMDNAME_LEN = 512;

  static const WFTP_CHK_CHK_USER_PASS = "Please login";
  static const WFTP_CHK_NOT_AVAILABLE = "Service not available";
  static const WFTP_CHK_REFUSE = "refused";
  static const WFTP_CHK_OPEN_ERR = "Not connect";

  static const WFTP_NETRC_MACHINE = "machine";
  static const WFTP_NETRC_LOGIN = "login";
  static const WFTP_NETRC_PASSWOED = "password";

  ///	起動時にFTPで使用する「netrc」のファイルがあれば削除する
  /// 関連tprxソース:WftpLib.c - Wftp_Netrc_File_Del
  static void wftpNetrcFileDel(TprTID tid, String homeDir) {
    String workDir = sprintf("%s/.netrc", [homeDir]);
    WftpNetrc ret = wftpCheckExistNetrc(
        tid, homeDir, WftpNetrc.WFTP_CHECK_NETRC_FILE, workDir);
    if (ret == WftpNetrc.WFTP_NETRC_FILE_NON) {
      TprLog().logAdd(
          tid, LogLevelDefine.normal, "wftpNetrcFileDel:[$workDir] NonFile");
      return;
    }
    Directory dir =  TprxPlatform.getDirectory(workDir);
    dir.delete(recursive: true);
    TprLog().logAdd(
        tid, LogLevelDefine.normal, "wftpNetrcFileDel:[$workDir] File Remove");
  }

  ///	「netrc」のファイルの内容を確認する
  ///	返り値	ファイルがない場合	WFTP_NETRC_FILE_NON
  ///		ファイルがある場合	WFTP_NETRC_FILE_EXIST
  ///		内容に記載がない場合	WFTP_NETRC_NOT_WRITE
  ///		内容に記載がある場合	WFTP_NETRC_ALREADY_WRITE
  ///  関連tprxソース:WftpLib.c - Wftp_Netrc_File_Check()
  static WftpNetrc wftpCheckExistNetrc(
    TprTID tid,
    String userHomeDir,
    WftpNetrc type,
    String filePath, {
    String hostName = "",
    String loginName = "",
    String passwordName = "",
  }) {
    final File file = TprxPlatform.getFile(filePath);
    if (!file.existsSync()) {
      TprLog().logAdd(
          tid, LogLevelDefine.normal, "$filePath Non File[${type.name}]");
      if (type == WftpNetrc.WFTP_CHECK_NETRC_FILE_MAKE) {
        // TODO:00001 日向 ディレクトリまで一緒に作ってくれるのか.
        RandomAccessFile rFile =
            file.openSync(mode: FileMode.write); //　ファイル新規作成.
        rFile.close();
      }
      // ファイルが存在しない.
      return WftpNetrc.WFTP_NETRC_FILE_NON;
    }
    if (type == WftpNetrc.WFTP_CHECK_NETRC_FILE) {
      // ファイルが存在した.
      return WftpNetrc.WFTP_NETRC_FILE_EXIST;
    }
    try {
      // TODO:10012 C言語仕様の確認   C言語だとNULで表示されるなら仕様がかわるので要注意
      String checkStr =
          "$WFTP_NETRC_MACHINE $hostName $WFTP_NETRC_LOGIN $loginName $WFTP_NETRC_PASSWOED $passwordName";
      // ファイルの中に指定の文字列があるかチェック.
      WftpNetrc ret = wftpNetrcFileCheck(tid, file, checkStr);
      return ret;
    } catch (e, s) {
      // ファイルを読み込めないなどのファイルオープンエラー.
      TprLog().logAdd(tid, LogLevelDefine.error,
          "fopen[${basename(file.path)}] error $e ,$s");
      if (type == WftpNetrc.WFTP_CHECK_NETRC_FILE_MAKE) {
        wftpNetrcFileDel(Tpraid.TPRAID_FTP, userHomeDir);
        RandomAccessFile rFile =
            file.openSync(mode: FileMode.write); //　ファイル新規作成.
        rFile.close();
      }
      // 文字を読み込む時に問題が発生した.
      return WftpNetrc.WFTP_NETRC_WRITE_DATA_ERROR;
    }
  }

  /// 指定ファイルに確認用文字列が書かれているならWFTP_NETRC_ALREADY_WRITEを返す.
  ///  関連tprxソース:WftpLib.c - Wftp_Netrc_File_Check()
  static WftpNetrc wftpNetrcFileCheck(TprTID tid, File file, String checkStr) {
    List<String> lines = file.readAsLinesSync();
    for (String line in lines) {
      if (line == checkStr) {
        return WftpNetrc.WFTP_NETRC_ALREADY_WRITE;
      }
    }
    return WftpNetrc.WFTP_NETRC_NOT_WRITE;
  }
}
