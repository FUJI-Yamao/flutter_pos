/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../lib/apllib/cnct.dart';
import '../apl/rxmem_define.dart';
import '../sys/tpr_log.dart';
import '../sys/tpr_type.dart';

///関連tprxソース: if_fcl.c
class IfFcl {
  /// 機能：自動処理が実行中かチェックする。
  /// 引数：TPRTID src
  /// 戻値：TRUE ：実行中
  ///       FALSE：未実行
  /// 関連tprxソース: if_fcl.c - fcl_auto_action_chk
  static bool fclAutoActionChk(TprTID src) {
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      TprLog().logAdd(src, LogLevelDefine.error, " rxMemPtr() error");
      return false;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;

    if (Cnct.cnctMemGet(src, CnctLists.CNCT_MULTI_CNCT).abs() == 4) {
      if (tsBuf.multi.order != FclProcNo.FCL_NOT_ORDER.index &&
          tsBuf.multi.step == 99) {
        return true;
      }
    } else {
      if (tsBuf.multi.order != FclProcNo.FCL_NOT_ORDER.index &&
          (tsBuf.multi.step == 98 || tsBuf.multi.step == 99)) {
        return true;
      }
    }
    return false;
  }

  /// 機能：自動処理を開始できない状態にする。
  /// 引数：TPRTID src
  ///       char   flg
  ///              0：自動処理を開始できる状態にする。
  ///              1：自動処理を開始できない状態にする。
  /// 戻値：なし
  /// 関連tprxソース: if_fcl.c - fcl_auto_no_start
  static void fclAutoNoStart(TprTID src, int flg) {
    RxMemRet xRetStat = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRetStat.isInvalid()) {
      TprLog().logAdd(src, LogLevelDefine.error, " rxMemPtr() error");
      return;
    }
    RxTaskStatBuf tsBuf = xRetStat.object;

    tsBuf.multi.autoFlg = flg;
    tsBuf.multi.flg |= 0x02;
  }
}

///関連tprxソース: if_fcl.h  Define data
class Fcl {
/* レスポンスコード */
static const int FCL_NORMAL      =  0;
static const int FCL_SENDERR     = -1;
static const int FCL_OFFLINE     = -2;
static const int FCL_TIMEOUT     = -3;
static const int FCL_RETRYERR    = -4;
static const int FCL_BUSY        = -5;
static const int FCL_SYSERR      = -6;
static const int FCL_CODEERR     = -7;
static const int FCL_RESERR      = -8;
static const int FCL_OCXERR      = -9;
static const int FCL_VOIDDATAERR = -10;
static const int FCL_ALARMMSG    = -11;
static const int FCL_INITCOMM    = -12;
static const int FCL_NONINITCOMM = -13;
}

///関連tprxソース: if_fcl.h - FCL_SERVICE
enum FclService {
  /* サービス種別 */
  FCL_UNIQ(0),
  FCL_SPVT(35),
  FCL_QP(2),
  FCL_EDY(1),
  FCL_ID(3),
  FCL_PITA(4),
  FCL_SUIC(5),
  FCL_WAON(6),
  FCL_CRDT(7),
  FCL_NIMOCA(8);

  final int value;
  const FclService(this.value);
}

///関連tprxソース: if_fcl.h - FCLPROCNO
enum FclProcNo {
  FCL_NOT_ORDER,
  FCL_I_START,
  FCL_I_OPEMODE_S,
  FCL_I_OPEMODE_R,
  FCL_I_STAT_S,
  FCL_I_STAT_R,
  FCL_I_ENCRYPT2_S,
  FCL_I_ENCRYPT2_R,
  FCL_I_MUTUAL1_S,
  FCL_I_MUTUAL1_R,
  FCL_I_MUTUAL2_S,
  FCL_I_MUTUAL2_R,
  FCL_I_MUTUAL2_ERR_S,
  FCL_I_MUTUAL2_ERR_R,
  FCL_I_DATA_S,
  FCL_I_DATA_R,
  FCL_I_TRAN_END_S,
  FCL_I_TRAN_END_R,
  FCL_I_TRAN_END_ERR_S,
  FCL_I_TRAN_END_ERR_R,
  FCL_I_TRAN_END_CAN_S,
  FCL_I_TRAN_END_CAN_R,
  FCL_I_TRAN_END_SPVT_S,
  FCL_I_TRAN_END_SPVT_R,
  FCL_I_TRAN_END_QP_S,
  FCL_I_TRAN_END_QP_R,
  FCL_I_TRAN_END_ID_S,
  FCL_I_TRAN_END_ID_R,
  FCL_I_END,
  FCL_T_START,
  FCL_T_OPEMODE_S,
  FCL_T_OPEMODE_R,
  FCL_T_TRAN_S,
  FCL_T_TRAN_R,
  FCL_T_TRAN_CHK_S,
  FCL_T_TRAN_CHK_R,
  FCL_T_TRAN_END_S,
  FCL_T_TRAN_END_R,
  FCL_T_TRAN_END_ERR_S,
  FCL_T_TRAN_END_ERR_R,
  FCL_T_TRAN_END_CAN_S,
  FCL_T_TRAN_END_CAN_R,
  FCL_T_LOG_RETRY,
  FCL_T_LOG_GET_S_S,
  FCL_T_LOG_GET_S_R,
  FCL_T_LOG_GET_S,
  FCL_T_LOG_GET_R,
  FCL_T_LOG_GET_E_S,
  FCL_T_LOG_GET_E_R,
  FCL_T_STAT_S,
  FCL_T_STAT_R,
  FCL_T_END,
  FCL_T_END_BAL,
  FCL_T_END_TRAN,
  FCL_T_END_ALARM,
  FCL_T_END_NOT,
  FCL_T_END_PIN,
  FCL_T_AUT_GET_S_S,
  FCL_T_AUT_GET_S_R,
  FCL_T_AUT_GET_S,
  FCL_T_AUT_GET_R,
  FCL_T_AUT_GET_E_S,
  FCL_T_AUT_GET_E_R,
  FCL_T_AUT_SUSPEND,
  FCL_T_AUT_RESTART,
  FCL_T_AUT_PUT_S_S,
  FCL_T_AUT_PUT_S_R,
  FCL_T_AUT_PUT_S,
  FCL_T_AUT_PUT_R,
  FCL_T_AUT_PUT_E_S,
  FCL_T_AUT_PUT_E_R,
  FCL_T_AUT_UPD_S,
  FCL_T_AUT_UPD_R,
  FCL_T_AUT_UPD_C_S,
  FCL_T_AUT_UPD_C_R,
  FCL_T_APL_GET_S_S,
  FCL_T_APL_GET_S_R,
  FCL_T_APL_GET_S,
  FCL_T_APL_GET_R,
  FCL_T_APL_GET_E_S,
  FCL_T_APL_GET_E_R,
  FCL_T_APL_SUSPEND,
  FCL_T_APL_RESTART,
  FCL_T_APL_PUT_S_S,
  FCL_T_APL_PUT_S_R,
  FCL_T_APL_PUT_S,
  FCL_T_APL_PUT_R,
  FCL_T_APL_PUT_E_S,
  FCL_T_APL_PUT_E_R,
  FCL_T_APL_UPD_S,
  FCL_T_APL_UPD_R,
  FCL_T_APL_UPD_C_S,
  FCL_T_APL_UPD_C_R,
  FCL_T_CAN_START,
  FCL_T_TRAN_CAN_S,
  FCL_T_TRAN_CAN_R,
  FCL_T_CAN_END,
  FCL_T_CAN_END_BAL,
  FCL_F_INQ_START,
  FCL_F_INQ_S,
  FCL_F_INQ_R,
  FCL_F_INQ_CHK_S,
  FCL_F_INQ_CHK_R,
  FCL_F_INQ_END,
  FCL_F_INQ_END_OK,
  FCL_F_INQ_END_NG,
  FCL_F_INQ_END_ALARM,
  FCL_F_CAN_START,
  FCL_F_INQ_CAN_S,
  FCL_F_INQ_CAN_R,
  FCL_F_CAN_END,
  FCL_F_CAN_END_ALARM,
  FCL_Q_TRAN_START,
  FCL_Q_OPEMODE_S,
  FCL_Q_OPEMODE_R,
  FCL_Q_STAT_S,
  FCL_Q_STAT_R,
  FCL_Q_ENCRYPT2_S,
  FCL_Q_ENCRYPT2_R,
  FCL_Q_MUTUAL1_S,
  FCL_Q_MUTUAL1_R,
  FCL_Q_MUTUAL2_S,
  FCL_Q_MUTUAL2_R,
  FCL_Q_MUTUAL2_ERR_S,
  FCL_Q_MUTUAL2_ERR_R,
  FCL_Q_DATA_S,
  FCL_Q_DATA_R,
  FCL_Q_TRAN_END_S,
  FCL_Q_TRAN_END_R,
  FCL_Q_TRAN_END_ERR_S,
  FCL_Q_TRAN_END_ERR_R,
  FCL_Q_TRAN_END_CAN_S,
  FCL_Q_TRAN_END_CAN_R,
  FCL_Q_TRAN_S,
  FCL_Q_TRAN_R,
  FCL_Q_TRAN_END,
  FCL_Q_TRAN_END_OK,
  FCL_Q_TRAN_END_NG,
  FCL_Q_TRAN_END_ALARM,
  FCL_B_BAL_START,
  FCL_B_OPEMODE_S,
  FCL_B_OPEMODE_R,
  FCL_B_BAL_S,
  FCL_B_BAL_R,
  FCL_B_BAL_CHK_S,
  FCL_B_BAL_CHK_R,
  FCL_B_BAL_END,
  FCL_B_CAN_START,
  FCL_B_BAL_CAN_S,
  FCL_B_BAL_CAN_R,
  FCL_B_CAN_END,
  FCL_R_READ_START,
  FCL_R_OPEMODE_S,
  FCL_R_OPEMODE_R,
  FCL_R_READ_S,
  FCL_R_READ_R,
  FCL_R_READ_CHK_S,
  FCL_R_READ_CHK_R,
  FCL_R_READ_END,
  FCL_R_CAN_START,
  FCL_R_INQ_CAN_S,
  FCL_R_INQ_CAN_R,
  FCL_R_CAN_END,
  FCL_M_READ_START,
  FCL_M_OPEMODE_S,
  FCL_M_OPEMODE_R,
  FCL_M_READ_S,
  FCL_M_READ_R,
  FCL_M_READ_CHK_S,
  FCL_M_READ_CHK_R,
  FCL_M_READ_END,
  FCL_M_WRITE_START,
  FCL_M_WRITE_S,
  FCL_M_WRITE_R,
  FCL_M_REWRITE_S,
  FCL_M_REWRITE_R,
  FCL_M_WRITE_CHK_S,
  FCL_M_WRITE_CHK_R,
  FCL_M_WRITE_END,
  FCL_M_CAN_START,
  FCL_M_CARD_CAN_S,
  FCL_M_CARD_CAN_R,
  FCL_M_CAN_END,
  FCL_U_OFF_START,
  FCL_U_OFF_OPEMODE_S,
  FCL_U_OFF_OPEMODE_R,
  FCL_U_OFF_END,
  FCL_D_START,
  FCL_D_OPEMODE_S,
  FCL_D_OPEMODE_R,
  FCL_D_STAT_S,
  FCL_D_STAT_R,
  FCL_D_ENCRYPT2_S,
  FCL_D_ENCRYPT2_R,
  FCL_D_MUTUAL1_S,
  FCL_D_MUTUAL1_R,
  FCL_D_MUTUAL2_S,
  FCL_D_MUTUAL2_R,
  FCL_D_MUTUAL2_ERR_S,
  FCL_D_MUTUAL2_ERR_R,
  FCL_D_DATA_S,
  FCL_D_DATA_R,
  FCL_D_TRAN_END_S,
  FCL_D_TRAN_END_R,
  FCL_D_TRAN_END_ERR_S,
  FCL_D_TRAN_END_ERR_R,
  FCL_D_TRAN_END_CAN_S,
  FCL_D_TRAN_END_CAN_R,
  FCL_D_MNT_OPEMODE_S,
  FCL_D_MNT_OPEMODE_R,
  FCL_D_MNT_PW_S,
  FCL_D_MNT_PW_R,
  FCL_D_MNT_IN_S,
  FCL_D_MNT_IN_R,
  FCL_D_DATETIME_SET_S,
  FCL_D_DATETIME_SET_R,
  FCL_D_MNT_OUT_S,
  FCL_D_MNT_OUT_R,
  FCL_D_OFF_OPEMODE_S,
  FCL_D_OFF_OPEMODE_R,
  FCL_D_END,
  FCL_A_START,
  FCL_A_OPEMODE_S,
  FCL_A_OPEMODE_R,
  FCL_A_STAT_S,
  FCL_A_STAT_R,
  FCL_A_ENCRYPT2_S,
  FCL_A_ENCRYPT2_R,
  FCL_A_MUTUAL1_S,
  FCL_A_MUTUAL1_R,
  FCL_A_MUTUAL2_S,
  FCL_A_MUTUAL2_R,
  FCL_A_MUTUAL2_ERR_S,
  FCL_A_MUTUAL2_ERR_R,
  FCL_A_DATA_S,
  FCL_A_DATA_R,
  FCL_A_TRAN_END_S,
  FCL_A_TRAN_END_R,
  FCL_A_TRAN_END_ERR_S,
  FCL_A_TRAN_END_ERR_R,
  FCL_A_TRAN_END_CAN_S,
  FCL_A_TRAN_END_CAN_R,
  FCL_A_MNT_OPEMODE_S,
  FCL_A_MNT_OPEMODE_R,
  FCL_A_MNT_PW_S,
  FCL_A_MNT_PW_R,
  FCL_A_MNT_IN_S,
  FCL_A_MNT_IN_R,
  FCL_A_DLL_S,
  FCL_A_DLL_R,
  FCL_A_DLL_CHK_S,
  FCL_A_DLL_CHK_R,
  FCL_A_COM_GET_S_S,
  FCL_A_COM_GET_S_R,
  FCL_A_COM_GET_S,
  FCL_A_COM_GET_R,
  FCL_A_COM_GET_E_S,
  FCL_A_COM_GET_E_R,
  FCL_A_MNT_OUT_S,
  FCL_A_MNT_OUT_R,
  FCL_A_OFF_OPEMODE_S,
  FCL_A_OFF_OPEMODE_R,
  FCL_A_END,
  FCL_E_STAT_START,
  FCL_E_STAT_S,
  FCL_E_STAT_R,
  FCL_E_STAT_END,
  OCX_D_START,
  OCX_D_END,
  OCX_D_CAN_END,
  OCX_U_START,
  OCX_U_END;

 static FclProcNo getDefine(int index) {
    FclProcNo state = FclProcNo.values.firstWhere((element) {
      return element.index == index;
    }, orElse: () => FclProcNo.FCL_NOT_ORDER);
    return state;
  }
}

///関連tprxソース: if_fcl.h - FCLSTEPNO
enum FclStepNo {
  FCL_STEP_WAIT(0),
  FCL_STEP_TRAN_BEFORE(1),
  FCL_STEP_TRAN_TOUCH(2),
  FCL_STEP_TRAN_RETRY1(3),
  FCL_STEP_TRAN_RETRY2(4),
  FCL_STEP_TRAN_AFTER(5),
  FCL_STEP_LOG_GET(6),
  FCL_STEP_INQ_BAL(7),
  FCL_STEP_INQ_TRAN(8),
  FCL_STEP_AUTO_INIT(98),
  FCL_STEP_AUTO_DLL(99);
  final int value;
  const FclStepNo(this.value);

  static FclStepNo getDefine(int index) {
    FclStepNo state = FclStepNo.values.firstWhere((element) {
      return element.value == index;
    }, orElse: () => FclStepNo.FCL_STEP_WAIT);
    return state;
  }
}

///関連tprxソース: if_fcl.h - FCLSTEP2NO
enum FclStep2No {
  FCL_STEP2_NORMAL,
  FCL_STEP2_RETOUCH,
  FCL_STEP2_PASSCORD,
  FCL_STEP2_AUT,
  FCL_STEP2_APL,
  FCL_STEP2_FIRSTCARD,
  FCL_STEP2_SAMECARD,
  FCL_STEP2_SHORTCARD,
  FCL_STEP2_PIN,
  FCL_STEP2_REPIN,
  FCL_STEP2_EXCHANGE;

  static FclStep2No getDefine(int index) {
    FclStep2No state = FclStep2No.values.firstWhere((element) {
      return element.index == index;
    }, orElse: () => FclStep2No.FCL_STEP2_NORMAL);
    return state;
  }
}

///関連tprxソース: if_fcl.h - FCL_DATA
class FclData {
  FclService skind = FclService.FCL_UNIQ;
  int tKind = 0;
  int mode = 0;
  int stat72 = 0;
  int code83 = 0;
  int srvSu = 0;
  List<String> code81 = List.empty();
  List<String> code84 = List.empty();
  int stat = 0;
  String	ode84 = '';
  int mngReq = 0;
  int result = 0;
  int slipNo = 0;
  String	edyId = '';
  int emId = 0;
  int resultCode = 0;
  int resultCodeExtended = 0;
  String centerResultCode = '';
  String centerResultCodePfm = '';
  FclSndData sndData = FclSndData();
  FclRcvData rcvData = FclRcvData();
  int ttlBlockSu = 0;
  int ttlByteSu = 0;
  List<String>?	data;
  int cnclOrder = 0;

}

///関連tprxソース: if_fcl.h - FCL_SND_DATA
class FclSndData {
  int printNo = 0;
  int			ttlAmt = 0;
  String		kId = '';
  String		cardId = '';
  int			limitDate = 0;
  int			canSlipNo = 0;
  int			canIcNo = 0;
  int			beEdyNo = 0;
  int			payMethod = 0;
  String		pluCd = '';
  int			cKind = 0;
  int			onOffNon = 0;
  String   tranDatetime = '';   // [VEGA]一件明細作成日時
  int      rctId = 0;          // [VEGA]一件明細ID
  String   cardKind = '';       // [VEGA]カード区分
  String   busiCd = '';         // [VEGA]活性化事業者コード
  List<FclPoint>? pointData;// [VEGA]ポイント情報

}

///関連tprxソース: if_fcl.h - FCL_RCV_DATA
class FclRcvData {
  int slipNo = 0;
  int icNo = 0;
  int edyNo= 0;
  int recognNo = 0;
  String dateTime = '';
  String cardId = '';
  int limitDate = 0;
  String name = '';
  String signRes = '';
  int lastBalance = 0;
  int nowBalance = 0;
  int notAmt = 0;
  String rwId = '';
  int cardType = 0;
  int rctId = 0;              // [VEGA]一件明細ID
  String cardKind = '';       // [VEGA]カード区分
  String busiCd = '';         // [VEGA]活性化事業者コード
}

///関連tprxソース: if_fcl.h - FCL_POINT
class FclPoint {
  int			targetAmt = 0;	// ポイント対象金額
  int			point = 0;		  // 付与ポイント数
}

/* ------------------------------------------------------ 共用テーブル１ */
///関連tprxソース: if_fcl.h - FCL_ETC1_R
class FclETC1R {
  String codeNo = '';
  int stat72 = 0;
  FclService skind = FclService.FCL_UNIQ;
}

/* ------------------------------------------------------ 共用テーブル２ */
///関連tprxソース: if_fcl.h - FCL_ETC2_R
class FclETC2R {
  String codeNo = '';
  int stat72 = 0;
  FclService skind = FclService.FCL_UNIQ;
  int result = 0;
}

/* ------------------------------------------------------ 共用テーブル３ */
///関連tprxソース: if_fcl.h - FCL_ETC3_R
class FclETC3R {
  String codeNo = '';
  int stat72 = 0;
}

/* ------------------------------------------------------ 共用テーブル５ */
///関連tprxソース: if_fcl.h - FCL_ETC5_R
class FclETC5R {
  String codeNo = '';
  int stat72 = 0;
  FclService skind = FclService.FCL_UNIQ;
  int stat = 0;
  String code84 = '';
}

///関連tprxソース: if_fcl.h - FCL_1003_R
class Fcl1003R {
  String codeNo = '';
  int stat72 = 0;
  int mode = 0;
  int code83 = 0;
  int srvsu = 0;
  List<String> code82 = List.filled(6, '');
}

///関連tprxソース: if_fcl.h - FCL_1010_R
class Fcl1010R {
  String codeNo = '';
  int stat72 = 0;
  int mode = 0;
  int result = 0;
  int spec = 0;
}

///関連tprxソース: if_fcl.h - FCL_174F_R
class Fcl174FR {
  String codeNo = '';
  int stat72 = 0;
  String ccu = '';
  int encrypt = 0;
}

///関連tprxソース: if_fcl.h - FCL_3090_R
class Fcl3090R {
  String codeNo = '';
  int stat72 = 0;
  String m1i = '';
  String m2i = '';
}

///関連tprxソース: if_fcl.h - FCL_9012_SPVT
class Fcl9012SPVT {
  int result = 0;
  int ttlBlockSu = 0;
  int ttlByteSu = 0;
}

///関連tprxソース: if_fcl.h - S_AREA9012
class SArea9012 {
  Fcl9012SPVT? spvt;

  SArea9012([this.spvt]);
}

///関連tprxソース: if_fcl.h - FCL_9012_R
class Fcl9012R {
  String codeNo = '';
  int stat72 = 0;
  FclService skind = FclService.FCL_UNIQ;
  SArea9012 sarea = SArea9012();
}

///関連tprxソース: if_fcl.h - FCL_9013_SPVT
class Fcl9013SPVT {
  int result = 0;
  String data = '';
}

///関連tprxソース: if_fcl.h - S_AREA9013
class SArea9013 {
  Fcl9013SPVT? spvt;

  SArea9013([this.spvt]);
}

///関連tprxソース: if_fcl.h - FCL_9013_R
class Fcl9013R {
  String codeNo = '';
  int stat72 = 0;
  FclService skind = FclService.FCL_UNIQ;
  SArea9013 sarea = SArea9013();
}

///関連tprxソース: if_fcl.h - FCL_9014_SPVT
class Fcl9014SPVT {
  int result = 0;
}

///関連tprxソース: if_fcl.h - S_AREA9014
class SArea9014 {
  Fcl9014SPVT? spvt;

  SArea9014([this.spvt]);
}

///関連tprxソース: if_fcl.h - FCL_9014_R
class Fcl9014R {
  String codeNo = '';
  int stat72 = 0;
  FclService skind = FclService.FCL_UNIQ;
  SArea9014 sarea = SArea9014();
}

///関連tprxソース: if_fcl.h - FCL_9030_R
class Fcl9030R {
  String codeNo = '';
  int stat72 = 0;
  String edyId = '';
  int emid = 0;
}

///関連tprxソース: if_fcl.h - FCL_9410_R
class Fcl9410R {
  String codeNo = '';
  int stat72 = 0;
  int stat = 0;
  int ttlsu = 0;
  int ttlamt = 0;
  String lastDateTime = '';
  String nowDateTime = '';
  int startEdyNo = 0;
  int endEdyNo = 0;
}

///関連tprxソース: if_fcl.h - FCL_9452_R
class Fcl9452R {
  String codeNo = '';
  int stat72 = 0;
  FclService skind = FclService.FCL_UNIQ;
  int stat = 0;
  String code84 = '';
  int printNo = 0;
  int dayTtlNo = 0;
  int saleSu = 0;
  int saleAmt = 0;
  int canSu = 0;
  int canAmt = 0;
  int ttlSu = 0;
  int ttlAmt = 0;
  String lastDateTime = '';
  String nowDateTime = '';
  int startSlipNo = 0;
  int endSlipNo = 0;
  int sendDataSu = 0;
  int ttlDataSu = 0;
}

///関連tprxソース: if_fcl.h - FCL_981A_R
class Fcl981AR {
  String codeNo = '';
  int stat72 = 0;
  FclService skind = FclService.FCL_UNIQ;
  int stat = 0;
  String code84 = '';
}

///関連tprxソース: if_fcl.h - FCL_B441_R
class FclB441R {
  String codeNo = '';
  int stat72 = 0;
  int stat = 0;
  int saleSu = 0;
  int saleAmt = 0;
  int canSu = 0;
  int canAmt = 0;
  int ttlSu = 0;
  int ttlAmt = 0;
  String lastDateTime = '';
  String nowDateTime = '';
  int startSlipNo = 0;
  int endSlipNo = 0;
  String code84 = '';
  String cName1 = '';
  int saleSu1 = 0;
  int saleAmt1 = 0;
  int canSu1 = 0;
  int canAmt1 = 0;
  String cName2 = '';
  int saleSu2 = 0;
  int saleAmt2 = 0;
  int canSu2 = 0;
  int canAmt2 = 0;
  String cName3 = '';
  int saleSu3 = 0;
  int saleAmt3 = 0;
  int canSu3 = 0;
  int canAmt3 = 0;
  String cName4 = '';
  int saleSu4 = 0;
  int saleAmt4 = 0;
  int canSu4 = 0;
  int canAmt4 = 0;
  String cName5 = '';
  int saleSu5 = 0;
  int saleAmt5 = 0;
  int canSu5 = 0;
  int canAmt5 = 0;
  String noOnusCName = '';
  int noOnusSaleSu = 0;
  int noOnusSaleAmt = 0;
  int noOnusCanSu = 0;
  int noOnusCanAmt = 0;
  int sendDataSu = 0;
  int ttlDataSu = 0;
}

///関連tprxソース: if_fcl.h - FCL_961E_ID
class Fcl961eID{
  String shopName = "";
  String telNo = "";
  int offAmt = 0;
  String schemeName = "";
  int schemeId = 0;
  int onPin = 0;
  int onPinAmt = 0;
  int payKind = 0;
  String cComCd = "";
  String tid = "";
  int authoriKind = 0;
  int keyKind = 0;
  int cafisVer = 0;
  String shopCd = "";
  int crdtCd = 0;
  String comCd = "";
}
