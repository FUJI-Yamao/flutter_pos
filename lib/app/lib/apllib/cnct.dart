/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
// --

import 'package:collection/collection.dart';
import 'package:flutter_pos/app/common/cls_conf/mac_infoJsonFile.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';

import '../../common/cls_conf/configJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';

///  関連tprxソース: cnct.c
class Cnct {
  static int cnctExecMode = 0;  /* タイプ変更方法 */
  static int cnctChkSio = 0;  /* SIO設定を参照  0:未参照 1:参照 */

  /// 共有メモリからデータをセット.
  ///  関連tprxソース: cnct.c - cnct_mem_set()
  static bool cnctMemSet(TprTID tid ,CnctLists cnctNum, int value ){
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    _setMemData(pCom, cnctNum, value);
    return true;
  }

  ///  設定ファイルへデータをセット.
  ///  関連tprxソース: cnct.c - cnct_mem_set()
  static Future<bool> cnctSysSet(TprTID tid ,CnctLists cnctNum, int? value ) async {
    if(value == null){
      TprLog().logAdd(tid, LogLevelDefine.error,
          "cnctSysSet():  param error set value is null[${cnctNum.name}][$value]",
          errId: -1);
      return false;
    }
    String keyword = cnctNum.keyword;
    if(keyword.isEmpty){
      TprLog().logAdd(tid, LogLevelDefine.error,
          "cnctSysSet():  keyword is empty[${cnctNum.name}][$value]", errId: -1);
      return false;
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "cnctSysSet():  SystemFunc.rxMemRead[RXMEM_COMMON]", errId: -1);
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    Mac_infoJsonFile macInfo = pCom.iniMacInfo;
    JsonRet ret =  await macInfo.setValueWithName("internal_flg", keyword, value);
    if(!ret.result){
      TprLog().logAdd(tid, LogLevelDefine.error,
      "cnctSysSet():  set json Error. [${cnctNum.name}][$value]",errId: -1);
      return false;
    }
    await macInfo.load();
    SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, pCom, RxMemAttn.MAIN_TASK);
    return true;
  }

  ///  共有メモリからデータを取得.
  ///  関連tprxソース: cnct.c - cnct_mem_get()
  static  int cnctMemGet(TprTID tid ,CnctLists cnctNum,{bool driver = false}) {

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error, "_cnctMain():rxMemRead Error"
          "[${cnctNum.name}][false][${ CnctTypes.CNCT_GETMEM.name}]", errId: -1);
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    int? data =  _getMemData (pCom, cnctNum);
    if(data == null){
      TprLog().logAdd(tid, LogLevelDefine.error,
          "_cnctMain():GETMEM pData NULL Error[${cnctNum.name}][false][${ CnctTypes.CNCT_GETMEM.name}]",
          errId: -1);
      // 0を返す.
      return 0;
    }
    return data;
  }


  ///  設定ファイルからデータを取得.
  ///  関連tprxソース: cnct.c - cnct_sys_get()
  static Future<(bool, int)> cnctSysGet(TprTID tid ,CnctLists cnctNum) async {

    String keyword = cnctNum.keyword;
    if(keyword.isEmpty){
      TprLog().logAdd(tid, LogLevelDefine.error,
          "cnctSysGet():   set json Error. keyword is empty[${cnctNum.name}]",
          errId: -1);
      return (false,0);
    }
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "cnctSysGet(): rxMemRead error");
      return (false,0);
    }
    RxCommonBuf pCom = xRet.object;

    Mac_infoJsonFile macinfo = pCom.iniMacInfo;
    JsonRet ret = await macinfo.getValueWithName("internal_flg", keyword);
    if(!ret.result){
      return (false,0);
    }
    int data = ret.value;
    return (true, data);
  }


  ///  タイプ指定で共有メモリからデータを取得
  ///  関連tprxソース: cnct.c - cnct_mem_get_type()
  static int cnctMemGetType(TprTID tid ,CnctLists cnctNum ,CnctTypes type,{bool driver = false}) {
    // パラメータチェック
    if(type.setting){
      // 取得する関数だが、セットするタイプが来ている.
      TprLog().logAdd(tid, LogLevelDefine.error,
      "cnctMemGetType(): param error [${cnctNum.name}][${type.name}]",
      errId: -1);
      return 0;
    }
    return cnctMemGet(tid, cnctNum);

  }


  /// メモリから[cnctNum]と対応するデータを取得する
  static int? _getMemData( RxCommonBuf pCom, CnctLists cnctNum){
    switch(cnctNum){
      case CnctLists.CNCT_RCT_ONOFF: // レシートON/OFFフラグ
        return pCom.iniMacInfo.internal_flg.rct_onoff;
      case CnctLists.CNCT_ACR_ONOFF: // 自動釣銭機ON/OFFフラグ
        return pCom.iniMacInfo.internal_flg.acr_onoff;
      case CnctLists.CNCT_ACR_CNCT: // 自動釣銭釣札機接続
        return pCom.iniMacInfo.internal_flg.acr_cnct;
      case CnctLists.CNCT_CARD_CNCT: // カード決済機接続
        return pCom.iniMacInfo.internal_flg.card_cnct;
      case CnctLists.CNCT_ACB_DECCIN: // 釣銭釣札機接続時の入金確定処理
        return pCom.iniMacInfo.internal_flg.acb_deccin;
      case CnctLists.CNCT_RWT_CNCT: // リライトカード接続
        return pCom.iniMacInfo.internal_flg.rwt_cnct;
      case CnctLists.CNCT_SCALE_CNCT: // 秤接続
        return pCom.iniMacInfo.internal_flg.scale_cnct;
      case CnctLists.CNCT_ACB_SELECT: // 自動釣銭釣札機の種類
        return pCom.iniMacInfo.internal_flg.acb_select;
      case CnctLists.CNCT_IIS21_CNCT: // iis21接続
        return pCom.iniMacInfo.internal_flg.iis21_cnct;
      case CnctLists.CNCT_MOBILE_CNCT: // モバイルPOS接続
        return pCom.iniMacInfo.internal_flg.mobile_cnct;
      case CnctLists.CNCT_STPR_CNCT: //  ステーションプリンタ接続
        return pCom.iniMacInfo.internal_flg.stpr_cnct;
      case CnctLists.CNCT_NETWLPR_CNCT: // ネットワークプリンタ接続／CDバックアップ保存
        return pCom.iniMacInfo.internal_flg.netwlpr_cnct;
      case CnctLists.CNCT_POPPY_CNCT: // POPPY接続
        return pCom.iniMacInfo.internal_flg.poppy_cnct;
      case CnctLists.CNCT_TAG_CNCT: // 棚札プリンタ接続
        return pCom.iniMacInfo.internal_flg.tag_cnct;
      case CnctLists.CNCT_AUTO_DECCIN: // 釣銭釣札機モード変更
        return pCom.iniMacInfo.internal_flg.auto_deccin;
      case CnctLists.CNCT_S2PR_CNCT: // ２ステーションプリンタ接続
        return pCom.iniMacInfo.internal_flg.s2pr_cnct;
      case CnctLists.CNCT_PWRCTRL_CNCT: //  無線LAN再起動処理
        return pCom.iniMacInfo.internal_flg.pwrctrl_cnct;
      case CnctLists.CNCT_CATALINAPR_CNCT: // カタリナプリンタ接続
        return pCom.iniMacInfo.internal_flg.catalinapr_cnct;
      case CnctLists.CNCT_DISH_CNCT: //  皿勘定接続
        return pCom.iniMacInfo.internal_flg.dish_cnct;
      case CnctLists.CNCT_CUSTREALSVR_CNCT: // 顧客リアル問い合わせサーバー接続
        return pCom.iniMacInfo.internal_flg.custrealsvr_cnct;
      case CnctLists.CNCT_AIVOICE_CNCT: // 音声合成装置接続
        return pCom.iniMacInfo.internal_flg.aivoice_cnct;
      case CnctLists.CNCT_GCAT_CNCT: // カード決済機接続（デビッット／クレジット）
        return pCom.iniMacInfo.internal_flg.gcat_cnct;
      case CnctLists.CNCT_SUICA_CNCT: // Suica決済機接続
        return pCom.iniMacInfo.internal_flg.suica_cnct;
      case CnctLists.CNCT_MP1_CNCT: // 値付けプリンタ接続
        return pCom.iniMacInfo.internal_flg.mp1_cnct;
      case CnctLists.CNCT_REALITMSEND_CNCT: // リアル明細送信サーバー接続
        return pCom.iniMacInfo.internal_flg.realitmsend_cnct;
      case CnctLists.CNCT_GRAMX_CNCT: // GramX接続
        return pCom.iniMacInfo.internal_flg.gramx_cnct;
      case CnctLists.CNCT_RFID_CNCT: // RFIDタグリーダライタ接続
        return pCom.iniMacInfo.internal_flg.rfid_cnct;
      case CnctLists.CNCT_MSG_FLG: //  Plu PopUp Message
        return pCom.iniMacInfo.internal_flg.msg_flg;
      case CnctLists.CNCT_MULTI_CNCT: // マルチ端末機接続(FeliCa非接触IC)
        return pCom.iniMacInfo.internal_flg.multi_cnct;
      case CnctLists.CNCT_JREM_CNCT: // JREM製マルチ端末機接続(FeliCa非接触IC)
        return pCom.iniMacInfo.internal_flg.jrem_cnct;
      case CnctLists.CNCT_COLORDSP_CNCT: // カラー客表接続
        return pCom.iniMacInfo.internal_flg.colordsp_cnct;
      case CnctLists.CNCT_USBCAM_CNCT: // USBカメラ接続
        return pCom.iniMacInfo.internal_flg.usbcam_cnct;
      case CnctLists.CNCT_MASR_CNCT: //  自走式磁気カードリーダー接続
        return pCom.iniMacInfo.internal_flg.masr_cnct;
      case CnctLists.CNCT_BRAINFL_CNCT: // 画像認識商品情報出力
        return pCom.iniMacInfo.internal_flg.brainfl_cnct;
      case CnctLists.CNCT_CAT_JMUPS_TWIN_CNCT: // マルチ決済端末J-Mups連動（カード決済機併用）
        return pCom.iniMacInfo.internal_flg.cat_jmups_twin_cnct;
      case CnctLists.CNCT_SQRC_CNCT: // SQRCチケット発券サーバー接続
        return pCom.iniMacInfo.internal_flg.sqrc_ticket_cnct;
      case CnctLists.CNCT_CUSTREAL_PQS_NEW_SEND: // 顧客リアル新PQSフォーマット
        return pCom.iniMacInfo.internal_flg.custrealsvr_pqs_new_send;
      case CnctLists.CNCT_ICCARD_CNCT: // Ｃカードリーダ接続
      // 何もしない
        break;
      case CnctLists.CNCT_COLORDSP_SIZE: // カラー客表サイズ
        return pCom.iniMacInfo.internal_flg.colordsp_size;
      case CnctLists.CNCT_APBF_CNCT: // SB-1接続
        return pCom.iniMacInfo.internal_flg.apbf_cnct;
      case CnctLists.CNCT_HITOUCH_CNCT: // Hitouch接続
      // 何もしない
        return null;
      case CnctLists.CNCT_AMI_CNCT: // ゴルフ場精算機ICリーダー接続
      // 何もしない
        return null;
      default:
        return null;
    }
  }


  static void _setMemData( RxCommonBuf pCom, CnctLists cnctNum,dynamic data){
    switch(cnctNum){
      case CnctLists.CNCT_RCT_ONOFF: // レシートON/OFFフラグ
      pCom.iniMacInfo.internal_flg.rct_onoff = data;
      break;
      case CnctLists.CNCT_ACR_ONOFF: // 自動釣銭機ON/OFFフラグ
      pCom.iniMacInfo.internal_flg.acr_onoff = data;
      break;
      case CnctLists.CNCT_ACR_CNCT: // 自動釣銭釣札機接続
      pCom.iniMacInfo.internal_flg.acr_cnct = data;
      break;
      case CnctLists.CNCT_CARD_CNCT: // カード決済機接続
      pCom.iniMacInfo.internal_flg.card_cnct = data;
      break;
      case CnctLists.CNCT_ACB_DECCIN: // 釣銭釣札機接続時の入金確定処理
      pCom.iniMacInfo.internal_flg.acb_deccin = data;
      break;
      case CnctLists.CNCT_RWT_CNCT: // リライトカード接続
      pCom.iniMacInfo.internal_flg.rwt_cnct = data;
      break;
      case CnctLists.CNCT_SCALE_CNCT: // 秤接続
      pCom.iniMacInfo.internal_flg.scale_cnct = data;
      break;
      case CnctLists.CNCT_ACB_SELECT: // 自動釣銭釣札機の種類
      pCom.iniMacInfo.internal_flg.acb_select = data;
      break;
      case CnctLists.CNCT_IIS21_CNCT: // iis21接続
      pCom.iniMacInfo.internal_flg.iis21_cnct = data;
      break;
      case CnctLists.CNCT_MOBILE_CNCT: // モバイルPOS接続
      pCom.iniMacInfo.internal_flg.mobile_cnct = data;
      break;
      case CnctLists.CNCT_STPR_CNCT: //  ステーションプリンタ接続
      pCom.iniMacInfo.internal_flg.stpr_cnct = data;
      break;
      case CnctLists.CNCT_NETWLPR_CNCT: // ネットワークプリンタ接続／CDバックアップ保存
      pCom.iniMacInfo.internal_flg.netwlpr_cnct = data;
      break;
      case CnctLists.CNCT_POPPY_CNCT: // POPPY接続
      pCom.iniMacInfo.internal_flg.poppy_cnct = data;
      break;
      case CnctLists.CNCT_TAG_CNCT: // 棚札プリンタ接続
      pCom.iniMacInfo.internal_flg.tag_cnct = data;
      break;
      case CnctLists.CNCT_AUTO_DECCIN: // 釣銭釣札機モード変更
      pCom.iniMacInfo.internal_flg.auto_deccin = data;
      break;
      case CnctLists.CNCT_S2PR_CNCT: // ２ステーションプリンタ接続
      pCom.iniMacInfo.internal_flg.s2pr_cnct = data;
      break;
      case CnctLists.CNCT_PWRCTRL_CNCT: //  無線LAN再起動処理
      pCom.iniMacInfo.internal_flg.pwrctrl_cnct = data;
      break;
      case CnctLists.CNCT_CATALINAPR_CNCT: // カタリナプリンタ接続
      pCom.iniMacInfo.internal_flg.catalinapr_cnct = data;
      break;
      case CnctLists.CNCT_DISH_CNCT: //  皿勘定接続
      pCom.iniMacInfo.internal_flg.dish_cnct = data;
      break;
      case CnctLists.CNCT_CUSTREALSVR_CNCT: // 顧客リアル問い合わせサーバー接続
      pCom.iniMacInfo.internal_flg.custrealsvr_cnct = data;
      break;
      case CnctLists.CNCT_AIVOICE_CNCT: // 音声合成装置接続
      pCom.iniMacInfo.internal_flg.aivoice_cnct = data;
      break;
      case CnctLists.CNCT_GCAT_CNCT: // カード決済機接続（デビッット／クレジット）
      pCom.iniMacInfo.internal_flg.gcat_cnct = data;
      break;
      case CnctLists.CNCT_SUICA_CNCT: // Suica決済機接続
      pCom.iniMacInfo.internal_flg.suica_cnct = data;
      break;
      case CnctLists.CNCT_MP1_CNCT: // 値付けプリンタ接続
      pCom.iniMacInfo.internal_flg.mp1_cnct = data;
      break;
      case CnctLists.CNCT_REALITMSEND_CNCT: // リアル明細送信サーバー接続
      pCom.iniMacInfo.internal_flg.realitmsend_cnct = data;
      break;
      case CnctLists.CNCT_GRAMX_CNCT: // GramX接続
      pCom.iniMacInfo.internal_flg.gramx_cnct = data;
      break;
      case CnctLists.CNCT_RFID_CNCT: // RFIDタグリーダライタ接続
      pCom.iniMacInfo.internal_flg.rfid_cnct = data;
      break;
      case CnctLists.CNCT_MSG_FLG: //  Plu PopUp Message
      pCom.iniMacInfo.internal_flg.msg_flg = data;
      break;
      case CnctLists.CNCT_MULTI_CNCT: // マルチ端末機接続(FeliCa非接触IC)
      pCom.iniMacInfo.internal_flg.multi_cnct = data;
      break;
      case CnctLists.CNCT_JREM_CNCT: // JREM製マルチ端末機接続(FeliCa非接触IC)
      pCom.iniMacInfo.internal_flg.jrem_cnct = data;
      break;
      case CnctLists.CNCT_COLORDSP_CNCT: // カラー客表接続
      pCom.iniMacInfo.internal_flg.colordsp_cnct = data;
      break;
      case CnctLists.CNCT_USBCAM_CNCT: // USBカメラ接続
      pCom.iniMacInfo.internal_flg.usbcam_cnct = data;
      break;
      case CnctLists.CNCT_MASR_CNCT: //  自走式磁気カードリーダー接続
      pCom.iniMacInfo.internal_flg.masr_cnct = data;
      break;
      case CnctLists.CNCT_BRAINFL_CNCT: // 画像認識商品情報出力
      pCom.iniMacInfo.internal_flg.brainfl_cnct = data;
      break;
      case CnctLists.CNCT_CAT_JMUPS_TWIN_CNCT: // マルチ決済端末J-Mups連動（カード決済機併用）
      pCom.iniMacInfo.internal_flg.cat_jmups_twin_cnct = data;
      break;
      case CnctLists.CNCT_SQRC_CNCT: // SQRCチケット発券サーバー接続
      pCom.iniMacInfo.internal_flg.sqrc_ticket_cnct = data;
      break;
      case CnctLists.CNCT_CUSTREAL_PQS_NEW_SEND: // 顧客リアル新PQSフォーマット
      pCom.iniMacInfo.internal_flg.custrealsvr_pqs_new_send = data;
      break;
      case CnctLists.CNCT_ICCARD_CNCT: // Ｃカードリーダ接続
      // 何もしない
      break;
      case CnctLists.CNCT_COLORDSP_SIZE: // カラー客表サイズ
      pCom.iniMacInfo.internal_flg.colordsp_size = data;
      break;
      case CnctLists.CNCT_APBF_CNCT: // SB-1接続
      pCom.iniMacInfo.internal_flg.apbf_cnct = data;
      break;
      case CnctLists.CNCT_HITOUCH_CNCT: // Hitouch接続
      // 何もしない
      break;
      case CnctLists.CNCT_AMI_CNCT: // ゴルフ場精算機ICリーダー接続
      // 何もしない
      break;
      default:
   }
  }

  ///  関連tprxソース: cnct.c - cnct_type_on()
  static void cnctTypeOn() {
    cnctExecMode = 1;
  }
  ///  関連tprxソース: cnct.c - cnct_type_off()
  static void cnctTypeOff() {
    cnctExecMode = 0;
  }

  ///  関連tprxソース: cnct.c - cnct_chk_sio_on()
  static void cnctChkSioOn() {
    cnctChkSio = 1;
  }
  ///  関連tprxソース: cnct.c - cnct_chk_sio_off()
  static void cnctChkSioOff() {
    cnctChkSio = 0;
  }
}

///  関連tprxソース: cnct.h - CNCT_TYPS
enum CnctTypes{
  CNCT_GETMEM(false,false) ,
  CNCT_GETSYS(false,true),
  CNCT_SETMEM(true,false),
  CNCT_SETSYS(true,true),

  // 202312 QCJCは実装対象外.
  // CNCT_GETMEM_JC_J, /* GET ini_macinfo                       */
  // CNCT_GETMEM_JC_C, /* GET ini_macinfo_JC_C                  */
  CNCT_GETMEM_ALL(false,false),  /* GET ini_macinfo and ini_macinfo_JC_C  */

  // CNCT_GETSYS_JC_J, /* GET mac_info.json                      */
  // CNCT_GETSYS_JC_C, /* GET mac_info_JC_C.json                 */
  CNCT_GETSYS_ALL(false,true),  /* GET mac_info.json and macinfo_JC_C.json */

  CNCT_GETSYS_INI(false,true);  /* GET mac_info.json and macinfo_JC_C.json */

  /// 値をセットする場合はtrue,ゲットする場合false.
  final bool setting;
  /// 設定ファイルからとってくる場合はtrueメモリから持ってくる場合はfalse;
  final bool sys;
  const CnctTypes(this.setting,this.sys);
}
///  関連tprxソース: cnct.h - CNCT_LISTS
enum CnctLists{
  CNCT_RCT_ONOFF("rct_onoff"),
  CNCT_ACR_ONOFF("acr_onoff"),
  CNCT_ACR_CNCT("acr_cnct"),
  CNCT_CARD_CNCT("card_cnct"),
  CNCT_ACB_DECCIN("acb_deccin"),
  CNCT_RWT_CNCT("rwt_cnct"),
  CNCT_SCALE_CNCT("scale_cnct"),
  CNCT_ACB_SELECT("acb_select"),
  CNCT_IIS21_CNCT("iis21_cnct"),
  CNCT_MOBILE_CNCT("mobile_cnct"),
  CNCT_STPR_CNCT("stpr_cnct"),
  CNCT_NETWLPR_CNCT("netwlpr_cnct"),
  CNCT_POPPY_CNCT("poppy_cnct"),
  CNCT_TAG_CNCT("tag_cnct"),
  CNCT_AUTO_DECCIN("auto_deccin"),
  CNCT_S2PR_CNCT("s2pr_cnct"),
  CNCT_PWRCTRL_CNCT("pwrctrl_cnct"),
  CNCT_CATALINAPR_CNCT("catalinapr_cnct"),
  CNCT_DISH_CNCT("dish_cnct"),
  CNCT_CUSTREALSVR_CNCT("custrealsvr_cnct"),
  CNCT_AIVOICE_CNCT("aivoice_cnct"),
  CNCT_GCAT_CNCT("gcat_cnct"),
  CNCT_SUICA_CNCT("suica_cnct"),
  CNCT_MP1_CNCT("mp1_cnct"),
  CNCT_REALITMSEND_CNCT("realitmsend_cnct"),
  CNCT_GRAMX_CNCT("gramx_cnct"),
  CNCT_RFID_CNCT("rfid_cnct"),
  CNCT_MSG_FLG("msg_flg"),
  CNCT_MULTI_CNCT("multi_cnct"),
  CNCT_JREM_CNCT("jrem_cnct"),
  CNCT_COLORDSP_CNCT("colordsp_cnct"),
  CNCT_USBCAM_CNCT("usbcam_cnct"),
  CNCT_MASR_CNCT("masr_cnct"),
  CNCT_BRAINFL_CNCT("brainfl_cnct"),
  CNCT_CAT_JMUPS_TWIN_CNCT("cat_jmups_twin_cnct"),
  CNCT_SQRC_CNCT("sqrc_ticket_cnct"),
  CNCT_CUSTREAL_PQS_NEW_SEND("custrealsvr_pqs_new_send"),
  CNCT_ICCARD_CNCT("iccard_cnct"),		/* 2015/02/02 */
  CNCT_COLORDSP_SIZE("colordsp_size"),
  CNCT_RCPT_CNCT(""),
  CNCT_APBF_CNCT("apbf_cnct"),
  CNCT_HITOUCH_CNCT("hitouch_cnct"),
  CNCT_AMI_CNCT("ami_cnct");

  static get CNCT_MAX => CnctLists.values.length;

  /// keyIdから対応するMultiQPTerminalを取得する.
  static CnctLists? getDefine(int index) {
    CnctLists? define =
    CnctLists.values.firstWhereOrNull((a) => a.index == index);
    define ??= null; // 定義されているものになければnoneを入れておく.
    return define;
  }

  final String keyword;
  const CnctLists(this.keyword);

}