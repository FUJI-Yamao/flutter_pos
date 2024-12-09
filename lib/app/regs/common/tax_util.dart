/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'package:collection/collection.dart';

import '../../inc/apl/t_item_log.dart';

/// MEMO:DBのデータなので、本当はソースに持ちたくないが、マジックナンバーを避けるために定義.
enum TaxCdDefine {
  none(-1), // なし.
  superRefTax(0), //上位参照.
  excludeTax1(1), //外税8%
  includeTax1(2), // 内税8%
  noneTax(3), // 非課税
  excludeTax2(4), // 外税10%
  includeTax2(5), //  内税10%
  nonTax2(10); //非課税.

  final int id;
  const TaxCdDefine(this.id);

  /// keyIdから対応するFuncKeyを取得する.
  static TaxCdDefine getDefine(int id) {
    TaxCdDefine? idDefine =
        TaxCdDefine.values.firstWhereOrNull((a) => a.id == id);
    idDefine ??= none; // 定義されているものになければnoneを入れておく.
    return idDefine;
  }
}
/// 税タイプ定義.
enum TaxTypeDefine {
  none(-1,-1),
  excludeTax(0,0), //外税.
  includeTax(1,1), //内税
  nonTax(10,2); // 免税/非課税.
  /// DBと対応するTaxType
  final int id;
  /// クラウドPOSで返されるTaxType.
  final int clxosRetId;
  const TaxTypeDefine(this.id,this.clxosRetId);

  /// DBと対応する税コードから対応するFuncKeyを取得する.
  static TaxTypeDefine getDefine(int id) {
    TaxTypeDefine? define =
        TaxTypeDefine.values.firstWhereOrNull((a) => a.id == id);
    define ??= none; // 定義されているものになければnoneを入れておく.
    return define;
  }
  /// クラウドPOSから返される税コードからから対応するFuncKeyを取得する.
  static TaxTypeDefine getDefineFromClxosRetId(int clxosRetId) {
    TaxTypeDefine? define =
    TaxTypeDefine.values.firstWhereOrNull((a) => a.clxosRetId == clxosRetId);
    define ??= none; // 定義されているものになければnoneを入れておく.
    return define;
  }
}
