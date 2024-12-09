/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
 /// 履歴ログ渡し用レスポンス
 class HistLogDownResponse {
  /// 返答ステータス
  final int retSts;
  /// エラーメッセージ
  final String errMsg;
  /// 履歴ログ配列
  final List<HistLog> histLog;

  HistLogDownResponse({required this.retSts, required this.errMsg, required this.histLog});

  factory HistLogDownResponse.fromJson(Map<String, dynamic> json) {
    return HistLogDownResponse(
      retSts: json['RetSts'],
      errMsg: json['ErrMsg'],
      histLog: json['HistLog'].map<HistLog>((e) => HistLog.fromJson(e)).toList()
    );
  }
}

/// 履歴ログ
class HistLog {

  /// 履歴ログコード
  final int histCd;

  /// 作成日時
  final String insDatetime;

  /// 企業コード
  final int compCd;

  /// 店舗コード
  final int streCd;

  /// テーブル名称
  final String tableName;

  /// SQLタイプ
  /// 
  /// ０：INSERT or UPDATE
  /// １：Delete
  /// ２：データ値のSQL実行
  /// ３：TRUNCATE
  /// ４：COPY取込・・・data1にパスを記述
  /// ５：COPY圧縮ファイル取込・・・data1にパスを記述
  /// ６：画像ファイル取込・・・data1にパスを記述
  /// ７：画像ファイル取込（tar）・・・data1にパスを記述
  /// ８：コマンドID
  /// ９：画像ファイル削除
  /// １０：設定ファイル取込・・・data1にパスを記述（使用用途不明）
  /// １１：COPY取込（M,ST以外）
  /// ※c_histlog_mst準拠
  final int mode;

  /// 履歴対象機器フラグ
  final int macFlg;

  /// データ１
  final String data1;

  /// データ２
  final String data2;

  HistLog({required this.histCd, required this.insDatetime, required this.compCd, required this.streCd, required this.tableName, required this.mode, required this.macFlg, required this.data1, required this.data2});

  factory HistLog.fromJson(Map<String, dynamic> json) {
    return HistLog(
      histCd: int.tryParse(json['hist_cd']) ?? 0,
      insDatetime: json['ins_datetime'] ?? '',
      compCd: int.tryParse(json['comp_cd']) ?? 0,
      streCd: int.tryParse(json['stre_cd']) ?? 0,
      tableName: json['table_name'] ?? '',
      mode: int.tryParse(json['mode']) ?? 0,
      macFlg: int.tryParse(json['mac_flg']) ?? 0,
      data1: json['data1'] ?? '',
      data2: json['data2'] ?? '',
    );
  }
}