/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';


import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/apl/t_item_log.dart';
import '../../ui/socket/client/customer_socket_client.dart';
import '../common/tax_util.dart';
import '../inc/rc_regs.dart';
import '../spool/rsmain.dart';
import 'rc_chgitm_dsp.dart';
import 'rc_stl.dart';
import 'rcsyschk.dart';

/// クラウドPOSを利用する場合のPLUボタン関連のクラス.
class RcClxosCommon{

  static bool get  validClxos => Platform.isLinux && true;

  /// 商品情報の呼出正常終了後に行う処理.
  /// [data] クラウドPOSから返ってきたデータ
  /// [sendCustomerScreen] 客表側画面にデータを送るかどうか.
  /// 
  static void itemLoadAfterClxos(CalcResultWithRawJson data,{sendCustomerScreen = true}) async {
    
    //  クラウドPOSからの返り値をメモリに入れる.
    RcClxosCommon.settingMemResultData(data.result);
    if (sendCustomerScreen) {
      // 客側に商品登録メッセージを送る
      CustomerSocketClient().sendItemRegister(data.rawJson);
    }
    // スプールテンポラリファイル出力
    if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
      RsMain.rsWriteTempFile(data.rawJson);
    }

    return ;
  }

  /// クラウドPOSからの返り値をメモリに入れる.
  static void settingMemResultData(CalcResultItem result ){
    RegsMem().lastResultData  = result;
    // 各アイテムごとのデータ.
    int index = -1;

    for (ResultItemData item in RegsMem().lastResultData!.calcResultItemList!) {
      index++;
      if (item.retSts != 0) {
        // エラー
        continue;
      }

      RegsMem().tItemLog[index] = TItemLog();
      RegsMem().tItemLog[index].itemData = item;
      RegsMem().tItemLog[index].seqNo = item.seqNo!;

      if(item.type != null && item.itemKind == 1){
        // 取消.
        RegsMem().tItemLog[index].t10002.scrvoidFlg = true;
      }
      if(item.itemType != null && item.itemKind == 1){
        // 30、31は数量変更できないので、プラスマイナスボタンは非表示.
          // TODO: これに該当するtitemLogはない.
        // 通常JAN以外は、30:不定貫を返す。
        // (itemlog->bar_format_flgが1、2、5以外は不定貫)
        // １個限りMMは、31:個数変更不可を返す。
        // 無償商品の場合は必ず800を返す。


     }

      if(item.warningType != null  ){
        // TODO: alertPluFlgが近い.
        // 0以外は警告商品であることを報知
        RegsMem().tItemLog[index].t10000Sts.alertPluFlg =  item.warningType!;
      }
      // 商品コード.
      RegsMem().tItemLog[index].t10000.pluCd1_2 = item.barcode!;

      // 商品名.
      RegsMem().tItemLog[index].t10000.posName = item.name!;

      // 商品個数.
      RegsMem().tItemLog[index].t10000.realQty = item.qty!;

      // 値下げ・売価変更などのデータをセット.
      if (item.discountList != null) {
        for (var discountInfo in item.discountList!) {
          _settingMemDiscountData( index, discountInfo);
        }
      }
      if(item.taxDataList != null){
        // 非課税の場合、コードがDBと変わっているので変換する.
        RegsMem().tItemLog[index].t10000.taxTyp = TaxTypeDefine.getDefineFromClxosRetId(item.taxDataList![0].type!).id;
        RegsMem().tItemLog[index].t10000.taxPer = item.taxDataList![0].rate!.toDouble();
        RegsMem().tItemLog[index].t10000.taxCd = item.taxDataList![0].code!;
      }


      if(item.itemKind != null){
        // ItemKind=3の場合、明細部で個数変更は出来ない、明細変更で入力させる
         RegsMem().tItemLog[index].t10003.itemKind = item.itemKind!;
      }
      if(item.prcChgFlg != null){
        // 明細変更で価格変更が操作可能かのフラグ。不可の場合はボタンを非活性に
        RegsMem().tItemLog[index].t10000Sts.prcChgPflg = item.prcChgFlg!;
      }
      if(item.discChgFlg != null){
        // 明細変更で値下げが操作可能かのフラグ。不可の場合はボタンを非活性に
        RegsMem().tItemLog[index].t10000Sts.itemDscFlg = item.discChgFlg!;
      }
      if(item.decimalVal != null){
        // ItemKind=3の場合、明細部で個数変更は出来ない、明細変更で入力させる
      //  RegsMem().tItemLog[index]!.t10001.exInTabl = item.decimalVal!;
      }
      if(item.pointAddList != null){
        RegsMem().tItemLog[index].t11200 = [];
        // TODO:totalはここで初期化してはいけないと思う.
      //  RegsMem().tTtllog.t106000 = [];
       // int promIndex =0;
        for(PointAddData data in item.pointAddList!){
          if(data.type == 1){ // 商品加算.
            RegsMem().tItemLog[index].t11100.pluPointTtl = data.point!;
            RegsMem().tItemLog[index].t11100Sts.pntAddName = data.name!;
          }else if(data.type == 2){ //ロイヤリティ加算
            // TODO:ロイヤリティの場合ItemLog->11200->val or reward_val valいない
            // RegsMem().tItemLog[index]!.t11200[promIndex] = T11200();
            // RegsMem().tItemLog[index]!.t11200[promIndex]!. = data.point!;
            // RegsMem().tTtllog.t106000.promName = data.name!;
          }

        }

      }
      // 商品単価.
      // クラウドPOS のL1581 売価変更の場合、入る所が違うかも.
      RegsMem().tItemLog[index].t10003.uPrc = item.price!;
      if( RegsMem().tItemLog[index].t10400.itemPrcChgFlg == 2 // 売価変更
          ||  RegsMem().tItemLog[index].t10400.itemPrcChgFlg == 4 // バーコード売価変更
          || (RcStl.rcChkItmRBufTermBrgnTyp(index))				// マークダウンと期間売変売価
          || (RegsMem().tItemLog[index].t10500.clsDscFlg == 1)		// 分類一括売価
          || (RegsMem().tItemLog[index].t10500.clsDscFlg == 5)){		// 会員分類一括売価){
        // クラウドPOS のL1581 売価変更の場合、入る所が違うかも.
        RegsMem().tItemLog[index].t10003.uusePrc = item.price!;
      }else{
        // クラウドPOS のL1581 売価変更の場合、入る所が違うかも.
        RegsMem().tItemLog[index].t10003.uPrc = item.price!;
      }
    }
    RegsMem().tTtllog.t100001.stlTaxInAmt = RegsMem().lastTotalData?.amount ?? 0;
    RegsMem().tTtllog.calcData.stlTaxAmt  =  RegsMem().tTtllog.t100001.stlTaxInAmt;

    RegsMem().tTtllog.t100001Sts.itemlogCnt = index+1;
    //tODOBaseAmoutやDiscountList
      //TODO:custdata
  }
 /// クラウドPOSからの返り値のうち、価格変更情報をメモリに入れる.
 static void _settingMemDiscountData(
      int index, DiscountData discount) {
    switch (discount.type) {
      case 1: // 特売.
        RegsMem().tItemLog[index].t10100.brgnCd = discount.code!;
        RegsMem().tItemLog[index].t10100Sts.brgnName = discount.name!;
        RegsMem().tItemLog[index].t10100.brgnDscAmt = discount.discountPrice!;
        break;
      case 2: //  FNo.10800 : ミックスマッチ
        RegsMem().tItemLog[index].t10800.bdlCd = discount.code!;
        RegsMem().tItemLog[index].t10800Sts.bdlName = discount.name!;
        RegsMem().tItemLog[index].t10800.bdlDscPdamt = discount.discountPrice!;
        RegsMem().tItemLog[index].t10800.bdlFlg = discount.formedFlg!;
        break;
      case 3: // FNo.10900 : セットマッチ
        RegsMem().tItemLog[index].t10900.stmCd = discount.code!;
        RegsMem().tItemLog[index].t10900Sts.stmName = discount.name!;
        RegsMem().tItemLog[index].t10900.stmDscPdamt = discount.discountPrice!;
        RegsMem().tItemLog[index].t10900.stmFlg = discount.formedFlg!;
        break;
      case 4: //  FNo.10500 : 分類値下
        RegsMem().tItemLog[index].t10500.clsSchcd == discount.code!;
        RegsMem().tItemLog[index].t10500Sts.clsdscName = discount.name!;
        RegsMem().tItemLog[index].t10500.clsDscAmt = discount.discountPrice!;

        break;
      case 5: //  FNo.10200 : 値引
        RegsMem().tItemLog[index].t10200.itemDscCd == discount.code!;
        // 入れるところがない.
        //      RegsMem().tItemLog[index]!.t10200Sts.clsdscName = discount.name;
        RegsMem().tItemLog[index].t10200.itemDscAmt = discount.discountPrice!;
        break;
      case 6: //  FNo.10300 : 割引
        RegsMem().tItemLog[index].t10300.itemPdscCd = discount.code!;
        // 入れるところがない.
        //      RegsMem().tItemLog[index]!.t10200Sts.clsdscName = discount.name;
        RegsMem().tItemLog[index].t10300.itemPdscAmt = discount.discountPrice!;
        break;
      case 7: //  売価変更
        RegsMem().tItemLog[index].t10400.itemPrcChgFlg = discount.code!;
        // 入れるところがない.
        //      RegsMem().tItemLog[index]!.t10200Sts.clsdscName = discount.name;
        RegsMem().tItemLog[index].t10400.itemPrcChgAmt =
            discount.discountPrice!;
        break;
      case 8: //  会員売価
        //   RegsMem().tItemLog[index]!.t10400.itemPrcChgFlg = int.tryParse(discount.code) ?? 0;
        // 入れるところがない.
        //      RegsMem().tItemLog[index]!.t10200Sts.clsdscName = discount.name;
        RegsMem().tItemLog[index].t11000.mpriDscAmt = discount.discountPrice!;
        break;
      default: // その他
      // airpos_calc_main.c L1811
      //         { 10, (long*)&otoArrayInfo[LOY_SVSTYP_AMT].SvsType, "", otoArrayInfo[LOY_SVSTYP_AMT].PlanName, &otoArrayInfo[LOY_SVSTYP_AMT].Dsc },
      // { 11, (long *)&otoArrayInfo[LOY_SVSTYP_DSC].SvsType, "", otoArrayInfo[LOY_SVSTYP_DSC].PlanName, &otoArrayInfo[LOY_SVSTYP_DSC].Dsc },
      // { 12, (long *)&otoArrayInfo[LOY_SVSTYP_PDSC].SvsType, "", otoArrayInfo[LOY_SVSTYP_PDSC].PlanName, &otoArrayInfo[LOY_SVSTYP_PDSC].Dsc },
      //         break;
    }
  }

  /// 商品情報の呼出
  /// Process.run起動でエラーが発生した場合はPROC_ERROR_STS,PROC_ERROR_MSGの値を返す。
  static Future<CalcResultWithRawJson> stabItem(CalcRequestParaItem para) async {
    //元のJSON文字列を格納する変数の初期化
    String rawJson = '';
    CalcResultItem result =  CalcResultItem(retSts: 0,errMsg: "",posErrCd: null,calcResultItemList:[],totalDataList:null,custData: null,subttlList:null);


    // 実際のjsonを復帰させる場合は下記を有効にする
    // String rawJson = r'''{"RetSts":0,"ErrMsg":"","ItemList":[{"RetSts":0,"ErrMsg":"","PosErrCd":0,"SeqNo":1,"Type":0,"ItemType":0,"WarningType":0,"Barcode":"2501012001729","OrgBarcode1":"2501012001729","OrgBarcode2":"","Name":"にら　束","Price":195,"Qty":1,"RealQty":1,"ItemKind":0,"ItemDscType":1,"ItemDscVal":10,"ItemDscCode":39,"ClsNo":0,"Weight":0,"DiscountList":[{"Type":5,"Code":39,"Name":"値引","DiscountPrice":10,"FormedFlg":1}],"TaxList":[{"Type":0,"Rate":8,"Code":1}],"ScanTime":"2024-09-16 13:22:47"}],"TotalData":[{"Amount":179,"TotalQty":1,"RefundFlag":0,"BaseAmount":185,"Subtotal":185,"SubDscAmount":20,"ExTaxAmount":14,"DiscountList":[{"Type":0,"DiscountPrice":10},{"Type":5,"DiscountPrice":10}]}]}''';
    // CalcResultItem result =  CalcResultItem.fromJson(jsonDecode(rawJson));
    // result.calcResultItemList = [];
    try {
      int totalQty = 0;
      int sum = 0;
      for(var paraItem in para.itemList){
        ResultItemData item = ResultItemData(retSts:0,errMsg: "",posErrCd: null,seqNo:paraItem.seqNo,type: null,itemType:0,warningType: 0,barcode: paraItem.barcode1,
            orgBarcode1: paraItem.barcode1,orgBarcode2:null,name :"名前",price:200,qty:paraItem.qty,discountList: [], taxDataList: null, scanTime: '', itemKind: null, itemDscType: null, itemDscVal: null, itemDscCode: null, prcChgVal: null, prcChgFlg: null, discChgFlg: null, decimalVal: '', clsNo: 0, clsVal: null, pointAddList: [],);
        item.price = 200;
        item.qty = paraItem.qty;
        item.name = "クラウドPOS非対応のため仮";
        item.seqNo = paraItem.seqNo;
        item.type = paraItem.type;
        item.retSts = 0;
        if(paraItem.prcChgVal != null && paraItem.prcChgVal != -1){
          item.prcChgVal = paraItem.prcChgVal;
          item.prcChgFlg  =1;
        }
        if(paraItem.itemDscType != null  && paraItem.itemDscType != -1){
          item.discountList ??= [];
          int descType = paraItem.itemDscType! == DscChangeType.dsc.index ? 5:6;
          String descName = paraItem.itemDscType! == DscChangeType.dsc.index ? "値引き":"割引";
          item.discountList?.add(DiscountData(type:descType,discountPrice:paraItem.itemDscVal,name:descName, code: 0, formedFlg: null));
          item.discountList?.add(DiscountData(type:descType,discountPrice:paraItem.itemDscVal,name:descName, code: 0, formedFlg: null));

        }
        if (paraItem.type != 1) {
          sum +=  item.price! * item.qty!;
          totalQty += item.qty!;
        }
        result.calcResultItemList!.add(item);
       }
      if (para.refundFlag == 1){
        sum = sum * -1;
        totalQty *= -1;
      }
      result.totalDataList ??= [];
      result.totalDataList!.add(TotalData(amount:sum, totalDataDiscountList: [],baseAmount: 0, totalQty: totalQty, refundFlag: para.refundFlag, subtotal: sum, subDscAmount:0, exTaxAmount: 0,));

      result.retSts = 0;
      rawJson = jsonEncode(result.toJson());

    } catch (e) {

    }
    return CalcResultWithRawJson(rawJson: rawJson, result:  result);
  }

}



/// 客表にJSONも一緒に返せるように新しい返り値の定義
class CalcResultWithRawJson {
  final String rawJson;
  final CalcResultItem result;

  CalcResultWithRawJson({required this.rawJson, required this.result});
}
