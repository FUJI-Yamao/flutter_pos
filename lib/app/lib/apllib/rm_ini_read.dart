/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';
import 'dart:typed_data';

import 'package:charset_converter/charset_converter.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/cls_conf/counterJsonFile.dart';
import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/cls_conf/mbrrealJsonFile.dart';
import '../../common/cls_conf/soundJsonFile.dart';
import '../../common/cls_conf/sysJsonFile.dart';
import '../../common/cls_conf/sys_paramJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../cm_sound/sound.dart';
import 'hostfile_control.dart';
import 'netplan_control.dart';
import 'rx_prt_flag_set.dart';
import 'staff_auth.dart';

///  関連tprxソース: rminread.c
class RmIniRead {
  /// エラーダイアログのID
  /// rminread.c - ret_val.
  DlgConfirmMsgKind _msgKind = DlgConfirmMsgKind.MSG_NONE;
  late RxCommonBuf _pCom;
   // 決済用の設定ファイル.jsonではなくini
  static String get  tccUtsIniPath  => 
     "${EnvironmentData().sysHomeDir}/conf/multi_tmn/TccUts.ini";
  

  /// エラーダイアログIDを上書きする関数.
  void _setErrDlgId(DlgConfirmMsgKind kind) {
    if (_msgKind != DlgConfirmMsgKind.MSG_NONE) {
      return;
    }
    _msgKind = kind;
  }

  RmIniRead() {
    _msgKind = DlgConfirmMsgKind.MSG_NONE;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return ;
    }
    RxCommonBuf pCom = xRet.object;
    _pCom = pCom;
  }

  /// 登録モード用.iniファイル読み込みメイン関数
  /// 関連tprxソース: rminread.c - rmIniReadMain()
  Future<DlgConfirmMsgKind> rmIniReadMain() async {
    List<Future<bool>> futureList = [];

    // jsonファイル読み込み.
    futureList.add(rmIniCounterRead());
    futureList.add(rmIniMacinfoRead());

    // macInfoの処理を使用するため一旦全て読み込みが終わるまで待つ.
    await Future.wait(futureList);

    futureList.clear();
    // sys.json
    await _rmIniSysScpuRead();
    //  sys_param.ini
    await _rmIniSysparamRead();

    if (CompileFlag.FB2GTK) {
      // rmIniDspcolorRead
    }

    //  mbrreal.json
    futureList.add(_rmIniMbrRealRead());
    // multi_tmn/TccUts.json
    futureList.add(_rmIniMultiRead());
    // lottery.json
    futureList.add(_rmIniLotteryRead());

    TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.normal,
        "rmIniReadMain() ret_val[${_msgKind.name}]");

    // MEMO:QCJCは実装対象外.

    /// すべて読み込むまで待つ.
    await Future.wait(futureList);
    return _msgKind;
  }

  /// counter.jsonを読み込む.
  ///  関連tprxソース: rminread.c - rmIniCounterRead()
  Future<bool> rmIniCounterRead() async {
    try {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "rmIniCounterRead() start");
      CounterJsonFile counter = CounterJsonFile();
      await counter.load();
      _pCom.iniCounter = counter;
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "counter.json:rpct_no[${_pCom.iniCounter.tran.receipt_no}]");

      // ログイン情報を初期化.
      StaffAuth.SetStaffInfo(Tpraid.TPRAID_SYST, _pCom,
          StaffInfoIndex.STAFF_INFO_LOGIN, -1, "", 0);
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "rmIniCounterRead() end(OK)");

      return true;
    } catch (e, s) {
      _setErrDlgId(DlgConfirmMsgKind.MSG_COUNTER_NOTREAD);
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "rmIniCounterRead() end(NG),$e,$s");
      return false;
    }
  }

  /// mac_info.json
  /// 関連tprxソース: rminread.c - rmIniMacinfoRead()
  Future<bool> rmIniMacinfoRead() async {
    try {
      Mac_infoJsonFile macInfo = Mac_infoJsonFile();
      await macInfo.load();
      _pCom.iniMacInfo = macInfo;
      if (CompileFlag.RCTLOGO_STPRN) {
        _pCom.iniMacInfo.printer.rct_tb_cut = 0;
      }
      if (CompileFlag.DRUG_REVISION) {
        // TODO:10005 DRUG_REVISION 今のところfalseなので割愛.
      }

      return true;
    } catch (e, s) {
      _setErrDlgId(DlgConfirmMsgKind.MSG_INFO_NOTREAD);
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "_rmIniMacinfoRead() end(NG),$e,$s");
      return false;
    }
  }

  /// sys_param.json読み込み
  ///  関連tprxソース: rminread.c - rmIniSysparamRead()
  Future<bool> _rmIniSysparamRead() async {
    try {
      Sys_paramJsonFile sysParam = Sys_paramJsonFile();
      await sysParam.load();
      // 自分のホスト名をホストファイルから取得.
      String myHostName = HostFileControl.getHostName();

      // 自分のIPアドレスをホストファイルから取得.
      String myIp = HostFileControl.getHostByNameStr(myHostName);
      if (myIp.isNotEmpty) {
        _pCom.iniSysParam.mblIp = myIp;
      }
      String serverName = sysParam.master.name;
      if (_pCom.iniMacInfo.mm_system.mm_onoff == 0) {
        serverName = sysParam.server.name;
      }
      // サーバーのIPアドレスを取得.
      String serverIp = HostFileControl.getHostByNameStr(serverName);
      if (serverIp.isNotEmpty) {
        _pCom.iniSysParam.mblIp = serverIp;
      }
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "sys_param.ini:svr[$serverName] ip[${_pCom.iniSysParam.svrIp}]");

      // TODO:10006 DBサーバーへの接続　DBはsqliteのため、ipアドレスは不要のはず.
      List<int> dbIp = HostFileControl.getHostByName(sysParam.db.name);
      if (dbIp.isNotEmpty) {
        _pCom.iniSysParam.dbSvrIp = dbIp.join(".");
      }
      if (_pCom.iniSysParam.dbSvrIp.isEmpty ||
          _pCom.iniSysParam.dbSvrIp == "0.0.0.0") {
        // DB用の設定がされてないならサーバーと同じ.
        _pCom.iniSysParam.dbSvrIp = _pCom.iniSysParam.svrIp;
      }

      // サブサーバー.
      String subServerIp =
          HostFileControl.getHostByNameStr(sysParam.subserver.name);
      if (subServerIp.isNotEmpty) {
        _pCom.iniSysParam.mblIp = subServerIp;
      }
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "sys_param.ini:sub[$serverName] ip[${_pCom.iniSysParam.subIp}]");

      // TODO:10006 DBサーバーへの接続　DBはsqliteのため、ipアドレスは不要のはず.webAPIに置き換わる?
      _pCom.iniSysParam.localdbname = sysParam.db.localdbname;
      _pCom.iniSysParam.localdbuser = sysParam.db.localdbuser;
      _pCom.iniSysParam.localdbpass = sysParam.db.localdbpass;

      if (_pCom.iniMacInfo.mm_system.mm_onoff == 0) {
        _pCom.iniSysParam.hostdbname = sysParam.db.hostdbname;
        _pCom.iniSysParam.hostdbuser = sysParam.db.hostdbuser;
        _pCom.iniSysParam.hostdbpass = sysParam.db.hostdbpass;
      } else {
        _pCom.iniSysParam.hostdbname = sysParam.db.masterdbname;
        _pCom.iniSysParam.hostdbuser = sysParam.db.masterdbuser;
        _pCom.iniSysParam.hostdbpass = sysParam.db.masterdbpass;
      }
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "sys_param.ini:localdbname[${_pCom.iniSysParam.localdbname}] user[${_pCom.iniSysParam.localdbuser}] pass[${_pCom.iniSysParam.localdbpass}]");
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "sys_param.ini:hostdbname[${_pCom.iniSysParam.hostdbname}] user[${_pCom.iniSysParam.hostdbuser}] pass[${_pCom.iniSysParam.hostdbpass}]");

      // mobilePOS.
      String mobileIp = HostFileControl.getHostByNameStr(sysParam.mobile.name);
      if (mobileIp.isNotEmpty) {
        _pCom.iniSysParam.mblIp = mobileIp;
      }
      // センターサーバー.
      String host = HostFileControl.getHostByNameStr("centerserver_mst");
      if (host.isNotEmpty) {
        _pCom.iniSysParam.csvrMstIp = host;
      }
      host = HostFileControl.getHostByNameStr("centerserver_trn");
      if (host.isNotEmpty) {
        _pCom.iniSysParam.csvrTrnIp = host;
      }
      _pCom.iniSysParam.csvrDbname = sysParam.db.hostdbname;
      _pCom.iniSysParam.csrvDbuser = sysParam.db.hostdbuser;
      _pCom.iniSysParam.csrvDbpass = sysParam.db.hostdbpass;

      // TODO:10007 設定ファイルにないデータ hostdbuser_tscs
      _pCom.iniSysParam.hostdbuserTscs =
          sprintf("%s%06d", [' ', _pCom.iniMacInfo.system.shpno]);

      // ポイントアーティスト 接続方式取得.
      _pCom.iniSysParam.paConectTyp = 0;
      if (await CmCksys.cmCustrealPointartistSystem() != 0) {
        _pCom.iniSysParam.paConectTyp = sysParam.custreal2_pa.conect_typ;
      } else {
        _pCom.iniSysParam.dbConnectTimeout = sysParam.db.db_connect_timeout;
      }
      // 顧客(予約)DBサーバー
      _pCom.iniSysParam.custsvrDbname = sysParam.cust_reserve_db.hostdbname;
      _pCom.iniSysParam.custsvrDbuser = sysParam.cust_reserve_db.hostdbuser;
      _pCom.iniSysParam.custsvrDbpass = sysParam.cust_reserve_db.hostdbpass;

      host = HostFileControl.getHostByNameStr("cust_reserve_svr");
      if (host.isNotEmpty) {
        _pCom.iniSysParam.custsvrIp = host;
      }

      // TODO:10007 設定ファイルにないデータ WS様 HQサーバー
      // WS様 HQサーバー
      // pCom.iniSysParam.wsHqDbname = sysParam.ws_hq.hostdbname;
      // pCom.iniSysParam.wsHqDbuser = sysParam.ws_hq.hostdbuser;
      // pCom.iniSysParam.wsHqDbpass = sysParam.ws_hq.hostdbpass;
      //
      // host = HostFileControl.getHostByNameStr("ws_hq");
      // if (host.isNotEmpty) {
      //   pCom.iniSysParam.wsHqIp = host;
      // }
      return true;
    } catch (e, s) {
      _setErrDlgId(DlgConfirmMsgKind.MSG_SYS_PARAM_NOTREAD);
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "_rmIniMacinfoRead() end(NG),$e,$s");
      return false;
    }
  }

  /// sys.json読み込み
  ///  関連tprxソース: rminread.c - rmIniSysScpuRead()
  Future<bool> _rmIniSysScpuRead() async {
    try {
      _pCom.iniSys = SysJsonFile();
      await _pCom.iniSys.load();
      SysJsonFile sysInfo = _pCom.iniSys;

      if (sysInfo.type.tower == "yes") {
        _pCom.iniSys_tower = true;
      } else {
        _pCom.iniSys_tower = false;
      }
      if (sysInfo.type.mskind == "m") {
        _pCom.iniSys_tower = false;
      } else {
        _pCom.iniSys_tower = true;
      }
      await RxPrtFlagSet.rcSetSysiniToMemory();
      await RxPrtFlagSet.rcSetMemberSysiniToMemory();

      _pCom.iniScpu.brgtky = sysInfo.lcdbright.lcdbright1;
      _pCom.iniScpu.brgtky2 = sysInfo.lcdbright.lcdbright2;
      _pCom.iniScpu.kvlmky = sysInfo.speaker.keyvol1;
      _pCom.iniScpu.kvlmky2 = sysInfo.speaker.keyvol2;
      _pCom.iniScpu.pitchky = sysInfo.speaker.keytone1;
      _pCom.iniScpu.pitchky2 = sysInfo.speaker.keytone2;
      _pCom.iniScpu.scanvlmky = sysInfo.speaker.scanvol1;
      _pCom.iniScpu.scanvlmky2 = sysInfo.speaker.scanvol2;
      _pCom.iniScpu.scanpitchky = sysInfo.speaker.scantone1;
      _pCom.iniScpu.scanpitchky2 = sysInfo.speaker.scantone2;

      return true;
    } catch (e, s) {
      _setErrDlgId(DlgConfirmMsgKind.MSG_SYS_NOTREAD);
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "_rmIniSysScpuRead() end(NG),$e,$s");
      return false;
    }
  }

  /// mbrreal.json読み込み
  ///  関連tprxソース: rminread.c - rmIniMbrRealRead()
  Future<bool> _rmIniMbrRealRead() async {
    try {
      MbrrealJsonFile mbrrealJson = MbrrealJsonFile();
      await mbrrealJson.load();
      _pCom.iniMbrreal = mbrrealJson;

      return true;
    } catch (e, s) {
      _setErrDlgId(DlgConfirmMsgKind.MSG_SYS_NOTREAD);
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "_rmIniMbrRealRead() end(NG),$e,$s");
      return false;
    }
  }

  /// multi_tmn/TccUts.json読み込み
  ///  関連tprxソース: rminread.c - rmIniMultiRead()
  Future<bool> _rmIniMultiRead() async {
    try {
    //
      {
        // ネットワークの設定がなければ追加する.
        await setNetConfigReferencePath();

        String defaultValue = "".padLeft(RxTccutsIni.TCCUTS_TID_LEN, "0");
        _pCom.ini_multi.QP_tid = defaultValue;
        _pCom.ini_multi.iD_tid = defaultValue;
        _pCom.ini_multi.Suica_tid = defaultValue;
        _pCom.ini_multi.Edy_tid = defaultValue;

        String filePath = tccUtsIniPath;
        File tccUts = TprxPlatform.getFile(filePath);
        List<String> data = [];
        if(Platform.isLinux) {
          List<int> byteList = tccUts.existsSync()
              ? tccUts.readAsBytesSync()
              : [];
          if (byteList.isEmpty) {
            return true;
          }

          // 文字コードがEUC.
          String decode = await CharsetConverter.decode(
              'euc-jp', Uint8List.fromList(byteList));
          data = decode.split("\n");
        }

        if ((await CmCksys.cmUt1QUICPaySystem() != 0) ||
            (await CmCksys.cmMultiVegaSystem() != 0)) {
          final (bool isSuccess, String dataValue) =
              getTccUtsTermId(data, "TEM100");
          _pCom.ini_multi.QP_tid = isSuccess ? dataValue : defaultValue;
        }

        if ((await CmCksys.cmUt1IDSystem() != 0) ||
            (await CmCksys.cmMultiVegaSystem() != 0)) {
          final (bool isSuccess, String dataValue) =
              getTccUtsTermId(data, "TEM200");
          _pCom.ini_multi.iD_tid = isSuccess ? dataValue : defaultValue;
        }

        if (await CmCksys.cmMultiVegaSystem() != 0) {
          final (bool isSuccess, String dataValue) =
              getTccUtsTermId(data, "TEM300");
          _pCom.ini_multi.Suica_tid = isSuccess ? dataValue : defaultValue;
        }

        if (await CmCksys.cmMultiVegaSystem() != 0) {
          final (bool isSuccess, String dataValue) =
              getTccUtsTermId(data, "TEM600");
          _pCom.ini_multi.Edy_tid = isSuccess ? dataValue : defaultValue;
        }
      }
      return true;
    } catch (e, s) {
      _setErrDlgId(DlgConfirmMsgKind.MSG_SYS_NOTREAD);
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "_rmIniMultiRead() end(NG),$e,$s");
      return false;
    }
  }
  /// TccUts.iniの指定のセクションのTermIdを取得する.
  (bool isSuccess, String dataValue) getTccUtsTermId(
      List<String> data, String section) {
    bool targetSection = false;
    for (var line in data) {
      if (line.contains("[$section]")) {
        targetSection = true;
      } else if (line.contains("[")) {
        targetSection = false;
      }
      if (targetSection) {
        if (line.contains("TermId")) {
          List<String> termId = line.split("=");
          if (termId.length < 2) {
            // 設定なし.
            return (false, "");
          }
          // 左右のスペースは削除.
          return (true, termId[1].trim());
        }
      }
    }
    return (false, "");
  }

  
  /// TccUts.iniのSYSTEMのセクションにNetConfigReferencePathの項目がないなら追加
  /// 大元となるTccUts.iniは存在する前提.
  /// NetConfigReferencePath=/etc/netplan/99_config.yaml
  Future<void> setNetConfigReferencePath(
     ) async {

    const String section = "SYSTEM";
    const String key = "NetConfigReferencePath";

    File tccUts = TprxPlatform.getFile(tccUtsIniPath);

    List<String> data = [];
    if(Platform.isLinux) {
      List<int> byteList = tccUts.existsSync()
              ? tccUts.readAsBytesSync()
              : [];
      if (byteList.isEmpty) {
        return ;
      }
      // 文字コードがEUC.
      String decode = await CharsetConverter.decode(
          'euc-jp', Uint8List.fromList(byteList));
      data = decode.split("\n");
    }
    
    if(data.isEmpty || data.join().contains('$key=')){
        // データがないor既に設定されている.
        return; 
    }
    // 設定されていないので追加する.
    String value = NetPlanControl.filePath;
    String addLine = "$key=$value";
    bool targetSection = false;
    List<String> afterData = List.from(data);
    for(int i =0; i < data.length; i++){
      String line = data[i];
      if (line.contains("[$section]")) {
        targetSection = true;
      } else if(targetSection && ( line.contains("[") || line.trim().isEmpty)){
        // 別のセクションに切り替わる
        afterData.insert(i, addLine);
        break;
      }
    }

    // 追加したデータを書き込む
    String afterDataStr = afterData.join("\n");
    if(Platform.isLinux){
      Uint8List encode = await CharsetConverter.encode(
                  'euc-jp', afterDataStr);
      tccUts.writeAsBytesSync(encode);
    }else{
      tccUts.writeAsStringSync(afterDataStr);
    }  
  }

  /// lottery.json読み込み
  ///  関連tprxソース: rminread.c - rmIniLotteryRead()
  Future<bool> _rmIniLotteryRead() async {
    try {
      // TODO:10007 設定ファイルにない lottery.json
      //Lottery

      return true;
    } catch (e, s) {
      _setErrDlgId(DlgConfirmMsgKind.MSG_SYS_NOTREAD);
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "_rmIniSysScpuRead() end(NG),$e,$s");
      return false;
    }
  }
}
