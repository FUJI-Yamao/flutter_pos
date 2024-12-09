/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';

//import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/common/cls_conf/counterJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/speezaJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/sysJsonFile.dart';
import 'package:flutter_pos/app/common/date_util.dart';
import 'package:flutter_pos/app/ui/language/l_languagedbcall.dart';
import 'package:flutter_pos/app/ui/page/test/test_setup/p_fcl_setup_download.dart';
import 'package:flutter_pos/app/ui/page/test/test_setup/p_fcl_setup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';

import '../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../common/cls_conf/mac_infoJsonFile.dart';
import '../../../common/cmn_sysfunc.dart';
import '../../../inc/apl/fnc_code.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../lib/apllib/rm_db_read.dart';
import '../../../lib/apllib/rm_ini_read.dart';
import '../../../regs/checker/rcstllcd.dart';
import '../../../regs/checker/regs.dart';
import '../../../sys/stropncls/rmstcls.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_sound_buttons.dart';
import '../../enum/e_presetcd.dart';
import '../../socket/server/semiself_socket_server.dart';
import '../common/component/w_msgdialog.dart';
import 'test_page2/test_page_contorller/test_page_controller.dart';

/// 動作テストをするための設定やテストを行うページ
// TODO:10130 テストコード(リリース前削除)
class TestSettingPage extends StatefulWidget {
  const TestSettingPage({super.key});



  @override
  State<TestSettingPage> createState() => _TestSettingPageState();
}

class _TestSettingPageState extends State<TestSettingPage> {
  ///コンストラクタ
  String saleDateStr = "";
  TestPageController ctrl = Get.put(TestPageController());
  RxCommonBuf pCom = RxCommonBuf();
  RxInt ralseMagFmt = 0.obs;

  @override
  void initState() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    pCom = xRet.object;
    saleDateStr = pCom.iniCounter.tran.sale_date;
    ralseMagFmt.value = pCom.dbTrm.ralseMagFmt;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('現在設定されている営業日:$saleDateStr'),
                SizedBox(
                  height: 10.h,
                ),
                Obx(() => Text(
                    'QUICPay日計処理状況:${ctrl.nowStatusQP.value}',
                    style: const TextStyle(
                      fontSize: 15,))),
                Obx(() => Text(
                    'iD日計処理状況:${ctrl.nowStatusiD.value}',
                    style: const TextStyle(
                      fontSize: 15,))),

                SoundElevatedButton(
                  onPressed: () => _settingSaleDate(),
                  callFunc: runtimeType.toString(),
                  child: const Text(
                    "営業日を今日にする",
                    style: TextStyle(fontSize: BaseFont.font20px),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SoundElevatedButton(
                  onPressed: () => _resetSaleDate(),
                  callFunc: runtimeType.toString(),
                  child: const Text(
                    "営業日をリセットする",
                    style: TextStyle(fontSize: BaseFont.font20px),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SoundElevatedButton(
                  onPressed: () => _settingQuicPayAndID(),
                  callFunc: runtimeType.toString(),
                  child: const Text(
                    "QUICPay、iD確認用設定",
                    style: TextStyle(fontSize: BaseFont.font20px),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SoundElevatedButton(
                  onPressed: () => _quicPayDailyEnd(),
                  callFunc: runtimeType.toString(),
                  child: const Text(
                    "QUICPay日計",
                    style: TextStyle(fontSize: BaseFont.font20px),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SoundElevatedButton(
                  onPressed: () => _iDDailyEnd(),
                  callFunc: runtimeType.toString(),
                  child: const Text(
                    "iD日計",
                    style: TextStyle(fontSize: BaseFont.font20px),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SoundElevatedButton(
                  onPressed: () => _multiTidSetup(),
                  callFunc: runtimeType.toString(),
                  child: const Text(
                    "端末セットアップ通信",
                    style: TextStyle(fontSize: BaseFont.font20px),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SoundElevatedButton(
                  onPressed: () => _multiTidSetupDownload(),
                  callFunc: runtimeType.toString(),
                  child: const Text(
                    "端末設定情報ダウンロード",
                    style: TextStyle(fontSize: BaseFont.font20px),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SoundElevatedButton(
                  onPressed: () => _settingTicketData(),
                  callFunc: runtimeType.toString(),
                  child: const Text(
                    "テスト用商品券設定",
                    style: TextStyle(fontSize: BaseFont.font20px),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SoundElevatedButton(
                  onPressed: () => _settingNormal(),
                  callFunc: runtimeType.toString(),
                  child: Text(
                    '通常レジで起動する'.trns,
                    style: const TextStyle(fontSize: BaseFont.font20px),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SoundElevatedButton(
                  onPressed: () => _settingSemiSelf(),
                  callFunc: runtimeType.toString(),
                  child: const Text(
                    "セミセルフ（登録機）設定",
                    style: TextStyle(fontSize: BaseFont.font20px),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SoundElevatedButton(
                  onPressed: () => _settingFullSelf(),
                  callFunc: runtimeType.toString(),
                  child: const Text(
                    "フルセルフ／セミセルフ（精算機）設定",
                    style: TextStyle(fontSize: BaseFont.font20px),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SoundElevatedButton(
                  onPressed: () => _settingQcSelect(),
                  callFunc: runtimeType.toString(),
                  child: const Text(
                    "QC指定設定（preset/reginfo/speeza）",
                    style: TextStyle(fontSize: BaseFont.font20px),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SoundElevatedButton(
                  onPressed: () => _setRalseCard(),
                  callFunc: runtimeType.toString(),
                  child:
                  Obx(() => Text(
                    'RALSEカード設定(ralseMagFmt)現在値:${ralseMagFmt.value}',
                    style: const TextStyle(fontSize: BaseFont.font20px),
                  )),
                 ),
                SizedBox(
                  height: 10.h,
                ),
                SoundElevatedButton(
                  onPressed: () => _tempSettingJson(),
                  callFunc: runtimeType.toString(),
                  child: Text(
                    'アークス様用設定'.trns,
                    style: const TextStyle(fontSize: BaseFont.font20px),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SoundElevatedButton(
                  onPressed: () => _vegaDeviceSettingJson(),
                  callFunc: runtimeType.toString(),
                  child: Text(
                    'カード決済機接続種別設定：VEGA'.trns,
                    style: const TextStyle(fontSize: BaseFont.font20px),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SoundElevatedButton(
                  onPressed: () => _initVegaDeviceSettingJson(),
                  callFunc: runtimeType.toString(),
                  child: Text(
                    'カード決済機接続種別設定：初期化(0)'.trns,
                    style: const TextStyle(fontSize: BaseFont.font20px),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SoundElevatedButton(
                  onPressed: () => Get.back(),
                  callFunc: runtimeType.toString(),
                  child: Text(
                    'l_cmn_back'.trns,
                    style: const TextStyle(fontSize: BaseFont.font20px),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  /// 営業日を今日にする
  Future<void> _settingSaleDate() async {
    try {
      RmIniRead read = RmIniRead();

      String saleDate = DateUtil.getNowStrJpn(DateUtil.formatDate);
      //  設定ファイルに日付をセット
      CounterJsonFile counter = CounterJsonFile();
      await counter.load();
      counter.tran.sale_date = saleDate;
      await counter.save();
      await read.rmIniCounterRead();
      // --
      DbManipulationPs db = DbManipulationPs();

      /* 従業員オープン情報マスタ取得：レジ番号に対応したチェッカー状態を取得する。 */
      String sqlStaffOpen =
          "select * from c_staffopen_mst where mac_no = ${pCom.iniMacInfoMacNo} \n";
      Result result = await db.dbCon.execute(sqlStaffOpen);
      if (result.isEmpty) {
        String sql =
            "INSERT INTO public.c_staffopen_mst (comp_cd, stre_cd, mac_no, cshr_status) VALUES (@comp_cd, @stre_cd, @mac_no, 1);";
        Map<String, dynamic>? subValues = {
          "comp_cd": pCom.iniMacInfoCrpNoNo,
          "stre_cd": pCom.iniMacInfoShopNo,
          "mac_no": pCom.iniMacInfoMacNo
        };
        await db.dbCon.execute(Sql.named(sql), parameters: subValues);
        await RmDBRead().rmDbStaffopenRead();
      }

      String openSql =
          "select open_flg, close_flg from c_openclose_mst where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and sale_date = @saleDate";
      Map<String, dynamic>? subValues = {
        "comp": pCom.dbRegCtrl.compCd,
        "stre": pCom.dbRegCtrl.streCd,
        "mac": pCom.dbRegCtrl.macNo,
        "saleDate": saleDate
      };
      Result dataList =
      await db.dbCon.execute(Sql.named(openSql), parameters: subValues);
      if (dataList.isEmpty) {
        String sql =
            "INSERT INTO public.c_openclose_mst (comp_cd, stre_cd, mac_no, sale_date,open_flg) VALUES (@comp_cd, @stre_cd, @mac_no, @sale_date,1);";
        Map<String, dynamic>? subValues = {
          "comp_cd": pCom.iniMacInfoCrpNoNo,
          "stre_cd": pCom.iniMacInfoShopNo,
          "mac_no": pCom.iniMacInfoMacNo,
          "sale_date": saleDate
        };
        await db.dbCon.execute(Sql.named(sql), parameters: subValues);
      } else {
        String sql =
            "update public.c_openclose_mst  set open_flg =1 , close_flg = 0 where comp_cd = @comp_cd and stre_cd = @stre_cd and mac_no = @mac_no and sale_date = @sale_date;";
        Map<String, dynamic>? subValues = {
          "comp_cd": pCom.iniMacInfoCrpNoNo,
          "stre_cd": pCom.iniMacInfoShopNo,
          "mac_no": pCom.iniMacInfoMacNo,
          "sale_date": saleDate
        };
        await db.dbCon.execute(Sql.named(sql), parameters: subValues);
      }
      await RmDBRead().rmDbOpenCloseRead();
      /* 従業員オープン情報マスタ取得：レジ番号に対応したチェッカー状態を取得する。 */
      String sqlRegCounter =
          "select * from p_regcounter_log where mac_no = ${pCom.iniMacInfoMacNo} \n";
      Result resultRegCounter = await db.dbCon.execute(sqlRegCounter);
      if (resultRegCounter.isNotEmpty) {
        String sql = "update p_regcounter_log set sale_date = @sale_date;";
        Map<String, dynamic>? subValues = {"sale_date": saleDate};
        await db.dbCon.execute(Sql.named(sql), parameters: subValues);
      } else {
        // String sql = "INSERT INTO p_regcounter_log(comp_cd, stre_cd, mac_no, sale_date, cnt_json_data) VALUES (@comp_cd, @stre_cd, @mac_no, @sale_date, '{"print_no": 12,"receipt_no": 14,"rcpt_print_no": 3}')";
        // Map<String, dynamic>? subValues = {"comp_cd" : pCom.iniMacInfoCrpNoNo,"stre_cd" : pCom.iniMacInfoShopNo,"mac_no" :  pCom.iniMacInfoMacNo,"sale_date":saleDate};
        // await db.dbCon.execute(Sql.named(sql),parameters:subValues);
      }
      String sqlRegInfo =
          "select * from c_reginfo_mst where mac_no = ${pCom.iniMacInfoMacNo} \n";
      Result resultRegInfo = await db.dbCon.execute(sqlRegInfo);
      if (resultRegInfo.isEmpty) {
        String sql =
            "INSERT INTO public.c_reginfo_mst(comp_cd, stre_cd, mac_no, mac_typ) VALUES (@comp_cd, @stre_cd, @mac_no, 1);";
        Map<String, dynamic>? subValues = {
          "comp_cd": pCom.iniMacInfoCrpNoNo,
          "stre_cd": pCom.iniMacInfoShopNo,
          "mac_no": pCom.iniMacInfoMacNo
        };
        await db.dbCon.execute(Sql.named(sql), parameters: subValues);
        RmDBRead().rmDbRegInfoRead();
      }
      setState(() {
        saleDateStr = saleDate;
      });
    } catch (e) {
      setState(() {
        saleDateStr = e.toString();
      });
    }
  }

  /// 営業日をなしにする
  Future<void> _resetSaleDate() async {
    try {
      RmIniRead read = RmIniRead();

      ///  設定ファイルの日付をリセット
      String resetDate = "0000-00-00";
      //  設定ファイルに日付をセット
      CounterJsonFile counter = CounterJsonFile();
      await counter.load();
      counter.tran.sale_date = resetDate;
      counter.save().then((value) => read.rmIniCounterRead());

     // String sql = "update p_regcounter_log set sale_date = @sale_date;";
      // Map<String, dynamic>? subValues = {"sale_date" :resetDate};
      // await db.dbCon.execute(Sql.named(sql),parameters:subValues);
      //
      // String  openSql = "select open_flg, close_flg from c_openclose_mst where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and sale_date = @saleDate";
      // Map<String, dynamic>? subValues = {
      //   "comp"     : pCom.dbRegCtrl.compCd,
      //   "stre"     : pCom.dbRegCtrl.streCd,
      //   "mac"      : pCom.dbRegCtrl.macNo,
      //   "saleDate" : resetDate
      // };
      // Result dataList = await db.dbCon.execute(Sql.named(openSql), parameters: subValues);
      // if (dataList.isNotEmpty) {
      //   String sql = "update public.c_openclose_mst  set open_flg =0 , close_flg = 1 where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and sale_date = @saleDate;";
      //   Map<String, dynamic>? subValues = {"comp_cd" : pCom.iniMacInfoCrpNoNo,"stre_cd" : pCom.iniMacInfoShopNo,"mac_no" :  pCom.iniMacInfoMacNo, "sale_date" : resetDate};
      //   await db.dbCon.execute(Sql.named(sql),parameters:subValues);
      //   await  RmDBRead().rmDbStropnclsRead();
      // }

      setState(() {
        saleDateStr = resetDate;
      });
    } catch (e) {
      setState(() {
        saleDateStr = e.toString();
      });
    }
  }

  /// クイックペイ、IDを使用するためのセットアップ
  Future<void> _settingQuicPayAndID() async {
    RmIniRead read = RmIniRead();
    _settingSaleDate();
    //  設定ファイルにUT1の設定をセット
    Mac_infoJsonFile macInfo = Mac_infoJsonFile();
    await macInfo.load();
    macInfo.internal_flg.multi_cnct = 3;
    macInfo.select_self.qc_mode = 0;
    macInfo.save().then((value) => read.rmIniMacinfoRead());

    try {
      // kyoptの更新
      DbManipulationPs db = DbManipulationPs();
      String sql1 =
          "Update c_keyopt_mst set kopt_data=0  where fnc_cd=22 and kopt_cd=6;";
      Result result1 = await db.dbCon.execute(sql1);
      sql1 =
      "Update c_keyopt_mst set kopt_data=1  where fnc_cd=22 and kopt_cd=10;";
      result1 = await db.dbCon.execute(sql1);
      sql1 =
      "Update c_keyopt_mst set kopt_data=19 where fnc_cd=22 and kopt_cd=11;";
      result1 = await db.dbCon.execute(sql1);
      sql1 =
      "Update c_keyopt_mst set kopt_data=0  where fnc_cd=22 and kopt_cd=14;";
      result1 = await db.dbCon.execute(sql1);
      await RmDBRead().rmDbKeyFncRead();

      sql1 =
      "UPDATE c_recoginfo_mst SET emergency_type = '330300000000000000' WHERE page = 1";
      result1 = await db.dbCon.execute(sql1);
      sql1 =
      "UPDATE c_recoginfo_mst SET emergency_type = '000000000030000000' WHERE page = 2";
      result1 = await db.dbCon.execute(sql1);
      sql1 =
      "UPDATE c_recoginfo_mst SET emergency_type = '000000000330000000' WHERE page = 8";
      result1 = await db.dbCon.execute(sql1);
      sql1 = "update c_trm_mst set trm_data = 1 where trm_cd = 1324";
      result1 = await db.dbCon.execute(sql1);
    } catch (e) {
      setState(() {
        saleDateStr = e.toString();
      });
    }

    try {
      // kyoptの更新
      DbManipulationPs db = DbManipulationPs();
      String sql1 =
          "create table c_header_log_past ( ) inherits (c_header_log);";
      Result result1 = await db.dbCon.execute(sql1);
      sql1 = "create table c_data_log_past ( ) inherits (c_data_log);";
      result1 = await db.dbCon.execute(sql1);
      sql1 = "create table c_status_log_past ( ) inherits (c_status_log);";
      result1 = await db.dbCon.execute(sql1);
      sql1 = "create table c_ej_log_past ( ) inherits (c_ej_log);";
      result1 = await db.dbCon.execute(sql1);
      await RmDBRead().rmDbKeyFncRead();
    } catch (e, s) {
      // 2回目の実行以降はエラーになるので何もしない.
    }
    MsgDialog.show(MsgDialog.singleButtonMsg(
      type: MsgDialogType.info,
      message: "実行しました",
    ));

  }

  /// クイックペイの日計処理を実行する関数.(仮)
  Future<void> _quicPayDailyEnd() async {
    await Rmstcls.execProcOpt7();
    MsgDialog.show(MsgDialog.singleButtonMsg(
      type: MsgDialogType.info,
      message:"QUICPayの日計処理を実行しました",
    ));

  }

  /// iDの日計処理を実行する関数.(仮)
  Future<void> _iDDailyEnd() async {
    await Rmstcls.execProcOpt9();
    MsgDialog.show(MsgDialog.singleButtonMsg(
      type: MsgDialogType.info,
      message:"iDの日計処理を実行しました",
    ));

  }

  /// 端末セットアップ通信画面を呼び出す
  void _multiTidSetup() {

    // 端末セットアップ通信画面へ遷移
    Get.to(() => const FclSetupPage());
  }
  /// 端末設定情報ダウンロード画面を呼び出す
  void _multiTidSetupDownload() {

    // 端末設定情報ダウンロード画面へ遷移
    Get.to(() => const FclSetupDownloadPage());
  }

  /// 商品券を使用するためのセットアップ
  Future<void> _settingTicketData() async {
    try {
      DbManipulationPs db = DbManipulationPs();

      // 設定値 それぞれ文字列で設定すること
      String crdtEnbleFlg;  // 掛売登録  0:しない 1:する
      String frcEntryFlg;   // 預り金額の置数強制  0:しない 1:する 2:確定処理 3:券面のみ
      String mulFlg;        // 乗算登録  0:禁止 1:有効
      String chkAmt;        // 券面金額
      String nochgFlg;      // 釣り銭支払  0:あり 1:なし 2:確認表示 3:使用不可

      // 品券1
      crdtEnbleFlg = '0';
      frcEntryFlg = '1';
      mulFlg = '0';
      chkAmt = '0';
      nochgFlg = '0';
      await _setTicketData(db, FuncKey.KY_CHK1.keyId.toString(), crdtEnbleFlg, frcEntryFlg, mulFlg, chkAmt, nochgFlg);

      // 品券2
      crdtEnbleFlg = '0';
      frcEntryFlg = '1';
      mulFlg = '1';
      chkAmt = '0';
      nochgFlg = '1';
      await _setTicketData(db, FuncKey.KY_CHK2.keyId.toString(), crdtEnbleFlg, frcEntryFlg, mulFlg, chkAmt, nochgFlg);

      // 品券3
      crdtEnbleFlg = '0';
      frcEntryFlg = '1';
      mulFlg = '1';
      chkAmt = '500';
      nochgFlg = '0';
      await _setTicketData(db, FuncKey.KY_CHK3.keyId.toString(), crdtEnbleFlg, frcEntryFlg, mulFlg, chkAmt, nochgFlg);

      // 品券４
      crdtEnbleFlg = '0';
      frcEntryFlg = '3';
      mulFlg = '1';
      chkAmt = '500';
      nochgFlg = '1';
      await _setTicketData(db, FuncKey.KY_CHK4.keyId.toString(), crdtEnbleFlg, frcEntryFlg, mulFlg, chkAmt, nochgFlg);

      // 品券5
      crdtEnbleFlg = '0';
      frcEntryFlg = '3';
      mulFlg = '0';
      chkAmt = '500';
      nochgFlg = '0';
      await _setTicketData(db, FuncKey.KY_CHK5.keyId.toString(), crdtEnbleFlg, frcEntryFlg, mulFlg, chkAmt, nochgFlg);

      // todo 動作確認用に一時的に品券6を使用可能にするためなので必要な時に以下の設定値をtrueにして実行してください
      bool isTicket6Enabled = false;
      if (isTicket6Enabled) {
        try {
          String sql1 =
          "insert into c_preset_mst (comp_cd, stre_cd, preset_grp_cd, preset_cd, preset_no, presetcolor, ky_cd,"
              "ky_status, ky_name, upd_datetime) "
              "VALUES(1, '10310', 1, ${PresetCd.giftVoucher.value}, 6, 212, ${FuncKey.KY_CHA30.keyId.toString()},"
              "20, '品券6', 'now')"
              "on conflict(comp_cd, stre_cd, preset_grp_cd, preset_cd, preset_no) "
              "do update set ky_cd=${FuncKey.KY_CHA30.keyId.toString()}, ky_name='品券6', upd_datetime='now'";
          await db.dbCon.execute(sql1);
        } catch (e) {
          debugPrint("ticket6 regist error = ${e.toString()}");
        }

        // 品券6
        crdtEnbleFlg = '0';
        frcEntryFlg = '0';
        mulFlg = '0';
        chkAmt = '0';
        nochgFlg = '1';
        await _setTicketData(db, FuncKey.KY_CHA30.keyId.toString(), crdtEnbleFlg, frcEntryFlg, mulFlg, chkAmt, nochgFlg);

      }
      await _settingTicketDataKeyfnc();
      await RmDBRead().rmDbKeyFncRead();
    } catch (e) {
      debugPrint("e=${e.toString()}");
    }

    MsgDialog.show(MsgDialog.singleButtonMsg(
      type: MsgDialogType.info,
      message: "実行しました",
    ));
  }

  /// c_keyfnc_mstのfnc_nameに品券1～品券5を設定する
  Future<void> _settingTicketDataKeyfnc() async {
    try {
      final giftCertificateList = await _loadGiftCertificateData();

      DbManipulationPs db = DbManipulationPs();
      int index = 0;
      for(PresetInfo info in giftCertificateList) {
        String sql1 = "UPDATE c_keyfnc_mst SET fnc_name='${info.kyName}', upd_datetime='now' WHERE fnc_cd=${(26+index).toString()};";
        await db.dbCon.execute(sql1);
        index++;
      }
    } catch (e) {
      debugPrint("e=${e.toString()}");
    }

  }

  /// 商品券リストデータ取得
  Future<List<PresetInfo>> _loadGiftCertificateData() async {
    var allPresets = await RegistInitData.getPresetData();
    var filteredPresets = allPresets
        .where((item) => item.presetCd == PresetCd.giftVoucher.value && item.kyCd != 0)
        .toList();
    final giftCertificateList = <PresetInfo>[];
    giftCertificateList.assignAll(filteredPresets);
    return giftCertificateList;
  }

  /// 商品券データを設定する
  Future<void> _setTicketData(DbManipulationPs db, String fncCd, String crdtEnbleFlg, String frcEntryFlg, String mulFlg, String chkAmt, String nochgFlg) async {
    try {
      // kyoptの更新
      String sql1 = "UPDATE c_keyopt_mst SET kopt_data=$crdtEnbleFlg, upd_datetime='now' WHERE fnc_cd=29 AND kopt_cd=10;";
      await db.dbCon.execute(sql1);
      sql1 = "UPDATE c_keyopt_mst SET kopt_data=$frcEntryFlg, upd_datetime='now' WHERE fnc_cd=$fncCd AND kopt_cd=6;";
      await db.dbCon.execute(sql1);
      sql1 = "UPDATE c_keyopt_mst SET kopt_data=$mulFlg, upd_datetime='now' WHERE fnc_cd=$fncCd AND kopt_cd=7;";
      await db.dbCon.execute(sql1);
      sql1 = "UPDATE c_keyopt_mst SET kopt_data=$chkAmt, upd_datetime='now' WHERE fnc_cd=$fncCd AND kopt_cd=14;";
      await db.dbCon.execute(sql1);
      sql1 = "UPDATE c_keyopt_mst SET kopt_data=$nochgFlg, upd_datetime='now' WHERE fnc_cd=$fncCd AND kopt_cd=15;";
      await db.dbCon.execute(sql1);
    } catch(e) {
      debugPrint("_setTicketData error = ${e.toString()}");
    }
  }
  Future<void> _settingNormal() async {
    pCom.iniSys.type.receipt_qr_system = "no";
    pCom.iniSys.type.qcashier_system   = "no";
    pCom.iniSys.type.happyself_system  = "no";
    await pCom.iniSys.save();
    pCom.iniMacInfo.select_self.kpi_hs_mode = 0;
    pCom.iniMacInfo.select_self.qc_mode = 0;
    await pCom.iniMacInfo.save();
  }
  Future<void> _settingSemiSelf() async {
    pCom.iniSys.type.receipt_qr_system = "yes";
    pCom.iniSys.type.qcashier_system   = "no";
    pCom.iniSys.type.happyself_system  = "no";
    await pCom.iniSys.save();
    pCom.iniMacInfo.select_self.kpi_hs_mode = 0;
    await pCom.iniMacInfo.save();

  }
  Future<void> _settingFullSelf() async {
  //pCom.iniSys.type.receipt_qr_system = "yes";
    pCom.iniSys.type.qcashier_system   = "yes";
    pCom.iniSys.type.happyself_system  = "yes";
    await pCom.iniSys.save();
  }
  Future<void> _settingQcSelect() async {
    DbManipulationPs db = DbManipulationPs();
    String sql = "";
    // プリセットマスタ（KY_QCSELECT:QC指定）の追加
    sql = "delete from c_preset_mst where preset_grp_cd=1 and preset_no=354;";
    await db.dbCon.execute(sql);
    sql = "delete from c_preset_mst where preset_grp_cd=1 and preset_no=356;";
    await db.dbCon.execute(sql);
    sql = "delete from c_preset_mst where preset_grp_cd=1 and preset_no=357;";
    await db.dbCon.execute(sql);
    sql = "insert into c_preset_mst (comp_cd,stre_cd,preset_grp_cd,preset_cd,preset_no,presetcolor,ky_cd,ky_plu_cd,ky_smlcls_cd,ky_size_flg,ky_status,ky_name,img_num,ins_datetime,upd_datetime,status,send_flg,upd_user,upd_system) values (${pCom.iniMacInfo.system.crpno},${pCom.iniMacInfo.system.shpno},1,20201,354,212,354,0,0,1,20,'QC指定1',0,now(),now(),0,0,999999,2);";
    await db.dbCon.execute(sql);
    sql = "insert into c_preset_mst (comp_cd,stre_cd,preset_grp_cd,preset_cd,preset_no,presetcolor,ky_cd,ky_plu_cd,ky_smlcls_cd,ky_size_flg,ky_status,ky_name,img_num,ins_datetime,upd_datetime,status,send_flg,upd_user,upd_system) values (${pCom.iniMacInfo.system.crpno},${pCom.iniMacInfo.system.shpno},1,20201,356,212,356,0,0,1,20,'QC指定2',0,now(),now(),0,0,999999,2);";
    await db.dbCon.execute(sql);
    sql = "insert into c_preset_mst (comp_cd,stre_cd,preset_grp_cd,preset_cd,preset_no,presetcolor,ky_cd,ky_plu_cd,ky_smlcls_cd,ky_size_flg,ky_status,ky_name,img_num,ins_datetime,upd_datetime,status,send_flg,upd_user,upd_system) values (${pCom.iniMacInfo.system.crpno},${pCom.iniMacInfo.system.shpno},1,20201,357,212,357,0,0,1,20,'QC指定3',0,now(),now(),0,0,999999,2);";
    await db.dbCon.execute(sql);
    // 精算機登録
    sql = "delete from c_reginfo_mst where mac_no=41;";
    await db.dbCon.execute(sql);
    sql = "delete from c_reginfo_mst where mac_no=42;";
    await db.dbCon.execute(sql);
    sql = "delete from c_reginfo_mst where mac_no=43;";
    await db.dbCon.execute(sql);
    String ipAddr = await SemiSelfSocketServer.localhostSetting();
    sql = "select * from c_reginfo_mst where comp_cd=${pCom.iniMacInfo.system.crpno} and stre_cd=${pCom.iniMacInfo.system.shpno} and mac_no=${pCom.iniMacInfo.system.macno};";
    Result sel = await db.dbCon.execute(sql);
    if (!sel.isEmpty) {
      sql = "update c_reginfo_mst set auto_opn_cshr_cd=999999 where comp_cd=${pCom.iniMacInfo.system.crpno} and stre_cd=${pCom.iniMacInfo.system.shpno} and mac_no=${pCom.iniMacInfo.system.macno};";
    } else {
      sql = "insert into c_reginfo_mst (comp_cd,stre_cd,mac_no,mac_typ,mac_addr,ip_addr,brdcast_addr,ip_addr2,brdcast_addr2,org_mac_no,crdt_trm_cd,set_owner_flg,mac_role1,mac_role2,mac_role3,pbchg_flg,auto_opn_cshr_cd,auto_opn_chkr_cd,auto_cls_cshr_cd,start_datetime,end_datetime,ins_datetime,upd_datetime,status,send_flg,upd_user,upd_system,mac_name) values (${pCom.iniMacInfo.system.crpno},${pCom.iniMacInfo.system.shpno},${pCom.iniMacInfo.system.macno},102,'00:1F:F2:23:12:14','${ipAddr}' ,'10.2.80.255' ,'','',0,0,0,0,0,0,0,999999,0,999999,now(),now(),now(),now(),1,0,999999,1,0);";
    }
    await db.dbCon.execute(sql);
    sql = "insert into c_reginfo_mst (comp_cd,stre_cd,mac_no,mac_typ,mac_addr,ip_addr,brdcast_addr,ip_addr2,brdcast_addr2,org_mac_no,crdt_trm_cd,set_owner_flg,mac_role1,mac_role2,mac_role3,pbchg_flg,auto_opn_cshr_cd,auto_opn_chkr_cd,auto_cls_cshr_cd,start_datetime,end_datetime,ins_datetime,upd_datetime,status,send_flg,upd_user,upd_system,mac_name) values (${pCom.iniMacInfo.system.crpno},${pCom.iniMacInfo.system.shpno},41,102,'00:1F:F2:23:12:14','${ipAddr}' ,'10.2.80.255' ,'','',0,0,0,0,0,0,0,999999,0,999999,now(),now(),now(),now(),1,0,999999,1,0);";
    await db.dbCon.execute(sql);
    sql = "insert into c_reginfo_mst (comp_cd,stre_cd,mac_no,mac_typ,mac_addr,ip_addr,brdcast_addr,ip_addr2,brdcast_addr2,org_mac_no,crdt_trm_cd,set_owner_flg,mac_role1,mac_role2,mac_role3,pbchg_flg,auto_opn_cshr_cd,auto_opn_chkr_cd,auto_cls_cshr_cd,start_datetime,end_datetime,ins_datetime,upd_datetime,status,send_flg,upd_user,upd_system,mac_name) values (${pCom.iniMacInfo.system.crpno},${pCom.iniMacInfo.system.shpno},42,102,'00:1F:F2:23:12:14','10.2.81.117','10.2.81.255' ,'','',0,0,0,0,0,0,0,999999,0,999999,now(),now(),now(),now(),1,0,999999,1,0);";
    await db.dbCon.execute(sql);
    sql = "insert into c_reginfo_mst (comp_cd,stre_cd,mac_no,mac_typ,mac_addr,ip_addr,brdcast_addr,ip_addr2,brdcast_addr2,org_mac_no,crdt_trm_cd,set_owner_flg,mac_role1,mac_role2,mac_role3,pbchg_flg,auto_opn_cshr_cd,auto_opn_chkr_cd,auto_cls_cshr_cd,start_datetime,end_datetime,ins_datetime,upd_datetime,status,send_flg,upd_user,upd_system,mac_name) values (${pCom.iniMacInfo.system.crpno},${pCom.iniMacInfo.system.shpno},43,102,'00:1F:F2:23:12:14','10.2.81.118' ,'10.2.81.255' ,'','',0,0,0,0,0,0,0,999999,0,999999,now(),now(),now(),now(),1,0,999999,1,0);";
    await db.dbCon.execute(sql);
    // Speeza.json設定
    SpeezaJsonFile speeza = SpeezaJsonFile();
    await speeza.load();
    speeza.QcSelect.ConMacNo1 = 41;
    speeza.QcSelect.ConMacName1 = "MyPC";
    speeza.QcSelect.ConMacNo2 = 42;
    speeza.QcSelect.ConMacName2 = "117";
    speeza.QcSelect.ConMacNo3 = 43;
    speeza.QcSelect.ConMacName3 = "118";
    await speeza.save();
  }

  /// RALSEカードの有効無効を設定する
  /// ラルズ（RALSE）は札幌を中心に道央圏で74店舗を展開するスーパーマーケット（アークスグループのグループ企業）
  Future<void> _setRalseCard() async {
    try {
      DbManipulationPs db = DbManipulationPs();
      String sql = "update c_trm_mst set trm_data=SET_VALUE where comp_cd=${pCom.iniMacInfo.system.crpno} and stre_cd=${pCom.iniMacInfo.system.shpno} and trm_grp_cd=1 and trm_cd=344;";
      if (pCom.dbTrm.ralseMagFmt == 0) {
        sql = sql.replaceAll("SET_VALUE", "1");
      } else {
        sql = sql.replaceAll("SET_VALUE", "0");
      }
      await db.dbCon.execute(sql);
      await RmDBRead().rmDbReadStage1();
      ralseMagFmt.value = pCom.dbTrm.ralseMagFmt;
    } catch(e) {
      debugPrint("_setRalseCard error = ${e.toString()}");
    }
  }

  // 対応要件まとめ_20221130に従い、sys.jsonファイルを編集する。
  // 設定画面などで適切に編集できるようになったらこのAPIは削除する。
  Future<void> _tempSettingJson() async {
    SysJsonFile sysIni = SysJsonFile();
    await sysIni.load();
    // 共通
    sysIni.type.membersystem = "yes";                 // 顧客ポイント仕様
    sysIni.type.creditsystem = "yes";                 // クレジット仕様
    sysIni.type.disc_barcode = "yes";                 // 値引バーコード仕様
    sysIni.type.clothes_barcode = "yes";              // 衣料バーコード仕様
    sysIni.type.ntt_asp = "yes";                      // Pastel Port接続仕様
    sysIni.type.nttd_preca = "yes";                   // Pastel Portプリカ仕様
    sysIni.type.custreal_nec = "yes";                 // 顧客リアル [NEC] 仕様
    sysIni.type.canal_payment_service_system = "yes"; // コード決済 [CANALPay] 仕様
    sysIni.type.ut1qpsystem = "yes";                  // QUICPay仕様 [UT1]
    sysIni.type.ut1idsystem = "yes";                  // iD仕様 [UT1]
    // レジタイプによって設定
  //sysIni.type.qcashier_system = "yes";               // Qcachier仕様
  //sysIni.type.receipt_qr_system = "yes";            // レシートQRコード仕様
  //sysIni.type.happyself_system = "yes";             // HappySelf仕様
  //sysIni.type.pbchg_system = "yes";                 // 収納代行仕様
  //sysIni.type.shop_and_go_system = "yes";           // Shop＆Go仕様
    // お店によって設定
    sysIni.type.prod_item_autoset = "yes";           // 生産者商品登録時作成
    //sysIni.type.sm53_itochanin_system = "yes";     // 特定SM53仕様
    //sysIni.type.sm41_bellejois_sytem = "yes";      // 特定SM41仕様
    await sysIni.save();
  }

  //カード決済機接続種別をVEGAに設定する
  Future<void> _vegaDeviceSettingJson() async {
    Mac_infoJsonFile macInfo = Mac_infoJsonFile();
    await macInfo.load();
    macInfo.internal_flg.gcat_cnct = 19;
    macInfo.save();

    MsgDialog.show(MsgDialog.singleButtonMsg(
      type: MsgDialogType.info,
      message: "実行しました",
    ));
  }

  //カード決済機接続種別を初期化(0)する
  Future<void> _initVegaDeviceSettingJson() async {
    Mac_infoJsonFile macInfo = Mac_infoJsonFile();
    await macInfo.load();
    macInfo.internal_flg.gcat_cnct = 0;
    macInfo.save();

    MsgDialog.show(MsgDialog.singleButtonMsg(
      type: MsgDialogType.info,
      message: "実行しました",
    ));
  }
}
