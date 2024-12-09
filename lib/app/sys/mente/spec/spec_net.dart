/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pos/app/lib/apllib/services_control.dart';
import '../../../common/cls_conf/barcode_payJsonFile.dart';
import '../../../common/cls_conf/custreal_necJsonFile.dart';
import '../../../common/cls_conf/hostsJsonFile.dart';
import '../../../common/cls_conf/sys_paramJsonFile.dart';
import '../../../inc/sys/tpr_log.dart';
import '../../../lib/apllib/netplan_control.dart';
import '../../../lib/apllib/recog.dart';
import '../../../lib/cm_sys/cm_cksys.dart';
import '../../../ui/page/maintenance/specfile/model/m_specfile.dart';
import 'spec_sub_ret.dart';

/// specfileInfo.jsonファイルの項目名と同じものを設定
enum SpecNetItems {
  myIp(SpecFileDispRow(
      title: "IPアドレス",
      description: "ＩＰアドレス\n",
      editKind: SpecFileEditKind.ipAddressInput,
      setting: IpAddressInputSetting())), //IPアドレス
  subNetmask(SpecFileDispRow(
      title: "サブネットマスク",
      description: "サブネットマスク\n",
      editKind: SpecFileEditKind.ipAddressInput,
      setting: IpAddressInputSetting())), //サブネットマスク
  gateWay(SpecFileDispRow(
      title: "ゲートウェイアドレス",
      description: "ゲートウェイアドレス（使用せずは、　０．０．０．０）\n",
      editKind: SpecFileEditKind.ipAddressInput,
      setting: IpAddressInputSetting())), //ゲートウェイアドレス
  serverIp(SpecFileDispRow(
      title: "サーバーIPアドレス",
      description: "サーバーIPアドレス\n",
      editKind: SpecFileEditKind.ipAddressInput,
      setting: IpAddressInputSetting())), //サーバーIPアドレス
  compcIp(SpecFileDispRow(
      title: "通信PCIPアドレス",
      description: "通信PCIPアドレス\n",
      editKind: SpecFileEditKind.ipAddressInput,
      setting: IpAddressInputSetting())), //通信PC IPアドレス
  comPort(SpecFileDispRow(
      title: "通信PCポート",
      description: "通信ＰＣ　ソケット通信ポート番号\n　１～６５５３５　　　　　　　　",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(1, 65535))), //通信PCポート
  compc2Ip(SpecFileDispRow(
      title: "通信PC２　IPアドレス",
      description: "通信ＰＣ２　ＩＰアドレス\n",
      editKind: SpecFileEditKind.ipAddressInput,
      setting: IpAddressInputSetting())), //通信PC2 IPアドレス
  comPort2(SpecFileDispRow(
      title: "通信PC２　ポート",
      description: "通信ＰＣ２　ソケット通信ポート番号\n  １～６５５３５                    ",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(1, 65535))), //通信PC2 ポート
  dns1(SpecFileDispRow(
      title: "DNS（１）",
      description: "ＤＮＳ（１）\n",
      editKind: SpecFileEditKind.ipAddressInput,
      setting: IpAddressInputSetting())), //DNS(1)
  dns2(SpecFileDispRow(
      title: "DNS（２）",
      description: "ＤＮＳ（２）\n",
      editKind: SpecFileEditKind.ipAddressInput,
      setting: IpAddressInputSetting())), //DNS(2)
  timeserverIp(SpecFileDispRow(
      title: "タイムサーバーIPアドレス",
      description: "タイムサーバー  ＩＰアドレス\n",
      editKind: SpecFileEditKind.ipAddressInput,
      setting: IpAddressInputSetting())), //タイムサーバー IPアドレス
  spqcIp(SpecFileDispRow(
      title: "お会計券管理IPアドレス",
      description: "お会計券管理　ＩＰアドレス\n",
      editKind: SpecFileEditKind.ipAddressInput,
      setting: IpAddressInputSetting())), //お会計券管理 IPアドレス
  verupIp(SpecFileDispRow(
      title: "バージョンアップファイル取得先IPアドレス",
      description: "バージョンアップファイル取得先  ＩＰアドレス\n",
      editKind: SpecFileEditKind.ipAddressInput,
      setting: IpAddressInputSetting())), //バージョンアップファイル取得先 IPアドレス
  cunstrealUrl(SpecFileDispRow(
      title: "リアル顧客(NEC)接続　接続先URL（全店共通）",
      description: "リアル顧客(NEC)接続  接続先ＵＲＬ\n",
      editKind: SpecFileEditKind.stringInput,
      setting: StringInputSetting(0, 110))), //リアル顧客(NEC)接続　接続先URL（全店共通）
  cunstrealTimeout(SpecFileDispRow(
      title: "リアル顧客問合せ　受信タイムアウト秒数",
      description:
          "リアル顧客(NEC)接続  受信タイムアウト秒\n  １～９９９                            ",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(1, 999))), //リアル顧客問合せ　受信タイムアウト秒数
  cunstrealOpenretrycnt(SpecFileDispRow(
      title: "リアル顧客(NEC)接続　リトライ回数",
      description: "リアル顧客(NEC)接続  接続リトライ回数\n０～９、０：接続なし                  ",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(0, 9))), //リアル顧客(NEC)接続　リトライ回数
  canalTimeout(SpecFileDispRow(
      title: "CANALPayment　timeアウト秒",
      description: "CANALPayment タイムアウト秒\n　１～９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(1, 99))), //CANALPayment　timeアウト秒
  canalCompanycode(SpecFileDispRow(
      title: "CANALPayment　企業コード",
      description: "CANALPayment 企業コード\n",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(1, 99))), //CANALPayment　企業コード
  canalBranchcode(SpecFileDispRow(
      title: "CANALPayment　店舗コード",
      description: "CANALPayment 店舗コード\n",
      editKind: SpecFileEditKind.stringInput,
      setting: StringInputSetting(0, 32))), //CANALPayment　店舗コード
  canalMerchanId(SpecFileDispRow(
      title: "CANALPayment　マーチャントID",
      description: "CANALPayment マーチャントID\n",
      editKind: SpecFileEditKind.stringInput,
      setting: StringInputSetting(0, 12))), //CANALPayment　マーチャントID
  canalUrl(SpecFileDispRow(
      title: "CANALPayment　URL",
      description: "CANALPayment 問い合わせURL\n",
      editKind: SpecFileEditKind.stringInput,
      setting: StringInputSetting(0, 110))), //CANALPayment　URL
  pbchg1Ip(SpecFileDispRow(
      title: "収納代行サーバーPrimary　IPアドレス",
      description: "収納サーバー(Primary)　ＩＰアドレス\n",
      editKind: SpecFileEditKind.ipAddressInput,
      setting: IpAddressInputSetting())), //収納代行サーバーPrimary IPアドレス
  pbchg1Port(SpecFileDispRow(
      title: "収納代行サーバーPrimary　ポート番号",
      description: "収納サーバー(Primary)  ポート番号\n  １～６５５３５                 ",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(1, 65535))), //収納代行サーバーPrimary ポート
  pbchg2Ip(SpecFileDispRow(
      title: "収納代行サーバーSecondary　IPアドレス",
      description: "収納サーバー(Secondary)　ＩＰアドレス\n",
      editKind: SpecFileEditKind.ipAddressInput,
      setting: IpAddressInputSetting())), //収納代行サーバーSecondary IPアドレス
  pbchg2Port(SpecFileDispRow(
      title: "収納代行サーバーSecondary　ポート番号",
      description: "収納サーバー(Primary)  ポート番号\n  １～６５５３５                 ",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(1, 65535))), //収納代行サーバーSecondary ポート
  tsServerUrl(SpecFileDispRow(
      title: "TSサーバー接続　接続先URL",
      description: "TSサーバー接続  接続先ＵＲＬ\n",
      editKind: SpecFileEditKind.stringInput,
      setting: StringInputSetting(0, 110))); //TSサーバー接続　接続先URL

  final SpecFileDispRow dispRow;

  const SpecNetItems(this.dispRow);

  /// keyJsonからenumを取得する.
  /// 一致するものがなければnullを返す
  static SpecNetItems? getDefine(SpecFileDispRow keyJson) {
    SpecNetItems? define =
        SpecNetItems.values.firstWhereOrNull((a) => a.dispRow == keyJson);
    return define;
  }
}

/// フロントからのデータ取得用のクラス
class SpecNetWorkData {
  final SpecNetItems specKey;
  final String specVal;

  SpecNetWorkData(this.specKey, this.specVal);
}

/// 関連tprxソース: specNET.c
class SpecNet {
  /// データに変更があるかどうかのフラグ.
  int dataChanged = 0;

  /// データに変更があるかどうか
  /// 変更があった場合にtrue.
  bool existChangeData() {
    return dataChanged != 0;
  }

  /// ネットワーク画面が保持する比較用の情報
  Map<SpecNetItems, dynamic> netWorkDataDef = {};

  /// 初期表示 各データ読み込み
  /// 各項目の表示データ欄に記載されているファイルから条件に合った情報を取得する。
  ///  関連tprxソース: specNET.c
  @override
  Future<SpecSubRet> initialize() async {
    SpecSubRet initRet = SpecSubRet();
    //　各ファイルから情報を取得
    // hostsファイル
    try {
      late HostsJsonFile hostsFile;
      hostsFile = HostsJsonFile();
      await hostsFile.load();

      netWorkDataDef[SpecNetItems.myIp] = hostsFile.hosts1.IpAddress; //IPアドレス
      if (netWorkDataDef[SpecNetItems.myIp].isEmpty) {
        netWorkDataDef[SpecNetItems.myIp] = "0.0.0.0";
      }
      netWorkDataDef[SpecNetItems.serverIp] =
          hostsFile.hosts2.IpAddress; //サーバーIPアドレス
      if (netWorkDataDef[SpecNetItems.serverIp].isEmpty) {
        netWorkDataDef[SpecNetItems.serverIp] = "0.0.0.0";
      }
      netWorkDataDef[SpecNetItems.compcIp] =
          hostsFile.hosts6.IpAddress; //通信PCIPアドレス
      if (netWorkDataDef[SpecNetItems.compcIp].isEmpty) {
        netWorkDataDef[SpecNetItems.compcIp] = "0.0.0.0";
      }
      netWorkDataDef[SpecNetItems.compc2Ip] =
          hostsFile.hosts31.IpAddress; //通信PC2IPアドレス
      if (netWorkDataDef[SpecNetItems.compc2Ip].isEmpty) {
        netWorkDataDef[SpecNetItems.compc2Ip] = "0.0.0.0";
      }
      netWorkDataDef[SpecNetItems.timeserverIp] =
          hostsFile.hosts24.IpAddress; //タイムサーバーIPアドレス
      if (netWorkDataDef[SpecNetItems.timeserverIp].isEmpty) {
        netWorkDataDef[SpecNetItems.timeserverIp] = "0.0.0.0";
      }
      netWorkDataDef[SpecNetItems.spqcIp] =
          hostsFile.hosts32.IpAddress; //お会計券管理IPアドレス
      if (netWorkDataDef[SpecNetItems.spqcIp].isEmpty) {
        netWorkDataDef[SpecNetItems.spqcIp] = "0.0.0.0";
      }
      netWorkDataDef[SpecNetItems.verupIp] =
          hostsFile.hosts41.IpAddress; //バージョンアップファイル取得先IPアドレス
      if (netWorkDataDef[SpecNetItems.verupIp].isEmpty) {
        netWorkDataDef[SpecNetItems.verupIp] = "0.0.0.0";
      }
      netWorkDataDef[SpecNetItems.pbchg1Ip] =
          hostsFile.hosts29.IpAddress; //収納代行サーバーPrimaryIPアドレス
      if (netWorkDataDef[SpecNetItems.pbchg1Ip].isEmpty) {
        netWorkDataDef[SpecNetItems.pbchg1Ip] = "0.0.0.0";
      }
      netWorkDataDef[SpecNetItems.pbchg2Ip] =
          hostsFile.hosts30.IpAddress; //収納代行サーバーSecondaryIPアドレス
      if (netWorkDataDef[SpecNetItems.pbchg2Ip].isEmpty) {
        netWorkDataDef[SpecNetItems.pbchg2Ip] = "0.0.0.0";
      }
    } catch (e, s) {
      // エラー処理
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "initialize() loadHost(NG),$e,$s");
      initRet.retFlg = false;
      return initRet;
    }

    //NetPlanControl クラス
    try {
      NetPlanControl netPlanControl = NetPlanControl();

      String interfaceName;
      if (Platform.isLinux) {
        interfaceName = (await netPlanControl.getEthernetName())!;
        if (interfaceName == null) {
          interfaceName = NetPlanControl.defaultInterfaceName;
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.warning,
              "Ethernetsの名前を取得失敗, デフォルトAPI　'$interfaceName' を使用します");
        }
      } else {
        interfaceName = NetPlanControl.defaultInterfaceName;
      }

      //インタフェース設定取得
      Map<String, dynamic>? interfaceConfig =
          await netPlanControl.getInterfaceConfig(interfaceName);
      debugPrint(interfaceName);
      if (interfaceConfig == null) {
        throw Exception('$interfaceName　のネットワーク構成を取得できません');
      }
      //IPアドレスを設定
      String? ipAddress = interfaceConfig['addresses']?[0]?.split('/')?.first;
      netWorkDataDef[SpecNetItems.myIp] = ipAddress ?? "0.0.0.0";

      //サブネットマスクを設定
      //CIDRをを取得し、サブネットマスクに変換
      String? subnetMaskCidr =
          interfaceConfig['addresses']?[0]?.split('/')?.last;
      String? subnetMask;

      if (subnetMaskCidr != null) {
        try {
          subnetMask =
              netPlanControl.cidrToSubnetMask(int.parse(subnetMaskCidr));
        } catch (e) {
          subnetMask = "0.0.0.0";
          // エラー処理
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
              "subnetMaskサブネットマスクの変換失敗 (CIDR: $subnetMaskCidr):  $e");
        }
      } else {
        subnetMask = "0.0.0.0";
      }
      netWorkDataDef[SpecNetItems.subNetmask] = subnetMask;

      //ゲートウェイを設定
      String? gateway = interfaceConfig['routes'][0]['via'];
      netWorkDataDef[SpecNetItems.gateWay] = gateway ?? "0.0.0.0";
    } catch (e, s) {
      // エラー処理
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "initialize() NetPlanControl(NG),$e,$s");
      initRet.retFlg = false;
      return initRet;
    }
    //servicesファイル
    try {
      var servicesControl = ServicesControl();
      //新しいservicesデータを追加
      if (servicesControl.isLinux) {
        await servicesControl.appendNewServices();
      }
      //　servicesファイル解析し、　更新されたデータを取得
      var servicesData = await servicesControl.parseServicesFile();

      //　特定のservicesファイルのポート番号を取得
      String comPort =
          servicesControl.getPortNumber(servicesData, 'comport', '6200');
      String comPort2 =
          servicesControl.getPortNumber(servicesData, 'comport2', '0');
      String pbchg1Port =
          servicesControl.getPortNumber(servicesData, 'pbchg1port', '8210');
      String pbchg2Port =
          servicesControl.getPortNumber(servicesData, 'pbchg2port', '8210');

      netWorkDataDef[SpecNetItems.comPort] = comPort;
      netWorkDataDef[SpecNetItems.comPort2] = comPort2;
      netWorkDataDef[SpecNetItems.pbchg1Port] = pbchg1Port;
      netWorkDataDef[SpecNetItems.pbchg2Port] = pbchg2Port;
    } catch (e, s) {
      // エラー処理
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "initialize() ServicesControl(NG),$e,$s");
      initRet.retFlg = false;
      return initRet;
    }

    //DNSの設定は　etc/netplan/99_config.yamlへ変更
    //DNS(1)(2)
    try {
      NetPlanControl netPlanControl = NetPlanControl();
      String interfaceName;
      if (Platform.isLinux) {
        String? fetchedInterfaceName = await netPlanControl.getEthernetName();
        if (fetchedInterfaceName == null) {
          interfaceName = NetPlanControl.defaultInterfaceName;
          TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.warning,
              "Ethernetsの名前取得失敗、デフォルトAPI'$interfaceName'を使用する");
        } else {
          interfaceName = fetchedInterfaceName;
        }
      } else {
        interfaceName = NetPlanControl.defaultInterfaceName;
      }

      //インタフェース設定取得
      Map<String, dynamic>? interfaceConfig =
          await netPlanControl.getInterfaceConfig(interfaceName);
      if (interfaceConfig == null) {
        throw Exception('$interfaceName のネットワーク構成を取得失敗');
      }

      //DNSアドレス設定
      List<String> dnsAddress =
          interfaceConfig['nameservers']['addresses']?.cast<String>() ?? [];
      netWorkDataDef[SpecNetItems.dns1] =
          dnsAddress.isNotEmpty ? dnsAddress[0] : "0.0.0.0";
      netWorkDataDef[SpecNetItems.dns2] =
          dnsAddress.length > 1 ? dnsAddress[1] : "0.0.0.0";
    } catch (e, s) {
      // エラー処理
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "initialize() NetPlanControl(NG),$e,$s");
      initRet.retFlg = false;
      return initRet;
    }

    // custreal_nec.json
    // リアル顧客
    try {
      late Custreal_necJsonFile custrealNec;
      custrealNec = Custreal_necJsonFile();
      await custrealNec.load();
      netWorkDataDef[SpecNetItems.cunstrealUrl] = custrealNec.nec.url;
      netWorkDataDef[SpecNetItems.cunstrealTimeout] =
          custrealNec.custrealsvr.timeout;
      netWorkDataDef[SpecNetItems.cunstrealOpenretrycnt] =
          custrealNec.custrealsvr.openretrycnt;
    } catch (e, s) {
      // エラー処理
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "initialize() loadCustreal_nec(NG),$e,$s");
      initRet.retFlg = false;
      return initRet;
    }
    // barcode_pay.json
    // CANAL
    try {
      late Barcode_payJsonFile barcodePay;
      barcodePay = Barcode_payJsonFile();
      await barcodePay.load();
      netWorkDataDef[SpecNetItems.canalTimeout] =
          barcodePay.canalpayment.timeout;
      netWorkDataDef[SpecNetItems.canalCompanycode] =
          barcodePay.canalpayment.company_code;
      netWorkDataDef[SpecNetItems.canalBranchcode] =
          barcodePay.canalpayment.branch_code;
      netWorkDataDef[SpecNetItems.canalMerchanId] =
          barcodePay.canalpayment.merchantId;
      netWorkDataDef[SpecNetItems.canalUrl] = barcodePay.canalpayment.url;
    } catch (e, s) {
      /// エラー処理
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "initialize() loadBarcode_pay(NG),$e,$s");
      initRet.retFlg = false;
      return initRet;
    }
    // sys_param.json
    // TSサーバー
    try {
      late Sys_paramJsonFile sysParamFiles;
      sysParamFiles = Sys_paramJsonFile();
      await sysParamFiles.load();
      netWorkDataDef[SpecNetItems.tsServerUrl] = sysParamFiles.server.url;
      netWorkDataDef[SpecNetItems.cunstrealTimeout] =
          sysParamFiles.custrealsvr.timeout;
    } catch (e, s) {
      // エラー処理
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "initialize() loadSys_param(NG),$e,$s");
      initRet.retFlg = false;
      return initRet;
    }
    await _displayJudg();
    return initRet;
  }

  /// 表示条件があるものについては各チェックを行い、非表示にするものは[netWorkDataDef]から削除する
  Future<void> _displayJudg() async {
    //マシンタイプ取得
    int mmType = CmCksys.cmMmType();
    int macM1 = 2;
    int macMOnly = 3;

    //通信PC2　IPアドレス＆ポート
    if (await CmCksys.cmCapsPqvicSystem() != 0) {
      //CAPS(P-QVIC)接続仕様か判定
      //IPアドレス非表示、ポート表示
      netWorkDataDef.remove(SpecNetItems.compc2Ip);
    } else if (await CmCksys.cmNttaspSystem() == 0 //NTTASP仕様か判定
        &&
        await CmCksys.cmCapsPqvicSystem() == 0) {
      //どちらも非表示
      netWorkDataDef.remove(SpecNetItems.compc2Ip);
      netWorkDataDef.remove(SpecNetItems.comPort2);
    }
    //リアル顧客(NEC)接続　接続先URL（全店共通）＆受信タイムアウト秒数＆リトライ回数
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
                RecogLists.RECOG_CUSTREAL_NEC, RecogTypes.RECOG_GETMEM))
            .result ==
        RecogValue.RECOG_NO) {
      //承認キーが無効の場合
      //すべて非表示
      netWorkDataDef.remove(SpecNetItems.cunstrealUrl);
      netWorkDataDef.remove(SpecNetItems.cunstrealTimeout);
      netWorkDataDef.remove(SpecNetItems.cunstrealOpenretrycnt);
    }
    //CANALPayment timeアウト秒＆企業コード＆店舗コード＆マーチャンID＆URL
    if (await CmCksys.cmCanalPaymentServiceSystem() == 0) {
      //ｺｰﾄﾞ決済[CANALPay]仕様判定
      //すべて非表示
      netWorkDataDef.remove(SpecNetItems.canalTimeout);
      netWorkDataDef.remove(SpecNetItems.canalCompanycode);
      netWorkDataDef.remove(SpecNetItems.canalBranchcode);
      netWorkDataDef.remove(SpecNetItems.canalMerchanId);
      netWorkDataDef.remove(SpecNetItems.canalUrl);
    }
    // 収納代行サーバーPrimary＆Secondary　IPアドレス＆ポート
    if ((await CmCksys.cmPbchgSystem() == 0) && /* 収納代行仕様 */
        (((mmType != macM1) && (mmType != macMOnly)) ||
            (await CmCksys.cmPbchgTsSystem() == 0))) {
      //収納代行仕様ではないかつマシンのタイプが2,3以外またはTS接続の収納業務が無効の場合
      //すべて非表示
      netWorkDataDef.remove(SpecNetItems.pbchg1Ip);
      netWorkDataDef.remove(SpecNetItems.pbchg1Port);
      netWorkDataDef.remove(SpecNetItems.pbchg2Ip);
      netWorkDataDef.remove(SpecNetItems.pbchg2Port);
    }
    //TSサーバー接続　接続先URL ＆受信タイムアウト秒数＆リトライ回数
    if ((await Recog().recogGet(Tpraid.TPRAID_SYSTEM,
                RecogLists.RECOG_CUSTREAL_NEC, RecogTypes.RECOG_GETMEM))
            .result ==
        RecogValue.RECOG_NO) {
      //承認キーが無効の場合
      //すべて非表示
      netWorkDataDef.remove(SpecNetItems.tsServerUrl);
      netWorkDataDef.remove(SpecNetItems.cunstrealTimeout);
    }
  }

  /// 決定ボタン押下
  /// 注意：inputClicked(int idx, String afterEdited)の1番目のパラメータidxの値は、
  /// 当コンパイル環境で決められたint型の最大ビット数を超えてはいけない
  SpecSubRet inputClicked(SpecNetWorkData data) {
    SpecSubRet inputClickedRet = SpecSubRet();
    if (netWorkDataDef[data.specKey].toString() != data.specVal) {
      // データが最初jsonファイルから読み込んだ値と異なる
      dataChanged = dataChanged | 1 << data.specKey.index;
    } else {
      // データが最初jsonファイルから読み込んだ値と一致する
      dataChanged = dataChanged & (dataChanged ^ (1 << data.specKey.index));
      if (0 == dataChanged) {
        inputClickedRet.retFlg = false;
      }
    }
    return inputClickedRet;
  }

  /// 保存ボタン押下
  Future<SpecSubRet> saveSettingFile(List<SpecNetWorkData> newValues) async {
    SpecSubRet setJsonRet = SpecSubRet();
    List<Future> futures = [];
    // 画面全項目に変更がない場合、処理終了
    if (0 == dataChanged) return setJsonRet;
    Map<SpecNetItems, dynamic> netWorkDataNew = {};
    // ループ文でフロント側から受け取った画面項目値値をMAPに入れる
    newValues.forEach((val) {
      netWorkDataNew[val.specKey] = val.specVal;
    });

    // ファイル関連処理のプロセスフラグ
    try {
      //ラベルに表示されている値と初期表示時のMapの値を比較
      if (!mapEquals(netWorkDataDef, netWorkDataNew)) {
        HostsJsonFile hostsFile = HostsJsonFile();
        await hostsFile.load();
        NetPlanControl netPlanControl = NetPlanControl();
        await netPlanControl.readNetPlan();
        ServicesControl servicesControl = ServicesControl();
        await servicesControl.parseServicesFile();
        Custreal_necJsonFile custrealNec = Custreal_necJsonFile();
        await custrealNec.load();
        Barcode_payJsonFile barcodePay = Barcode_payJsonFile();
        await barcodePay.load();
        Sys_paramJsonFile sysParamFiles = Sys_paramJsonFile();
        await sysParamFiles.load();
        for (var key in netWorkDataNew.keys) {
          switch (key) {
            case SpecNetItems.myIp:
              hostsFile.hosts1.IpAddress = netWorkDataNew[key];
              String newIPAddress = netWorkDataNew[key];

              String? interfaceName = await netPlanControl.getEthernetName();
              if (interfaceName == null) {
                debugPrint("Ethernetsネーム取得失敗、IPアドレス更新失敗");
                setJsonRet.retFlg = false;
                continue;
              }
              bool updateIPResult = await netPlanControl.updateIPAddress(
                  interfaceName, newIPAddress);
              if (!updateIPResult) {
                debugPrint("IpAddresses更新失敗");
                setJsonRet.retFlg = false;
              }
              break;
            case SpecNetItems.subNetmask:
              String newSubNetmask = netWorkDataNew[key];

              String? interfaceName = await netPlanControl.getEthernetName();
              if (interfaceName == null) {
                debugPrint("Ethernetsネーム取得失敗、subNetmask更新失敗");
                setJsonRet.retFlg = false;
                continue;
              }
              bool updatesubNetmaskResult = await netPlanControl
                  .updateSubnetmask(interfaceName, newSubNetmask);
              if (!updatesubNetmaskResult) {
                debugPrint("subNetmask更新失敗");
                setJsonRet.retFlg = false;
              }
              break;
            case SpecNetItems.gateWay:
              String newGateWay = netWorkDataNew[key];

              String? interfaceName = await netPlanControl.getEthernetName();
              if (interfaceName == null) {
                debugPrint("Ethernetsネーム取得失敗、gateWay");
                setJsonRet.retFlg = false;
                continue;
              }
              bool updateGateWayResult =
                  await netPlanControl.updateGateway(interfaceName, newGateWay);
              if (!updateGateWayResult) {
                debugPrint("gateWay更新失敗");
                setJsonRet.retFlg = false;
              }
              break;
            case SpecNetItems.serverIp:
              hostsFile.hosts2.IpAddress = netWorkDataNew[key];
              break;
            case SpecNetItems.compcIp:
              hostsFile.hosts6.IpAddress = netWorkDataNew[key];
              break;
            case SpecNetItems.comPort:
              String newComPort = netWorkDataNew[key];
              bool updateResult =
                  await servicesControl.updatePortNumber('comport', newComPort);

              if (!updateResult) {
                debugPrint('comport 更新失敗');
                setJsonRet.retFlg = false;
              } else {
                netWorkDataNew[key] = newComPort;
              }
              break;
            case SpecNetItems.compc2Ip:
              hostsFile.hosts31.IpAddress = netWorkDataNew[key];
              break;
            case SpecNetItems.comPort2:
              String newComPort2 = netWorkDataNew[key];
              bool updateResult = await servicesControl.updatePortNumber(
                  'comport2', newComPort2);

              if (!updateResult) {
                debugPrint('comport2 更新失敗');
                setJsonRet.retFlg = false;
              } else {
                netWorkDataNew[key] = newComPort2;
              }
              break;
            case SpecNetItems.dns1:
            case SpecNetItems.dns2:
              List<String> newDNSAddresses = [];
              if (netWorkDataNew[SpecNetItems.dns1] != "0.0.0.0") {
                newDNSAddresses.add(netWorkDataNew[SpecNetItems.dns1] as String);
              }
              if (netWorkDataNew[SpecNetItems.dns2] != "0.0.0.0") {
                newDNSAddresses.add(netWorkDataNew[SpecNetItems.dns2] as String);
              }

              String? interfaceName = await netPlanControl.getEthernetName();
              if (interfaceName == null) {
                debugPrint('Ethernet interfaceName　取得出来ません、DNS更新できません');
                setJsonRet.retFlg = false;
                continue;
              }
              bool dnsUpdateResult = await netPlanControl.updateDNS(
                  interfaceName, newDNSAddresses);
              if (!dnsUpdateResult) {
                debugPrint('DNS更新に失敗しました');
                setJsonRet.retFlg = false;
              }
              break;
            case SpecNetItems.timeserverIp:
              hostsFile.hosts24.IpAddress = netWorkDataNew[key];
              break;
            case SpecNetItems.spqcIp:
              hostsFile.hosts32.IpAddress = netWorkDataNew[key];
              break;
            case SpecNetItems.verupIp:
              hostsFile.hosts41.IpAddress = netWorkDataNew[key];
              break;
            case SpecNetItems.cunstrealUrl:
              custrealNec.nec.url = netWorkDataNew[key];
              break;
            case SpecNetItems.cunstrealTimeout:
              custrealNec.custrealsvr.timeout = int.parse(netWorkDataNew[key]);
              break;
            case SpecNetItems.cunstrealOpenretrycnt:
              custrealNec.custrealsvr.openretrycnt =
                  int.parse(netWorkDataNew[key]);
              break;
            case SpecNetItems.canalTimeout:
              barcodePay.canalpayment.timeout = int.parse(netWorkDataNew[key]);
              break;
            case SpecNetItems.canalCompanycode:
              barcodePay.canalpayment.company_code =
                  int.parse(netWorkDataNew[key]);
              break;
            case SpecNetItems.canalBranchcode:
              barcodePay.canalpayment.branch_code = netWorkDataNew[key];
              break;
            case SpecNetItems.canalMerchanId:
              barcodePay.canalpayment.merchantId = netWorkDataNew[key];
              break;
            case SpecNetItems.canalUrl:
              barcodePay.canalpayment.url = netWorkDataNew[key];
              break;
            case SpecNetItems.pbchg1Ip:
              hostsFile.hosts29.IpAddress = netWorkDataNew[key];
              break;
            case SpecNetItems.pbchg1Port:
              String pbchg1Port = netWorkDataNew[key];
              bool updateResult = await servicesControl.updatePortNumber(
                  'pbchg1Port', pbchg1Port);

              if (!updateResult) {
                debugPrint('pbchg1Port 更新失敗');
                setJsonRet.retFlg = false;
              } else {
                netWorkDataNew[key] = pbchg1Port;
              }
              break;

            case SpecNetItems.pbchg2Ip:
              hostsFile.hosts30.IpAddress = netWorkDataNew[key];
              break;
            case SpecNetItems.pbchg2Port:
              String pbchg2Port = netWorkDataNew[key];
              bool updateResult = await servicesControl.updatePortNumber(
                  'pbchg2Port', pbchg2Port);

              if (!updateResult) {
                debugPrint('pbchg2Port 更新失敗');
                setJsonRet.retFlg = false;
              } else {
                netWorkDataNew[key] = pbchg2Port;
              }
              break;
            case SpecNetItems.tsServerUrl:
              sysParamFiles.server.url = netWorkDataNew[key];
              break;
            default:
              TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.warning,
                  "setJsonClicked() no set file. key:${netWorkDataNew.keys} value:${netWorkDataNew.keys}");
          }
        }
        await hostsFile.save();
        await custrealNec.save();
        await barcodePay.save();
        await sysParamFiles.save();
      }
    } catch (e, s) {
      // ファイル読み取り中エラー発生
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "setJsonClicked() loadFile(NG),$e,$s");
      setJsonRet.retFlg = false;
      return setJsonRet;
    } finally {
      await Future.wait(futures);
    }

    // 変更されている値がある場合は、対象のファイルに変更されている値に更新
    // jsonファイル更新成功、バックエンド側で保持される値も更新
    if (!mapEquals(netWorkDataDef, netWorkDataNew)) {
      netWorkDataDef[SpecNetItems.myIp] = netWorkDataNew[SpecNetItems.myIp];
      netWorkDataDef[SpecNetItems.subNetmask] =
          netWorkDataNew[SpecNetItems.subNetmask];
      netWorkDataDef[SpecNetItems.gateWay] =
          netWorkDataNew[SpecNetItems.gateWay];
      netWorkDataDef[SpecNetItems.serverIp] =
          netWorkDataNew[SpecNetItems.serverIp];
      netWorkDataDef[SpecNetItems.compcIp] =
          netWorkDataNew[SpecNetItems.compcIp];
      netWorkDataDef[SpecNetItems.comPort] =
          netWorkDataNew[SpecNetItems.comPort];
      netWorkDataDef[SpecNetItems.compc2Ip] =
          netWorkDataNew[SpecNetItems.compc2Ip];
      netWorkDataDef[SpecNetItems.comPort2] =
          netWorkDataNew[SpecNetItems.comPort2];
      netWorkDataDef[SpecNetItems.dns1] = netWorkDataNew[SpecNetItems.dns1];
      netWorkDataDef[SpecNetItems.dns2] = netWorkDataNew[SpecNetItems.dns2];
      netWorkDataDef[SpecNetItems.timeserverIp] =
          netWorkDataNew[SpecNetItems.timeserverIp];
      netWorkDataDef[SpecNetItems.spqcIp] = netWorkDataNew[SpecNetItems.spqcIp];
      netWorkDataDef[SpecNetItems.verupIp] =
          netWorkDataNew[SpecNetItems.verupIp];
      netWorkDataDef[SpecNetItems.cunstrealUrl] =
          netWorkDataNew[SpecNetItems.cunstrealUrl];
      netWorkDataDef[SpecNetItems.cunstrealTimeout] =
          netWorkDataNew[SpecNetItems.cunstrealTimeout];
      netWorkDataDef[SpecNetItems.cunstrealOpenretrycnt] =
          netWorkDataNew[SpecNetItems.cunstrealOpenretrycnt];
      netWorkDataDef[SpecNetItems.canalTimeout] =
          netWorkDataNew[SpecNetItems.canalTimeout];
      netWorkDataDef[SpecNetItems.canalCompanycode] =
          netWorkDataNew[SpecNetItems.canalCompanycode];
      netWorkDataDef[SpecNetItems.canalBranchcode] =
          netWorkDataNew[SpecNetItems.canalBranchcode];
      netWorkDataDef[SpecNetItems.canalMerchanId] =
          netWorkDataNew[SpecNetItems.canalMerchanId];
      netWorkDataDef[SpecNetItems.canalUrl] =
          netWorkDataNew[SpecNetItems.canalUrl];
      netWorkDataDef[SpecNetItems.pbchg1Ip] =
          netWorkDataNew[SpecNetItems.pbchg1Ip];
      netWorkDataDef[SpecNetItems.pbchg1Port] =
          netWorkDataNew[SpecNetItems.pbchg1Port];
      netWorkDataDef[SpecNetItems.pbchg2Ip] =
          netWorkDataNew[SpecNetItems.pbchg2Ip];
      netWorkDataDef[SpecNetItems.pbchg2Port] =
          netWorkDataNew[SpecNetItems.pbchg2Port];
      netWorkDataDef[SpecNetItems.tsServerUrl] =
          netWorkDataNew[SpecNetItems.tsServerUrl];
    }
    dataChanged = 0;
    return setJsonRet;
  }
}
