/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';

import '../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../../postgres_library/src/basic_table_access.dart';
import '../../../../postgres_library/src/pos_basic_table_access.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_log.dart';
import 'rcfncchk.dart';
import 'rcregmain.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';
import 'regs_preset_def.dart';

///
/// 関連tprxソース:Regs.c
///
class Regs {
  /// 関連tprxソース:Regs.c - RegsEnd
  static int regsEnd = 0;
}

///
/// 登録画面で初期データを取得するクラス.
///
class RegistInitData {
  // -----▼登録プリセット------------------
  /// プリセットのタブ数.
  static const _presetPageMax = 4;

  // 1つのプリセットCDで取得されるデータ数は91.
  // MEMO: 今はまだデータが仮なので不使用.
  static const _presetNumByCd = 8;
  static const _presetPluMax = _presetNumByCd - _presetPageMax;

  // -----▲登録プリセット------------------

  // -----▼登録拡張プリセット---------------
  ///　拡張商品明細(登録)のpreset_cd.
  static const _extCollectKeyCd = 2103;

  // // 拡張商品明細(小計)のpreset_cd.
  // static const _extCollectKeyCdSubttl = 2104;
  // // 拡張商品登録補助のpreset_cd.
  // static const _extRegAssist = 2105;
  // // 拡張登録補助のpreset_cd.
  // static const _extAssist = 2106;
  // // 拡張決済のpreset_cd.
  // static const _extPayment = 2107;

  /// 登録拡張プリセットの数.
  /// 関連tprxソース:rcstllcd.h SUBTOTAL_COLLECTKEYPRESET_ITM_CNT
  static const _subTotalCollectKeyPresetItmCnt = 6;

  /// 取得されたpresetデータ
  static List<PresetInfo>? presetData;
  static List<PresetInfo>? presetImgData;

  // ------▲登録拡張プリセット----------------

  static Future<void> main() async {
    await RcRegMain.rcMemGet();
  }

  /// pageNO:0~_presetPageMax
  /// return [presetCd]  pageNo * 100 + 1.
  static int _getPresetCd(int pageNo) {
    if (pageNo < 0 && _presetPageMax < pageNo) {
      return -1;
    }
    int presetCd = (pageNo + 1) * 100 + 1;
    return presetCd;
  }

  /// 関連tprxソース:Regs_Preset.c - preset_read_db()
  /// 商品登録プリセットデータを取得する.
  /// 結果が空だったらpresetNotreadLcdのエラーを呼び出し側で表示する
  static Future<List<PresetInfo>> presetReadDB() async {
    try {
      List<PresetInfo> list = <PresetInfo>[];
      var db = DbManipulationPs();
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog()
            .logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error, "rxMemRead error");
        return list;
      }
      RxCommonBuf pCom = xRet.object;
      String sql = "SELECT "
          " * "
          " FROM "
          " c_preset_mst prst"
          " WHERE "
          "	prst.comp_cd = @comp_cd AND prst.stre_cd = @stre_cd AND prst.preset_grp_cd = @preset_grp_cd"
          " ORDER BY preset_no";
      Map<String, dynamic>? subValues = {
        "comp_cd": pCom.dbRegCtrl.compCd,
        "stre_cd": pCom.dbRegCtrl.streCd,
        "preset_grp_cd": pCom.dbRegCtrl.presetGrpCd
      };
      Result mstList =
          await db.dbCon.execute(Sql.named(sql), parameters: subValues);
      if (mstList.isEmpty) {
        TprLog()
            .logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error, "no data found");
        return list;
      }
      for (int i = 0; i < mstList.length; i++) {
        Map<String, dynamic> data = mstList[i].toColumnMap();
        try {
          PresetInfo rn = PresetInfo.fromMap(data);
          list.add(rn);
        } catch (e) {
          debugPrint("Error processing data for row $i:$e");
        }
      }
      presetData = list;
      return list;
    } catch (e, s) {
      // DBエラーなど.
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
          "RegistPresetData  DB err. $e $s");
      // 空のリスト.
      return <PresetInfo>[];
    }
  }

  /// 保存されたデータを取得
  static Future<List<PresetInfo>> getPresetData() async {
    if (presetData == null) {
      return await presetReadDB();
    }
    return presetData!;
  }

  /// 関連tprxソース:Regs_Preset.c - preset_read_db()
  /// 商品登録プリセットデータを取得する.
  /// 結果が空だったらpresetNotreadLcdのエラーを呼び出し側で表示する
  static Future<List<PresetInfo>> presetImgReadDB() async {
    try {
      List<PresetInfo> list = <PresetInfo>[];
      var db = DbManipulationPs();
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog()
            .logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error, "rxMemRead error");
        return list;
      }
      RxCommonBuf pCom = xRet.object;
      String sql = "SELECT "
          "	prst.preset_grp_cd AS preset_grp_cd"
          "	,prst.preset_cd AS preset_cd"
          "	,prst.preset_no AS preset_no"
          "	,prst.presetcolor AS presetcolor"
          "	,prst.ky_cd AS ky_cd"
          "	,prst.ky_plu_cd AS ky_plu_cd"
          "	,prst.ky_smlcls_cd AS ky_smlcls_cd"
          "	,prst.ky_size_flg AS ky_size_flg"
          "	,prst.ky_status AS ky_status"
          "	,prst.ky_name AS ky_name"
          "	,img.img_num AS img_num"
          "	,img.name AS img_name"
          " FROM "
          "	c_preset_mst prst "
          " LEFT OUTER JOIN "
          "	c_preset_img_mst img "
          " ON "
          "	prst.comp_cd = img.comp_cd AND prst.img_num = img.img_num "
          " WHERE "
          "	prst.comp_cd = @comp_cd AND prst.stre_cd = @stre_cd AND prst.preset_grp_cd = @preset_grp_cd"
          " ORDER BY preset_no";
      Map<String, dynamic>? subValues = {
        "comp_cd": pCom.dbRegCtrl.compCd,
        "stre_cd": pCom.dbRegCtrl.streCd,
        "preset_grp_cd": pCom.dbRegCtrl.presetGrpCd
      };
      Result mstList =
          await db.dbCon.execute(Sql.named(sql), parameters: subValues);
      if (mstList.isEmpty) {
        TprLog()
            .logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error, "no data found");
        return list;
      }
      for (int i = 0; i < mstList.length; i++) {
        Map<String, dynamic> data = mstList[i].toColumnMap();
        try {
          PresetInfo rn = PresetInfo.fromMap(data);
          list.add(rn);
        } catch (e) {
          debugPrint("Error processing data for row $i:$e");
        }
      }
      presetImgData = list;
      return list;
    } catch (e, s) {
      // DBエラーなど.
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
          "RegistPresetImgData  DB err. $e $s");
      // 空のリスト.
      return <PresetInfo>[];
    }
  }

  /// 保存されたデータを取得
  static Future<List<PresetInfo>> getPresetImgData() async {
    if (presetImgData == null) {
      return await presetImgReadDB();
    }
    return presetImgData!;
  }

  /// 関連tprxソース:Regs_Preset.c
  /// 商品登録拡張プリセットデータを取得する.
  static Future<List<CPresetMstColumns>> getExtCollectPreset() async {
    try {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
            "preset_read_db : rxMemRead error");
        // 空データを返す.
        return <CPresetMstColumns>[];
      }
      RxCommonBuf pCom = xRet.object;

      var db = DbManipulationPs();
      String sql1 =
          "select * from c_preset_mst where comp_cd = @p1 AND stre_cd = @p2 AND preset_cd = @p3 ORDER BY preset_no";
      Map<String, dynamic>? subValues = {
        "p1": pCom.dbRegCtrl.compCd,
        "p2": pCom.dbRegCtrl.streCd,
        "p3": _extCollectKeyCd
      };
      Result result =
          await db.dbCon.execute(Sql.named(sql1), parameters: subValues);

      if (result.length < _subTotalCollectKeyPresetItmCnt) {
        // データがたりない.
        TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
            "preset_read_db subTotalCollectKeyPresetItmCnt ntuples[${result.length}]");
        // 空データを返す.
        return <CPresetMstColumns>[];
      }
      return List.generate(result.length, (i) {
        Map<String, dynamic> data = result[i].toColumnMap();
        CPresetMstColumns rn = CPresetMstColumns();
        rn.comp_cd = int.tryParse(data['comp_cd']);
        rn.stre_cd = int.tryParse(data['stre_cd']);
        rn.preset_grp_cd = int.tryParse(data['preset_grp_cd']);
        rn.preset_cd = int.tryParse(data['preset_cd']);
        rn.preset_no = data['preset_no'];
        rn.presetcolor = data['presetcolor'] ?? 0;
        rn.ky_cd = data['ky_cd'] ?? 0;
        rn.ky_plu_cd = data['ky_plu_cd'];
        rn.ky_smlcls_cd = int.tryParse(data['ky_smlcls_cd']) ?? 0;
        rn.ky_size_flg = data['ky_size_flg'] ?? 0;
        rn.ky_status = data['ky_status'] ?? 0;
        rn.ky_name = data['ky_name'];
        rn.img_num = int.tryParse(data['img_num']) ?? 0;
        rn.ins_datetime = (data['ins_datetime']).toString();
        rn.upd_datetime = (data['upd_datetime']).toString();
        rn.status = data['status'] ?? 0;
        rn.send_flg = data['send_flg'] ?? 0;
        rn.upd_user = int.tryParse(data['upd_user']) ?? 0;
        rn.upd_system = data['upd_system'] ?? 0;
        return rn;
      });
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
          "CPresetMstColumns  DB err. $e $s");
      return <CPresetMstColumns>[];
    }
  }

  /// 関連tprxソース:Regs_Preset.c - preset_Item_Chk
  static Future<bool> presetItemChk() async {
    return ((await presetItemBaseChk() || await RcSysChk.rcChk2800System()) &&
        (await RcFncChk.rcCheckItmMode() ||
            await RcFncChk.rcCheckManualMixMode()));
  }

  /// 関連tprxソース:Regs_Preset.c - preset_Item_BaseChk
  static Future<bool> presetItemBaseChk() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf cBuf = xRet.object;
//	return(C_BUF->db_trm.warn_mscrap_flg != 0);
    return cBuf.dbTrm.warnMscrapFlg != 0 &&
        !await RcSysChk.rcChkShopAndGoSystem() &&
        !await RcSysChk.rcSGChkSelfGateSystem();
  }

  // TODO:00016　佐藤　定義のみ追加
  /// 関連tprxソース:Regs_Preset.c - rcReverse_Btn_Proc
  static void rcReverseBtnProc() {}

  // TODO:00016　佐藤　定義のみ追加
  /// 関連tprxソース:Regs_Preset.c - rcPreset_Btn_First
  static void rcPresetBtnFirst() {}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:Regs.c - rcTomoIF_LibraryCheckError
  static void rcTomoIFLibraryCheckError() {}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:Regs.c - rcTomoIF_LibraryCheckError_Clear
  static void rcTomoIFLibraryCheckErrorClear() {}

  /// 税金DBを取得する.
  /// 関連tprxソース:rmdbread.c rmDbTaxRead
  static Future<List<CTaxMstColumns>> getTaxData() async {
    try {
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRet.isInvalid()) {
        TprLog()
            .logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error, "rxMemRead error");
        return <CTaxMstColumns>[];
      }
      RxCommonBuf pCom = xRet.object;
      if (pCom.dbTax.isEmpty) {
        TprLog().logAdd(
            Tpraid.TPRAID_CHK, LogLevelDefine.error, "tax_read_db no data");
      }
      return pCom.dbTax;
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
          "CTaxMstColumns DB err. $e $s");
      return <CTaxMstColumns>[];
    }
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:Regs.c - rcCAPS_PQVIC_Key_NO
  static void rcCAPSPQVICKeyNO(){}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:Regs.c - rcCAPS_PQVIC_Key_YES
  static void rcCAPSPQVICKeyYES(){}

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース:Regs.c - rcCAPS_PQVIC_KeyGetError
  static void rcCAPSPQVICKeyGetError(){}
}

/// Define
///  関連tprxソース: Regs.c
class RegsDef {
  /// DB用 (PGconn *chkr_con)
  static var chkrCon = null;

  /// DB用 (PGconn *chkr_ts_con)
  static var chkrTsCon = null;
  static TranInfo tran = TranInfo();
  static SubttlInfo subttl = SubttlInfo();
  static SubttlInfo dualSubttl = SubttlInfo();
}
