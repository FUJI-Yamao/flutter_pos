/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';
import '../../../../common/environment.dart';
import '../../../../if/if_sound.dart';
import '../../../../inc/sys/tpr_aid.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../lib/apllib/image_label_dbcall.dart';
import '../../../../lib/apllib/msg_db.dart';
import '../../../../lib/cm_sound/sound_def.dart';
import '../../../../regs/checker/rc_key.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../controller/c_drv_controller.dart';
import '../../../enum/e_screen_kind.dart';
import '../../../model/m_dialog_info.dart';
import 'w_dicisionbutton.dart';
import '../../../../inc/sys/tpr_log.dart';


/// メッセージダイアログのタイプ.
enum MsgDialogType {
  /// エラーダイアログ.
  error(BaseColor.attentionColor, "エラー"),

  /// 確認ダイアログ.
  /// /// todo Icon確認必要（3種類）
  info(BaseColor.baseColor, '確認');

  /// ダイアログのメインカラー.
  final Color color;

  ///　ダイアログのデフォルトタイトル.
  ///　タイトル指定されてない場合に使用
  final String defaultTitle;

  /// コンストラクタ
  const MsgDialogType(this.color, this.defaultTitle);

  /// エラーか否か
  bool isError() {
    return this == MsgDialogType.error;
  }
}

class MsgDlgBtnSetting {
  final String btnTxt;
  final Function? btnFunc;

  MsgDlgBtnSetting(this.btnTxt, this.btnFunc);
}

///dialogCdからメッセージを取得されてない場合は、デフォルトの'message’が表示されます
class MsgDialog extends StatefulWidget with RegisterDeviceEvent {

   @override
  MsgDialogState createState() => MsgDialogState();

  ///　コンストラクタ.
  /// 名前付きコンストラクタで対応できるものは名前付きコンストラクタの方を呼ぶ
  MsgDialog({
    super.key,
    required this.type,
    this.title = '',
    this.dialogKind,
    this.replacements = const [],
    this.message = '',
    this.footerMessage = '',
    required this.btnSettingList,
    this.titleColor,
  });

  /// ボタンなし/ダイアログIdからメッセージを指定する
  MsgDialog.noButtonDlgId({
    super.key,
    required this.type,
    this.title = '',
    required int? dialogId,
    this.replacements = const [],
    this.footerMessage = '',
    this.titleColor,
  }) : btnSettingList = []{
    _setDialogKind(dialogId);
  }

  /// ボタンなし/メッセージを指定する
  MsgDialog.noButtonMsg({
    super.key,
    required this.type,
    this.title = '',
    required this.message ,
    this.footerMessage = '',
    this.titleColor,
  }) :  btnSettingList = [],
        dialogKind = null;

  /// 1つボタン/ダイアログIDからメッセージを表示する
  /// 各BtnFncは指定がない場合はGet.Back()が実行される.
  /// BtnFncを指定するときは、ダイアログから戻る処理をfncの中に含めること.
  MsgDialog.singleButtonDlgId({
    super.key,
    required this.type,
    this.title = '',
    required int? dialogId,
    this.replacements = const [],
    this.footerMessage = '',
    String btnTxt = 'とじる',
    Function? btnFnc,
    this.titleColor,
  }) :  btnSettingList = [MsgDlgBtnSetting(btnTxt, btnFnc)]{
    _setDialogKind(dialogId);

    if (type.isError()) {
      var deviceControllerTag = registrationEvent();
      deviceControllerEndFunc = () => deleteDeviceController(deviceControllerTag);

      clearFunc = btnFnc;
    }
  }

  /// 1つボタン/メッセージを指定する
  /// 各BtnFncは指定がない場合はGet.Back()が実行される.
  /// BtnFncを指定するときは、ダイアログから戻る処理をfncの中に含めること.
  MsgDialog.singleButtonMsg({
    super.key,
    required this.type,
    this.title = '',
    required this.message ,
    this.footerMessage = '',
    String btnTxt = 'とじる',
    Function? btnFnc,
    this.titleColor,
  }):  btnSettingList = [MsgDlgBtnSetting(btnTxt, btnFnc)],
       dialogKind = null {
    if (type.isError()) {
      var deviceControllerTag = registrationEvent();
      deviceControllerEndFunc = () => deleteDeviceController(deviceControllerTag);

      clearFunc = btnFnc;
    }
  }

  /// 2つボタン/ダイアログIDからメッセージを表示する
  /// タイトルは指定がない場合は[type]に対応するタイトルを表示する
  /// 各BtnFncは指定がない場合はGet.Back()が実行される.
  /// BtnFncを指定するときは、ダイアログから戻る処理をfncの中に含めること.
  MsgDialog.twoButtonDlgId({
    super.key,
    required this.type,
    this.title = '',
    int? dialogId,
    this.replacements = const [],
    this.footerMessage = '',
    String leftBtnTxt = 'とじる',
    Function? leftBtnFnc,
    String rightBtnTxt = 'はい',
    Function? rightBtnFnc,
    this.titleColor,
    this.content,
  }) : btnSettingList = [
    MsgDlgBtnSetting(leftBtnTxt, leftBtnFnc),
    MsgDlgBtnSetting(rightBtnTxt, rightBtnFnc)
  ]{
    _setDialogKind(dialogId);
  }
  /// 2つボタン/メッセージを指定する
  /// 各BtnFncは指定がない場合はGet.Back()が実行される.
  /// BtnFncを指定するときは、ダイアログから戻る処理をfncの中に含めること.
  MsgDialog.twoButtonMsg({
    super.key,
    required this.type,
    this.title = '',
    required this.message,
    this.footerMessage = '',
    String leftBtnTxt = 'とじる',
    Function? leftBtnFnc,
    String rightBtnTxt = 'はい',
    Function? rightBtnFnc,
    this.titleColor,
  }) :  btnSettingList = [
    MsgDlgBtnSetting(leftBtnTxt, leftBtnFnc),
    MsgDlgBtnSetting(rightBtnTxt, rightBtnFnc)
  ], dialogKind = null;



   /// 3つボタン/ダイアログIDからメッセージを表示する
   /// タイトルは指定がない場合は[type]に対応するタイトルを表示する
   /// 各BtnFncは指定がない場合はGet.Back()が実行される.
   /// BtnFncを指定するときは、ダイアログから戻る処理をfncの中に含めること.
   MsgDialog.threeButtonDlgId({
     super.key,
     required this.type,
     this.title = '',
     int? dialogId,
     this.replacements = const [],
     this.footerMessage = '',
     String leftBtnTxt = 'はい',
     Function? leftBtnFnc,
     String middleBtnTxt = 'いいえ',
     Function? middleBtnFnc,
     String rightBtnTxt = '休止',
     Function? rightBtnFnc,
     this.titleColor,
   }) : btnSettingList = [
     MsgDlgBtnSetting(leftBtnTxt, leftBtnFnc),
     MsgDlgBtnSetting(middleBtnTxt, middleBtnFnc),
     MsgDlgBtnSetting(rightBtnTxt, rightBtnFnc)
   ]{
     _setDialogKind(dialogId);
   }
   /// 3つボタン/メッセージを指定する
   /// 各BtnFncは指定がない場合はGet.Back()が実行される.
   /// BtnFncを指定するときは、ダイアログから戻る処理をfncの中に含めること.
   MsgDialog.threeButtonMsg({
     super.key,
     required this.type,
     this.title = '',
     required this.message,
     this.footerMessage = '',
     String leftBtnTxt = 'はい',
     Function? leftBtnFnc,
     String middleBtnTxt = 'いいえ',
     Function? middleBtnFnc,
     String rightBtnTxt = '休止',
     Function? rightBtnFnc,
     this.titleColor,
   }) :  btnSettingList = [
     MsgDlgBtnSetting(leftBtnTxt, leftBtnFnc),
     MsgDlgBtnSetting(middleBtnTxt, middleBtnFnc),
     MsgDlgBtnSetting(rightBtnTxt, rightBtnFnc)
   ], dialogKind = null;



   ///　ダイアログのタイプ
  late final  MsgDialogType type;

  ///　ダイアログタイトル
  late final  String title;

  ///ダイアログID
  ///MsgDialogインスタンス作成し、dialogCd提供しなかった場合はnullになります。
  ///nullの場合はデフォルトmessageが表示されます
  late final DlgConfirmMsgKind? dialogKind;
  ///　ダイアログメッセージ
  String message = '';

  ///　メッセージの下に表示する追加文言.
  late final String footerMessage;

  /// ダイアログ下部に表示するボタンリスト.
  late final List<MsgDlgBtnSetting> btnSettingList;

  /// 置換する際の挿入リスト
  late final List<dynamic> replacements;

  /// タイトル部分のカラー
  Color? titleColor;

  /// ダイアログUID. アプリ全体でダイアログが表示されているかどうかの判定に使用する.
  final String dlgUniqId = DateTime.now().toString();

  /// ダイアログ本文に独自のウィジェットを出力したい場合に指定する.
  /// ダイアログIDに応じたメッセージはウィジェットの直下に出力する.
  Widget? content;

  /// 現在表示中のダイアログUIDセット.
  /// 空ならアプリ内で表示中のメッセージダイアログはない.
  static Set<String>  dialogUIdSet = {};
  /// ダイアログが表示中かどうかを判定する.
  static bool get isDialogShowing => dialogUIdSet.isNotEmpty;

  /// 表示しているダイアログの種別
  static DlgConfirmMsgKind? displayingType;

  /// エラーダイアログか否か
  static bool isError = false;

  /// ダイアログクリア時の処理
  Function? clearFunc;

  /// デバイスコントローラーの終了処理
  /// ダイアログの制御の為に生成したデバイスコントローラーのインスタンスを明示的に破棄する必要がある場合などに設定する
  Function? deviceControllerEndFunc;

  /// ダイアログIdからダイアログKindを設定する.
  /// 無効なIdだった場合にはmessageを設定する.
  _setDialogKind(int? dialogId) {
    if (dialogId != null) {
      DlgConfirmMsgKind kind = DlgConfirmMsgKind.getDefine(dialogId);
      if (kind != DlgConfirmMsgKind.MSG_NONE) {
        // 有効なkindが設定されている
        dialogKind = kind;
      } else {
        // 有効なkindではないので、エラー表示.
        message = "エラー　$dialogId";
        dialogKind = null;
      }
    }
  }

  /// ダイアログを表示する
  static void show(MsgDialog msgDialog) {
    if (
      MsgDialog.isDialogShowing
        && (MsgDialog.isError && msgDialog.type.isError())
        && (MsgDialog.displayingType != null && MsgDialog.displayingType == msgDialog.dialogKind)
    ) {
      debugPrint('######## 同じ内容のエラーダイアログは重複表示しない');
      return;
    }

    MsgDialog.displayingType = msgDialog.dialogKind;

    MsgDialog.isError = msgDialog.type.isError();

    // メカキーを連打した時などに、複数のダイアログが表示されるのを防ぐため、
    // 表示中のダイアログUIDを保持しておく.
    // ダイアログ内のinitだと遅い可能性があるので表示する前に追加する.
    MsgDialog.dialogUIdSet.add(msgDialog.dlgUniqId);
    Get.dialog(
      msgDialog,
      //　ダイアログ外タップで閉じない
      barrierDismissible: false,
    );
  }

  static Future<T?> showConfirm<T>(MsgDialog msgDialog) async {
    // メカキーを連打した時などに、複数のダイアログが表示されるのを防ぐため、
    // 表示中のダイアログUIDを保持しておく.
    // ダイアログ内のinitだと遅い可能性があるので表示する前に追加する.
    MsgDialog.dialogUIdSet.add(msgDialog.dlgUniqId);
    return Get.dialog(
      msgDialog,
      //　ダイアログ外タップで閉じない
      barrierDismissible: false,
    );
  }

  /// 未実装機能のエラーダイアログを表示する
  static void showNotImplDialog() {
     show(
       MsgDialog.singleButtonMsg(
         type: MsgDialogType.error,
         message: '未実装です',
       ),
     );
   }

   /// デバイスコントローラーのタグ設定
  @override
  IfDrvPage getTag() {
    return IfDrvPage.messageDialog;
  }

  /// デバイスコントローラーのキー操作設定
  @override
  KeyDispatch? getKeyCtrl() {
    KeyDispatch keyCon = KeyDispatch(Tpraid.TPRAID_CHK);

    // クリアキー押下時の処理
    keyCon.funcClr = () async {
      if (clearFunc != null) {
        clearFunc?.call();
      } else {
        Get.back();
      }
    };

    return keyCon;
  }
}

/// メッセージボックス
///dialogCdからメッセージを取得されてない場合は、デフォルトの'message’が表示されます
class MsgDialogState extends State<MsgDialog>  {


  /// エラーダイアログ表示時のc_dialog_mst.title_col値
  static const  int errColorCd = 36;

  @override
  void initState() {
    super.initState();
    // 画面を開く前に、showDialogIdSetにダイアログUIDを追加しているのでここでは行わない

    // ポップアップ音、もしくは、エラー音を鳴らす
    SoundKind soundKind = widget.type == MsgDialogType.error ? SoundKind.error : SoundKind.popup;
    if (EnvironmentData().screenKind == ScreenKind.register) {
      // 本体側は右で鳴らす
      IfSound.ifSound(soundKind);
    } else {
      // タワー側 or 客側表示パネルを左で鳴らす
      IfSound.ifSoundCshr(soundKind);
    }
  }

  @override
  void dispose() {
    super.dispose();
    // ダイアログを閉じるときに、表示中のダイアログUIDを削除する.
    MsgDialog.dialogUIdSet.remove(widget.dlgUniqId);
    MsgDialog.displayingType = null;

    widget.deviceControllerEndFunc?.call();
  }


  ///メッセージを非同期に取得するメソッド
  ///dialogCdがnullの場合はデフォルトmessageを返します
  Future<DialogInfo> _fetchMessage() async {
    if (widget.dialogKind != null) {
      /// メッセージ内容、タイトル色はDBより取得する
      DialogInfo info = await DialogDB.getMessageByDialogCd(
          Tpraid.TPRAID_SYST, widget.dialogKind!.dlgId);
      /// タイトル文字列はアプリ内部で保持している値を使用する
      info.title = info.titleImgCd.imageData;
      /// 置換文字列が存在する場合は置換する
      if (widget.replacements.isNotEmpty){
        try {
          info.messages = sprintf(info.messages, widget.replacements);
        } catch (exception) {
          debugPrint('catch the exception in _fetchMessage function: $exception');
        }
      }
      return info;
    }
    DialogInfo dialogInfo = DialogInfo();
    dialogInfo.messages = widget.message;
    dialogInfo.title = widget.title.isEmpty ? widget.type.defaultTitle : widget.title;
    dialogInfo.titleColorCd = (widget.type == MsgDialogType.error ? errColorCd : 0);
    return dialogInfo;
  }

  ///FutureBuilderを使用して、非同期message1を取得する
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DialogInfo>(
      future: _fetchMessage(),
      builder: (context, snapshot) {
        ///非同期処理完了の場合
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            ///snapshot.data 使用してダイアログ構築
            return _buildDialog(context, snapshot.data!);
          } else {
            ///エラー処理
            DialogInfo dialogInfo = DialogInfo();
            dialogInfo.messages = 'Error: Unable to load message';
            return _buildDialog(context, dialogInfo);
          }
        } else {
          ///ロード中の処理
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  /// ダイアログを構築する
  Widget _buildDialog(BuildContext context, DialogInfo dialogInfo) {
    /// title > DBからdialogIdで取得した値 > typeで指定したエラー／確認の種別に基づいたデフォルトテキスト
    /// の優先順位でタイトル内容を指定する
    Color color = widget.titleColor ?? (dialogInfo.result ?
    (dialogInfo.titleColorCd == errColorCd ? BaseColor.attentionColor : BaseColor.baseColor)
        : widget.type.color);
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      backgroundColor: color,
      titlePadding: const EdgeInsets.fromLTRB(5, 18, 5, 18),
      title: Stack(
        children: [
          ///ダイアログのタイトル
          Align(
            alignment: Alignment.center,
            child: Text(
              widget.title.isNotEmpty ? widget.title : (dialogInfo.result ? dialogInfo.title : widget.type.defaultTitle),
              style: const TextStyle(
                color: BaseColor.someTextPopupArea,
                fontSize: BaseFont.font28px,
                fontFamily: BaseFont.familyDefault,
              ),
            ),
          ),

          ///ダイアログIDを表示
          Positioned(
            right: 32.w,
            child: Text(
              widget.dialogKind?.dlgId.toString() ?? '',
              style: const TextStyle(
                color: BaseColor.someTextPopupArea,
                fontSize: BaseFont.font28px,
              ),
            ),
          ),
        ],
      ),
      content: getMsgBoxContainer(dialogInfo.messages, color),
      contentPadding: const EdgeInsets.all(0),
    );
  }

  /// ダイアログのメッセージとボタンのWidget
  Widget getMsgBoxContainer(String msg, Color borderColor) {
    return Container(
      width: 912.w,
      height: 656.h,
      padding: EdgeInsets.fromLTRB(100.w, 50.h, 100.w, 10.h),
      decoration: BoxDecoration(
        color: BaseColor.someTextPopupArea,
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
        border: Border.all(
          /// titleColor > DBのc_dialog_mst.title_colから取得した色 > typeで指定したエラー／確認の種別に基づいたデフォルト色
          /// の優先順位でタイトルカラーを指定する
          color: borderColor,
          width: 1.w,
        ),
      ),
      child: Stack(
        children: [
          ///ダイアログメッセージ
          Align(
            alignment: Alignment.center,
            child: SizedBox(
                width: 900.w,
                height: 350.h,
                child: (() {
                  if (widget.content != null) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.content!,
                        Container(),
                        Text(
                          msg,
                          style: const TextStyle(
                            color: BaseColor.baseColor,
                            fontSize: BaseFont.font28px,
                            fontFamily: BaseFont.familyDefault,
                          ),
                        ),
                        Container(),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            msg,
                            style: const TextStyle(
                              color: BaseColor.baseColor,
                              fontSize: BaseFont.font28px,
                              fontFamily: BaseFont.familyDefault,
                              height: 1 + (6 / 28),
                            ),
                          ),
                        ),
                        if (widget.footerMessage.isNotEmpty)
                          Center(
                            child: Text(
                              widget.footerMessage,
                              style: const TextStyle(
                                color: BaseColor.baseColor,
                                fontSize: BaseFont.font28px,
                                fontFamily: BaseFont.familyDefault,
                                height: 1 + (6 / 28),
                              ),
                            ),
                          )
                      ],
                    );
                  }
                })(),
            ),
          ),

          ///下側のボタン
          Positioned(
            bottom: 0.07.sh,
            left: 0,
            right: 0,
            child: getFooterButton(),
          ),
        ],
      ),
    );
  }

  /// ダイアログのボタン部分のWidget
  Widget getFooterButton() {
    return Align(
      alignment: Alignment.center,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        for (var button in widget.btnSettingList)
          DecisionButton(
            oncallback: () =>
            button.btnFunc != null ? button.btnFunc!.call() : Get.back(),
            text: button.btnTxt,
            isdecision: false,
          ),
      ]),
    );
  }



}  