/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/*
 *   set_jinf.dart - Common Functions for JAN Code
 *   original code : set_jinf.c
 */

/*----------------------------------------------------------------------*
 * Include files
 *----------------------------------------------------------------------*/

import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';

//C:\Users\koidnori\StudioProjects\pos_flutter_14\flutter_pos\lib\app\lib\cm_jan\set_jinf.dart
import '../apllib/recog.dart';
import 'dsc_plu.dart';
import '../cm_ean/mk_cdig.dart';
import '../../sys/regs/rmmain.dart';
import '../../inc/lib/ean.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/lib/jan_inf.dart';
import '../../common/cmn_sysfunc.dart';
import '../../lib/cm_jan/customercard_jan.dart';
import '../../lib/cm_jan/depoinplu_jan.dart';
import '../../lib/cm_jan/jan.dart';
import '../../lib/cm_jan/mbr.dart';
import '../../lib/cm_jan/gs1.dart';
import '../../lib/cm_jan/pbchg_jan.dart';
import '../../lib/cm_jan/rcpt_bar.dart';
import '../../lib/cm_jan/svstckt_bar.dart';
import '../../lib/cm_jan/card_forget_ws.dart';
import '../../inc/apl/compflag.dart';
import '../../lib/cm_jan/sale_lmt.dart';
import '../../lib/cm_jan/reserv_jan.dart';
import '../../lib/cm_jan/clk_jan.dart';
import '../../lib/cm_jan/plu6.dart';
import '../../lib/cm_jan/non_plu.dart';
import '../../lib/cm_jan/pcd.dart';
import '../../lib/cm_jan/itf_jan.dart';
import '../../lib/cm_jan/dbl_jan.dart';
import '../../lib/cm_jan/prod_jan.dart';
import '../../lib/cm_jan/bok_jan.dart';
import 'mag_jan.dart';

const int NG = 1;
const int OK = 0;

class SetJinf {

  /*----------------------------------------------------------------------*
   * Programs
   *----------------------------------------------------------------------*/
  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: set_jinf.c - jan_cd
  static void janCd(JANInf Ji,int zeroMkCdigit){

  }
  // static void jan_cd(JAN_inf *Ji, short zero_mk_cdigit)
  // {
  // if(!cm_chk_mk_cdigit(Ji->Code,1)) {
  // /* automaticaly make check-digit error ? */
  // Ji->Type = JANtype_ILL_CD;     /* check-digit error */
  // }
  // }
  //
  // static void jan_cd_variable(JAN_inf *Ji, short zero_mk_cdigit, short digit)
  // {
  // if(!cm_chk_mk_cdigit_variable(Ji->Code,1, digit)) {
  // /* automaticaly make check-digit error ? */
  // Ji->Type = JANtype_ILL_CD;  /* check-digit error */
  // }
  // }
  //
  // #if 0
  // extern void cm_set_jan_inf(JAN_inf *Ji, short zero_mk_cdigit)
  // {
  // set_jan(Ji, 0, zero_mk_cdigit);
  // return;
  // }
  //
  // extern void cm_set_jan_infA(JAN_inf *Ji)
  // {
  // set_jan(Ji, 1);
  // return;
  // }
  // #endif
  //
  // static int chk_zero0(char *dst, int size)
  // {
  // int digit;
  //
  // for(digit = size; size > 0; size--, dst++) {
  // if(*dst != '0')
  // break;
  // digit--;
  // }
  // return(digit);
  // }
  //
  //

  ///関連tprxソース: set_jinf.c - cm_set_jan_inf
  static Future<void> cmSetJanInf(JANInf Ji, int JanInfFlag, int zeroMkCdigit) async{
    await cmSetJanInfCom(Ji, JanInfFlag, zeroMkCdigit, 1);
  }

  // extern void cm_set_jan_inf(JAN_inf *Ji, short JanInfFlag, short zero_mk_cdigit)
  // {
  // cm_set_jan_inf_com(Ji, JanInfFlag, zero_mk_cdigit, 1);
  // }
  //
  // /**********************************************************************
  //     関数：cm_set_jan_inf_upc_e_ignore()
  //     機能：JAN情報設定（UPC-Eの判別は無視する）
  //     引数：
  //     戻値：なし
  //  ***********************************************************************/
  // extern	void	cm_set_jan_inf_upc_e_ignore(JAN_inf *Ji, short JanInfFlag, short zero_mk_cdigit)
  // {
  // cm_set_jan_inf_com(Ji, JanInfFlag, zero_mk_cdigit, 0);
  // }
  //

  /// cmSetJanInfCom
  /// 機能：JAN情報設定処理
  ///関連tprxソース: rcsyschk.c - cm_set_jan_inf_com
  static Future<void> cmSetJanInfCom(
      JANInf Ji, int JanInfFlag, int zeroMkCdigit, int upcEFlag) async{
    int janSize;
    int digit;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;

    // rxMemPtr(RXMEM_COMMON, (void **)&pCom);  【dart置き換え時コメント】共有メモリのポインタセットの為、何もしない
    Ji.type = JANInfConsts.JANtype; /* set initial type */

    janSize = Ji.code.length;
    Ji.flag = '';
    digit = chkZero0(Ji.code, janSize);

    /*--------------------------------------------------------------------------------------*
    * Ji->Codeが切られているため、チェックデジットチェックにてエラーにしたくない条件を列記
    * 他のバーコードチェックにてCallされているため、処理を中断する
    * 尚、CODE128のフラグなし13桁にてJANtype_RESERVがセットされるため、処理順を気を付けること
    *--------------------------------------------------------------------------------------*/
    if(await chkJanInfOth(Ji,janSize)){
      Ji.type = JANInfConsts.JANtype;
      Ji.format = 0;
      return;
    }else{
      if(Ji.type != JANInfConsts.JANtype){
        return;
      }
    }

    if(nw7ChkLawson(Ji,janSize) == 0){///  TODO:00007 梶原 中身の実装が必要
      return;
    }

    if(cmChkDpoint(Ji,janSize) == 0){///  TODO:00007 梶原 中身の実装が必要
      return;
    }

    if(await CmCksys.cmDcmpointSystem() == 1){
      Mbr.cmDcmMbr(Ji, janSize);///  TODO:00007 梶原 中身の実装が必要
      if(Ji.type == JANInfConsts.JANtypeMbr13){
        return;
      }
    }
    Gs1.cmGs1(Ji);///  TODO:00007 梶原 中身の実装が必要
    if(Ji.type == JANInfConsts.JANtypeGs1){
      return;
    }
    PbchgJan.cmPbchg(Ji);///  TODO:00007 梶原 中身の実装が必要
    if(Ji.type == JANInfConsts.JANtypePbchg){
      return;
    }

    RcptBar.cmRcptBar(Ji, 2);///  TODO:00007 梶原 中身の実装が必要
    if(Ji.type == JANInfConsts.JANtypeRcptBar26){ // JANtype_RCPT_BAR_26
      return;
    }

    SvstcktBar.cmSvsTcktBar(Ji, 2);///  TODO:00007 梶原 中身の実装が必要
    if(Ji.type == JANInfConsts.JANtypeSvstckt){ // サービス券バーコード
      return;
    }

    CardForgetWs.cmCardForgetWsJan(Ji, 2);///  TODO:00007 梶原 中身の実装が必要
    if(Ji.type == JANInfConsts.JANtypeCardforgetWs){ // WS様向けカード忘れバーコード
      return;
    }
    if (CompileFlag.SALELMT_BAR){
      if(await CmCksys.cmSallLmtbar26System() == 1){
        SaleLmt.cmSalelmt(Ji, 2);///  TODO:00007 梶原 中身の実装が必要
      }
    }

    if(CompileFlag.RESERV_SYSTEM){
      if(CompileFlag.SALELMT_BAR){
        if(Ji.type != JANInfConsts.JANtypeSalelmt26){
          ReservJan.cmReserv(Ji); ///  TODO:00007 梶原 中身の実装が必要
          if(Ji.type == JANInfConsts.JANtypeReserv){
            return;
          }
        }
      }
    }
    if(nw7Chk13Mbr(Ji,digit) == 0){ ///  TODO:00007 梶原 中身の実装が必要
      return;
    }

    if(upcEFlag == 0){
      if((digit == 5) || (digit == 6)){
        digit = upcECd(Ji, digit);  ///  TODO:00007 梶原 中身の実装が必要
      }
    }

    switch(digit){
      case  1:
      case  2:
      case  3:
      case  4:
      case  5:
      case  6:
        if(await CmCksys.cmNW7StaffSystem() == 0){
          if(Ji.type == JANInfConsts.JANtype){
            ClkJan.cmClk(Ji, 0);
          }
          if(Ji.type != JANInfConsts.JANtype){
            break;
          }
        }
        if(Ji.type == JANInfConsts.JANtype){
          Plu6.cmPlu6(Ji);
        }
        break;
      case  7:
      case  8:
        if(await CmCksys.cmNW7StaffSystem() == 0){
          if(Ji.type == JANInfConsts.JANtype){
            ClkJan.cmClk(Ji, 0);
          }
          if(Ji.type != JANInfConsts.JANtype){
            break;
          }
          if((CmCksys.cmIKEASystem() != 1) && (pCom.dbTrm.pluDigit == 0)){  /* PLUｺｰﾄﾞ: 6桁 */
            janCd(Ji,zeroMkCdigit); ///  TODO:00007 梶原 中身の実装が必要
          }
        }
        if(Ji.type == JANInfConsts.JANtype){
          Mbr.cmMbr8(Ji, 2);  ///  TODO:00007 梶原 中身の実装が必要
        }
        if(Ji.type == JANInfConsts.JANtype){
          Mbr.cmMbr8(Ji, 1);  ///  TODO:00007 梶原 中身の実装が必要(既出
        }
        if(Ji.type == JANInfConsts.JANtype){
          NonPlu.cmNonPlu8(Ji, 1);  ///  TODO:00007 梶原 中身の実装が必要
        }
        if(Ji.type == JANInfConsts.JANtype){
          Jan.cmJan8(Ji);
        }
        if(! Pcd.cmChkPcd(Ji)){ ///  TODO:00007 梶原 中身の実装が必要
          Ji.type = JANInfConsts.JANtypeIllPcd;
        }
        break;
      case  9:
      case 10:
      case 11:
      case 12:
      case 13:
        if(await CmCksys.cmNW7StaffSystem() == 1){  //従業員９桁まで
          if(Ji.type == JANInfConsts.JANtype){
            ClkJan.cmClk(Ji, 0);
          }
          if(Ji.type != JANInfConsts.JANtype){
            break;
          }
        }
        if(Ji.type == JANInfConsts.JANtype){
          ItfJan.cmItf(Ji, 3);  ///  TODO:00007 梶原 中身の実装が必要
        }
        if(Ji.type == JANInfConsts.JANtype){
          ItfJan.cmItf(Ji, 1);  ///  TODO:00007 梶原 中身の実装が必要
        }
        if(Ji.type != JANInfConsts.JANtype){
          break;
        }
        if(Ji.code.substring(0,1) != 'N'){   //     if((char)Ji->Code[0] != 'N')
          janCd(Ji,zeroMkCdigit); ///  TODO:00007 梶原 中身の実装が必要
        }
        if(CompileFlag.CLOTHES_BARCODE){
          if(await clothesSysChk() == 1){
            if(Ji.type == JANInfConsts.JANtype){
              DblJan.cmDblJan26(Ji, 2, 4);
            }
          }
        }
        if(Ji.type == JANInfConsts.JANtype){
          ProdJan.cmProd(Ji, 1); ///  TODO:00007 梶原 中身の実装が必要
        }
        if(Ji.type == JANInfConsts.JANtype){
          ProdJan.cmProd(Ji, 2); ///  TODO:00007 梶原 中身の実装が必要
        }
        if(Ji.type == JANInfConsts.JANtype){
          BokJan.cmBokJan26(Ji, 3); ///  TODO:00007 梶原 中身の実装が必要
        }
        if(Ji.type == JANInfConsts.JANtype){
          Mbr.cmMbr13(Ji, 2); ///  TODO:00007 梶原 中身の実装が必要
        }
        if(Ji.type == JANInfConsts.JANtype){
          ClkJan.cmClk(Ji, 2);
          if(Ji.type == JANInfConsts.JANtypeClerk){
            clkNumChg(Ji);  ///  TODO:00007 梶原 中身の実装が必要
          }
        }
        if(Ji.type == JANInfConsts.JANtype){
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_non_plu13(Ji,2);
        }
        if(Ji.type == JANInfConsts.JANtype){
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_wgt_plu13(Ji,2);
        }
        if(Ji.type == JANInfConsts.JANtype){
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_mag_jan13(Ji,2);
        }
        if(Ji.type == JANInfConsts.JANtype){
          if (newMagSysChk() != 0) {
            await MagJan.cmMagJan18(Ji, 3);
          }
        }
        if(Ji.type == JANInfConsts.JANtype){
          await DscPlu.cmDscPlu(Ji, 2);
        }
        if(Ji.type == JANInfConsts.JANtype){
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_prom(Ji,2);
        }
        if(CompileFlag.ITF18_BARCODE){
          if(Ji.type == JANInfConsts.JANtype){
            ///  TODO:00007 梶原 関数の作成と中身の実装が必要
            //     cm_itf18(Ji, 2);
          }
        }
        if(Ji.type == JANInfConsts.JANtype){
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_non_plu13(Ji,1);
        }
        if(Ji.type == JANInfConsts.JANtype){
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_wgt_plu13(Ji,1);
        }
        if(Ji.type == JANInfConsts.JANtype){
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_mbl(Ji,2);
        }
        if(CompileFlag.CATALINA_SYSTEM){
          if(Ji.type == JANInfConsts.JANtype){
            ///  TODO:00007 梶原 関数の作成と中身の実装が必要
            //     cm_ctln(Ji,4);
          }
        }
        if(CompileFlag.ITF18_BARCODE){
          if(Ji.type == JANInfConsts.JANtype){
            ///  TODO:00007 梶原 関数の作成と中身の実装が必要
            //     cm_itf18(Ji, 1);
          }
        }
        if(CompileFlag.GRAMX){
          if(Ji.type == JANInfConsts.JANtype){
            ///  TODO:00007 梶原 関数の作成と中身の実装が必要
            //     cm_gx(Ji,2);
          }
        }
        if(CompileFlag.DEPARTMENT_STORE){
          if(Ji.type == JANInfConsts.JANtype){
            ///  TODO:00007 梶原 関数の作成と中身の実装が必要
            //     cm_prctag(Ji,2);
          }
          if(Ji.type == JANInfConsts.JANtype){
            ///  TODO:00007 梶原 関数の作成と中身の実装が必要
            //     cm_giftcard(Ji,2);
          }
          if(Ji.type == JANInfConsts.JANtype){
            ///  TODO:00007 梶原 関数の作成と中身の実装が必要
            //     cm_preset(Ji,2);
          }
          if(Ji.type == JANInfConsts.JANtype){
            ///  TODO:00007 梶原 関数の作成と中身の実装が必要
            //     cm_non_plu13(Ji,2);
          }
        }
        ///  TODO:00007 梶原 関数の作成と中身の実装が必要
        //     if( cm_RainbowCard_system() ){
          if (Ji.type == JANInfConsts.JANtype) {
            ///  TODO:00007 梶原 関数の作成と中身の実装が必要
            //     cm_coupon(Ji,2);
          }
        //     }
        if(CompileFlag.SALELMT_BAR) {
          if (Ji.type == JANInfConsts.JANtype) {
            ///  TODO:00007 梶原 関数の作成と中身の実装が必要
            //     cm_salelmt(Ji,2);
          }
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_funckey(Ji,2);
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_ticket(Ji,2);
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_drugRev(Ji,2);
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_pntshift_bar(Ji,2);
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_benefit_coupon(Ji,2);
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_card_forget(Ji,2);
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_komeri_jan(Ji,2);
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_sp_dept_jan(Ji,2);
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_netDoArsv_jan(Ji, 2);
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_QC_PluAdd_jan(Ji, 2);
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_cosmos_jan(Ji, 2);
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_stfdiscnt(Ji, 2);		/* 2014/08/25 従業員割引バーコード対応 */
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_ayaha_gift_point(Ji,2);
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_Tcoupon_jan(Ji,2);
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_Hinken_bar (Ji, 2);
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_OnetoOne_jan(Ji, 2);
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_DepoBtlId_jan(Ji, 2);
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_ChargeSlip_jan(Ji, 2);
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_AccountReceivable_jan(Ji, 2);
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_mente_jan(Ji, 2);
        }
        if (Ji.type == JANInfConsts.JANtype) {
          ///  TODO:00007 梶原 関数の作成と中身の実装が必要
          //     cm_jan13(Ji);
        }
        break;
      case 19:
        if(CmCksys.cmIKEASystem() == 1){
          if (Ji.type == JANInfConsts.JANtype) {
            ///  TODO:00007 梶原 関数の作成と中身の実装が必要
            //     CODE39_MbrCode_IKEA(Ji);
          }
        }
        break;
      default:
      ///  TODO:00007 梶原 関数の作成と中身の実装が必要
        //     jan_cd_variable(Ji, zero_mk_cdigit, digit);
        if (Ji.type == JANInfConsts.JANtype) {
          Mbr.cmMbr13(Ji, 2); ///  TODO:00007 梶原 中身の実装が必要
        }
        if (Ji.type == JANInfConsts.JANtype) {
          Ji.type = JANInfConsts.JANtypeIllegal;   /* set illegal type */
        }
        break;
    }
  }

  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: set_jinf.c - upc_e_cd
  static int upcECd(JANInf Ji,int digit){
    return 0;
  }

  // extern
  // bool cm_chk_price_barcode (uchar AscPluCd[], short zero_mk_cdigit)
  // {
  // JAN_inf tJAN_inf;
  // short   size;
  //
  // cm_clr((char *)&tJAN_inf, sizeof(tJAN_inf));
  // //   cm_mov((char *)&tJAN_inf.Code[0], (char *)AscPluCd, sizeof(tJAN_inf.Code));
  // size = (sizeof(tJAN_inf.Code) <= strlen((char *)AscPluCd)) ? sizeof(tJAN_inf.Code) - 1 : strlen((char *)AscPluCd);
  // cm_mov((char *)&tJAN_inf.Code[0], (char *)AscPluCd, size);
  // cm_set_jan_inf(&tJAN_inf,0,zero_mk_cdigit);
  //
  // switch(tJAN_inf.Type) {
  // case JANtype_NON_PLU8:
  // case JANtype_NON_PLU13:
  // case JANtype_WEIGHT_PLU13:
  // case JANtype_MAGAZINE13:
  // case JANtype_BOOK26_1:
  // case JANtype_BOOK26_2:
  // #if    SALELMT_BAR
  // case JANtype_SALELMT_1:
  // #endif
  // return(TRUE);
  // default:
  // break;
  // }
  // return(FALSE);
  // }
  //
  // static char NW7_7Typ_cd(uchar *code)
  // {
  // char cd;
  // long long value;
  //
  // value = atoll((char *)code);
  //
  // cd = value % 7;
  // return cd;
  // }
  //
  //
  // static void  CODE39_MbrCode_IKEA(JAN_inf *Ji)
  // {
  // //	char tmp_buf[44+1];       /* JAN code(ASCII) */
  //
  // if(strncmp(Ji->Code, "627598034", 9) == 0){
  // #if 0
  // /* ここで会員番号を編集すると編集後の番号にて再度set_jinfを通されることがあり、
  // 		   その際エラーになってしまうため顧客ファイル読み込み直前の編集とした */
  // memset(tmp_buf, 0x0, sizeof(tmp_buf));
  // strncpy(tmp_buf, Ji->Code, sizeof(tmp_buf));
  // memset(Ji->Code, 0x0, sizeof(Ji->Code));
  // strncpy(Ji->Code, &tmp_buf[9], 10);
  // #endif
  // Ji->Type = JANtype_MBR19_IKEA;
  // }
  // }
  //
  // static short upc_e_cd(JAN_inf *Ji, short digit)
  // {
  // char euc_a[ASC_EAN_13];
  // char x6;
  // //   char Code2Flag[2];
  // short jan_size;
  // RX_COMMON_BUF *pCom;
  //
  // if (rxMemPtr(RXMEM_COMMON, (void **)&pCom) != RXMEM_OK) {
  // TprLibLogWrite(0, TPRLOG_ERROR, -1, "upc_e_cd rxMemPtr COMMON get error!!\n");
  // return digit;
  // }
  // if(!(pCom->db_trm.chg_upce_upca))
  // return digit;
  //
  // if(strncmp(Ji->Code, "0000000999999", 13) == 0)
  // return digit;
  //
  // cm_mov(euc_a,"0000000000000",sizeof(euc_a));
  // x6 = (Ji->Code[12] - 0x30);
  // switch(x6) {
  // case 0:
  // case 1:
  // case 2:
  // euc_a[2] = Ji->Code[7];
  // euc_a[3] = Ji->Code[8];
  // euc_a[4] = Ji->Code[12];
  // euc_a[9] = Ji->Code[9];
  // euc_a[10] = Ji->Code[10];
  // euc_a[11] = Ji->Code[11];
  // break;
  // case 3:
  // euc_a[2] = Ji->Code[7];
  // euc_a[3] = Ji->Code[8];
  // euc_a[4] = Ji->Code[9];
  // euc_a[10] = Ji->Code[10];
  // euc_a[11] = Ji->Code[11];
  // break;
  // case 4:
  // euc_a[2] = Ji->Code[7];
  // euc_a[3] = Ji->Code[8];
  // euc_a[4] = Ji->Code[9];
  // euc_a[5] = Ji->Code[10];
  // euc_a[11] = Ji->Code[11];
  // break;
  // case 5:
  // case 6:
  // case 7:
  // case 8:
  // case 9:
  // euc_a[2] = Ji->Code[7];
  // euc_a[3] = Ji->Code[8];
  // euc_a[4] = Ji->Code[9];
  // euc_a[5] = Ji->Code[10];
  // euc_a[6] = Ji->Code[11];
  // euc_a[11] = Ji->Code[12];
  // break;
  // }
  // if(!cm_chk_mk_cdigit(euc_a, 1)) { /* automaticaly make check-digit error ? */
  // Ji->Type = JANtype_ILL_CD;     /* check-digit error */
  // }
  // else {
  // memset(Ji->Code, 0x0, sizeof(Ji->Code));
  // strncpy(Ji->Code, euc_a, sizeof(euc_a));
  // jan_size = (sizeof(Ji->Code) <= strlen(Ji->Code)) ? sizeof(Ji->Code) - 1 : strlen(Ji->Code);
  // cm_clr(&Ji->Flag[0], sizeof(Ji->Flag));
  // digit = chk_zero0(Ji->Code, jan_size);
  // #if 0
  // cm_mov(Code2Flag,&Ji->Code[5], sizeof(Code2Flag));
  // Ji->Flag = (short)atoi(Code2Flag);
  // Ji->Type = JANtype_UPC_E;
  // Ji->Format = 99;
  // Ji->Price = 0L;
  // #endif
  // }
  // return digit;
  // }

  /// 関連tprxソース: set_jinf.c - cm_mk_dsc_code()
  static int cmMkDscCode(Code128_inf C128i) {
    String Code128_plus = "";  // [ASC_EAN_26+1];
    int ret = NG;

    if (DscPlu.cmDscPlu1(C128i) == NG) {
      return ret;
    }
    if (DscPlu.cmDscPlu2(C128i) == NG) {
      return ret;
    }
    if ((C128i.digit >= 9) && (C128i.digit <= 20)) {
      Code128_plus = '0' * (20 - C128i.digit)
                   + C128i.Org_Code.substring(0, C128i.digit);
    } else {
      return ret;
    }
    C128i.Code1 = C128i.Code1 + Code128_plus.substring(0, 0 + 10);
    C128i.Code1 += ('0' * (Ean.ASC_EAN_13 - C128i.Code1.length));
    C128i.Code2 = C128i.Code2 +
        Code128_plus.substring(10, 10 + 3) +
        "0" +
        Code128_plus.substring(13, 13 + 6);
    C128i.Code2 += ('0' * (Ean.ASC_EAN_13 - C128i.Code2.length));
    C128i.Code1 = MkCdig.cmMkCdigit(C128i.Code1);
    C128i.Code2 = MkCdig.cmMkCdigit(C128i.Code2);

    return OK;
  }

  // #if CLOTHES_BARCODE
  // static int clothes_sys_chk(void)
  // {
  // RX_COMMON_BUF *pCom;
  // int		recog = 0;
  //
  // /* 記メモリポインタ*/
  // if (rxMemPtr(RXMEM_COMMON, (void **)&pCom) != RXMEM_OK) {
  // return 0;
  // }
  // if( recog_get(TPRAID_SYSTEM, RECOG_CLOTHES_BARCODE, RECOG_GETMEM) ) {
  // recog = 1;
  // }
  // return ( recog );
  // }
  // #endif

  ///関連tprxソース: set_jinf.c - newmag_sys_chk
  static int newMagSysChk() {
    return 1;
  }

  //#if SALELMT_BAR
  static int cmMkSallmtdscCode(Code128_inf C128i) {
    String Code128_plus = "";  // [ASC_CODE128_28+1];
    int result = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);

    result = NG;
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "cmMkSallmtdscCode rxMemPtr COMMON get error!!\n");
      return result;
    }
    RxCommonBuf pCom = xRet.object;
    if (DscPlu.cmDscPlu1(C128i) == NG) {
      return result;
    }
    if (DscPlu.cmDscPlu2(C128i) == NG) {
      return result;
    }
    if ((C128i.digit >= 16) && (C128i.digit <= 28)) {
      Code128_plus = '0' * (28 - C128i.digit)
                   +  C128i.Org_Code_SalLmt.substring(0, C128i.digit);
    } else {
      return result;
    }
    C128i.Code1 = C128i.Code1 + Code128_plus.substring(0, 10);
    C128i.Code2 = C128i.Code2 + Code128_plus.substring(10, 10 + 3);


    if (pCom.dbTrm.discBarcode28d != 0) {
      C128i.Code2 += Code128_plus.substring(21, 21 + 6);
    } else {
      C128i.Code2 += Code128_plus.substring(13, 13 + 6);
      C128i.SalLmtDay = Code128_plus.substring(20, 20 + 8);
    }
    C128i.Code1 += ('0' * (Ean.ASC_EAN_13 - C128i.Code1.length));
    C128i.Code2 += ('0' * (Ean.ASC_EAN_13 - C128i.Code2.length));
    C128i.Code1 = MkCdig.cmMkCdigit(C128i.Code1);
    C128i.Code2 = MkCdig.cmMkCdigit(C128i.Code2);

    return OK;
  }
  //#endif

  // タック様仕様: 26桁販売期限バーコード
  static int cmMkSallmtdscCodeLength26(Code128_inf C128i) {
    String Code128_plus = ""; // [ASC_CODE128_28+1];
    int result = NG;

    if(DscPlu.cmDscPlu1(C128i) == NG) {
      return result;
    }
    if(DscPlu.cmDscPlu2(C128i) == NG) {
      return result;
    }

    if((C128i.digit >= 16) && (C128i.digit <= 26)) {
      Code128_plus = C128i.Org_Code_SalLmt.substring(0, C128i.digit);
    } else {
      return result;
    }
    C128i.Code1 = C128i.Code1 + Code128_plus.substring(0, 0 + 10);
    C128i.Code2 = C128i.Code2 + Code128_plus.substring(10, 10 + 3)
                              + Code128_plus.substring(19, 19 + 6);
    C128i.SalLmtDay = Code128_plus.substring(13, 13 + 6);
    C128i.Code1 += ('0' * (Ean.ASC_EAN_13 - C128i.Code1.length));
    C128i.Code2 += ('0' * (Ean.ASC_EAN_13 - C128i.Code2.length));
    C128i.Code1 = MkCdig.cmMkCdigit(C128i.Code1);
    C128i.Code2 = MkCdig.cmMkCdigit(C128i.Code2);

    return OK;
  }

  // original comment.
  // /*-----------------------------------------------------------------------------------------------*
  //  *  関数: chk_jan_inf_oth()
  //  *        フラグチェック等にてType確定->桁が想定と異なる->渡されたCodeは桁を切られたものと判断
  //  *        つまり他のバーコードチェックにてCallされたと判断する関数
  //  *  引数: short jan_size	Codeのlength
  //  *  戻値: TRUE:自バーコードでない。 FALSE:自バーコードである。
  //  *-----------------------------------------------------------------------------------------------*/
  ///関連tprxソース: set_jinf.c - chk_jan_inf_oth
  static Future<bool> chkJanInfOth(JANInf Ji, int janSize) async {
    if (await CmCksys.cmWizAbjSystem() == 1) {
      if (Ji.type == JANInfConsts.JANtype) {
        CustomerCardJan.cmCustomerCardJan(Ji, 2);
      }
    }

    if (Ji.type == JANInfConsts.JANtype) {
      DepoinpluJan.cmDepoInPluJan(Ji, 2);
    }

    if (Ji.type == JANInfConsts.JANtype) {
      Jan.cmCashRecycleJan(Ji, 2);
    }

    if (Ji.type == JANInfConsts.JANtype) {
      Jan.cmFreshZFSPJan(Ji, 2);
    }

    switch (Ji.type) {
      case JANInfConsts.JANtypeCustomercard:
        if (janSize != 18) {
          return true;
        }
        break;
      case JANInfConsts.JANformatDepoinplu:
        if (janSize != 18) {
          return true;
        }
        break;
      case JANInfConsts.JANtypeCashRecycleOut:
      case JANInfConsts.JANtypeCashRecycleIn:
      case JANInfConsts.JANtypeCashRecycleInout:
        if (janSize != JanInfDefine.cashRecycleCd) {
          return true;
        }
        break;
      case JANInfConsts.JANtypeFreshZfsp: // 生鮮ZFSP
        if (janSize != JanInfDefine.barSizeFreshZfsp) {
          return true;
        }
        break;
      default:
        return false;
    }
    return false;
  }
  // /*-----------------------------------------------------------------------------------------------*
  //  *  関数: clk_num_chg()
  //  *        従業員バーコードの値を以下のように変換する(西鉄ストア様向け対応)
  //  *        FF ???? IIIIII C/D フォーマットを使用する。
  //  *        FF 0012 345678 C/D > FF 0000 123567 C/D
  //  *  引数: JAN_inf	Ji	バーコード情報
  //  *  戻値: なし
  //  *-----------------------------------------------------------------------------------------------*/
  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: set_jinf.dart - clk_num_chg
  static void clkNumChg(JANInf Ji){

  }
  // static	void	clk_num_chg( JAN_inf *Ji )
  // {
  // char	code_buf[PBCHG_CD_MAX+1];
  // int	cnt;
  // int	start;
  //
  // /* 特定交通系１仕様 確認 */
  // if(!cm_tb1_system())
  // return;
  //
  // /* 従業員番号が６桁以下なら変換しない */
  // start = strlen(Ji->Code)-(8+1);
  // if(strncmp(&Ji->Code[start], "00", 2) == 0)	/* 従業員番号上２桁が"0"か確認する */
  // {
  // return;
  // }
  //
  // cnt = 0;
  // memset( code_buf, 0x0, sizeof(code_buf) );
  // memcpy( &code_buf[cnt], &Ji->Flag[0], Ji->FlagDigit);
  // cnt += Ji->FlagDigit;
  // strncat( code_buf, "0000", 4);
  // cnt += 4;
  // memcpy( &code_buf[cnt], &Ji->Code[4], 3);
  // cnt += 3;
  // memcpy( &code_buf[cnt], &Ji->Code[8], 3);
  // cnt += 3;
  // memcpy( &code_buf[cnt], "0", 1);
  // cm_mk_cdigit(code_buf);
  // memset( &Ji->Code[0], 0x0, sizeof(Ji->Code) );
  // memcpy( &Ji->Code[0], &code_buf[0], strlen(code_buf) );
  //
  // return;
  // }
  //

  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: set_jinf.c - NW7_CHK_13_MBR
  static int nw7Chk13Mbr(JANInf Ji,int janSize){
    return 1;
  }
  // static short NW7_CHK_13_MBR(JAN_inf *Ji, short jan_size)
  // {
  // RX_COMMON_BUF	*pCom;
  // char		Code[15];
  //
  // if (rxMemPtr(RXMEM_COMMON, (void **)&pCom) != RXMEM_OK) {
  // TprLibLogWrite(0, TPRLOG_ERROR, -1, "NW7_CHK_13_MBR rxMemPtr COMMON get error!!\n");
  // return 0;
  // }
  // if(pCom->db_trm.crdt_user_no != 1)
  // return 0;
  //
  // if(jan_size != 14)
  // return 0;
  //
  // if((strchr(Ji->Code, 'N')) != NULL){
  // Ji->Type = JANtype_MBR_NW7_13;
  // return 1;
  // }
  // return 0;
  // }

  /*
   * 関数名　：cmMkDscCode3
   * 機能概要：パレット様仕様: 24桁値引バーコード
   * 呼出方法：cm_mk_dsc_code3(Code128_inf *C128i);
   * 引数　　：Code128_inf *C128
   * 戻り値　：
   */
  static int cmMkDscCode3(Code128_inf C128i) {
    String Code128_plus = ""; // [ASC_EAN_26+1];
    int result = NG;

    if(DscPlu.cmDscPlu1(C128i) == NG) {
      return result;
    }
    if(DscPlu.cmDscPlu2(C128i) == NG) {
      return result;
    }
    if((C128i.digit >= 9) && (C128i.digit <= 24)) {
      Code128_plus = '0' * (24 - C128i.digit) + C128i.Org_Code.substring(0, C128i.digit);
    } else {
      return result;
    }
    C128i.Code1 = C128i.Code1 + Code128_plus.substring(10, 10 + 10);
    C128i.Code2 = C128i.Code2 + Code128_plus.substring(20, 20 + 3);

    if (Code128_plus.substring(2, 2 + 1) == "4") {  	//値下げフラグが「４」の場合でも「３」と同じ動きをさせる
      C128i.Code2 += "3";
    } else {
      C128i.Code2 += Code128_plus.substring(2, 2 + 1);
    }
    C128i.Code2 += Code128_plus.substring(5, 5 + 5);

    /* チェックデジット */
    C128i.Code1 += ('0' * (Ean.ASC_EAN_13 - C128i.Code1.length));
    C128i.Code2 += ('0' * (Ean.ASC_EAN_13 - C128i.Code2.length));
    C128i.Code1 = MkCdig.cmMkCdigit(C128i.Code1);
    C128i.Code2 = MkCdig.cmMkCdigit(C128i.Code2);

    return OK;
  }

  // /*
  //  * 関数名　：cm_chk_dpoint
  //  * 機能概要：バーコード判定処理に渡されたバーコードがdポイントのバーコードか判定する
  //  * 呼出方法：cm_chk_dpoint(&Ji, jan_size);
  //  * 引数　　：JAN_inf *Ji：読み取ったバーコード情報
  //  * 　　　　：short jan_size：読み取り対象バーコード長
  //  * 戻り値　：0:dポイントのバーコードではない
  //  * 　　　　：1:dポイントのバーコード
  //  */
  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: set_jinf.c - cm_chk_dpoint
  static int cmChkDpoint(JANInf Ji,int janSize){
    return 1;
  }
  // static short cm_chk_dpoint(JAN_inf *Ji, short jan_size)
  // {
  // char		log[128];
  // RX_COMMON_BUF	*pCom;
  // char		Code[15+1];
  //
  // memset(log, 0, sizeof(log));
  //
  // if(rxMemPtr(RXMEM_COMMON, (void **)&pCom) != RXMEM_OK)
  // {
  // snprintf(log, sizeof(log), "%s rxMemPtr COMMON get error!!", __FUNCTION__);
  // TprLibLogWrite(TPRAID_NONE, TPRLOG_ERROR, -1, log);
  // return 0;
  // }
  //
  // // dポイント仕様でなければ、dポイントではない判定
  // if(! cm_dpoint_system())
  // {
  // return 0;
  // }
  //
  // // "Nd+カード番号(15桁)+d"の18文字以外なら、dポイントではない判定
  // if(jan_size != DPOINT_CARD_LENGTH+3)
  // {
  // return 0;
  // }
  //
  // // NW7でなければ、dポイントではない判定
  // if(Ji->Code[0] != 'N')
  // {
  // return 0;
  // }
  //
  // // スタートストップキャラクターが'd'、または、'D'でなければ、dポイントではない判定
  // if(!((Ji->Code[1] == 'd') && (Ji->Code[17] == 'd'))
  // && !((Ji->Code[1] == 'D') && (Ji->Code[17] == 'D')))
  // {
  // return 0;
  // }
  //
  // // dポイントのバーコードフォーマットであれば、dポイントカードと判定
  // memset(Code, 0, sizeof(Code));
  // strncpy(Code, &Ji->Code[2], DPOINT_CARD_LENGTH);
  // if(cm_chk_dpoint_cardno(Code))
  // {
  // return 1;
  // }
  //
  // return 0;
  // }
  //
  // /*
  //  * 関数名　：cm_chk_dpoint_cardno
  //  * 機能概要：引数の文字列がdポイントのカード番号か判定する
  //  * 呼出方法：cm_chk_dpoint_cardno(&CardNo);
  //  * 引数　　：char *CardNo：判定対象の文字列
  //  * 戻り値　：0:dポイントのカード番号ではない
  //  * 　　　　：1:dポイントのカード番号
  //  */
  // extern short cm_chk_dpoint_cardno(char *CardNo)
  // {
  // char	assign[4+1];
  // char	work[14+1];
  //
  // // dポイント仕様でなければ、dポイントではない判定
  // if(! cm_dpoint_system())
  // {
  // return 0;
  // }
  //
  // // 桁数チェック
  // if(strlen(CardNo) != DPOINT_CARD_LENGTH)
  // {
  // return 0;
  // }
  //
  // // 数値チェック
  // if(cm_chk_digit(CardNo, DPOINT_CARD_LENGTH) == FALSE)
  // {
  // return 0;
  // }
  //
  // // dポイントカード番号体系チェック
  // if(CardNo[8] != DPNT_CARD_ID)
  // {
  // return 0;
  // }
  //
  // // dポイントカード番号割当チェック
  // memset(assign, 0, sizeof(assign));
  // memcpy(assign, &CardNo[9], sizeof(assign)-1);
  // if(((atoi(assign) < DPNT_ASSIGN_NO1) || (atoi(assign) > DPNT_ASSIGN_NO2))
  // && (atoi(assign) != DCARD_ASSIGN_NO))
  // {
  // return 0;
  // }
  //
  // // チェックデジット判定
  // memset(work, 0, sizeof(work));
  // memcpy(work, CardNo, 13);
  // work[13] = CardNo[14];
  // if(NW7_7Typ_cd((uchar *)work) != (CardNo[13] - '0'))
  // {
  // return 0;
  // }
  //
  // return 1;
  // }
  //

  /// 関数名　：cmMkDscCode2
  /// 機能概要：パレット様仕様: 24桁値引バーコード
  /// 引数　　：Code128_inf C128
  /// 戻り値　：
  static int cmMkDscCode2(Code128_inf C128i) {
    String Code128_plus = "";  //[ASC_EAN_26+1];
    int ret = NG;

    if(DscPlu.cmDscPlu1(C128i) == NG) {
      return ret;
    }
    if(DscPlu.cmDscPlu2(C128i) == NG) {
      return ret;
    }
    if((C128i.digit >= 9) && (C128i.digit <= 22)) {
      Code128_plus = '0' * (22 - C128i.digit)
                   + C128i.Org_Code.substring(0, C128i.digit);
    } else {
      return ret;
    }

    C128i.Code1 = C128i.Code1 + Code128_plus.substring(0, 10);
    C128i.Code2 = C128i.Code2 + Code128_plus.substring(10, 10 + 3)
                              + Code128_plus.substring(14, 14 + 7);
    C128i.Code1 += ('0' * (Ean.ASC_EAN_13 - C128i.Code1.length));
    C128i.Code2 += ('0' * (Ean.ASC_EAN_13 - C128i.Code2.length));
    C128i.Code1 = MkCdig.cmMkCdigit(C128i.Code1);
    C128i.Code2 = MkCdig.cmMkCdigit(C128i.Code2);

    return OK;
  }

  /// chkZero0
  /// 概要:先頭の0を外した状態の文字列長を返す
  /// 引数:先頭0埋めされた数字で構成した文字列 dst
  ///    :dstの文字数 size
  ///関連tprxソース: rcsyschk.c - chk_zero0
  static int chkZero0(String dst, int size) {
    int digit = size;

    for (int i = 0; size > i; i++) {
      if (dst.substring(i, i + 1) != '0') {
        break;
      }
      digit--;
    }
    return digit;
  }

  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: set_jinf.c - NW7_CHK_LAWSON
  static int nw7ChkLawson(JANInf Ji,int janSize){
    return 1;
  }
  // static short NW7_CHK_LAWSON(JAN_inf *Ji, short jan_size)
  // {
  // RX_COMMON_BUF	*pCom;
  // char		Code[15];
  //
  // if (rxMemPtr(RXMEM_COMMON, (void **)&pCom) != RXMEM_OK) {
  // TprLibLogWrite(0, TPRLOG_ERROR, -1, "NW7_CHK_LOWSON rxMemPtr COMMON get error!!\n");
  // return 0;
  // }
  // if(!(pCom->db_trm.loason_nw7mbr))
  // return 0;
  // if(jan_size != 15)
  // return 0;
  // memset(Code, 0x0, sizeof(Code));
  // strncpy(Code, Ji->Code, 14);
  // if((Ji->Code[14] - 0x30) != NW7_7Typ_cd(Code)) {
  // TprLibLogWrite(0, TPRLOG_ERROR, -1, "NW7_CHK_LOWSON NW7_7Typ_cd error!!\n");
  // return 0;
  // }
  // Ji->Type = JANtype_MBR_NW7_L;
  // return 1;
  // }

  ///関連tprxソース: set_jinf.c - clothes_sys_chk
  static Future<int> clothesSysChk() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error,
          "cmSetDblFlag() rxMemRead error");
      return 0;
    }
    RxCommonBuf pCom = xRet.object;
    int recog = 0;

    RecogRetData recogRetData = await Recog().recogGet(
        Tpraid.TPRAID_SYSTEM,
        RecogLists.RECOG_CLOTHES_BARCODE,
        RecogTypes.RECOG_GETMEM);
    if (recogRetData.result != RecogValue.RECOG_NO) {
      recog = 1;
    }
    return recog;
  }
  // static int clothes_sys_chk(void)
  // {
  // RX_COMMON_BUF *pCom;
  // int		recog = 0;
  //
  // /* 記メモリポインタ*/
  // if (rxMemPtr(RXMEM_COMMON, (void **)&pCom) != RXMEM_OK) {
  // return 0;
  // }
  // if( recog_get(TPRAID_SYSTEM, RECOG_CLOTHES_BARCODE, RECOG_GETMEM) ) {
  // recog = 1;
  // }
  // return ( recog );
  // }
}
