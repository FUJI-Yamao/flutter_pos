/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

// 関連tprxソース:sysbkupd.c

/// 関連tprxソース:sysbkupd.c -sysKeyMap
class SysKeyMap {
  int idx = 0;
  late Function func;
}

/// login information
/// 関連tprxソース:sysbkupd.c -LoginInfo
class LoginInfo {
  ///  staff number
  int staffCd = 0;

  ///  name
  String name = "";

  ///  password
  String passwd = "";

  /// staff permit
  /// 1=regs, 2=set, 9=manage
  int lvlCd = 0;

  /// permit bytes
  ///  0=hide, 1=show
  String permit = "";

  /// open one-only
  int openA = 0;

  ///  open one-two
  int openB = 0;

  /// open two
  int openC = 0;

  /// 0:スキャナ 1:手入力
  int scanTyp = 0;
}

typedef SysLogin_T = LoginInfo;
