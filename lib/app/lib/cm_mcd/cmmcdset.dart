/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/*
 * cmmcdset.dart Common functions for Magnetic Card Member Code
 */

/************************************************************************/
/*                  Magnetic Card Check Program                         */
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/mcd.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../cm_ean/mk_cdig.dart';
import '../cm_mbr/cmmbrsys.dart';
import '../cm_sys/cm_cksys.dart';

/************************************************************************/

class Cmmcdset {

  // /*
  //  *  Foramt  : short cm_mcd_MbrCd (char *CodeBuf, char *CardBuf, short CodeBufSize);
  //  *  Input   : char *CodeBuf     Member Code Buffer Pointer
  //  *          : char *CardBuf     Magnetic Card Data Buffer Pointer
  //  *          : short CodeBufSize Member Code Buffer Size
  //  *  Output  : short wErrMsg     Error Message Number
  //  */
  // extern short cm_mcd_MbrCd (char *CodeBuf, char *CardBuf, short CodeBufSize)
  // {
  // RX_COMMON_BUF *pComBuf;
  // short         w_end_p;
  // short         w_digit;
  // //#if CN_NSC
  // int           i;
  // //#endif
  // #if RALSE_MBRSYSTEM
  // short cdstart = 0;
  // int   poi;
  // #endif
  // char tmp[16];
  // int  cdigit;
  //
  // memset(CodeBuf, '0', CodeBufSize);
  // if(rxMemPtr(RXMEM_COMMON, (void **)&pComBuf) != RXMEM_OK) {
  // return(MSG_CUST_TRM_NOTREAD);
  // }
  // if(! cm_mbr_system(pComBuf)) {
  // return(MSG_SETCUSTCARD);
  // }
  // #if RALSE_MBRSYSTEM & !RALSE_CREDIT
  // if ( pComBuf->db_trm.ralse_mag_fmt )
  // {
  // if (cm_mcd_typechk(CardBuf) == MCD_RLSOTHER)
  // return(MSG_CARDERROR);
  // }
  // #endif
  // switch(pComBuf->db_trm.mag_card_typ)
  // {
  // case TERAOKA  : mcd_MbrCd(CodeBuf, CodeBufSize, (char*)&((super_m *)CardBuf)->mbr_cd,
  // sizeof(((super_m *)CardBuf)->mbr_cd));
  // break;
  // case OTHER_CO7:
  // case OTHER_CO4:
  // case OTHER_CO2:
  // case OTHER_CO1:
  // case OTHER_CO : if((pComBuf->db_trm.othcmp_mag_strt_no > (short)0x71) ||
  // (pComBuf->db_trm.othcmp_mag_efct_no > cm_magcd_len()) )
  // //                           (pComBuf->db_trm.othcmp_mag_efct_no > (short)0x8 ) )
  // return(MSG_NOTUSECARD);
  // w_end_p = pComBuf->db_trm.othcmp_mag_strt_no;
  // if( cm_mcd_Check_Other_Co2_TS3(CardBuf) )
  // w_end_p = 57;
  // if(pComBuf->db_trm.mag_card_typ == OTHER_CO1) {
  // if((strncmp((CardBuf+1), "K6", 2) == 0) && (strncmp((CardBuf+7), "0252", 4) == 0) )
  // w_end_p = pComBuf->db_trm.othcmp_mag_strt_no+1;
  // else
  // w_end_p = pComBuf->db_trm.othcmp_mag_strt_no;
  // }
  // else if(cm_custreal_uid_system()){
  // if((strncmp((CardBuf+1), "s8", 2) == 0))
  // w_end_p = 11;
  // else
  // w_end_p = 44;
  // }
  // else if(cm_IKEA_system()){
  // w_end_p = 0;
  // }
  // #if RALSE_MBRSYSTEM
  // if ( pComBuf->db_trm.ralse_mag_fmt )
  // {
  // if ( (cm_mcd_typechk(CardBuf) == MCD_RLSCARD) ||
  // (cm_mcd_typechk(CardBuf) == MCD_RLSCRDT) )
  // w_end_p -= 1;
  // #if RALSE_CREDIT
  // else if ( (cm_mcd_typechk(CardBuf) == MCD_RLSVISA) && cm_NewARCS_system() )
  // w_end_p -= 1;
  // #endif
  //
  // if (cm_mcd_typechk(CardBuf) == MCD_RLSSTAFF)
  // cdstart = pComBuf->db_trm.othcmp_mag_strt_no - 5;
  // else if (cm_mcd_typechk(CardBuf) == MCD_RLSCARD)
  // cdstart = pComBuf->db_trm.othcmp_mag_strt_no - 6;
  // #if RALSE_CREDIT
  // else if (cm_mcd_typechk(CardBuf) == MCD_RLSCRDT)
  // cdstart = RCDCKPOSITION;
  // else if ((cm_mcd_typechk(CardBuf) == MCD_RLSVISA) && cm_NewARCS_system() )
  // cdstart = RCDCKPOSITION;
  // #endif
  // if (cdstart > 0)
  // {
  // for(poi = cdstart; poi < cdstart + 12; poi++) {
  // if( (*(CardBuf + poi) < '0') ||
  // (*(CardBuf + poi) > '9'))
  // return(MSG_CARDERROR);
  // }
  // }
  // #if ARCS_MBR
  // if (cm_mcd_typechk(CardBuf) == MCD_RLSSTAFF)
  // w_end_p = pComBuf->db_trm.othcmp_mag_strt_no;
  // else if (cm_mcd_typechk(CardBuf) == MCD_RLSCARD)
  // w_end_p = pComBuf->db_trm.othcmp_mag_strt_no - 5;
  // #if RALSE_CREDIT
  // else if (cm_mcd_typechk(CardBuf) == MCD_RLSCRDT)
  // w_end_p = RCDCKPOSITION+1;
  // else if ((cm_mcd_typechk(CardBuf) == MCD_RLSVISA) && cm_NewARCS_system())
  // w_end_p = RCDCKPOSITION+1;
  // #endif
  // #endif
  // }
  // #endif
  // w_digit = pComBuf->db_trm.othcmp_mag_efct_no;
  // #if ARCS_MBR
  // if( cm_mcd_typechk(CardBuf) == MCD_RLSSTAFF )
  // w_digit = 7;
  // #endif
  // if(((pComBuf->db_trm.nw7mbr_barcode_1) && (pComBuf->db_trm.mem_use_typ == 1)) ||
  // (pComBuf->db_trm.seikatsuclub_ope))
  // w_digit += 2;
  // else if(pComBuf->db_trm.original_card_ope)
  // w_digit += 1;
  // else if(cm_IKEA_system())
  // w_digit = (short)cm_magcd_len();
  // if(w_digit == (short)0)
  // //                           w_digit = (short)ASC_MCD_CD;
  // w_digit = (short)cm_magcd_len();
  // if((w_end_p + w_digit) > (short)(MCD_CNT - 1))
  // return(MSG_NOTUSECARD);
  // #if CN_NSC
  // pComBuf->nsc_mbr_flg = 0;
  // memset(pComBuf->nsc_mbr_cd, 0, sizeof(pComBuf->nsc_mbr_cd));
  // for(i = 1; i < 9; i++) {
  // if((i == 1) && (CardBuf[1] == 2)){
  // if(cm_mcd_ChkMbrCdNSC(CardBuf) != 0)
  // return(MSG_READ_MBRCARD);
  // else{
  // pComBuf->nsc_mbr_flg = 1;
  // sprintf(pComBuf->nsc_mbr_cd,"%d%d%d%d%d%d%d%d%d%d%d%d%d",
  // CardBuf[1],CardBuf[2],CardBuf[3],CardBuf[4],CardBuf[5],CardBuf[6],CardBuf[7],
  // CardBuf[8],CardBuf[9],CardBuf[10],CardBuf[11],CardBuf[12],CardBuf[13]);
  // //				memcpy(pComBuf->nsc_mbr_cd, CardBuf +1, 13);
  // break;
  // }
  // }
  // if(i < 5){
  // if(CardBuf[i] != 8)
  // return(MSG_READ_MBRCARD);
  // }
  // else{
  // if(CardBuf[i] != 6)
  // return(MSG_READ_MBRCARD);
  // else if(i == 8){
  // w_end_p = 9;
  // w_digit = 8;
  // sprintf(pComBuf->nsc_mbr_cd,"%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d",
  // CardBuf[1],CardBuf[2],CardBuf[3],CardBuf[4],CardBuf[5],CardBuf[6],CardBuf[7],
  // CardBuf[8],CardBuf[9],CardBuf[10],CardBuf[11],CardBuf[12],CardBuf[13],
  // CardBuf[14],CardBuf[15],CardBuf[16]);
  // //			      memcpy(pComBuf->nsc_mbr_cd, CardBuf +1, 16);
  // }
  // }
  // }
  // #endif
  // mcd_MbrCd(CodeBuf, CodeBufSize, &CardBuf[w_end_p], w_digit);
  // break;
  // case OTHER_CO3:
  // w_end_p = 44;
  // w_digit = 13;
  //
  // mcd_MbrCd(CodeBuf, CodeBufSize, &CardBuf[w_end_p], w_digit);
  // break;
  // case OTHER_CO5:
  // if(strncmp((CardBuf+7), "3005", 4) == 0){
  // w_end_p = 11;
  // w_digit = (short)cm_magcd_len();
  // mcd_MbrCd(CodeBuf, CodeBufSize, &CardBuf[w_end_p], w_digit);
  // cdigit = 0;
  // for(i = 0; i < 13; i++) {
  // cdigit += ((CodeBuf[12-i])-0x30)*((i%8)+2);
  // }
  // cdigit %= 11;
  // cdigit = 11-cdigit;
  // if(cdigit >= 10)
  // cdigit = 0;
  // if(CodeBuf[13] == (cdigit + 0x30))
  // return(FALSE);
  // else
  // return(MSG_NOTUSECARD);
  // }
  // else if(strncmp((CardBuf+11), "422001", 6) == 0){
  // w_end_p = 11;
  // w_digit = 16;
  // mcd_MbrCd(tmp, 16, &CardBuf[w_end_p], w_digit);
  // }
  // else{
  // for(i = 0; i < 16; i++) {
  // if((CardBuf[i+1] >= 0x00) && (CardBuf[i+1] <= 0x10))
  // tmp[i] = CardBuf[i+1] + 0x30;
  // else
  // return(MSG_NOTUSECARD);
  // }
  //
  // if(strncmp(tmp, "422001", 6) != 0)
  // return(MSG_NOTUSECARD);
  // }
  // if(strncmp(tmp, "422001", 6) == 0){
  // memcpy(CodeBuf, &tmp[1], 14);
  // memset(tmp, 0, sizeof(tmp));
  // sprintf(tmp,"00000%c%c%c%c%c%c%c%c%c",
  // CodeBuf[7], CodeBuf[5], CodeBuf[9], CodeBuf[6],CodeBuf[13], CodeBuf[12], CodeBuf[10], CodeBuf[8], CodeBuf[11]);
  // memcpy(CodeBuf , tmp, 14);
  // }
  // break;
  //
  // default       : return(MSG_CARDERROR);
  // }
  // return(FALSE);
  // }
  //
  // static void mcd_MbrCd (char *CodeBuf, short CodeBufSize, char *MbrCd, short MbrCdSize)
  // {
  // RX_COMMON_BUF *pComBuf;
  // #if CN
  // short i;
  // #endif
  // if(rxMemPtr(RXMEM_COMMON, (void **)&pComBuf) != RXMEM_OK) {
  // return;
  // }
  // if(MbrCdSize < CodeBufSize)
  // {
  // memcpy(CodeBuf + (CodeBufSize - MbrCdSize), MbrCd, MbrCdSize);
  // }
  // else
  // {
  // if(((pComBuf->db_trm.nw7mbr_barcode_1) && (pComBuf->db_trm.mem_use_typ == 1)) ||
  // (pComBuf->db_trm.seikatsuclub_ope))
  // memcpy(CodeBuf, MbrCd, CodeBufSize+2);
  // else if(pComBuf->db_trm.original_card_ope)
  // memcpy(CodeBuf, MbrCd, CodeBufSize+1);
  // else
  // memcpy(CodeBuf, MbrCd, CodeBufSize);
  // }
  // #if CN
  // for(i = 0; i < CodeBufSize; i++) {
  // if((CodeBuf[i] >= 0) && (CodeBuf[i] <= 9))
  // CodeBuf[i] += 0x30;
  // }
  // #endif
  // }
  //
  // /*
  //  *  Foramt  : short cm_mcd_mbr_name (char *NameBuf, char *CardBuf, short NameBufSize);
  //  *  Input   : char *NameBuf      Member Name Buffer Pointer
  //  *          : char *CardBuf      Magnetic Card Data Buffer Pointer
  //  *          : short NameBufSize  Member Name Buffer Size
  //  *  Output  : short wErrMsg      Error Message Number
  //  */
  // extern short cm_mcd_MbrName (char *NameBuf, char *CardBuf, short NameBufSize)
  // {
  // RX_COMMON_BUF *pComBuf;
  //
  // memset(NameBuf, ' ', NameBufSize);
  // if(rxMemPtr(RXMEM_COMMON, (void **)&pComBuf) != RXMEM_OK) {
  // return(MSG_CUST_TRM_NOTREAD);
  // }
  // if(! cm_mbr_system(pComBuf)) {
  // return(MSG_SETCUSTCARD);
  // }
  // switch(pComBuf->db_trm.mag_card_typ)
  // {
  // case TERAOKA : mcd_MbrNameTeraoka(NameBuf, (super_m *)CardBuf, NameBufSize);
  // break;
  // default      : break;
  // }
  // return(FALSE);
  // }
  //
  // static void mcd_MbrNameTeraoka (char *NameBuf, super_m *ptSuperM, short NameBufSize)
  // {
  // short wNameSize;
  //
  // wNameSize = sizeof(ptSuperM->mbr_name);
  // memcpy(NameBuf, ptSuperM->mbr_name, (NameBufSize < wNameSize) ?
  // NameBufSize : wNameSize);
  // }

  /// 磁気カードNoを会員カードNoに変換する
  /// 引数:[mcdBuf] 磁気カードNo (Fix 8byte)
  /// 引数:[cardTyp] カードフォーマット種別
  /// 戻り値:[int] エラーNo (0=エラーなし)
  /// 戻り値:[String] 会員カードNo (Fix 13byte)
  /// 関連tprxソース: cmmcdset.c - cm_mcd_to_mbr
  static Future<(int, String)> cmMcdToMbr(String mcdBuf, [int cardTyp = 0]) async {
    if (CmCksys.cmIKEASystem() != 0) {
      return (0, ""); //IKEA仕様では何も処理しない(MbrCd変換無し)
    }

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return (DlgConfirmMsgKind.MSG_CUST_TRM_NOTREAD.dlgId, "");
    }
    RxCommonBuf cBuf = xRet.object;

    if (await CmMbrSys.cmMbrSystem(cBuf) == 0) {
      return (DlgConfirmMsgKind.MSG_SETCUSTCARD.dlgId, "");
    }

    String ret = "".padLeft(CmMbrSys.cmMbrcdLen(), "0");  //元ソースmbrBuf
    int mbrLen = CmMbrSys.cmMbrcdLen();
    int magLen = CmMbrSys.cmMagcdLen();
    int subLen = mbrLen - magLen - 1;

    if ((await CmCksys.cmDcmpointSystem() != 0)
        || (await CmCksys.cmCustrealWebserSystem() != 0)
        || (await CmCksys.cmCustrealUidSystem() != 0)
        || (CmCksys.cmJAIwateSystem() != 0)) {
      if (CmMbrSys.cmMbrcdLen() > CmMbrSys.cmMagcdLen()) {
        ret = "${ret.substring(0, subLen)}${mcdBuf.substring(0, magLen)}${mcdBuf.substring(mbrLen-1)}";
      }
      else {
        ret = mcdBuf.substring(0, mbrLen);
      }
      return (0, ret);
    }
    else if ((await CmCksys.cmCustrealOpSystem != 0)
        || (await CmCksys.cmCustrealUniSystem() != 0)  //12Ver
        || (CmCksys.cmCustrealRPointSystem() != 0)  //12Ver
    ) {
      ret = mcdBuf.substring(0, mbrLen);
      return (0, ret);
    }
    else if (await CmCksys.cmIchiyamaMartSystem() != 0) {
      if (mcdBuf.startsWith("00000")) {
        if (ret.length > 14) {
          ret = "${ret.substring(0, 5)}${mcdBuf.substring(5, 14)}${ret.substring(14)}";
        } else {
          ret = "${ret.substring(0, 5)}${mcdBuf.substring(5, 14)}";
        }
      }
      else {
        if (ret.length > 14) {
          ret = "${mcdBuf.substring(0, 14)}${ret.substring(14)}";
        } else {
          ret = mcdBuf.substring(0, 14);
        }
      }
      return (0, ret);
    }

    if ((cBuf.dbTrm.magCardTyp == Mcd.OTHER_CO3)
        || (cBuf.dbTrm.magCardTyp == Mcd.OTHER_CO7)) {
      if (ret.length > 14) {
        ret = "${mcdBuf.substring(0, 13)}${ret.substring(13)}";
      } else {
        ret = mcdBuf.substring(0, 13);
      }
      return (0, ret);
    }

    int sa = 0;
    if (magLen > Mcd.ASC_MCD_CD) {
      sa = magLen - Mcd.ASC_MCD_CD;
    }

    int instreFlg = 0;
    switch (cBuf.dbTrm.magcadKnd) {
      case 0:  /* NNNNNNNN   -> FF00NNNNNNNNc/d */
        instreFlg = getInstreFlg(cBuf, Mcd.FMT_NO_MBR13);
        if (instreFlg != 0) {
          if (((cBuf.dbTrm.nw7mbrBarcode1 != 0) && (cBuf.dbTrm.memUseTyp == 1))
              || (cBuf.dbTrm.seikatsuclubOpe != 0)) {
            ret = ret.substring(0, 2) + mcdBuf.substring(0, magLen-2-1);
          }
          else if (cBuf.dbTrm.originalCardOpe != 0) {
            ret = ret.substring(0, 3) + mcdBuf.substring(0, 9);
          }
          else {
            if (CompileFlag.ARCS_MBR) {
              if (cardTyp == Mcd.MCD_RLSSTAFF) {
                ret = "${ret.substring(0, 2)}1${ret.substring(3)}";
              }
            }
            if (mbrLen > magLen) {
              ret = "${ret.substring(0, subLen)}${mcdBuf.substring(0, magLen)}";
            }
            else {
              ret = mcdBuf.substring(0, mbrLen);
            }
          }
          ret += instreFlg.toString();
          ret = MkCdig.cmMkCdigitVariable(ret, mbrLen);
          return (0, ret);
        }
        break;
      case 1:  /* ???NNNNN   -> 00000FFNNNNNc/d */
        instreFlg = getInstreFlg(cBuf, Mcd.FMT_NO_MBR8);
        if (instreFlg != 0) {
          ret = ret.substring(0, subLen+3+sa) + mcdBuf.substring(3+sa, magLen);
          ret = ret.substring(0, 5) + instreFlg.toString() + ret.substring(6);
          ret = MkCdig.cmMkCdigit(ret);
          return (0, ret);
        }
        else {
          instreFlg = getInstreFlg(cBuf, Mcd.FMT_NO_MBR8_2);
          if (instreFlg != 0) {
            ret = ret.substring(0, subLen+2+sa) + mcdBuf.substring(2+sa, magLen);
            ret = ret.substring(0, 5) + instreFlg.toString() + ret.substring(6);
            ret = MkCdig.cmMkCdigit(ret);
            return (0, ret);
          }
        }
        break;
      case 2:  /* FFNNNNNc/d -> 00000FFNNNNNc/d */
        if (mcdBuf == getInstreFlg(cBuf, Mcd.FMT_NO_MBR8).toString()) {
          ret = ret.substring(0, subLen-1) + mcdBuf.substring(0, magLen);
          return (0, ret);
        }
        else {
          instreFlg = getInstreFlg(cBuf, Mcd.FMT_NO_MBR8_2);
          if ((instreFlg != 0) && (instreFlg.toString() == mcdBuf)) {
            ret = ret.substring(0, subLen-1) + mcdBuf.substring(0, magLen);
            return (0, ret);
          }
        }
        break;
      default:
        break;
    }
    return (DlgConfirmMsgKind.MSG_BARFMTERR.dlgId, ret);
  }

  /// 数値に変換したインストアマーキングフラグを取得する
  /// 引数:[pComBuf] 共有クラス（RxCommonBuf）
  /// 引数:[formatNo] フォーマット種別
  /// 戻り値: インストアマーキングフラグ
  /// 関連tprxソース: cmmcdset.c - get_instre_flg
  static int getInstreFlg (RxCommonBuf pComBuf, int formatNo) {
    for (int i = 0; i < RxMem.DB_INSTRE_MAX; i++) {
      if ((pComBuf.dbInstre[i].format_typ == Mcd.FMT_TYP_MBR) /* Format type member ? */
          && (pComBuf.dbInstre[i].format_no == formatNo) ) {  /* Same format no. ?    */
        return int.tryParse(pComBuf.dbInstre[i].instre_flg[0]) ?? 0;
      }
    }
    return 0;
  }

  //
  // extern short cm_mcd_StoreCd (char *CodeBuf, char *CardBuf, short CodeBufSize)
  // {
  // RX_COMMON_BUF *pComBuf;
  // short         w_end_p;
  // short         w_digit;
  //
  // memset(CodeBuf, '0', CodeBufSize);
  // if(rxMemPtr(RXMEM_COMMON, (void **)&pComBuf) != RXMEM_OK) {
  // return(MSG_CUST_TRM_NOTREAD);
  // }
  // if(! cm_mbr_system(pComBuf)) {
  // return(MSG_SETCUSTCARD);
  // }
  //
  // w_end_p = 5;
  // w_digit = 6;
  // if(w_digit == (short)0)
  // w_digit = (short)ASC_MCD_CD;
  // if((w_end_p + w_digit) > (short)(MCD_CNT - 1))
  // return(MSG_NOTUSECARD);
  // mcd_StoreCd(CodeBuf, CodeBufSize, &CardBuf[w_end_p], w_digit);
  //
  // return(FALSE);
  // }
  //
  //
  // static void mcd_StoreCd (char *CodeBuf, short CodeBufSize, char *MbrCd, short MbrCdSize)
  // {
  // #if CN
  // short i;
  // #endif
  // if(MbrCdSize < CodeBufSize)
  // {
  // memcpy(CodeBuf + (CodeBufSize - MbrCdSize), MbrCd, MbrCdSize);
  // }
  // else
  // {
  // memcpy(CodeBuf, MbrCd, CodeBufSize);
  // }
  // #if CN
  // for(i = 0; i < CodeBufSize; i++) {
  // if((CodeBuf[i] >= 0) && (CodeBuf[i] <= 9))
  // CodeBuf[i] += 0x30;
  // }
  // #endif
  // }
  //
  //
  // extern short cm_mcd_StaffFlg (char *CodeBuf, char *CardBuf, short CodeBufSize)
  // {
  // RX_COMMON_BUF *pComBuf;
  // short         w_end_p;
  // short         w_digit;
  //
  // memset(CodeBuf, '0', CodeBufSize);
  // if(rxMemPtr(RXMEM_COMMON, (void **)&pComBuf) != RXMEM_OK) {
  // return(MSG_CUST_TRM_NOTREAD);
  // }
  // if(! cm_mbr_system(pComBuf)) {
  // return(MSG_SETCUSTCARD);
  // }
  //
  // w_end_p = 1;
  // w_digit = 1;
  // if(w_digit == (short)0)
  // w_digit = (short)ASC_MCD_CD;
  // if((w_end_p + w_digit) > (short)(MCD_CNT - 1))
  // return(MSG_NOTUSECARD);
  // mcd_StaffFlg(CodeBuf, CodeBufSize, &CardBuf[w_end_p], w_digit);
  //
  // return(FALSE);
  // }
  //
  //
  // static void mcd_StaffFlg (char *CodeBuf, short CodeBufSize, char *MbrCd, short MbrCdSize)
  // {
  // #if CN
  // short i;
  // #endif
  // if(MbrCdSize < CodeBufSize)
  // {
  // memcpy(CodeBuf + (CodeBufSize - MbrCdSize), MbrCd, MbrCdSize);
  // }
  // else
  // {
  // memcpy(CodeBuf, MbrCd, CodeBufSize);
  // }
  // #if CN
  // for(i = 0; i < CodeBufSize; i++) {
  // if((CodeBuf[i] >= 0) && (CodeBuf[i] <= 9))
  // CodeBuf[i] += 0x30;
  // }
  // #endif
  // }
  //
  // #if CN_NSC
  // extern short cm_mcd_ChkMbrCdNSC (char *CardBuf)
  // {
  // char mbr_cd;
  //
  // mbr_cd = (char)0;
  // mbr_cd = CardBuf[2] + CardBuf[4] + CardBuf[6] + CardBuf[8] + CardBuf[10] + CardBuf[12];
  // mbr_cd *= (char)3;
  // mbr_cd += CardBuf[1] + CardBuf[3] + CardBuf[5] + CardBuf[7] + CardBuf[9] + CardBuf[11];
  // mbr_cd %= (char)10;
  // mbr_cd = (char)10 - mbr_cd;
  // mbr_cd %= (char)10;
  //
  // if(CardBuf[13] == mbr_cd)
  // return OK;
  // else
  // return NG;
  // }
  // #endif

}