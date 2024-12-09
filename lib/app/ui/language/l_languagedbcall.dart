/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';

import '/app/ui/controller/c_common_controller.dart';
import 'package:flutter_pos/postgres_library/src/db_manipulation_ps.dart';

/// 取得データからの必要な分の抽出コンストラクター
class LanguagesData {
  final multilingual_key;
  final country_division;
  final label_name;

  const LanguagesData(
      {required this.multilingual_key,
      required this.country_division,
      required this.label_name});

  factory LanguagesData.fromMap(Map<String, dynamic> map) => LanguagesData(
        multilingual_key: map['multilingual_key'],
        country_division: map['country_division'],
        label_name: map['label_name'],
      );

  Map<String, dynamic> toMap() => {
        'multilingual_key': multilingual_key,
        'country_division': country_division,
        'label_name': label_name,
      };
}

/// 多言語化DBアクセスクラス
class LanguagesMstDbCall {
  /// 多言語データ読み込み
  multilingualSelect() async {
    // DBアクセスクラス取得
    var dbAccess = DbManipulationPs();

    // データ読み込み
    List<LanguagesData> lstRtn = [];
    String sql1 = "select * from languages_mst";
    Result result = await dbAccess.dbCon.execute(sql1);

    if (result.isEmpty) {
      debugPrint('多言語マスタは空');
    } else {
      // 必要な部分だけを抽出
      for(int i = 0; i < result.length; i++ ){
        Map<String, dynamic> data  = result[i].toColumnMap();
        lstRtn.add(LanguagesData(
            multilingual_key: data["multilingual_key"],
            country_division: data["country_division"],
            label_name: data["label_name"]));
      }
    }

    return lstRtn;
  }

  /// 変数からのラベル名抽出
  String languageSelectWhere(List<LanguagesData> languagesMstAllRtn,
      String strMultilingualKey, int intCountryDivision) {
    String strRtn = '';
    try {
      strRtn = languagesMstAllRtn
          .where((a) =>
              a.country_division == intCountryDivision &&
              a.multilingual_key == strMultilingualKey)
          .toList()[0]
          .label_name
          .toString();
    } catch (e) {
      if (strRtn.isEmpty) {
        strRtn = strMultilingualKey;
      }
    }

    return strRtn;
  }

  /// タップするごとにデータが切り替わるようにする
  tapChange(Rx<int> intR, List<LanguagesData> lstData, setting) {
    // 位置をカウントアップする
    intR.value++;
    // マックス値と同じか超える場合は0に戻す
    if (intR.value >= lstData.length) {
      intR.value = 0;
    }
    // ボタン設定のタイトルに入れる多言語keyを切り替える
    setting.value.text = lstData[intR.value].multilingual_key;
    // リフレッシュで再描画させる
    setting.refresh();
  }

  /// 対象の多言語keyを抽出
  List<LanguagesData> getMultipleKey(String strMultipleKey) {
    // 変数から多言語データを取得
    List<LanguagesData> lstRtn = Get.find<CommonController>().lstLngsRtn;
    // 抽出後変数
    List<LanguagesData> lstMultipleKey = [];
    // 変数から該当するデータを抜き取る
    lstRtn.forEach((element) {
      // 対象の多言語keyを抽出
      // 比較できないものはスキップ
      if (element.multilingual_key.length >= strMultipleKey.length) {
        if (element.multilingual_key.substring(0, strMultipleKey.length) ==
                strMultipleKey &&
            element.country_division == LocaleNo.English.no) {
          lstMultipleKey.add(element);
        }
      }
    });

    return lstMultipleKey;
  }
}

/// 多言語：国区分を連番で作成、飛び番無し
enum LocaleNo {
  English(no:1,kind:"en"), // 英語
  Japanese(no:2,kind:"ja"), // 日本語
  Chinese(no:3,kind:"zh"), // 中国語
  Korean(no:4,kind:"ko"); // 韓国語

  const LocaleNo({required this.no, required this.kind});

  final int no;
  final String kind;
}

/// 多言語extensionクラス
extension LanguagesMstEx on String {
  // languageSelectWhere関数の中でobs値（intCountry）を使っているためOBXでの再描画か可能となっている。
  String get trns {
    CommonController c = Get.find();
    String strTrn;
    strTrn = LanguagesMstDbCall().languageSelectWhere(c.lstLngsRtn, this,
        c.intCountry.value); // thisはText('this'.trns)の「'this'」の部分

    // ラベル対応（日本語のみの設定）
    if (strTrn.isEmpty || strTrn == this) {
      strTrn = LanguagesMstDbCall()
          .languageSelectWhere(c.lstLngsRtn, this, c.defaultCountry);
    }

    return strTrn;
  }
}

// extension LanguagesMstEx2 on String {
//
//   Rx<String> get trns2 {
//     final strTrn = LanguagesMstDbCall()
//         .languageSelectWhere(c.lstLngsRtn, this, c.intCountry.value)
//         .obs;               // これでやる場合、Text('this'.trns.value)となる
//     return strTrn;
//   }
// }
