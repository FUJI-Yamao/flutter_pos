/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../postgres_library/src/basic_table_access.dart';
import '../../../postgres_library/src/sale_table_access.dart';
import '../../regs/checker/rc_lastcomm.dart';
import '../../regs/checker/regs.dart';
import '../../ui/page/register/controller/c_registerbody_controller.dart';
import '../db/c_bdllog.dart';
import '../db/c_bdllog_sts.dart';
import '../db/c_crdt_actual_log.dart';
import '../db/c_crdt_actual_log_sts.dart';
import '../db/c_ttllog.dart';
import '../db/c_ttllog_sts.dart';
import 'rx_cnt_list.dart';
import 'rxmem_barcode_pay.dart';
import 'rxmem_calc.dart';
import 'rxmem_tax.dart';
import 'rxmem_tmp.dart';
import 'rxmemcogca.dart';
import 'rxmemprn.dart';
import 'rxmemsptend.dart';
import 't_item_log.dart';

///
/// 複数のライブラリやソースで共通で使用する定義.
/// 関連tprxソース:rxregmem.h
///

/// 関連tprxソース:rxregmem.h t_bdllog
class TbdlLog {
  T200000 t200000 = T200000();
  T200000Sts t200000Sts = T200000Sts();
}
//
// typedef struct
// {
// t_300000	t300000;
// t_300000_sts	t300000Sts;
// } t_stmlog;

/// ログ定義_クレジット
/// 関連tprxソース:rxregmem.h t_crdtlog
class TCrdtLog {
  late T400000 t400000 = T400000();
  late T400000Sts t400000Sts = T400000Sts();
}

/// ログ定義クラス
/// 関連tprxソース:rxregmem.h t_ttllog
class TTtlLog {
  T1000 t1000 = T1000();
  T100001 t100001 = T100001();
  T100002 t100002 = T100002();
  T100003 t100003 = T100003();
  T100004 t100004 = T100004();
  T100010 t100010 = T100010();
  T100011 t100011 = T100011();
  T100012 t100012 = T100012();
  T100013 t100013 = T100013();
  T100014 t100014 = T100014();
  T100015 t100015 = T100015();
  T100016 t100016 = T100016();
  T100017 t100017 = T100017();
  T100018 t100018 = T100018();
  T100019 t100019 = T100019();

  List<T100100> t100100 = List.generate(CntList.sptendMax,(_) => T100100());
  List<T100101> t100101 = List.generate(CntList.sptendMax, (_) => T100101());
  List<T100102> t100102 = List.generate(CntList.sptendMax, (_) => T100102());

  List<T100200> t100200 = List.generate(AmtKind.amtMax.index, (_) => T100200());
  List<T100201> t100201 = List.generate(AmtKind.amtMax.index, (_) => T100201());
  List<T100210> t100210 = List.generate(AmtKind.amtMax.index, (_) => T100210());
  List<T100220> t100220 = List.generate(AmtKind.amtMax.index, (_) => T100220());

  List<T100300> t100300 = List.generate(CntList.taxMax, (_) => T100300());
  List<T100400> t100400 = List.generate(CntList.taxMax, (_) => T100400());
  List<T100401> t100401 = List.generate(CntList.taxMax, (_) => T100401());

  T100500 t100500 = T100500();
  T100600 t100600 = T100600();
  T100700 t100700 = T100700();

  T100701 t100701 = T100701();
  T100702 t100702 = T100702();
  T100710 t100710 = T100710();
  T100711 t100711 = T100711();
  List<T100712> t100712 = List.generate(CntList.tcpnPrnMax, (_) => T100712());
  T100713 t100713 = T100713();
  T100714 t100714 = T100714();
  T100715 t100715 = T100715();
  T100720 t100720 = T100720();
  T100730 t100730 = T100730();
  List<T100740> t100740 = List.generate(CntList.taiyoCpnMax, (_) => T100740());
  T100750 t100750 = T100750();
  T100760 t100760 = T100760();
  T100770 t100770 = T100770();
  T100780 t100780 = T100780();
  /// FNo.100790 : 楽天ポイント
  T100790 t100790 = T100790();
  T100800 t100800 = T100800();
  T100900 t100900 = T100900();
  T100901 t100901 = T100901();
  T100902 t100902 = T100902();
  T100903 t100903 = T100903();
  T100904 t100904 = T100904();

  List<T101000> t101000 = List.generate(CntList.promMax, (_) => T101000());
  List<T101001> t101001 = List.generate(CntList.promMax, (_) => T101001());

  T101100 t101100 = T101100();

  T102000 t102000 = T102000();

  List<T102001> t102001 = List.generate(CntList.dsckindMax, (_) => T102001());
  List<T102002> t102002 = List.generate(CntList.dsckindMax, (_) => T102002());
  List<T102003> t102003 = List.generate(PrcChgKind.prcChgKindMax, (_) => T102003());

  T102004 t102004 = T102004();
  T102005 t102005 = T102005();
  List<T102500> t102500 = List.generate(CntList.promMax, (_) => T102500());
  T102501 t102501 = T102501();
  T102600 t102600 = T102600();
  T103000 t103000 = T103000();

  T105000 t105000 = T105000();
  T105100 t105100 = T105100();
  T105200 t105200 = T105200();
  T105300 t105300 = T105300();
  T105400 t105400 = T105400();
  T105500 t105500 = T105500();

  /// FNo.106000 : One to Oneプロモーション
  List<T106000> t106000 = List.generate(CntList.loyPromTtlMax, (_) => T106000());
  List<T106100> t106100 = List.generate(CntList.othPromMax, (_) => T106100());
  List<T106500> t106500 = List.generate(CntList.othPromMax, (_) => T106500());
  List<T106501> t106501 = List.generate(CntList.othPromMax, (_) => T106501());
  List<T107000> t107000 = List.generate(CntList.acntMax, (_) => T107000());

  T108000 t108000 = T108000();
  T109000 t109000 = T109000();
  T110000 t110000 = T110000();
  T111000 t111000 = T111000();
  T120000 t120000 = T120000();
  T121000 t121000 = T121000();
  T600000 t600000 = T600000();

  List<T100906> t100906 = List.generate(CntList.fgUseSerialArrMax, (_) => T100906());

  T100001Sts t100001Sts = T100001Sts();
  T100002Sts t100002Sts = T100002Sts();
  T100010Sts t100010Sts = T100010Sts();
  T100011Sts t100011Sts = T100011Sts();
  T100012Sts t100012Sts = T100012Sts();
  T100013Sts t100013Sts = T100013Sts();
  T100017Sts t100017Sts = T100017Sts();
  List<T100100Sts> t100100Sts = List.generate(CntList.sptendMax, (_) => T100100Sts());
  List<T100200Sts> t100200Sts = List.generate(AmtKind.amtMax.index, (_) => T100200Sts());

  T100600Sts t100600Sts = T100600Sts();

  T100700Sts t100700Sts = T100700Sts();
  T100701Sts t100701Sts = T100701Sts();
  T100702Sts t100702Sts = T100702Sts();
  List<T100712Sts> t100712Sts = List.generate(CntList.tcpnPrnMax, (_) => T100712Sts());
  T100715Sts t100715Sts = T100715Sts();
  T100770Sts t100770Sts = T100770Sts();
  /// 楽天ポイント
  T100790Sts t100790Sts = T100790Sts();
  T100800Sts t100800Sts = T100800Sts();
  T100900Sts t100900Sts = T100900Sts();
  T100901Sts t100901Sts = T100901Sts();
  T100902Sts t100902Sts = T100902Sts();
  List<T101000Sts> t101000Sts = List.generate(CntList.promMax, (_) => T101000Sts());
  List<T101001Sts> t101001Sts = List.generate(CntList.promMax, (_) => T101001Sts());

  T101100Sts t101100Sts = T101100Sts();
  List<T102500Sts> t102500Sts = List.generate(CntList.promMax, (_) => T102500Sts());
  T102501Sts t102501Sts = T102501Sts();

  T105000Sts t105000Sts = T105000Sts();
  T105100Sts t105100Sts = T105100Sts();
  T105200Sts t105200Sts = T105200Sts();
  T105300Sts t105300Sts = T105300Sts();
  T105400Sts t105400Sts = T105400Sts();

  List<T106000Sts> t106000Sts = List.generate(CntList.loyPromTtlMax, (_) => T106000Sts());
  List<T106100Sts> t106100Sts = List.generate(CntList.othPromMax, (_) => T106100Sts());
  List<T106500Sts> t106500Sts = List.generate(CntList.othPromMax, (_) => T106500Sts());
  List<T106501Sts> t106501Sts = List.generate(CntList.othPromMax, (_) => T106501Sts());

  List<T107000Sts> t107000Sts = List.generate(CntList.acntMax, (_) => T107000Sts());

  T109000Sts t109000Sts = T109000Sts();

  CalcTtl calcData = CalcTtl(); // 一時的なデータ. 実績としては残さないが印字などで使用

  /// 関連tprxソース:rxlogcalc.c rxCalc_Stl_Tax_In_Amt
  int getSubTtlTaxInAmt() {

    return t100001.stlTaxInAmt;
  }

  /// 有効なRegsMem().tItemLogの数を取得する.
  int getItemLogCount() {
    return     RegsMem().tTtllog.t100001Sts.itemlogCnt;
  }

  /// 購入アイテムの総数を取得する.
  /// 返品時はマイナス値を返す.
  int getItemCount() {
    int sum = 0;
    if( RegsMem().lastTotalData == null){
      return sum;
    }
    sum = RegsMem().lastTotalData?.totalQty ?? 0;
    if (RegsMem().refundFlag){
      sum = sum * -1;
    }

    return sum;
  }
}

enum RegsMemState {
  none,
  busy,
}

///関連tprxソース:rxregmem.h REGSMEM
class RegsMem {
  /// シングルトン
  static final RegsMem _instance = RegsMem._internal();
  factory RegsMem() {
    return _instance;
  }
  RegsMem._internal() {
    resetData();
  }

  CCrdtActualLog crdtlog = CCrdtActualLog(); // Credit Actual Log Buffer
  RegsMemState state = RegsMemState.none;

  List<TItemLog> tItemLog = List.generate(CntList.itemMax, (_) => TItemLog());
  late List<TbdlLog> tBdlLog = List.generate(CntList.itemMax, (_) => TbdlLog());
  List<TCrdtLog> tCrdtLog = List.generate(CntList.sptendMax, (_) => TCrdtLog());
  late TTtlLog tTtllog;
  late List<CTaxMstColumns> _taxList;
  CHeaderLog tHeader = CHeaderLog();
  CPluMstColumns? repeatPluData;
  RxMemPrn prnrBuf = RxMemPrn();
  RxMemTmp tmpbuf = RxMemTmp();
  RxmemBcdpay bcdpay = RxmemBcdpay();
  RxMemCogcaRx cogcaRxData = RxMemCogcaRx();
  int mltsuicaAlarmPayprc  = 0;  /* VEGA3000電子マネー: 処理未了発生時の取引金額 */
  int workInType = 0;  //業務宣言（0:なし  1:プリカ  2:ハウス  3:HappySelf(フル)）
  int qcSaGDataSetflg = 0; /* Shop&Go商品 0:読込でない 1:読込済み フラグ */
  int precaBalance = 0;  /* プリペイド残高（登録モード表示用）*/
  int precaSptendQcFlg = 0;  /* プリペイド QCashierスプリット登録フラグ */
  int precaCardreadQcFlg = 0;  /* プリペイド QCashierカード読取フラグ */
  bool refundFlag = false;  // 返品モードフラグ
  String refundDate = "";   // 返品日付
  SCustTtlTbl custTtlTbl = SCustTtlTbl();
  List<SCustCpnTbl> custCpnTbl = List.generate(RxCntList.OTH_PROM_MAX, (_) => SCustCpnTbl());
  List<SCustLoyTbl> custLoyTbl = List.generate(RxCntList.LOY_PROM_TTL_MAX, (_) => SCustLoyTbl());
  List<SCustStpTbl> custStpTbl = List.generate(RxCntList.OTH_PROM_MAX, (_) => SCustStpTbl());
  List<RxMemTax> tax = List.generate(InvTaxKind.INV_TAX_MAX.value, (_) => RxMemTax());	 // インボイス 税データ
  List<List<PPromschMst>> bdlSch = List.generate(CntList.itemMax, (_) => List.generate(BdlKind.bdlKindMax.index, (_) => PPromschMst()));
  List<List<PPromschMst>> stmSch = List.generate(CntList.itemMax, (_) => List.generate((CntList.rcschStmAllsch+1), (_) => PPromschMst()));
  List<RxMemTempSptend> tempSptend = List.generate(RX_LASTCOMM_PAYKIND.LCOM_MAX.index, (_) => RxMemTempSptend());	// 一時格納用スプリット情報 LCOM_PRECA:プリカ関連、LCOM_DPOINT:dポイント関連

  // ▼▼▼クラウドPOS対応▼▼▼▼▼
  /// クラウドPOSへ商品登録request情報.
  CalcRequestParaItem? lastRequestData;
  /// クラウドPOSへ商品登録の結果
  CalcResultItem? lastResultData;
    /// クラウドPOSへ商品登録の結果の小計データ
  TotalData? get lastTotalData =>  lastResultData?.totalDataList?.first;
  
  // ▲▲▲クラウドPOS対応▲▲▲▲▲

  /// 税データを取得する.
  /// 税データがない場合はDBから取得する.
  Future<CTaxMstColumns?> getTaxData(int taxCd) async {
    if (_taxList.isEmpty) {
      List<CTaxMstColumns> taxData = await RegistInitData.getTaxData();
      _taxList = taxData;
    }
    // 税データにないものを引数に指定している場合はnull.
    return _taxList[taxCd];
  }

  /// 全てのデータをリセットする.
  void resetData() {
    resetState();
    _taxList = <CTaxMstColumns>[];
    tItemLog = List.generate(CntList.itemMax, (_) => TItemLog());
    tCrdtLog = List.generate(CntList.sptendMax, (_) => TCrdtLog());
    tTtllog = TTtlLog();
    repeatPluData = null;
  }

  /// 税データはリセットしない.
  void resetTranData() {
    resetState();
    tItemLog = List.generate(CntList.itemMax, (_) => TItemLog());
    tCrdtLog = List.generate(CntList.sptendMax, (_) => TCrdtLog());

    tTtllog.t1000 = T1000();
    tTtllog.t100001 = T100001();
    tTtllog.t100002 = T100002();
    tTtllog.t100003 = T100003();
    tTtllog.t100004 = T100004();
    tTtllog.t100010 = T100010();
    tTtllog.t100011 = T100011();
    tTtllog.t100012 = T100012();
    tTtllog.t100013 = T100013();
    tTtllog.t100014 = T100014();
    tTtllog.t100015 = T100015();
    tTtllog.t100016 = T100016();
    tTtllog.t100017 = T100017();
    tTtllog.t100018 = T100018();
    tTtllog.t100019 = T100019();

    tTtllog.t100100 = List.generate(CntList.sptendMax,(_) => T100100());
    tTtllog.t100101 = List.generate(CntList.sptendMax, (_) => T100101());
    tTtllog.t100102 = List.generate(CntList.sptendMax, (_) => T100102());

//  在高   tTtllog.t100200 = List.generate(AmtKind.amtMax.index, (_) => T100200());
    tTtllog.t100201 = List.generate(AmtKind.amtMax.index, (_) => T100201());
    tTtllog.t100210 = List.generate(AmtKind.amtMax.index, (_) => T100210());
    tTtllog.t100220 = List.generate(AmtKind.amtMax.index, (_) => T100220());

    tTtllog.t100300 = List.generate(CntList.taxMax, (_) => T100300());
    tTtllog.t100400 = List.generate(CntList.taxMax, (_) => T100400());
    tTtllog.t100401 = List.generate(CntList.taxMax, (_) => T100401());

    tTtllog.t100500 = T100500();
//  釣銭機    tTtllog.t100600 = T100600();
    tTtllog.t100700 = T100700();

    tTtllog.t100701 = T100701();
    tTtllog.t100702 = T100702();
    tTtllog.t100710 = T100710();
    tTtllog.t100711 = T100711();
    tTtllog.t100712 = List.generate(CntList.tcpnPrnMax, (_) => T100712());
    tTtllog.t100713 = T100713();
    tTtllog.t100714 = T100714();
    tTtllog.t100715 = T100715();
    tTtllog.t100720 = T100720();
    tTtllog.t100730 = T100730();
    tTtllog.t100740 = List.generate(CntList.taiyoCpnMax, (_) => T100740());
    tTtllog.t100750 = T100750();
    tTtllog.t100760 = T100760();
    tTtllog.t100770 = T100770();
    tTtllog.t100780 = T100780();
    /// FNo.100790 : 楽天ポイント
    tTtllog.t100790 = T100790();
    tTtllog.t100800 = T100800();
    tTtllog.t100900 = T100900();
    tTtllog.t100901 = T100901();
    tTtllog.t100902 = T100902();
    tTtllog.t100903 = T100903();
    tTtllog.t100904 = T100904();

    tTtllog.t101000 = List.generate(CntList.promMax, (_) => T101000());
    tTtllog.t101001 = List.generate(CntList.promMax, (_) => T101001());

    tTtllog.t101100 = T101100();

    tTtllog.t102000 = T102000();

    tTtllog.t102001 = List.generate(CntList.dsckindMax, (_) => T102001());
    tTtllog.t102002 = List.generate(CntList.dsckindMax, (_) => T102002());
    tTtllog.t102003 = List.generate(PrcChgKind.prcChgKindMax, (_) => T102003());

    tTtllog.t102004 = T102004();
    tTtllog.t102005 = T102005();
    tTtllog.t102500 = List.generate(CntList.promMax, (_) => T102500());
    tTtllog.t102501 = T102501();
    tTtllog.t102600 = T102600();
    tTtllog.t103000 = T103000();

    tTtllog.t105000 = T105000();
//  売上回収    tTtllog.t105100 = T105100();
    tTtllog.t105200 = T105200();
    tTtllog.t105300 = T105300();
    tTtllog.t105400 = T105400();

    /// FNo.106000 : One to Oneプロモーション
    tTtllog.t106000 = List.generate(CntList.loyPromTtlMax, (_) => T106000());
    tTtllog.t106100 = List.generate(CntList.othPromMax, (_) => T106100());
    tTtllog.t106500 = List.generate(CntList.othPromMax, (_) => T106500());
    tTtllog.t106501 = List.generate(CntList.othPromMax, (_) => T106501());
    tTtllog.t107000 = List.generate(CntList.acntMax, (_) => T107000());

    tTtllog.t108000 = T108000();
    tTtllog.t109000 = T109000();
    tTtllog.t110000 = T110000();
    tTtllog.t111000 = T111000();
    tTtllog.t120000 = T120000();
    tTtllog.t121000 = T121000();
    tTtllog.t600000 = T600000();

    tTtllog.t100906 = List.generate(CntList.fgUseSerialArrMax, (_) => T100906());

    tTtllog.t100001Sts = T100001Sts();
    tTtllog.t100002Sts = T100002Sts();
    tTtllog.t100010Sts = T100010Sts();
    tTtllog.t100011Sts = T100011Sts();
    tTtllog.t100012Sts = T100012Sts();
    tTtllog.t100013Sts = T100013Sts();
    tTtllog.t100017Sts = T100017Sts();
    tTtllog.t100100Sts = List.generate(CntList.sptendMax, (_) => T100100Sts());
//  在高      tTtllog.t100200Sts = List.generate(AmtKind.amtMax.index, (_) => T100200Sts());

//  釣銭機    tTtllog.t100600Sts = T100600Sts();

    tTtllog.t100700Sts = T100700Sts();
    tTtllog.t100701Sts = T100701Sts();
    tTtllog.t100702Sts = T100702Sts();
    tTtllog.t100712Sts = List.generate(CntList.tcpnPrnMax, (_) => T100712Sts());
    tTtllog.t100715Sts = T100715Sts();
    tTtllog.t100770Sts = T100770Sts();
    /// 楽天ポイント
    tTtllog.t100790Sts = T100790Sts();
    tTtllog.t100800Sts = T100800Sts();
    tTtllog.t100900Sts = T100900Sts();
    tTtllog.t100901Sts = T100901Sts();
    tTtllog.t100902Sts = T100902Sts();
    tTtllog.t101000Sts = List.generate(CntList.promMax, (_) => T101000Sts());
    tTtllog.t101001Sts = List.generate(CntList.promMax, (_) => T101001Sts());

    tTtllog.t101100Sts = T101100Sts();
    tTtllog.t102500Sts = List.generate(CntList.promMax, (_) => T102500Sts());
    tTtllog.t102501Sts = T102501Sts();

    tTtllog.t105000Sts = T105000Sts();
//  売上回収    tTtllog.t105100Sts = T105100Sts();
    tTtllog.t105200Sts = T105200Sts();
    tTtllog.t105300Sts = T105300Sts();
    tTtllog.t105400Sts = T105400Sts();

    tTtllog.t106000Sts = List.generate(CntList.loyPromTtlMax, (_) => T106000Sts());
    tTtllog.t106100Sts = List.generate(CntList.othPromMax, (_) => T106100Sts());
    tTtllog.t106500Sts = List.generate(CntList.othPromMax, (_) => T106500Sts());
    tTtllog.t106501Sts = List.generate(CntList.othPromMax, (_) => T106501Sts());

    tTtllog.t107000Sts = List.generate(CntList.acntMax, (_) => T107000Sts());

    tTtllog.t109000Sts = T109000Sts();

    tTtllog.calcData = CalcTtl(); // 一時的なデータ. 実績としては残さないが印字などで使用

    repeatPluData = null;
    lastRequestData = null;
    lastResultData = null;
  }

  void resetState() {
    state = RegsMemState.none;
  }

  bool checkAndSetState() {
    if (state == RegsMemState.busy) {
      return false;
    }
    state = RegsMemState.busy;
    return true;
  }
}
