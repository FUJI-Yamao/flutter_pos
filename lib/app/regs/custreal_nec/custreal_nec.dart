/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import '../../common/cls_conf/custreal_necJsonFile.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/apl/rxmem_define.dart';
import '../inc/rc_custreal_nec.dart';

/// 通信クライアント（シングルトン）
/// 顧客管理サーバに対してソケット通信を行う。
/// 関連tprxソース: custreal_nec.c
class CustrealNec {
  // staticとしてインスタンスを事前に作成
  static final CustrealNec _instance = CustrealNec._internal();

  // Factoryコンストラクタ
  factory CustrealNec() {
    // 初期化されていないと例外をスローする
    return _instance;
  }

  // 内部で利用する別名コンストラクタ
  CustrealNec._internal();

  // 変数を定義
  static late Socket socket;
  static late Custreal_necJsonFile custrealNec;
  static final _stopwatch = Stopwatch();

  // 設定ファイルから取得情報
  static String host = '';
  static int port = 0;
  static String path = '';
  static late Duration timeoutSec;
  static late int tenantCd;
  static late String _rxBuf;
  static late String _encodeDate;

  // データの設定値
  static RxSocket pSocketBUF = RxSocket();
  static RxSocket rxStructBuf = RxSocket();

  // 定数
  static const int tmStart = 1;
  static const int tmEnd = 2;
  static const int openRetryMax = 2;
  static const int openRetryWait = 500;

  /// 顧客管理サーバ ソケット通信エントリーポイント
  /// 引数: [RxSocket]
  /// 戻り値：[RxSocket]
  ///
  /// 関連tprxソース: custreal_nec.c - main
  /// 関連tprxソース: custreal_nec.c - socket_main
  Future<RxSocket> socketMain(RxSocket data) async {
    TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.normal,
        "CustrealNecSocketClient TPRAID_CUSTREAL_NEC Start \n");

    pSocketBUF = data;

    // JSONファイル読み込み、設定ファイル(custreal_nec.json)からリアル顧客情報を取得
    custrealNec = Custreal_necJsonFile();
    await custrealNec.load();

    // リトライ回数
    final retry = _getOpenRetryCnt();
    // リトライ時の待機時間
    final wait = Duration(milliseconds: _getOpenRetryWait());
    // レスポンス待機時間
    timeoutSec = Duration(seconds: _getOpenTimeOut());
    // テナントコード
    tenantCd = await _getTenantCd();
    // 接続先情報設定
    _getUrl();

    // 接続先チェック
    if (port <= 0) {
      await _socketResWrite(RcCustrealNec.ORDER_NEC_ERROR,
          DlgConfirmMsgKind.MSG_SOCKET_GETHOSTBYNAME.dlgId, null);
      TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.error,
          "CustrealNecSocketClient cannot get Url");
      return rxStructBuf;
    }
    // ホスト名からIPアドレスを解決
    List<InternetAddress> addresses = await InternetAddress.lookup(host);
    if (addresses.isEmpty) {
      await _socketResWrite(RcCustrealNec.ORDER_NEC_ERROR,
          DlgConfirmMsgKind.MSG_SOCKET_GETHOSTBYNAME.dlgId, null);
      TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.error,
          "CustrealNecSocketClient cannot get info for compc");
      return rxStructBuf;
    }

    int fd = -2;
    // 接続処理を実行し、接続できない場合はリトライ回数分実行。
    for (int cnt = 0; cnt < retry; cnt++) {
      fd = await socketOpen();
      // 接続できた時点でループ処理から抜ける。
      if (fd != -2) {
        break;
      }
      // 接続失敗時は時間を空けて再度接続を行う。
      await Future.delayed(wait);
    }
    if (fd == -2) {
      // ソケットコネクトエラー
      await _socketResWrite(RcCustrealNec.ORDER_NEC_ERROR,
          DlgConfirmMsgKind.MSG_SOCKET_CONNECTNG.dlgId, null);
      return rxStructBuf;
    }

    // リクエストを送信
    await _socketWrite(pSocketBUF.data);
    if (pSocketBUF.order == RcCustrealNec.ORDER_NEC_REQUEST) {
      // リッスン開始
      await _socketRead();
    } else {
      // エラー無しで終了
      await _socketResWrite(RcCustrealNec.ORDER_NEC_RESET,
          DlgConfirmMsgKind.MSG_NONE.dlgId, null);
    }
    TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.normal,
        "CustrealNecSocketClient jpo process end\n");
    _socketClose();

    // データが帰ってくるのを待ってからリターンを返す。
    await Future.delayed(const Duration(milliseconds: 100));
    return rxStructBuf;
  }

  /// 呼び出し元のリターンを設定する。
  /// エラーだった場合、[orderNo]、[errorNo]を設定する。
  /// 正常だった場合、サーバー受信データ[rcvdata]を設定する。
  /// 関連tprxソース: custreal_nec.c - socket_reswrite
  static Future<void> _socketResWrite(
      int orderNo, int errorNo, String? rcvdata) async {
    rxStructBuf.order = orderNo;

    if (orderNo == RcCustrealNec.ORDER_NEC_ERROR) {
      // クラス変数から直接エラー情報を設定
      rxStructBuf.errNo = errorNo;
    } else if (orderNo == RcCustrealNec.ORDER_NEC_RECEIVE) {
      // サーバーから取得したレスポンスデータを設定。
      rxStructBuf.data = rcvdata!;
    }
  }

  /// 関連tprxソース: custreal_nec.c - socket_open
  /// サーバー接続を行い、接続失敗時はリトライ回数分再接続を試みる。
  static Future<int> socketOpen() async {
    // 接続の可否
    int sockFd = 0;
    // エラー
    int errorNo = 0;

    // プロセスタイム取得
    _socketProcessTime(tmStart, errorNo, "open");
    try {
      // ソケット接続
      socket = await Socket.connect(host, port).timeout(timeoutSec);
      TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.normal,
          "CustrealNecSocketClient socket open");
    } on SocketException {
      // ソケットコネクトエラー
      TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.error,
          "CustrealNecSocketClient socket connect ng");
      // エラー情報設定
      await _socketResWrite(RcCustrealNec.ORDER_NEC_ERROR,
          DlgConfirmMsgKind.MSG_SOCKET_SOCKETNG.dlgId, null);
      sockFd = -2;
      return sockFd;
    }
    // non blocking mode connect process
    _socketProcessTime(tmEnd, errorNo, "open");
    return sockFd;
  }

  /// 送信メッセージ作成処理
  /// getパッケージでは既存ソースのリクエストヘッダ作成・置き換えは不可能であるため、
  /// dart:ioで直接メッセージを作成・送信する。
  /// 関連tprxソース: custreal_nec.c - socket_write
  static Future<void> _socketWrite(String data) async {
    String workData = '';
    int errorNo;

    try {
      // 送信データを変換
      _urlEncode(data);
      // リクエストボディ作成
      workData = 'TENANT=$tenantCd&DATA=$_encodeDate';

      // リクエストラインとヘッダーを構築
      final txbuf = StringBuffer()
        ..write('POST $path /HTTP/1.1\r\n')
        ..write('Host: $host:$port\r\n')
        ..write('User-Agent: TERAOKA-POS RedHat\r\n')
        ..write(
            'Content-Type: application/x-www-form-urlencoded; charset=Windows-31J\r\n')
        ..write('Content-Length: ${workData.length}\r\n')
        ..write('Connection: close\r\n')
        ..write('\r\n') // 空行でヘッダーとボディを分ける
        ..write('$workData \r\n');

      errorNo = 0;
      _socketProcessTime(tmStart, errorNo, "Write");

      // リクエストをソケットに書き込む
      socket.write(txbuf.toString());
      //　バッファリングされたすべてのデータを送信
      await socket.flush();

      _socketProcessTime(tmEnd, errorNo, "Write");
      TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.error,
          "socket write error no=$errorNo, size=%d'");
    } catch (e) {
      // ソケットライトエラー
      errorNo = DlgConfirmMsgKind.MSG_SOCKET_WRITENG.dlgId;
      // エラー情報を共有メモリに書き込み
      await _socketResWrite(RcCustrealNec.ORDER_NEC_ERRRT, errorNo, null);
      // ログ出力
      TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.error,
          "socket write error no=$errorNo, size=%${workData.length}'");
      socket.destroy();
    }
  }

  /// 取得したデータをlistenし、サーバーから送信されたデータを受信する。
  /// 関連tprxソース: custreal_nec.c - socket_read
  static Future<void> _socketRead() async {
    // 変数定義
    int errorNo;

    TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.normal,
        "CustrealNecSocketClient socket read \n");

    errorNo = 0;
    _socketProcessTime(tmStart, errorNo, "Read");

    // タイムアウト
    final workTimeout = Duration(minutes: await _getTimeOut());
    Timer? timeoutTimer;
    // 初期のタイムアウトタイマーを設定
    timeoutTimer = Timer(workTimeout, () async {
      await _socketResWrite(RcCustrealNec.ORDER_NEC_ERRRT,
          DlgConfirmMsgKind.MSG_TIMEOVER.dlgId, null);
      // タイムアウト
      TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.error,
          "CustrealNecSocketClient socket read timeout error ");
      errorNo = 999;
    });

    socket.listen(
      // ソケットからメッセージを受信したときの処理
            (Uint8List data) {
          TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.normal,
              "CustrealNecSocketClient onMessage data=$data");

          // データ受信時にタイムアウトタイマーをリセット
          timeoutTimer?.cancel();
          // データUint8ListのデータをStringに変換
          _rxBuf = String.fromCharCodes(data);
        }, onError: (error) async {
      // ソケット受信セレクトエラー
      await _socketResWrite(RcCustrealNec.ORDER_NEC_ERRRT,
          DlgConfirmMsgKind.MSG_SOCKET_SELECTNG.dlgId, null);
      TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.error,
          "CustrealNecSocketClient socket read select error ");
      errorNo = 999;
    },
        // ソケット閉じられた時の処理
        onDone: () async {
          TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.normal,
              "CustrealNecSocketClient onClose");
          try {
            // ヘッダーとボディを分ける。
            final parts = _rxBuf.split('\r\n\r\n');
            final header = parts[0];
            final body = parts[1];

            // _chk_socket_size
            if (_chkSocketSize(_rxBuf)) {
              // ヘッダー判定
              final statusLine = header.split('\r\n')[0];
              if (statusLine.contains('HTTP/1.1 200')) {
                // 取得したボディを設定
                await _socketResWrite(RcCustrealNec.ORDER_NEC_RECEIVE,
                    DlgConfirmMsgKind.MSG_NONE.dlgId, body);
              } else {
                // ヘッダーが不正だった場合はエラーとして処理処理する。
                await _socketResWrite(RcCustrealNec.ORDER_NEC_ERRRT,
                    DlgConfirmMsgKind.MSG_SOCKET_READNG.dlgId, null);
                TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.error,
                    "read result error $_rxBuf");
              }
            }
            timeoutTimer?.cancel();
          } catch (e) {
            // データが取得できたが何かしらのエラーが発生した場合、
            TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.error,
                "socket read error no=$errorNo, size=%d");
            TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.error,
                "socket write $_rxBuf");
            errorNo = 6666;
          }
        }, cancelOnError: true);
    _socketProcessTime(tmStart, errorNo, "Read");
  }

  /// 正常終了時にソケット通信を終了
  /// 関連tprxソース: custreal_nec.c - socket_close
  static void _socketClose() {
    try {
      socket.close();
      TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.normal,
          "CustrealNecSocketClient socket close");
    } catch (e) {
      TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.error,
          "CustrealNecSocketClient socket close error $e");
    }
  }

  /// ソケットサイズチェック
  /// 取得したレスポンス[_rxbuf]から該当の文字が含まれているか検索する。
  /// 含まれていればtrue、含まれていなければfalseを設定する。
  /// 関連tprxソース: custreal_nec.c - chk_socket_size
  static bool _chkSocketSize(_rxBuf) {
    // 処理結果を格納する変数
    final int result = 0;
    if (result != -1) {
      if (_rxBuf.contains(RegExp("FCSC")) || _rxBuf.contains(RegExp("FCSP"))) {
        return true;
      }
    }
    return false;
  }

  /// 処理時間をログに出力する。
  /// 関連tprxソース: custreal_nec.c - socket_ProcessTime
  static void _socketProcessTime(int order, int errorNo, String data) {
    switch (order) {
      case tmStart:
        _stopwatch.start();
        break;
      case tmEnd:
        _stopwatch.stop();
        TprLog().logAdd(Tpraid.TPRAID_JPO_TM, LogLevelDefine.normal,
            "\t $data \t ${_stopwatch.elapsedTicks.toString()} \t $errorNo ");
        break;
      default:
        break;
    }
  }

  /// 設定ファイルからリトライ回数を取得する。
  /// 初期値が「0」であり、メンテナンス画面の設定値として許容していることから条件分岐を削除
  /// 関連tprxソース: custreal_nec.c - getOpenRetryCnt
  static int _getOpenRetryCnt() {
    final int retry;
    // データが取得できない場合は初期値「0」が設定される。
    // if (custreal_nec.custrealsvr.retrycnt == 0) {
    //   TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.error,
    //       "CustrealNecSocketClient TprLibGetIni error(custrealsvr open retry count) default Set ${openRetryMax}");
    //   retry = openRetryMax;
    // } else {
    //   retry = custreal_nec.custrealsvr.openretrycnt;
    // }
    retry = custrealNec.custrealsvr.openretrycnt;
    return retry;
  }

  /// サーバー接続できなかった場合の待機時間。
  /// 初期値は「[openRetryWait] 500 ms」とする。
  /// 関連tprxソース: custreal_nec.c - getOpenRetryWait
  static int _getOpenRetryWait() {
    final int wait;
    // データが取得できない場合はデフォルト値を設定
    if (custrealNec.custrealsvr.opentimeout == 0) {
      TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.error,
          "CustrealNecSocketClient TprLibGetIni error(custrealsvr open retry Wait) default Set $openRetryWait");
      wait = openRetryWait;
    } else {
      wait = custrealNec.custrealsvr.timeout;
    }

    return wait * 1000;
  }

  /// コネクトのタイムアウト値
  /// 関連tprxソース: custreal_nec.c - GetOpenTimeOut
  static int _getOpenTimeOut() {
    final int timeoutSec;
    // データが取得できない場合はデフォルト値を設定
    if (custrealNec.custrealsvr.timeout == 0) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          "CustrealNecSocketClient TprLibGetIni error(custrealsvr opentimeout)");
      timeoutSec = 1;
    } else {
      timeoutSec = custrealNec.custrealsvr.timeout;
    }
    return timeoutSec;
  }

  /// テナントコード
  /// 関連tprxソース: custreal_nec.c - getTenantCd
  static Future<int> _getTenantCd() async {
    int tenantCd;

    if (custrealNec.nec.tenantcd == 0) {
      await _socketResWrite(RcCustrealNec.ORDER_NEC_ERROR,
          DlgConfirmMsgKind.MSG_SOCKET_GETHOSTBYNAME.dlgId, null);

      TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.error,
          "CustrealNecSocketClient TprLibGetIni error(cannot get url)");
      tenantCd = 1001006;
    }
    tenantCd = custrealNec.nec.tenantcd;
    return tenantCd;
  }

  /// 設定ファイルからURLを取得し、[host]と[port]に分けて使用する
  /// 関連tprxソース: custreal_nec.c - getUrl
  static Future<void> _getUrl() async {
    if (custrealNec.nec.url == '') {
      await _socketResWrite(RcCustrealNec.ORDER_NEC_ERROR,
          DlgConfirmMsgKind.MSG_SOCKET_GETHOSTBYNAME.dlgId, null);

      TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.error,
          "CustrealNecSocketClient TprLibGetIni error(cannot get url)");
      return;
    }
    String necUrl = custrealNec.nec.url;
    necUrl = 'http://127.0.0.1:38080';

    // Uriクラスで設定ファイルのURLを分割する。
    final uri = Uri.parse(necUrl);
    //
    if (uri.scheme == 'http') {
      host = uri.host;
      path = uri.path;
      // ポートがない場合はHTTPサービスのポート番号「80」を設定
      port = uri.port != 0 ? uri.port : 80;
    }
  }

  /// 関連tprxソース: custreal_nec.c - getTimeOut
  static Future<int> _getTimeOut() async {
    final int workTimeOut;
    if (custrealNec.custrealsvr.timeout == 0) {
      await _socketResWrite(RcCustrealNec.ORDER_NEC_ERROR,
          DlgConfirmMsgKind.MSG_SOCKET_GETHOSTBYNAME.dlgId, null);
      TprLog().logAdd(Tpraid.TPRAID_CUSTREAL_NEC, LogLevelDefine.error,
          "CustrealNecSocketClient TprLibGetIni error(custrealsvr timeout)\n");
      workTimeOut = 30;
    } else {
      workTimeOut = custrealNec.custrealsvr.timeout;
    }

    return workTimeOut;
  }

  /// 送信用のデータを変換し、既存ソースのを基にデータ部を作成する。
  /// 関連tprxソース: custreal_nec.c - UrlEncode
  static void _urlEncode(String data) {
    StringBuffer encodedData = StringBuffer();

    for (int i = 0; i < data.length; i++) {
      int codeUnit = data.codeUnitAt(i);

      if ((codeUnit >= 0x30 && codeUnit <= 0x39) || // '0' <= data[i] <= '9'
          (codeUnit >= 0x61 && codeUnit <= 0x7A) || // 'a' <= data[i] <= 'z'
          (codeUnit >= 0x41 && codeUnit <= 0x5A) || // 'A' <= data[i] <= 'Z'
          codeUnit == 0x2D || // data[i] == '-'
          codeUnit == 0x2E || // data[i] == '.'
          codeUnit == 0x5F || // data[i] == '_'
          codeUnit == 0x7E) {
        // data[i] == '~'
        encodedData.writeCharCode(codeUnit);
      } else if (codeUnit == 0x20) {
        // data[i] == ' '
        encodedData.write('+');
      } else {
        encodedData.write('%');
        encodedData
            .write(codeUnit.toRadixString(16).toUpperCase().padLeft(2, '0'));
      }
    }
    _encodeDate = encodedData.toString();
  }
}