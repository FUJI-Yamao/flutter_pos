/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/common/cls_conf/configJsonFile.dart';
import 'package:flutter_pos/app/common/cls_conf/recogkey_dataJsonFile.dart';
import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/sys/recogkey/recogkey_define.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/environment.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/cnct.dart';
import '../../lib/apllib/recog.dart';
import '../../lib/apllib/recog_db.dart';
import '../../lib/apllib/recog_ftp.dart';
import '../../lib/apllib/rx_prt_flag_set.dart';
import '../../lib/cm_sys/cm_scr.dart';
import '../mente/mentemain.dart';


/// 承認キー　解放キーのコード入力画面バックエンド.
///  関連tprxソース:  recogkey.c
class Recogkey{

  /// QCJCボタンを表示する場合はtrueを返す
  /// 関連tprxソース: recogkey.c - recogkey_QCJC_show_button()
  Future<bool> isDispQCJCButton() async {
    bool ret = false;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    if(pCom.quickFlg == QuickSetupTypeNo.QUICK_SETUP_TYPE_NONE){
      return false;
    }
    RecogRetData retQcashierSys = await Recog().recogGet(MenteMain.MENTE_LOG, RecogLists.RECOG_QCASHIER_SYSTEM, RecogTypes.RECOG_GETMEM);
    RecogRetData retQRSys = await Recog().recogGet(MenteMain.MENTE_LOG, RecogLists.RECOG_RECEIPT_QR_SYSTEM, RecogTypes.RECOG_GETMEM);
    if(retQcashierSys.result.isValid() && retQRSys.result.isValid()){
      // QCJCシステムなのでtrue.
      ret = true;
    }
    if(CompileFlag.SMART_SELF){
      RecogRetData retCashierSys = await Recog().recogGet(MenteMain.MENTE_LOG, RecogLists.RECOG_DESKTOP_CASHIER_SYSTEM, RecogTypes.RECOG_GETMEM);
      if(retCashierSys.result.isValid()){
        ret = false;
      }
    }
    return ret;
  }

  /// 承認キー実行ボタンを押したときの処理.
  /// 承認キー確認画面を出すために、承認キーの組み合わせが正しいかをチェックする.
  /// 問題がなければ[RecogkeyError.NONE]とキー[recogkeySaveDes]が返る
  /// recogkeySaveDesを使って、フロント側で確認画面を表示する.
  /// 関連tprxソース: recogkey.c - recogkey_Confirm_button()
  Future<(RecogkeyError,String recogkeySaveDes)> recogkeyConfirmButton(
      String inputKey, String inputMakeData) async {
    String recogkeySaveDes = "";
    // 入力チェック.
    if(inputKey.length < RecogKeyDefine.RECOG_ENTRY_LENGTH1 || inputMakeData.length < RecogKeyDefine.RECOG_ENTRY_LENGTH2){
      TprLog().logAdd(RecogkeyDefine.RECOGKEY_LOG, LogLevelDefine.error,
          "recogkey: entry data is short");
      return (RecogkeyError.INPUT_ERROR,recogkeySaveDes);
    }

    List<int> des = <int>[];
    // inputKeyを２つずつ組み合わせて数値に変換した配列にする
    for(int i=0; i<inputKey.length; i+=2){
      String data = inputKey[i] + inputKey[i+1];
      // 文字列を16進数数値へ変換.
      int hex = int.parse(data,radix: 16);
      des.add(hex);
    }
    int bi = int.parse(inputMakeData,radix: 16);
    debugPrint(des.toString());

    // scramble check
    CmScrRet ret = await CmScr.cmScrOff(RecogkeyDefine.RECOGKEY_CODE, des, bi);
    if(ret != CmScrRet.OK){
      TprLog().logAdd(RecogkeyDefine.RECOGKEY_LOG, LogLevelDefine.error,
          "recogkey: cm_scr_off error");
      return (RecogkeyError.ENTRY_DATA_NO_MUCH, recogkeySaveDes);
    }

    if(!(await recogkeyCheckMacAddr(bi))){
      TprLog().logAdd(RecogkeyDefine.RECOGKEY_LOG, LogLevelDefine.error,
          "recogkey: recogkey_check_macaddr error");
      return (RecogkeyError.ENTRY_DATA_NO_MUCH, recogkeySaveDes);
    }
    recogkeySaveDes = inputKey;
    return (RecogkeyError.NONE, recogkeySaveDes);
  }

  /// macアドレスと[bi]が合致しているかをチェックする.
  /// 合致していたらtrueを返す.
  /// 関連tprxソース: recogkey.c - recogkey_check_macaddr(),recogkey_check_macaddr_file_read()
  Future<bool> recogkeyCheckMacAddr(int bi,{String fileName = ""}) async {
    // MACアドレス取得
    var (bool isSuccess, List<List<int>> mac) = await CmScr.getMacAddr();

    if(!isSuccess){
      return false;
    }
    //2文字16進数
    String biStr = sprintf("%02x", [bi & 0x000000FF]);
    String macAddr = "";

    for(int i=0; i<mac.length; i++){
      macAddr = sprintf("%02x", [mac[i][CmScr.IFHWADDRLEN-1]]);
      if(biStr == macAddr){
        return true;
      }
    }
    return false;
  }

  /// 承認キー初期化処理.
  /// 関連tprxソース: recogkey.c - recogkey_clr_func_main()
  Future<DlgConfirmMsgKind> recogkeyClrFuncMain() async {
    TprLog().logAdd(RecogkeyDefine.RECOGKEY_LOG, LogLevelDefine.normal,
        "recogkey: recogkey_clr_func_main call");

    bool isSuccess = await _recogkeyVersionCheck();
    if(!isSuccess){
      TprLog().logAdd(RecogkeyDefine.RECOGKEY_LOG, LogLevelDefine.error,
          "recogkey_clr_func_main: recogkey_version_check error");
      return DlgConfirmMsgKind.MSG_RECOGERR2;
    }
    // 今の承認キーの設定ファイルのバックアップを取る.
    Recogkey_dataJsonFile recog = Recogkey_dataJsonFile();
    String tmp = "${await recog.getFilePath()}.bak";
    File file = File(await recog.getFilePath());
    try{
      await file.copy(tmp); // バックアップファイルを作成
      // ここでエラーが出たとき.
      await recog.setDefault(); // デフォルトデータを復帰.
      File tmpFile = File(tmp); //無事終わったらtmpファイルを削除.
      await tmpFile.delete();
    }catch(e,s){
      TprLog().logAdd(RecogkeyDefine.RECOGKEY_LOG, LogLevelDefine.error,
          "recogkey_clr_func_main:recogkey_func_fcopy error $e,$s");
      return DlgConfirmMsgKind.MSG_RECOGERR2;
    }

    /* DB clear c_recoginfo_mst */
    await RecogDB.recogInitDB(RecogkeyDefine.RECOGKEY_LOG);
    await RecogDB.recoginfoDbCheck(RecogkeyDefine.RECOGKEY_LOG);
    RxPrtFlagSet.recogReadFlagClear();
    RxPrtFlagSet.rcResetRecogkey();

    await RxPrtFlagSet.rcPrtReadFlagData();
    await RxPrtFlagSet.macInfoPrmClr(CnctLists.CNCT_MOBILE_CNCT);
    await RxPrtFlagSet.macInfoPrmClr(CnctLists.CNCT_NETWLPR_CNCT);
    RecogFtp.rxRecogFtpDel();

    return DlgConfirmMsgKind.MSG_RECOG_OK;
  }

  /// SMHDバージョンチェック
  /// 関連tprxソース: recogkey.c - recogkey_version_check()
  Future<bool> _recogkeyVersionCheck() async {
    if(!Platform.isLinux){
        return true;
    }
    JsonRet ret = await getJsonValue(TprxPlatform.getPlatformPath(RecogkeyDefine.RECOGKEY_FILEPATH_SMHD),
        RecogkeyDefine.RECOGKEY_INI_SEC_SMHD, RecogkeyDefine.RECOGKEY_INI_SEC_SMHD);

    if(!ret.result){
      TprLog().logAdd(RecogkeyDefine.RECOGKEY_LOG, LogLevelDefine.error,
      "recogkey_version_check: smhd version get error ${ret.cause.name}");
      return false;
    }
    String recogkeyVersionSmhd = ret.value;
    // smhdのバージョンの先頭に"v"のプレフィックスがついているので2文字目からRECOGKEY_SMHD_VER_LEN文字を取得する.
    recogkeyVersionSmhd = recogkeyVersionSmhd.substring(1, RecogkeyDefine.RECOGKEY_SMHD_VER_LEN+1);

    String defineValue = RecogkeyDefine.RECOGKEY_SMHD_VERSION;
    int result = _recogkeyVersionComp(recogkeyVersionSmhd, defineValue);
    if(result < 0){
      TprLog().logAdd(RecogkeyDefine.RECOGKEY_LOG, LogLevelDefine.error,
        "recogkey_version_check: smhd is old");
    }

    return false;
  }

  /// バージョンチェック.
  /// 返り値
  ///  0 == Both version are same
  ///  -1 == Version1 < version2
  ///  1 == Version1 > version2
  /// 関連tprxソース: recogkey.c - recogkey_version_check()
  int _recogkeyVersionComp(String versionA, String versionB) {
    if(versionA == versionB){
      return 0; //　完全に一致.
    }
    // 1文字ずつ切り出して比較し、バージョンの大小を判定する.
    List<String> listA = versionA.split("");
    List<String> listB = versionB.split("");
    for(int i=0; (i<listA.length && i<listB.length); i++){
      // 小文字で統一し、文字コードの値で大小を比較する.
      int a = listA[i].toLowerCase().codeUnits[0];
      int b = listB[i].toLowerCase().codeUnits[0];
      if(a < b){
        return -1;
      }else if(b < a){
        return 1;
      }
    }
    return 0;
  }

  // --- static 関数 -----

  /// フラグデータ[bi]から、承認キーのページを取得する.
  /// 関連tprxソース: recogkey.c - recogkey_get_flag_page()
  static int recogkeyGetFlagPage(int bi){
    //bit shift
    bi >>= 10;
    int pageNum = ~bi & 0x0000003F;

    TprLog().logAdd(RecogkeyDefine.RECOGKEY_LOG, LogLevelDefine.normal,
        "recogkey_get_flag_page:page_num=${pageNum+1}");
    return pageNum+1;
  }
}

/// 承認キー関連のエラー定義.
enum RecogkeyError{
  NONE, // エラーなし.
  INPUT_ERROR, // 入力値エラー.
  ENTRY_DATA_NO_MUCH, // 入力値がアンマッチ.
}