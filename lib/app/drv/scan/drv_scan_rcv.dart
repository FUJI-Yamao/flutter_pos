/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';
import 'dart:isolate';

import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:intl/intl.dart';

import '../../common/cmn_sysfunc.dart';
import './drv_scan_com.dart';
import '../common/com_datetime.dart';
import '../common/com_rpt_tool.dart';
import '../../common/date_util.dart';
import '../../common/environment.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/lib/drv_com.dart';
import '../../inc/lib/qcConnect.dart';
import '../../inc/lib/spqc.dart';
import "../../inc/lib/rs232c.dart";
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../lib/apllib/qr2txt.dart';
import '../../lib/apllib/competition_ini.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/cm_ean/set_cdig.dart';
import '../../fb/fb_lib.dart';

/// 関連tprxソース:drv_scan_rcv_plus.c
///  struct tMioPluData
class tMioPluData {
  /// 変数
  String plu_cd = ""; //char[13 + 1]
  int qty = 0;
}

/// 関連tprxソース:drv_scan_rcv_plus.c
///
class ScanRcv {
  /// 定数
  static const MIO_HEADER_SIZ = 33;
  static const MIO_TRAILER_SIZ = 2;
  static const MIO_PLUDATA_SIZ = 18;
  static const CRcode = "\x0D";
  static const QR_BIN_Q = "\x51";
  static const QR_BIN_CR = "\x0D";
  static const SCAN_PASSPORT_CODE = 'P';
  static const QR_HEADER_CODE_DIGIT = 4;
  static const QR_HEADER_TTL_DIGIT = 60;
  static const QR_AI_CHK_HEADER_CODE = "9999";
  static const COMPETITION_INI_SALE_DATE = 3;
  static const COMPETITION_INI_GETMEM = 0;

  static const MIO_QRREADBUF_SIZE = (1024 + 1);

  /// 変数
//List<String> SerialReadBuf = []..length = (ScanCom.SCAN_RCVBUF_SIZE_MAX + 1);
  String SerialReadBuf = "";
  static int data_count = 0;
  static int make_count = 0;
  static int qr_status = 0;
  static int mio_make_count = 0;
  static int mio_qr_status = 0;
  static String mio_QRReadBuf = ""; //uchar[1024 + 1]
  static String QRReadBuf = ""; //uchar[4096 + 1]
  static String filename = ""; //uchar[128 + 1]
  static int fPassportScanning =
      0; /* パスポートスキャンフラグ PASSPORT_SCAN_IDLE:アイドル、PASSPORT_SCAN_PROCESSING:スキャン中 */
  static int url_format_flg = 0;
  static int qr_http_flag = 0; /*flag for invalid qr code containing http in the first 15 chars. 0: valid or not a QR 1: invalid 2: QR not applicable for check*/

  /// 変数 SS_CR2 (特定CR2接続仕様)
  static int cr40_qr_status = 0;
  static int ope_mode = 0;
  static String datetime = ""; //char[15]
  static String now_datetime = ""; //char[19]
  static int qr_mac_no = 0;
  static int qr_rcpt_no = 0;
  static int qr_qty = 0;
  static int qr_amt = 0;
  static int cr40_read_page = 0;
  static int page_now = 0;
  static int page_max = 0;
  ScanCom scanCom = ScanCom();
  TprLog myLog = TprLog();
  ComRptTool comRptTool = ComRptTool();
  Qr2Txt qr2txt = Qr2Txt();

  /// 対象データが数値（0～9）であるかチェックする
  /// 引数:[data] 対象データ
  /// 引数:[len] 対象データ長
  /// 戻り値：true = 全て数値
  ///       false = 数値では無いものが含まれている
  static bool checkNumData(String data, [int len = 0]) {
    List<String> data0 = data.split("");
    for (int i = 0; i < len; i++) {
      if (int.tryParse(data0[i]) == null) {
        return false;
      }
    }
    return true;
  }

  /// バーコードのチェックデジットとの整合性をチェックする。
  ///
  /// 引数:[data] 対象データ
  ///
  /// 引数:[len] 対象データ長
  ///
  /// 戻り値：true = チェックOK
  ///
  ///       false = チェックNG
  ///
  /// 参考URL：https://www.gs1jp.org/code/jan/check_digit.html
  ///
  /// 関連tprxソース: drv_scan_rcv_plus.c - check_cd_data()
  static bool checkCdData(String data, int len) {
    bool ret = true;
    int i = 0;
    int checkDigit = data.codeUnitAt(len - 1) - 0x30;

    len--;
    i = 0;
    while (len != 0) {
      len --;
      i += ((data.codeUnitAt(len) - 0x30) * 3);
      if (len == 0) {
        break;
      }
      len--;
      i += (data.codeUnitAt(len) - 0x30);
    }
    i = (10 - (i % 10));
    if (i == 10) {
      i = 0;
    }
    if (checkDigit != i) {
      ret = false;
    }

    return (ret);
  }

  /// 対象データが数値（0～9）,およびアルファベット（a～z、A～Z）であるかチェックする
  ///
  /// 引数:[data] 対象データ
  ///
  /// 引数:[len] 対象データ長
  ///
  /// 戻り値：true = 全て数値 or アルファベットである
  ///
  ///       false = 数値でもアルファベットでも無いものが含まれている
  ///
  /// 関連tprxソース: drv_scan_rcv_plus.c - check_alpha_data()
  static bool checkAlphaData (String data, int len) {
    bool ret = RegExp(r"[a-zA-Z0-9]").hasMatch(data.substring(0, len));
    return (ret);
  }

  /// 受信データのパラメータチェック（QR）
  ///
  /// 引数:[_parentSendPort] 親タスクへの通信ポート
  ///
  /// 引数:[tid] タスクID
  ///
  /// 引数:[devmsg] 受信データ（１バイト）
  ///
  /// 戻り値:なし
  ///
  /// 関連tprxソース: drv_scan_rcv_plus.c - drv_scan_RcvQRtoMakeData()
  Future<void> _drvScanRcvQRtoMakeData(SendPort _parentSendPort, TprTID tid, String devmsg) async {

    // v1のオリジナルコードでコメントアウト
	  // if (await CmCksys.cmQCashierSystem() == 0) {
		//   return;
	  // }

    if (await checkRepicaScanMode(tid) != 0) {
      ;	// 他のQR処理をしない
    } else {
      if(await CmCksys.cmPluralQRSystem() != 0) {
        await _drvScanRcvQRtoMakeData2(_parentSendPort, tid, devmsg);
        return;
      }

      if (CompileFlag.SS_CR2) {
        if( await CmCksys.cmPaymentMngSystem() != 0){
          await _drvScanRcvQRtoMakeDataCR40(tid, devmsg);
          return;
        }
      }

      if(await CmCksys.cmShopAndGoSystem() != 0) {
        await _drvScanRcvQRtoMakeDataShopAndGo(_parentSendPort, tid, devmsg);
        return;
      }
    }

    if (qr_status == 1) {
      await qr2txt.cmQrToTxtWrite(devmsg, filename, 1);
    }
    if (make_count == 0) {
      filename = "";
      QRReadBuf = "";
    }
    QRReadBuf += devmsg;
    make_count++;

    if ((make_count <= 15) && (qr_http_flag == 0) && (QRReadBuf.contains("http"))) {
      qr_http_flag = 1;
      myLog.logAdd(tid, LogLevelDefine.normal,
          "drv_scan_RcvQRtoMakeData: QR contains http in the first 15 chars, " +
          "qr_http_flag=$qr_http_flag}\n");
    }

    if (make_count == QR_HEADER_TTL_DIGIT) {
      if (QRReadBuf.substring(0, QR_HEADER_CODE_DIGIT) == QR_AI_CHK_HEADER_CODE) {
        qr_http_flag = 2;
        myLog.logAdd(tid, LogLevelDefine.normal,
            "drv_scan_RcvQRtoMakeData: QR starts with 9999, do not check http\n");
				DateTime dt = DateTime.now();
        filename =  DateFormat('yyyyMMddHHmmss').format(dt) + "_" +
                    QRReadBuf.substring(QR_HEADER_CODE_DIGIT);
        SerialReadBuf = "${QR_BIN_Q}$filename";
        data_count = SerialReadBuf.length;
        qr_status = 1;
      }
    }

    if (devmsg == CRcode) {
      if (qr_status == 0) {
        make_count = 0;
        fPassportScanning = ScanCom.PASSPORT_SCAN_IDLE; /* パスポートスキャンフラグをクリア */
        // v1のオリジナルコードでコメントアウト
        // myLog.logAdd(tid, LogLevelDefine.error,
        //     "drv_scan_RcvQRtoMakeData: clear qr_http_flag=0\n");

        if (await checkRepicaScanMode(tid) != 0) {
          SerialReadBuf = "K" + QRReadBuf;			// Code128へすり替える
          data_count = SerialReadBuf.length - 1;  // 終了文字を二重にセットしないため
          await _drvScanRcvCr(_parentSendPort, tid,QR_BIN_CR);
        } else if (await CmCksys.cmSp1QrReadSystem() != 0) {
          SerialReadBuf = "Q" + QRReadBuf;
          data_count = SerialReadBuf.length- 1;		// 終了文字を二重にセットしないため
          await _drvScanRcvCr(_parentSendPort, tid,QR_BIN_CR);
          myLog.logAdd(tid, LogLevelDefine.normal,
              runtimeType.toString() + " SerialReadBuf[$SerialReadBuf]");
        }
        qr_http_flag = 0;
        return;
      }
      qr2txt.cmQrToTxtChmod();
      qr_status = 0;
      make_count = 0;
      await _drvScanRcvCr(_parentSendPort, tid, QR_BIN_CR);
      return;
    }
  }

  /// 受信データのパラメータチェック（QR2）
  ///
  /// 引数:[_parentSendPort] 親タスクへの通信ポート
  ///
  /// 引数:[tid] タスクID
  ///
  /// 引数:[devmsg] 受信データ（１バイト）
  ///
  /// 関連tprxソース: drv_scan_rcv_plus.c - drv_scan_RcvQRtoMakeData2()
  Future<void> _drvScanRcvQRtoMakeData2(SendPort _parentSendPort, TprTID tid, String devmsg) async {
    String tmpbuf = "";
    String erlog = "";
    int i = 0;
    int count = 0;
    const int len = 1 + 12 + 1;

    if (make_count == 0) {
      filename = "";
      QRReadBuf = "";
    }
    QRReadBuf += devmsg;
    make_count++;
    List<String> QRReadBuf0 = QRReadBuf.split("");
    /*check if contains 'http' in first 15 chars */
    if((make_count <= 15) && (qr_http_flag == 0) && (QRReadBuf.indexOf("http") >= 0)) {
      myLog.logAdd(tid, LogLevelDefine.error,
          "drv_scan_RcvQRtoMakeData2: QR contains http in the first 15 chars, qr_http_flag=1\n");
      qr_http_flag = 1;
    }
    if ((make_count == 13) && (QRReadBuf0[13 - 1] == ',')) {
      qr_status = 1;
    }

    if (devmsg == CRcode) {
      if ((qr_status == 1) &&
          (((make_count % 13) - 1) == 0) && (QRReadBuf0[make_count - 2] == ',')) {
        tmpbuf = "";
        count = 0;
        for (i = 0; i < make_count; i++) {
          if (((i + 1) % 13) == 0)  {
            if (QRReadBuf0[i] == ',') {
              tmpbuf += ScanCom.SCAN_EAN13_CODE;
              tmpbuf += SetCdig.cmSetCdigit(QRReadBuf.substring(i - 12, i) + '0');
              count += len;
            } else {
              myLog.logAdd(tid, LogLevelDefine.error,
                  "drv_scan_RcvQRtoMakeData2() [$i] error[$QRReadBuf]\n");
              qr_status = 0;
              break;
            }
          }
        }
        if (qr_status == 1) {
          for(i = 0; i < count; i += len) {
            SerialReadBuf = tmpbuf.substring(i, i + len);
            data_count = SerialReadBuf.length;
            await _drvScanRcvCr(_parentSendPort, tid, QR_BIN_CR);
          }
        }
      }
      qr_status = 0;
      make_count = 0;
      fPassportScanning = ScanCom.PASSPORT_SCAN_IDLE; /* パスポートスキャンフラグをクリア */
      return;
    }
  }

  /// "_drvScanRcvEx()"一部を関数化（"_drvScanRcvCr()"でもコールしたい為）
  ///
  /// 引数:[tid] タスクID
  ///
  /// 戻り値:なし
  ///
  /// 関連tprxソース: drv_scan_rcv_plus.c - RcvExSubProc()
  void _rcvExSubProc(TprTID tid) {
    String CRTime = "";

    CRTime = DateUtil.getNowStr(DateUtil.formatForLogDetail);
    scanCom.drvScanInitVariable(tid);

		cmRs232cLogWriteDate(ScanCom.scan_info.device, Rs232cCommKind.RS232C_RCV,
        SerialReadBuf, data_count, CRTime);
    fPassportScanning = ScanCom.PASSPORT_SCAN_IDLE; /* パスポートスキャンフラグをクリア */
  }


  /// スキャナからのデータを取得する
  ///
  /// 引数:[_parentSendPort] 親タスクへの通信ポート
  ///
  /// 引数:[tid] タスクID
  ///
  /// 引数:[devmsg] 受信データ（１バイト）
  ///
  /// 戻り値：0 = Normal End(IDLE)
  ///
  ///        1 = Normal End(RCV_CR/EX)
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_rcv_plus.c - drv_scan_SerialRcv()
  Future<int> drvScanSerialRcv(SendPort _parentSendPort, TprTID tid, String devmsg) async {
    int ret = 0;

    switch (ScanCom.scan_info.state) {
      case SCAN_STATE.SCAN_STATE_IDLE:
        await drvScanRcvIdle(_parentSendPort, tid, devmsg);
        ret = 0;
        break;
      case SCAN_STATE.SCAN_STATE_RCV_CR:
        await _drvScanRcvCr(_parentSendPort, tid, devmsg);
        ret = 1;
        break;
      case SCAN_STATE.SCAN_STATE_RCV_EX:
        _drvScanRcvEx(_parentSendPort, tid, devmsg);
        ret = 1;
        break;
      default:
			  cmRs232cLogWrite(ScanCom.scan_info.device, Rs232cCommKind.RS232C_RCV, devmsg, 1, "");
        ScanCom.scan_info.state = SCAN_STATE.SCAN_STATE_IDLE;
        ret = -1;
        break;
    }
    return ret;
  }

  /// 受信データのパラメータチェック（MIO）
  ///
  /// 引数:[_parentSendPort] 親タスクへの通信ポート
  ///
  /// 引数:[tid] タスクID
  ///
  /// 引数:[devmsg] 受信データ（１バイト）
  ///
  /// 戻り値：true = Normal End
  ///
  ///       false = Error
  ///
  /// 関連tprxソース: drv_scan_rcv_plus.c - drv_scan_RcvMiotoMakeData()
  Future<bool> _drvScanRcvMiotoMakeData(SendPort _parentSendPort,
      TprTID tid, String devmsg) async {
    String fname = ""; //char[128 + 1]
    String mio_filename = ""; //char[128 + 1]
    String erlog = ""; //char[128]
    String tmpbuf = ""; //char[128]
    String yyyymmddhhmm = ""; //char[12 + 1]
    String sale_date = ""; //char[RX_COUNTER_DATE_SIZE + 1]
    int order_no = 0,
        table_no = 0,
        guest_qty = 0,
        term_no = 0,
        pen_id = 0,
        qty = 0;
    int i = 0, MioPluDataCount = 0, posi = 0, key = 0;
    bool result = true;
    int errno = 0;  // TODO:エラーコードを出すことができないか？
    String contents = "";  // ファイル書き込み

    var dt = DateTime.now();
		RxCommonBuf		pCom = RxCommonBuf();
    File fp;

    do {
      if (pCom == null) {
        erlog = "_drvScanRcvMiotoMakeData() rxMemPtr error devmsg[$devmsg]\n";
        result = false;
        break;
      }

      if (mio_make_count == 0) {
        mio_QRReadBuf = "";
        mio_qr_status = 1;
      }

      mio_QRReadBuf = mio_QRReadBuf + devmsg;
      mio_make_count++;

      if (mio_make_count > (MIO_QRREADBUF_SIZE - 3)) {
        erlog = "_drvScanRcvMiotoMakeData() mio_make_count over error[$mio_make_count]\n";
        result = false;
        break;
      }

      if (devmsg == CRcode) {
        mio_filename = "";
        mio_make_count--;
        MioPluDataCount = ((mio_make_count - (MIO_HEADER_SIZ + MIO_TRAILER_SIZ))
                              / MIO_PLUDATA_SIZ).toInt();
        if ((mio_make_count < (MIO_HEADER_SIZ + MIO_TRAILER_SIZ + MIO_PLUDATA_SIZ)) ||
          (((mio_make_count - (MIO_HEADER_SIZ + MIO_TRAILER_SIZ)) % MIO_PLUDATA_SIZ) != 0) ||
            (MioPluDataCount < 1)) {
          erlog = "_drvScanRcvMiotoMakeData() mio_make_count size error" +
              "[$mio_make_count][$MioPluDataCount][$mio_QRReadBuf]\n";
          result = false;
          break;
        }
        int tm_mday = int.parse(mio_QRReadBuf.substring(1, 3));
        int tm_mon = int.parse(mio_QRReadBuf.substring(3, 5));
        int tm_year = int.parse(mio_QRReadBuf.substring(5, 9));
        int tm_hour = int.parse(mio_QRReadBuf.substring(9, 11));
        int tm_min = int.parse(mio_QRReadBuf.substring(11, 13));
        int tm_sec = int.parse(mio_QRReadBuf.substring(13, 15));
        try {
          DateTime dt = DateTime(
              tm_year, tm_mon, tm_mday, tm_hour, tm_min, tm_sec);
        } catch (e) {
          erlog = "_drvScanRcvMiotoMakeData() mktime error[$mio_QRReadBuf][$e]\n";
          result = false;
          break;
        }
        tmpbuf = mio_QRReadBuf.substring(15, 15 + 6);
        order_no = int.parse(tmpbuf);
        if (order_no < 1) {
          erlog = "_drvScanRcvMiotoMakeData() order no[$order_no] error[$mio_QRReadBuf]\n";
          result = false;
          break;
        }
        tmpbuf = mio_QRReadBuf.substring(21, 21 + 4);
        table_no = int.parse(tmpbuf);
        if (table_no != 0) {
          erlog = "_drvScanRcvMiotoMakeData() table no[$table_no] error[$mio_QRReadBuf]\n";
          result = false;
          break;
        }
        tmpbuf = mio_QRReadBuf.substring(25, 25 + 2);
        guest_qty = int.parse(tmpbuf);
        if (guest_qty != 0) {
          erlog = "_drvScanRcvMiotoMakeData() guest no[$guest_qty] error[$mio_QRReadBuf]\n";
          result = false;
          break;
        }
        tmpbuf = mio_QRReadBuf.substring(27, 27 + 2);
        term_no = int.parse(tmpbuf);
        if ((term_no < 1) || (term_no > 99)) {
          erlog = "_drvScanRcvMiotoMakeData() term no[$term_no] error[$mio_QRReadBuf]\n";
          result = false;
          break;
        }
        tmpbuf = mio_QRReadBuf.substring(29, 29 + 4);
        pen_id = int.parse(tmpbuf);
        if (pen_id != 0) {
          erlog = "_drvScanRcvMiotoMakeData() pen id[$pen_id] error[$mio_QRReadBuf]\n";
          result = false;
          break;
        }
        String tmp1 = mio_QRReadBuf.substring(mio_make_count - 2, mio_make_count - 2 + 1);
        String tmp2 = mio_QRReadBuf.substring(mio_make_count - 1, mio_make_count - 1 + 1);
        if ((tmp1 != '0') || (tmp2 != '0')) {
          erlog = "_drvScanRcvMiotoMakeData() printer status position 00 error" +
                  "[$tmp1$tmp2] error[$mio_QRReadBuf]\n";
          result = false;
          break;
        }
        posi = MIO_HEADER_SIZ;
        qty = 0;
        List<tMioPluData> pMioPluData = <tMioPluData>[];
        for ( i = 0; i < MioPluDataCount; i++ ) {
          pMioPluData.add(tMioPluData());
          tmpbuf = ('0' * 9) + mio_QRReadBuf.substring(posi, posi + 4);
          pMioPluData[i].plu_cd = tmpbuf.substring(0, 13);
          posi += 16;
          tmpbuf = mio_QRReadBuf.substring(posi, posi + 2);
          pMioPluData[i].qty = int.parse(tmpbuf);
          qty += pMioPluData[i].qty;
          posi += 2;
        }
        CompetitionIniRet ret = await CompetitionIni.competitionIniGet(tid,
            CompetitionIniLists.COMPETITION_INI_SALE_DATE,
            CompetitionIniType.COMPETITION_INI_GETMEM);
        sale_date = ret.value;
        tmpbuf = sale_date.replaceAll("-", "");
        DateTime dt0 = DateTime.now();
        fname = "${DateFormat('yyyyMMddHHmmss').format(dt0)}_01${tmpbuf}"
                "${DateFormat('yyyyMMddHHmm').format(dt)}"
                "${((term_no * 100) + (order_no / 10000)).toInt().toString().padLeft(6, '0')}"
                "${(order_no % 10000).toString().padLeft(4, '0')}"
                "0001${qty.toString().padLeft(4,'0')}000000000101";
        mio_filename = "/tmp/QR$fname.TXT";
        final File fp = File(mio_filename);
        try {
          if (!Directory('/tmp').existsSync()) {
            Directory('/tmp').createSync(recursive: true);
          }
        } catch(e) {
          erlog = "_drvScanRcvMiotoMakeData() createSync('/tmp') " +
                  "error[${errno}] [$MioPluDataCount][$mio_QRReadBuf]\n";
          result = false;
          break;
        }

        for (i = 0; i < MioPluDataCount; i++) {
          if ((pCom.dbTrm.mulSmlDscUsetyp == 1) ||
              (pCom.dbTrm.mulSmlDscUsetyp == 2)) {
            try {
              contents += "0013${pMioPluData[i].plu_cd}\n";
              await fp.writeAsString(contents);
            } catch(e) {
              erlog = "_drvScanRcvMiotoMakeData() "
                      "writeAsString($mio_filename,$QR_AI_KEY$key) "
                      "error[$e] [$MioPluDataCount][$mio_QRReadBuf]\n";
              result = false;
              break;
            }
          }
          if ( pMioPluData[i].qty > 1 ) {
            if ((pCom.dbTrm.mulSmlDscUsetyp == 1) ||
                (pCom.dbTrm.mulSmlDscUsetyp == 2)) {
              try {
                contents += "${QR_AI_KEY.toString().padLeft(2, '0')}03"
                            "${FuncKey.KY_MUL.keyId.toString().padLeft(3, '0')}\n";
                fp.writeAsString(contents);
              } catch(e) {
                erlog = "_drvScanRcvMiotoMakeData() "
                        "writeAsString3[$i]($mio_filename,${QR_AI_KEY}${FuncKey.KY_MUL.keyId}) "
                        "error[$e] [$MioPluDataCount][$mio_QRReadBuf]\n";
                result = false;
                break;
              }
            }
            if ((pMioPluData[i].qty / 10) > 0) {
              switch ((pMioPluData[i].qty / 10).toInt()) {
                case 1: key = FuncKey.KY_1.keyId; break;
                case 2: key = FuncKey.KY_2.keyId; break;
                case 3: key = FuncKey.KY_3.keyId; break;
                case 4: key = FuncKey.KY_4.keyId; break;
                case 5: key = FuncKey.KY_5.keyId; break;
                case 6: key = FuncKey.KY_6.keyId; break;
                case 7: key = FuncKey.KY_7.keyId; break;
                case 8: key = FuncKey.KY_8.keyId; break;
                case 9: key = FuncKey.KY_9.keyId; break;
                case 0:
                default:key = FuncKey.KY_0.keyId; break;
              }
              try {
                contents += "${QR_AI_KEY.toString().padLeft(2, '0')}03"
                            "${key.toString().padLeft(3, '0')}\n";
                fp.writeAsString(contents);
              } catch(e) {
                erlog = "_drvScanRcvMiotoMakeData() "
                        "fprintf3[$i]($mio_filename,${QR_AI_KEY}${key}) "
                        "error[$e] [$MioPluDataCount][$mio_QRReadBuf]\n";
                result = false;
                break;
              }
            }
            switch (pMioPluData[i].qty % 10) {
              case 1: key = FuncKey.KY_1.keyId; break;
              case 2: key = FuncKey.KY_2.keyId; break;
              case 3: key = FuncKey.KY_3.keyId; break;
              case 4: key = FuncKey.KY_4.keyId; break;
              case 5: key = FuncKey.KY_5.keyId; break;
              case 6: key = FuncKey.KY_6.keyId; break;
              case 7: key = FuncKey.KY_7.keyId; break;
              case 8: key = FuncKey.KY_8.keyId; break;
              case 9: key = FuncKey.KY_9.keyId; break;
              case 0:
              default:key = FuncKey.KY_0.keyId; break;
            }
            try {
              contents += "${QR_AI_KEY.toString().padLeft(2, '0')}03"
                          "${key.toString().padLeft(3, '0')}\n";
              fp.writeAsString(contents);
            } catch(e) {
              erlog = "_drvScanRcvMiotoMakeData() "
                      "fprintf2[$i]($mio_filename,${QR_AI_KEY}${key}) "
                      "error[$e] [$MioPluDataCount][$mio_QRReadBuf]\n";
              result = false;
              break;
            }
            if ((pCom.dbTrm.mulSmlDscUsetyp == 1) ||
                (pCom.dbTrm.mulSmlDscUsetyp == 2)) {
              try {
                contents += "${QR_AI_KEY.toString().padLeft(2, '0')}03"
                            "${FuncKey.KY_MUL.keyId.toString().padLeft(3, '0')}\n";
                fp.writeAsString(contents);
              } catch(e) {
                erlog = "_drvScanRcvMiotoMakeData() "
                        "fprintf3[$i]($mio_filename,${QR_AI_KEY}${FuncKey.KY_PRC.keyId}) "
                        "error[$e] [$MioPluDataCount][$mio_QRReadBuf]\n";
                result = false;
                break;
              }
            } else {
              try {
                contents += "${QR_AI_KEY.toString().padLeft(2, '0')}03"
                            "${FuncKey.KY_MUL.keyId.toString().padLeft(3, '0') }\n";
                fp.writeAsString(contents);
              } catch(e) {
                erlog = "_drvScanRcvMiotoMakeData() "
                        "fprintf3[$i]($mio_filename,${QR_AI_KEY}${FuncKey.KY_MUL.keyId}) " +
                        "error[$e] [$MioPluDataCount][$mio_QRReadBuf]\n";
                result = false;
                break;
              }
            }
          }
          if (!((pCom.dbTrm.mulSmlDscUsetyp == 1) ||
                (pCom.dbTrm.mulSmlDscUsetyp == 2))) {
            try {
              contents += "0013${pMioPluData[i].plu_cd}\n";
              fp.writeAsString(contents);
            } catch(e) {
              erlog = "_drvScanRcvMiotoMakeData() "
                      "fprintf[$i]($mio_filename,${QR_AI_KEY}${key}) "
                      "error[$e] [$MioPluDataCount][$mio_QRReadBuf]\n";
              result = false;
              break;
            }
          }
        }
        SerialReadBuf = "${QR_BIN_Q}$fname";
        data_count = SerialReadBuf.length;
        await _drvScanRcvCr(_parentSendPort, tid, QR_BIN_CR);
        mio_make_count = 0;
        mio_qr_status = 0;
        mio_QRReadBuf = "";
      }
    }while(false);

_drvScanRcvMiotoMakeData_End:
    if (result == false) {
      myLog.logAdd(tid, LogLevelDefine.error, erlog);
      mio_make_count = 0;
      mio_qr_status = 0;
      mio_QRReadBuf = "";
    }
    return (result);
  }

  /// バーコードデータの整合性をチェックする
  ///
  /// 引数:[tid] タスクID
  ///
  /// 引数:[scan_data] 受信データ
  ///
  /// 引数:[data_len] 受信データ長
  ///
  /// 戻り値：true = Normal End
  ///
  ///       false = Error
  ///
  /// 関連tprxソース: drv_scan_rcv_plus.c - drv_scan_data_check()
  Future<bool> drvScanDataCheck(TprTID tid, String scan_data0, int data_len) async {
    bool result = false;
    List<String> scan_data = scan_data0.split('');

    switch (scan_data[0]) {
      case ScanCom.SCAN_UPCA_CODE:
        if (data_len == ScanCom.SCAN_UPCA_SIZE) {
          final upca = scan_data0.substring(
              ScanCom.SCAN_OFFSET_LABEL_ID,
              ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_UPCA_DATA_SIZE);
          if ((result = checkNumData(upca)) == true) {
            if ((result = checkCdData(upca, ScanCom.SCAN_UPCA_DATA_SIZE)) == false) {
              myLog.logAdd(tid, LogLevelDefine.error, " UPCA cd error");
            } else {
              if (scan_data0.substring(0, ScanCom.SCAN_OFFSET_LABEL_ID +
                  ScanCom.SCAN_UPCA_DATA_SIZE) == "A856102000260") {
                ScanCom.object_out = 1;
                ScanCom.object_data_flg = 1;
                myLog.logAdd(tid, LogLevelDefine.error, " object OUT");
              }
              if (scan_data0.substring(0, ScanCom.SCAN_OFFSET_LABEL_ID +
                  ScanCom.SCAN_UPCA_DATA_SIZE) == "A856102000253") {
                ScanCom.object_in = 1;
                ScanCom.object_data_flg = 1;
                myLog.logAdd(tid, LogLevelDefine.error, " object IN");
              }
            }
          } else {
            myLog.logAdd(tid, LogLevelDefine.error, " UPCA num error");
          }
        } else {
          myLog.logAdd(tid, LogLevelDefine.error, " UPCA length error");
        }
        break;
      case ScanCom.SCAN_UPCE_CODE:
        if ((data_len == ScanCom.SCAN_UPCE_SIZE) &&
            (scan_data[ScanCom.SCAN_OFFSET_LABEL_ID] == '0')) {
          final upce = scan_data0.substring(
              ScanCom.SCAN_OFFSET_LABEL_ID,
              ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_UPCE_DATA_SIZE);
          if ((result = checkNumData(upce, ScanCom.SCAN_UPCE_DATA_SIZE)) == false) {
            myLog.logAdd(tid, LogLevelDefine.error, " UPCE num error");
          }
        } else {
          myLog.logAdd(tid, LogLevelDefine.error, " UPCE length error");
        }
        break;
      case ScanCom.SCAN_EAN13_CODE:
        if (scan_data[ScanCom.SCAN_OFFSET_LABEL_ID] == ScanCom.SCAN_EAN8_CODE) {
          if (data_len == ScanCom.SCAN_EAN8_SIZE) {
            final ean13 = scan_data0.substring(
                ScanCom.SCAN_OFFSET_LABEL_ID2,
                ScanCom.SCAN_OFFSET_LABEL_ID2 + ScanCom.SCAN_EAN8_DATA_SIZE);
            if ((result = checkNumData(ean13, ScanCom.SCAN_EAN8_DATA_SIZE)) == true) {
              if ((result = checkCdData(ean13, ScanCom.SCAN_EAN8_DATA_SIZE)) == false) {
                myLog.logAdd(tid, LogLevelDefine.error, " EAN8 cd error");
              }
            } else {
              myLog.logAdd(tid, LogLevelDefine.error, " EAN8 length error");
            }
          } else {
            myLog.logAdd(tid, LogLevelDefine.error, " EAN8 length error");
          }
        } else {
          if (data_len != ScanCom.SCAN_EAN13_SIZE) {
            /* アドオン仕様 */
            if (data_len == ScanCom.SCAN_EAN_ADDON_SIZE) {
              final eanadon = scan_data0.substring(
                  ScanCom.SCAN_OFFSET_LABEL_ID,
                  ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_EAN_ADDON_DATA_SIZE);
              if ((result = checkNumData(eanadon, ScanCom.SCAN_EAN_ADDON_DATA_SIZE)) == true) {
                if ((scan_data[ScanCom.SCAN_OFFSET_LABEL_ID + 0] == '4') &&
                    (scan_data[ScanCom.SCAN_OFFSET_LABEL_ID + 1] == '9') &&
                    (scan_data[ScanCom.SCAN_OFFSET_LABEL_ID + 2] == '1')) {
                  if ((result = checkCdData(eanadon, ScanCom.SCAN_EAN13_DATA_SIZE)) == false) {
                    myLog.logAdd(tid, LogLevelDefine.error, " ADDON cd error");
                  }
                } else {
                  result = false;
                  myLog.logAdd(tid, LogLevelDefine.error, " ADDON Scan_data error");
                }
              } else {
                myLog.logAdd(tid, LogLevelDefine.error, " ADDON num error");
              }
            } else {
              myLog.logAdd(tid, LogLevelDefine.error, " ADDON size error");
            }
          } else {
            final ean13 = scan_data0.substring(
                ScanCom.SCAN_OFFSET_LABEL_ID,
                ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_EAN13_DATA_SIZE);
            if ((result = checkNumData(ean13, ScanCom.SCAN_EAN13_DATA_SIZE)) == true) {
              if ((result = checkCdData(ean13, ScanCom.SCAN_EAN13_DATA_SIZE)) == false) {
                myLog.logAdd(tid, LogLevelDefine.error, " EAN13 num error");
              }
            } else {
              myLog.logAdd(tid, LogLevelDefine.error, " EAN13 num error");
            }
          }
        }
        break;
      case ScanCom.SCAN_CODE128_CODE:
        late RxTaskStatBuf tsBuf;
        if ((await CmCksys.cmBarcodePay1System() != 0) ||
            (await CmCksys.cmCanalPaymentServiceSystem() != 0) ||
            (await CmCksys.cmMultiOnepaySystem() != 0) ||
            (await CmCksys.cmNetstarsCodepaySystem() != 0) ||
            (await CmCksys.cmFujitsuFipCodepaySystem() != 0) ||
            (await CmCksys.cmRepicaStdCodeSystem() != 0) ||
            (await CmCksys.cmOnepaySystem() != 0) ||
            (await CmCksys.cmQuizPaymentSystem() != 0)) {
          RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
          if (xRet.isInvalid()) {
						myLog.logAdd(tid, LogLevelDefine.error, "Task stat get error");
					} else {
            tsBuf = xRet.object;
            final code128size = data_len - ScanCom.SCAN_LABEL_CR;
            final code128 = scan_data0.substring(
                ScanCom.SCAN_OFFSET_LABEL_ID,
                ScanCom.SCAN_OFFSET_LABEL_ID + code128size);
            if (tsBuf.bcdpay.scan_flg != 0) {
							if (((result = checkNumData(code128, code128size)) == true) ||
                  (((result = checkAlphaData(code128, code128size)) == true) &&
                   ((await CmCksys.cmMultiOnepaySystem() != 0) ||
                    (await CmCksys.cmNetstarsCodepaySystem() != 0)))) {
								result = true;
								break;
							}
						}
            if (tsBuf.repica.scan_flg != 0) {
              if ((result = checkNumData(code128,code128size)) == true) {
                result = true;
                break;
              }
            }
					}
				}
        if (data_len != ScanCom.SCAN_CODE128_SIZE20) {
          if (data_len == ScanCom.SCAN_CODE128_SIZE26) {
            final code128_26 = scan_data0.substring(
                ScanCom.SCAN_OFFSET_LABEL_ID,
                ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_CODE128_DATA_SIZE26);
            if ((result = checkNumData(code128_26, ScanCom.SCAN_CODE128_DATA_SIZE26)) == true) {
              if ((result = checkCdData(code128_26, ScanCom.SCAN_CODE128_DATA_SIZE26)) == false) {
                myLog.logAdd(tid, LogLevelDefine.error, " CODE128 26 num error");
              }
            } else {
              myLog.logAdd(tid, LogLevelDefine.error, " CODE128 26 num error");
            }
          } else if (data_len == ScanCom.SCAN_CODE128_SIZE28) {
            final code128_28 = scan_data0.substring(
                ScanCom.SCAN_OFFSET_LABEL_ID,
                ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_CODE128_DATA_SIZE28);
            if ((result = checkNumData(code128_28, ScanCom.SCAN_CODE128_DATA_SIZE28)) == true) {
              if ((result = checkCdData(code128_28, ScanCom.SCAN_CODE128_DATA_SIZE28)) == false) {
                myLog.logAdd(tid, LogLevelDefine.error, " CODE128 28 num error");
              }
            } else {
              myLog.logAdd(tid, LogLevelDefine.error, " CODE128 28 num error");
            }
          } else if (data_len == ScanCom.SCAN_CODE128_SIZE24) {
            final code128_24 = scan_data0.substring(
                ScanCom.SCAN_OFFSET_LABEL_ID,
                ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_CODE128_DATA_SIZE24);
            if ((result = checkNumData(code128_24, ScanCom.SCAN_CODE128_DATA_SIZE24)) == true) {
              if (await CmCksys.cmOnepaySystem() != 0) {
                result = true;
              } else if ((result = checkCdData(code128_24, ScanCom.SCAN_CODE128_DATA_SIZE24)) == false ) {
                myLog.logAdd(tid, LogLevelDefine.error, " CODE128 24 num error");
              }
            } else {
              myLog.logAdd(tid, LogLevelDefine.error, " CODE128 24 num error");
            }
          } else if (data_len == ScanCom.SCAN_PBCHG_SIZE) {
            final pbchg = scan_data0.substring(
                ScanCom.SCAN_OFFSET_LABEL_ID,
                ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_CODE128_DATA_SIZE_PBCHG);
            if ((result = checkNumData(pbchg, (ScanCom.SCAN_CODE128_DATA_SIZE_PBCHG))) == true) {
              if ((result = checkCdData(pbchg, (ScanCom.SCAN_CODE128_DATA_SIZE_PBCHG))) == false) {
                myLog.logAdd(tid, LogLevelDefine.error, " PBCHGBarcode 44 num error");
                result = true;
              }
            } else {
              myLog.logAdd(tid, LogLevelDefine.error, " PBCHG Barcode 44 num error");
            }
          } else if (data_len == ScanCom.SCAN_CODE128_SIZE18) {
            final code128_18 = scan_data0.substring(
                ScanCom.SCAN_OFFSET_LABEL_ID,
                ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_CODE128_DATA_SIZE18);
            if ((result = checkNumData(code128_18, ScanCom.SCAN_CODE128_DATA_SIZE18)) == true) {
              if (await CmCksys.cmOnepaySystem() != 0) {
                result = true;
              } else if (CmCksys.cmRm5900System() != 0) {
                result = true;
              }	else if ((result = checkCdData(code128_18, ScanCom.SCAN_CODE128_DATA_SIZE18)) == false ) {
                myLog.logAdd(tid, LogLevelDefine.error, " CODE128 18 num error");
              }
            } else {
              myLog.logAdd(tid, LogLevelDefine.error, " CODE128 18 num error");
            }
          } else if (data_len == ScanCom.SCAN_CODE128_SIZE30) {
            final code128_30 = scan_data0.substring(
                ScanCom.SCAN_OFFSET_LABEL_ID,
                ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_CODE128_DATA_SIZE30);
            if ((result = checkNumData(code128_30, ScanCom.SCAN_CODE128_DATA_SIZE30)) == true) {
              if ((result = checkCdData(code128_30, ScanCom.SCAN_CODE128_DATA_SIZE30)) == false) {
                myLog.logAdd(tid, LogLevelDefine.error, " CODE128 30 cd error");
              }
            } else {
              myLog.logAdd(tid, LogLevelDefine.error, " CODE128 30 num error");
            }
          } else if (data_len == ScanCom.SCAN_CODE128_SIZE16) {
            /* チェックデジットなし */
            final code128_16 = scan_data0.substring(
                ScanCom.SCAN_OFFSET_LABEL_ID,
                ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_CODE128_DATA_SIZE16);
            if ((result = checkNumData(code128_16, ScanCom.SCAN_CODE128_DATA_SIZE16)) != true) {
              myLog.logAdd(tid, LogLevelDefine.error, " CODE128 16 num error");
            }
          } else if (data_len == ScanCom.SCAN_CODE128_SIZE32) {
            /* チェックデジットなし */
            final code128_32 = scan_data0.substring(
                ScanCom.SCAN_OFFSET_LABEL_ID,
                ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_CODE128_DATA_SIZE32);
            if ((result = checkNumData(code128_32, ScanCom.SCAN_CODE128_DATA_SIZE32)) != true) {
              myLog.logAdd(tid, LogLevelDefine.error, " CODE128 32 num error");
            }
          }
          // #if SS_CR2   /* v1ではSCAN_CODE128_SIZE8、およびcm_CR_NSW_data_systemは実装されていないため、コメントアウト */
          // else if (( data_len == ScanCom.SCAN_CODE128_SIZE8 ) && (CompileFlag.SS_CR2)) {
          //   if (CmCksys.cm_CR_NSW_data_system() == 1) {
          //     result = true;
          //   } else {
          //     myLog.logAdd(tid, LogLevelDefine.error, " CODE128 8 recog error");
          //   }
          // }
          // #endif
          else if (data_len == ScanCom.SCAN_CODE128_SIZE12) {
            final code128_12 = scan_data0.substring(
                ScanCom.SCAN_OFFSET_LABEL_ID,
                ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_CODE128_DATA_SIZE12);
            if ((result = checkNumData(code128_12, ScanCom.SCAN_CODE128_DATA_SIZE12)) == true) {
              if (await CmCksys.cmLinePaySystem() != 0) {
                result = true;
              } else if ((result = checkCdData(code128_12, ScanCom.SCAN_CODE128_DATA_SIZE12)) == false ) {
                myLog.logAdd(tid, LogLevelDefine.error, " CODE128 12 cd error");
              }
            } else {
              myLog.logAdd(tid, LogLevelDefine.error, " CODE128 12 num error");
            }
          } else if (data_len == ScanCom.SCAN_CODE128_SIZE17) {
            final code128_17 = scan_data0.substring(
                ScanCom.SCAN_OFFSET_LABEL_ID,
                ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_CODE128_DATA_SIZE17);
            if ((result = checkNumData(code128_17, ScanCom.SCAN_CODE128_DATA_SIZE17)) == true) {
              if (await CmCksys.cmOnepaySystem() != 0) {
                result = true;
              } else {
                myLog.logAdd(tid, LogLevelDefine.error, " CODE128 17 cd error");
              }
            } else {
              myLog.logAdd(tid, LogLevelDefine.error, " CODE128 17 num error");
            }
          } else if (data_len == ScanCom.SCAN_CODE128_SIZE21) {
            final code128_21 = scan_data0.substring(
                ScanCom.SCAN_OFFSET_LABEL_ID,
                ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_CODE128_DATA_SIZE21);
            if ((result = checkNumData(code128_21, ScanCom.SCAN_CODE128_DATA_SIZE21)) == true) {
              if (await CmCksys.cmOnepaySystem() != 0) {
                result = true;
              } else {
                myLog.logAdd(tid, LogLevelDefine.error, " CODE128 21 cd error");
              }
            }
          } else if (data_len == ScanCom.SCAN_CODE128_SIZE23) {
            final code128_23 = scan_data0.substring(
                ScanCom.SCAN_OFFSET_LABEL_ID,
                ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_CODE128_DATA_SIZE23);
            if ((result = checkNumData(code128_23, ScanCom.SCAN_CODE128_DATA_SIZE23)) == true) {
              if (await CmCksys.cmOnepaySystem() != 0) {
                result = true;
              } else {
                myLog.logAdd(tid, LogLevelDefine.error, " CODE128 23 cd error");
              }
            } else {
              myLog.logAdd(tid, LogLevelDefine.error, " CODE128 23 num error");
            }
          } else if (data_len == ScanCom.SCAN_CODE128_SIZE22) {
            final code128_22 = scan_data0.substring(
                ScanCom.SCAN_OFFSET_LABEL_ID,
                ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_CODE128_DATA_SIZE22);
            if ((result = checkNumData(code128_22, ScanCom.SCAN_CODE128_DATA_SIZE22)) == true) {
              if (await CmCksys.cmOnepaySystem() != 0) {
                result = true;
              } else if ((result = checkCdData(code128_22, ScanCom.SCAN_CODE128_DATA_SIZE22)) == false ) {
                myLog.logAdd(tid, LogLevelDefine.error, " CODE128 22 num error");
              }
            } else {
              myLog.logAdd(tid, LogLevelDefine.error, " CODE128 22 num error");
            }
          } else if (data_len == ScanCom.SCAN_CODE128_SIZE19) {
            /* チェックデジットなし */
            final code128_19 = scan_data0.substring(
                ScanCom.SCAN_OFFSET_LABEL_ID,
                ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_CODE128_DATA_SIZE19);
            if ((result = checkNumData(code128_19, ScanCom.SCAN_CODE128_DATA_SIZE19)) != true) {
              myLog.logAdd(tid, LogLevelDefine.error, " CODE128 19 num error");
            }
          } else {
            myLog.logAdd(tid, LogLevelDefine.error, " CODE128 26 length error");
          }
        } else {
          final code128_20 = scan_data0.substring(
              ScanCom.SCAN_OFFSET_LABEL_ID,
              ScanCom.SCAN_OFFSET_LABEL_ID + ScanCom.SCAN_CODE128_DATA_SIZE20);
          if ((result = checkNumData(code128_20, ScanCom.SCAN_CODE128_DATA_SIZE20)) == true) {
            if ((await CmCksys.cmOnepaySystem() != 0) && (tsBuf.bcdpay.scan_flg != 0)) {
              result = true;
            } else if (await CmCksys.cmFipMemberBarcodeSystem() != 0) {
              result = true;
            } else if (await CmCksys.cmFipEmoneyStandardSystem() != 0) {	// FIP電子マネー(標準)仕様
              result = true;
            } else if ((result = checkCdData(code128_20, ScanCom.SCAN_CODE128_DATA_SIZE20)) == false ) {
              myLog.logAdd(tid, LogLevelDefine.error, " CODE128 20 length error");
            }
          } else {
            myLog.logAdd(tid, LogLevelDefine.error, " CODE128 20 num error");
          }
        }
        break;
      case ScanCom.SCAN_NW7_CODE:
        if (((scan_data[ScanCom.SCAN_OFFSET_START_CODE] == 'a') ||
             (scan_data[ScanCom.SCAN_OFFSET_START_CODE] == 'b') ||
             (scan_data[ScanCom.SCAN_OFFSET_START_CODE] == 'c') ||
             (scan_data[ScanCom.SCAN_OFFSET_START_CODE] == 'd') ||
             (scan_data[ScanCom.SCAN_OFFSET_START_CODE] == 'A') ||
             (scan_data[ScanCom.SCAN_OFFSET_START_CODE] == 'B') ||
             (scan_data[ScanCom.SCAN_OFFSET_START_CODE] == 'C') ||
             (scan_data[ScanCom.SCAN_OFFSET_START_CODE] == 'D')) &&
               ((scan_data[data_len - 2] == 'a') ||
                (scan_data[data_len - 2] == 'b') ||
                (scan_data[data_len - 2] == 'c') ||
                (scan_data[data_len - 2] == 'd') ||
                (scan_data[data_len - 2] == 'A') ||
                (scan_data[data_len - 2] == 'B') ||
                (scan_data[data_len - 2] == 'C') ||
                (scan_data[data_len - 2] == 'D'))) {
          final nw7 = scan_data0.substring(
              ScanCom.SCAN_OFFSET_LABEL_ID2,
              ScanCom.SCAN_OFFSET_LABEL_ID2 + (data_len - ScanCom.SCAN_LABEL_START_STOP_CR));
          if ((result = checkNumData(nw7, (data_len - ScanCom.SCAN_LABEL_START_STOP_CR))) == false) {
            myLog.logAdd(tid, LogLevelDefine.error, " NW7 num error");
          }
        } else {
          myLog.logAdd(tid, LogLevelDefine.error, " NW7 start_stop character error");
        }
        break;
      case ScanCom.SCAN_ITF_CODE:
        result = true;
        final itf = scan_data0.substring(
            ScanCom.SCAN_OFFSET_LABEL_ID,
            ScanCom.SCAN_OFFSET_LABEL_ID + (data_len - ScanCom.SCAN_LABEL_CR));
        if ((CmCksys.cmIKEASystem() != 0) && (data_len == ScanCom.SCAN_ITF_SIZE14)) {
          result = checkNumData(itf, (data_len - ScanCom.SCAN_LABEL_CR));
          if ( result != true ) {
            myLog.logAdd(tid, LogLevelDefine.error, " ITF14 num error");
          }
        } else if ((data_len == ScanCom.SCAN_ITF_SIZE18) ||
          (data_len == ScanCom.SCAN_ITF_SIZE16) || (data_len == ScanCom.SCAN_ITF_SIZE14)) {
          result = checkNumData(itf, (data_len - ScanCom.SCAN_LABEL_CR));
          if ( result == true ) {
            if ((result = checkCdData(itf, (data_len - ScanCom.SCAN_LABEL_CR))) == false ) {
              myLog.logAdd(tid, LogLevelDefine.error, " ITF cd error");
            }
          } else {
            myLog.logAdd(tid, LogLevelDefine.error, " ITF num error");
          }
        } else {
          myLog.logAdd(tid, LogLevelDefine.error, " ITF length error");
        }
        break;
      case ScanCom.SCAN_GS1_1_CODE:
        result = true;
        break;
      case ScanCom.SCAN_CODE39_CODE:
        result = true;
        if ((CmCksys.cmIKEASystem() != 0) && (data_len == ScanCom.SCAN_CODE39_SIZE19)) {
          final code39 = scan_data0.substring(
              ScanCom.SCAN_OFFSET_LABEL_ID,
              ScanCom.SCAN_OFFSET_LABEL_ID + (data_len - ScanCom.SCAN_LABEL_CR));
          result = checkNumData(code39, (data_len - ScanCom.SCAN_LABEL_CR));
          if ( result != true ) {
            myLog.logAdd(tid, LogLevelDefine.error, " CODE39 num error");
          }
        } else {
          result = true;
        }
        break;
      case ScanCom.SCAN_QR_CODE:
        result = true;
        break;
      case ScanCom.SCAN_EAN128_CODE:
        if (data_len == ScanCom.SCAN_PBCHG_SIZE) {
          final ean128 = scan_data0.substring(ScanCom.SCAN_OFFSET_LABEL_ID, ScanCom.SCAN_OFFSET_LABEL_ID + (ScanCom.SCAN_PBCHG_SIZE - 2));
          if ((result = checkNumData(ean128, (ScanCom.SCAN_PBCHG_SIZE - 2))) == true) {
            if ((result = checkCdData(ean128, (ScanCom.SCAN_PBCHG_SIZE - 2))) == false) {
              myLog.logAdd(tid, LogLevelDefine.error, " PBCHGBarcode 44 cd error");
              result = true;
            }
          } else {
            myLog.logAdd(tid, LogLevelDefine.error, " PBCHG Barcode 44 num error");
          }
        } else {
          myLog.logAdd(tid, LogLevelDefine.error, "EAN128 44 length error");
        }
        break;
    // #if SS_CR2    /* v1では sysJson.type.cr2_nsw_system が未定義のためコメントアウト*/
    // case ScanCom.SCAN_STF_CODE:
    //   if (CompileFlag.SS_CR2) {
    //       if (data_len > 0) {
    //         if (CmCksys. cm_CR_NSW_data_system() == 1) {
    //           result = true;
    //         } else {
    //           myLog.logAdd(tid, LogLevelDefine.error, " STF recog error");
    //         }
    //       } else {
    //         myLog.logAdd(tid, LogLevelDefine.error, " STF length error");
    //       }
    //     }
    //     break;
    // #endif
      case SCAN_PASSPORT_CODE: // パスポート情報
        if (fPassportScanning == ScanCom.PASSPORT_SCAN_PROCESSING) {
          if (data_len > ScanCom.SCAN_PASSPORT_OCRB_SIZE) {
            myLog.logAdd(tid, LogLevelDefine.error, " Passport Ocrb size over error");
            break;
          }
          result = true;
        }
        break;
      default:
  			if (await CmCksys.cmShopAndGoSystem() != 0) {
	  			if ( url_format_flg == 1 ) {
		  			result = true;
			  	}
			  }
        break;
    }

    return (result);
  }


  /// スキャナからのデータを取得する（ステータス:Idle）
  ///
  /// 引数:[_parentSendPort] 親タスクへの通信ポート
  ///
  /// 引数:[tid] タスクID
  ///
  /// 引数:[devmsg] 受信データ（１バイト）
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 機能概要：IDLEステータスにてスキャナからのデータを取得し、先頭データによりCR待ちに移行する。
  ///
  /// 関連tprxソース: drv_scan_rcv_plus.c - drv_scan_RcvIdle()
  Future<void> drvScanRcvIdle(SendPort _parentSendPort, TprTID tid, String devmsg) async {
    String ResTime = "";
    bool result = true;

    switch (devmsg) {
      case ScanCom.SCAN_HW_SINGLE_RES:
      case ScanCom.SCAN_HW_PRESEN_RES:
        if (scanCom.drvScanSetTimer(tid, ScanCom.SCAN_HW_TIMER) != 0) {
					cmRs232cLogWrite(ScanCom.scan_info.device, Rs232cCommKind.RS232C_RCV, devmsg, 1, "");
          return;
        } else if (qr_status != 0) {
          mio_make_count = 0;
          mio_qr_status = 0;
          await _drvScanRcvQRtoMakeData(_parentSendPort, tid, devmsg);
          cmRs232cLogWrite(ScanCom.scan_info.device, Rs232cCommKind.RS232C_RCV, devmsg, 1, "");
          break;
        }
        data_count = 0;
        make_count = 0;
        mio_make_count = 0;
        qr_status = 0;
        SerialReadBuf = "";
        fPassportScanning = ScanCom.PASSPORT_SCAN_IDLE;
        scanCom.tprMsg.devnotify = new TprMsg().devnotify;
        SerialReadBuf += devmsg;
        data_count += devmsg.length;
        ScanCom.scan_info.state = SCAN_STATE.SCAN_STATE_RCV_EX;
				if (await CmCksys.cmTaxfreePassportinfoSystem() != 0) {
					// パスポートスキャンの開始
					fPassportScanning = ScanCom.PASSPORT_SCAN_PROCESSING;
					ScanCom.scan_info.state = SCAN_STATE.SCAN_STATE_RCV_CR;
				}
        break;
      case ScanCom.SCAN_UPCA_CODE:      // "A"
      case ScanCom.SCAN_UPCE_CODE:      // "E"
      case ScanCom.SCAN_EAN13_CODE:     // "F"
      case ScanCom.SCAN_CODE128_CODE:   // "K"
      case ScanCom.SCAN_NW7_CODE:       // "N"
      case ScanCom.SCAN_ITF_CODE:       // "I"
      case ScanCom.SCAN_GS1_1_CODE:     // "R"
      case ScanCom.SCAN_CODE39_CODE:    // "M"
      case ScanCom.SCAN_EAN128_CODE:    // "W"
      case ScanCom.SCAN_STF_CODE:       // 'H'
        if (CompileFlag.SS_CR2) {
          if ((await CmCksys.cmPaymentMngSystem() == 1) && (cr40_qr_status == 1)) {
            await _drvScanRcvQRtoMakeDataCR40(tid, devmsg);
            break;
          }
        } else {
          if (devmsg == ScanCom.SCAN_STF_CODE) {
            break;
          }
        }
        if (scanCom.drvScanSetTimer(tid, ScanCom.SCAN_TIMER) != 0) {
					cmRs232cLogWrite(ScanCom.scan_info.device, Rs232cCommKind.RS232C_RCV, devmsg, 1, "");
          return;
        } else if (qr_status != 0) {
          mio_make_count = 0;
          mio_qr_status = 0;
          await _drvScanRcvQRtoMakeData(_parentSendPort, tid, devmsg);
          cmRs232cLogWrite(ScanCom.scan_info.device, Rs232cCommKind.RS232C_RCV, devmsg, 1, "");
          break;
        }
        data_count = 0;
        make_count = 0;
        mio_make_count = 0;
        qr_status = 0;
        mio_qr_status = 0;
        SerialReadBuf = "";
        SerialReadBuf += devmsg;
        data_count += devmsg.length;
        ScanCom.scan_info.state = SCAN_STATE.SCAN_STATE_RCV_CR;
        break;
      case ScanCom.SCAN_QR_CODE:
        if (CompileFlag.SS_CR2) {
          if (await CmCksys.cmPaymentMngSystem() == 1) {
            make_count = 0;
            qr_status = 0;
            cr40_qr_status = 1;
            await _drvScanRcvQRtoMakeDataCR40(tid, devmsg);
          }
        }
        break;
      default:
        if (mio_qr_status == 1) {
          make_count = 0;
          qr_status = 0;
          if (await _drvScanRcvMiotoMakeData(_parentSendPort, tid, devmsg) == false) {
            scanCom.drvScanResCharSend(_parentSendPort, tid, false, data_count);
            result = false;
            ResTime = DateUtil.getNowStr(DateUtil.formatForLogDetail);
          }
        } else {
          mio_make_count = 0;
          mio_qr_status = 0;
          await _drvScanRcvQRtoMakeData(_parentSendPort, tid, devmsg);
        }
				cmRs232cLogWrite(ScanCom.scan_info.device, Rs232cCommKind.RS232C_RCV, devmsg, 1, "");
        break;
    }
  }

  /// スキャナからのデータを取得する（ステータス:Receive EX）
  ///
  /// 引数:[_parentSendPort] 親タスクへの通信ポート
  ///
  /// 引数:[tid] タスクID
  ///
  /// 引数:[devmsg] 受信データ（１バイト）
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 関連tprxソース: drv_scan_rcv_plus.c - drv_scan_RcvEx()
  void _drvScanRcvEx(SendPort _parentSendPort, TprTID tid, String devmsg) {
    if (SerialReadBuf.length <= data_count) {
      myLog.logAdd(tid, LogLevelDefine.error, " RcvMag overflow");
      scanCom.drvScanInitVariable(tid);
      return;
    }

    SerialReadBuf = SerialReadBuf.substring(0, data_count) + devmsg +
        SerialReadBuf.substring(data_count + 2);
    data_count += devmsg.length;
    switch (devmsg) {
      case ScanCom.SCAN_HW_MODE_RES_END:
      case ScanCom.SCAN_DISPLAYMODE_RES_END:
        _rcvExSubProc(tid);
        break;
      default:
        break;
    }
  }

  /// スキャナからのデータを取得する（ステータス:Receive CR）
  ///
  /// 引数:[_parentSendPort] 親タスクへの通信ポート
  ///
  /// 引数:[tid] タスクID
  ///
  /// 引数:[devmsg] 受信データ（１バイト）
  ///
  /// 戻り値：0 = Normal End
  ///
  ///       -1 = Error
  ///
  /// 機能概要：データ受信中にCRを受信した場合はバーコードデータと認識し、親タスクに受信データを送信する。
  ///
  /// 関連tprxソース: drv_scan_rcv_plus.c - drv_scan_RcvCr()
  Future<void> _drvScanRcvCr(SendPort _parentSendPort, TprTID tid, String devmsg) async {
    FbMem fbMem = FbMem();
    String erlog = "";
    String SysSendData = "";
    int retry_count = 0;
    int send_len = 0;
    String CRTime = "";
    String ResTime = "";
    String SendData = "";
    bool result = false;

    if ((ScanCom.SCAN_RCVBUF_SIZE_MAX + 1) <= data_count) {
      myLog.logAdd(tid, LogLevelDefine.error, " RcvMag overflow");
      scanCom.drvScanInitVariable(tid);
      return;
    }

    SerialReadBuf += devmsg;
    data_count += devmsg.length;

    switch(devmsg) {
      case CRcode:
        if(ScanCom.SCAN_LOGWRITE != 0) {
          cmRs232cLogWrite(ScanCom.scan_info.device, Rs232cCommKind.RS232C_RCV,
              SerialReadBuf, data_count, "");
          CRTime = drv_DateTime();
        }
        scanCom.drvScanInitVariable(tid);

        if(await drvScanDataCheck( tid, SerialReadBuf, data_count ) == false) {
          if(retry_count >= ScanCom.SCAN_RETRYMAX) {
            retry_count = 0;
            myLog.logAdd(tid, LogLevelDefine.error, " retry over");
          } else {
            scanCom.drvScanResCharSend(_parentSendPort, tid, false, data_count);
            result = false;
            ResTime = drv_DateTime();
            retry_count++;
          }
        } else {
          if(ScanCom.scan_info.act == SCAN_ACT.SCAN_ENABLE) {
            if (CompileFlag.CENTOS == true) {
              if (fbMem.rpt_rec == 1) {
                ComRptTool.comRptOpeRec(ScanCom.scan_info.myDid, 0, 0, SerialReadBuf);
              }
            }
            scanCom.drvScanResCharSend(_parentSendPort, tid, true, data_count);
            result = true;
            ResTime = drv_DateTime();
            send_len = 0;
            SysSendData += "\x01";
            send_len++;

            if( SerialReadBuf.codeUnitAt(0) == ScanCom.SCAN_EAN128_CODE ) {
              SysSendData += ScanCom.SCAN_CODE128_CODE;
              send_len++;
              SysSendData += SerialReadBuf.substring(0, data_count - 1);
              send_len += (data_count - 1);
            } else {
              SysSendData += SerialReadBuf;
              send_len += data_count;
            }

            if(ScanCom.object_data_flg == 0) {
              scanCom.drvScanResNotify(_parentSendPort, tid,
                  TprDidDef.TPRDEVRESULTOK, SysSendData, send_len);
              ScanCom.scan_exe = 1;
              myLog.logAdd(tid, LogLevelDefine.error, " SCAN !!");
            }
            // v1のオリジナルコードでコメントアウト
            // scanCom.drvScanResNotify(
            //     tid, TprDidDef.TPRDEVRESULTOK, SysSendData, send_len);
          }

          if(ScanCom.object_data_flg == 1) {
            ScanCom.object_data_flg = 0;
            scanCom.drvScanResCharSend(_parentSendPort, tid, true, data_count);

            if((ScanCom.object_in == 1) && (ScanCom.scan_exe == 1) && (ScanCom.object_out == 1)) {
              // myLog.logAdd(tid, LogLevelDefine.error, "Seijou");
            }
            if((ScanCom.object_in == 1) && (ScanCom.scan_exe == 0) && (ScanCom.object_out == 1)) {
              RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
              if (xRet.isInvalid()) {
                erlog = runtimeType.toString() + " rxMemPtr error \n";
                myLog.logAdd(tid, LogLevelDefine.error, erlog);
                ScanCom.swing_flg == 0;
                break;
              }
              RxCommonBuf pCom = xRet.object;

              if(ScanCom.swing_flg == 1) {
                if((pCom.iniMacInfo.select_self.self_mode == 1)
                  && ((await CmCksys.cmAiboxSystem() != 1) ||
                      ((await CmCksys.cmAiboxSystem() == 1) &&
                       (CmCksys.cmAiboxMode() == 2)))) {	// AIBOX学習モード
                  // フルセルフモード （v1のオリジナルコードでコメントアウト）
                  // myLog.logAdd(tid, LogLevelDefine.error, "swing");
                  SysSendData = "CNT";
                  scanCom.drvScanResNotifyFlg(_parentSendPort, tid, TprDidDef.TPRDEVRESULTOK,
                      SysSendData, SysSendData.length, true);
                }
              }
            }
            if ((ScanCom.object_in == 1) && (ScanCom.object_out == 1)) {
              // myLog.logAdd(tid, LogLevelDefine.error, "FLAG CLEAR");
              ScanCom.object_in = 0;
              ScanCom.object_out = 0;
              ScanCom.scan_exe = 0;
            }
          }
          retry_count = 0;
        }
        if (ScanCom.SCAN_LOGWRITE == true) {
          cmRs232cLogWriteDate(ScanCom.scan_info.device,
              Rs232cCommKind.RS232C_RCV, SerialReadBuf, data_count, CRTime);

          if ((ScanCom.scan_info.res_char == SCAN_RESCHAR.SCAN_ACK_NAK) ||
              (ScanCom.scan_info.res_char == SCAN_RESCHAR.SCAN_ACK_NAK_CR)) {
            SendData = (result == true) ? DrvCom.ACK : DrvCom.NAK;
          } else if (ScanCom.scan_info.res_char == SCAN_RESCHAR.SCAN_BEL) {
            SendData = (result == true) ? DrvCom.BEL : DrvCom.NUL;
          } else {
            SendData = (result == true) ? ScanCom.SCAN_OK_DAT : ScanCom.SCAN_NG_DAT;
          }
          cmRs232cLogWriteDate(ScanCom.scan_info.device, Rs232cCommKind.RS232C_SEND,
              SendData, SendData.length, ResTime);
        }
        fPassportScanning = ScanCom.PASSPORT_SCAN_IDLE;		/* パスポートスキャンフラグをクリア */
        qr_http_flag = 0;
        // myLog.logAdd(tid, LogLevelDefine.error, "RcvCr: qr_http_flag = 0");
        break;
      case ScanCom.SCAN_HW_MODE_RES_END:
      case ScanCom.SCAN_DISPLAYMODE_RES_END:
        if ( fPassportScanning == ScanCom.PASSPORT_SCAN_PROCESSING ) {
          _rcvExSubProc(tid);
        }
        break;
      default:
        break;
    }
  }

  /// タイマー処理
  ///
  /// 引数:[tid] タスクID
  ///
  /// 引数:[ptTprMsg] アプリからの送信データ
  ///
  /// 戻り値：true = Normal End
  ///
  ///       false = Error
  ///
  /// 関連tprxソース: drv_scan_rcv_plus.c - drv_scan_Timer()
  int drvScanTimer(TprMID tid, TprMsg_t msg) {
    switch (ScanCom.scan_info.state) {
      case SCAN_STATE.SCAN_STATE_RCV_CR:
				cmRs232cLogWrite(ScanCom.scan_info.device, Rs232cCommKind.RS232C_RCV,
            SerialReadBuf, data_count, "");
        scanCom.drvScanInitVariable(tid);
        myLog.logAdd(tid, LogLevelDefine.error, " timeout error");
        break;
      case SCAN_STATE.SCAN_STATE_IDLE:
      default:
        break;
    }

    return (0);
  }

  /// 受信タイムアウト処理
  ///
  /// 引数:[_parentSendPort] 親タスクへの通信ポート
  ///
  /// 引数:[tid] タスクID
  ///
  /// 引数:[ptTprMsg] アプリからの送信データ
  ///
  /// 戻り値：なし
  ///
  /// 関連tprxソース: drv_scan_rcv_plus.c - drv_scan_Datachk_TimerProc()
  Future<void> drvScanDatachkTimerProc(SendPort _parentSendPort, TprTID tid) async {
    myLog.logAdd(tid, LogLevelDefine.error,
        "drvScanDatachkTimerProc() Send QR_BIN_CR to End QR\n");
    qr2txt.cmQrToTxtChmod();
    qr_status = 0;
    make_count = 0;
    await _drvScanRcvCr(_parentSendPort, tid, QR_BIN_CR);

    return;
  }

  /// Shop&GO仕様のQRコード受信処理
  ///
  /// 引数:[_parentSendPort] 親タスクへの通信ポート
  ///
  /// 引数:[tid] タスクID
  ///
  /// 引数:[devmsg] 受信データ（１バイト）
  ///
  /// 戻り値：なし
  ///
  /// 関連tprxソース: drv_scan_rcv_plus.c - drv_scan_RcvQRtoMakeData_ShopAndGo()
  Future<void> _drvScanRcvQRtoMakeDataShopAndGo(
      SendPort _parentSendPort, TprTID tid, String devmsg) async {

    // 1文字ごとにログが出るためコメントアウト。この後にある一定長読み取るごとのログを使う。
    // myLog.logAdd(tid, LogLevelDefine.normal,
    //    "drvScanRcvQRtoMakeDataShopAndGo() devmsg:$devmsg QRReadBuf[$make_count][$QRReadBuf]");

    if (make_count == 0) {
      filename = "";
      QRReadBuf = "";
    }
    QRReadBuf += devmsg;
    make_count++;

    if ((make_count == 5) &&
        (QRReadBuf[0] == 's') &&
        (QRReadBuf[1] == 'g') &&
        (QRReadBuf[2] == 'q') &&
        (QRReadBuf[3] == 'r')) {
      qr_status = 1;
      myLog.logAdd(tid, LogLevelDefine.normal,
          "drvScanRcvQRtoMakeDataShopAndGo() qr_status[$qr_status]");
    }

    if (devmsg == CRcode) {
      if (qr_status == 1) {
        url_format_flg = 1;
        SerialReadBuf = QRReadBuf.substring(0, make_count);
        data_count = SerialReadBuf.length;
        await _drvScanRcvCr(_parentSendPort, tid, QR_BIN_CR);
        myLog.logAdd(tid, LogLevelDefine.normal,
            "drvScanRcvQRtoMakeDataShopAndGo() SerialReadBuf[${SerialReadBuf}]");
      }
      url_format_flg = 0;
      qr_status = 0;
      make_count = 0;
//		tp1_system_flag = 0;	/* 承認キー判定フラグのクリア */
//		ticket_flag = 0;	/* 利用券(引換券)判定フラグのクリア */
      qr_http_flag = 0;
      return;
    }
  }

	/// 受信データのパラメータチェック（QR_CR2）
  ///
	/// 引数:[tid] タスクID
  ///
	/// 引数:[devmsg] 受信データ（１バイト）
  ///
  /// 戻り値：なし
  ///
  /// 関連tprxソース: drv_scan_rcv_plus.c - drv_scan_RcvQRtoMakeData_CR40()
	Future<void> _drvScanRcvQRtoMakeDataCR40(TprTID tid, String devmsg) async {
    String 	erlog = "";
    String 	qr_txt_path = "";
    String 	write_buf = "";
    String 	tmpbuf = "";
    String 	md5_path = "";		//uchar[TPRMAXPATHLEN]
    String 	slct_path = "";
    String 	cmd = "";
    String 	dir = "";
    int  	  i = 0;
    int  	  md5_ret = 0;

    if ( make_count == 0 )	{
  	  filename = "";
  	  QRReadBuf = "";
    }

    if ( qr_status == 1 ) {
      qr2txt.cmQrToTxtWriteCr40(devmsg, filename, 1);
    }

    QRReadBuf += devmsg;
    make_count++;

    if((make_count <= 15) && (qr_http_flag == 0) && (QRReadBuf.contains("http"))) {
      myLog.logAdd(tid, LogLevelDefine.normal,
          "drv_scan_RcvQRtoMakeData_CR40: QR contains http in the first 15 chars, qr_http_flag=1\n");
      qr_http_flag = 1;
    }

    switch ( make_count ) {
  	  case 3:
        ope_mode = int.parse(QRReadBuf.substring(2));
        break;
  	  case 20:
        datetime = QRReadBuf.substring(6);
        break;
  	  case 29:
        qr_mac_no = int.parse(QRReadBuf.substring(18));
        break;
  	  case 38:
        qr_rcpt_no = int.parse(QRReadBuf.substring(27));
        break;
  	  case 44:
        qr_qty = int.parse(QRReadBuf.substring(36));
        break;
  	  case 53:
        qr_amt = int.parse(QRReadBuf.substring(42));
        break;
  	  case 64:
        page_now = int.parse(QRReadBuf.substring(58));
        break;
  	  case 66:
        myLog.logAdd(tid, LogLevelDefine.normal,
            "drvScanRcvQRtoMakeDataCR40() QRReadBuf[$QRReadBuf]\n");
        if ( QRReadBuf.substring(0, 2) == CR40_AI_CHK_HEADER_CODE) {
          myLog.logAdd(tid, LogLevelDefine.normal,
              "drvScanRcvQRtoMakeDataCR40 data_count 2 QR\n");
          page_max = int.parse(QRReadBuf.substring(60));
          DateTime dt = DateTime.now();
          now_datetime = DateFormat('yyyyMMddHHmmss').format(dt);
          filename = CR40_BASE_DIR + CR40_PREFIX +
                     ope_mode.toString().padLeft(2, '0') + now_datetime +
                     qr_mac_no.toString().padLeft(9, '0') +
                     qr_rcpt_no.toString().padLeft(9, '0');
          SerialReadBuf = "${QR_BIN_Q}$filename";
          data_count = SerialReadBuf.length;
          qr_status = 1;
          qr_http_flag = 2;
          try {
            if (!Directory(CR40_BASE_DIR + CR40_PREFIX).existsSync()) {
              Directory(CR40_BASE_DIR + CR40_PREFIX).createSync(recursive: true);
            }
          } catch(e) {
            break;
          }
          qr2txt.cmQrToTxtWriteCr40(QRReadBuf, filename, data_count);
      	  qr_txt_path = "${EnvironmentData().sysHomeDir}$QR2TEXT_TEXT_DIR/$QR2TEXT_TEXT_NAME$filename.TXT";
        }
        break;
  	  default:
        break;
    }

    if (devmsg == CRcode)	{
  	  if ( qr_status == 0) {
        make_count = 0;
        // tp1_system_flag = 0;	/* 承認キー判定フラグのクリア */
        // ticket_flag = 0;	/* 利用券(引換券)判定フラグのクリア */
        fPassportScanning = ScanCom.PASSPORT_SCAN_IDLE;  /* パスポートスキャンフラグをクリア */
        return;
  	  }

  	  cr40_read_page++;
  	  if ( page_max == cr40_read_page ) {
        // レシートファイルのMD5を作成   TODO:SS_CR2で使用するため一旦無視する。
        //md5_ret = MD5_Lib( CR40_MD5_CREATE, filename );

        // QCSELECTファイルの作成
        dir = "$SPQCC_BASE_DIR${EnvironmentData().sysHomeDir}";
        slct_path = "$dir/$QCSELECT_PREFIX$now_datetime$qr_mac_no$qr_rcpt_no$ope_mode.$QCSELECT_SUFFIX";
        cmd = "touch $slct_path";
        //system(cmd);

        qr_status = 0;
        make_count = 0;
        cr40_qr_status = 0;
        cr40_read_page = 0;
        // tp1_system_flag = 0;	/* 承認キー判定フラグのクリア */
        // ticket_flag = 0;	/* 利用券(引換券)判定フラグのクリア */
        fPassportScanning = ScanCom.PASSPORT_SCAN_IDLE;		/* パスポートスキャンフラグをクリア */
      }
      return;
    }
  }

  /// レピカ仕様の標準バーコードを読み取り中かを返す
  ///
  /// 引数:[tid] タスクID
  ///
  /// 戻り値：1：読み取り中、0：読み取り中ではない
  ///
  /// 関連tprxソース: drv_scan_rcv_plus.c - check_repica_scan_mode()
  Future<int> checkRepicaScanMode (TprTID tid) async {
    if (await CmCksys.cmRepicaStdCodeSystem() != 0) {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRet.isInvalid()) {
        myLog.logAdd(tid, LogLevelDefine.error, "Task stat get error");
        return (0);
      }
      RxTaskStatBuf tsBuf = xRet.object;
      if (tsBuf.repica.scan_flg != 0) {
        return (1);
      }
    }
    return (0);
  }

  /// RS232Cログ出力
  ///
  /// 引数:[devide] デバイスID
  ///
  /// 引数:[kind] 種別（送信 or 受信）
  ///
  /// 引数:[log] 受信中のバーコードデータ
  ///
  /// 引数:[data_count] 発生時刻の字数
  ///
  /// 引数:[date] 発生時刻
  ///
  /// 戻り値：なし
  ///
  /// 関連tprxソース: drv_scan_rcv_plus.c - check_repica_scan_mode()
  // TODO:ログの出し方は別途検討する。
  void cmRs232cLogWrite(int device, Rs232cCommKind kind, String log, int data_count, String date){
    cmRs232cLogWriteDate(device, kind, log, data_count, "");
  }

  void cmRs232cLogWriteDate(int device, Rs232cCommKind kind, String log, int data_count, String date){

  }
}
