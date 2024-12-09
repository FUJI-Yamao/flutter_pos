/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/sys/tpr_type.dart';
import 'package:flutter_pos/app/lib/apllib/cnct.dart';

import '../../inc/apl/rx_mbr_ata_chk.dart';
import '../../lib/apllib/recog.dart';
import '../inc/rc_regs.dart';

class RxRegMem{
  /************************************************************************/
  /*                      RECOG & CNCT Memory Set                         */
  /************************************************************************/
  /// 関連tprxソース: rxregmem.c - rxInfoMemGet
  static Future<void> rxInfoMemGet(TprMID tid) async {

    rcCnctMemAllSet(tid);
    // TODO:10121 QUICPay、iD 202404実装対象外
    // rc_Info_Mem_get();
    await rcRecogMemAllSet(tid);
  }

  /// 周辺装置メモリセット
  /// 引数:[tid] タスクID
  /// 関連tprxソース: rxregmem.c - rc_cnct_mem_allset
  static void rcCnctMemAllSet(TprMID tid){
    for(int i = 0;i < CnctLists.CNCT_MAX; i++){
      rcCnctMemSet(tid,i);
    }
    RcRegs.rcInfoMem.rcCnct.cnctEffect = 1;
  }

  /// 周辺装置メモリセット（パラメタ指定）
  /// 引数:[tid] タスクID
  /// 引数:[num] パラメタリストNo
  /// 関連tprxソース: rxregmem.c - rc_cnct_mem_set
  static void rcCnctMemSet(TprTID tid, int num) {
    switch(CnctLists.getDefine(num)){
      case CnctLists.CNCT_RCT_ONOFF: RcRegs.rcInfoMem.rcCnct.cnctRctOnoff  = Cnct.cnctMemGet(tid, CnctLists.CNCT_RCT_ONOFF);break;
      case CnctLists.CNCT_ACR_ONOFF: RcRegs.rcInfoMem.rcCnct.cnctAcrOnoff  = Cnct.cnctMemGet(tid, CnctLists.CNCT_ACR_ONOFF);break;
      case CnctLists.CNCT_ACR_CNCT: RcRegs.rcInfoMem.rcCnct.cnctAcrCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_ACR_CNCT);break;
      case CnctLists.CNCT_CARD_CNCT: RcRegs.rcInfoMem.rcCnct.cnctCardCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_CARD_CNCT);break;
      case CnctLists.CNCT_ACB_DECCIN: RcRegs.rcInfoMem.rcCnct.cnctAcbDeccin  = Cnct.cnctMemGet(tid, CnctLists.CNCT_ACB_DECCIN);break;
      case CnctLists.CNCT_RWT_CNCT: RcRegs.rcInfoMem.rcCnct.cnctRwtCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_RWT_CNCT);break;
      case CnctLists.CNCT_SCALE_CNCT: RcRegs.rcInfoMem.rcCnct.cnctScaleCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_SCALE_CNCT);break;
      case CnctLists.CNCT_ACB_SELECT: RcRegs.rcInfoMem.rcCnct.cnctAcbSelect  = Cnct.cnctMemGet(tid, CnctLists.CNCT_ACB_SELECT);break;
      case CnctLists.CNCT_IIS21_CNCT: RcRegs.rcInfoMem.rcCnct.cnctIis21Cnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_IIS21_CNCT);break;
      case CnctLists.CNCT_MOBILE_CNCT: RcRegs.rcInfoMem.rcCnct.cnctMobileCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_MOBILE_CNCT);break;
      case CnctLists.CNCT_STPR_CNCT: RcRegs.rcInfoMem.rcCnct.cnctStprCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_STPR_CNCT);break;
      case CnctLists.CNCT_NETWLPR_CNCT: RcRegs.rcInfoMem.rcCnct.cnctNetwlprCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_NETWLPR_CNCT);break;
      case CnctLists.CNCT_POPPY_CNCT: RcRegs.rcInfoMem.rcCnct.cnctPoppyCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_POPPY_CNCT);break;
      case CnctLists.CNCT_TAG_CNCT: RcRegs.rcInfoMem.rcCnct.cnctTagCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_TAG_CNCT);break;
      case CnctLists.CNCT_AUTO_DECCIN: RcRegs.rcInfoMem.rcCnct.cnctAutoDeccin  = Cnct.cnctMemGet(tid, CnctLists.CNCT_AUTO_DECCIN);break;
      case CnctLists.CNCT_S2PR_CNCT: RcRegs.rcInfoMem.rcCnct.cnctS2PrCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_S2PR_CNCT);break;
      case CnctLists.CNCT_PWRCTRL_CNCT: RcRegs.rcInfoMem.rcCnct.cnctPwrctrlCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_PWRCTRL_CNCT);break;
      case CnctLists.CNCT_CATALINAPR_CNCT: RcRegs.rcInfoMem.rcCnct.cnctCatalinaprCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_CATALINAPR_CNCT);break;
      case CnctLists.CNCT_DISH_CNCT: RcRegs.rcInfoMem.rcCnct.cnctDishCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_DISH_CNCT);break;
      case CnctLists.CNCT_CUSTREALSVR_CNCT: RcRegs.rcInfoMem.rcCnct.cnctCustrealsvrCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_CUSTREALSVR_CNCT);break;
      case CnctLists.CNCT_AIVOICE_CNCT: RcRegs.rcInfoMem.rcCnct.cnctAivoiceCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_AIVOICE_CNCT);break;
      case CnctLists.CNCT_GCAT_CNCT: RcRegs.rcInfoMem.rcCnct.cnctGcatCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_GCAT_CNCT);break;
      case CnctLists.CNCT_SUICA_CNCT: RcRegs.rcInfoMem.rcCnct.cnctSuicaCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_SUICA_CNCT);break;
      case CnctLists.CNCT_MP1_CNCT: RcRegs.rcInfoMem.rcCnct.cnctMp1Cnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_MP1_CNCT);break;
      case CnctLists.CNCT_REALITMSEND_CNCT: RcRegs.rcInfoMem.rcCnct.cnctRealitmsendCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_REALITMSEND_CNCT);break;
      case CnctLists.CNCT_GRAMX_CNCT: RcRegs.rcInfoMem.rcCnct.cnctGramxCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_GRAMX_CNCT);break;
      case CnctLists.CNCT_RFID_CNCT: RcRegs.rcInfoMem.rcCnct.cnctRfidCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_RFID_CNCT);break;
      case CnctLists.CNCT_MSG_FLG: RcRegs.rcInfoMem.rcCnct.cnctMsgFlg  = Cnct.cnctMemGet(tid, CnctLists.CNCT_MSG_FLG);break;
      case CnctLists.CNCT_MULTI_CNCT: RcRegs.rcInfoMem.rcCnct.cnctMultiCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_MULTI_CNCT);break;
      case CnctLists.CNCT_JREM_CNCT: RcRegs.rcInfoMem.rcCnct.cnctJremCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_JREM_CNCT);break;
      case CnctLists.CNCT_COLORDSP_CNCT: RcRegs.rcInfoMem.rcCnct.cnctColordspCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_COLORDSP_CNCT);break;
      case CnctLists.CNCT_USBCAM_CNCT: RcRegs.rcInfoMem.rcCnct.cnctUsbcamCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_USBCAM_CNCT);break;
      case CnctLists.CNCT_MASR_CNCT: RcRegs.rcInfoMem.rcCnct.cnctMasrCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_MASR_CNCT);break;
      case CnctLists.CNCT_BRAINFL_CNCT: RcRegs.rcInfoMem.rcCnct.cnctBrainflCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_BRAINFL_CNCT);break;
      case CnctLists.CNCT_CAT_JMUPS_TWIN_CNCT: RcRegs.rcInfoMem.rcCnct.cnctCatJmupsTwinCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_CAT_JMUPS_TWIN_CNCT);break;
      case CnctLists.CNCT_SQRC_CNCT: RcRegs.rcInfoMem.rcCnct.cnctSqrcCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_SQRC_CNCT);break;
      case CnctLists.CNCT_CUSTREAL_PQS_NEW_SEND: RcRegs.rcInfoMem.rcCnct.cnctCustrealPqsNewSend  = Cnct.cnctMemGet(tid, CnctLists.CNCT_CUSTREAL_PQS_NEW_SEND);break;
      case CnctLists.CNCT_ICCARD_CNCT: RcRegs.rcInfoMem.rcCnct.cnctIccardCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_ICCARD_CNCT);break;
      case CnctLists.CNCT_COLORDSP_SIZE: RcRegs.rcInfoMem.rcCnct.cnctColordspSize  = Cnct.cnctMemGet(tid, CnctLists.CNCT_COLORDSP_SIZE);break;
      case CnctLists.CNCT_RCPT_CNCT: RcRegs.rcInfoMem.rcCnct.cnctRcptCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_RCPT_CNCT);break;
      case CnctLists.CNCT_APBF_CNCT: RcRegs.rcInfoMem.rcCnct.cnctApbfCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_APBF_CNCT);break;
      case CnctLists.CNCT_HITOUCH_CNCT: RcRegs.rcInfoMem.rcCnct.cnctHitouchCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_HITOUCH_CNCT);break;
      case CnctLists.CNCT_AMI_CNCT: RcRegs.rcInfoMem.rcCnct.cnctAmiCnct  = Cnct.cnctMemGet(tid, CnctLists.CNCT_AMI_CNCT);break;
      default: break;
    }
  }

  /// 関連tprxソース: rxregmem.c - rc_recog_mem_allset
  static Future<void> rcRecogMemAllSet(TprMID tid) async {
    int i = 0;
    for (i = 0; i < RecogLists.RECOG_MAX.index; i++) {
      await rcRecogMemSet(tid, i);
    }
    RcRegs.rcInfoMem.rcRecog.recogEffect = 1;
  }

  /// 関連tprxソース: rxregmem.c - rc_recog_mem_set
  /* 承認キーメモリセット関数 */
  static Future<void> rcRecogMemSet(TprMID tid, int num) async {
    switch (RecogLists.getDefine(num)) {
      case RecogLists.RECOG_MEMBERSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogMembersystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_MEMBERSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_MEMBERPOINT:
        RcRegs.rcInfoMem.rcRecog.recogMemberpoint = (await Recog().recogGet(
            tid, RecogLists.RECOG_MEMBERPOINT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_MEMBERFSP:
        RcRegs.rcInfoMem.rcRecog.recogMemberfsp = (await Recog().recogGet(
            tid, RecogLists.RECOG_MEMBERFSP, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CREDITSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogCreditsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_CREDITSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SPECIAL_RECEIPT:
        RcRegs.rcInfoMem.rcRecog.recogSpecialReceipt = (await Recog().recogGet(
            tid, RecogLists.RECOG_SPECIAL_RECEIPT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_DISC_BARCODE:
        RcRegs.rcInfoMem.rcRecog.recogDiscBarcode = (await Recog().recogGet(
            tid, RecogLists.RECOG_DISC_BARCODE, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_IWAISYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogIwaisystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_IWAISYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SELF_GATE:
        RcRegs.rcInfoMem.rcRecog.recogSelfGate = (await Recog().recogGet(
            tid, RecogLists.RECOG_SELF_GATE, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SYS_24HOUR:
        RcRegs.rcInfoMem.rcRecog.recogSys24Hour = (await Recog().recogGet(
            tid, RecogLists.RECOG_SYS_24HOUR, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_VISMACSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogVismacsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_VISMACSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_HQ_ASP:
        RcRegs.rcInfoMem.rcRecog.recogHqAsp = (await Recog().recogGet(
            tid, RecogLists.RECOG_HQ_ASP, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_JASAITAMA_SYS:
        RcRegs.rcInfoMem.rcRecog.recogJasaitamaSys = (await Recog().recogGet(
            tid, RecogLists.RECOG_JASAITAMA_SYS, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_PROMSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogPromsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_PROMSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_EDYSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogEdysystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_EDYSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_FRESH_BARCODE:
        RcRegs.rcInfoMem.rcRecog.recogFreshBarcode = (await Recog().recogGet(
            tid, RecogLists.RECOG_FRESH_BARCODE, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SUGI_SYS:
        RcRegs.rcInfoMem.rcRecog.recogSugiSys = (await Recog().recogGet(
            tid, RecogLists.RECOG_SUGI_SYS, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_HESOKURISYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogHesokurisystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_HESOKURISYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_GREENSTAMP_SYS:
        RcRegs.rcInfoMem.rcRecog.recogGreenstampSys = (await Recog().recogGet(
            tid, RecogLists.RECOG_GREENSTAMP_SYS, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_COOPSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogCoopsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_COOPSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_POINTCARDSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogPointcardsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_POINTCARDSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_MOBILESYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogMobilesystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_MOBILESYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_HQ_OTHER:
        RcRegs.rcInfoMem.rcRecog.recogHqOther = (await Recog().recogGet(
            tid, RecogLists.RECOG_HQ_OTHER, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_REGCONNECTSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogRegconnectsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_REGCONNECTSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CLOTHES_BARCODE:
        RcRegs.rcInfoMem.rcRecog.recogClothesBarcode = (await Recog().recogGet(
            tid, RecogLists.RECOG_CLOTHES_BARCODE, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_FJSS:
        RcRegs.rcInfoMem.rcRecog.recogFjss = (await Recog().recogGet(
            tid, RecogLists.RECOG_FJSS, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_MCSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogMcsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_MCSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_NETWORK_PRN:
        RcRegs.rcInfoMem.rcRecog.recogNetworkPrn = (await Recog().recogGet(
            tid, RecogLists.RECOG_NETWORK_PRN, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_POPPY_PRINT:
        RcRegs.rcInfoMem.rcRecog.recogPoppyPrint = (await Recog().recogGet(
            tid, RecogLists.RECOG_POPPY_PRINT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_TAG_PRINT:
        RcRegs.rcInfoMem.rcRecog.recogTagPrint = (await Recog().recogGet(
            tid, RecogLists.RECOG_TAG_PRINT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_TAURUS:
        RcRegs.rcInfoMem.rcRecog.recogTaurus = (await Recog().recogGet(
            tid, RecogLists.RECOG_TAURUS, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_NTT_ASP:
        RcRegs.rcInfoMem.rcRecog.recogNttAsp = (await Recog().recogGet(
            tid, RecogLists.RECOG_NTT_ASP, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_EAT_IN:
        RcRegs.rcInfoMem.rcRecog.recogEatIn = (await Recog().recogGet(
            tid, RecogLists.RECOG_EAT_IN, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_MOBILESYSTEM2:
        RcRegs.rcInfoMem.rcRecog.recogMobilesystem2 = (await Recog().recogGet(
            tid, RecogLists.RECOG_MOBILESYSTEM2, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_MAGAZINE_BARCODE:
        RcRegs.rcInfoMem.rcRecog.recogMagazineBarcode = (await Recog().recogGet(
            tid, RecogLists.RECOG_MAGAZINE_BARCODE, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_HQ_OTHER_REAL:
        RcRegs.rcInfoMem.rcRecog.recogHqOtherReal = (await Recog().recogGet(
            tid, RecogLists.RECOG_HQ_OTHER_REAL, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_PW410SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogPw410System = (await Recog().recogGet(
            tid, RecogLists.RECOG_PW410SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_NSC_CREDIT:
        RcRegs.rcInfoMem.rcRecog.recogNscCredit = (await Recog().recogGet(
            tid, RecogLists.RECOG_NSC_CREDIT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_HQ_PROD:
        RcRegs.rcInfoMem.rcRecog.recogHqProd = (await Recog().recogGet(
            tid, RecogLists.RECOG_HQ_PROD, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_FELICASYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogFelicasystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_FELICASYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_PSP70SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogPsp70System = (await Recog().recogGet(
            tid, RecogLists.RECOG_PSP70SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_NTT_BCOM:
        RcRegs.rcInfoMem.rcRecog.recogNttBcom = (await Recog().recogGet(
            tid, RecogLists.RECOG_NTT_BCOM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CATALINASYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogCatalinasystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_CATALINASYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_PRCCHKR:
        RcRegs.rcInfoMem.rcRecog.recogPrcchkr = (await Recog().recogGet(
            tid, RecogLists.RECOG_PRCCHKR, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_DISHCALCSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogDishcalcsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_DISHCALCSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_ITF_BARCODE:
        RcRegs.rcInfoMem.rcRecog.recogItfBarcode = (await Recog().recogGet(
            tid, RecogLists.RECOG_ITF_BARCODE, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CSS_ACT:
        RcRegs.rcInfoMem.rcRecog.recogCssAct = (await Recog().recogGet(
            tid, RecogLists.RECOG_CSS_ACT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CUST_DETAIL:
        RcRegs.rcInfoMem.rcRecog.recogCustDetail = (await Recog().recogGet(
            tid, RecogLists.RECOG_CUST_DETAIL, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CUSTREALSVR:
        RcRegs.rcInfoMem.rcRecog.recogCustrealsvr = (await Recog().recogGet(
            tid, RecogLists.RECOG_CUSTREALSVR, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SUICA_CAT:
        RcRegs.rcInfoMem.rcRecog.recogSuicaCat = (await Recog().recogGet(
            tid, RecogLists.RECOG_SUICA_CAT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_YOMOCASYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogYomocasystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_YOMOCASYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SMARTPLUSSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSmartplussystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SMARTPLUSSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_DUTY:
        RcRegs.rcInfoMem.rcRecog.recogDuty = (await Recog().recogGet(
            tid, RecogLists.RECOG_DUTY, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_ECOASYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogEcoasystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_ECOASYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_ICCARDSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogIccardsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_ICCARDSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SUB_TICKET:
        RcRegs.rcInfoMem.rcRecog.recogSubTicket = (await Recog().recogGet(
            tid, RecogLists.RECOG_SUB_TICKET, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_QUICPAYSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogQuicpaysystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_QUICPAYSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_IDSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogIdsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_IDSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_REVIVAL_RECEIPT:
        RcRegs.rcInfoMem.rcRecog.recogRevivalReceipt = (await Recog().recogGet(
            tid, RecogLists.RECOG_REVIVAL_RECEIPT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_QUICK_SELF:
        RcRegs.rcInfoMem.rcRecog.recogQuickSelf = (await Recog().recogGet(
            tid, RecogLists.RECOG_QUICK_SELF, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_QUICK_SELF_CHG:
        RcRegs.rcInfoMem.rcRecog.recogQuickSelfChg = (await Recog().recogGet(
            tid, RecogLists.RECOG_QUICK_SELF_CHG, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_ASSIST_MONITOR:
        RcRegs.rcInfoMem.rcRecog.recogAssistMonitor = (await Recog().recogGet(
            tid, RecogLists.RECOG_ASSIST_MONITOR, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_MP1_PRINT:
        RcRegs.rcInfoMem.rcRecog.recogMp1Print = (await Recog().recogGet(
            tid, RecogLists.RECOG_MP1_PRINT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_REALITMSEND:
        RcRegs.rcInfoMem.rcRecog.recogRealitmsend = (await Recog().recogGet(
            tid, RecogLists.RECOG_REALITMSEND, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_RAINBOWCARD:
        RcRegs.rcInfoMem.rcRecog.recogRainbowcard = (await Recog().recogGet(
            tid, RecogLists.RECOG_RAINBOWCARD, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_GRAMX:
        RcRegs.rcInfoMem.rcRecog.recogGramx = (await Recog().recogGet(
            tid, RecogLists.RECOG_GRAMX, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_MM_ABJ:
        RcRegs.rcInfoMem.rcRecog.recogMmAbj = (await Recog().recogGet(
            tid, RecogLists.RECOG_MM_ABJ, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CAT_POINT:
        RcRegs.rcInfoMem.rcRecog.recogCatPoint = (await Recog().recogGet(
            tid, RecogLists.RECOG_CAT_POINT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_TAGRDWT:
        RcRegs.rcInfoMem.rcRecog.recogTagrdwt = (await Recog().recogGet(
            tid, RecogLists.RECOG_TAGRDWT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_DEPARTMENT_STORE:
        RcRegs.rcInfoMem.rcRecog.recogDepartmentStore = (await Recog().recogGet(
            tid, RecogLists.RECOG_DEPARTMENT_STORE, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_EDYNO_MBR:
        RcRegs.rcInfoMem.rcRecog.recogEdynoMbr = (await Recog().recogGet(
            tid, RecogLists.RECOG_EDYNO_MBR, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_FCF_CARD:
        RcRegs.rcInfoMem.rcRecog.recogFcfCard = (await Recog().recogGet(
            tid, RecogLists.RECOG_FCF_CARD, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_PANAMEMBERSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogPanamembersystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_PANAMEMBERSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_LANDISK:
        RcRegs.rcInfoMem.rcRecog.recogLandisk = (await Recog().recogGet(
            tid, RecogLists.RECOG_LANDISK, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_PITAPASYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogPitapasystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_PITAPASYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_TUOCARDSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogTuocardsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_TUOCARDSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SALLMTBAR:
        RcRegs.rcInfoMem.rcRecog.recogSallmtbar = (await Recog().recogGet(
            tid, RecogLists.RECOG_SALLMTBAR, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_BUSINESS_MODE:
        RcRegs.rcInfoMem.rcRecog.recogBusinessMode = (await Recog().recogGet(
            tid, RecogLists.RECOG_BUSINESS_MODE, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_MCP200SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogMcp200System = (await Recog().recogGet(
            tid, RecogLists.RECOG_MCP200SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SPVTSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSpvtsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SPVTSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_REMOTESYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogRemotesystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_REMOTESYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_ORDER_MODE:
        RcRegs.rcInfoMem.rcRecog.recogOrderMode = (await Recog().recogGet(
            tid, RecogLists.RECOG_ORDER_MODE, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_JREM_MULTISYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogJremMultisystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_JREM_MULTISYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_MEDIA_INFO:
        RcRegs.rcInfoMem.rcRecog.recogMediaInfo = (await Recog().recogGet(
            tid, RecogLists.RECOG_MEDIA_INFO, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_GS1_BARCODE:
        RcRegs.rcInfoMem.rcRecog.recogGs1Barcode = (await Recog().recogGet(
            tid, RecogLists.RECOG_GS1_BARCODE, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_ASSORTSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogAssortsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_ASSORTSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CENTER_SERVER:
        RcRegs.rcInfoMem.rcRecog.recogCenterServer = (await Recog().recogGet(
            tid, RecogLists.RECOG_CENTER_SERVER, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_RESERVSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogReservsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_RESERVSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_DRUG_REV:
        RcRegs.rcInfoMem.rcRecog.recogDrugRev = (await Recog().recogGet(
            tid, RecogLists.RECOG_DRUG_REV, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_GINCARDSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogGincardsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_GINCARDSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_FCLQPSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogFclqpsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_FCLQPSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_FCLEDYSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogFcledysystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_FCLEDYSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CAPS_CAFIS:
        RcRegs.rcInfoMem.rcRecog.recogCapsCafis = (await Recog().recogGet(
            tid, RecogLists.RECOG_CAPS_CAFIS, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_FCLIDSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogFclidsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_FCLIDSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_PTCKTISSUSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogPtcktissusystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_PTCKTISSUSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_ABS_PREPAID:
        RcRegs.rcInfoMem.rcRecog.recogAbsPrepaid = (await Recog().recogGet(
            tid, RecogLists.RECOG_ABS_PREPAID, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_PROD_ITEM_AUTOSET:
        RcRegs.rcInfoMem.rcRecog.recogProdItemAutoset = (await Recog().recogGet(
            tid, RecogLists.RECOG_PROD_ITEM_AUTOSET, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_PROD_ITF14_BARCODE:
        RcRegs.rcInfoMem.rcRecog.recogProdItf14Barcode = (await Recog().recogGet(
            tid, RecogLists.RECOG_PROD_ITF14_BARCODE, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SPECIAL_COUPON:
        RcRegs.rcInfoMem.rcRecog.recogSpecialCoupon = (await Recog().recogGet(
            tid, RecogLists.RECOG_SPECIAL_COUPON, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_BLUECHIP_SERVER:
        RcRegs.rcInfoMem.rcRecog.recogBluechipServer = (await Recog().recogGet(
            tid, RecogLists.RECOG_BLUECHIP_SERVER, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_HITACHI_BLUECHIP:
        RcRegs.rcInfoMem.rcRecog.recogHitachiBluechip = (await Recog().recogGet(
            tid, RecogLists.RECOG_HITACHI_BLUECHIP, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_HQ_OTHER_CANTEVOLE:
        RcRegs.rcInfoMem.rcRecog.recogHqOtherCantevole = (await Recog().recogGet(
            tid, RecogLists.RECOG_HQ_OTHER_CANTEVOLE, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_QCASHIER_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogQcashierSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_QCASHIER_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_RECEIPT_QR_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogReceiptQrSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_RECEIPT_QR_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_VISATOUCH_INFOX:
        RcRegs.rcInfoMem.rcRecog.recogVisatouchInfox = (await Recog().recogGet(
            tid, RecogLists.RECOG_VISATOUCH_INFOX, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_PBCHG_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogPbchgSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_PBCHG_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_HC1_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogHc1System = (await Recog().recogGet(
            tid, RecogLists.RECOG_HC1_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CAPS_HC1_CAFIS:
        RcRegs.rcInfoMem.rcRecog.recogCapsHc1Cafis = (await Recog().recogGet(
            tid, RecogLists.RECOG_CAPS_HC1_CAFIS, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_REMOTESERVER:
        RcRegs.rcInfoMem.rcRecog.recogRemoteserver = (await Recog().recogGet(
            tid, RecogLists.RECOG_REMOTESERVER, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_MRYCARDSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogMrycardsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_MRYCARDSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SP_DEPARTMENT:
        RcRegs.rcInfoMem.rcRecog.recogSpDepartment = (await Recog().recogGet(
            tid, RecogLists.RECOG_SP_DEPARTMENT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_DECIMALITMSEND:
        RcRegs.rcInfoMem.rcRecog.recogDecimalitmsend = (await Recog().recogGet(
            tid, RecogLists.RECOG_DECIMALITMSEND, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_WIZ_CNCT:
        RcRegs.rcInfoMem.rcRecog.recogWizCnct = (await Recog().recogGet(
            tid, RecogLists.RECOG_WIZ_CNCT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_ABSV31_RWT:
        RcRegs.rcInfoMem.rcRecog.recogAbsv31Rwt = (await Recog().recogGet(
            tid, RecogLists.RECOG_ABSV31_RWT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_PLURALQR_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogPluralqrSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_PLURALQR_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_NETDOARESERV:
        RcRegs.rcInfoMem.rcRecog.recogNetdoareserv = (await Recog().recogGet(
            tid, RecogLists.RECOG_NETDOARESERV, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SELPLUADJ:
        RcRegs.rcInfoMem.rcRecog.recogSelpluadj = (await Recog().recogGet(
            tid, RecogLists.RECOG_SELPLUADJ, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CUSTREAL_WEBSER:
        RcRegs.rcInfoMem.rcRecog.recogCustrealWebser = (await Recog().recogGet(
            tid, RecogLists.RECOG_CUSTREAL_WEBSER, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_WIZ_ABJ:
        RcRegs.rcInfoMem.rcRecog.recogWizAbj = (await Recog().recogGet(
            tid, RecogLists.RECOG_WIZ_ABJ, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CUSTREAL_UID:
        RcRegs.rcInfoMem.rcRecog.recogCustrealUid = (await Recog().recogGet(
            tid, RecogLists.RECOG_CUSTREAL_UID, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_BDLITMSEND:
        RcRegs.rcInfoMem.rcRecog.recogBdlitmsend = (await Recog().recogGet(
            tid, RecogLists.RECOG_BDLITMSEND, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CUSTREAL_NETDOA:
        RcRegs.rcInfoMem.rcRecog.recogCustrealNetdoa = (await Recog().recogGet(
            tid, RecogLists.RECOG_CUSTREAL_NETDOA, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_UT_CNCT:
        RcRegs.rcInfoMem.rcRecog.recogUtCnct = (await Recog().recogGet(
            tid, RecogLists.RECOG_UT_CNCT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CAPS_PQVIC:
        RcRegs.rcInfoMem.rcRecog.recogCapsPqvic = (await Recog().recogGet(
            tid, RecogLists.RECOG_CAPS_PQVIC, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_YAMATO_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogYamatoSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_YAMATO_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CAPS_CAFIS_STANDARD:
        RcRegs.rcInfoMem.rcRecog.recogCapsCafisStandard = (await Recog().recogGet(
            tid, RecogLists.RECOG_CAPS_CAFIS_STANDARD, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_NTTD_PRECA:
        RcRegs.rcInfoMem.rcRecog.recogNttdPreca = (await Recog().recogGet(
            tid, RecogLists.RECOG_NTTD_PRECA, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_USBCAM_CNCT:
        RcRegs.rcInfoMem.rcRecog.recogUsbcamCnct = (await Recog().recogGet(
            tid, RecogLists.RECOG_USBCAM_CNCT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_DRUGSTORE:
        RcRegs.rcInfoMem.rcRecog.recogDrugstore = (await Recog().recogGet(
            tid, RecogLists.RECOG_DRUGSTORE, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CUSTREAL_NEC:
        RcRegs.rcInfoMem.rcRecog.recogCustrealNec = (await Recog().recogGet(
            tid, RecogLists.RECOG_CUSTREAL_NEC, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CUSTREAL_OP:
        RcRegs.rcInfoMem.rcRecog.recogCustrealOp = (await Recog().recogGet(
            tid, RecogLists.RECOG_CUSTREAL_OP, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_DUMMY_CRDT:
        RcRegs.rcInfoMem.rcRecog.recogDummyCrdt = (await Recog().recogGet(
            tid, RecogLists.RECOG_DUMMY_CRDT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_HC2_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogHc2System = (await Recog().recogGet(
            tid, RecogLists.RECOG_HC2_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break; // くろがねや特注仕様確認
      case RecogLists.RECOG_PRICE_SOUND:
        RcRegs.rcInfoMem.rcRecog.recogPriceSound = (await Recog().recogGet(
            tid, RecogLists.RECOG_PRICE_SOUND, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_DUMMY_PRECA:
        RcRegs.rcInfoMem.rcRecog.recogDummyPreca = (await Recog().recogGet(
            tid, RecogLists.RECOG_DUMMY_PRECA, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_MONITORED_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogMonitoredSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_MONITORED_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_JMUPS_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogJmupsSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_JMUPS_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_UT1QPSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogUt1Qpsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_UT1QPSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_UT1IDSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogUt1Idsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_UT1IDSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_BRAIN_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogBrainSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_BRAIN_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_PFMPITAPASYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogPfmpitapasystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_PFMPITAPASYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_PFMJRICSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogPfmjricsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_PFMJRICSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CHARGESLIP_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogChargeslipSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_CHARGESLIP_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_PFMJRICCHARGESYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogPfmjricchargesystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_PFMJRICCHARGESYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_ITEMPRC_REDUCTION_COUPON:
        RcRegs.rcInfoMem.rcRecog.recogItemprcReductionCoupon = (await Recog().recogGet(
            tid, RecogLists.RECOG_ITEMPRC_REDUCTION_COUPON,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_CAT_JNUPS_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogCatJnupsSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_CAT_JNUPS_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SQRC_TICKET_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSqrcTicketSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SQRC_TICKET_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CCT_CONNECT_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogCctConnectSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_CCT_CONNECT_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CCT_EMONEY_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogCctEmoneySystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_CCT_EMONEY_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_TEC_INFOX_JET_S_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogTecInfoxJetSSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_TEC_INFOX_JET_S_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_PROD_INSTORE_ZERO_FLG:
        RcRegs.rcInfoMem.rcRecog.recogProdInstoreZeroFlg = (await Recog().recogGet(
            tid, RecogLists.RECOG_PROD_INSTORE_ZERO_FLG,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_FRONT_SELF_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogFrontSelfSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_FRONT_SELF_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_TRK_PRECA:
        RcRegs.rcInfoMem.rcRecog.recogTrkPreca = (await Recog().recogGet(
            tid, RecogLists.RECOG_TRK_PRECA, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_DESKTOP_CASHIER_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogDesktopCashierSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_DESKTOP_CASHIER_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_NIMOCA_POINT_SYSTEM :
        RcRegs.rcInfoMem.rcRecog.recogNimocaPointSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_NIMOCA_POINT_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_TB1_SYSTEM :
        RcRegs.rcInfoMem.rcRecog.recogTb1System = (await Recog().recogGet(
            tid, RecogLists.RECOG_TB1_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CUSTREAL_POINTARTIST :
        RcRegs.rcInfoMem.rcRecog.recogCustrealPointartist = (await Recog().recogGet(
            tid, RecogLists.RECOG_CUSTREAL_POINTARTIST,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_REPICA_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogRepicaSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_REPICA_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_YUMECA_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogYumecaSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_YUMECA_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CUSTREAL_TPOINT:
        RcRegs.rcInfoMem.rcRecog.recogCustrealTpoint = (await Recog().recogGet(
            tid, RecogLists.RECOG_CUSTREAL_TPOINT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_MAMMY_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogMammySystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_MAMMY_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_KITCHEN_PRINT:
        RcRegs.rcInfoMem.rcRecog.recogKitchenPrint = (await Recog().recogGet(
            tid, RecogLists.RECOG_KITCHEN_PRINT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_HC3_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogAyahaSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_HC3_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_COGCA_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogCogcaSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_COGCA_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SALL_LMTBAR26:
        RcRegs.rcInfoMem.rcRecog.recogSallLmtbar26 = (await Recog().recogGet(
            tid, RecogLists.RECOG_SALL_LMTBAR26, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_BDL_MULTI_SELECT_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogBdlMultiSelectSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_BDL_MULTI_SELECT_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
    /* ﾐｯｸｽﾏｯﾁ複数選択仕様 */
      case RecogLists.RECOG_PURCHASE_TICKET_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogPurchaseTicketSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_PURCHASE_TICKET_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
    /* 特定売上チケット発券仕様 */
      case RecogLists.RECOG_CUSTREAL_UNI_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogCustrealUniSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_CUSTREAL_UNI_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_EJ_ANIMATION_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogEjAnimationSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_EJ_ANIMATION_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_TAX_FREE_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogTaxFreeSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_TAX_FREE_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_VALUECARD_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogValuecardSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_VALUECARD_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SM4_COMODI_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm4ComodiSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM4_COMODI_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CCT_POINTUSE_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogCctPointuseSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_CCT_POINTUSE_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SM5_ITOKU_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm5ItokuSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM5_ITOKU_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_ZHQ_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogZhqSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_ZHQ_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_RPOINT_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogRpointSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_RPOINT_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_VESCA_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogVescaSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_VESCA_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_AJS_EMONEY_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogAjsEmoneySystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_AJS_EMONEY_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SM16_TAIYO_TOYOCHO_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm16TaiyoToyochoSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM16_TAIYO_TOYOCHO_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_INFOX_DETAIL_SEND_SYSTEM :
        RcRegs.rcInfoMem.rcRecog.recogInfoxDetailSendSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_INFOX_DETAIL_SEND_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_SELF_MEDICATION_SYSTEM :
        RcRegs.rcInfoMem.rcRecog.recogSelfMedicationSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SELF_MEDICATION_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_PANAWAONSYSTEM :
        RcRegs.rcInfoMem.rcRecog.recogPanawaonsystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_PANAWAONSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_ONEPAYSYSTEM :
        RcRegs.rcInfoMem.rcRecog.recogOnepaysystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_ONEPAYSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_HAPPYSELF_SYSTEM :
        RcRegs.rcInfoMem.rcRecog.recogHappyselfSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_HAPPYSELF_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_HAPPYSELF_SMILE_SYSTEM :
        RcRegs.rcInfoMem.rcRecog.recogHappyselfSmileSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_HAPPYSELF_SMILE_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_LINEPAY_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogLinepaySystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_LINEPAY_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_STAFF_RELEASE_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogStaffReleaseSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_STAFF_RELEASE_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_WIZ_BASE_SYSTEM :
        RcRegs.rcInfoMem.rcRecog.recogWizBaseSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_WIZ_BASE_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SHOP_AND_GO_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogShopAndGoSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SHOP_AND_GO_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_DS2_GODAI_SYSTEM :
        RcRegs.rcInfoMem.rcRecog.recogDs2GodaiSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_DS2_GODAI_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_TAXFREE_PASSPORTINFO_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogTaxfreePassportinfoSystem =
            (await Recog().recogGet(
                tid, RecogLists.RECOG_TAXFREE_PASSPORTINFO_SYSTEM,
                RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_SM20_MAEDA_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm20MaedaSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM20_MAEDA_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SM36_SANPRAZA_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm36SanprazaSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM36_SANPRAZA_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_SM33_NISHIZAWA_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm33NishizawaSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM33_NISHIZAWA_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_CR50_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogCr50System = (await Recog().recogGet(
            tid, RecogLists.RECOG_CR50_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CASE_CLOTHES_BARCODE_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogCaseClothesBarcodeSystem =
            (await Recog().recogGet(
                tid, RecogLists.RECOG_CASE_CLOTHES_BARCODE_SYSTEM,
                RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_CUSTREAL_DUMMY_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogCustrealDummySystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_CUSTREAL_DUMMY_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_REASON_SELECT_STD_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogReasonSelectStdSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_REASON_SELECT_STD_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_BARCODE_PAY1_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogBarcodePay1System = (await Recog().recogGet(
            tid, RecogLists.RECOG_BARCODE_PAY1_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CUSTREAL_PTACTIX:
        RcRegs.rcInfoMem.rcRecog.recogCustrealPtactix = (await Recog().recogGet(
            tid, RecogLists.RECOG_CUSTREAL_PTACTIX, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CR3_SHARP_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogCr3SharpSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_CR3_SHARP_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CCT_CODEPAY_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogCctCodepaySystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_CCT_CODEPAY_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_WS_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogWsSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_WS_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CUSTREAL_POINTINFINITY:
        RcRegs.rcInfoMem.rcRecog.recogCustrealPointinfinity = (await Recog().recogGet(
            tid, RecogLists.RECOG_CUSTREAL_POINTINFINITY,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_TOY_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogToySystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_TOY_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_MULTI_VEGA_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogMultiVegaSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_MULTI_VEGA_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CANAL_PAYMENT_SERVICE_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogCanalPaymentServiceSystem =
            (await Recog().recogGet(
                tid, RecogLists.RECOG_CANAL_PAYMENT_SERVICE_SYSTEM,
                RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_DPOINT_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogDpointSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_DPOINT_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SM41_BELLEJOIS_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm41BellejoisSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM41_BELLEJOIS_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_SM42_KANESUE_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm42KanesueSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM42_KANESUE_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SM44_JA_TSURUOKA_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm44JaTsuruokaSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM44_JA_TSURUOKA_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_PUBLIC_BARCODE_PAY_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogPublicBarcodePaySystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_PUBLIC_BARCODE_PAY_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_STERA_TERMINAL_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSteraTerminalSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_STERA_TERMINAL_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_REPICA_POINT_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogRepicaPointSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_REPICA_POINT_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SM45_OCEAN_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm45OceanSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM45_OCEAN_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_FUJITSU_FIP_CODEPAY_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogFujitsuFipCodepaySystem =
            (await Recog().recogGet(
                tid, RecogLists.RECOG_FUJITSU_FIP_CODEPAY_SYSTEM,
                RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_TAXFREE_SERVER_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogTaxfreeServerSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_TAXFREE_SERVER_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_EMPLOYEE_CARD_PAYMENT_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogEmployeeCardPaymentSystem =
            (await Recog().recogGet(
                tid, RecogLists.RECOG_EMPLOYEE_CARD_PAYMENT_SYSTEM,
                RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_NET_RECEIPT_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogNetReceiptSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_NET_RECEIPT_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SM49_ITOCHAIN_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm49ItochainSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM49_ITOCHAIN_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_PUBLIC_BARCODE_PAY2_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogPublicBarcodePay2System =
            (await Recog().recogGet(
                tid, RecogLists.RECOG_PUBLIC_BARCODE_PAY2_SYSTEM,
                RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_MULTI_ONEPAYSYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogMultiOnepaysystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_MULTI_ONEPAYSYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SM52_PALETTE_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm52PaletteSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM52_PALETTE_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_PUBLIC_BARCODE_PAY3_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogPublicBarcodePay3System =
            (await Recog().recogGet(
                tid, RecogLists.RECOG_PUBLIC_BARCODE_PAY3_SYSTEM,
                RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_SVSCLS2_STLPDSC_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSvscls2StlpdscSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SVSCLS2_STLPDSC_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_SM55_TAKAYANAGI_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm55TakayanagiSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM55_TAKAYANAGI_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_MAIL_SEND_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogMailSendSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_MAIL_SEND_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_NETSTARS_CODEPAY_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogNetstarsCodepaySystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_NETSTARS_CODEPAY_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_SM56_KOBEBUSSAN_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm56KobebussanSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM56_KOBEBUSSAN_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_LIQR_TAXFREE_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogLiqrTaxfreeSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_LIQR_TAXFREE_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SM59_TAKARAMC_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm59TakaramcSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM59_TAKARAMC_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_DETAIL_NOPRN_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogDetailNoprnSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_DETAIL_NOPRN_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CUSTREAL_GYOMUCA_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogCustrealGyomucaSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_CUSTREAL_GYOMUCA_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_SM61_FUJIFILM_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm61FujifilmSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM61_FUJIFILM_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_DEPARTMENT2_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogDepartment2System = (await Recog().recogGet(
            tid, RecogLists.RECOG_DEPARTMENT2_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CUSTREAL_CROSSPOINT:
        RcRegs.rcInfoMem.rcRecog.recogCustrealCrosspoint = (await Recog().recogGet(
            tid, RecogLists.RECOG_CUSTREAL_CROSSPOINT, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_HC12_JOYFUL_HONDA_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogHc12JoyfulHondaSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_HC12_JOYFUL_HONDA_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_SM62_MARUICHI_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm62MaruichiSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM62_MARUICHI_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_SM65_RYUBO_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm65RyuboSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM65_RYUBO_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_TOMOIF_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogTomoifSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_TOMOIF_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_SM66_FRESTA_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm66FrestaSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM66_FRESTA_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_COSME1_ISTYLE_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogCosme1IstyleSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_COSME1_ISTYLE_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_SM71_SELECTION_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm71SelectionSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM71_SELECTION_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_KITCHEN_PRINT_RECIPT:
        RcRegs.rcInfoMem.rcRecog.recogKitchenPrintRecipt = (await Recog().recogGet(
            tid, RecogLists.RECOG_KITCHEN_PRINT_RECIPT,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_MIYAZAKI_CITY_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogMiyazakiCitySystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_MIYAZAKI_CITY_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_PUBLIC_BARCODE_PAY4_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogPublicBarcodePay4System =
            (await Recog().recogGet(
                tid, RecogLists.RECOG_PUBLIC_BARCODE_PAY4_SYSTEM,
                RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_SP1_QR_READ_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSp1QrReadSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SP1_QR_READ_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CASHONLY_KEYOPT_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogCashonlyKeyoptSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_CASHONLY_KEYOPT_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_SM74_OZEKI_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogSm74OzekiSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_SM74_OZEKI_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_CARPARKING_QR_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogCarparkingQrSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_CARPARKING_QR_SYSTEM,
            RecogTypes.RECOG_GETMEM)).result.index;
        break;
      case RecogLists.RECOG_OLC_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogOlcSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_OLC_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_QUIZ_PAYMENT_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogQuizPaymentSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_QUIZ_PAYMENT_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      case RecogLists.RECOG_JETS_LANE_SYSTEM:
        RcRegs.rcInfoMem.rcRecog.recogJetsLaneSystem = (await Recog().recogGet(
            tid, RecogLists.RECOG_JETS_LANE_SYSTEM, RecogTypes.RECOG_GETMEM))
            .result.index;
        break;
      default :
        break;
    }
  }
}

