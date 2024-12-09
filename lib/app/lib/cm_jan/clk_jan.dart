/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/jan_inf.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../cm_sys/cm_cksys.dart';
import '../cm_sys/cm_stf.dart';

class ClkJan{
  //   /*----------------------------------------------------------------------*
  //  *	Clerk bar code mask data table
  //  *----------------------------------------------------------------------*/
  // /*
  // 		Set clerk bar code information
  // */
  ///関連tprxソース: clk_jan.c - cm_clk
  static Future<void> cmClk(JANInf ji,int flag) async {
    if (flag == 0
      && await CmCksys.cmNW7StaffSystem() != 0
      && ji.code.contains('N')
    ) { /* NW-7従業員バーコード用  */
      if(ji.code.contains("Na") ||
        ji.code.contains("NA")
      ) {
        ji.type = JANInfConsts.JANtypeClerk;
        ji.format = 136;
      }
      return;
    }

    cmSetClkFlag(ji);
    if(ji.flagDigit != flag) {
      ji.type = JANInfConsts.JANtype;
      ji.format = 0;
      ji.flagDigit = 0;
      ji.flag = "";
    }
    cmSetClkType(ji);
    if(ji.type != JANInfConsts.JANtypeClerk) {
      ji.flag = "";
    }
    ji.price = 0;
  }

  /// 関連tprxソース: clk_jan.c - cm_set_clk_flag
  static void cmSetClkFlag (JANInf ji) {
    ji.flagDigit = 2;
    if (ji.flag.length > ji.flagDigit) {
      ji.flag = ji.code.substring(0, ji.flagDigit) + ji.flag.substring(ji.flagDigit);
    } else {
      ji.flag = ji.code.substring(0,ji.flagDigit);
    }
  }

  /// 機能：NW-7従業員バーコードの従業員番号取得(1～6桁まで可能です)
  /// 引数：scan_buf    スキャナから読み込んだデータ
  ///       nw7_CR_chhk 0x0d(CR)をチェックする位置
  /// 戻値：(従業員番号の長さ, 0x0d(CR)をチェックする位置)
  /// 関連tprxソース: clk_jan.c - cm_staff_NW7
  static Future<(int, int?)> cmStaffNw7(String scanBuf, int? nw7CrChk) async {
    int nw7StfStart = 0;
    String scanData = "";
    int nw7StfLen = 0;
    int nw7StfEnd = 0;
    int nw7Flg = 0;
    int stfMax = 0;

    scanData = scanBuf;
    scanData = scanData.split('').map((element) {
      if (element == 'N') {
        nw7Flg = 1;
        return element;
      } else {
        return element.toLowerCase();
      }
    }).join();

    if(nw7CrChk != null)
    {
      nw7CrChk  = 0;
    }
    if(nw7Flg == 1)
    {
      stfMax = await CmStf.apllibStaffCDInputLimit(0);
      nw7StfStart = scanData.indexOf(RegExp(r'a|A'));
      if(nw7StfStart >= 0)
      {
        nw7StfEnd = scanData.substring(nw7StfStart + 1).indexOf("a");
      }
      if((nw7StfStart >= 0)	&&
        (nw7StfEnd >= 0)	&&
        ((nw7StfEnd - (nw7StfStart + 1)) > 0)	&&
        ((nw7StfEnd - (nw7StfStart + 1)) <= stfMax))
      {
        nw7StfLen = nw7StfEnd - (nw7StfStart + 1);
        nw7CrChk = nw7StfLen + 4;  // N + [a] + [a] + CR = 4
      }
    }
    return (nw7StfLen, nw7CrChk);
  }

  /// 機能：NW-7従業員バーコードを13桁から取り出す
  /// 引数： ji  スキャナから読み込んだデータ
  ///        stfData 取得した従業員番号セット
  ///        nw7StfLen 従業員番号の長さ
  /// 関連tprxソース: clk_jan.c - cm_staff_NW7_get
  static Future<void> cmStaffNw7Get(JANInf ji, String stfData, int nw7StfLen) async {
    String stfBuf = "";
    int	stfMax = 0;
    int nw7StfStart = 0;

    stfMax = await CmStf.apllibStaffCDInputLimit(0);

    if((nw7StfLen > 0)		&&
      (stfMax >= nw7StfLen)	&&
      (ji.code.length > nw7StfLen))
    {
      nw7StfStart = ji.code.indexOf(RegExp(r'a|A'));
      if(nw7StfStart >= 0)
      {
        stfBuf = ji.code.substring(nw7StfStart + 1, nw7StfLen + 1);
        stfBuf = stfBuf.padLeft(stfMax, '0');
      }
    }

    stfData = stfBuf.substring(0, stfMax);

    return;
  }

  /// 関連tprxソース: clk_jan.c - cm_set_clk_type
  static void cmSetClkType (JANInf ji) {
    int i;

    ji.type = JANInfConsts.JANtype;
    ji.format = 0;

    RxMemRet ret = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (ret.isInvalid()) {
      return;
    }
    RxCommonBuf pComBuf = ret.object;

    if(ji.flagDigit != 2) {
      return;
    }
    for(i = 0; i < RxMem.DB_INSTRE_MAX; i++) {
      if (pComBuf.dbInstre[i].format_typ == 4) {
        if (
          ji.flag.length >= ji.flagDigit && 
          pComBuf.dbInstre[i].instre_flg.length >= ji.flagDigit &&
          ji.flag.substring(0, ji.flagDigit) == pComBuf.dbInstre[i].instre_flg.substring(0, ji.flagDigit)
        ) {
          if(pComBuf.dbInstre[i].format_no == 136) {
            ji.type = JANInfConsts.JANtypeClerk;
            ji.format = pComBuf.dbInstre[i].format_no;
            break;
          }
          if(pComBuf.dbInstre[i].format_no == 329) {
            ji.type = JANInfConsts.JANtypeClerk3;
            ji.format = pComBuf.dbInstre[i].format_no;
            break;
          }
          if(pComBuf.dbInstre[i].format_no == 76) {
            ji.type = JANInfConsts.JANtypeClerk2;
            ji.format = pComBuf.dbInstre[i].format_no;
            break;
          }
        }
      }
    }
  }
}