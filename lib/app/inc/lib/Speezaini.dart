/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


//---------------------------------------------------------------------------------
//	Prototype
//---------------------------------------------------------------------------------
import 'package:flutter_pos/app/inc/lib/qcConnect.dart';

/// 各レジ固有の設定 (ファイルリクエストで取得できない)
/// 関連tprxソース: Speezaini.h - SpeezaPrivateData
class SpeezaPrivateData {
  int qcSelectConColor1 = 0;   // QC指定1キー  プリセット色
  int qcSelectConColor2 = 0;   // QC指定2キー  プリセット色
  int qcSelectConColor3 = 0;   // QC指定3キー  プリセット色
  int QcSelectConPrint1 = 0;   // QC指定1キー  印字  0:する 1:しない
  int QcSelectConPrint2 = 0;   // QC指定2キー  印字  0:する 1:しない
  int QcSelectConPrint3 = 0;   // QC指定3キー  印字  0:する 1:しない
  int QcSelectConMacNo1 = 0;   // QC指定1キー  接続レジNo
  int QcSelectConMacNo2 = 0;   // QC指定2キー  接続レジNo
  int QcSelectConMacNo3 = 0;   // QC指定3キー  接続レジNo
  String qcSelectConMacName1 = ""; // QC指定1キー  プリセット名称
  String qcSelectConMacName2 = ""; // QC指定2キー  プリセット名称
  String qcSelectConMacName3 = ""; // QC指定3キー  プリセット名称
  int qcSelectPosi1 = 0;    // QC指定1キー　拡大表示時の位置
  int qcSelectPosi2 = 0;                          // QC指定2キー　拡大表示時の位置
  int qcSelectPosi3 = 0;                          // QC指定3キー　拡大表示時の位置
}

/// QCashier状態表示を構成するための構造体
/// 関連tprxソース: Speezaini.h - SpeezaMsgFormat
class SpeezaMsgFormat{
  int BackColor = 0;   // 背景色
  int TextColor = 0;   // 文字色
  String Message = ""; // 表示メッセージ
}

/// 各レジ共通の設定 (ファイルリクエストで取得可能。ただし、個別設定も出来る)
/// 関連tprxソース: Speezaini.h - SpeezaCommonData
class SpeezaCommonData{
  int qcSelectChangeAmountType = 0;  // お釣あり取引時に指定キーを選択する (QC指定)
  int qcSelectCautionType = 0;   // QCashier注意表示 (0:する  1:しない)
  // TODO:00012 平野 下記二行は実装保留
  List<SpeezaMsgFormat> MsgForm = List.generate(QcStatusType.QCSTATUS_TYPE_MAX, (index) => SpeezaMsgFormat());  // QCashier状態表示のフォーマット
  List<SpeezaMsgFormat> CautionForm = List.generate(QcCautionStatus.QC_CAUTION_MAX, (index) => SpeezaMsgFormat());  // QCashier注意表示のフォーマット
  int qcTerminalReturnTime = 0;   // 操作後の登録画面戻り時間（秒）　０～９９　（０：しない　９９：ターミナル参照）
  int qCSelectRprItemPrn = 0;   // QC指定時の再発行で登録商品を印字 (0:しない　1:する)
  int qcDispPrecaBalSht = 0;   // 精算機で電子マネー残高不足時登録機に通知する (0:しない 1:する)
  int qcSelectStlPushedExpand = 0;  // 小計押下時にQC指定キーを拡大表示する (0:しない　1:する)
  int chargeTranSpeezaUpdate = 0;   // 小計額以上の会計・品券キー入力時に取引送信 (0:する　1:しない)
}

/// SpeezaIni設定の各種データ格納構造体
/// 関連tprxソース: Speezaini.h - SpeezaIniData
class SpeezaIniData{
  SpeezaCommonData com = SpeezaCommonData(); // 各レジ共通の設定
  SpeezaPrivateData pvt = SpeezaPrivateData(); // 各レジ固有の設定
}