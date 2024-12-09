
// TODO : 必要かわからない関数をいれる。後で置き換えが必要

import 'app/fb/fb_lib.dart';
import 'app/inc/apl/rxmem_define.dart';
import 'app/inc/apl/rxregmem_define.dart';
import 'app/inc/apl/rxtbl_buff.dart';
import 'app/inc/apl/trm_list.dart';
import 'app/inc/lib/apllib.dart';
import 'app/inc/lib/jan_inf.dart';
import 'app/inc/sys/tpr_type.dart';
import 'app/lib/apllib/qr2txt.dart';
import 'app/regs/checker/rcstllcd.dart';
import 'app/regs/inc/rc_mbr.dart';
import 'app/regs/inc/rc_mem.dart';
import 'app/ui/colorfont/c_basefont.dart';
import 'postgres_library/src/customer_table_access.dart';
import 'postgres_library/src/db_manipulation_ps.dart';


// tprx\src\regs\inc\rcregs.h
// #define    FIP_BOTH        0
// #define    FIP_NO1         1
// #define    FIP_NO2         2
// #define    FIP_NO3         3
const int FIP_BOTH = 0;
const int FIP_NO1 = 1;
const int FIP_NO2 = 2;
const int FIP_NO3 = 3;

// tprx\src\inc\lib\ChgStyle.h
// #define KANJI16		16
// #define KANJI24		24
// #define KANJI32		32
// #define KANJINO		 0
const int KANJI16 = 16;
const int KANJI24 = 24;
const int KANJI32 = 32;
const int KANJINO = 0;


// 関連tprxソース: tprx\src\regs\checker\rc_jpo.h - #define   EDY_DEV_ERROR   0x0100
const int EDY_DEV_ERROR = 0x0100;

// 関連tprxソース: tprx\src\inc\lib\jan_inf.h ‐ #define JANformat_CHARGE_SLIP	(short)325
const JANInfConsts JANformat_CHARGE_SLIP = JANInfConsts.JANformatChargeSlip;

// 関連tprxソース: tprx\src\inc\lib\typ.h ‐ #define MAG_CD_MAX	16  /* */
const int MAG_CD_MAX = 16;

// 関連tprxソース: tprx\src\inc\apl\rxcntlists.h - #define	SPTEND_MAX	36
const int SPTEND_MAX = 36;

// 関連tprxソース: tprx\src\inc\lib\cm_sys.h - #define FIP_CNCT1 0
const int FIP_CNCT1 = 0;
// 関連tprxソース: tprx\src\inc\lib\cm_sys.h - #define FIP_CNCT2 1
const int FIP_CNCT2 = 1;
// 関連tprxソース: tprx\src\inc\lib\cm_sys.h - #define FIP_CNCT3 2
const int FIP_CNCT3 = 2;
// 関連tprxソース: tprx\src\inc\lib\cm_sys.h - #define FIP_CNCT2_SP 99
const int FIP_CNCT2_SP = 99;

// 関連tprxソース: tprx\src\regs\inc\rcmbr.h - #define	RCMBR_ANVKIND_1		1
const int RCMBR_ANVKIND_1 = 1;
// 関連tprxソース: tprx\src\regs\inc\rcmbr.h - #define	RCMBR_ANVKIND_2		2
const int RCMBR_ANVKIND_2 = 2;
// 関連tprxソース: tprx\src\regs\inc\rcmbr.h - #define	RCMBR_ANVKIND_3		4
const int RCMBR_ANVKIND_3 = 4;

// 関連tprxソース: tprx\src\regs\inc\rcregs.h - #define    RG            0x0000
const int RG = 0x0000;

// 関連tprxソース: tprx\src\regs\checker\rcstldsp.h　‐　post tendering. Entry, TEND and Change part
enum PostCtrl {
   PT_CLEAR(0),       /* Clear */
   PT_TOTAL(1),       /* Total */
   PT_CHANGE(2),      /* Change */
   CALC_TOTAL(3);     /* Total */

  final int value;
  const PostCtrl(this.value);
}

// 関連tprxソース: tprx\src\regs\checker\rc_floating.h - FL_RESULT
enum FlResult{
	FL_RESULT_SUCCESS(0),		// 成功(処理なし含む)
	FL_RESULT_OVER(1),			// 最大登録数超
	FL_RESULT_NONE(2),			// 対象データなし
	FL_RESULT_LOCKED(3),		// 他レジで操作中　(取得時のチェック)
	FL_RESULT_ILLMODE(4),		// 操作モードが異なるデータ登録済
	FL_RESULT_DBERR(5),		// データベースエラー
	FL_RESULT_SYSERR(6),		// システムエラー
	FL_RESULT_USE_CUST(7);		// 指定会員登録済み

  final int value;
  const FlResult(this.value);
}

// 関連tprxソース: tprx\src\regs\checker\rc_sgdsp.h - MBRCARD_READTYPE
enum MbrcardRedType {
	NOT_READ,
	IC_READ,
	MS_READ,
	DPOINT_READ,
	RPOINT_READ,
	OTB_READ,
	TMOBILE_READ,
	OBR_READ,
	TOMO_READ,
	MCARD_READ;
}


// 関連tprxソース: tprx\src\regs\checker\rcstllcd.h - Subttl_Sptend_Info
class Subttl_Sptend_Info {
  Object? sptendinfoFixed;
}

// 関連tprxソース: tprx\src\regs\checker\rc_sgdsp.h - NEWSG_EXPDSP
class NEWSG_EXPDSP {
  int dspCnt = 0;
}

// 関連tprxソース: c:\work\tera\c_src\pj\tprx\src\regs\checker\rc_qcdsp.h - QC_MBRREADDSP
class QC_MBRREADDSP {
  MbrcardRedType mbrcard_readtyp = MbrcardRedType.NOT_READ;
}

// 関連tprxソース: tprx\src\inc\apl\rxtbl_buff.h - p_brgnitem_mst
class PBrgnitemMst {
  int brgn_prc = 0;
  int brgncust_prc = 0;
}

class Dummy {

  static Object? tColorFipItemInfo = Object();

  /// 関連tprxソース: tprx\src\regs\checker\rcsuica_com.c - short rcSuica_IcChk(void)
  static int rcSuicaIcChk() {
    return 0;
  }

  // 関連tprxソース: tprx\src\lib\tprlib\TprLibUps.c - int	TprLibUpsCheck( TPRTID tid )
  static int tprLibUpsCheck(TprMID tid) {
    return 0;
  }

  // 関連tprxソース: tprx\src\lib\tprlib\TprLibHdd.c - int	TprLibSSDDiskSizeCheck( TPRTID tid )
  static int tprLibSSDDiskSizeCheck(TprMID tid) {
    return 0;
  }

  // 関連tprxソース: tprx\src\lib\tprlib\TprLibHdd.c - int	TprLibSSDCheck( TPRTID tid )
  static int tprLibSSDCheck(TprMID tid) {
    return 0;
  }

  // 関連tprxソース: tprx\src\lib\tprlib\TprLibHdd.c - short	TprLibUsbcamExist(TPRTID tid, int errpop_flg)
  static int tprLibUsbcamExist(TprMID tid, int errpopFlg) {
    return 0;
  }

  // 関連tprxソース: tprx\src\regs\checker\rc_acracb.c - short rcAcrAcb_RegStart_Proc(void)
  static int rcAcrAcbRegStartProc() {
    return 0;
  }

  // 関連tprxソース: tprx\src\regs\checker\rc_set.c - void    rcRegStart_Cashier_FlagClr(const char *call_func)
  static void rcRegStartCashierFlagClr(String callFunc) {
  }

  //　関連tprxソース: tprx\src\regs\checker\Regs.c - short rcQCJC_1Clk_Check(void)
  static int rcQCJC1ClkCheck() {
    return 0;
  }

  // 関連tprxソース: tprx\src\regs\checker\rckyrezero.c - void rcSG_AfterError_Proc(void)
  static void rcSGAfterErrorProc() {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcsyschk.c - bool rcCheck_Evoid_DirectCall(void)
  static bool rcCheckEvoidDirectCall() {
    return false;
  }

  // 関連tprxソース: tprx\src\regs\checker\Regs.c - void rcCall_FuncKey(void)
  static void rcCallFuncKey() {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcqc_com.c - void rcQC_Movie_Start(void)
  static void rcQCMovieStart() {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcqc_com.c - void rcQC_SignP_Ctrl_Proc(void)
  static void rcQCSignPCtrlProc() {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcqc_dsp.c - void	rcQC_Chk_Change_Stock( void )
  static void rcQCChkChangeStock() {
  }

  // 関連tprxソース: tprx\src\regs\checker\rc_auto.c - void	rcAuto_Chk_After_DocMemChk(int ret)
  static void rcAutoChkAfterDocMemChk(int ret) {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcitmchk.c - bool rcCheckInOutKey(void)
  static bool rcCheckInOutKey() {
    return false;
  }

  // 関連tprxソース: \tprx\src\regs\checker\rcmbrtellst.c - int rcmbrGetTelLstScrn(void)
  static bool rcmbrGetTelLstScrn() {
    return false;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcfncchk.c - bool rcCheck_OffMode(void)
  static bool rcCheckOffMode() {
    return false;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcky_clr.c - bool rcChk_Post_Reg(void)
  static bool rcChkPostReg() {
    return false;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcky_offdsp.c　‐bool	OffModeChkChecker( void )
  static bool offModeChkChecker() {
    return false;
  }

  // 関連tprxソース: tprx\src\regs\checker\liblary.c - void cm_mov (char *dst, char *src, size_t size)
  static void cmMov(PostReg dst, PostReg? src) {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcstldsp.c - void rcStlDsp_Post(short wPostCtrl)
  static void rcStlDspPost(PostCtrl wPostCtrl) {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcfncchk.c　‐　bool rcCheck_Crdt_Mode(void)
  static bool rcCheckCrdtMode() {
    return false;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcfncchk.c - bool rcCheck_SPVT_Mode(void)
  static bool rcCheckSPVTMode() {
    return false;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcfncchk.c - bool rcCheck_SPVT_VoidMode(void) 
  static bool rcCheckSPVTVoidMode() {
    return false;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcsptendinfo.c - void rcSptendInfo_Quit(Subttl_Info *pSubttl)
  static void rcSptendInfoQuit(SubttlInfo pSubttl) {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcmltsuica_com.c - void rcMultiNimoca_ReadEnd(void)
  static void rcMultiNimocaReadEnd() {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcmltsuica_com.c - void rcMultiSuica_EndProc(void)
  static void rcMultiSuicaEndProc() {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcspvt_dsp.c - void rcSPVT_ApproveDsp(void)
  static void rcSPVTApproveDsp() {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcspvt_com.c - void rcSPVT_Authori_End(short result)
  static void rcSPVTAuthoriEnd(int result) {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcspvt_com.c - void rcSPVT_EndProc(void)
  static void rcSPVTEndProc() {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcpitapa_com.c - void rcMultiPiTaPa_EndProc(void)
  static void rcMultiPiTaPaEndProc() {
  }

  // 関連tprxソース: tprx\src\regs\checker\rc_edy.c ‐ void rcEdy_KyBreak(void)
  static void rcEdyKyBreak() {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcedy_com.c - void rcMultiEdy_EndProc(void)
  static void rcMultiEdyEndProc() {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcitmdsp.c - void rc_Dualhalf_Default(void)
  static void rcDualhalfDefault() {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcsyschk.c - short rcChk_dPoint_DualMemberType(void)
  static int rcChkDPointDualMemberType() {
    return 0;
  }

  // 関連tprxソース: tprx\src\regs\checker\rc_timer.c - void rc_TimerList_Remove(RC_TIMER_LISTS num)
  static void rcTimerListRemove(RC_TIMER_LISTS num) {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcmbrrecal.c - void rcmbrrecal_set_immprom_data(void)
  static void rcmbrrecalSetImmpromData() {
  }

  // 関連tprxソース: tprx\src\regs\checker\rc_59dsp.c - int	rc59_floating_use_cust_check ( char *cust_no )
  static int rc59FloatingUseCustCheck(String? custNo) {
    return 0;
  }

  // 関連tprxソース: tprx\src\regs\checker\rc_floating.c - FL_RESULT rcFloating_Chk_Use_Cust (char *cust_no)
  static FlResult rcFloatingChkUseCust(String? custNo) {
    return FlResult.FL_RESULT_SUCCESS;
  }

  // 関連tprxソース: tprx\src\regs\checker\rc_59dsp.c - short	rc59_floating_chk_PLU_select ( void )
  static bool rc59FloatingChkPLUSelect() {
    return false;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcmbrcom.c ‐ short rcmbr_Ck_Digit_ds2(char* mbr_cd)
  static int rcmbrCkDigitDs2(String? mbrCd) {
    return 0;
  }

  // 関連tprxソース: tprx\src\regs\common\rxmbrcom.c - int rcmbrChkCustWithPtr(REGSMEM *pRct)
  static bool rcmbrChkCustWithPtr(RegsMem pRct) {
    return false;
  }

  // 関連tprxソース: tprx\src\lib\cm_ean\cdigit.c - char cm_w2_modulas10 (uchar *b_card, uchar *b_wait, int size)
  static String cmW2Modulas10(String bCard, String bWait, int size) {
    return (bCard + bWait).substring(0, size);
  }

  // 関連tprxソース: tprx\src\regs\checker\rcmbrcom.c - bool ChkMbrCd_TenCnt_Limit(void)
  static bool chkMbrCdTenCntLimit() {
    return false;
  }

  // 関連tprxソース: tprx\src\lib\cm_ean\cdigit.c - short cm_cdigit_Tpoint(char *id16)
  static int cmCdigitTpoint(String id16) {
    return 0;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcfncchk.c - bool rcSG_Check_EndCrdt_Mode(void)
  static bool rcSGCheckEndCrdtMode() {
    return false;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcfncchk.c - bool rcSG_Check_UseCrdt_Mode(void)
  static bool rcSGCheckUseCrdtMode() {
    return false;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcky_extkey.c - char  rcKyExtKey_Disp_Posi( void )
  static int rcKyExtKeyDispPosi() {
    return 0;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcky_extkey.c - EXTKY_TYPE	rcChk_Ky_ExtKey_DispType(void)
  static ExtkyType rcChkKyExtKeyDispType() {
    return ExtkyType.EXTKY_NON;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcky_langchg.c - short rcky_langchg_use_check(void)
  static int rckyLangchgUseCheck() {
    return 0;
  }

  // 関連tprxソース: tprx\src\regs\checker\rc_repica.c - short	rcChk_Repica_barScantyp( void )
  static int rcChkRepicaBarScantyp() {
    return 0;
  }

  // 関連tprxソース: tprx\src\regs\checker\rc_preca.c - short rxChk_CHACHK_CrdtTyp(RX_COMMON_BUF *C_BUF, short crdt_typ)
  static int rxChkCHACHKCrdtTyp(RxCommonBuf cBuf, SPTEND_STATUS_LISTS crdtTyp) {
    return 0;
  }

  // 関連tprxソース: tprx\src\regs\checker\rc_repica.c - bool	rcChk_Repica_cocona_Card(void)
  static bool rcChkRepicaCoconaCard() {
    return false;
  }

  // 関連tprxソース: tprx\src\regs\checker\rc_acracb.c - short rcAcrAcb_StockUpdate(short pop)
  static int rcAcrAcbStockUpdate(int pop) {
    return 0;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcqc_dsp.c - void	rcQC_Check_Change_Info(void)
  static void rcQCCheckChangeInfo() {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcqc_dsp.c - void	rcQC_Change_Lack_Proc(void)
  static void rcQCChangeLackProc() {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcsyschk.c - short	rcsyschk_VFHD_happy_self_system(void)
  static int rcsyschkVFHDHappySelfSystem() {
    return 0;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcmbrcom.c  - void rc28Fip_SetTabData(int tab_num)
  static void rc28FipSetTabData(int tabNum) {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcsyschk.c - rcChk_2800_AllFip_SameDisp
  static bool rcChk2800AllFipSameDisp() {
    return false;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcsyschk.c - short rcChk_2800_SubFip_Cnct(void)
  static int rcChk2800SubFipCnct() {
        return 0;
  }

  // 関連tprxソース: tprx\src\regs\checker\rc_28fip.c - void Fip_Flush(char fip_no, char *buf_line1, char *buf_line2, char *buf_line3)
  static void fipFlush(int fipNo, String bufLine1, String bufLine2, String bufLine3) {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcitmdsp.c　‐　void rcDspManualMMCnt_LCD(short dspflg)
  static void rcDspManualMMCntLCD(int dspflg) {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcky_tab.c - short rcPrg_Ky_TabSuspend(void)
  static int rcPrgKyTabSuspend() {
        return 0;
  }
  // 関連tprxソース: tprx\src\regs\checker\rcmcard_dsp.c - rcMember_Get_ProcStep
  static int rcMemberGetProcStep() {
        return 0;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcmcard_dsp.c - int	rcMember_Rtn_funcCode(void)
  static int rcMemberRtnFuncCode() {
        return 0;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcmbrkymbr.c - short	rcMbr_ChkWaitMsg( void )
  static int rcMbrChkWaitMsg() {
    return 0;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcmbrkymbr.c - void	rcMbr_ProcWaitMsg( short flg )
  static void rcMbrProcWaitMsg(int flg) {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcmbrkymbr.c - void	rcMbr_ProcCpnMsg( short flg )
  static void rcMbrProcCpnMsg(int flg) {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcmbr_custdsp.c - void	rcmbr_custbmp_Draw(int kind)
  static void rcmbrCustbmpDraw(int kind) {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcmbrkymbr.c - void	rcMbr_ProcCmplntMsg(void)
  static void rcMbrProcCmplntMsg() {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcmbrkymbr.c - short	rcMbr_ChkBuyHist(void)
  static int rcMbrChkBuyHist() {
        return 0;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcfncchk.c - bool rcCheck_MemberCardMode(void)
  static bool rcCheckMemberCardMode() {
        return false;
  }

  // 関連tprxソース: tprx\src\regs\checker\rcmcard_dsp.c - void	rcMcard_BuyHistFlg_Set(int flg)
  static void rcMcardBuyHistFlgSet(int flg) {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcky_buy_hist.c - void	rcky_buy_hist_proc(int call)
  static void rckyBuyHistProc(int call) {
  }

  // 関連tprxソース: tprx\src\regs\checker\rcmbrkymbr.c - void	rcMbr_ProcTargetMsg( void )
  static void rcMbrProcTargetMsg() {
  }

  // tprx\src\regs\checker\rcfncchk.c - bool rcCheck_ScnMbrMode(void)
  static bool rcCheckScnMbrMode() {
    return true;
  }

  // tprx\src\regs\checker\rc_regsret.c - short rc_regsret_TimerRemove(short clrflg)
  static bool rcRegsretTimerRemove(int clrflg) {
    return true;
  }

  // tprx\src\regs\checker\Regs_Preset.c- void rcReverse_Btn_Proc(void)
  static void rcReverseBtnProc() {
  }

  // tprx\src\regs\checker\Regs_Preset.c - void rcPreset_Btn_First(void)
  static void rcPresetBtnFirst() {
  }

  // tprx\src\regs\checker\rc_ifevent.c - void chk_display_time_offline(void)
  static void chkDisplayTimeOffline() {
  }

  // tprx\src\regs\checker\rcitmdsp.c - void rcItem_Disp_FIP(char fip_no)
  static void rcItemDispFIP(int fipNo) {
  }

  // tprx\src\regs\checker\rc_59dsp.c - void	rc59_Rct_OnOff_Dsp ( Subttl_Info *pSubttl )
  static void rc59RctOnOffDsp(SubttlInfo? pSubttl) {
  }

  // tprx\src\regs\checker\rc_59dsp.c - void	rc59_Floating_Preset_Refresh ( void )
  static void rc59FloatingPresetRefresh() {
  }

  // tprx\src\regs\common\rxmbrcom.c - short	rxmbrcom_ChkTpointRead(REGSMEM *regsmem)
  static bool rxmbrcomChkTpointRead(RegsMem regsmem) {
    return true;
  }

  // tprx\src\regs\checker\rcitmdsp.c - short rcMultiSuica_Mark_Chk(void)
  static bool rcMultiSuicaMarkChk() {
    return true;
  }

  // tprx\src\regs\checker\rcitmdsp.c - void rcDspMbrmk_LCD(void)
  static void rcDspMbrmkLCD() {
  }

  // tprx\src\regs\checker\rc_28dsp.c - void	rc28Mbr_Clear_Disp( MbrDispData *MbrParts )
  static void rc28MbrClearDisp(MbrDispData mbrParts) {
  }

  // tprx\src\regs\checker\rcitmdsp.c - void rc_CustMsgDsp(int flg, Subttl_Info *pSubttl)
  static void rcCustMsgDsp(int flg, SubttlInfo? pSubttl) {
  }

  // tprx\src\regs\checker\rc_28dsp.c - void	rcMbrInfo_Icon_Disp( int zoom_flg, Subttl_Info *pSubttl, int clrFlg )
  static void rcMbrInfoIconDisp(int zoomFlg, SubttlInfo? pSubttl, int clrFlg) {
  }

  // tprx\src\regs\checker\rcmbrcom.c - void rcmbrClearModeDisp(void)
  static void rcmbrClearModeDisp() {
  }

  // tprx\src\regs\checker\rckyselpluadj.c - bool rcky_SelPluAdj_SelctMode(void)
  static bool rckySelPluAdjSelctMode() {
    return true;
  }

  // tprx\src\regs\checker\rckydisburse.c - extern void rcky_disburse_conf(void)
  static void rckyDisburseConf() {
  }

  // tprx\src\regs\checker\rckyselpluadj.c - extern void rcky_selpluadj_conf(void)
  static void rckySelpluadjConf() {
  }

  // tprx\src\regs\checker\rc_28dsp.c - void	rc28dsp_rcpt_btn_destroy(Subttl_Info *pSubttl)
  static void rc28dspRcptBtnDestroy(SubttlInfo pSubttl) {
  }

  // tprx\src\regs\checker\rc_28dsp.c - void	rc_ModeFrameDisp( int clearFlg )
  static void rcModeFrameDisp(int clearFlg) {
  }

  // tprx\src\regs\checker\rcsyschk.c - short	rc_Check_ScanDlg(void)
  static bool rcCheckScanDlg() {
    return true;
  }

  // tprx\src\regs\checker\rc_obr.c - extern void rcScan_Lay_Enable(void)
  static void rcScanLayEnable() {
  }

  // tprx\src\regs\checker\rcky_extkey.c - void rcKyExtKey_Quit( Subttl_Info *pSubttl )
  static void rcKyExtKeyQuit(SubttlInfo pSubttl) {
  }
  // tprx\src\regs\checker\rcitmdsp.c - void rc_CustMsg_StlDestroy(Subttl_Info *pSubttl)
  static void rcCustMsgStlDestroy(SubttlInfo pSubttl) {
  }
  // tprx\src\regs\checker\rcky_qctckt.c - void	rcClearStlPopUpQcTckt( void )
  static void rcClearStlPopUpQcTckt() {
  }
  // tprx\src\regs\checker\rcky_chgstatus.c - void rcky_chgstatus_Destroy_Subttl(void)
  static void rckyChgstatusDestroySubttl() {
  }
}
