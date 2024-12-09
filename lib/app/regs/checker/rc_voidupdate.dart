/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/counter.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/competition_ini.dart';
import '../../lib/apllib/upd_util.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_key_stf_release.dart';
import 'rc_mbr_com.dart';
import 'rc_suica_com.dart';
import 'rc_timer.dart';
import 'rccatalina.dart';
import 'rcsyschk.dart';

class RcVoidUpdate {
  // TODO:10125 通番訂正 202404実装対象外（定義のみ）
  /// 訂正や返品の元日付が条件に合致しない場合はエラーにする
  /// 引数:[voidSaleDate] 元売上日
  /// 戻値: 0=OK  それ以外=エラーコード
  /// 関連tprxソース:rc_voidupdate.c - rc_voidupdate_Check_ReadDate()
  static int rcVoidupdateCheckReadDate(String voidSaleDate) {
    return 0;
  }

  /// 関連tprxソース:rc_voidupdate.c - rcCheckVoidResultMyself()
  static bool rcCheckVoidResultMyself() {
    return true;
  }

  /// 訂正可能な実績かどうか、現在の操作モードから確認する
  /// (クレジット訂正時のみQC実績は未対応)
  /// 引数:[opeModeFlg] 画面モード
  /// 引数:[fncCode] ファンクションコード
  /// 戻値: true=可能  false=不可能
  /// 関連tprxソース:rc_voidupdate.c - rcVoidChkOpeMode()
  static bool rcVoidChkOpeMode(int opeModeFlg, FuncKey fncCode) {
    switch (fncCode) {
      case FuncKey.KY_EVOID:
        if (RcSysChk.rcVDOpeModeChk()
            && ((opeModeFlg == OpeModeFlagList.OPE_MODE_REG)
                || (opeModeFlg == OpeModeFlagList.OPE_MODE_REG_QC_SPLIT))) {
          return true;
        }
        break;
      case FuncKey.KY_ESVOID:
        if (RcSysChk.rcRGOpeModeChk()
            && ((opeModeFlg == OpeModeFlagList.OPE_MODE_REG)
                || (opeModeFlg == OpeModeFlagList.OPE_MODE_REG_QC_SPLIT))) {
          return true;
        }
        break;
      case FuncKey.KY_CRDTVOID:
      case FuncKey.KY_PRECAVOID:
        if (RcSysChk.rcVDOpeModeChk()
            && (opeModeFlg == OpeModeFlagList.OPE_MODE_REG)) {
          return true;
        }
        break;
      default:
        break;
    }

    if ((fncCode == FuncKey.KY_EVOID)
        || (fncCode == FuncKey.KY_ESVOID)
        || (fncCode == FuncKey.KY_CRDTVOID)
        || (fncCode == FuncKey.KY_PRECAVOID)) {
      if (RcSysChk.rcTROpeModeChk()) {
        if ((fncCode == FuncKey.KY_CRDTVOID)
            || (fncCode == FuncKey.KY_PRECAVOID)) {
          if (opeModeFlg == OpeModeFlagList.OPE_MODE_TRAINING) {
            return true;
          }
        } else if ((opeModeFlg == OpeModeFlagList.OPE_MODE_TRAINING)
            || (opeModeFlg == OpeModeFlagList.OPE_MODE_TRAINING_QC_SPLIT)) {
          return true;
        }
      }
    }
    return false;
  }

  /// 関連tprxソース:rc_voidupdate.c - VoidCustRealSrvUpdChk()
  static Future<bool> voidCustRealSrvUpdChk() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;

    if (await CmCksys.cmIchiyamaMartSystem() == 0) {
      return true;
    } else {
      RegsMem mem = SystemFunc.readRegsMem();
      if ((await RcSuicaCom.rcNimocaRdVoidData())
          && (mem.tTtllog.t100700Sts.voidIccnclMsgFlg != 0)) {
        return true;
      } else {
        return ((cBuf.dbTrm.voidCust == 1) &&
            (await CmCksys.cmChkRwcCust() == 0));
      }
    }
  }

  /// 自レジ実績変換時での二重呼出防止のため, 空実績送信
  /// 関連tprxソース:rc_voidupdate.c - rcCallBlockVoidResultMyself()
  static Future<VoidUpdateParam> rcCallBlockVoidResultMyself(
      VoidUpdateParam voidParam) async {
    String orgSaleDate = "";  // 訂正元日付をYYYYMMD形式に変換後格納バッファー
    String nowSaleDate = "";  // 本日日付をYYYYMMD形式に変換後格納バッファー
    String nowTime = "";  // システム時刻  YYYY/MM/DD HH:MM:SS形式
    VoidUpdateParam ret = voidParam;

    if (!rcCheckVoidResultMyself()) {
      return ret;
    }
    // TODO: 10034 日付管理 - timestamp.c datetime_change()呼び出し
    /*
    if ((datetime_change(NULL, nowSaleDate, 0, FT_YYYYMMDD, 1) == -1)
        || (datetime_change(NULL, nowTime, 1, FT_YYYYMMDD_SLASH_SPACE_HHMMSS_COLON, 1) == -1)
        || (datetime_change(voidParam->OrgDate, orgSaleDate, 2, FT_YYYYMMDD, 1) == -1) ) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "rcCallBlockVoidResultMyself(): datetime Get Error");
      return;
    }
     */
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
        "rcCallBlockVoidResultMyself(): Start orginal[$orgSaleDate] today[$nowSaleDate]");

    // TODO: 10034 日付管理 - timestamp.c datetime_dayscalc()呼び出し
    /*
    if (datetime_dayscalc(orgSaleDate, nowSaleDate) != 0) {
      char		sql[1024];
      char		date[4] = {0};
      long		setVoidRecNo = -1;
      long		setVoidPrnNo = -1;
      PGconn		*localCon;
      PGresult	*localRes;

      // 本日営業日以前の場合は、空実績のINSERTを行う
      if (C_BUF->db_regctrl.set_owner_flg > 0) {
        localCon = db_WebLogin( GetTid(), DB_ERRLOG, voidParam->OrgIpAddr );
      } else {
        localCon = db_SrLogin(GetTid(), DB_ERRLOG);
      }
      if (localCon != NULL) {
        strncpy( date, &orgSaleDate[6], 2 );
        snprintf( sql, sizeof(sql),
          "SELECT MAX(void_receipt_no) AS void_receipt_no, MAX(void_print_no) AS void_print_no FROM c_ttllog%s WHERE void_mac_no='%ld'",
          date, competition_get_macno(GetTid()) );
        if ((localRes = db_PQexec(GetTid(), DB_ERRLOG, localCon, sql)) != NULL) {
          if (db_PQntuples(GetTid(), localRes) != 0) {
            setVoidRecNo	= strtol( dbLibGetField(GetTid(), localRes, "void_receipt_no", 0), NULL, 10 );
            setVoidPrnNo	= strtol( dbLibGetField(GetTid(), localRes, "void_print_no", 0), NULL, 10 );
            setVoidRecNo++;
            setVoidPrnNo++;
          }
          if (setVoidRecNo > 9999) {
            setVoidRecNo = 1;
          }
          if (setVoidPrnNo > 9999) {
            setVoidPrnNo = 1;
          }
          snprintf( log, sizeof(log), "%s: Server INSERT [%ld][%ld]", __FUNCTION__, setVoidRecNo, setVoidPrnNo );
          TprLibLogWrite( GetTid(), TPRLOG_NORMAL, 0, log);
        }
        db_PQclear(GetTid(), localRes);

        snprintf( sql, sizeof(sql),
          "INSERT INTO c_ttllog%s (tran_flg,stre_cd,mac_no,receipt_no,print_no,chkr_no,chkr_name,cshr_no,cshr_name,now_sale_datetime,sale_date,ope_mode_flg,void_mac_no,void_receipt_no,void_print_no) values (0,'%ld','%ld','%ld','%ld','%ld','%s','%ld','%s','%s','%s','%d','%ld','%ld','%ld')",
          date,
          MEM->ttlrbuf.stre_cd,
          *voidParam->OrgMacNo,
          *voidParam->OrgRecNo,
          *voidParam->OrgPrnNo,
          0,
          "",
          0,
          "",
          nowTime,
          voidParam->OrgDate,
          OM_TRAINIG,
          competition_get_macno(GetTid()),
          setVoidRecNo,
          setVoidPrnNo);
        if ((setVoidRecNo != -1) && (setVoidPrnNo != -1)) {
          if ((localRes = db_PQexec(GetTid(), DB_ERRLOG, localCon, sql)) == NULL) {
            snprintf( log, sizeof(log), "%s: INSERT Sql Error", __FUNCTION__ );
            TprLibLogWrite( GetTid(), TPRLOG_ERROR, -1, log );
          }
          db_PQclear(GetTid(), localRes);
        }
        db_PQfinish( GetTid(), localCon );
      }
    } else {
     */
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        return ret;
      }
      RxCommonBuf cBuf = xRet.object;
      RegsMem mem = SystemFunc.readRegsMem();
      RegsMem tempMem = mem;
      mem = RegsMem();

      mem.tHeader.prn_typ = PrnterControlTypeIdx.TYPE_NOTEJRCPT.index;
      mem.tHeader.stre_cd = cBuf.iniMacInfo.system.shpno;
      mem.tHeader.mac_no = voidParam.orgMacNo;
      mem.tHeader.receipt_no = voidParam.orgRecNo;
      mem.tHeader.print_no = voidParam.orgPrnNo;
      mem.tHeader.chkr_no = 0;
      mem.tHeader.cshr_no = 0;
      mem.tHeader.ope_mode_flg = OpeModeFlagList.OPE_MODE_TRAINING;		// 訂正元レジのレポートに訂正レジ情報を印字させないため
      mem.tTtllog.t100001Sts.voidMacNo = (await CompetitionIni.competitionIniGetMacNo(Tpraid.TPRAID_PMOD)).value;
      mem.tTtllog.t100001Sts.voidReceiptNo = await Counter.competitionGetRcptNo(await RcSysChk.getTid());
      mem.tTtllog.t100001Sts.voidPrintNo = await Counter.competitionGetPrintNo(await RcSysChk.getTid());
      mem.tHeader.sale_date = tempMem.tHeader.sale_date;
      mem.tHeader.endtime = nowTime;

      await rcvoidLogUpdate(-1, ret.orgIpAddr, 0);
      mem = tempMem;
    // TODO: 10034 日付管理 - timestamp.c datetime_dayscalc()呼び出し
    /*
    }
     */
    ret.orgIpAddr = "";

    return ret;
  }

  /// 関連tprxソース:rc_voidupdate.c - rcvoidlog_Update()
  static Future<int> rcvoidLogUpdate(
      int fncCd, String ipAddr, int custUpdateFlg) async {
    int result = 0;
    int opeMode = 0;
    RegsMem mem = SystemFunc.readRegsMem();
    TTtlLog ttlLog = mem.tTtllog;

    RcKyStfRelease.rcPrgStfReleaseResave(); /* SM7_HOKUSHIN */

    AcMem cMem = SystemFunc.readAcMem();
    if (fncCd == FuncKey.KY_ESVOID.keyId) {
      opeMode = cMem.stat.opeMode;
      if (cMem.stat.opeMode != RcRegs.TR) {
        cMem.stat.opeMode = RcRegs.VD;
      }
    }
    if (CompileFlag.CATALINA_SYSTEM) {
      if (RcSysChk.cmRealItmSendSystem()) {
        await RcCatalina.rcCatalinaAllSend2(0);
      }
    }

    String ipAdr = "";
    ipAdr = ipAddr;
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
        "rcvoidLogUpdate(): receipt_no[${mem.tHeader.receipt_no}] mac_no[${mem.tHeader.mac_no}] void_mac_no[${mem.tTtllog.t100001Sts.voidMacNo}]");
    result = UpdUtil.voidMemSend(await RcSysChk.getTid(), ipAdr, mem);

    if ((await RcMbrCom.rcmbrChkStat() != 0)
        && (RcMbrCom.rcmbrChkCust() != 0)) {
      // TODO:10125 通番訂正 202404実装対象外
      /*
      #if CUSTREALSVR
      if ((((cm_custrealsvr_system())
              || (cm_custreal_pointartist_system())
              || (cm_custreal_nec_system(0))
              || (cm_custreal_uni_system())
              || (cm_custreal_Rpoint_system()))
            && (! cust_update_flg) )
            || (! ((cm_custrealsvr_system())
                  || (cm_custreal_pointartist_system())
                  || (cm_custreal_nec_system(0))
                  || (cm_custreal_uni_system())
                  || (cm_custreal_Rpoint_system())) ) ) {
      #endif
        if ((MbrActChk(fncCd))
            && (VoidCustRealSrvUpdChk() == TRUE)) {
          TtlLog.mac_no = competition_get_macno(GetTid());
          TtlLog.receipt_no = competition_get_rcptno(GetTid());
          TtlLog.print_no = competition_get_printno(GetTid());
          wts_con = chkr_ts_con;
          #if DEPARTMENT_STORE
          if(!(cm_DepartmentStore_system())) {
            /* 中合様では特殊な会員マスタを使用している為、省略 */
          #endif
            if( CMEM->custdata.enq.cust_no[0] == 0x00 ) {
              rcmbrReSetCustEnq(TtlLog.mbr_cd, TtlLog.mbr_mfamily_cd);
            }
          #if DEPARTMENT_STORE
          }
          #endif
          rcmbrCustlogUpdate( &TtlLog, NULL );
          chkr_ts_con = wts_con;
        }
      #if CUSTREALSVR
      }
      #endif
       */
    }
    if ( fncCd == FuncKey.KY_ESVOID.keyId) {
      if (cMem.stat.opeMode != RcRegs.TR) {
        cMem.stat.opeMode = opeMode;
      }
    }
    if (CompileFlag.MC_SYSTEM) {
      // TODO:10125 通番訂正 202404実装対象外
      /*
      if (fncCd == KY_CRDTVOID) {
        if (rcChk_Mc_System() &&
            ((MEM->mcarddata.mc_stat & 0x80)
                || (MEM->mcarddata.mc_stat & 0x1000))) {
          rcPana_RealLog_Send();
        }
      }
       */
    }
    return result;
  }

  /// タイマー実行
  /// 引数:[waitTime] 待ち時間
  /// 引数:[Functioon] 実行関数
  /// 引数:[data] タイマ処理へ渡すデータ
  /// 戻り値: true=動作中  false=停止中
  /// 関連tprxソース:rc_voidupdate.c - rcVoidProcTimerAdd()
  static int rcVoidProcTimerAdd(int waitTime, Function func, int data) {
    return RcTimer.rcTimerListAdd(RC_TIMER_LISTS.RC_VOID_PROC_TIMER, waitTime, func, data);
  }

  /// タイマーの初期化関数
  /// 戻り値: true=動作中  false=停止中
  /// 関連tprxソース:rc_voidupdate.c - rcVoidProcTimerRemove()
  static void rcVoidProcTimerRemove() {
    RcTimer.rcTimerListRemove(RC_TIMER_LISTS.RC_VOID_PROC_TIMER.id);
  }

  /// タイマー動作確認関数
  /// 戻り値: true=動作中  false=停止中
  /// 関連tprxソース:rc_voidupdate.c - rcVoidProcTimerChk()
  static bool rcVoidProcTimerChk() {
    return RcTimer.rcTimerListRun(RC_TIMER_LISTS.RC_VOID_PROC_TIMER);
  }
}

/// 接続時の種類
/// 関連tprxソース:rc_voidupdate.h - VOIDUP_DB_LOGIN_STATUS
enum VoidupDbLoginStatus {
  /// 接続OK
  VOIDUP_LOGIN_CONNECT_OK(0),
  /// 自レジ (当日実績)
  VOIDUP_LOGIN_LOCAL(1),
  /// 対象レジ (当日実績)
  VOIDUP_LOGIN_OTHER_LOCAL(2),
  /// Ｍレジ
  VOIDUP_LOGIN_MASTER(3),
  /// ＴＳ
  VOIDUP_LOGIN_TS(4),
  /// マルチセグメント (前日以前)
  VOIDUP_LOGIN_SEGMENT(5),
  /// 自レジ失敗
  VOIDUP_LOGIN_ERROR(-1),
  /// Ｍレジ失敗
  VOIDUP_LOGIN_MASTER_ERROR(-3),
  /// ＴＳ失敗
  VOIDUP_LOGIN_TS_ERROR(-4),
  /// マルチセグメント失敗
  VOIDUP_LOGIN_SEGMENT_ERROR(-5),
  /// マシン番号なし
  VOIDUP_LOGIN_NOTFOUND_ERROR(-6),
  ;
  final int stts;
  const VoidupDbLoginStatus(this.stts);
}

/// 各訂正操作で使用する値を格納
/// 関連tprxソース:rc_voidupdate.h - struct VoidUpdateParam
class VoidUpdateParam {
  int keyType = 0;  // 各訂正操作でのキーコード
  int speezaFlag = 0;  // スピーザでの呼び戻し実績用   0:通常  1:スピーザ実績
  int orgIpAddrSize = 0;  // IPアドレス格納バッファサイズ
  int orgMacNo = 0;  // 訂正元のマシン番号
  int orgRecNo = 0;  	//    〃   レシート番号
  int orgPrnNo = 0;  //    〃   ジャーナル番号
  String orgIpAddr = "";  //    〃   IPアドレス
  String orgDate = "";  //    〃   日付
}