/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/apllib.dart';
import '../../inc/lib/cm_nedit.dart';
import '../../inc/lib/cm_str_molding_define.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_log_define.dart';
import '../../inc/sys/tpr_type.dart';
import '../apllib/apllib_img_read.dart';
import '../apllib/apllib_strutf.dart';

class CmStrMolding {
  static const IMGDATAADD_MAX	= 10;
  static const JNALWIDTH = 54;
  static const ANS_LINE_MAX	= 2;
  static const LINE_BUFSIZ_MAX = ((JNALWIDTH * 4) + 1);
  static const JNALBUFSIZ	= ((JNALWIDTH * 4) + 1);
  static const RCPTWIDTH = 32;
  static const RCPTBUFSIZ	= (((RCPTWIDTH + 2) * 4) + 1);
  static const MOLDIGN_BUF_SIZE	= 256;	// 両端に文字を配置する関数で使用する, 一方のバッファサイズ
  static const MOLDING_MAX_CNT = MOLDIGN_BUF_SIZE / RxMem.CHARCODE_BYTE;	// 上記で最大にセットされる半角文字数

  static const	DATA_PTN_NONE	= 0;

  static const ASTERISK = "＊";
  static const HYPHEN = "-";

  /// 関連tprxソース:cm_str_molding.c - cm_Multi_ImgDataAdd()
  static int cmMultiImgDataAdd(TprMID tid, TImgDataAdd? imgDataAdd, TImgDataAddAns Ans) {
    String erLog;
    EucAdj adj;
    CmEditCtrl fCtrl;
    int i = 0, j = 0, posi = 0;
    int err_flg = 0;
    int bytes = 0;
    int digit = 0, pbuf_digit = 0, pbuf_siz = 0, len = 0, retflg = 0;
    int ptn_st = 0, ptn_end = 0, ptn_spc = 0, ptn_add1spc = 0;
    int width = 0;
    int buf_siz = 0;

    if (imgDataAdd == null) {
      erLog = "cmMultiImgDataAdd param NULL error\n";
      TprLog().logAdd(tid, LogLevelDefine.error, erLog);
      return -1;
    }
    if (imgDataAdd.width > 0) { //幅指定あり
      width = imgDataAdd.width;
    } else {
      width = 54;
    }
    buf_siz = (width * 4 + 1);
    String pbuf = '';
    String tmpbuf = '';
    List<String> spc = List.empty(growable: true);
    List<int> pdata = List.empty(growable: true);
    String pdataStr = '';
    String spcStr = '';
    for (i = 0; i < CmStrMoldingDef.IMGDATAADD_MAX; i++) {
      if (((imgDataAdd.imgData[i].posi < 0) && (imgDataAdd.imgData[i].posi > width)) ||
          ((imgDataAdd.imgData[i].Edit_typ < 0) && (imgDataAdd.imgData[i].Edit_typ > EditTyps.EDIT_TYP_MAX.id)) ||
          ((imgDataAdd.imgData[i].typ < 0) && (imgDataAdd.imgData[i].typ > DataTyps.DATA_TYP_MAX.id)) ||
          ((imgDataAdd.imgData[i].Edit_typ != EditTyps.EDIT_TYP_NONE.id) && (imgDataAdd.imgData[i].fCtrl == null)) ||
          ((imgDataAdd.imgData[i].count < CmStrMoldingDef.DATA_COUNT_DISABLE) && (imgDataAdd.imgData[i].count > width)) )
      {
        erLog = "cmMultiImgDataAdd param error[$i] [${imgDataAdd.imgData[i].ptn}][${imgDataAdd.imgData[i].posi}][${imgDataAdd.imgData[i].fCtrl}][${imgDataAdd.imgData[i].Edit_typ}][${imgDataAdd.imgData[i].typ}][${imgDataAdd.imgData[i].count}][${imgDataAdd.imgData[i].data}]\n";
        TprLog().logAdd(tid, LogLevelDefine.error, erLog);
        return -1;
      }
      if(imgDataAdd.imgData[i].data == null) { //null許容型ではないのでnullになることはないため、不要？ == 0?
        imgDataAdd.imgData[i].count = CmStrMoldingDef.DATA_COUNT_DISABLE;
      }
    }
    pbuf_digit = pbuf_siz = 0;

    for (i = 0; i < CmStrMoldingDef.IMGDATAADD_MAX; i++) {
      if(imgDataAdd.imgData[i].count == CmStrMoldingDef.DATA_COUNT_DISABLE) {
        continue;
      }
      ptn_st = ptn_end = ptn_spc = ptn_add1spc = 0;
      if ((imgDataAdd.imgData[i].ptn & CmStrMoldingDef.DATA_PTN_ST) != 0) {
        ptn_st = 1;
      }
      else if((imgDataAdd.imgData[i].ptn & CmStrMoldingDef.DATA_PTN_CD) != 0) {
        ptn_st = 2;
      }
      else if((imgDataAdd.imgData[i].ptn & CmStrMoldingDef.DATA_PTN_ST_BRA) != 0) {
        ptn_st = 3;
      }
      if((imgDataAdd.imgData[i].ptn & CmStrMoldingDef.DATA_PTN_END) != 0) {
        ptn_end = 1;
      }
      else if((imgDataAdd.imgData[i].ptn & CmStrMoldingDef.DATA_PTN_END_BRA) != 0) {
        ptn_end = 2;
      }
      if((imgDataAdd.imgData[i].ptn & CmStrMoldingDef.DATA_PTN_TEN) != 0) {
        ptn_spc = 1;
      }
      else if((imgDataAdd.imgData[i].ptn & CmStrMoldingDef.DATA_PTN_CUT) != 0) {
        ptn_spc = 2;
      }
      if((imgDataAdd.imgData[i].ptn & CmStrMoldingDef.DATA_PTN_ADD1SPC) != 0) {
        ptn_add1spc = 1;
      }
      switch (imgDataAdd.imgData[i].Edit_typ) {
        case 0:  // EditTyps.EDIT_TYP_NONE
          switch(imgDataAdd.imgData[i].typ) {
            case 0:  // DataTyps.DATA_TYP_SHORT
              pdata += imgDataAdd.imgData[i].data.toString().codeUnits;
              break;
            case 1:  //  DataTyps.DATA_TYP_INT
              pdata += imgDataAdd.imgData[i].data.toString().codeUnits;
              break;
            case 2:  // DataTyps.DATA_TYP_LONG
              pdata += imgDataAdd.imgData[i].data.toString().codeUnits;
              break;
            case 3:  // DataTyps.DATA_TYP_DOUBLE
              pdata += imgDataAdd.imgData[i].data.toString().codeUnits;
              break;
            case 4:  // DataTyps.DATA_TYP_CHAR
              pdata += imgDataAdd.imgData[i].data.toString().codeUnits;
              pdataStr = pdata.join('');
              (adj, pdataStr) = AplLibStrUtf.aplLibEucAdjust(pdataStr, pdataStr.length, imgDataAdd.imgData[i].count); //pStrをpdataに変換する方法募集
              break;
            case 5:  // DataTyps.DATA_TYP_LONGLONG
              pdata += imgDataAdd.imgData[i].data.toString().codeUnits;
              break;
            case 6:  // DataTyps.DATA_TYP_IMGCD
            default:
              adj = AplLibImgRead.aplLibImgRead(imgDataAdd.imgData[i].data);
              break;
          }
          break;
        case 2:  // EditTyps.EDIT_TYP_BINARY
          if (imgDataAdd.imgData[i].typ == DataTyps.DATA_TYP_LONG.id) {
            bytes = CmNedit().cmEditBinaryUtf(imgDataAdd.imgData[i].fCtrl, pdata, pdata.length, imgDataAdd.imgData[i].count,
                imgDataAdd.imgData[i].data, imgDataAdd.imgData[i].count, bytes).$2;
          }
          else {
            err_flg = 1;
          }
          break;
        case 3:  // EditTyps.EDIT_TYP_BINARY_LL
          if (imgDataAdd.imgData[i].typ == DataTyps.DATA_TYP_LONGLONG.id) {
            for (int p = 0; p < pdata.length; p++) {
              pdataStr += pdata[p].toString();
            }
            bytes = CmNedit().cmEditBinaryLlUtf(imgDataAdd.imgData[i].fCtrl, pdataStr, pdata.length, imgDataAdd.imgData[i].count,
                imgDataAdd.imgData[i].data, imgDataAdd.imgData[i].count, bytes).$2;
          }
          else {
            err_flg = 1;
          }
          break;
        case 5:  // EditTyps.EDIT_TYP_TOTALPRICE
          if (imgDataAdd.imgData[i].typ == DataTyps.DATA_TYP_LONG.id) {
            fCtrl = imgDataAdd.imgData[i].fCtrl;
            bytes = CmNedit().cmEditTotalPriceUtf(fCtrl, pdata, pdata.length, imgDataAdd.imgData[i].count,
                imgDataAdd.imgData[i].data, bytes).$2;
          }
          else {
            err_flg = 1;
          }
          break;
        case 7:  // EditTyps.EDIT_TYP_UNITPRICE
          if (imgDataAdd.imgData[i].typ == DataTyps.DATA_TYP_LONG.id) {
            fCtrl = imgDataAdd.imgData[i].fCtrl;
            bytes = CmNedit().cmEditUnitPriceUtf(fCtrl, pdata, pdata.length, imgDataAdd.imgData[i].count,
                imgDataAdd.imgData[i].data, bytes).$2;
          }
          else{
            err_flg = 1;
          }
          break;
        case 6:  // EditTyps.EDIT_TYP_TOTALPRICE_LL
          if (imgDataAdd.imgData[i].typ == DataTyps.DATA_TYP_LONGLONG.id) {
            bytes = CmNedit().cmEditTotalPriceLlUtf(imgDataAdd.imgData[i].fCtrl, pdata, pdata.length, imgDataAdd.imgData[i].count,
                imgDataAdd.imgData[i].data, bytes).$2;
          }
          else {
            err_flg = 1;
          }
          break;
        case 4:  // EditTyps.EDIT_TYP_WEIGHT
          if (imgDataAdd.imgData[i].typ == DataTyps.DATA_TYP_LONG.id) {
            fCtrl = imgDataAdd.imgData[i].fCtrl;
            bytes = CmNedit().cmEditWeightUtf(fCtrl, pdata, pdata.length, imgDataAdd.imgData[i].count,
                imgDataAdd.imgData[i].data, bytes).$2;
          }
          else{
            err_flg = 1;
          }
          break;
        case 1:  // EditTyps.EDIT_TYP_BCD
          if (imgDataAdd.imgData[i].typ == DataTyps.DATA_TYP_CHAR.id) {
            fCtrl = imgDataAdd.imgData[i].fCtrl;

            bytes = CmNedit().cmEditBcdUtf(fCtrl, pdata, pdata.length, imgDataAdd.imgData[i].count,
                imgDataAdd.imgData[i].data.toString(), imgDataAdd.imgData[i].bcd_len, imgDataAdd.imgData[i].digit, bytes).$2;
          }
          else {
            err_flg = 1;
          }
          break;
        case 8:  // EditTyps.EDIT_TYP_VOLUME // RM-3800で体積を追加
          if (imgDataAdd.imgData[i].typ == DataTyps.DATA_TYP_LONG.id) {
            fCtrl = imgDataAdd.imgData[i].fCtrl;
            bytes = CmNedit().cmEditVolumeUtf(fCtrl, pdata, pdata.length, imgDataAdd.imgData[i].count,
                imgDataAdd.imgData[i].data, bytes).$2;
          }
          else {
            err_flg = 1;
          }
          break;
      }
      List<String> pdataStrList = List.empty(growable: true);
      for(int i = 0; i < pdata.length; i++) {
        pdataStrList.add(pdata[i].toString());
      }
      if (ptn_end != 0) {
        if((pdata.length + 1) < buf_siz) {
          len = pdata.length;
          switch(ptn_end) {
            case 2:
              pdataStrList[len] = ']';
              break;
            default:
              pdataStrList[len] = ')';
              break;
          }
        }
      }
      switch(ptn_spc) {
        case 1: /* ten */
          for (j = 0; j < pdata.length; j++) {
            if(pdataStrList[j] == ' ') {
              pdataStrList[j] = '.';
            }
          }
          break;
        case 2: /* cut */
          for (j = 0; j < pdata.length; j++) {
            if (pdataStrList[j] != ' ') {
              break;
            }
          }
          if (j > 0) {
            tmpbuf = pdataStrList[j];
            pdataStrList = List.empty(growable: true);
            pdataStrList.add(tmpbuf);
          }
          break;
        default:
          break;
      }
      if (err_flg != 0) {
        erLog = "cmMultiImgDataAdd err_flg error[$i] [${imgDataAdd.imgData[i].ptn}][${imgDataAdd.imgData[i].posi}][${imgDataAdd.imgData[i].fCtrl}][${imgDataAdd.imgData[i].Edit_typ}][${imgDataAdd.imgData[i].typ}][${imgDataAdd.imgData[i].count}][${imgDataAdd.imgData[i].data}]\n";
        TprLog().logAdd(tid, LogLevelDefine.error, erLog);
        return -1;
      }

      posi = 0;
      if ((imgDataAdd.imgData[i].posi - pbuf_digit) > 0) {
        if (ptn_st != 0) {
          if((imgDataAdd.imgData[i].posi - pbuf_digit - 1) > 0) {
            for (int i = 0; i < imgDataAdd.imgData[i].posi - pbuf_digit - 1; i++) {
              spc.add(' ');
            }
          }
          switch(ptn_st) {
            case 1:
              spc[spc.length] = '(';
              break;
            case 2:
              spc[spc.length] = '#';
              break;
            case 3:
              spc[spc.length] = '[';
              break;
          }
        }
        else {
          for (int i = 0; i < imgDataAdd.imgData[i].posi - pbuf_digit; i++) {
            spc.add(' ');
          }
        }
      }
      else if(pbuf_digit > 0) {
        if (pdataStrList.length > (pbuf_digit - imgDataAdd.imgData[i].posi)) {
          for (j = 0; j < (pbuf_digit - imgDataAdd.imgData[i].posi); j++) {
            if (pdataStrList[j] != ' ') {
              break;
            }
            posi++;
          }
        }
      }
      spcStr = spc.join();
      if(pdataStrList.isNotEmpty) {
        if (ptn_add1spc != 0) {
          tmpbuf = "$spcStr ${pdataStrList[posi]}";
        } else {
          tmpbuf = "$spcStr${pdataStrList[posi]}";
        }
      }
      digit = AplLibStrUtf.aplLibEntCnt(tmpbuf);
      if ((pbuf_digit + digit) > width) {
        pbuf = AplLibStrUtf.aplLibEucAdjust(pbuf, pbuf.length, width).$2;
        if(cmImgDataAddAns(tid, Ans, pbuf) == -1) {
          return -1;
        }

        spc = List.empty(growable: true);
        if (imgDataAdd.imgData[i].posi > 0) {
          if (ptn_st != 0) {
            if ((imgDataAdd.imgData[i].posi - 1) > 0) {
              for (int i = 0; i < imgDataAdd.imgData[i].posi - 1; i++) {
                spc.add(' ');
              }
            }
            switch(ptn_st) {
              case 1:
                spc[spc.length] = '(';
                break;
              case 2:
                spc[spc.length] = '#';
                break;
              case 3:
                spc[spc.length] = '[';
                break;
            }
          } else {
            for (int i = 0; i < imgDataAdd.imgData[i].posi; i++) {
              spc.add(' ');
            }
          }
        }
        spcStr = spc.join();
        tmpbuf = "$spcStr$pdataStr";
        adj = AplLibStrUtf.aplLibEucAdjust(tmpbuf, tmpbuf.length, width).$1;
        if ((i + 1) >= CmStrMoldingDef.IMGDATAADD_MAX) {
          if (cmImgDataAddAns(tid, Ans, tmpbuf) == -1) {
            return -1;
          }
          return 0;
        }
        for (int j = (i + 1), retflg = 0; j < IMGDATAADD_MAX; j++) {
          if (imgDataAdd.imgData[j].count != CmStrMoldingDef.DATA_COUNT_DISABLE) {
            retflg++;
            break;
          }
        }
        if (retflg == 0) {
          if (cmImgDataAddAns(tid, Ans, tmpbuf) == -1) {
            return -1;
          }
          return 0;
        }
        pbuf = tmpbuf;
        pbuf_digit = adj.count;
      } else {
        pbuf_siz = pbuf.length;
        pbuf += tmpbuf;
        adj = AplLibStrUtf.aplLibEucAdjust(pbuf, pbuf.length, width).$1;
        if ((i + 1) >= CmStrMoldingDef.IMGDATAADD_MAX) {
          if (cmImgDataAddAns(tid, Ans, pbuf) == -1) {
            return -1;
          }
          return 0;
        }
        for (int j = (i + 1), retflg = 0; j < IMGDATAADD_MAX; j++) {
          if (imgDataAdd.imgData[j].count != CmStrMoldingDef.DATA_COUNT_DISABLE) {
            retflg++;
            break;
          }
        }
        if (retflg == 0) {
          if (cmImgDataAddAns(tid, Ans, pbuf) == -1) {
            return -1;
          }
          return 0;
        }
        pbuf_digit = adj.count;
      }
    }
    return 0;
  }

  ///  関連tprxソース: cm_str_molding.h - cm_Multi_ImgDataAdd_Char
  static void cmMultiImgDataAddChar(TprMID tid, TImgDataAdd? imgDataAdd,
      int num, int ptn, int posi, int count, String str) {
    if (imgDataAdd == null) {
      return;
    }
    if ((num < 0) || (num > IMGDATAADD_MAX)) {
      return;
    }
    imgDataAdd.imgData[num] = TImgData();
    imgDataAdd.imgData[num].ptn = ptn;
    imgDataAdd.imgData[num].posi = posi;
    imgDataAdd.imgData[num].typ = DataTyps.DATA_TYP_CHAR.id;
    imgDataAdd.imgData[num].count = count;
    imgDataAdd.imgData[num].data = int.tryParse(str) ?? 0;
  }

  /// 関連tprxソース:cm_str_molding.c - cm_ImgDataAddAns()
  static int cmImgDataAddAns(TprMID tid, TImgDataAddAns ans, String tmpBuf ) {
    String erLog;

    ans.line_num++;
    if (ans.line_num > CmStrMoldingDef.ANS_LINE_MAX) {
      erLog = "cmImgDataAddAns line max error\n";
      TprLog().logAdd(tid, LogLevelDefine.error, erLog);
      return -1;
    }
    if (tmpBuf.length >= CmStrMoldingDef.LINE_BUFSIZ_MAX) {
      erLog = "cmImgDataAddAns line buffer siz error[${tmpBuf.length}]\n";
      TprLog().logAdd(tid, LogLevelDefine.error, erLog);
      return -1;
    }
    ans.line[ans.line_num - 1] = tmpBuf;
    return 0;
  }

  /// 関連tprxソース:cm_str_molding.c - cm_ImgDataAdd()
  static int cmImgDataAdd(TprMID tid, String imgData, int width, int count, int posi, int spc, TImgDataAddAns ans) {
    String erlog;
    EucAdj adj = EucAdj();
    EucAdj adj2 = EucAdj();
    int	i, count2, countOrg;

    countOrg = count;
    if ((count <= 0) || (count > width)) {
      count = JNALWIDTH;
    }
    if (width <= 0) {
      erlog = "cmImgDataAdd width error[$imgData][$width][$countOrg]\n";
      TprLog().logAdd(tid, LogLevelDefine.error, erlog);
      return -1;
    }
    String pbuf = "";
    String tmpbuf = "";
    String tmpspc = "";
    if ((posi < DataPosiTyps.DATA_POSI_RIGHT.id) || (posi >= width)) {
      erlog = "cmImgDataAdd posi error[$imgData][$posi][$countOrg]\n";
      TprLog().logAdd(tid, LogLevelDefine.error, erlog);
      return -1;
    }
    tmpbuf = imgData;
    adj = AplLibStrUtf.aplLibEucAdjust(tmpbuf, tmpbuf.length, count).$1;
    switch(posi) {
      case -1:  //DATA_POSI_CENTER
        switch(spc) {
          case 0:  // DATA_SPC
            tmpspc = "".padLeft((width - adj.count) ~/ 2, " ");
            pbuf = tmpspc + tmpbuf;
            break;
          case 1:  // DATA_POSI_CENTER_ASTERISK
            tmpspc = ASTERISK;
            adj2 = AplLibStrUtf.aplLibEucAdjust(tmpspc, tmpspc.length, width).$1;
            count2 = ((width - adj.count) ~/ 2);
            for(i = 0; i < count2/adj2.count; i++) {
              tmpspc += ASTERISK;
            }
            pbuf = tmpspc + tmpbuf + tmpspc;
            pbuf = AplLibStrUtf.aplLibEucAdjust(pbuf, pbuf.length, width).$2;
            break;
          case 2:  // DATA_POSI_CENTER_HYPHEN
          default:
            tmpspc = HYPHEN;
            adj2 = AplLibStrUtf.aplLibEucAdjust(tmpspc, tmpspc.length, width).$1;
            count2 = ((width - adj.count) ~/ 2);
            for(i = 0; i < count2/adj2.count; i++) {
              tmpspc += HYPHEN;
            }
            pbuf = tmpspc + tmpbuf + tmpspc;
            pbuf = AplLibStrUtf.aplLibEucAdjust(pbuf, pbuf.length, width).$2;
            break;
        }
        break;
      case -2:  // DATA_POSI_RIGHT
        tmpspc = "".padLeft((width - adj.count), " ");
        pbuf = tmpspc + tmpbuf;
        break;
      case 0:  // DATA_POSI_LEFT
        pbuf = tmpbuf;
        break;
      default:
        tmpspc = "".padLeft(posi, " ");
        pbuf = tmpspc + tmpbuf;
        break;
    }
    pbuf = AplLibStrUtf.aplLibEucAdjust(pbuf, pbuf.length, width).$2;
    cmImgDataAddAns(tid, ans, pbuf);
    return 0;
  }

  /// 関連tprxソース:cm_str_molding.h - マクロcm_Multi_ImgDataAdd_UnitPrice
  static void cmMultiImgDataAddUnitPrice (TprMID tid, TImgDataAdd imgDataAdd, int num,
      int ptn, int posi, int ctrlTyp, CmEditCtrl fCtrl, int count, double data) {
    cmMultiImgDataAddLL(tid, imgDataAdd, num, ptn, posi, ctrlTyp, fCtrl,
        EditTyps.EDIT_TYP_UNITPRICE.index, count, DataTyps.DATA_TYP_LONG.id, data);
  }

  /// 関連tprxソース:cm_str_molding.c - cm_Multi_ImgDataAdd_LL()
  static void cmMultiImgDataAddLL (TprMID tid, TImgDataAdd imgDataAdd, int num,
      int ptn, int posi, int ctrlTyp, CmEditCtrl fCtrl, int editTyp, int count,
      int dataTyp, double data) {
    // TODO:00011 周 中身実装待ち
  }
}