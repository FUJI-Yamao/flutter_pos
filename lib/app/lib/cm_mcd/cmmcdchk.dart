
import '../../../dummy.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/date_util.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/mcd.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../cm_ary/chk_digit.dart';
import '../cm_mbr/cmmbrsys.dart';

class Cmmcdchk {

  // 関連tprxソース:cmmcdchk.c - cm_mcd_Check_Op()
  static int cmMcdCheckOp(int inpFlg, String inpData, String mbrCd,
      String cardData) {
    RxCommonBuf pComBuf = RxCommonBuf();
    String codeBuf = '0' * (16 + 1);
    String dateBuf = '0' * (4 + 1);
    String nowDate = '0' * (4 + 1);
    String work = '0' * (128 + 1);
    int len;
    int kind, chk;
    int forbidden, dataLen;
    String nowdate = '0' * (9 + 1);
    int chkFlg; // 0x01：新ID  0x02: opcカード
    String cardBuf = '0' * (128 + 1);

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.result != RxMem.RXMEM_OK) {
      return DlgConfirmMsgKind.MSG_SYSERR.dlgId;
    }

    work = inpData;
    len = work.length;

    cardBuf = '0' * (128 + 1);
    codeBuf = '0' * (16 + 1);
    codeBuf = '0' * (16 + 1);
    dateBuf = '0' * (4 + 1);
    nowdate = '0' * (9 + 1);
    DateUtil.dateTimeChange(nowdate
        , DateTimeChangeType.DATE_TIME_CHANGE_SYSTEM
        , DateTimeFormatKind.FT_YYYYMMDD
        , DateTimeFormatWay.DATE_TIME_FORMAT_ZERO);
    if (nowdate.compareTo('20200128') > 0) {
      forbidden = 1;
    } else {
      forbidden = 0;
    }

    kind = 0;
    chkFlg = 0;
    dataLen = 0;
    switch (inpFlg) {
      case 1: // JIS1
        return DlgConfirmMsgKind.MSG_CARD_NOTUSE2.dlgId;

      case 5: // JIS2
        if (len < 30) {
          return DlgConfirmMsgKind.MSG_MBRNOMISTAKE.dlgId;
        }
        dataLen = 69;
        if (work.substring(10, 16) == '000000') {
          codeBuf = '0' * 4 + work.substring(27, 29) + work.substring(16, 26);
          kind = 1;
        }
        else {
          if (len < 44) {
            return DlgConfirmMsgKind.MSG_MBRNOMISTAKE.dlgId;
          }
          if (work.substring(43, 44) == '8' ||
              work.substring(57, 61) == '6670') {
            if (len < dataLen) {
              return DlgConfirmMsgKind.MSG_MBRNOMISTAKE.dlgId;
            }
            chkFlg |= 0x01; // 新IDカード
            kind = 1;
            codeBuf = '0' * 4 + work.substring(43, 44) + work.substring(57, 68);
          } else {
            codeBuf = work.substring(10, 26);
            dateBuf = work.substring(39, 43);
          }
        }
        cardBuf = work.substring(0, dataLen);
        break;

      case 7: // バーコード
        if (len != 16) {
          return DlgConfirmMsgKind.MSG_BARFMTERR.dlgId;
        }
        dataLen = 16;
        codeBuf = '0' * 4 + work.substring(0, 12);
        dateBuf = work.substring(14, 16) + work.substring(12, 14);
        kind = 1;
        chkFlg |= 0x01;
        cardBuf = work.substring(0, dataLen);
        break;

      case 8: // manual
        dataLen = 12;
        switch (len) {
          case 12:
            codeBuf = '0' * 4 + work.substring(0, 12);
            kind = 1;
            break;
          case 11:
            codeBuf = '0' * 5 + work.substring(0, 11);
            kind = 1;
            break;
          case 20:
            if (forbidden != 0) {
              return DlgConfirmMsgKind.MSG_OPC_FORBIDEN_ERR.dlgId;
            }
            codeBuf = work.substring(0, 16);
            dateBuf = work.substring(16, 18) + work.substring(18, 20);
            dataLen = 16;
            break;
          case 16: // 新ID（OPC）
            codeBuf = '0' * 4 + work.substring(0, 12);
            dateBuf = work.substring(12, 14) + work.substring(14, 16);
            kind = 1;
            chkFlg |= 0x01;
            break;
          default:
            return DlgConfirmMsgKind.MSG_MBRNOMISTAKE.dlgId;
        }
        cardBuf = '0' * dataLen;
        if (len == 11) {
          cardBuf = cardBuf.replaceRange(1, dataLen, work);
        } else {
          cardBuf = work.substring(0, dataLen);
        }
        break;

      default:
        return DlgConfirmMsgKind.MSG_SYSERR.dlgId;
    }

    if (ChkDigit.cmChkDigit(codeBuf, 16) == false) {
      return DlgConfirmMsgKind.MSG_DATATYPEERR.dlgId;
    }

    if (dateBuf.isNotEmpty) {
      if (ChkDigit.cmChkDigit(dateBuf, 4) == false) {
        return DlgConfirmMsgKind.MSG_DATATYPEERR.dlgId;
      }
    }

    chk = 1; // mag_ecft_trm_chk=0に設定された場合はchk不定値になる為ここに移動
    if (pComBuf.dbTrm.magEcftTrmChk != 0) {
      if (kind != 0) {
        if (codeBuf == '000051') chk = 0;
        if (codeBuf == '0000010') chk = 0;
        if (codeBuf == '0000011') chk = 0;
        if (codeBuf == '0000012') chk = 0;
        if (codeBuf == '0000013') chk = 0;
        if (codeBuf == '0000014') chk = 0;
        if (codeBuf == '0000015') chk = 0;
        if (codeBuf == '0000016') chk = 0;
        if (codeBuf == '0000017') chk = 0;
        if (codeBuf == '0000018') chk = 0;
        if (codeBuf == '00000190') chk = 0;
        if (codeBuf == '00000197') chk = 0;
        if (codeBuf == '00000198') chk = 0;
        if (codeBuf == '00000199') chk = 0;
        if (codeBuf == '00002') chk = 0;
        if (chk == 0 && inpFlg == 8 && len == 16) {
          return DlgConfirmMsgKind.MSG_MBRNOMISTAKE.dlgId;
        }

        if (chkFlg & 0x01 != 0) {
          if (codeBuf == '0000831') chkFlg |= 0x02;
          if (codeBuf == '0000832') chkFlg |= 0x02;
          if (codeBuf == '0000833') chkFlg |= 0x02;
          if (codeBuf == '0000834') chkFlg |= 0x02;
          if (codeBuf == '0000841') chkFlg |= 0x02;
          if (codeBuf == '0000842') chkFlg |= 0x02;
          if (codeBuf == '0000843') chkFlg |= 0x02;
          if (codeBuf == '0000844') chkFlg |= 0x02;
          if (codeBuf == '0000851') chkFlg |= 0x02;
          if (codeBuf == '0000852') chkFlg |= 0x02;
          if (codeBuf == '0000853') chkFlg |= 0x02;
          if (codeBuf == '0000854') chkFlg |= 0x02;
          if (codeBuf == '0000861') chkFlg |= 0x02;
          if (codeBuf == '0000862') chkFlg |= 0x02;
          if (codeBuf == '0000871') chkFlg |= 0x02;
          if (codeBuf == '0000872') chkFlg |= 0x02;
          if (codeBuf == '0000873') chkFlg |= 0x02;
          if (codeBuf == '0000874') chkFlg |= 0x02;
          if (codeBuf == '0000881') chkFlg |= 0x02;
          if (codeBuf == '0000882') chkFlg |= 0x02;
          if (chkFlg & 0x02 != 0) chk = 0;
        }
      } else {
        if (codeBuf.compareTo('354290000001') >= 0 &&
            codeBuf.compareTo('354290499899') <= 0) chk = 0;
        if (codeBuf.compareTo('354089010001') >= 0 &&
            codeBuf.compareTo('354089999899') <= 0) chk = 0;
        if (codeBuf.compareTo('354189010001') >= 0 &&
            codeBuf.compareTo('354189999899') <= 0) chk = 0;
        if (codeBuf.compareTo('354069900001') >= 0 &&
            codeBuf.compareTo('354069999899') <= 0) chk = 0;
        if (codeBuf.compareTo('354258900001') >= 0 &&
            codeBuf.compareTo('354258999899') <= 0) chk = 0;
        if (codeBuf.compareTo('354169900001') >= 0 &&
            codeBuf.compareTo('354169999899') <= 0) chk = 0;
        if (codeBuf.compareTo('498660000001') >= 0 &&
            codeBuf.compareTo('498660999799') <= 0) chk = 0;
        if (codeBuf.compareTo('520860000001') >= 0 &&
            codeBuf.compareTo('520860889799') <= 0) chk = 0;
        if (codeBuf.compareTo('456660000001') >= 0 &&
            codeBuf.compareTo('456660999799') <= 0) chk = 0;
        if (codeBuf.compareTo('529660000001') >= 0 &&
            codeBuf.compareTo('529660999799') <= 0) chk = 0;
        if (codeBuf.compareTo('520860890001') >= 0 &&
            codeBuf.compareTo('520860989999') <= 0) chk = 0;

        /* test card */
        if (codeBuf.compareTo('354290499900') >= 0 &&
            codeBuf.compareTo('354290499999') <= 0) chk = 0;
        if (codeBuf.compareTo('354089999900') >= 0 &&
            codeBuf.compareTo('354089999999') <= 0) chk = 0;
        if (codeBuf.compareTo('354189999900') >= 0 &&
            codeBuf.compareTo('354189999999') <= 0) chk = 0;
        if (codeBuf.compareTo('354069999900') >= 0 &&
            codeBuf.compareTo('354069999999') <= 0) chk = 0;
        if (codeBuf.compareTo('354258999900') >= 0 &&
            codeBuf.compareTo('354258999999') <= 0) chk = 0;
        if (codeBuf.compareTo('354169999900') >= 0 &&
            codeBuf.compareTo('354169999999') <= 0) chk = 0;
        if (codeBuf.compareTo('498660999801') >= 0 &&
            codeBuf.compareTo('498660999999') <= 0) chk = 0;
        if (codeBuf.compareTo('520860990001') >= 0 &&
            codeBuf.compareTo('520860999999') <= 0) chk = 0;
        if (codeBuf.compareTo('456660999801') >= 0 &&
            codeBuf.compareTo('456690999999') <= 0) chk = 0;
        if (codeBuf.compareTo('529660999801') >= 0 &&
            codeBuf.compareTo('529660999999') <= 0) chk = 0;
        if (codeBuf.compareTo('520860990001') >= 0 &&
            codeBuf.compareTo('520860999999') <= 0) chk = 0;

        if (chk == 0) chkFlg |= 0x02;
      }
      if (chkFlg & 0x02 != 0) {
        if (inpFlg == 5 && forbidden != 0) {
          return DlgConfirmMsgKind.MSG_OPC_FORBIDEN_ERR.dlgId;
        }

        if (chk == 0) {
          chk = 2;
          if (dateBuf.substring(2, 4).compareTo('01') >= 0 &&
              dateBuf.substring(2, 4).compareTo('12') <= 0) {
            int tim = DateTime
                .now()
                .millisecondsSinceEpoch;
            DateTime sysdate = DateTime.fromMillisecondsSinceEpoch(tim);
            nowDate =
            '${(sysdate.year + 1900) % 100}${sysdate.month.toString().padLeft(
                2, '0')}';

            if (dateBuf.substring(0, 2).compareTo('85') >= 0 &&
                dateBuf.substring(0, 2).compareTo(nowDate) <= 0) {
              chk = 0;
            }
          } else {
            chk = 3;
          }
        }
        if (chk == 0 && chkFlg & 0x01 != 0 && inpFlg == 5) {
          cardBuf = cardBuf.replaceRange(2, 10, ' ' * 8);
          cardBuf = cardBuf.replaceRange(16, 43, ' ' * 27);
        }
      }
    }

    if (chk == 1) {
      return DlgConfirmMsgKind.MSG_CANT_FELICA.dlgId;
    }
    if (chk == 2) {
      return DlgConfirmMsgKind.MSG_GOODTHRUERR.dlgId;
    }
    if (chk == 3) {
      return DlgConfirmMsgKind.MSG_INPUTERR.dlgId;
    }

    mbrCd = codeBuf;
    cardData = cardBuf;

    return 0;
  }

  // 関連tprxソース:cmmcdchk.c - cm_mcd_Check_TS3()
  static int cmMcdCheckTS3(String cardBuf) {
    String cardNo = cardBuf.substring(0, MAG_CD_MAX);
    int retType = 0;

    int cardNoLL = int.parse(cardNo);
    return retType;
  }

  // 関連tprxソース:cmmcdchk.c - cm_mcd_typechk()
  static Future<int> cmMcdTypeChk(String cardBuf) async {
    if (cardBuf[Mcd.MCD_RLSCKCDST] == Mcd.MCD_RLSSTAFFCD) {
      return Mcd.MCD_RLSSTAFF;
    }
    else if (cardBuf[Mcd.MCD_RLSCKCDST] == Mcd.MCD_RLSCARDCD) {
      return Mcd.MCD_RLSCARD;
    }
    else if (cardBuf[Mcd.MCD_RLSCKCDST] == Mcd.MCD_RLSCRDTCD) {
      if (cardBuf[Mcd.MCD_RLSCKCRDTCDST] == Mcd.MCD_RLSCRDTCD2) {
        return Mcd.MCD_RLSCRDT;
      }
    }
    else if ((cardBuf[Mcd.MCD_RLSCKCDST] == Mcd.MCD_RLSVISACD)
        && (await CmMbrSys.cmNewARCSSystem() != 0)) {
      if (cardBuf[Mcd.MCD_RLSCKVISACDST] == Mcd.MCD_RLSVISACD2) {
        return Mcd.MCD_RLSVISA;
      }
    }
    return Mcd.MCD_RLSOTHER;
  }
}