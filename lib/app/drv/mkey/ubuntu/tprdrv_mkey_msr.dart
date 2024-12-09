/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/foundation.dart';

import '../../../fb/fb_lib.dart';
import './tprdrv_mkey.dart';
import './tprdrv_mkey_cmnmem.dart';
import './tprdrv_mkey_tbl.dart';
import '../../../common/cmn_sysfunc.dart';
import '../../common/com_rpt_tool.dart';

import '../../../inc/lib/rs232c.dart';
import '../../../inc/sys/tpr_did.dart';
import '../../../inc/sys/tpr_ipc.dart';
import '../../../inc/sys/tpr_log.dart';
import '../../../inc/sys/tpr_mid.dart';
import '../../../inc/sys/tpr_type.dart';

/// デバイスドライバ制御_メカキー（磁気カードリーダー参照）
///  関連tprxソース:\drv\mkey_2800\tprdrv_msr_2800.c
class TprDrvMkeyMsr {
  /* ＡＰＬへ送信するときのＳＳ、ＥＳ	*/
  static const MSR_JIS1_APL_SS = 0x0b; /* JIS1 Start Sentinel(開始コード)	*/
  static const MSR_JIS1_APL_ES = 0x0f; /* JIS1 End Sentinel(終了コード)	*/
  static const MSR_JIS2_APL_SS = 0x7f; /* JIS2 Start Sentinel(開始コード) */
  static const MSR_JIS2_APL_ES = 0x7f; /* JIS2 End Sentinel(終了コード) */

  static const JIS1MAX = 37;
  static const JIS2MAX = 69;

  /* linux/input.h: Keys and Button */
  static const KEY_5 = 5;
  static const KEY_EQUAL = 13;
  static const KEY_ENTER = 28;
  static const KEY_SEMICOLON = 39;
  static const KEY_SLASH = 53;
  static const KEY_RIGHTSHIFT = 54;
  static const KEY_RIGHTCTRL = 97;

  int jis1Len = 0;
  int jis2Len = 0;
  List<String> buf = List.generate(MsrInfo.MSR_RCVBUF_SIZE_MAX, (_) => "0");
  FbMem fbMem = TprDrvMkey().fbMem;

  /// 磁気カードリーダからのデータを取得する
  ///  関連tprxソース:tprdrv_msr_2800.c - msr_FromDevice()
  /// 引数:[code] 取得したキーコード
  /// 戻り値: なし
  Future<void> msrFromDevice(int code) async {
    int keyEnter = 0;

    MsrInput().code[TprDrvMkey().dataCount] = code;
    buf[TprDrvMkey().dataCount] = code.toString();

    /// TODO: readFbMem()の引数は暫定（現状、fbMemを初期化するのみ）
    fbMem = SystemFunc.readFbMem(null);

    if (fbMem.rpt_rec == 1) {
      String tmpLst = "";
      if (MsrInfo().device == Rs232cDev.RS232C_MSR2800D) {
        ComRptTool.comRptOpeRec(TprDidDef.TPRDIDMECKEY1, code, 0, tmpLst);
      } else {
        ComRptTool.comRptOpeRec(TprDidDef.TPRDIDMECKEY2, code, 0, tmpLst);
      }
    }

    if (code != KEY_ENTER) {
      if (fbMem.FBvnc == 0) {
        TprDrvMkey().dataCount++;
      }
    } else {
      if (fbMem.FBvnc == 0) {
        /// TODO: cm_rs232c_log_write()は、暫定で無効にする
        //cm_rs232c_log_write(MsrInfo().device, Rs232cCommKind.RS232C_RCV, buf, TprDrvMkey().dataCount);
        await tprdrvMsrRcv();
      } else {
        TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.normal,
            "ignore MSR data on FBvnc != 0");
      }
      MsrInfo().msrFlg = false;
    }

    return;
  }

  /// 受信処理（磁気カードデータＢＣＣ待ち）
  ///  関連tprxソース:tprdrv_msr_2800.c - tprdrv_msr_Rcv()
  Future<void> tprdrvMsrRcv() async {
    List<String> jis1 = List.generate(MsrInfo.MSR_JISBUF_SIZE_MAX, (_) => '0');
    List<String> jis2 = List.generate(MsrInfo.MSR_JISBUF_SIZE_MAX, (_) => '0');
    List<String> sendData = List.generate(256, (_) => '0');
    List<String> sendDataCvv = List.generate(256, (_) => '0');
    List<String> sendtmp = List.generate(256, (_) => '0');
    int sendLen = 0;

    _tprdrvMsrDataCompare();
    if (TprDrvMkey().dataCount > 0) {
      if (await _tprdrvMsrEdit(jis1, jis2, TprDrvMkey().dataCount)) {
        TprDrvMkey().dataCount = 0;
        buf = List.generate(MsrInfo.MSR_RCVBUF_SIZE_MAX, (_) => "0");
        return;
      }
      TprDrvMkey().dataCount = 0;
      buf = List.generate(MsrInfo.MSR_RCVBUF_SIZE_MAX, (_) => "0");
      if (jis2Len > 0) {
        sendData[sendLen++] = String.fromCharCode(0x01);
        sendData[sendLen++] = String.fromCharCode(MSR_JIS2_APL_SS);
        sendData.insertAll(sendLen, jis2);
        sendLen += jis2Len;
        sendData[sendLen++] = String.fromCharCode(MSR_JIS2_APL_ES);
        sendtmp = sendData.sublist(2);
        sendData[sendLen] = _tprdrvMsrMakeBcc(sendData, sendLen - 2);
        sendDataCvv = sendData;
        sendDataCvv[67] = String.fromCharCode(0x30);
        sendDataCvv[68] = String.fromCharCode(0x30);
        sendDataCvv[69] = String.fromCharCode(0x30);

        /// TODO: cm_rs232c_log_write()は、暫定で無効にする
        //cm_rs232c_log_write(MsrInfo().device, Rs232cCommKind.RS232C_SEND, sendDataCvv, sendLen);
        _tprdrvMsrResNotify(
            MsrInfo().myDid[1], TprDidDef.TPRDEVRESULTOK, sendData, sendLen);
        MsrInfo().compCnt = 0;
      }
      if (jis1Len > 0) {
        sendLen = 0;
        sendData[sendLen++] = String.fromCharCode(0x01);
        sendData[sendLen++] = String.fromCharCode(MSR_JIS1_APL_SS);
        for (int i = 0; i < jis1Len; i++) {
          sendData[sendLen++] =
              String.fromCharCode(jis1[i].codeUnitAt(0) & 0x0f);
        }
        sendData[sendLen++] = String.fromCharCode(MSR_JIS1_APL_ES);
        sendtmp = sendData.sublist(1);
        sendData[sendLen] = _tprdrvMsrMakeBcc(sendData, sendLen - 1);
        sendLen++;
        sendDataCvv = sendData;
        sendDataCvv[31] = String.fromCharCode(0x00);
        sendDataCvv[32] = String.fromCharCode(0x00);
        sendDataCvv[33] = String.fromCharCode(0x00);

        /// TODO: cm_rs232c_log_write()は、暫定で無効にする
        //cm_rs232c_log_write(MsrInfo().device, Rs232cCommKind.RS232C_SEND, sendDataCvv, sendLen);
        _tprdrvMsrResNotify(
            MsrInfo().myDid[0], TprDidDef.TPRDEVRESULTOK, sendData, sendLen);
        MsrInfo().compCnt = 0;
      }
      jis1 = List.generate(MsrInfo.MSR_JISBUF_SIZE_MAX, (_) => '0');
      jis2 = List.generate(MsrInfo.MSR_JISBUF_SIZE_MAX, (_) => '0');
      sendData = List.generate(256, (_) => '0');
    } else {
      TprLog().logAdd(
          TprDrvMkey().myTid, LogLevelDefine.error, "ERROR data_count < 0");
    }
    MsrInfo().msrFlg = false;
    TprDrvMkey().dataCount = 0;
    buf = List.generate(MsrInfo.MSR_RCVBUF_SIZE_MAX, (_) => '0');
  }

  /// 磁気カード受信データを直前のデータと比較する
  ///  関連tprxソース:tprdrv_msr_2800.c - tprdrv_msr_DataCompare()
  void _tprdrvMsrDataCompare() {
    int compCntMax = MsrInfo().compCntMax;

    if (TprDrvMkey().dataCount > 0) {
      if (listEquals(buf,
          MsrInfo().readBufSave.take(MsrInfo.MSR_RCVBUF_SIZE_MAX).toList())) {
        TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.error,
            "ReadData same error [max:$compCntMax cnt:${MsrInfo().compCnt + 1}]");
        if (_drvMsrDataCompareSkip()) {
          TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.normal,
              "SerialDataCompare Check Skip !!");
          return;
        }
        if ((compCntMax - 1) <= MsrInfo().compCnt) {
          MsrInfo().readBufSave =
              List.generate(MsrInfo.MSR_RCVBUF_SIZE_MAX + 1, (_) => '0');
          MsrInfo().jis1Save =
              List.generate(MsrInfo.MSR_JISBUF_SIZE_MAX, (_) => '0');
          MsrInfo().jis2Save =
              List.generate(MsrInfo.MSR_JISBUF_SIZE_MAX, (_) => '0');
          MsrInfo().compCnt = 0;
        } else {
          MsrInfo().compCnt++;
        }
        TprDrvMkey().dataCount = 0;
        buf = List.generate(MsrInfo.MSR_RCVBUF_SIZE_MAX, (_) => '0');
      } else {
        MsrInfo().readBufSave.replaceRange(0, buf.length, buf);
      }
    }
  }

  /// データが直前のデータと同じだった場合のエラーをスキップするか
  ///  関連tprxソース:tprdrv_msr_2800.c - drv_msr_DataCompareSkip()
  /// 戻り値：true = エラーをスキップする
  ///       false = エラーをスキップしない
  bool _drvMsrDataCompareSkip() {
    return true;
  }

  /// 磁気カードデータからをＪＩＳ１とＪＩＳ２を取得する
  ///  関連tprxソース:tprdrv_msr_2800.c - tprdrv_msr_Edit()
  /// 引数:[jis1] jis1データ
  ///     [jis2] jis2データ
  ///     [dataLen] データ長
  /// 戻り値：true = Normal End
  ///       false = Error
  Future<bool> _tprdrvMsrEdit(
      List<String> jis1, List<String> jis2, int dataLen) async {
    TprDrvMkey().tbl = MkeyTbl().MkeyTbl68;

    TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.normal,
        "tprdrvMsrEdit() Chk[$KEY_ENTER][$KEY_SLASH][$KEY_RIGHTSHIFT][$KEY_5][$KEY_SEMICOLON][$KEY_EQUAL] dataLen:[$dataLen] DataLast:[${MsrInput().code[dataLen]}]");

    int i = -1;
    int j = 0;
    int k = 0;
    bool result = false;
    List<String> jis1Cvv =
        List.generate(MsrInfo.MSR_JISBUF_SIZE_MAX, (_) => '0');
    List<String> jis2Cvv =
        List.generate(MsrInfo.MSR_JISBUF_SIZE_MAX, (_) => '0');

    while (true) {
      if (i != -1) {
        if (MsrInput().code[i] == KEY_ENTER) {
          TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.normal,
              "tprdrvMsrEdit() MSR Last Enter[${MsrInput().code[i]}]");
          break;
        }
        if (i >= dataLen) {
          TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.error,
              "tprdrvMsrEdit() MSR Data Length[$dataLen] EditCount[$i] End");
          return false;
        }
      }
      i++;
      /* JIS2 */
      if ((MsrInput().code[i] == KEY_RIGHTSHIFT) &&
          (MsrInput().code[i + 1] == KEY_5)) {
        i += 2;
        j = 0;
        if (i >= dataLen) {
          TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.error,
              "tprdrvMsrEdit() MSR Data Length[$dataLen] EditCount[$i] End in JIS2-1");
          return false;
        }
        while (true) {
          if (j > JIS2MAX) {
            jis2Len = j;
            TprLog().logAdd(
                TprDrvMkey().myTid, LogLevelDefine.error, "JIS2 Max Length");
            return false;
          }
          if (i >= dataLen) {
            TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.error,
                "tprdrvMsrEdit() MSR Data Length[$dataLen] EditCount[$i] End in JIS2-2");
            return false;
          }
          if (MsrInput().code[i] == KEY_RIGHTSHIFT) {
            if (MsrInput().code[i + 1] == KEY_SLASH) {
              i += 2;
              result = await _drvMsrDataLengthChk(j, 2);
              if (!result) {
                k = i;
                while (true) {
                  if ((MsrInput().code[k] == KEY_RIGHTSHIFT) &&
                      (MsrInput().code[k + 1] == KEY_SLASH)) {
                    i -= 2;
                    result = true;
                    i++;
                    if (TprDrvMkey().tbl[MsrInput().code[i]][3] == "\xff") {
                      /* s_ascii */
                      TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.error,
                          "JIS2 KEY_RIGHTSHIFT+Don't Know[${MsrInput().code[i]}]");
                      return false;
                    }
                    jis2[j] = TprDrvMkey().tbl[MsrInput().code[i]][3];
                  }
                  k++;
                  if (k > dataLen) {
                    TprLog().logAdd(
                        TprDrvMkey().myTid, LogLevelDefine.error, "No EndCode");
                    break;
                  }
                }
              }
              jis2Len = j;
              TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.normal,
                  "Code Type[JIS2] Length[$jis2Len]");
              jis2Cvv = jis2;
              for (int p = 65; p < 68; p++) {
                /* for CVV */
                jis2Cvv[p] = '0';
              }
              _tprdrvMsrDataLogWrite(jis2Cvv, jis2Len);
              if (!result) {
                return false;
              }
            }
            i++;
            if (TprDrvMkey().tbl[MsrInput().code[i]][4] == "\xff") {
              /* s_ascii */
              TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.error,
                  "tprdrvMsrEdit() JIS2 KEY_RIGHTSHIFT+Don't Know[${MsrInput().code[i]}]");
              return false;
            }
            jis2[j] = TprDrvMkey().tbl[MsrInput().code[i]][4];
          } else if (MsrInput().code[i] == KEY_RIGHTCTRL) {
            i++;
            if (MsrInput().code[i] == KEY_RIGHTSHIFT) {
              i++;
              if ((TprDrvMkey().tbl[MsrInput().code[i]][6] != '0') &&
                  (TprDrvMkey().tbl[MsrInput().code[i]][5] != "\xff")) {
                /* shift_ctrl && c_ascii */
                jis2[j] = TprDrvMkey().tbl[MsrInput().code[i]][5];
              } else {
                TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.error,
                    "tprdrvMsrEdit() JIS2 KEY_RIGHTCTRL+SHIFT+Don't Know[${MsrInput().code[i]}]");
                return false;
              }
            } else {
              if ((TprDrvMkey().tbl[MsrInput().code[i]][6] == '0') &&
                  (TprDrvMkey().tbl[MsrInput().code[i]][5] != "\xff")) {
                /* shift_ctrl && c_ascii */
                jis2[j] = TprDrvMkey().tbl[MsrInput().code[i]][5];
              } else {
                TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.error,
                    "tprdrvMsrEdit() JIS2 KEY_RIGHTCTRL+Don't Know[${MsrInput().code[i]}]");
                return false;
              }
            }
            break;
          } else {
            if (TprDrvMkey().tbl[MsrInput().code[i]][3] == "\xff") {
              TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.error,
                  "tprdrvMsrEdit() JIS2 Don't Know[${MsrInput().code[i]}]");
              return false;
            }
            jis2[j] = TprDrvMkey().tbl[MsrInput().code[i]][4];
            break;
          }
          i++;
          j++;
        }
      }
      /* JIS1 Track2 */
      if (MsrInput().code[i] == KEY_SEMICOLON) {
        i++;
        j = 0;
        if (i >= dataLen) {
          TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.error,
              "tprdrvMsrEdit() MSR Data Length[$dataLen] EditCount[$i] End in JIS1-1");
          return false;
        }
        while (true) {
          if (TprDrvMkey().tbl[MsrInput().code[i]][4] == "\xff") {
            TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.error,
                "tprdrvMsrEdit() JIS1 Track2 Don't Know[${MsrInput().code[i]}]");
            return false;
          }
          jis1[j] = TprDrvMkey().tbl[MsrInput().code[i]][4];
          i++;
          j++;
          if ((MsrInput().code[i] == KEY_RIGHTSHIFT) &&
              (MsrInput().code[i + 1] == KEY_SLASH)) {
            i += 2;
            jis1Len = j;
            TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.normal,
                "Code Type[JIS1] Length[$jis1Len]");
            jis1Cvv = jis1;
            for (int p = 29; p < 32; p++) {
              /* for CVV */
              jis1Cvv[p] = '0';
            }
            _tprdrvMsrDataLogWrite(jis1Cvv, jis1Len);
            result = await _drvMsrDataLengthChk(jis1Len, 1);
            if (!result) {
              return false;
            }
            break;
          }
          if (j > JIS1MAX) {
            jis1Len = j;
            TprLog().logAdd(
                TprDrvMkey().myTid, LogLevelDefine.error, "JIS1 Max Length");
            return false;
          }
          if (i >= dataLen) {
            TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.error,
                "tprdrvMsrEdit() MSR Data Length[$dataLen] EditCount[$i] End in JIS1-2");
            return false;
          }
        }
      }
      /* JIS1 Track3 */
      if ((MsrInput().code[i] == KEY_RIGHTSHIFT) &&
          (MsrInput().code[i + 1] == KEY_EQUAL)) {
        TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.normal,
            "JIS1 Track3 Don't Know Jump Code!!");
        i += 2;
        j = 0;
        if (i >= dataLen) {
          TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.error,
              "tprdrvMsrEdit() MSR Data Length[$dataLen] EditCount[$i] End in Track3-1");
          return false;
        }
        while (true) {
          i++;
          j++;
          if ((MsrInput().code[i] == KEY_RIGHTSHIFT) &&
              (MsrInput().code[i + 1] == KEY_SLASH)) {
            i += 2;
            break;
          }
          if (i >= dataLen) {
            TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.error,
                "tprdrvMsrEdit() MSR Data Length[$dataLen] EditCount[$i] End in Track3-2");
            return false;
          }
        }
      }
    }
    _tprdrvMsrJis1Jis2DataCompare(jis1, jis2);

    return true;
  }

  /// BCCを算出する
  ///  関連tprxソース:tprdrv_msr_2800.c - tprdrv_msr_make_bcc()
  /// 引数:[data] レスポンスデータ
  ///     [len] データ長
  /// 戻り値：BCC
  String _tprdrvMsrMakeBcc(List<String> data, int len) {
    int bcc = 0x00;

    do {
      len--;
      bcc ^= data[len].codeUnitAt(0);
    } while (len > 0);

    return String.fromCharCode(bcc);
  }

  /// 磁気カードデータからをＪＩＳ１とＪＩＳ２を取得する
  ///  関連tprxソース:tprdrv_msr_2800.c - tprdrv_msr_ResNotify()
  /// 引数:[did] デバイスID
  ///     [result] 通信結果(TPRDEVRESULT????)
  ///     [data] レスポンスデータ
  ///     [dataLen] データ長
  /// 戻り値：true = Normal End
  ///       false = Error
  bool _tprdrvMsrResNotify(
      TprDID did, int result, List<String> data, int dataLen) {
    TprMsg_t msg = TprMsg();

    if (dataLen > 1024) {
      /* sizeof(tprmsg_t.devnotify.data) */
      List<String> tmp = [""];
      _tprdrvMsrResNotify(did, TprDidDef.TPRDEVRESULTRERR, tmp, 0);
      TprLog().logAdd(
          TprDrvMkey().myTid, LogLevelDefine.error, " read size over error");
      return false;
    }
    TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.normal,
        "_tprdrvMsrResNotify() datalen[$dataLen]");
    msg.devnotify.mid = TprMidDef.TPRMID_DEVNOTIFY;
    msg.devnotify.length = 1048 - 8 - 1024 + dataLen;
    //sizeof(tprmsgdevnotify_t) - sizeof(tprcommon_t) - sizeof(Msg.devnotify.data) + dataLen;
    msg.devnotify.tid = did; /* device ID */
    msg.devnotify.io = TprDidDef.TPRDEVIN; /* input or output */
    msg.devnotify.result = result;
    msg.devnotify.datalen = dataLen; /* datalen & sequence No. */
    msg.devnotify.data = List.generate(msg.devnotify.data.length, (_) => "0");

    if (msg.devnotify.datalen > 0) {
      msg.devnotify.data.replaceRange(0, data.length, data);
    }

    /// TODO:write()は処理なし
    SystemFunc.write(MsrInfo().sysPipe, msg, 1048 - 1024 + dataLen);

    return true;
  }

  /// ＪＩＳ１，ＪＩＳ２のデータがmsr_chk.iniの設定値と同一かをチェックする
  ///  関連tprxソース:tprdrv_msr_2800.c - drv_msr_DataLengthChk()
  /// 引数:[dataLen] データ長
  ///     [type] JIS種類（1:JIS1, 2:JIS2）
  /// 戻り値：true = Normal End
  ///       false = Error
  Future<bool> _drvMsrDataLengthChk(int length, int type) async {
    String jisType = "JIS$type";

    if ((type != 1) && (type != 2)) {
      TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.normal,
          "_drvMsrDataLengthChk() NO CHECK!");
      return true;
    }

    /// TODO:msr_chk.iniファイルが未定義のため、暫定処理を用意
    TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.normal,
        "_drvMsrDataLengthChk() Pass");
    /*
    Msr_chkJsonFile msrChkIni = Msr_chkJsonFile();
    msrChkIni.setAbsolutePath(AppPath().path);
    await msrChkIni.load();

    final sectMax = await msrChkIni.getValueWithName(jisType, "max_length");
    final sectMin = await msrChkIni.getValueWithName(jisType, "min_length");
    if (!sectMax.result || !sectMin.result) {
      TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.error,
          "_drvMsrDataLengthChk() msr_chk.ini file error $jisType max_length:${sectMax
              .cause.name} min_length:${sectMin.cause.name}");
      return false;
    }
    if ((sectMax.value == 0) && (sectMin.value == 0)) {
      TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.normal,
          "_drvMsrDataLengthChk() $jisType chk_len All Zero");
      return true;
    }
    TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.normal,
        "_drvMsrDataLengthChk() $jisType Length Check Start");

    length = length + 3;
    if (((length + 3) < sectMin.value) || (sectMax.value < (length + 3))) {
      TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.error,
          "_drvMsrDataLengthChk() Check NG!!!!! max:[${sectMax.value}] min:[${sectMin.value}]   Data Length[$length]");
      return false;
    }
    TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.normal,
        "_drvMsrDataLengthChk() Check OK! max:[${sectMax.value}] min:[${sectMin.value}]   Data Length[$length]");
     */

    return true;
  }

  /// 磁気カードデータＪＩＳ１／ＪＩＳ２をログに書き込む
  ///  関連tprxソース:tprdrv_msr_2800.c - tprdrv_msr_DataLogWrite()
  /// 引数:[data] レスポンスデータ
  ///     [size] データ長
  /// 戻り値：true = Normal End
  ///       false = Error
  void _tprdrvMsrDataLogWrite(List<String> data, int size) {
    String strBuf = "";
    int cntMax = (size < 127) ? size : 127; //(256/2)-1

    for (int cnt = 0; cnt < cntMax; cnt++) {
      strBuf +=
          "0x${data[cnt].codeUnitAt(0).toRadixString(16).padLeft(2, '0')}";
    }
    TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.normal, strBuf);
  }

  /// 磁気カードデータＪＩＳ１／ＪＩＳ２をログに書き込む
  ///  関連tprxソース:tprdrv_msr_2800.c - tprdrv_msr_Jis1Jis2DataCompare()
  /// 引数:[jis1] JIS1データ
  ///     [jis2] JIS2データ
  /// 戻り値: なし
  void _tprdrvMsrJis1Jis2DataCompare(List<String> jis1, List<String> jis2) {
    int compCntMax = MsrInfo().compCntMax;
    bool resultFlg = false;

    if (jis2Len > 0) {
      if (listEquals(jis2, MsrInfo().jis2Save)) {
        TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.error,
            "JIS2 same error [max:$compCntMax cnt:${MsrInfo().compCnt + 1}]");
        if (_drvMsrDataCompareSkip()) {
          TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.normal,
              "Jis2DataCompare Check Skip !!");
        } else {
          resultFlg = true;
        }
      } else {
        MsrInfo().jis2Save = jis2;
      }
    }
    if (jis2Len == 0) {
      MsrInfo().jis2Save = List.generate(MsrInfo().jis2Save.length, (_) => '0');
    }

    if (jis1Len > 0) {
      if (listEquals(jis1, MsrInfo().jis1Save)) {
        TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.error,
            "JIS1 same error [max:$compCntMax cnt:${MsrInfo().compCnt + 1}]");
        if (_drvMsrDataCompareSkip()) {
          TprLog().logAdd(TprDrvMkey().myTid, LogLevelDefine.normal,
              "Jis1DataCompare Check Skip !!");
        } else {
          resultFlg = true;
        }
      } else {
        MsrInfo().jis1Save = jis1;
      }
    }
    if (jis1Len == 0) {
      MsrInfo().jis1Save = List.generate(MsrInfo().jis1Save.length, (_) => '0');
    }

    if (resultFlg) {
      /* Same Data */
      if ((compCntMax - 1) <= MsrInfo().compCnt) {
        MsrInfo().readBufSave =
            List.generate(MsrInfo().readBufSave.length, (_) => '0');
        TprDrvMkey().dataCount = 0;
        MsrInfo().jis2Save =
            List.generate(MsrInfo().jis2Save.length, (_) => '0');
        MsrInfo().jis1Save =
            List.generate(MsrInfo().jis1Save.length, (_) => '0');
        MsrInfo().compCnt = 0;
      } else {
        MsrInfo().compCnt++;
      }
      jis2Len = 0;
      jis1Len = 0;
    }

    return;
  }
}
