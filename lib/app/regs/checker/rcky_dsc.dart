/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rcstllcd.dart';
import 'package:get/get.dart';

import '../../../clxos/calc_api.dart';
import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../ui/menu/register/m_menu.dart';

import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/page/full_self/controller/c_full_self_register_controller.dart';
import '../../ui/page/register/controller/c_registerbody_controller.dart';
import '../../ui/page/subtotal/basepage/p_discount_setting_page.dart';
import '../../ui/page/subtotal/controller/c_subtotal_controller.dart';
import '../common/rxkoptcmncom.dart';
import 'rc_clxos.dart';
import 'rcsyschk.dart';

 ///割引／値引設定画面への遷移用クラス
 class RckyDsc {
   /// 割引／値引選択画面のボタンの表示と画面遷移の処理
   /// 引数 [title] ページタイトル
   /// 引数 [funcKey] ファンクションキー
   static Future<void> openDscSetPage(String title, FuncKey funcKey) async {
     RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
     if (xRet.isInvalid()) {
       return;
     }
     int keyId = funcKey.keyId;
     RxCommonBuf cBuf = xRet.object;
      if (Rxkoptcmncom.rxChkKeyKindPdsc(cBuf, keyId)) {
         if (Rxkoptcmncom.rxChkKoptPdscEntry(cBuf, keyId) == 1) {
           await addStlDscAndDsp(keyId,Rxkoptcmncom.rxChkKoptPdscPdscPer(cBuf, keyId));
           return;
         }
       } else if (Rxkoptcmncom.rxChkKeyKindDsc(cBuf, keyId)) {
         if (Rxkoptcmncom.rxChkKoptDscEntry(cBuf,keyId) == 1) {
            await addStlDscAndDsp(keyId,Rxkoptcmncom.rxChkKoptDscDscAmt(cBuf, keyId));
            return;
         }
       }
       /// 割引／値引設定画面を開く
       Get.to(() => DiscountSettingPage(title: title, funcKey: funcKey));
   }


  /// 小計値引/割引を追加出来るかどうか
  /// 出来ない場合はエラーコードを返す.
  static int chkAddStlDsc(){
    if(RegsMem().lastRequestData == null
    || RegsMem().tTtllog.t100001Sts.sptendCnt > 0){
      // 商品登録をしていない/ 支払い操作中である
      return  DlgConfirmMsgKind.MSG_OPEERR.dlgId;
    }
    return 0;
  }

   /// 小計値引/割引を追加する
   /// 引数 [fncCd] ファンクションコード
   /// 引数 [value]  割引率/値引額
   /// 返り値　(成功/失敗,エラーコード,APIの戻り値)
   static Future<void> addStlDscAndDsp( int fncCd , int dscValue) async {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, "addStlDscAndDsp funcCd:$fncCd dscValue:$dscValue");

         RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
     if (xRet.isInvalid()) {
       return;
     }
     RxCommonBuf cBuf = xRet.object;
     final (success, errId, resData) = await addStlDsc(fncCd,dscValue);
      if(!success || errId != 0){
        MsgDialog.show(
          MsgDialog.singleButtonDlgId(
            type: MsgDialogType.error,
            dialogId: errId,
          ),
        );
        return;
      }
      // 表示に反映する.
      try{    
        if(await RcSysChk.rcSGChkSelfGateSystem() || cBuf.iniMacInfo.select_self.kpi_hs_mode == 2){
         // フルセルフ/セミセルフの場合
          FullSelfRegisterController registBodyCntrl = Get.find();
          registBodyCntrl.setData(resData!);
        }else{
          // 通常レジ
          RegisterBodyController registBodyCntrl = Get.find();
          SubtotalController subtotalCtrl = Get.find();

          // トランザクションデータの保存（RegsMemのデータを保存）
          registBodyCntrl.saveTransactionData();
          // 小計情報を更新する
          subtotalCtrl.changeDiscountValue();
          // 表示用データのリフレッシュ.
          registBodyCntrl.refreshPurchaseData();
        }
      }catch(e){
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, "addStlDscAndDsp $e");
      }
        
      SetMenu1.navigateToPaymentSelectPage();
      return;
    
   }

    
   /// 小計値引/割引を追加する
   /// 引数 [fncCd] ファンクションコード
   /// 引数 [dscValue]  割引率/値引額
   /// 返り値　(成功/失敗,エラーコード,APIの戻り値)
   static Future<(bool,int,CalcResultItem?)> addStlDsc(int fncCd , int dscValue) async {
    int errId = chkAddStlDsc();
    if(errId != 0){
      // 商品登録をしていない場合
      return (false, errId,null);
    }
    if(RegsMem().tTtllog.t100001Sts.sptendCnt > 0){
      // 支払い操作中である場合
        return (false, DlgConfirmMsgKind.MSG_OPEERR.dlgId,null);
    }
    RegsMem().lastRequestData!.subttlList.add(SubttlData(stlDscCode:fncCd, stlDscVal:dscValue));
    CalcResultWithRawJson resultWithRawJson;
    if(!RcClxosCommon.validClxos){
      resultWithRawJson = await RcClxosCommon.stabItem(RegsMem().lastRequestData!);
    }else{
      resultWithRawJson = await CalcApi.loadItem(RegsMem().lastRequestData!);
    }
    // 全体のエラーIDを取得.
    errId = resultWithRawJson.result.getErrId();
    if (errId != 0) {
      // 何らかのエラー.
       // エラーが出た場合、追加した小計値引/割引を削除する
      RegsMem().lastRequestData!.subttlList.removeLast();
      TprLog().logAdd(
          Tpraid.TPRAID_CHK, LogLevelDefine.error, "addStlDsc $errId:${resultWithRawJson.result.errMsg} ");
      return (false,errId,null);
    }
    
    RcClxosCommon.itemLoadAfterClxos(resultWithRawJson);

    return (true,0,resultWithRawJson.result);
   }
 }