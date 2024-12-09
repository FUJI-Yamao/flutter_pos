/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/sys/recogkey/recogkey.dart';
import 'package:flutter_pos/app/sys/recogkey/recogkey_define.dart';
import 'package:flutter_pos/postgres_library/src/db_manipulation_ps.dart';
import 'package:sprintf/sprintf.dart';

import '../../inc/sys/tpr_log.dart';
import '../../lib/apllib/rx_prt_flag_set.dart';

/// 承認キー　解放確認画面バックエンド.
/// 最初の画面描画時にRecogkeySub(bi,recogkeySaveDes)でオブジェクトを作成し、
/// 作成したオブジェクトから各関数を呼んでください.
///  関連tprxソース:  recogkey_sub.c
class RecogkeySub{

  ///  関連tprxソース:  recogkey_sub.c - recogkey_sub_bi_st
  final int _bi;

  // HDDに保存する承認キー
  final String _recogkeySaveDes;
  // TODO:多言語へ置き換え
  static const RECOGKEY_ERRLABEL = "取得できません。機能番号%d";

  RecogkeySub(this._bi,this._recogkeySaveDes);

  /// 承認キーの名前リスト[recogkeyFuncList]を返す.リストの取得が成功したかどうかを[isSuccess]で返す
  /// 関連tprxソース: recogkey_sub.c - recogkey_sub_get_func()
  Future<(bool isSuccess, List<String> recogkeyFuncList)> getRecogKeyFuncList() async {
    TprLog().logAdd(RecogkeyDefine.RECOGKEY_LOG, LogLevelDefine.normal,
        "recogkey: recogkey_sub_get_func");

    // 表示する承認キー名.
    List<String> recogkeyFuncList = <String>[];

    // get page number
    int pageNum = Recogkey.recogkeyGetFlagPage(_bi);

    // ポジション.
    int posi = 0;
    try{
      // DB接続.
      DbManipulationPs db = DbManipulationPs();

      for(int iLoop = 0; iLoop < RecogkeyDefine.RECOGKEY_BIT_LOOP_MAX; iLoop++){
          int biTmp =  (_bi >> (3 - iLoop) * 8) & 0x000000ff;
          // 最後のループは2.
          int functionLoopMax = (iLoop == RecogkeyDefine.RECOGKEY_BIT_LOOP_MAX - 1) ? 2 : 8;
          for(int i=0; i < functionLoopMax; i++){
            int biData = (biTmp >> i) & 0x00000001;
            posi = i + (iLoop * 8) + 1;
            if(biData != 0){
              continue;
            }

            // RecogkeyDefine.RECOGKEY_SQL_RECOG_GET
            String sql1 = "select recog_name from p_recog_mst where page = @p1 and posi = @p2";
            Map<String, dynamic>? subValues = {"p1" : pageNum,"p2" : posi};

            Result result = await db.dbCon.execute(Sql.named(sql1),parameters:subValues);

            if(result.isEmpty){
              // データが取得できなかったらエラーとして返す.
              TprLog().logAdd(RecogkeyDefine.RECOGKEY_LOG, LogLevelDefine.error,
                  "recogkeySubGetFunc(): db_PQexec() p_recog_mst query error (page=$pageNum,posi=$posi) no data");
              return (false,recogkeyFuncList);
            }
            Map<String, dynamic> data = result.first.toColumnMap();
            if(data["recog_name"] == null){
              // 名前が設定されていなかったときは、エラーログをだし、取得できなかった文言を表示する.
              TprLog().logAdd(RecogkeyDefine.RECOGKEY_LOG, LogLevelDefine.error,
                  "recogkeySubGetFunc(): recogkey:p_recog_mst recog_name is null (page=$pageNum,posi=$posi)");
              recogkeyFuncList.add( sprintf(RECOGKEY_ERRLABEL,[posi]));
            }else if(data["recog_name"].isEmpty){
              recogkeyFuncList.add( sprintf(RECOGKEY_ERRLABEL,[posi]));
            }else{
               // 値が設定されているのでその値をセット.
              recogkeyFuncList.add(data["recog_name"]!);
            }

          }
      }
    }catch(e,s){
      TprLog().logAdd(RecogkeyDefine.RECOGKEY_LOG, LogLevelDefine.error,
          "recogkeySubGetFunc(): db_PQexec() p_recog_mst query error (page=$pageNum,posi=$posi) $e,$s");
      return (false,recogkeyFuncList);
    }
    return  (true,recogkeyFuncList);
  }

  /// 承認キーの解放処理.
  /// 関連tprxソース: recogkey_sub.c - recogkey_sub_func_main()
  Future<bool> recogkeySubFuncMain() async {
    List<int> sFlag = List.filled(RecogkeyDefine.RECOGKEY_BIT_MAX, 0);

    // get bit data
    int tmpBi= _bi;
    for(int i=0; i < RecogkeyDefine.RECOGKEY_BIT_MAX; i++){
      sFlag[3-i] = tmpBi & 0x000000FF;
      tmpBi >>= 8;
    }
    // get page number
    int pageNum = Recogkey.recogkeyGetFlagPage(_bi);

    String hexStr ="";
    for (var element in sFlag) {
      // それぞれ16進数に直して連結.
      hexStr += sprintf("%02x",[element]);
    }
    RecogKeySetIniRet  ret = await RxPrtFlagSet.recogkeySetFuncIni(pageNum, hexStr,_recogkeySaveDes );
    if(ret != RecogKeySetIniRet.SUCCESS){
      TprLog().logAdd(RecogkeyDefine.RECOGKEY_LOG, LogLevelDefine.error,
          "recogkey_sub_func_yes:recogkey_set_func_ini error ${ret.name} (page$pageNum)");
      return false;
    }

    return true;
  }
}
