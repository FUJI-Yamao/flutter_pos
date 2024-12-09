/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/regs/checker/rc_clxos.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:synchronized/synchronized.dart';

import '../../../clxos/calc_api.dart';
import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cls_conf/configJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/qcConnect.dart';
import '../../inc/lib/spqc.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/apllib/apllib_speedself.dart';
import '../../lib/apllib/db_comlib.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/socket/client/semiself_socket_client.dart';
import '../inc/rc_mem.dart';
import 'rc_clxos_payment.dart';
import 'rcspeeza_com.dart';
import 'rcsyschk.dart';

///  関連tprxソース: rcky_qcselect.c
class RckyQcSelect {
  static const QCSELECT_POPUP_NUM = 3;  // POPUPの最大表示数

  static List<List<QcSelectPopUpParam>>	popUpParam = List.generate(QcSelectDispTypList.QCSELECT_DISPTYP_MAX.index, (_) => List.generate(QCSELECT_POPUP_NUM, (_) => QcSelectPopUpParam()));  // POPUP登録モードパラメータ
  static List<List<QcSelectPopUpParam>>	stlPopUpParam = List.generate(QcSelectDispTypList.QCSELECT_DISPTYP_MAX.index, (_) => List.generate(QCSELECT_POPUP_NUM, (_) => QcSelectPopUpParam()));  // POPUP小計モードパラメータ
  static List<List<QcSelectPopUpParam>>	choicePopUpParam = List.generate(QcSelectDispTypList.QCSELECT_DISPTYP_MAX.index, (_) => List.generate(QCSELECT_POPUP_NUM, (_) => QcSelectPopUpParam()));  // POPUPお釣り選択モードパラメータ
  static QcSelectSaveParam qcSelSaveData = QcSelectSaveParam();  // 登録画面に入ったら抜けるまでデータを格納するもの
  static int qcSelectReadErrWait = 0;  // 読込エラー後のWait時間 (ずっと読込中になるのを回避するため)
  static int alertFlashTimer = 0;  // 点滅させるためのタイマー
  static int alertFlashFlag = 0;  // 点滅をさせないためのフラグ  0:OK  1:NG
  static int sendDlgTimer = 0;

  static final Lock _lock = Lock();

  /// 登録画面表示前にqcConnectタスクの開始, 及び, 接続QCashierの情報を共有メモリにセット
  ///　関連tprxソース: rcky_qcselect.c - rcStartQcConnectTask
  static Future<int> rcStartQcConnectTask(TprMID tid, int chkCash) async {
    int	ret;
    int	num;
    int	connectNum;	// スレッド起動数
    int	macNo;
    String ipAddr;
    int ipAddrlen = 64;
    int returnRet = 0;
    List<int>	qcSelectKyCodeList = [
      FuncKey.KY_QCSELECT.keyId,
      FuncKey.KY_QCSELECT2.keyId,
      FuncKey.KY_QCSELECT3.keyId,
      -1
    ];
    int	overlap;	// 同一レジ番号をチェックするため
    int	checkNum;	// 同一レジ番号をチェックするため
    int	setCnt;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return Typ.NG;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    // Speeza & QCashier共に必ず通る
    resetQcConnectStatus(chkCash);

    if ((!await RcSysChk.rcQRChkPrintSystem() && (!await RcSysChk.rcCheckQCJCFrcClkSystem())) || (chkCash == 1)) {
      return Typ.OK;
    }

    //動作中のタスクとそれ以外のタスクで同時に動作しないようにする
    await _lock.synchronized(() async {
      connectNum = 0;
      if (tsBuf.qcConnect.ConMax == 0) { //先に動作させるタスクでQC指定キー情報のセットを行う
        for (num = 0; qcSelectKyCodeList[num] != -1; num ++) {
          // speeza.iniにキー毎のマシン番号をセットしているのでそれを確認
          macNo = RcSpeezaCom.rcGetQcSelectMacNo(qcSelectKyCodeList[num]);
          if (macNo > 0) {
            overlap = 0;
            for (checkNum = connectNum; checkNum >= 0; checkNum--) {
              if (tsBuf.qcConnect.ConStatus[checkNum].macNo == macNo) {
                overlap = 1; // 同一レジ番号が設定されていた
                break;
              }
            }
            if (overlap == 1) {
              TprLog().logAdd(tid, LogLevelDefine.normal, "rcStartQcConnectTask: Same MacNo");
              continue;
            }

            (returnRet, ipAddr) = await DbComlib.dbLibGetIpAddrFromMacAddr(tid, macNo);
            if (returnRet == Typ.NG) {
              TprLog().logAdd(tid, LogLevelDefine.normal, "rcStartQcConnectTask: This Mac No is Not MacAddrMaster");
              continue; // 間違った番号をセットしていたら表示しない
            }
            if (await _rcSavePresetKeyData(tid, num, qcSelectKyCodeList[num]) == -1) {
              TprLog().logAdd(tid, LogLevelDefine.normal, "rcStartQcConnectTask: This Mac No is Not PresetMaster");
              continue; // プリセットマスタに存在しない場合はタスクを増やさない
            }
            tsBuf.qcConnect.ConStatus[connectNum].macNo = macNo;
            tsBuf.qcConnect.ConStatus[connectNum].ipAddr = ipAddr;

            // タスクの開始
            await SemiSelfSocketClient().connectSocket(connectNum);
            connectNum++;
            tsBuf.qcConnect.ConMax = connectNum;
          }
        }
      }
      else { //後に動作するタスクでは、セットされた共有メモリの情報を元に再現する
        for (num = 0; num < tsBuf.qcConnect.ConMax; num ++) {  //表示するQC指定キー分ループさせる
          setCnt = 0;
          for (checkNum = 0; qcSelectKyCodeList[checkNum] != -1; checkNum ++) {  //QC指定1～3をチェック
            if (setCnt == 0) {  //まだキー情報をセットしていない時
              macNo = RcSpeezaCom.rcGetQcSelectMacNo(qcSelectKyCodeList[checkNum]); //QC指定1～3のレジ番号を取得
              if (macNo > 0) {
                if (tsBuf.qcConnect.ConStatus[num].macNo == macNo) {  //先に共有メモリにセットされたレジ番号と同じかチェック
                  await _rcSavePresetKeyData(tid, checkNum, qcSelectKyCodeList[checkNum]); //キー情報をセット
                  setCnt = 1; //セット完了フラグを立てる
                }
              }
            }
          }
        }
      }
    });

    // キャッシャーの場合は、ファンクションキー表示の為の情報を作成後に抜けたい為、ここで処理を抜ける
    if (chkCash == 2) {
      return Typ.OK;
    }

    ret = Typ.NG;
    RxMemRet xRetM = SystemFunc.rxMemRead(RxMemIndex.RXMEM_QCCONNECT_STAT);
    if (xRetM.isInvalid()) {
      return ret;
    }
    if (xRetM.result == RxMem.RXMEM_OK) {
      TprLog().logAdd(tid, LogLevelDefine.normal, "rcStartQcConnectTask: qcConnect Task Start.");
      ret = Typ.OK;
    }
    if (ret == Typ.NG) {
      TprLog().logAdd(tid, LogLevelDefine.error, "rcStartQcConnectTask: qcConnect Task Start Error.");
      resetQcConnectStatus(chkCash);
      return Typ.NG;
    }
    return Typ.OK;
  }

  /// 初期化関数
  /// 引数: QCJC-Jフラグ
  ///  関連tprxソース: rcky_qcselect.c - ResetQcConnectStatus
  static void resetQcConnectStatus(int chkCash) {
    qcSelectReadErrWait = 0;
    // Speeza & QCashier用 Status 初期化
    if (chkCash == 1) { /* QCJC-J */
      return;
    }
    // Speeza用
    popUpParam = List.generate(QcSelectDispTypList.QCSELECT_DISPTYP_MAX.index, (_) => List.generate(QCSELECT_POPUP_NUM, (_) => QcSelectPopUpParam()));
    stlPopUpParam = List.generate(QcSelectDispTypList.QCSELECT_DISPTYP_MAX.index, (_) => List.generate(QCSELECT_POPUP_NUM, (_) => QcSelectPopUpParam()));
    choicePopUpParam = List.generate(QcSelectDispTypList.QCSELECT_DISPTYP_MAX.index, (_) => List.generate(QCSELECT_POPUP_NUM, (_) => QcSelectPopUpParam()));
    alertFlashTimer = -1;
    alertFlashFlag = 0;
    sendDlgTimer = -1;
  }

  /// speeza.iniにマシン番号を設定したファンクションコードが c_preset_mst に存在した場合は保存、
  /// 存在しない場合は -1 を返す
  /// 戻り値: 0=存在する  -1=存在しない
  ///  関連tprxソース: rcky_qcselect.c - rcSavePresetKeyData
  static Future<int> _rcSavePresetKeyData(TprMID tid, int num, int keyCode) async {
    String callFunc = "RckyQcSelect._rcSavePresetKeyData()";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error, "$callFunc: rxMemRead error");
      return -1;
    }
    RxCommonBuf cBuf = xRet.object;

    String sql = "SELECT ky_cd FROM c_preset_mst WHERE ky_cd = '$keyCode' AND preset_grp_cd = '${cBuf.dbRegCtrl.presetGrpCd}' AND comp_cd = ${cBuf.dbRegCtrl.compCd} AND stre_cd = ${cBuf.dbRegCtrl.streCd};";

    DbManipulationPs db = DbManipulationPs();
    try {
      Result dbRes = await db.dbCon.execute(sql);
      if (dbRes.affectedRows == 0) {
        TprLog().logAdd(tid, LogLevelDefine.error, "$callFunc: no record (sql: $sql)");
        return -1;
      }
      qcSelSaveData.useCode[num] = keyCode;  // QC指定キーのファンクションコードセット
      qcSelSaveData.useFlag = 1;  // QC指定キーが自レジのプリセットグループコード内に存在
    } catch (e) {
      //Cソース「db_PQexec() == NULL」時に相当
      TprLog().logAdd(tid, LogLevelDefine.error, "$callFunc: db_PQexec failed!!");
      return -1;
    }
    return 0;
  }

  /// 精算機ボタン押下時処理
  /// 引数: index レジ番号
  /// 関連tprxソース: rcky_qcselect.c  rcKy_QcSelect()
  static Future<bool> qcSelectKey(int index) async {
    TprMID tid = Tpraid.TPRAID_CHK;
    String sql = "";
    String uuid = "";
    int errNo = 0;
    List<String> cartLogQuery = [];

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "qcSelectKey rxMemRead error");
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    CalcRequestParaItem? lastRequestData = RegsMem().lastRequestData;
    CalcResultItem? lastResultData = RegsMem().lastResultData;

    if (lastRequestData == null || lastResultData == null) {
      TprLog().logAdd(tid, LogLevelDefine.error, "qcSelectKey: lastRequestData or lastResultData is null");
      return false;
    }

    uuid = lastRequestData.uuid;
    CalcResultPay retDataCheck;
    if (RcClxosCommon.validClxos) {
      retDataCheck = await RcClxosPayment.payment(pCom, isCheck: true);
    } else {
      DateTime dt = DateTime.now();
      String stdout = '{"RetSts":0,"ErrMsg":"","PosErrCd":null,"TotalData":{"Amount":988,"Payment":0,"Change":0,"RefundFlag":0,"TotalQty":6,"CompCd":1,"StreCd":10320,"MacNo":3,"ReceiptNo":191,"PrintNo":211,"CashierNo":999999,"EndTime":"' + dt.year.toString().padLeft(4, '0') + "-" + dt.month.toString().padLeft(2, '0') + "-" + dt.day.toString().padLeft(2, '0') + " " + dt.hour.toString().padLeft(2, '0') + ":" + dt.minute.toString().padLeft(2, '0') + ":" + dt.second.toString().padLeft(2, '0') + '","SerialNo":"2024092500000000100001032000000000321972500","UUID":""},"DigitalReceipt":{"Transaction":{"ReceiptDateTime":"${dt.year}-${dt.month}-${dt.day}T${dt.hour}:${dt.minute}:${dt.second}+09:00","WorkstationID":"3","ReceiptNumber":"191","TransactionID":"2024100300000000100001032000000000301910211","ReceiptImage":null,"RetailTransaction":null,"TRKReceiptImage":[{"LineSpace":6,"PrintType":"Line","CutType":"PartialCut","ReceiptLine":["@bitmap@Logo/receipt.bmp@/bitmap@","                                  ","店No:000010320      ﾚｼﾞNo:000003  ","2024年10月 4日(金曜日)  11時36分  ","000999999ﾒﾝﾃﾅﾝｽ      ﾚｼｰﾄNo:0191  ","                                  ","外8  にら　束               \\\\390　","     (    2個 x @@195)             ","外8  キャベツ　玉売り       \\\\450　","     (    3個 x @@150)             ","外8  トマト　バラ            \\\\75　","--------------------------------  "," 小計                       \\\\915  ","(外税8%対象額               \\\\915) "," 外税額            8%        \\\\73  "," 買上点数                    6点  ","--------------------------------  ","@fontsizeH@合計        \\\\988 @/fontsizeH@","(税率 8%対象額             \\\\988)  ","(内消費税等 8%内            \\\\73)  ","                                  ","外8内8は軽減税率対象商品です      ","@barC128_HNC@98241003019100000000302111@/barC128_HNC@"],"PageParts":{"Width":null,"Height":null,"Direction":null,"Rotate":null,"PartsList":null}}]}}}';
      retDataCheck = CalcResultPay.fromJson(jsonDecode(stdout));
    }
    errNo = retDataCheck.getErrId();

    CalcRequestParaPay requestParaPay;
    if (RcClxosCommon.validClxos) {
      requestParaPay = await RcClxosPayment.getQcRequestParaPay(pCom, isCheck: true);
    } else {
      String json = r'{"CompCd":1,"StreCd":10320,"ItemList":['
        '{"rSeqNo":1,"rQty":2,"rType":0,"rBarcode1":"2501012001729","rBarcode2":"","rCnctTime":"2024-10-04 11:35:49","rItemDscType":null,"rItemDscVal":null,"rItemDscCode":null,"rPrcChgVal":null,"rClsNo":0,"rClsVal":null,"rDecimalVal":"","rTaxChgCode":null},'
        '{"rSeqNo":2,"rQty":3,"rType":0,"rBarcode1":"2501011501411","rBarcode2":"","rCnctTime":"2024-10-04 11:35:56","rItemDscType":null,"rItemDscVal":null,"rItemDscCode":null,"rPrcChgVal":null,"rClsNo":0,"rClsVal":null,"rDecimalVal":"","rTaxChgCode":null},'
        '{"rSeqNo":3,"rQty":1,"rType":0,"rBarcode1":"2501010504543","rBarcode2":"","rCnctTime":"2024-10-04 11:36:02","rItemDscType":null,"rItemDscVal":null,"rItemDscCode":null,"rPrcChgVal":null,"rClsNo":0,"rClsVal":null,"rDecimalVal":"","rTaxChgCode":null}],'
        '"CustCode":"","SubttlList":[],"MacNo":3,"Uuid":"","OpeMode":1000,"RefundFlag":null,"RefundDate":"","PriceMode":null,"PosSpec":0,"ArcsInfo":null,"QcSendMacNo":null,"QcSendMacName":null}';
      requestParaPay = CalcRequestParaPay.fromJson(jsonDecode(json));
    }

    try {
      // p_cart_logインサート文配列取得
      Map<String, dynamic> params = {"uuid": uuid};
      sql = "select * from p_cart_log where cart_id = @uuid;";
      cartLogQuery = await _createInsertQuery("p_cart_log", sql, params);
      if ((!RcClxosCommon.validClxos) && (cartLogQuery.length == 0)) {
        // テストコード
        cartLogQuery.add(r"insert into p_cart_log (cart_id,plu_cd,sku_cd,rec_flg,ins_datetime,calc_data) values (@uuid,'2501010504543','',0,'2024-10-04 11:36:02.000Z','{" '"plucls_data":{"plu_lrgcls_cd":1,"plu_mdlcls_cd":1,"plu_smlcls_cd":101,"plu_tnycls_cd":999999,"plu_item_typ":1,"plu_pos_name":"トマト　バラ","plu_instruct_prc":135,"plu_pos_prc":75,"plu_tax_cd_1":1,"plu_rbtpremium_per":1,"lrg_cls_typ":1,"lrg_lrgcls_cd":1,"lrg_cls_flg":1,"lrg_tax_cd1":1,"lrg_name":"青果","lrg_dfltcls_cd":999999,"lrg_rbtpremium_per":1,"lrg_stlplus_flg":1,"lrg_pctr_tckt_flg":1,"lrg_clothing_flg":2,"mdl_cls_typ":2,"mdl_lrgcls_cd":1,"mdl_mdlcls_cd":1,"mdl_cls_flg":1,"mdl_tax_cd1":1,"mdl_name":"野菜","mdl_dfltcls_cd":999999,"mdl_rbttarget_flg":1,"mdl_rbtpremium_per":1,"mdl_prc_chg_flg":1,"mdl_stl_dsc_flg":1,"sml_cls_typ":3,"sml_lrgcls_cd":101,"sml_mdlcls_cd":1,"sml_smlcls_cd":101,"sml_tnycls_cd":999999,"sml_cls_flg":1,"sml_tax_cd1":1,"sml_name":"トマト","sml_dfltcls_cd":999999,"sml_rbttarget_flg":1,"sml_rbtpremium_per":1,"sml_prc_chg_flg":1,"sml_stl_dsc_flg":1,"sml_stlplus_flg":1,"sml_pctr_tckt_flg":1,"sml_clothing_flg":2,"sml_tax_exemption_flg":3,"tny_cls_typ":4,"tny_lrgcls_cd":999999,"tny_mdlcls_cd":1,"tny_smlcls_cd":101,"tny_tnycls_cd":999999}}' "');");
        cartLogQuery.add(r"insert into p_cart_log (cart_id,plu_cd,sku_cd,rec_flg,ins_datetime,calc_data) values (@uuid,'2501011501411','',0,'2024-10-04 11:35:56.000Z','{" '"plucls_data":{"plu_lrgcls_cd":1,"plu_mdlcls_cd":1,"plu_smlcls_cd":113,"plu_tnycls_cd":999999,"plu_item_typ":1,"plu_pos_name":"キャベツ　玉売り","plu_instruct_prc":195,"plu_pos_prc":150,"plu_tax_cd_1":1,"plu_rbtpremium_per":1,"lrg_cls_typ":1,"lrg_lrgcls_cd":1,"lrg_cls_flg":1,"lrg_tax_cd1":1,"lrg_name":"青果","lrg_dfltcls_cd":999999,"lrg_rbtpremium_per":1,"lrg_stlplus_flg":1,"lrg_pctr_tckt_flg":1,"lrg_clothing_flg":2,"mdl_cls_typ":2,"mdl_lrgcls_cd":1,"mdl_mdlcls_cd":1,"mdl_cls_flg":1,"mdl_tax_cd1":1,"mdl_name":"野菜","mdl_dfltcls_cd":999999,"mdl_rbttarget_flg":1,"mdl_rbtpremium_per":1,"mdl_prc_chg_flg":1,"mdl_stl_dsc_flg":1,"sml_cls_typ":3,"sml_lrgcls_cd":113,"sml_mdlcls_cd":1,"sml_smlcls_cd":113,"sml_tnycls_cd":999999,"sml_cls_flg":1,"sml_tax_cd1":1,"sml_name":"キャベツ","sml_dfltcls_cd":999999,"sml_rbttarget_flg":1,"sml_rbtpremium_per":1,"sml_prc_chg_flg":1,"sml_stl_dsc_flg":1,"sml_stlplus_flg":1,"sml_pctr_tckt_flg":1,"sml_clothing_flg":2,"sml_tax_exemption_flg":3,"tny_cls_typ":4,"tny_lrgcls_cd":999999,"tny_mdlcls_cd":1,"tny_smlcls_cd":113,"tny_tnycls_cd":999999}}' "');");
        cartLogQuery.add(r"insert into p_cart_log (cart_id,plu_cd,sku_cd,rec_flg,ins_datetime,calc_data) values (@uuid,'2501012001729','',0,'2024-10-04 11:35:49.000Z','{" '"plucls_data":{"plu_lrgcls_cd":1,"plu_mdlcls_cd":1,"plu_smlcls_cd":119,"plu_tnycls_cd":999999,"plu_item_typ":1,"plu_pos_name":"にら　束","plu_instruct_prc":195,"plu_pos_prc":195,"plu_tax_cd_1":1,"plu_rbtpremium_per":1,"lrg_cls_typ":1,"lrg_lrgcls_cd":1,"lrg_cls_flg":1,"lrg_tax_cd1":1,"lrg_name":"青果","lrg_dfltcls_cd":999999,"lrg_rbtpremium_per":1,"lrg_stlplus_flg":1,"lrg_pctr_tckt_flg":1,"lrg_clothing_flg":2,"mdl_cls_typ":2,"mdl_lrgcls_cd":1,"mdl_mdlcls_cd":1,"mdl_cls_flg":1,"mdl_tax_cd1":1,"mdl_name":"野菜","mdl_dfltcls_cd":999999,"mdl_rbttarget_flg":1,"mdl_rbtpremium_per":1,"mdl_prc_chg_flg":1,"mdl_stl_dsc_flg":1,"sml_cls_typ":3,"sml_lrgcls_cd":119,"sml_mdlcls_cd":1,"sml_smlcls_cd":119,"sml_tnycls_cd":999999,"sml_cls_flg":1,"sml_tax_cd1":1,"sml_name":"にら","sml_dfltcls_cd":999999,"sml_rbttarget_flg":1,"sml_rbtpremium_per":1,"sml_prc_chg_flg":1,"sml_stl_dsc_flg":1,"sml_stlplus_flg":1,"sml_pctr_tckt_flg":1,"sml_clothing_flg":2,"sml_tax_exemption_flg":3,"tny_cls_typ":4,"tny_lrgcls_cd":999999,"tny_mdlcls_cd":1,"tny_smlcls_cd":119,"tny_tnycls_cd":999999}}' "');");
        DbManipulationPs db = DbManipulationPs();
        String delSql = "delete from p_cart_log where cart_id=@uuid;";
        await db.dbCon.execute(Sql.named(delSql), parameters: params);
        await db.dbCon.execute(Sql.named(cartLogQuery[0]), parameters: params);
        await db.dbCon.execute(Sql.named(cartLogQuery[1]), parameters: params);
        await db.dbCon.execute(Sql.named(cartLogQuery[2]), parameters: params);
      }
      TprLog().logAdd(tid, LogLevelDefine.normal, "qcSelectKey: p_cart_log has ${cartLogQuery.length} records. uuid:$uuid");
    } catch(e, s) {
      TprLog().logAdd(tid, LogLevelDefine.error, "qcSelectKey: Failed to create insert query [$sql] $e, $s");
      return false;
    }

    try {
      // TODO:10163 セミセルフ レジ番号と送信情報をもとにwebsocket送信し、エラー応答の結果をerrNoに格納
      SemiSelfSocketClient().sendPaymentInfo(index, uuid, cartLogQuery: cartLogQuery, calcResultPay: retDataCheck, requestParaPay: requestParaPay);
    } catch (e, s) {
      // TODO:10163 セミセルフ QRコード印字ダイアログ表示
      TprLog().logAdd(tid, LogLevelDefine.error, "qcSelectKey: Failed to send UUID and register number $e, $s");
      return false;
    }

    if (errNo != 0) {
      int dlgId = RckyQcSelect.getDlgId(tid, errNo);
      if (dlgId != 0) {
        MsgDialog.show(
          MsgDialog.singleButtonDlgId(
            type: MsgDialogType.error,
            dialogId: dlgId,
          )
        );
        return false;
      }
    }

    return true;
  }

  /// 未精算一覧で表示するための未精算取引情報の作成
  ///  関連tprxソース: rcky_qcselect.c  rcCreateMakeBkupFile
  static Future<void> rcCreateMakeBkupFile(int index, String uuid, CalcResultPay? retPayCheck, CalcRequestParaPay? requestParaPay) async {

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    int macNo = getMacNoByIndex(index);
    String macName = getMacNameByIndex(index);
    CalcResultPay retQcSelect = await RcClxosPayment.qcSelect(pCom, macNo, macName, uuid);
    int errNo = retQcSelect.getErrId();

    if (retPayCheck?.totalData == null) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "makeUnliquidatedFile: CalcResultItem.totalData is Empty");
      return;
    }
    if (requestParaPay?.itemList == null) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "makeUnliquidatedFile: CalcRequestParaPay.itemList is Empty");
      return;
    }
    String transactionID = retPayCheck?.totalData?.SerialNo ?? "XXXXX";
    String receiptNo = "R" + (retPayCheck?.totalData?.receiptNo ?? 0).toString().padLeft(4, '0');
    String saleTime = retPayCheck?.totalData?.endTime ?? "1900/01/01 00:00:00";

    String dirPath = TprxPlatform.getPlatformPath(EnvironmentData.TPRX_HOME + SPQC_CLT_MAKE_DIR);

    // 指定フォルダ内に格納されているファイルを検索し、UUIDの一致で削除する（serial_noは取引ごとに変わってしまうので、ファイル再作成する）
    String filePattern = "_" + uuid + ".json";
    var fList = Directory(dirPath).listSync();
    for (var f in fList) {
      final File file = File(f.path);
      if (file.path.indexOf(filePattern) > 0) {
        file.deleteSync();
      }
    }

    // 未清算一覧用ファイル作成(TransactionIDとuuidを結合してファイル名とする)
    String fileName = transactionID + "_" + uuid + ".json";
    final File file = File(join(dirPath, fileName));
    if (saleTime.indexOf("+") >= 0) {
      saleTime = saleTime.substring(0, saleTime.indexOf("+"));
    }
    if (saleTime.indexOf("T") >= 0) {
      saleTime = saleTime.substring(saleTime.indexOf("T") + 1);
    }

    String jsonBody ='{'
        '"ret": 0,'
        '"macNo": ${macNo},'
        '"stlTaxInAmt": ${retPayCheck!.totalData!.amount},'
        '"qty": ${retPayCheck.totalData!.totalQty},'
        '"mode": ${requestParaPay!.opeMode},'
        '"outMdlclsQty": ${retPayCheck.totalData!.totalQty},'
        '"receiptNo": "${receiptNo}",'
        '"saleTime": "${saleTime}",'
        '"CalcRequestParaPay" : ${jsonEncode(requestParaPay)}'
    '}';
    if (getDebugState()) {
      jsonBody = _jsonShaping(jsonBody);
    }
    file.writeAsStringSync(jsonBody, encoding: utf8, flush: false);
    transactionID = "";
    receiptNo = "";
    saleTime = "";
  }

  /// QCashier等からの取引完了連絡があった場合の動作関数: 未精算取引データを削除する
  ///  関連tprxソース: qcSelectServer.c  RemoveSpeezaMakeFile（類似処理）
  static Future<void> rcRemoveBkupFile(int index, int macNo, String uuid) async {
    String dirPath = TprxPlatform.getPlatformPath(
        EnvironmentData.TPRX_HOME + SPQC_CLT_MAKE_DIR);

    String filePattern = "_" + uuid + ".json";
    var fList = Directory(dirPath).listSync();
    for (var f in fList) {
      // 指定フォルダ内に格納されているファイルを検索し、UUIDの一致、ファイル内のmacNoの一致で削除する。
      final File file = File(f.path);
      if (file.path.indexOf(filePattern) > 0) {
        String json = file.readAsStringSync();
        Map<String, dynamic> mapFile = jsonDecode(json);
        if (mapFile['macNo'] == macNo) {
          file.deleteSync();
        }
      }
    }
  }

  /// データベースからデータを取得し、insert文を作成する
  static Future<List<String>> _createInsertQuery(String tableName, String selectQuery, Map<String, dynamic> params) async {
    DbManipulationPs db = DbManipulationPs();
    Result result;
    result = await db.dbCon.execute(Sql.named(selectQuery), parameters: params);
    if (result.isEmpty) {
      return [];
    }

    List<String> columnNameList = [];
    List<String> columnValueList = [];
    return result.map((e) {
      columnNameList.clear();
      columnValueList.clear();
      for (var MapEntry(key: key, value: value) in e.toColumnMap().entries) {
        columnNameList.add(key);
        if (value == null) {
          columnValueList.add("null");
        } else if (value is String) {
          columnValueList.add("'$value'");
        } else if (value is DateTime) {
          columnValueList.add("'${value.toString()}'");
        } else {
          columnValueList.add(value.toString());
        }
      }
      String sql = 'insert into $tableName (${columnNameList.join(",")}) values (${columnValueList.join(",")});';
      return sql;
    }).toList();
  }

  static int getMacNoByIndex(int socketNo) {
    switch(socketNo) {
      case 1:   return RcSpeezaCom.speezaMem.pvt.QcSelectConMacNo1;
      case 2:   return RcSpeezaCom.speezaMem.pvt.QcSelectConMacNo2;
      case 3:   return RcSpeezaCom.speezaMem.pvt.QcSelectConMacNo3;
      default:  return 0;
    }
  }

  static String getMacNameByIndex(int socketNo) {
    switch(socketNo) {
      case 1:   return RcSpeezaCom.speezaMem.pvt.qcSelectConMacName1;
      case 2:   return RcSpeezaCom.speezaMem.pvt.qcSelectConMacName2;
      case 3:   return RcSpeezaCom.speezaMem.pvt.qcSelectConMacName3;
      default:  return "";
    }
  }

  static String getMacNameByMacNo(int macNo) {
    if(RcSpeezaCom.speezaMem.pvt.QcSelectConMacNo1 == macNo) {
      return RcSpeezaCom.speezaMem.pvt.qcSelectConMacName1;
    }
    if(RcSpeezaCom.speezaMem.pvt.QcSelectConMacNo2 == macNo) {
      return RcSpeezaCom.speezaMem.pvt.qcSelectConMacName2;
    }
    if(RcSpeezaCom.speezaMem.pvt.QcSelectConMacNo3 == macNo) {
      return RcSpeezaCom.speezaMem.pvt.qcSelectConMacName3;
    }
    return "";
  }

  static int getSocketNoByMacNo(int macNo) {
    if(RcSpeezaCom.speezaMem.pvt.QcSelectConMacNo1 == macNo) {
      return 1;
    }
    if(RcSpeezaCom.speezaMem.pvt.QcSelectConMacNo2 == macNo) {
      return 2;
    }
    if(RcSpeezaCom.speezaMem.pvt.QcSelectConMacNo3 == macNo) {
      return 3;
    }
    return 0;
  }

  static Future<String> _getMacName(int macNo) async {
    DbManipulationPs db = DbManipulationPs();
    Result result;
    try {
      result = await db.dbCon.execute("select mac_name from c_reginfo_mst where mac_no = $macNo;");
      if (result.isEmpty) {
        return "";
      }
      return result.first.toColumnMap()["mac_name"];
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error, "getMacName: Failed to get mac_name $e, $s");
      return "";
    }
  }

  /// rcSendFileQcSelect関数からステータスコードをDlgConfirmMsgKindに変換する処理を抜き出し
  ///  関連tprxソース: rcky_qcselect.c - rcSendFileQcSelect
  static int getDlgId(TprMID tid, int status) {
		if( status == AutoreadFileCreateStatus.AUTOREAD_DISP_MENU.id )
		{
      TprLog().logAdd(tid, LogLevelDefine.error, "rcSendFileQcSelect : Error Disp is Menu", errId: -1);
			return	DlgConfirmMsgKind.MSG_SPQC_SELECT_SEND_ERR.dlgId;
		}
		else if( status == AutoreadFileCreateStatus.AUTOREAD_DISP_MAINTE.id )
		{
      TprLog().logAdd(tid, LogLevelDefine.error, "rcSendFileQcSelect : Error Disp is Maintenance", errId: -1);
			return	DlgConfirmMsgKind.MSG_SPQC_SELECT_MAINTE_DISP.dlgId;
		}
		else if( status == AutoreadFileCreateStatus.AUTOREAD_DISP_CALL.id )
		{
      TprLog().logAdd(tid, LogLevelDefine.error, "rcSendFileQcSelect : Error Disp is Call", errId: -1);
			return	DlgConfirmMsgKind.MSG_SPQC_SELECT_CALL_DISP.dlgId;
		}
		else if( status == AutoreadFileCreateStatus.AUTOREAD_DISP_PAUSE.id )
		{
      TprLog().logAdd(tid, LogLevelDefine.error, "rcSendFileQcSelect : Error Disp is Pause", errId: -1);
			return	DlgConfirmMsgKind.MSG_SPQC_SELECT_PAUSE_DISP.dlgId;
		}
		else if( status == AutoreadFileCreateStatus.AUTOREAD_ANOTHER_USE.id )
		{
      TprLog().logAdd(tid, LogLevelDefine.error, "rcSendFileQcSelect : Error Another Use", errId: -1);
			return	DlgConfirmMsgKind.MSG_SPQC_SELECT_ANOTHER_USE.dlgId;
		}
		else if( status == AutoreadFileCreateStatus.AUTOREAD_TRAN_MAX.id )
		{
      TprLog().logAdd(tid, LogLevelDefine.error, "rcSendFileQcSelect : Error Create Tran Max", errId: -1);
			return	DlgConfirmMsgKind.MSG_SPQC_SELECT_TRAN_MAX.dlgId;
		}
		else if( status == AutoreadFileCreateStatus.AUTOREAD_MODE_DIFF.id )
		{
      TprLog().logAdd(tid, LogLevelDefine.error, "rcSendFileQcSelect : Error Ope Mode Different", errId: -1);
			return	DlgConfirmMsgKind.MSG_SPQC_SELECT_MODE_ERR.dlgId;
		}
		else if( status == AutoreadFileCreateStatus.AUTOREAD_DATE_DIFF.id )
		{
      TprLog().logAdd(tid, LogLevelDefine.error, "rcSendFileQcSelect : Error Sale Date Different", errId: -1);
			return	DlgConfirmMsgKind.MSG_SPQC_SELECT_DATE_ERR.dlgId;
		} else {
      return 0;
    }
  }
  static String _jsonShaping(String jsonBody) {
    jsonBody = jsonBody.replaceAll("{", "{\n    ");
    jsonBody = jsonBody.replaceAll(",", ",\n    ");
    jsonBody = jsonBody.replaceAll("}", "\n}");
    return jsonBody;
  }
}

/// ポップアップパラメタ
///  関連tprxソース: rcky_qcselect.c - QcSelectPopUpParam
class QcSelectPopUpParam {
  /*
  // QCの動作状態を示す
  GtkWidget	*Window;	// 半透明Window(下地)
  GtkWidget	*Fixed;		// 表示エリア
  GtkWidget	*Label;		// ラベル(状態表示)
  GtkWidget	*IconButton;	// 送信可不可を示すボタンアイコン
  GtkWidget	*BaseButton;	// ポップアップ表示の基点となるボタンのウィジェット
  // QCの注意状態を示す
  GtkWidget	*CautionWindow;	// 注意表示Window
  GtkWidget	*CautionFixed;	// 注意表示下地
  GtkWidget	*CautionLabel;	// 注意表示ラベル
   */
  int beStatus = 0;  // 表示したステータス
  int btnWidth = 0;  // BaseButtonの幅
  int btnHeight = 0;  // BaseButtonの高さ
  int cautionHoriz = 0;  // 警告表示ポップアップの位置 (X軸)
  int cautionVerti = 0;  // 警告表示ポップアップの位置 (Y軸)
  int cautionBeStatus = 0;  // 警告表示したステータス
  int macNo = 0;  // マシン番号
}

/// 登録画面に入ったら抜けるまでデータを格納しておくための構造体
///  関連tprxソース: rcky_qcselect.c - QcSelectSaveParam
class QcSelectSaveParam {
  int useFlag = 0;  // QC指定キーが自レジのプリセットグループコード内に存在するか  0:ない  1:ある
  List<int>	useCode = List.filled(RckyQcSelect.QCSELECT_POPUP_NUM + 1, 0);  // セットされたQC指定キーのファンクションコードを格納
  TSpQcInf useInf = TSpQcInf();  // QCashierが売上を立てた時にその読込データを保存しておくため, 読込時にデータを格納するためのもの
}

/// ディスプレイタイプリスト
///  関連tprxソース: rcky_qcselect.c - QCSELECT_DISPTYP_LIST
enum QcSelectDispTypList {
  QCSELECT_DISPTYP_DESK,  // 卓上側
  QCSELECT_DISPTYP_TOWER,  // タワー側
  QCSELECT_DISPTYP_MAX,
}