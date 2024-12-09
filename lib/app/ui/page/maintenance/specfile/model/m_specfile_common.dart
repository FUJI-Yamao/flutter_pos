/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../../../lib/apllib/competition_ini.dart';
import 'e_speckind.dart';
import 'm_specfile.dart';
import 'm_specfile_counter.dart';
import 'm_specfile_machine.dart';
import 'm_specfile_operating_env.dart';
import 'm_specfile_peripheral_device.dart';
import 'm_specified_amount_release_format.dart';
import 'userSetup/m_QCashier_common.dart';
import 'userSetup/m_QCashier_operation.dart';
import 'userSetup/m_speeza.dart';

/// スペックファイルの表示項目と処理
abstract class SpecRowDispCommon {

  /// インスタンス生成
  static SpecRowDispCommon factory(SpecKind dispSpecKind) {
    switch (dispSpecKind) {
    // マシン環境
      case SpecKind.machine:
        return SpecMachineDisplayData();
    // カウンター
      case SpecKind.counter:
        return SpecCounterDisplayData();
    // 動作環境
      case SpecKind.operating:
        return SpecOperatingEnvDisplayData();
    // 周辺装置
      case SpecKind.peripheralDevice:
        return SpecPeripheralDeviceDisplayData();
    // ACB
      case SpecKind.acb:
        return SpecSpecifiedAmountReleaseFormatDisplayData();
    // ECS
      case SpecKind.ecs:
        return SpecSpecifiedAmountReleaseFormatDisplayData();
    // Speeza
      case SpecKind.speeza:
        return SpeezaDisplayData();
    // QCashier設定（共通部）
      case SpecKind.qCashierCommon:
        return QCashierCommon();
    // QCashier設定（動作関連）
      case SpecKind.qCashierOperation:
      return QCashierOperation();
    // Shop&Go設定
      case SpecKind.shopAndGo:
      // TODO: Handle this case.
    // その他
      default:
      // 想定外なのでエラーにする
        throw AssertionError();
    }
  }

  /// 表示項目のリスト
  List<SpecFileDispRow> get rowList;

  /// 設定ファイルを読み込んで、表示項目毎の設定値を取得する
  /// dispRowDataには、非表示項目は含まれない
  Future<Map<SpecFileDispRow, SettingData>> loadJsonData(List<SpecFileDispRow> dispRowData);

  /// 表示項目毎の設定値を、設定ファイルに保存する
  Future<void> saveJsonData(Map<SpecFileDispRow, SettingData> specSubData);

  /// 営業中かどうか
  /// 営業中ならtrue
  Future<bool> isSaleDate() async {
    // 営業中判定
    CompetitionIniRet ret = await CompetitionIni.competitionIniGet(0, CompetitionIniLists.COMPETITION_INI_SALE_DATE, CompetitionIniType.COMPETITION_INI_GETSYS);
    String sDate = ret.value.substring(0, 10);
    if (sDate != "0000/00/00" && sDate != "0000-00-00") {
      // 営業中、編集不可
      return true;
    }
    return false;
  }

  /// 条件：営業ではない時に設定出来る
  Future<(bool, String)> configurableNotSaleDate() async {
    // 営業中判定
    if (await isSaleDate()) {
      return (false,"営業時間中は変更できません");
    }
    return (true, "");
  }
}




