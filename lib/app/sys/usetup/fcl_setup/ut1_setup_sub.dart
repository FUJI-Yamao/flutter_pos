/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:sprintf/sprintf.dart';

import '../../../common/cmn_sysfunc.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../inc/lib/apllib.dart';
import '../../../inc/lib/mm_reptlib_def.dart';
import '../../../inc/sys/tpr_log.dart';
import '../../../lib/apllib/TmnDaily_Trn.dart';
import '../../../lib/apllib/mm_reptlib.dart';
import '../../word/aa/l_fcl_setup.dart';
import 'fcl_setup.dart';
import 'fcl_setup_sub.dart';

class Ut1SetupSub{

  /// 関連tprxソース: ut1_setup_sub.c - ut1_ejhead_make
  static Future<void> ut1EjheadMake(int result) async {
    String buf = "";
    String errMsg = "";
    String errCd = "";
    int mode;

    if(TmnDailyTrn.fclsInfo.mode == 0){
      mode = 13;
    }else{
      mode = 5;
    }

    MmReptlib().headprintEj(mode, ReptNumber.MMREPT180.index);

    // memset( &buf[0], '\0', sizeof(buf) );
    // memset(&err_cd[0], '\0', sizeof(err_cd));
    // memset(&err_msg[0], '\0', sizeof(err_msg));

    switch(TmnDailyTrn.fclsInfo.state){
      case FclsSts.FCLS_STS_1_1_1:             /*  端末セットアップ通信  */
        buf = sprintf("%s - %s",
            [LFclSetup.FCLS_STITLE_COMM_COM, LFclSetup.FCLS_SETUP_COMM]);
        TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.error,
            "ut1EjheadMake: FCLS_STS_1_1_1");
        break;
      case FclsSts.FCLS_STS_1_1_2:
        /*  端末設定情報ダウンロード  */
        buf = sprintf("%s - %s",
            [LFclSetup.FCLS_STITLE_COMM_COM, LFclSetup.UT_STITLE_COMM_COM5]);
        TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.error,
            "ut1_ejhead_make: FCLS_STS_1_1_2");
        break;

      // case FCLS_STS_1_1_3:             /*  端末登録変更  */
    //   sprintf( buf, "%s - %s", FCLS_STITLE_COMM_COM, UT_STITLE_COMM_COM6);
    //   TprLibLogWrite(FCLS_LOG, TPRLOG_ERROR, -1, "ut1_ejhead_make: FCLS_STS_1_1_3");
    //   break;
    //
      case FclsSts.FCLS_STS_1_1_4:
        /*  端末交換通信  */
        buf = sprintf("%s - %s",
            [LFclSetup.FCLS_STITLE_COMM_COM, LFclSetup.UT_STITLE_COMM_COM7]);
        TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.error,
            "ut1_ejhead_make: FCLS_STS_1_1_4");
        break;

      // case FCLS_STS_1_3_1:             /*  QPセンタ通信 日計処理  */
    //   sprintf( buf, "%s - %s", FCLS_STITLE_COMM_QP, FCLS_DAILY);
    //   TprLibLogWrite(FCLS_LOG, TPRLOG_ERROR, -1, "ut1_ejhead_make: FCLS_STS_1_3_1");
    //   break;
    //
    // case FCLS_STS_1_4_1:             /*  Ｅｄｙセンタ通信 日計処理  */
    //   sprintf( buf, "%s - %s", FCLS_STITLE_COMM_EDY, FCLS_DAILY);
    //   TprLibLogWrite(FCLS_LOG, TPRLOG_ERROR, -1, "vega_ejhead_make: FCLS_STS_1_4_1");
    //   break;
    //
    // case FCLS_STS_1_4_2:             /*  Ｅｄｙセンタ通信 初回通信  */
    //   sprintf( buf, "%s - %s", FCLS_STITLE_COMM_EDY, FCLS_FIRST_COMM);
    //   TprLibLogWrite(FCLS_LOG, TPRLOG_ERROR, -1, "vega_ejhead_make: FCLS_STS_1_4_2");
    //   break;
    //
    // case FCLS_STS_1_4_3:             /*  Ｅｄｙセンタ通信 撤去通信  */
    //   sprintf( buf, "%s - %s", FCLS_STITLE_COMM_EDY, FCLS_REMOVAL_COMM);
    //   TprLibLogWrite(FCLS_LOG, TPRLOG_ERROR, -1, "vega_ejhead_make: FCLS_STS_1_4_3");
    //   break;
    //
    // case FCLS_STS_1_5_1:             /*  iDセンタ通信 日計処理  */
    //   sprintf( buf, "%s - %s", FCLS_STITLE_COMM_ID, FCLS_DAILY);
    //   TprLibLogWrite(FCLS_LOG, TPRLOG_ERROR, -1, "ut1_ejhead_make: FCLS_STS_1_5_1");
    //   break;
    //
    //
    // case FCLS_STS_2_2_1:             /*  交通系IC設定 端末音量  */
    //   if( result == 2 || result == 3){
    //     if(result == 2){
    //       result = 0;
    //       sprintf( buf, "%s - %s   %s : %x", FCLS_STITLE_SET_SUICA, FCLS_CMD_MLTSRVVOLUMEREQ, FCLS_VOLUME, pStat->multi.fcl_data.result);
    //     }
    //     else{
    //       result = 1;
    //       sprintf( buf, "%s - %s", FCLS_STITLE_SET_SUICA, FCLS_CMD_MLTSRVVOLUMEREQ);
    //     }
    //   }
    //   else{
    //     if(result == 0)
    //       sprintf( buf, "%s - %s   %s : %x", FCLS_STITLE_SET_SUICA, FCLS_CMD_MLTSRVVOLUMESET, FCLS_VOLUME, pStat->multi.fcl_data.result);
    //     else
    //       sprintf( buf, "%s - %s", FCLS_STITLE_SET_SUICA, FCLS_CMD_MLTSRVVOLUMESET);
    //   }
    //   TprLibLogWrite(FCLS_LOG, TPRLOG_ERROR, -1, "vega_ejhead_make: FCLS_STS_2_2_1");
    //   break;
    //
    // case FCLS_STS_2_3_1:             /*  QP設定 端末音量  */
    //   if( result == 2 || result == 3){
    //     if(result == 2){
    //       result = 0;
    //       sprintf( buf, "%s - %s   %s : %x", FCLS_STITLE_SET_QP, FCLS_CMD_MLTSRVVOLUMEREQ, FCLS_VOLUME, pStat->multi.fcl_data.result);
    //     }
    //     else{
    //       result = 1;
    //       sprintf( buf, "%s - %s", FCLS_STITLE_SET_QP, FCLS_CMD_MLTSRVVOLUMEREQ);
    //     }
    //   }
    //   else{
    //     if(result == 0)
    //       sprintf( buf, "%s - %s   %s : %x", FCLS_STITLE_SET_QP, FCLS_CMD_MLTSRVVOLUMESET, FCLS_VOLUME, pStat->multi.fcl_data.result);
    //     else
    //       sprintf( buf, "%s - %s", FCLS_STITLE_SET_QP, FCLS_CMD_MLTSRVVOLUMESET);
    //   }
    //   TprLibLogWrite(FCLS_LOG, TPRLOG_ERROR, -1, "ut1_ejhead_make: FCLS_STS_2_3_1");
    //   break;
    //
    // case FCLS_STS_2_4_1:             /*  Ｅｄｙ設定 端末音量  */
    //   if( result == 2 || result == 3){
    //     if(result == 2){
    //       result = 0;
    //       sprintf( buf, "%s - %s   %s : %x", FCLS_STITLE_SET_EDY, FCLS_CMD_MLTSRVVOLUMEREQ, FCLS_VOLUME, pStat->multi.fcl_data.result);
    //     }
    //     else{
    //       result = 1;
    //       sprintf( buf, "%s - %s", FCLS_STITLE_SET_EDY, FCLS_CMD_MLTSRVVOLUMEREQ);
    //     }
    //   }
    //   else{
    //     if(result == 0)
    //       sprintf( buf, "%s - %s   %s : %x", FCLS_STITLE_SET_EDY, FCLS_CMD_MLTSRVVOLUMESET, FCLS_VOLUME, pStat->multi.fcl_data.result);
    //     else
    //       sprintf( buf, "%s - %s", FCLS_STITLE_SET_EDY, FCLS_CMD_MLTSRVVOLUMESET);
    //   }
    //   TprLibLogWrite(FCLS_LOG, TPRLOG_ERROR, -1, "vega_ejhead_make: FCLS_STS_2_4_1");
    //   break;
    //
    // case FCLS_STS_2_5_1:             /*  iD設定 端末音量  */
    //   if( result == 2 || result == 3){
    //     if(result == 2){
    //       result = 0;
    //       sprintf( buf, "%s - %s   %s : %x", FCLS_STITLE_SET_ID, FCLS_CMD_MLTSRVVOLUMEREQ, FCLS_VOLUME, pStat->multi.fcl_data.result);
    //     }
    //     else{
    //       result = 1;
    //       sprintf( buf, "%s - %s", FCLS_STITLE_SET_ID, FCLS_CMD_MLTSRVVOLUMEREQ);
    //     }
    //   }
    //   else{
    //     if(result == 0)
    //       sprintf( buf, "%s - %s   %s : %x", FCLS_STITLE_SET_ID, FCLS_CMD_MLTSRVVOLUMESET, FCLS_VOLUME, pStat->multi.fcl_data.result);
    //     else
    //       sprintf( buf, "%s - %s", FCLS_STITLE_SET_ID, FCLS_CMD_MLTSRVVOLUMESET);
    //   }
    //   TprLibLogWrite(FCLS_LOG, TPRLOG_ERROR, -1, "ut1_ejhead_make: FCLS_STS_2_5_1");
    //   break;
    //
    // case FCLS_STS_3_1_1:             /*  共通保守 自己診断  */
    //   sprintf( buf, "%s - %s", FCLS_STITLE_MENTE_COM, UT_STITLE_MENTE_COMM);
    //   TprLibLogWrite(FCLS_LOG, TPRLOG_ERROR, -1, "ut1_ejhead_make: FCLS_STS_3_1_1");
    //   break;
    //
    // case FCLS_STS_3_2_1:             /*  共通保守 交通系ICセンタ通信  */
    //   sprintf( buf, "%s - %s", FCLS_STITLE_MENTE_COM, FCLS_STITLE_COMM_SUICA);
    //   TprLibLogWrite(FCLS_LOG, TPRLOG_ERROR, -1, "vega_ejhead_make: FCLS_STS_3_2_1");
    //   break;
    //
    // case FCLS_STS_3_3_1:             /*  共通保守 ＱＰセンタ通信  */
    //   sprintf( buf, "%s - %s", FCLS_STITLE_MENTE_COM, FCLS_STITLE_COMM_QP);
    //   TprLibLogWrite(FCLS_LOG, TPRLOG_ERROR, -1, "ut1_ejhead_make: FCLS_STS_3_3_1");
    //   break;
    //
    // case FCLS_STS_3_4_1:             /*  共通保守 Ｅｄｙセンタ通信  */
    //   sprintf( buf, "%s - %s", FCLS_STITLE_MENTE_COM, FCLS_STITLE_COMM_EDY);
    //   TprLibLogWrite(FCLS_LOG, TPRLOG_ERROR, -1, "vega_ejhead_make: FCLS_STS_3_4_1");
    //   break;
    //
    // case FCLS_STS_3_5_1:             /*  共通保守 ｉＤセンタ通信  */
    //   sprintf( buf, "%s - %s", FCLS_STITLE_MENTE_COM, FCLS_STITLE_COMM_ID);
    //   TprLibLogWrite(FCLS_LOG, TPRLOG_ERROR, -1, "ut1_ejhead_make: FCLS_STS_3_5_1");
    //   break;
    //
    // case FCLS_STS_3_6_1:             /*  共通保守 nimocaセンタ通信  */
    //   sprintf( buf, "%s - %s", FCLS_STITLE_MENTE_COM, FCLS_STITLE_COMM_NIMOCA);
    //   TprLibLogWrite(FCLS_LOG, TPRLOG_ERROR, -1, "vega_ejhead_make: FCLS_STS_3_6_1");
    //   break;
      default:
        TprLog().logAdd(FclSetup.FCLS_LOG, LogLevelDefine.error,
            "ut1EjheadMake: proc_no error");
        break;
    }
    await FclSetupSub.fclsEjTxtMake(buf, 0);

    buf = ""; // memset( &buf[0], '\0', sizeof(buf) );
    if(result == 0){ /* 正常終了 */
      buf = sprintf("%s%s",
          [LFclSetup.FCLS_EJ_RESULT, LFclSetup.FCLS_EJ_NORMAL]);
    }else{
      buf = sprintf("%s%s",
          [LFclSetup.FCLS_EJ_RESULT, LFclSetup.FCLS_EJ_ABNORMAL]);
      errCd = rcUt1Msg();
      buf += errCd; // strncat(buf, err_cd, sizeof(err_cd));
    }
    await FclSetupSub.fclsEjTxtMake(buf, 0);
    buf = ""; // memset( &buf[0], '\0', sizeof(buf) );
    await FclSetupSub.fclsEjTxtMake(buf, 0);

    return;
  }

  /// 関連tprxソース: ut1_setup_sub.c - rc_Ut1_Msg
  static String rcUt1Msg(){
    String ut1Buf = "";
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error, "rcUt1Msg() rxMemRead error\n");
      return '';
    }
    RxTaskStatBuf pStat = xRet.object;

    if(TmnDailyTrn.utSaleInfo.result == 2){
      return '';
    }

    if(pStat.multi.fclData.resultCode != 0){
      if((pStat.multi.fclData.centerResultCode.isNotEmpty)
          && (pStat.multi.fclData.centerResultCode[0] != String.fromCharCode(0x0))){
        ut1Buf = sprintf("(%i-%i-%s)", [
          pStat.multi.fclData.resultCode,
          pStat.multi.fclData.resultCodeExtended,
          pStat.multi.fclData.centerResultCode
        ]);
      }else{
        if(pStat.multi.fclData.resultCodeExtended != 0){
          ut1Buf = sprintf("(%i-%i)",[
            pStat.multi.fclData.resultCode,
            pStat.multi.fclData.resultCodeExtended
          ]);
        }else{
          ut1Buf = sprintf("(%i)" ,[pStat.multi.fclData.resultCode]);
        }
      }
    }else{
      return '';
    }
    return ut1Buf;
  }
}
