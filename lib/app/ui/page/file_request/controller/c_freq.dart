/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../../../clxos/calc_api.dart';
import '../../../../../clxos/calc_api_data.dart';
import '../../../../../clxos/calc_api_result_data.dart';
import '../../../../common/cls_conf/counterJsonFile.dart';
import '../../../../common/cls_conf/mac_infoJsonFile.dart';
import '../../../../inc/sys/tpr_log.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../sys/usetup/freq/freq.dart';
import '../../../../sys/usetup/freq/freq_tbl.dart';
/// ファイルリクエストのコントローラー
class FileRequestPageController extends GetxController {


 final pageTitle = "".obs;

  final dispData = <FReqGroupData>[].obs;
  int dspPage = 0;

  List<FReqPageData> pageData = [];
  final Rx<bool> allSelectFlg = false.obs;
  final Rx<String> execStatus = "".obs;



  @override
  void onInit() async {
    super.onInit();
    await Freq.init();
    await  Freq.freqSet();
    Freq.freqDispPage(0);
  }

}
class FReqPageData{
  List<FReqGroupData> groupList = [];
  FReqPageData();
}

class FReqGroupData{
 // List<FReqDispData> dataList= [];
  final BtDataTbl btData;
 List<TDataTbl> tableData = [];
  String  get name => btData.labelName;
  FReqGroupData(this.btData);
}