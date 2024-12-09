/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
/// 承認キー　定義.
///  関連tprxソース:  recogkey.h
class RecogkeyDefine{

  /// ログ出力の定義
  /// 関連tprxソース:  recogkey.h -RECOGKEY_LOG
  static const  RECOGKEY_LOG = 0;

  ///  bit data max
  /// 関連tprxソース:  recogkey.h - RECOGKEY_BIT_MAX;
  static const 	RECOGKEY_BIT_MAX = 4;
  /// bitのループ回数
  /// 関連tprxソース:  recogkey.h -RECOGKEY_BIT_LOOP_MAX
  static const 	RECOGKEY_BIT_LOOP_MAX	= 3;
  /// 関連tprxソース:  recogkey.h -RECOGKEY_CHK_PRINTER
  static const	RECOGKEY_CHK_PRINTER = 0;
  /* version */
  static const 	RECOGKEY_PRN_VERSION	= "1.2";
  static const 	RECOGKEY_SMHD_VERSION = "1.006";

  /// smhd.json
  /// 関連tprxソース:  recogkey.h - RECOGKEY_FILEPATH_SMHD
  static const  RECOGKEY_FILEPATH_SMHD = "/etc/version_smhd.json";
  static const  RECOGKEY_INI_TYPE_SMHD = "submasterhd";
  static const  RECOGKEY_INI_SEC_SMHD =	"ver";
  static const 	RECOGKEY_SMHD_VER_LEN	= 5;

  /// 承認キーのチェックコード.
  /// 関連tprxソース: recogkey.c - function.json
  static const  RECOGKEY_CODE = "012345";
}