/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/regs/checker/rc_key_ejconf.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/component/w_move_button.dart';
import 'package:flutter_pos/app/ui/page/common/basepage/common_base.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../common/component/w_msgdialog.dart';
import '../../register/pixel/c_pixel.dart';
import '../component/w_ejconf_dealings_button.dart';
import '../component/w_ejcon_print_button.dart';
import '../component/w_ejconf_receipt_data.dart';
import 'p_ejconf_search_basepage.dart';

///記録確認初期ページ
class EJConfirmationScreen extends CommonBasePage {
  EJConfirmationScreen({
    super.key,
    required super.title,
    super.backgroundColor = BaseColor.receiptBottomColor,
  });

  @override
  Widget buildBody(BuildContext context) {
    return EJConfirmationWidget(
      backgroundColor: backgroundColor,
    );
  }
}

///記録確認初ウィジェット
class EJConfirmationWidget extends StatefulWidget {
  final Color backgroundColor;

  const EJConfirmationWidget({super.key, required this.backgroundColor});

  @override
  EJConfirmationState createState() => EJConfirmationState();
}

///記録確認初ウィジェットの状態管理
class EJConfirmationState extends State<EJConfirmationWidget> {
  ///レシートデータあるかどうか、初期状態はなしと設定
  bool hasData = false;

  ///最初のデータであるかどうか
  bool isFirstData = false;

  ///最新のデータであるかどうか
  bool isLatestData = true;

  /// ScrollControllerインスタンス作成
  final ScrollController _scrollController = ScrollController();

  ///日付と時間　レシート番号とジャーナル番号の定義
  String dateAndTime = '';
  String receiptAndJournalNumber = '';

  ///レシートデータを格納する変数
  List<String> printData = [];

  ///RcKeyEjConfのインスタンス作成
  RcKeyEjConf rcKeyEjConf = RcKeyEjConf();

  @override
  void initState() {
    super.initState();
    fetchLatestData();
  }

  ///最新のデータ取得関数
  Future<void> fetchLatestData() async {
    final (isSuccess, err) = await rcKeyEjConf.getEjRecInit();
    if (isSuccess) {
      setState(() {
        hasData = true;
        isLatestData = true;
        isFirstData = false;
        dateAndTime = rcKeyEjConf.ejConfRet.saleDatetime;
        receiptAndJournalNumber =
            '${rcKeyEjConf.ejConfRet.receiptNo} ${rcKeyEjConf.ejConfRet.printNo}';
        printData = rcKeyEjConf.ejConfRet.printData;
      });
    } else {
      setState(() {
        hasData = false;
        isLatestData = true;
        debugPrint('エラー : $err');
      });
    }
  }

  ///前の取引データ取得関数
  Future<void> fetchPrevData() async {
    final (isSuccess, err) = await rcKeyEjConf.getEjPrevRec();
    if (isSuccess) {
      setState(() {
        hasData = true;
        isLatestData = false;
        dateAndTime = rcKeyEjConf.ejConfRet.saleDatetime;
        receiptAndJournalNumber =
            '${rcKeyEjConf.ejConfRet.receiptNo} ${rcKeyEjConf.ejConfRet.printNo}';
        printData = rcKeyEjConf.ejConfRet.printData;
      });
    } else {
      setState(() {
        debugPrint('エラー : $err');
        isFirstData = true;
      });
    }
  }

  ///次の取引データ取得関数
  Future<void> fetchNextData() async {
    final (isSuccess, err) = await rcKeyEjConf.getEjNextRec();
    if (isSuccess) {
      setState(() {
        hasData = true;
        isFirstData = false;
        dateAndTime = rcKeyEjConf.ejConfRet.saleDatetime;
        receiptAndJournalNumber =
            '${rcKeyEjConf.ejConfRet.receiptNo} ${rcKeyEjConf.ejConfRet.printNo}';
        printData = rcKeyEjConf.ejConfRet.printData;
      });
    } else {
      setState(() {
        debugPrint('エラー : $err');
        isLatestData = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(88.h),
        child: Material(
          elevation: 4.0,
          child: Container(
            color: BaseColor.someTextPopupArea.withOpacity(0.7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DealingButton(
                  icon: SvgPicture.asset(
                    'assets/images/icon_back.svg',
                    width: 48.w,
                    height: 48.h,
                  ),
                  text: '前の取り引き',
                  onPressed: isFirstData
                      ? () {}
                      : () async {
                          await fetchPrevData();
                        },
                  opacity: isFirstData ? 0.4 : 1.0,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 196.w, top: 16.h),
                    child: SizedBox(
                      width: 345.w,
                      height: 80.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            dateAndTime,
                            style: const TextStyle(
                              fontSize: BaseFont.font22px,
                              fontFamily: BaseFont.familyDefault,
                              color: BaseColor.baseColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            receiptAndJournalNumber,
                            style: const TextStyle(
                              fontSize: BaseFont.font22px,
                              fontFamily: BaseFont.familyDefault,
                              color: BaseColor.baseColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                PrintButton(
                  onPrintPressed: () async {
                    EjConfQuery query = EjConfQuery();
                    final (isSuccess, _) =
                        await rcKeyEjConf.printPresEjRec(query);
                    if (!isSuccess) {
                      MsgDialog.show(
                        MsgDialog.singleButtonDlgId(
                          type: MsgDialogType.error,
                          dialogId: DlgConfirmMsgKind.MSG_SETCASETTE.dlgId,
                        ),
                      );

                      return;
                    } else {
                      debugPrint('プリント終了');
                    }
                  },
                ),
                DealingButton(
                  icon: SvgPicture.asset(
                    'assets/images/icon_next.svg',
                    width: 48.w,
                    height: 48.h,
                  ),
                  text: '次の取り引き',
                  onPressed: isLatestData
                      ? () {}
                      : () async {
                          await fetchNextData();
                        },
                  opacity: isLatestData ? 0.4 : 1.0,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 48.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 680.w,
                    decoration: const BoxDecoration(
                      color: BaseColor.receiptBottomColor,
                    ),
                    child: hasData
                        ? DataView(
                            scrollController: _scrollController,
                            receiptData: printData,
                          )
                        : const NoDataView(),
                  ),
                  SizedBox(width: 8.w),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,

            /// MoveButtonのBottom側Marginの分を考慮
            bottom: (8 - BasePixel.pix05).h,
            child: MoveButton(
              text: '取り引きを\n検索する',
              onTap: () {
                Get.to(() => EJConfirmationSearchScreen(title: '記録確認'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
