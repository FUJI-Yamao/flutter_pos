/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rxmemcustreal2.dart';
import 'package:flutter_pos/app/regs/checker/rc_atct.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmemcustreal2.dart';
import '../../inc/apl/rxmemprn.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_log.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import 'rc_atct.dart';
import 'rcsyschk.dart';

/// 関連tprxソース:C: rc_point_infinity.h - PIREQPARAM_ECUPDATE()
class PIREQPARAM_ECUPDATE {
  String pManagementNumber = ''; //管理番号
}

// ポイント利用／付与
/// 関連tprxソース:C: rc_point_infinity.h - PIREQPARAM_MBRUSE()
class PIREQPARAM_MBRUSE {
  int nUsePoint = 0; // 利用／付与ポイント数
  RXMEMCUSTREAL2_HI_MBR_REC response = RXMEMCUSTREAL2_HI_MBR_REC();
}

class RcPointInfinity {
  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_point_infinity.c - rc_PointInfinity_MbrInfoChenge()
  static int rcPointInfinityMbrInfoChenge() {
    return 0;
  }

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_point_infinity.c - rc_PointInfinity_PointUseProc()
  static int rcPointInfinityPointUseProc(TendType? tendType) {
    return 0;
  }

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// PIサーバーへのリクエスト処理
  /// 引数:[nIfType] IFの種類
  /// 引数:[pParam] リクエストパラメータ
  /// 戻り値: 0=通信成功  0以外=通信失敗
  /// 関連tprxソース: rc_point_infinity.c - rc_PointInfinity_Request()
  static int rcPointInfinityRequest(int nIfType, int pParam) {
    return 0;
  }

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rc_point_infinity.c - rc_PointInfinity_UpdateTran()
  static int rcPointInfinityUpdateTran(int nIfType, int pParam) {
    return 0;
  }

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// エラーメッセージを表示する
  /// 引数:[errCd] メッセージ番号
  /// 引数:[func1] ボタン1押下処理
  /// 引数:[msg1] ボタン1ラベル
  /// 引数:[func2] ボタン2押下処理
  /// 引数:[msg2] ボタン1ラベル
  /// 引数:[title] ダイアログタイトル
  /// 関連tprxソース: rc_point_infinity.c - rc_PointInfinity_ErrMsgDlg()
  static void rcPointInfinityErrMsgDlg(int errNo, Function func1, String msg1, Function? func2, String msg2, String title) {
    return;
  }

  /// クーポン利用データの削除処理
  /// 引数:[cpnTyp] クーポンタイプ
  /// （1:アイテム番号  2:値引額  3:割引額（小計対象） 4:加算ポイント数  5:ポイント倍率  13:割引額（アイテム対象））
  /// 引数:[nAParam] 検索条件（「-1」の場合は、該当するタイプを全て削除）
  /// 関連tprxソース:rc_point_infinity.c - rc_PointInfinity_CpnInfoDelete
  static Future<void> rcPointInfinityCpnInfoDelete(int cpnTyp,
      int nAParam) async {
    bool fDelete = false;

    RegsMem mem = SystemFunc.readRegsMem();
    if (mem.prnrBuf.wsCpnUse.count == 0) {
      return;
    }
    RxMemPrnWsCpnUseInfo pUseInfo = RxMemPrnWsCpnUseInfo(); // 利用情報詳細

    for (int nLoop = 0; nLoop < RxMemPrn.WSCPNUSE_MAX; nLoop++) {
      fDelete = false;
      pUseInfo = mem.prnrBuf.wsCpnUse.cpnInfo[nLoop];
      if (pUseInfo.fEnable == 0) {
        continue; // クーポン情報未登録
      }
      if (pUseInfo.cpnbarTyp != cpnTyp) {
        continue; // 検索タイプ不一致
      }
      if (nAParam == -1) {
        fDelete = true;
      } else {
        if ((pUseInfo.cpnbarTyp == 1) || (pUseInfo.cpnbarTyp == 13)) {
          // 特別価格クーポン
          // 割引クーポン（アイテム対象）
          if (pUseInfo.cpnItmcnt == nAParam) {
            fDelete = true;
          }
        } else {
          // 値引クーポン
          // 割引クーポン（小計対象）
          // ポイント付与クーポン
          // ポイント倍率クーポン
          if (pUseInfo.cpnbarMny == nAParam) {
            fDelete = true;
          }
        }
      }
      if (fDelete) {
        // レコード削除
        switch (pUseInfo.cpnbarTyp) {
          case 1: // 特別価格クーポン
            break;
          case 2: // 値引クーポン
          // 削除した分を減算
            if (mem.prnrBuf.wsCpnUse.cpnDscPrc > pUseInfo.cpnbarMny) {
              mem.prnrBuf.wsCpnUse.cpnDscPrc -= pUseInfo.cpnbarMny;
            } else {
              mem.prnrBuf.wsCpnUse.cpnDscPrc = 0;
            }
            break;
          case 3: // 割引クーポン
            mem.prnrBuf.wsCpnUse.cpnPmPer = 0;
            break;
          case 4: // ポイント付与クーポン
          // 削除した分を減算
            if (mem.prnrBuf.wsCpnUse.cpnPntAdd > pUseInfo.cpnbarMny) {
              mem.prnrBuf.wsCpnUse.cpnPntAdd -= pUseInfo.cpnbarMny;
            } else {
              mem.prnrBuf.wsCpnUse.cpnPntAdd = 0;
            }
            break;
          case 5: // ポイント倍率クーポン
          // 削除した分を減算
            if (mem.prnrBuf.wsCpnUse.cpnPntMag > pUseInfo.cpnbarMny) {
              mem.prnrBuf.wsCpnUse.cpnPntMag -= pUseInfo.cpnbarMny;
            } else {
              mem.prnrBuf.wsCpnUse.cpnPntMag = 0;
            }
            break;
          default:
            break;
        }
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
            "RcPointInfinity.rcPointInfinityCpnInfoDelete(): type[$cpnTyp] param[$nAParam] ->delte[$nLoop]");
        pUseInfo = RxMemPrnWsCpnUseInfo();
        pUseInfo.fEnable = 0;
        if (mem.prnrBuf.wsCpnUse.count > 0) {
          mem.prnrBuf.wsCpnUse.count--;
        }
      }
    }
  }
}