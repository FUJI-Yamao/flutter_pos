/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';

import '../../../../inc/lib/mm_reptlib_def.dart';

/// 予約レポート情報
class BatchReportInfo {
  /// コンストラクタ
  BatchReportInfo();

  /// 企業番号
  int compCd = 0;
  /// 店舗番号
  int streCd = 0;
  /// マシン番号
  int macNo = 0;
  /// 営業日（YYYY/MM/DD）
  String saleDate = '';
  /// 予約レポートグループコード
  int batchGrpCd = 0;
}

/// 予約レポート詳細情報
class BatchReportDetail {
  /// コンストラクタ
  BatchReportDetail({
    required this.batchNo,
    required this.batchName,
    required this.batchReportOrderDetailList,
  });

  /// 選択状態
  Rx<bool> isChecked = false.obs;
  /// 作成した予約番号(1～9999)
  final int batchNo;
  /// 予約名称
  final String batchName;
  /// 予約レポート詳細情報のリスト
  final List<BatchReportOrderDetail> batchReportOrderDetailList;
}

/// 予約レポート順番詳細情報
class BatchReportOrderDetail {
  /// コンストラクタ
  BatchReportOrderDetail({
    required this.reportOrdr,
    required this.batchReportNo,
    required this.batchFlg2,
  });

  /// 順番(1～12)
  final int reportOrdr;
  /// 登録したレポート番号
  final int batchReportNo;
  /// 予約フラグ２（0：レジ日計　1：店舗日計）
  final int batchFlg2;

  /// 登録したレポートの名称
  String get batchReportNoName {
    return ReportKind.values[batchFlg2].name + ReptNumber.values[batchReportNo].name;
  }
}

/// レポートの種類
enum ReportKind {
  regDly('(レジ日計)'),
  strDly('(店舗日計)'),
  strTrm('(店舗累計)'),
  list('(一覧)'),
  custDly('(会員日計)'),
  custTrm('(会員累計)'),
  custList('(会員一覧)'),
  abj('(精算レジ)');

  /// コンストラクタ
  const ReportKind(this.name);
  /// レポートの種類の名称
  final String name;
}