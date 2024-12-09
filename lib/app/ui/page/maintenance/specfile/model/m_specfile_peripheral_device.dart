/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';

import '../../../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../../../common/cls_conf/mac_infoJsonFile.dart';
import '../../../../../common/cls_conf/sysJsonFile.dart';
import '../../../../../common/cmn_sysfunc.dart';
import '../../../../../inc/apl/rxmem_define.dart';
import '../../../../../inc/apl/trm_list.dart';
import '../../../../../inc/lib/cm_sys.dart';
import '../../../../../inc/sys/tpr_log.dart';
import 'm_specfile.dart';
import 'm_specfile_common.dart';

/// 周辺装置画面の項目と処理
class SpecPeripheralDeviceDisplayData extends SpecRowDispCommon {

  /// 表示項目
  static const String specBtnlvl5_1 = 'SPEC_BTNLVL5_1';     // 自動釣銭釣札機接続
  static const String specBtnlvl5_3 = 'SPEC_BTNLVL5_3';     // 釣銭釣札機接続時の入金確定処理
  static const String specBtnlvl5_4 = 'SPEC_BTNLVL5_4';     // カード決済機接続
  static const String specBtnlvl5_7 = 'SPEC_BTNLVL5_7';     // 自動釣銭釣札機の種類
  static const String specBtnlvl5_14 = 'SPEC_BTNLVL5_14';   // 釣銭釣札機モード変更
  static const String specBtnlvl5_21 = 'SPEC_BTNLVL5_21';   // 顧客問い合わせサーバー接続
  static const String specBtnlvl5_28 = 'SPEC_BTNLVL5_28';   // マルチ端末機接続
  static const String specBtnlvl5_30 = 'SPEC_BTNLVL5_30';   // カラー客表接続
  static const String specBtnlvl5_31 = 'SPEC_BTNLVL5_31';   // USBカメラ接続
  static const String specBtnlvl5_32 = 'SPEC_BTNLVL5_32';   // 自走式磁気カードリーダー接続
  static const String specBtnlvl5_34 = 'SPEC_BTNLVL5_34';   // マルチ決済端末J-Mups連動
  static const String specBtnlvl5_38 = 'SPEC_BTNLVL5_38';   // カラー客表サイズ
  static const String specBtnlvl5_39 = 'SPEC_BTNLVL5_39';   // USBカメラ設置方向
  static const String specBtnlvl5_40 = 'SPEC_BTNLVL5_40';   // USBカメラ映像リアルタイム表示
  static const String specBtnlvl5_42 = 'SPEC_BTNLVL5_42';   // USBカメラ映像リアルタイム表示サイズ
  static const String specBtnlvl5_51 = 'SPEC_BTNLVL5_51';   // HappySelfフルセルフ 秤接続

  /// 表示項目のリスト
  @override
  List<SpecFileDispRow> get rowList => [
    const SpecFileDispRow(
      key: specBtnlvl5_1,
      title: "自動釣銭釣札機接続",
      description: "自動釣銭釣札機接続\n　しない／釣銭機／釣銭釣札機",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("釣銭機", 1),
        SelectionSetting("釣銭釣札機", 2)
      ],
    ),
    const SpecFileDispRow(
      key: specBtnlvl5_3,
      title: "釣銭釣札機接続時の入金確定処理",
      description: "釣銭釣札機接続時の入金確定処理\n　しない／入金確定／自動確定／従業員入金確定／従業員自動確定",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("入金確定", 1),
        SelectionSetting("自動確定", 2),
        SelectionSetting("従業員確定", 3),
        SelectionSetting("従業員自動", 4)
      ],
    ),
    const SpecFileDispRow(
      key: specBtnlvl5_4,
      title: "カード決済機接続",
      description: "カード決済機接続           \n　しない／Edy(60)／Edy(100)／ﾔﾏﾄ電子ﾏﾈｰ端末／MST",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("Edy(60)", 5),
        SelectionSetting("Edy(100)", 7),
        SelectionSetting("ﾔﾏﾄ電子ﾏﾈｰ端末", 8),
        SelectionSetting("MST", 9)
      ],
    ),
    const SpecFileDispRow(
      key: specBtnlvl5_7,
      title: "自動釣銭釣札機の種類",
      description: "自動釣銭釣札機の種類       ACB-10／ACB-20／\n　ACB-50／ECS／N8384／ACB-200／FAL2／RT-300／ECS-777",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("ACB-10", 0),
        SelectionSetting("ACB-20", 1),
        SelectionSetting("ACB-50", 2),
        SelectionSetting("ECS", 3),
        SelectionSetting("N8384", 4),
        SelectionSetting("ACB-200", 5),
        SelectionSetting("FAL2", 6),
        SelectionSetting("RT-300", 7),
        SelectionSetting("ECS-777", 8),
      ],
    ),
    const SpecFileDispRow(
      key: specBtnlvl5_14,
      title: "釣銭釣札機モード変更",
      description: "釣銭釣札機モード変更　　　　　　　　しない／入金確定切替／\n　自動確定切替／従業員確定切替／従業員自動切替/入金or自動",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("入金確定", 1),
        SelectionSetting("自動確定", 2),
        SelectionSetting("従業員確定", 3),
        SelectionSetting("従業員自動", 4),
        SelectionSetting("入金or自動", 5)
      ],
    ),
    const SpecFileDispRow(
      key: specBtnlvl5_21,
      title: "顧客問い合わせサーバー接続",
      description: "顧客問い合わせサーバー接続\n　しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1)
      ],
    ),
    const SpecFileDispRow(
      key: specBtnlvl5_28,
      title: "マルチ端末機接続",
      description: "マルチ端末機接続(FeliCa非接触IC)\n　しない／FCL-C100／FAP-10／UT1／PFM-10／VEGA",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("FCL-C100", 1),
        SelectionSetting("FAP-10", 2),
        SelectionSetting("UT1", 3),
        SelectionSetting("PFM-10", 4),
        SelectionSetting("VEGA", 6)
      ],
    ),
    SpecFileDispRow(
        key: specBtnlvl5_30,
        title: "カラー客表接続",
        description: "カラー客表接続\n  しない／する",
        editKind: SpecFileEditKind.selection,
        setting: [
          const SelectionSetting("しない", 0),
          const SelectionSetting("する", 1)
        ],
        displayableFunc: _displayableColorDspCnct
    ),
    SpecFileDispRow(
        key: specBtnlvl5_31,
        title: "USBカメラ接続",
        description: "USBカメラ接続\n　しない／する",
        editKind: SpecFileEditKind.selection,
        setting: [
          const SelectionSetting("しない", 0),
          const SelectionSetting("する", 1)
        ],
        displayableFunc: _displayableUSBCamCnct
    ),
    const SpecFileDispRow(
      key: specBtnlvl5_32,
      title: "自走式磁気カードリーダー接続",
      description: "自走式磁気カードリーダー接続\n　しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1)
      ],
    ),
    SpecFileDispRow(
        key: specBtnlvl5_34,
        title: "マルチ決済端末J-Mups連動",
        description: "マルチ決済端末J-Mups連動(ｶｰﾄﾞ決済機併用)\n  しない／する",
        editKind: SpecFileEditKind.selection,
        setting: [
          const SelectionSetting("しない", 0),
          const SelectionSetting("する", 1)
        ],
        displayableFunc: _displayableJmupsTwinCnct
    ),
    const SpecFileDispRow(
      key: specBtnlvl5_38,
      title: "カラー客表サイズ",
      description: "カラー客表サイズ\n　7インチ／15インチ",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("7インチ", 0),
        SelectionSetting("15インチ", 1)
      ],
    ),
    SpecFileDispRow(
        key: specBtnlvl5_39,
        title: "USBカメラ設置方向",
        description: "USBカメラ設置方向\n  横／縦",
        editKind: SpecFileEditKind.selection,
        setting: [
          const SelectionSetting("横", 0),
          const SelectionSetting("縦", 1)
        ],
        displayableFunc: _displayableUSBCamCnct
    ),
    SpecFileDispRow(
        key: specBtnlvl5_40,
        title: "USBカメラ映像リアルタイム表示",
        description: "USBカメラ映像リアルタイム表示\n　しない／する",
        editKind: SpecFileEditKind.selection,
        setting: [
          const SelectionSetting("しない", 0),
          const SelectionSetting("する", 1)
        ],
        displayableFunc: _displayableUSBCamCnct
    ),
    SpecFileDispRow(
        key: specBtnlvl5_42,
        title: "USBカメラ映像リアルタイム表示サイズ",
        description: "USBカメラ映像リアルタイム表示サイズ\n  小／大／外付",
        editKind: SpecFileEditKind.selection,
        setting: [
          const SelectionSetting("小", 0),
          const SelectionSetting("大", 1),
          const SelectionSetting("外寸", 2)
        ],
        displayableFunc: _displayableUSBCamCnct
    ),
    const SpecFileDispRow(
      key: specBtnlvl5_51,
      title: "HappySelfフルセルフ 秤接続",
      description: "HappySelfフルセルフ 秤接続\n　しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1)
      ],
    ),
  ];

  /// 設定ファイルを読み込んで、表示項目毎の設定値を取得する
  /// dispRowDataには、非表示項目は含まれない
  @override
  Future<Map<SpecFileDispRow, SettingData>> loadJsonData(List<SpecFileDispRow> dispRowData) async {
    // 表示項目と設定値の組み合わせ
    Map<SpecFileDispRow, SettingData> specSubData = {};

    // MacInfoJsonFileの読み込み
    late Mac_infoJsonFile macInfoJsonFile;
    late RxCommonBuf pCom;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      macInfoJsonFile = Mac_infoJsonFile();
      await macInfoJsonFile.load();
    } else {
      pCom = xRet.object;
      macInfoJsonFile = pCom.iniMacInfo;
    }

    // 表示項目のループ
    for (var data in dispRowData) {
      // 設定ファイルから設定値を取得
      var value = _getJsonData(macInfoJsonFile, data.key);
      specSubData[data] = SettingData(before: value, after: value);
    }

    return specSubData;
  }

  /// 表示項目毎の設定値を、設定ファイルに保存する
  @override
  Future<void> saveJsonData(Map<SpecFileDispRow, SettingData> specSubData) async {
    // 変更前の設定値
    Map<String, dynamic> mapBeforeJsonData = {};

    // MacInfoJsonFileの読み込み
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if(xRet.isInvalid()){
      return;
    }
    RxCommonBuf pCom = xRet.object;
    Mac_infoJsonFile macInfoJsonFile = pCom.iniMacInfo;

    for (var data in specSubData.keys) {
      // 設定ファイルに設定値を設定
      _setJsonData(macInfoJsonFile, data.key, specSubData[data]!.after);
      // 変更前の設定値をmapに保存
      mapBeforeJsonData[data.key] = specSubData[data]!.before;
    }

    // 保存前処理として、先に実行する処理
    _firstProc(macInfoJsonFile, mapBeforeJsonData);
    //　保存前処理として、後で実行する処理
    _secondProc(macInfoJsonFile, mapBeforeJsonData);

    // MacInfoJsonFileへ保存
    await macInfoJsonFile.save();
    if(xRet.isValid()) {
      SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, pCom, RxMemAttn.MAIN_TASK);
    }
  }

  /// 保存前処理として、先に実行する処理
  void _firstProc(Mac_infoJsonFile macInfoJsonFile, Map<String, dynamic> mapBeforeJsonData) {
    // 釣銭釣札機モード変更の変更後の値に応じて釣銭釣札機接続時の入金確定処理の値を変更する処理
    _setAcbDeccin(macInfoJsonFile, mapBeforeJsonData);
  }

  /// 釣銭釣札機モード変更の変更後の値に応じて釣銭釣札機接続時の入金確定処理の値を変更する処理
  /// 釣銭釣札機モード変更の変更後の値が5(入金or自動)なら入金確定処理に1(入金確定)を代入する
  /// 釣銭釣札機モード変更の変更後の値が0以外なら入金確定処理にその0でない値を代入する
  /// ※入金確定処理が非表示等でnullの場合でも連動する状態になっている
  void _setAcbDeccin(Mac_infoJsonFile macInfoJsonFile, Map<String, dynamic> mapBeforeJsonData) {
    // 釣銭釣札機モード変更
    if (mapBeforeJsonData.containsKey(specBtnlvl5_14)) {
      // 釣銭釣札機モード変更の値が変更されていたら
      if (macInfoJsonFile.internal_flg.auto_deccin != mapBeforeJsonData[specBtnlvl5_14]) {
        if (macInfoJsonFile.internal_flg.auto_deccin == 5) {
          macInfoJsonFile.internal_flg.acb_deccin = 1;
        } else if (macInfoJsonFile.internal_flg.auto_deccin != 0) {
          macInfoJsonFile.internal_flg.acb_deccin = macInfoJsonFile.internal_flg.auto_deccin;
        }
      }
    }
  }

  /// 保存前処理として、後で実行する処理
  Future<void> _secondProc(Mac_infoJsonFile macInfoJsonFile, Map<String, dynamic> mapBeforeJsonData) async {
     // 釣銭釣札機接続時の入金確定処理の値に変更があったら、bkup_acb_deccinキーに0を設定する
    _setBkupAcbDeccin(macInfoJsonFile, mapBeforeJsonData);

    // 釣銭釣札機モード変更の値に変更があったら、bkup_auto_deccinキーに0を設定する
    _setBkupAutoDeccin(macInfoJsonFile, mapBeforeJsonData);

    // 自動釣銭釣札機の種類の値に変更があったら、共有メモリとDBの値を再設定する
    await _writeAcbSelect(macInfoJsonFile, mapBeforeJsonData);
  }

  /// 釣銭釣札機接続時の入金確定処理の値に変更があったら、bkup_acb_deccinキーに0を設定する
  void _setBkupAcbDeccin(Mac_infoJsonFile macInfoJsonFile, Map<String, dynamic> mapBeforeJsonData) {
    // 釣銭釣札機接続時の入金確定処理
    if (mapBeforeJsonData.containsKey(specBtnlvl5_3)) {
      // 釣銭釣札機接続時の入金確定処理の値が変更されていたら
      if (macInfoJsonFile.internal_flg.acb_deccin != mapBeforeJsonData[specBtnlvl5_3]) {
        macInfoJsonFile.deccin_bkup.bkup_acb_deccin = 0;
      }
    }
  }

  /// 釣銭釣札機モード変更の値に変更があったら、bkup_auto_deccinキーに0を設定する
  void _setBkupAutoDeccin(Mac_infoJsonFile macInfoJsonFile, Map<String, dynamic> mapBeforeJsonData) {
    // 釣銭釣札機モード変更
    if (mapBeforeJsonData.containsKey(specBtnlvl5_14)) {
      // 釣銭釣札機モード変更の値が変更されていたら
      if (macInfoJsonFile.internal_flg.auto_deccin != mapBeforeJsonData[specBtnlvl5_14]) {
        macInfoJsonFile.deccin_bkup.bkup_auto_deccin = 0;
      }
    }
  }

  /// 自動釣銭釣札機の種類の値に変更があったら、共有メモリとDBの値を再設定する
  Future<void> _writeAcbSelect(Mac_infoJsonFile macInfoJsonFile, Map<String, dynamic> mapBeforeJsonData) async {
    // 自動釣銭釣札機の種類
    if (mapBeforeJsonData.containsKey(specBtnlvl5_7)) {
      // 自動釣銭釣札機の種類の値が変更されていたら
      if (macInfoJsonFile.internal_flg.acb_select != mapBeforeJsonData[specBtnlvl5_7]) {
        if (!(await _writeTrm(macInfoJsonFile.internal_flg.acb_select))) {
          // 関数内で異常が発生した場合、エラーログを出力する
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "_writeTrm() ERROR!");
        }
      }
    }
  }

  /// 保存ボタン押下時に「自動釣銭釣札機の種類」の値が変更されていたら、
  /// 共有メモリとDBの値を再設定する
  /// 戻り値: true=正常終了  false=異常終了
  Future<bool> _writeTrm(int div) async {
    int m10000 = 0;
    int m5000  = 0;
    int m2000  = 0;
    int m1000  = 0;
    int m0500  = 0;
    int m0100  = 0;
    int m0050  = 0;
    int m0010  = 0;
    int m0005  = 0;
    int m0001  = 0;

    // 関数コールのログ
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "writeTrm");

    switch (div) {
      case 0: // ACB-10
        m10000 =   0;
        m5000  = 100;
        m2000  = 100;
        m1000  = 300;
        m0500  =  60;
        m0100  = 100;
        m0050  = 100;
        m0010  = 100;
        m0005  = 100;
        m0001  = 100;
      case 1: // ACB-20
        m10000 =   0;
        m5000  =  30;
        m2000  =  30;
        m1000  = 150;
        m0500  = 100;
        m0100  = 100;
        m0050  = 100;
        m0010  = 100;
        m0005  = 100;
        m0001  = 100;
      case 2: // ACB-50
        m10000 = 100;
        m5000  = 100;
        m2000  = 100;
        m1000  = 200;
        m0500  = 120;
        m0100  = 160;
        m0050  = 160;
        m0010  = 160;
        m0005  = 160;
        m0001  = 160;
      case 3 || 8: // ECS、ECS-777
        m10000 =   0;
        m5000  = 100;
        m2000  =   0;
        m1000  = 250;
        m0500  = 110;
        m0100  = 170;
        m0050  = 160;
        m0010  = 170;
        m0005  = 160;
        m0001  = 170;
      case 4: // N8384
        m10000 =   0;
        m5000  = 100;
        m2000  =   0;
        m1000  = 300;
        m0500  = 105;
        m0100  = 160;
        m0050  = 120;
        m0010  = 160;
        m0005  = 120;
        m0001  = 160;
      case 5 || 7:	// ACB-200、RT-300
        m10000 = 100;
        m5000  = 100;
        m2000  = 100;
        m1000  = 200;
        m0500  = 105;
        m0100  = 160;
        m0050  = 120;
        m0010  = 160;
        m0005  = 120;
        m0001  = 160;
      case 6: // FAL2
        m10000 = 100;
        m5000  = 100;
        m2000  =   0;
        m1000  = 250;
        m0500  = 105;
        m0100  = 160;
        m0050  = 120;
        m0010  = 160;
        m0005  = 120;
        m0001  = 160;
      default:
        m10000 = 100;
        m5000  = 100;
        m2000  = 100;
        m1000  = 200;
        m0500  = 105;
        m0100  = 160;
        m0050  = 120;
        m0010  = 160;
        m0005  = 120;
        m0001  = 160;
    }

    // 共有メモリを取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "_writeTrm() rxMemRead RXMEM_COMMON get error");
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    // 共有メモリにセット
    pCom.dbTrm.acxM10000 = m10000;
    pCom.dbTrm.acxM5000  = m5000;
    pCom.dbTrm.acxM2000  = m2000;
    pCom.dbTrm.acxM1000  = m1000;
    pCom.dbTrm.acxM500   = m0500;
    pCom.dbTrm.acxM100   = m0100;
    pCom.dbTrm.acxM50    = m0050;
    pCom.dbTrm.acxM10    = m0010;
    pCom.dbTrm.acxM5     = m0005;
    pCom.dbTrm.acxM1     = m0001;

    try{
      // DBのインスタンスを取得
      DbManipulationPs db = DbManipulationPs();
      String updateSql = """
        UPDATE c_trm_mst SET trm_data = 
          (CASE 
            WHEN trm_cd = '${TrmCdList.TRMNO_ACX_M_10000.trmCd}' THEN $m10000 
            WHEN trm_cd = '${TrmCdList.TRMNO_ACX_M_5000.trmCd}' THEN $m5000 
            WHEN trm_cd = '${TrmCdList.TRMNO_ACX_M_2000.trmCd}' THEN $m2000 
            WHEN trm_cd = '${TrmCdList.TRMNO_ACX_M_1000.trmCd}' THEN $m1000 
            WHEN trm_cd = '${TrmCdList.TRMNO_ACX_M_500.trmCd}' THEN $m0500 
            WHEN trm_cd = '${TrmCdList.TRMNO_ACX_M_100.trmCd}' THEN $m0100 
            WHEN trm_cd = '${TrmCdList.TRMNO_ACX_M_50.trmCd}' THEN $m0050 
            WHEN trm_cd = '${TrmCdList.TRMNO_ACX_M_10.trmCd}' THEN $m0010 
            WHEN trm_cd = '${TrmCdList.TRMNO_ACX_M_5.trmCd}' THEN $m0005 
            WHEN trm_cd = '${TrmCdList.TRMNO_ACX_M_1.trmCd}' THEN $m0001 
            ELSE trm_data 
          END);
      """;
      // DBに値をセット
      await db.dbCon.execute(updateSql);
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "_writeTrm() : $e,$s");
      return false;
    }
    return true;
  }

  /// 設定ファイルから設定値を取得
  dynamic _getJsonData(Mac_infoJsonFile macInfoJsonFile, String key) {
    switch (key) {
      case specBtnlvl5_1:       // 自動釣銭釣札機接続
        return macInfoJsonFile.internal_flg.acr_cnct;
      case specBtnlvl5_3:       // 釣銭釣札機接続時の入金確定処理
        return macInfoJsonFile.internal_flg.acb_deccin;
      case specBtnlvl5_4:       // カード決済機接続
        return macInfoJsonFile.internal_flg.card_cnct;
      case specBtnlvl5_7:       // 自動釣銭釣札機の種類
        return macInfoJsonFile.internal_flg.acb_select;
      case specBtnlvl5_14:       // 釣銭釣札機モード変更
        return macInfoJsonFile.internal_flg.auto_deccin;
      case specBtnlvl5_21:      // 顧客問い合わせサーバー接続
        return macInfoJsonFile.internal_flg.custrealsvr_cnct;
      case specBtnlvl5_28:      // マルチ端末機接続
        return macInfoJsonFile.internal_flg.multi_cnct;
      case specBtnlvl5_30:       // カラー客表接続
        return macInfoJsonFile.internal_flg.colordsp_cnct;
      case specBtnlvl5_31:       // USBカメラ接続
        return macInfoJsonFile.internal_flg.usbcam_cnct;
      case specBtnlvl5_32:       // 自走式磁気カードリーダー接続
        return macInfoJsonFile.internal_flg.masr_cnct;
      case specBtnlvl5_34:       // マルチ決済端末J-Mups連動
        return macInfoJsonFile.internal_flg.cat_jmups_twin_cnct;
      case specBtnlvl5_38:       // カラー客表サイズ
        return macInfoJsonFile.internal_flg.colordsp_size;
      case specBtnlvl5_39:      // USBカメラ設置方向
        return macInfoJsonFile.internal_flg.usbcam_direction;
      case specBtnlvl5_40:      // USBカメラ映像リアルタイム表示
        return macInfoJsonFile.internal_flg.usbcam_disp;
      case specBtnlvl5_42:       // USBカメラ映像リアルタイム表示サイズ
        return macInfoJsonFile.internal_flg.usbcam_disp_size;
      case specBtnlvl5_51:       // HappySelfフルセルフ 秤接続
        return macInfoJsonFile.internal_flg.hs_scale_cnct;
      default:                  // その他
        throw AssertionError();
    }
  }

  /// 設定ファイルに設定値を設定
  void _setJsonData(Mac_infoJsonFile macInfoJsonFile, String key, dynamic value) {
    switch (key) {
      case specBtnlvl5_1:       // 自動釣銭釣札機接続
        macInfoJsonFile.internal_flg.acr_cnct = value;
      case specBtnlvl5_3:       // 釣銭釣札機接続時の入金確定処理
        macInfoJsonFile.internal_flg.acb_deccin = value;
      case specBtnlvl5_4:       // カード決済機接続
        macInfoJsonFile.internal_flg.card_cnct = value;
      case specBtnlvl5_7:       // 自動釣銭釣札機の種類
        macInfoJsonFile.internal_flg.acb_select = value;
      case specBtnlvl5_14:       // 釣銭釣札機モード変更
        macInfoJsonFile.internal_flg.auto_deccin = value;
      case specBtnlvl5_21:      // 顧客問い合わせサーバー接続
        macInfoJsonFile.internal_flg.custrealsvr_cnct = value;
      case specBtnlvl5_28:      // マルチ端末機接続
        macInfoJsonFile.internal_flg.multi_cnct = value;
      case specBtnlvl5_30:       // カラー客表接続
        macInfoJsonFile.internal_flg.colordsp_cnct = value;
      case specBtnlvl5_31:       // USBカメラ接続
        macInfoJsonFile.internal_flg.usbcam_cnct = value;
      case specBtnlvl5_32:       // 自走式磁気カードリーダー接続
        macInfoJsonFile.internal_flg.masr_cnct = value;
      case specBtnlvl5_34:       // マルチ決済端末J-Mups連動
        macInfoJsonFile.internal_flg.cat_jmups_twin_cnct = value;
      case specBtnlvl5_38:       // カラー客表サイズ
        macInfoJsonFile.internal_flg.colordsp_size = value;
      case specBtnlvl5_39:      // USBカメラ設置方向
        macInfoJsonFile.internal_flg.usbcam_direction = value;
      case specBtnlvl5_40:      // USBカメラ映像リアルタイム表示
        macInfoJsonFile.internal_flg.usbcam_disp = value;
      case specBtnlvl5_42:       // USBカメラ映像リアルタイム表示サイズ
        macInfoJsonFile.internal_flg.usbcam_disp_size = value;
      case specBtnlvl5_51:       // HappySelfフルセルフ 秤接続
        macInfoJsonFile.internal_flg.hs_scale_cnct = value;
      default:                  // その他
        throw AssertionError();
    }
  }

  /// カラー客表接続が表示可能かどうか判定する
  /// true: 表示する　false: 表示しない
  Future<bool> _displayableColorDspCnct() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if(xRet.isInvalid()){
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    SysJsonFile sysJson = pCom.iniSys;

    int webType = await CmCksys.cmWebType();
    int web28Type = CmCksys.cmWeb2800Type(sysJson);
    // WEB機種タイプがWEB2800かつWEB2800の機種タイプがWebPrime3であることを判定
    if ((webType == CmSys.WEBTYPE_WEB2800) && (web28Type == CmSys.WEB28TYPE_PR3)) {
      return false;
      // ＵＳＢディスプレイ(カラー客側表示)に対応しているかを判定
    } else {
      if (CmCksys.cmUsbDispChk() == 0) {
        return false;
      }
    }
    return true;
  }

  /// USBカメラ接続なら表示.
  Future<bool> _displayableUSBCamCnct() async {
    return await CmCksys.cmUsbCamSystem() != 0;
  }

  /// カード決済機/J-Mups併用なら表示.
  Future<bool> _displayableJmupsTwinCnct() async {
    return await CmCksys.cmCatJmupsTwinConnection() != 0;
  }

}
