/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/postgres_library/src/db_manipulation_ps.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rx_mbr_ata_chk.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../sys/recogkey/recogkey_define.dart';
import '../cm_sys/cm_scr.dart';
import 'cnct.dart';
import 'recog.dart';
import 'recog_chk.dart';
import 'recog_db.dart';

///  関連tprxソース: rxprtflagset.c
class RxPrtFlagSet {
  /// 定数
  static const FUNC_LOOP_MAX = 3;

  /// 最終頁
  /// 2は、顧客ポイントと顧客ＦＳＰのこと
  static int get RECOG_PAGE_LAST => (((RecogLists.RECOG_MAX.index-2) ~/ RxMbrAtaChk.RECOG_FUNC_MAX) + 1);
  /// 最終頁のファンクション数
  static int get RECOG_FUNC_LAST => ((RecogLists.RECOG_MAX.index-2) % RxMbrAtaChk.RECOG_FUNC_MAX);


  /// 共有メモリの承認キーをクリアする.
  /// 関連tprxソース: rxprtflagset.c - rcPrt_ReadFlagData()
  static Future<bool> rcPrtReadFlagData() async {
    TprLog().logAdd(
        Tpraid.TPRAID_SYST, LogLevelDefine.normal,
        "rcPrtReadFlagData(): MAX page[$RxMbrAtaChk.RECOG_PAGE_MAX] func[$RxMbrAtaChk.RECOG_FUNC_MAX], LAST page[$RECOG_PAGE_LAST] func[$RECOG_FUNC_LAST]");

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "rcPrt_ReadFlagData() rxMemRead RXMEM_COMMON get error\n");
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    if(pCom.recogKeyReadFlg){
      TprLog().logAdd(
          Tpraid.TPRAID_SYST, LogLevelDefine.normal,
          "rcPrt_ReadFlagData(): cmem->recogkey_read_flg was set");
        return true;
    }
    pCom.recogClrStatus = ActivateStatus.ACTIVATE_NONE;

    bool success = true;
    success &= await _rcRecogHdd();  // 承認キー
    success &= await _rcRecogOK0893();  // 固定承認キー
    if(!success){
       return false;
    }

    pCom.recogKeyReadFlg = true;
    return true;
  }

  //----------------------------------------------------------------------
  // 承認キー関連
  //----------------------------------------------------------------------

  /// 共有メモリの承認キーフラグをリセットする.
  /// 関連tprxソース: rxprtflagset.c - recog_readflag_clear()
  static void recogReadFlagClear() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;
    pCom.recogKeyReadFlg = false;
    pCom.recogClrStatus = ActivateStatus.ACTIVATE_NONE;
  }

  /// 共有メモリの承認キーをクリアする.
  /// 関連tprxソース: rxprtflagset.c - rcResetRecogkey()
  static void rcResetRecogkey() {
    // RECOG_MEMBERSYSTEM からMAXまでの承認キーをクリア.
    List<RecogLists> clearList = RecogLists.values.skip(RecogLists.RECOG_MEMBERSYSTEM.index).toList();
    for(var def in clearList){
      if(def == RecogLists.RECOG_MAX){
        break;
      }
      // 共有メモリの承認キークリア
      Recog().recogSetEnum(Tpraid.TPRAID_SYSTEM, def, RecogTypes.RECOG_SETMEM, RecogValue.RECOG_NO);
    }
    TprLog().logAdd(
        Tpraid.TPRAID_SYST, LogLevelDefine.normal, "Reset Recogkey");
  }

  /// Set sys.json to cmem->ini_sys
  ///  関連tprxソース: rxprtflagset.c - rcSetSysiniToMemory()
  static Future<bool> rcSetSysiniToMemory() async {
    TprLog().logAdd(
        Tpraid.TPRAID_SYST, LogLevelDefine.normal, "Start sys.json to memory");
    Recog recog = Recog();
    recog.isUpdateSharedMemory = false; // 後でまとめて共有メモリをアップデートする.
    for(int recogIndex = RecogLists.RECOG_CREDITSYSTEM.index;
        recogIndex < RecogLists.RECOG_MAX.index;
        recogIndex++){
      // sysから値を取得.
      RecogLists def = RecogLists.getDefine(recogIndex);
      RecogRetData resultGetSys = await recog.recogChkGet(
          Tpraid.TPRAID_SYSTEM, def, RecogTypes.RECOG_GETSYS);
      if(resultGetSys.keyCheckResult == -1){
        continue;
      }

      // メモリに保存.
      RecogRetData resultSetMem = await recog.recogSetEnum(Tpraid.TPRAID_SYSTEM,
          def, RecogTypes.RECOG_SETMEM, resultGetSys.result);
      if (resultSetMem.result != RecogValue.RECOG_YES) {
        if ((resultSetMem.result == RecogValue.RECOG_NO) && (resultSetMem.keyCheckResult != -1)) {
          TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
              "rcSetSysiniToMemory() : Get sys.json type error recog_no=${def
                  .index}(${def.name}), ret[${resultSetMem.result.index}]",
              errId: -1);
        }
      }
    }
    // 共有メモリのアップデート.
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isValid()) {
     RxCommonBuf cMem = xRet.object;
     recog.updateSharedMemory(cMem);  
    }

    return true;
  }

  ///  関連tprxソース: rxprtflagset.c - rcSetMemberSysiniToMemory()
  static Future<bool> rcSetMemberSysiniToMemory() async {
    Recog recog = Recog();
    // check member system
    RecogRetData resultGetSys = await recog.recogGet(Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_MEMBERSYSTEM, RecogTypes.RECOG_GETSYS);

    if(resultGetSys.result == RecogValue.RECOG_OK0893){
      // member system
      recog.recogSet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_MEMBERSYSTEM,
          RecogTypes.RECOG_SETMEM, RecogValue.RECOG_OK0893.index);
      // member point
      recog.recogSet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_MEMBERPOINT,
          RecogTypes.RECOG_SETMEM, RecogValue.RECOG_YES.index);
      RecogRetData ret = await recog.recogSet(
          Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_MEMBERPOINT,
          RecogTypes.RECOG_SETSYS,
          RecogValue.RECOG_NO.index);
      if(ret.result != RecogValue.RECOG_YES){
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "rcSetMemberMemoryToSysini() : Set sys.json error memberpoint ret[${ret.result.index}]",
            errId: -1);
      }
      // memberfsp
      recog.recogSet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_MEMBERFSP,
          RecogTypes.RECOG_SETMEM, RecogValue.RECOG_YES.index);
      RecogRetData retFsp = await recog.recogSet(
          Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_MEMBERFSP,
          RecogTypes.RECOG_SETSYS,
          RecogValue.RECOG_NO.index);
      if(retFsp.result != RecogValue.RECOG_YES){
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "rcSetMemberMemoryToSysini() : Set sys.ini error memberfsp ret[${retFsp.result.index}]",
            errId: -1);
      }
    }else if(resultGetSys.result == RecogValue.RECOG_YES ||
        resultGetSys.result == RecogValue.RECOG_NO){
      RecogValue value = resultGetSys.result;
      // member system
      recog.recogSet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_MEMBERSYSTEM,
          RecogTypes.RECOG_SETMEM, value.index);
      // member point
      recog.recogSet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_MEMBERPOINT,
          RecogTypes.RECOG_SETMEM, value.index);
      RecogRetData ret = await recog.recogSet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_MEMBERPOINT, RecogTypes.RECOG_SETSYS, value.index);
      if(ret.result != RecogValue.RECOG_YES){
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "rcSetMemberMemoryToSysini() : Set sys.ini error memberpoint ret[${ret.result.index}]",
            errId: -1);
      }
      // memberfsp
      recog.recogSet(Tpraid.TPRAID_SYSTEM, RecogLists.RECOG_MEMBERFSP,
          RecogTypes.RECOG_SETMEM, value.index);
      RecogRetData retFsp = await recog.recogSet(Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_MEMBERFSP, RecogTypes.RECOG_SETSYS, value.index);
      if(retFsp.result != RecogValue.RECOG_YES){
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "rcSetMemberMemoryToSysini() : Set sys.ini error memberfsp ret[${retFsp.result.index}]",
            errId: -1);
      }
    }

    return true;
  }

  /// write recogkey in HDD
  ///  関連tprxソース:rxprtflagset.c - recogkey_set_func_ini
  static Future<RecogKeySetIniRet> recogkeySetFuncIni(int no, String data1, String data2) async {
    // パラメータチェック.
    if(no < 1){
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "recogkey: recogkey_set_func_ini parameter erro:no:$no",
          errId: -1);
      return RecogKeySetIniRet.PARAMETER_ERROR;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "rcRecogPrt_SetPrtToHdd() rxMemRead RXMEM_COMMON get error\n");
      return RecogKeySetIniRet.MEMORY_ERROR;
    }
    RxCommonBuf pCom = xRet.object;

    try{
      DbManipulationPs db = DbManipulationPs();
      int loginStaffCd = 0;
      String sql = RxMbrAtaChk.RECOGKEY_SQL_RECOGINFO_SET;
      Map<String, dynamic>? subValues = {
        "password" : data2,
        "fcode"    : data1,
        "upd_user" : loginStaffCd,
        "comp"     : pCom.iniMacInfoCrpNoNo,
        "stre"     : pCom.iniMacInfoShopNo,
        "mac"      : pCom.iniMacInfoMacNo,
        "page"     : no
      };
      await db.dbCon.execute(Sql.named(sql), parameters:subValues);
    }catch(e,s){
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "recogkey: recogkey_set_func_ini db update error",
          errId: -1);
      return RecogKeySetIniRet.DB_UPDATE_ERROR;
    }

    return RecogKeySetIniRet.SUCCESS;
  }

  //----------------------------------------------------------------------
  //  Recogkey read from HDD
  //----------------------------------------------------------------------
  ///
  ///  関連tprxソース:rxprtflagset.c - rcRecogHdd
  static Future<bool> _rcRecogHdd() async {
    for(int i =1; i<= RECOG_PAGE_LAST; i++){
      RecogKeyHDDGetRet recogHddFlg = await _rcRecogHddChk(i);
      if(recogHddFlg == RecogKeyHDDGetRet.DATA_GET_ERROR){
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "rcRecogHdd_chk() Error page[$i]",
            errId: -1);
      }else if(recogHddFlg == RecogKeyHDDGetRet.DATA_NOT_SET){
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.warning,
            "rcRecogHdd_chk() not set page[$i]",
            errId: 0);
      }
    }
    TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal,
        "HDD Recogkey Check end");
    return true;
  }

  ///
  ///  関連tprxソース:rxprtflagset.c - rcRecogHdd_chk()
  static Future<RecogKeyHDDGetRet> _rcRecogHddChk(int page) async {
    var (RecogKeyHDDGetRet ret, int bitParam) = await _rcRecogHddGetData(page);
    if(ret == RecogKeyHDDGetRet.SUCCESS){
      _rcRecogHddSetFunction(page,bitParam);
    }
    return ret;
  }

  ///  関連tprxソース:rxprtflagset.c - rcRecogHdd_GetData()
  static Future<(RecogKeyHDDGetRet,int)> _rcRecogHddGetData(int page) async {
    try{
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "rcRecogPrt_SetPrtToHdd() rxMemRead RXMEM_COMMON get error\n");
        return (RecogKeyHDDGetRet.DATA_GET_ERROR, 1);
      }
      RxCommonBuf pCom = xRet.object;

      DbManipulationPs db = DbManipulationPs();

      //mst.
      String sql1 =
          "select password, fcode from c_recoginfo_mst "
          "where comp_cd = @comp and mac_no = @mac and stre_cd = @stre and page = @page";
      Map<String, dynamic>? subValues = {
        "comp" : pCom.iniMacInfoCrpNoNo,
        "mac"  : pCom.iniMacInfoMacNo,
        "stre" : pCom.iniMacInfoShopNo,
        "page" : page
      };

       Result result = await db.dbCon.execute(Sql.named(sql1),parameters:subValues);

      if(result == null || result.isEmpty){
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal,
            "rcRecogHddGetData(): db_PQntuples() c_recoginfo_mst query RXPRTFLAGSET_SQL_RECOGINFO_GET error");
        return (RecogKeyHDDGetRet.DATA_GET_ERROR, 0);
      }
      Map<String,dynamic> data = result.first.toColumnMap();
      if(data["password"] == null){
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "rcRecogHddGetData(): Get password error", errId: -1);
        return (RecogKeyHDDGetRet.DATA_GET_ERROR, 0);
      }else if(data["password"]!.isEmpty){
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.warning,
            "rcRecogHddGetData(): password notset");
        return (RecogKeyHDDGetRet.DATA_NOT_SET, 0);
      }
      if(data["fcode"] == null){
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
            "rcRecogHddGetData(): Get fcode error", errId: -1);
        return (RecogKeyHDDGetRet.DATA_GET_ERROR, 0);
      }else if(data["fcode"]!.isEmpty){
        TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.warning,
            "rcRecogHddGetData(): fcode notset");
        return (RecogKeyHDDGetRet.DATA_NOT_SET, 0);
      }

      int bi = int.parse(data["fcode"]!,radix:16);
      List<int> des = [];
      String passwordHex  = data["password"];
      for(int i=0; i<12; i+=2){
        //2文字取得
        String tmp = passwordHex[i]
            +passwordHex[i+1];
        // 文字列を16進数数値へ変換.
        int hex = int.parse(tmp, radix:16);
        des.add(hex);
      }

      CmScrRet ret = await CmScr.cmScrOff(RecogkeyDefine.RECOGKEY_CODE, des, bi);
      if(ret != CmScrRet.OK){
        return (RecogKeyHDDGetRet.DATA_GET_ERROR, 0);
      }
      return (RecogKeyHDDGetRet.SUCCESS, bi);
    }catch(e,s){
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "HDD Recogkey Check end.$e,$s", errId: -1);
      return (RecogKeyHDDGetRet.DATA_GET_ERROR, 0);
    }
  }

  ///  関連tprxソース:rxprtflagset.c - rcRecogHdd_SetFunction()
  static Future<void> _rcRecogHddSetFunction(int page, int bitStat) async {
    int count = 0;
    // Get Recogkey Data
    for(int funcLoop=0; funcLoop<FUNC_LOOP_MAX; funcLoop++){
      //
      int i = (3-funcLoop) * 8;
      int bitTmp = (bitStat >> i) & 0x000000ff; // ibit右シフトして、下位8bitを取得

      // Get Enable Function
      for(int bitLoop=0; bitLoop<8; bitLoop++){
        int bitData = (bitTmp >> bitLoop) & 0x00000001;
        count++;

        // Set Enable Function
        int funcNo = (page==RECOG_PAGE_LAST) ? RECOG_FUNC_LAST-1 : 17;
        if(((count-1) > funcNo) || (bitData != 0)){
          continue;
        }
        RecogLists recogNo = recogPage2RecogLists(page-1, count-1);
        if((await Recog().recogGet(Tpraid.TPRAID_SYSTEM, recogNo, RecogTypes.RECOG_GETMEM)).result == RecogValue.RECOG_NO){
          await Recog().recogSetEnum(Tpraid.TPRAID_SYSTEM, recogNo, RecogTypes.RECOG_SETMEM,RecogValue.RECOG_YES);
          await RecogDB.RecogSetDB(Tpraid.TPRAID_SYSTEM,recogNo, RecogValue.RECOG_YES);
          TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal,
              "rcRecogHdd_SetFunction() page[$page] function[${count-1}] stands mem[${(await Recog().recogGet(Tpraid.TPRAID_SYSTEM, recogNo, RecogTypes.RECOG_GETMEM))}]");
        }
      }
    }
  }

  /// pageとcountから、対応するRecogListsを返す.
  ///  関連tprxソース:rxprtflagset.c - recog_page2index()
  static RecogLists recogPage2RecogLists(int page, int count) {
    int idx = RecogLists.RECOG_MEMBERSYSTEM.index;
    if(!((page == 0) && (count == 0))){
      /* 顧客ポイントと顧客ＦＳＰ分進む */
      idx = (page * RxMbrAtaChk.RECOG_FUNC_MAX) + count + 2;
    }
    return RecogLists.getDefine(idx);
  }

  ///  関連tprxソース:rxprtflagset.c - rcRecogOK0893()
  static Future<bool> _rcRecogOK0893() async {
    List<Future<RecogRetData>> futureList = [];
    for(int i=0; i<=RECOG_PAGE_LAST-1; i++){
      int funcNo = (i==RECOG_PAGE_LAST) ? RECOG_FUNC_LAST-1 : 17;
      var (bool success, String recogData) = await RecogChk.recogGetDBDtl(Tpraid.TPRAID_SYSTEM, (i + 1));

      for(int j=0; j<=funcNo; j++)	/* function loop start */{
        RecogValue recogValue = RecogValue.getDefine(int.tryParse(recogData[j])!);
        if(recogValue == RecogValue.RECOG_OK0893){
          RecogLists recogNo = recogPage2RecogLists(i, j);
          // 非同期で実行.
          futureList.add(Recog().recogSetEnum(Tpraid.TPRAID_SYSTEM, recogNo, RecogTypes.RECOG_SETMEM, RecogValue.RECOG_OK0893));
        }
      }
    }
    TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.normal,
        "Emergency Recogkey Check End");
    await Future.wait(futureList);
    return true;
  }

  /// mac_info.json の指定パラメタを"0"に設定する
  /// 関連tprxソース: rxprtflagset.c - mobile_clr(), lpd_clr()
  static Future<void> macInfoPrmClr(CnctLists cnctNum) async {
    bool ret = await Cnct.cnctSysSet(Tpraid.TPRAID_SYSTEM, cnctNum, 0);
    if(!ret){
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "macInfoPrmClr(): Set cnct to zero error ret ${cnctNum.name}", errId: -1);
    }
  }
  
  /// Set DB to sys.ini
  /// 関連tprxソース: rxprtflagset.c - rcSetDBToSysini_Recog()
  static Future<void> rcSetDBToSysiniRecog( TprMID tid) async {
    int	i = 0;
    int	j = 0;
    bool ret = false;
    RecogLists recogNo;
    String recogData = "";
    String buf = "";
    RecogValue recogTyp;

    for ( i = 0; i < RxMbrAtaChk.RECOG_PAGE_MAX; i++ )
    {
      (ret, recogData) = await RecogChk.recogGetDBDtl( tid, i+1);
      if (ret) {
        for ( j = 0 ; j < RxMbrAtaChk.RECOG_FUNC_MAX; j++ ) {
          buf = recogData[j];
          recogTyp = RecogValue.getDefine(int.tryParse(buf)!);
          recogNo = RxPrtFlagSet.recogPage2RecogLists( i, j );

          // 承認キーインデックスが、最大値に達したら終了(不要な処理は行わない。以下処理をしてもエラーとなる)
          if (recogNo.index >= RecogLists.RECOG_MAX.index) {
            return;
          }

          await Recog().recogSetEnum(tid, recogNo, RecogTypes.RECOG_SETSYS, recogTyp);

          // 承認キーマスタの更新を行う
          await RecogDB.recogSetDBAppMst(Tpraid.TPRAID_SYSTEM, recogNo, recogTyp);
        }
      }
    }
  }

}

/// recogkeySetFuncIni()の返り値.
enum RecogKeySetIniRet{
  SUCCESS, // DB更新成功.
  PARAMETER_ERROR, // 引数がおかしい.
  DB_UPDATE_ERROR, // DBがアップデートできなかった.
  MEMORY_ERROR,    // 共有メモリを取得できなかった.
}

/// rcRecogHddGetData()の返り値.
enum RecogKeyHDDGetRet{
  SUCCESS, //
  DATA_GET_ERROR, // データがない
  DATA_NOT_SET, //  データに値が設定されていない.
}

