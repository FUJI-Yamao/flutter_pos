/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../db_library/src/db_manipulation.dart';
import '../../inc/lib/jan_inf.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';

class Jan{

  /// 全日食生鮮ZFSP用の情報をセット
  /// 関連tprxソース: jan.c - cm_Fresh_ZFSP_jan
  static void cmFreshZFSPJan(JANInf Ji,int digit) {
    cmSetJanData(Ji, digit, JANInfConsts.JANformatFreshZfsp.value,
        JANInfConsts.JANtypeFreshZfsp.value, JANInfConsts.JANtypeFreshZfsp);
    if (Ji.type != JANInfConsts.JANformatFreshZfsp.value) {
      Ji.flag = '0';
    }
    Ji.price = 0;
  }

  /// キャッシュリサイクルバーコードかチェックし、フラグを設定する
  /// 関連tprxソース: jan.c - cm_cash_recycle_jan
  static void cmCashRecycleJan(JANInf Ji,int digit) {
    cmSetJanData(Ji, digit, JanInfDefine.barTypCashRecycleInout,
        JanInfDefine.janTypeCashRecycle, JANInfConsts.JANtypeCashRecycleInout);
    if (Ji.type != JANInfConsts.JANtypeCashRecycleInout) {
      Ji.flag = '0';
    }
  }

  //
  //	関数: cm_set_jan_data()
  //	機能: 引数の桁数(digit)分を, JAN_inf構造体のFlagにセット.
  //	      引数のフォーマットタイプ, フォーマット番号に合致したinstreマスタがあった場合, JAN_inf構造体のTypeにjanTypをセット
  //	引数: JAN_inf  バーコード情報格納構造体
  //	      digit    フラグ桁数
  //	      formatTyp  フォーマットタイプ
  //	      formatNo   フォーマット番号
  //	      janTyp     セットタイプ
  //	注意: 確認可能なのは1フォーマット, 1フォーマット番号なので複数には対応していない
  //
  ///関連tprxソース: jan.c - cm_set_jan_data
  static void cmSetJanData(JANInf Ji,int digit,int formatTyp,int formatNo,JANInfConsts janTyp){
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pComBuf = xRet.object;

    // 初期化
    Ji.type = JANInfConsts.JANtype;
    Ji.format = 0;
    //   if (rxMemPtr(RXMEM_COMMON, (void **)&pComBuf) != RXMEM_OK) return;【dart置き換え時コメント】共有メモリのポインタセットの為、何もしない

    // データセット
    Ji.flagDigit = digit;
    Ji.flag = Ji.code;

    for(int num = 0; num < RxMem.DB_INSTRE_MAX; num++){
      if(pComBuf.dbInstre[num].format_typ == formatTyp){
        if(Ji.flag == ((pComBuf.dbInstre[num]).instre_flg).substring(0,Ji.flagDigit)){
          if(pComBuf.dbInstre[num].format_no == formatNo){
            Ji.type = janTyp;
            Ji.format = pComBuf.dbInstre[num].format_no;
            break;
          }
        }
      }
    }
  }

 //  /*
 // *   Foramt : void cm_jan8 (JAN_inf *Ji);
 // *   Input  : JAN_inf *Ji - Address of JAN Information
 // *   Output : void
 // */
  ///関連tprxソース: jan.c - cm_jan8
  static void cmJan8(JANInf Ji){
    Ji.flagDigit = 2;
    Ji.flag = Ji.code.substring(0,Ji.flagDigit);
    Ji.type = JANInfConsts.JANtypeJan8;
    Ji.format = 10;
    Ji.price = 0;
  }

  /// フォーマットNoからインストア情報を取得する（バーコード作成などに用いる）
  /// 引数: フォーマットNo
  /// 戻り値: [int] 0=取得失敗  1=取得成功
  /// 戻り値: []
  /// 関連tprxソース: jan.c - cm_Get_db_instre
  static (int, CInstreMstColumns) cmGetDbInstre(int formatNo) {
    CInstreMstColumns dbInstre = CInstreMstColumns();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return (0, dbInstre);
    }
    RxCommonBuf cBuf = xRet.object;

    if (formatNo <= 0) {
      return (0, dbInstre);
    }
    for (int i=0; i<RxMem.DB_INSTRE_MAX; i++) {
      if (cBuf.dbInstre[i].format_no == formatNo) {
        dbInstre = cBuf.dbInstre[i] as CInstreMstColumns;
        return (1, dbInstre);
      }
    }
    return (0, dbInstre);
  }
}