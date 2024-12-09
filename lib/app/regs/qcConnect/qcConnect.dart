/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:synchronized/synchronized.dart';

import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemqcConnect.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/lib/qcConnect.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/apllib/competition_ini.dart';
import '../../lib/apllib/qcjc_com.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/cm_sys/cm_cktwr.dart';
import '../../tprlib/TprLibLog.dart';
import '../../ui/page/full_self/controller/c_full_self_select_pay_controller.dart';
import '../../ui/socket/model/semiself_request_socket_model.dart';
import '../../ui/socket/model/semiself_response_socket_model.dart';
import '../../ui/socket/server/semiself_socket_server.dart';
import '../checker/rc_clxos_payment.dart';
import '../checker/rcky_qcselect.dart';
import '../checker/rcsyschk.dart';

/// 関連tprxソース: 関連tprxソース: qcConnect.c
class QcConnect {
  static const RS_OK = 0;
  static const RS_NG = -1;

  static int fEnd = 0;		// タスク終了フラグ
  static int port = 0;
  static int SendMacNo = 0;
  static late RxCommonBuf pCom;
  static late RxTaskStatBuf pStat;
  // TODO:00002 佐野 - 各種パラメタを仮置き
  static int regNo = 0;  //処理中登録機No
  static String uuid = "";    //登録機から受け取ったUUID
  static String cartId = "";  //登録機から受け取ったシーケンス番号（カートID）
  static String pluCd = "";  //登録機から受け取った商品コードor会員コード
  static int cartCnt = 0;   //カードに入れる（入れた）商品数
  static int conMax = 0; //最大接続数
  static int roopCnt = 0;   //タイマーループカウンタ
  static int payResId = 0;  //クラウドPOS「支払確認」のエラーID
  static CalcResultPay payResult = CalcResultPay(retSts: null,errMsg: null,posErrCd: null,totalData: null,digitalReceipt: null);
  static CalcResultPay calcResultPay = CalcResultPay(retSts:null, errMsg:null, posErrCd:null, totalData:null, digitalReceipt:null);
  static CalcRequestParaPay calcRequestParaPay = CalcRequestParaPay(compCd: 0, streCd: 0);

  static final Lock _lock = Lock();


  //支払い方法選択のコントローラ
  static final FullSelfSelectPayController selecPayCtrl =
  Get.put(FullSelfSelectPayController());

  /// QCashierの状態を取得する
  /// 関連tprxソース: qcConnect.c - main
  static Future<void> qcConnectMain() async {
    //TprLibLog.tprLibLogInit();

    TprMID tid = Tpraid.TPRAID_QCCONNECT;
    if (await _initQcConnect(tid) != RS_OK) {
      return;
    }

    QCJCCom.qcjcJcChkOn(tid);  /* QCJC */
    fEnd = 0;

    TprLog().logAdd(tid, LogLevelDefine.normal, "QcConnect.qcConnectMain(): qcConnect Process Start");

    if (fEnd == 0) {
      String address = await SemiSelfSocketServer.localhostSetting();
      pStat.qcConnect.MyStatus.qcStatus = SemiSelfSocketServer.msgStatusStandby;
      // TODO:00004 小出 ソケットサーバーはIsolateを立てる必要がある（はず）。
      SemiSelfSocketServer.getServerStart(address,  port);
    }
    //_exitQcConnect();
    TprLog().logAdd(tid, LogLevelDefine.normal, "QcConnect.qcConnectMain(): qcConnect Process End");
  }

  /// 初期処理
  /// 関連tprxソース: qcConnect.c - InitQcConnect
  static Future<int> _initQcConnect(TprMID tid) async {
    // struct  servent	*Port;
    //
    // 終了関数定義
    // (void)signal(SIGUSR1, endFunc);
    // (void)signal(SIGPIPE, pipeFunc);

    // 共通メモリポインタ取得
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error, "InitQcConnect: rxMemPtr get error(COMMON)");
      return RS_NG;
    }
    pCom = xRetC.object;

    // タスクステータスポインタ取得
    RxMemRet xRetM = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetM.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error, "InitQcConnect: rxMemPtr get error(STAT)");
      return RS_NG;
    }
    pStat = xRetM.object;

    // // メッセージキュー取得
    // await SystemFunc.rxMemGet(RxMemIndex.RXMEM_QCCONNECT_STAT);

    // Port番号の取得
    /// TODO:00010 長田 getservbyname置き換えの検討が必要
    // Port = getservbyname( QCCONNECT_SOCK_NAME, QCCONNECT_SOCK_PROTOCOL );
    // if ( Port != NULL ) {
    //   port = Port.s_port;
    // } else {
    //   TprLog().logAdd(tid, LogLevelDefine.error, "getservbyname, can't get socket port\n");
    //   port = QCCONNECT_PORT_DEFAULT;
    // }
    // 仮で固定で設定している
    port = QCSELECT_PORT_DEFAULT;

    // 自レジのマシン番号をセット (QCJCの場合はチェッカー側のマシン番号)
    if ((CmCksys.cmQCashierJCSystem() != 0)
        && (pCom.iniMacInfo.select_self.qc_mode == 1)
        && (CmCktWr.cm_chk_tower() != CmCktWr.TPR_TYPE_DESK)) {
      SendMacNo = (await CompetitionIni.competitionIniGetRcptNo(tid)).value;
    } else {
      SendMacNo = (await CompetitionIni.competitionIniGetRcptNo(tid)).value;
    }
    return RS_OK;
  }

  /// タイマーループで監視
  /// DBに保存されているかの確認
  static Future<void> dbSavedCheck() async {
    // タイマーループして監視
    await recvCallParam(await RcSysChk.getTid());
  }

  /// ソケット通信を行い、データを取得する
  /// 関連tprxソース: qcConnect.c - ThreadQcConnect
  static Future<SemiSelfResponseInfo> recvQcConnect(String requestInfo) async {
    bool ret = false;
    String status = SemiSelfSocketServer.msgStatusStandby;
    String cautionStatus = SemiSelfSocketServer.msgCautionStatusNormal;
    int errNo = DlgConfirmMsgKind.MSG_NONE.dlgId;
    int macNo = pCom.iniMacInfoMacNo;
    bool cancel = false;
    SemiSelfRequestInfo jsonListSemiself = SemiSelfRequestInfo.fromJson(jsonDecode(requestInfo));

    SemiSelfResponseInfo res = SemiSelfResponseInfo(
        result: ret,   // trueで支払い受付、falseで受付不可（受付失敗）
        status: status,
        cautionStatus: cautionStatus,
        uuid: uuid,
        calcResultPay: jsonListSemiself.calcResultPay,
        calcRequestParaPay: jsonListSemiself.requestParaPay,
        cancel: cancel,
        errNo: errNo,
    );
    List<dynamic> cartLogQuery = [];
    int totalAmount = 0;
    int i = 0;
    if (pCom.iniMacInfoMacNo != jsonListSemiself.macNo) {
      // TODO:00004 当面コメントアウト。現在は全てmac_no=3で動作させているため、チェックすると都合が悪い。
      // res.errNo = DlgConfirmMsgKind.MSG_QCNOTPAY_SOCK_ERR.index;
      // return res;
    }

    if (jsonListSemiself != "") {
      macNo  = jsonListSemiself.macNo;
      uuid   = jsonListSemiself.uuid;
      cancel = jsonListSemiself.cancel;
      cartLogQuery = jsonListSemiself.cartLogQuery ?? [];
      try {
        calcResultPay = jsonListSemiself.calcResultPay ?? CalcResultPay(retSts: 0, errMsg:null, posErrCd:0, totalData:null, digitalReceipt:null);
        totalAmount = calcResultPay.totalData?.amount ?? 0;
      } catch(e) {
        TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "CalcResultPayデコード失敗");
      }
      try {
        calcRequestParaPay = jsonListSemiself.requestParaPay ?? CalcRequestParaPay(compCd: 0, streCd: 0, custCode: "", uuid: "");
      } catch(e) {
        TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, "CalcRequestParaPayデコード失敗");
      }
    }

    // 取引可否チェック
    DbManipulationPs db = DbManipulationPs();
    Result result;
    int regNoReceivedFromRegistrationMachine = 1; // 受け取った情報から取得する登録機レジ番号 元regNo
    SemiSelfSocketServer.regNoBeingProcessed = regNoReceivedFromRegistrationMachine;  // TODO
    switch(SemiSelfSocketServer.regNoBeingProcessed) {
      case 0:
        SemiSelfSocketServer.regNoBeingProcessed = regNoReceivedFromRegistrationMachine;
      default:
        if (SemiSelfSocketServer.regNoBeingProcessed == regNoReceivedFromRegistrationMachine) {
          // DBをセレクトして接続最大数以下の場合、DB保存
          String countSql = "SELECT count(*) FROM c_header_log";
          try {
            result = await db.dbCon.execute(countSql);
            if (result.affectedRows > 0) {
              conMax = result.affectedRows;
            } else {
              conMax = 0;
            }
            if (conMax <= ConstQxConnect.QCCONNECT_MAX) {
              String deleteSql = "DELETE FROM p_cart_log WHERE cart_id = '$uuid';";
              result = await db.dbCon.execute(deleteSql);
              cartCnt = 0;
              if (cartLogQuery.length > 0) {
                for (i = 0; i < cartLogQuery.length; i++) {
                  String query = cartLogQuery[i];
                  try {
                    result = await db.dbCon.execute(query);
                    cartCnt ++;
                  } catch(e) {
                    result = await db.dbCon.execute(deleteSql);
                    break;
                  }
                }
                ret = true;
                RegsMem().tTtllog.t100001.stlTaxInAmt = totalAmount;
                status = SemiSelfSocketServer.msgStatusPrePay;
              }
              res = SemiSelfResponseInfo(
                  result: ret,
                  status: status,
                  cautionStatus: cautionStatus,
                  uuid: uuid,
                  calcResultPay: calcResultPay,
                  calcRequestParaPay: calcRequestParaPay,
                  cancel: cancel,
                  errNo: errNo,
              );
              return res;
            }
          } catch (e) {
            // TODO:エラー処理
            res = SemiSelfResponseInfo(
                result: ret,
                status: status,
                cautionStatus: cautionStatus,
                uuid: uuid,
                calcResultPay: null,
                calcRequestParaPay: null,
                cancel: cancel,
                errNo: errNo
            );
            return res;
          }
        } else {
          // 処理中の登録記番号と異なるのでエラーレスポンスを返す。
          TprLog().logAdd(await RcSysChk.getTid(),
              LogLevelDefine.error, "ThreadQcConnect: Over Connect");
          // TODO:ソケット通信でエラー情報を返す処理が必要 semiself_response_soket_model.dart
          res = SemiSelfResponseInfo(
              result: ret,
              status: status,
              cautionStatus: cautionStatus,
              uuid: uuid,
              calcResultPay: calcResultPay,
              calcRequestParaPay: calcRequestParaPay,
              cancel: cancel,
              errNo: errNo
          );
          return res;
        }
    }
    return res;
  }

  /// ソケット通信で取得したデータを共有クラスに格納する
  /// 引数:[tid] タスクID（ログ用）
  /// 引数:[num] 接続機種No
  /// 引数:[readConData] 取得データ
  /// 関連tprxソース: qcConnect.c - ProcQcConnect
  static Future<void>	_procQcConnect(TprMID tid, int num, QcConnectSockReadInfo readConData) async {
    pStat.qcConnect.ConStatus[num].qcStatus = readConData.qcStatus;
    pStat.qcConnect.ConStatus[num].custWait = readConData.custWait;
    pStat.qcConnect.ConStatus[num].opeMode = readConData.opeMode;
    pStat.qcConnect.ConStatus[num].cautionStatus = readConData.cautionStatus;
    if (((await CmCksys.cmNttdPrecaSystem()) != 0)
        || ( (await CmCksys.cmTrkPrecaSystem()) != 0)
        || ( (await CmCksys.cmCogcaSystem()) != 0)
        || ( (await CmCksys.cmRepicaSystem()) != 0)
        || ( (await CmCksys.cmValueCardSystem()) != 0)
        || ( (await CmCksys.cmAjsEmoneySystem() != 0) ) )	{
      pStat.qcConnect.ConStatus[num].autocall_receipt_no = readConData.autocall_receipt_no;
      pStat.qcConnect.ConStatus[num].autocall_mac_no = readConData.autocall_mac_no;
      pStat.qcConnect.ConStatus[num].acbdata = readConData.acbdata;
    }
  }

  /// 終了処理
  /// 関連tprxソース: qcConnect.c - ExitQcConnect
  static void _exitQcConnect() {
    // 共有メモリ開放
    RckyQcSelect.resetQcConnectStatus(0);
    pCom = RxCommonBuf();
    pStat = RxTaskStatBuf();
  }

  /// ユーザーシグナル受取イベント関数(タスク終了)
  /// 関連tprxソース: qcConnect.c - endFunc
  static void endFunc() {
    fEnd = 1;
  }

  /// タイマーループで呼出情報（JSONデータ + p_cart_log）が取得できたかチェックする。
  /// 呼出情報が取得できた場合: クラウドPOS「支払確認」をコール
  /// 呼出情報以外を取得した場合: 15s間取得動作を行い、取得できなければ呼出情報の消去＆エラー
  /// 引数:[tid] タスクID（ログ用）
  /// 戻り値: エラーNo（0=エラーなし）
  static Future<int> recvCallParam(TprMID tid) async {
    // TODO:以下のコードはクラウドPOSの支払い操作の中で実行している可能性があるため、いったんコメントアウトする。
    // 　　　処理を精査して、必要であれば適時処理を復活させる。
    //      現状の現計処理は現計ボタンに紐づくrcKeyCash4Demo()にて実行する。
    return 0;
    int ret = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "QcConnect.recvCallParam(): rxMemPtr get error");
      return RS_NG;
    }
    pCom = xRet.object;
    DbManipulationPs db = DbManipulationPs();
    // String sqlChk1 = "SELECT * FROM p_cart_log"; //カートごとのキャッシュ情報
    // String sqlChk2 = "SELECT * FROM c_header_log_qc tbl_h "
    //     "JOIN c_ej_log_qc tbl_e ON tbl_h.serial_no=tbl_e.serial_no "
    //     "RIGHT JOIN c_data_log_qc tbl_d ON tbl_h.serial_no=tbl_d.serial_no "
    //     "RIGHT JOIN c_status_log_qc tbl_s ON tbl_h.serial_no=tbl_s.serial_no "
    //     "WHERE tbl_h.comp_cd=tbl_e.comp_cd "
    //     "AND tbl_h.stre_cd=tbl_e.stre_cd "
    //     "AND tbl_h.mac_no=tbl_e.mac_no "
    //     "ORDER BY tbl_h.serial_no DESC;"; //実績テーブル
    String sqlChk3 = 'SELECT count(*) FROM p_cart_log WHERE="${uuid}";'; //カートごとのキャッシュ情報
    int serialNo = 0;
    //await Future.delayed(const Duration(seconds: 1));
    try {
      // Result dbRes1 = await db.dbCon.execute(sqlChk1);
      // Result dbRes2 = await db.dbCon.execute(sqlChk2);
      Result dbRes3 = await db.dbCon.execute(sqlChk3);
      TprLog().logAdd(tid, LogLevelDefine.error, "******* recvCallParam ${dbRes3.affectedRows} == ${cartCnt}");
      if (dbRes3.affectedRows == cartCnt) {
        CalcResultPay retDataCheck = await RcClxosPayment.payment(pCom, isCheck: true);

      // if (dbRes1.affectedRows > 0) {
      //   /// 待機画面から精算可能状態にする
      //   selecPayCtrl.isQcUse.value = false;
      //   // TODO:00002 佐野 - どの実績データ(pCom)をセットするか要確認
      //   if (dbRes2.affectedRows > 0) {
      //     Map<String, dynamic> data2 = dbRes2.first.toColumnMap();
      //     serialNo = int.parse(data2["serial_no"]);
      //     // クラウドPOS「支払確認」にセットする値を抽出
      //     await getRxCmnBufFromDB(tid, serialNo);
      //     // クラウドPOS「支払確認」を実行
      //     payResult = await RcClxosPayment.payment(pCom, isCheck: true);
      //     ret = payResult.getErrId();
      //     if (ret == 0) {
      //       // 呼出情報の実績レコードを削除する
      //       Map<String, dynamic> data1 = dbRes1.first.toColumnMap();
      //       cartId = data1["cart_id"];
      //       pluCd = data1["plu_cd"];
      //       await db.dbCon.execute(
      //           "DELETE FROM p_cart_log WHERE cart_id=$cartId AND plu_cd=$pluCd;");
      //       await db.dbCon.execute(
      //           "DELETE FROM c_header_log WHERE serial_no=$serialNo;");
      //       await db.dbCon.execute(
      //           "DELETE FROM c_data_log WHERE serial_no=$serialNo;");
      //       await db.dbCon.execute(
      //           "DELETE FROM c_ej_log WHERE serial_no=$serialNo;");
      //       await db.dbCon.execute(
      //           "DELETE FROM c_status_log WHERE serial_no=$serialNo;");
      //     }
      //     sqlChk1 = "SELECT * FROM p_cart_log WHERE cart_id=$cartId AND plu_cd=$pluCd;";
      //     sqlChk2 = "SELECT * FROM c_header_log tbl_h "
      //         "JOIN c_ej_log tbl_e ON tbl_h.serial_no=tbl_e.serial_no "
      //         "RIGHT JOIN c_data_log tbl_d ON tbl_h.serial_no=tbl_d.serial_no "
      //         "RIGHT JOIN c_status_log tbl_s ON tbl_h.serial_no=tbl_s.serial_no "
      //         "WHERE tbl_h.serial_no=$serialNo;";
      //     dbRes1 = await db.dbCon.execute(sqlChk1);
      //     dbRes2 = await db.dbCon.execute(sqlChk2);
      //     if ((dbRes1.affectedRows == 0) && (dbRes2.affectedRows == 0)) {
      //       // 処理中登録機Noを0にする
      //       regNo = 0;
      //     }
      //   }
        //break;
      } else {
        roopCnt++; //DBからレコード取得失敗時、カウンタを起動
      }
      if (roopCnt == 15) {
        //レコード取得失敗後、15s経過したらエラー表示＆呼出情報を削除
        roopCnt = 0;
        _exitQcConnect();
        TprLog().logAdd(tid, LogLevelDefine.normal,
            "QcConnect.recvCallParam(): db_PQexec no record!!");
        ret = DlgConfirmMsgKind.MSG_SVR_COM_ERR.dlgId; //暫定
      }
    } catch (e) {
      //Cソース「db_PQexec() == NULL」時に相当
      TprLog().logAdd(tid, LogLevelDefine.error,
          "QcConnect.recvCallParam(): db_PQexec failed!!");
      ret = DlgConfirmMsgKind.MSG_SVR_COM_ERR.dlgId; //暫定
    }
    return ret;
  }

  /// 指定シリアルNoからクラウドPOS「支払確認」へ渡すパラメタをDBテーブル(実績系)から取得する。
  /// 取得データは、クラス変数pComに格納する
  /// 引数:[tid] タスクID（ログ用）
  /// 引数:[serialNo] シリアルNo
  /// 戻り値: エラーNo (0=エラーなし)
  static Future<int > getRxCmnBufFromDB(TprMID tid, int serialNo) async {
    DbManipulationPs db = DbManipulationPs();
    String sql_h = "SELECT * FROM c_header_log_qc WHERE serial_no=$serialNo;";
    String sql_d1 = "SELECT * FROM c_data_log_qc WHERE serial_no=$serialNo AND func_cd='100001';";
    String sql_d2 = "SELECT * FROM c_data_log_qc WHERE serial_no=$serialNo AND func_cd='100100';";
    String sql_d3 = "SELECT * FROM c_data_log_qc WHERE serial_no=$serialNo AND func_cd='121000';";
    String sql_s = "SELECT trim((regexp_split_to_array(status_data,CHR(9)))[9]) AS sptend_cnt FROM c_status_log_qc WHERE serial_no=$serialNo AND func_cd='100001';";
    //String sql_s2 = "SELECT trim((regexp_split_to_array(status_data,CHR(9)))[1]) AS crdt_no, trim((regexp_split_to_array(status_data,CHR(9)))[2]) AS ttl_lvl FROM c_status_log_qc WHERE serial_no=$serialNo AND func_cd=400000;";
    String sql_p = "SELECT * FROM p_cart_log;";
    int seqCnt = 0;
    try {
      Result dbRes_h = await db.dbCon.execute(sql_h);
      Result dbRes_d1 = await db.dbCon.execute(sql_d1);
      Result dbRes_d2 = await db.dbCon.execute(sql_d2);
      Result dbRes_d3 = await db.dbCon.execute(sql_d3);
      Result dbRes_s = await db.dbCon.execute(sql_s);
      //Result dbRes_p = await db.dbCon.execute(sql_p);
      // 実績テーブルに指定シリアルNoのレコードがないかチェック
      if ((dbRes_h.affectedRows == 0) /*|| (dbRes_p.affectedRows == 0)*/) {
        return DlgConfirmMsgKind.MSG_FILEREADERR.dlgId; // "DB読込エラー"
      }
      Map<String, dynamic> data_h = dbRes_h.first.toColumnMap();
      //Map<String, dynamic> data_p = dbRes_p.first.toColumnMap();
      // 実績テーブルからクラス変数pComに格納する
      // TODO:クラウドPOS「支払確認」の必須キーをDBより取得。他キーは要検討
      // p_cart_log
      // c_header_log
      pCom.dbRegCtrl.compCd = int.parse(data_h["comp_cd"]);
      pCom.dbRegCtrl.streCd = int.parse(data_h["stre_cd"]);
      pCom.dbRegCtrl.macNo = int.parse(data_h["mac_no"]);
      pCom.bkLastRequestData?.custCode = data_h["cust_no"];
      pCom.bkTHeader.ope_mode_flg = int.parse(data_h["ope_mode_flg"]);
      // c_status_log
      if (dbRes_s.affectedRows > 0) {
        Map<String, dynamic> data_s = dbRes_d1.first.toColumnMap();
        pCom.bkTtlLog.t100001Sts.sptendCnt = int.parse(data_s["sptend_cnt"]);
        if (pCom.bkTtlLog.t100001Sts.sptendCnt == 0) {
          return DlgConfirmMsgKind.MSG_FILEREADERR.dlgId; // "DB読込エラー"
        }
      } else {
        return DlgConfirmMsgKind.MSG_FILEREADERR.dlgId; // "DB読込エラー"
      }
      // c_data_log
      if ((dbRes_d1.affectedRows > 0) && (dbRes_d2.affectedRows > 0) && (dbRes_d3.affectedRows > 0)) {
        Map<String, dynamic> data_d1 = dbRes_d1.first.toColumnMap();
        Map<String, dynamic> data_d2 = dbRes_d2.first.toColumnMap();
        Map<String, dynamic> data_d3 = dbRes_d3.first.toColumnMap();
        pCom.bkTtlLog.t100001.qty = int.parse(data_d1["n_data6"]);
        // TODO:00002 佐野 - スプリットテンド回数が1のみの処理（複数の場合は要検討）
        for (int i = 0; i < pCom.bkTtlLog.t100001Sts.sptendCnt; i++) {
          pCom.bkTtlLog.t100100[i].sptendCd = int.parse(data_d2["n_data1"]);
          pCom.bkTtlLog.t100100[i].sptendData = int.parse(data_d2["n_data2"]);
          pCom.bkTtlLog.t100100[i].sptendSht =  int.parse(data_d2["n_data6"]);
        }
        // TODO:00002 佐野 - バーコードNoは要検討（パラメータが違う可能性あり）
        pCom.bkTtlLog.t121000.barcodeAmt = int.parse(data_d3["c_data5"]);
      } else {
        return DlgConfirmMsgKind.MSG_FILEREADERR.dlgId; // "DB読込エラー"
      }
    } catch (e) {
      //Cソース「db_PQexec() == NULL」時に相当
      TprLog().logAdd(tid, LogLevelDefine.error,
          "QcConnect.recvCallParam(): db_PQexec failed!!");
      return DlgConfirmMsgKind.MSG_FILEREADERR.dlgId; // "DB読込エラー"
    }
    return 0;
  }
}