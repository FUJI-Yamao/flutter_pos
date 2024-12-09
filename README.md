# flutter_pos

flutter_pos

ライブラリを追加した際にはflutterプロジェクトのdoc/使用ライブラリ一覧.xlsx に追記お願いいたします

## Getting Started

This project is a starting point for a Flutter application.

### Linux
■初回起動時に1度だけする設定  
- ログ出力先のフォルダ設定  
①/pj/tprx/log フォルダを作成  
②権限を付与 chmod 777 /pj/tprx/log
- [audioplayers](https://pub.dev/packages/audioplayers)の設定  
  Linux環境では以下のコマンドを実行してからビルドすること（[audioplayers_linux](https://github.com/bluefireteam/audioplayers/tree/main/packages/audioplayers_linux)）
  ```
  sudo apt-get install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
  ```

■起動コマンド  
LINUX  :flutter run -d linux lib/main.dart  
WINDOWS:flutter run lib/main.dart  
<仮想環境など、デバイスファイルがない場合は起動しないので下記コマンド>  
※デバイスが接続されてない場合  
LINUX  :flutter run -d linux lib/main.dart --dart-define=WITHOUT_DEVICE=true  
WINDOWS:flutter run lib/main.dart --dart-define=WITHOUT_DEVICE=true  
※WindowsでデバドラのLinux側のロジックを動作させる場合（soが異なるためWITHOUT_DEVICEと併用）  
WINDOWS:flutter run lib/main.dart --dart-define=LINUX_DEBUG_BY_WIN=true --dart-define=WITHOUT_DEVICE=true  

### windows  
 ■exeからの実行方法  
   
①  下記サイトの「3.リリースする 」のやり方に従って対象ファイルを配置.  
https://kehalife.com/flutter-windows-app/  
② 実行しているExeがあるのと同じ場所にsqlite3.dllを配置    
https://pub.dev/packages/sqflite_common_ffi#windows  

### Android 
AndroidVirtualDeviceはタブレットのもので実行する  
  
## リリースするときに必要な変更.  
・CompileFlag.DEBUG_TEST をfalseにする.  
※起動するたびにファイルを作るような処理など、開発中に有効にしておくとディスクを圧迫するものを封じています  

#客表画面を自動起動させる  
①releaseビルドを行う  
　windows: Run > ReleaseMode  
 linux:flutter build linux --release lib/main.dart --dart-define=WITHOUT_DEVICE=true  
※--dart-defineは環境に併せてください.実機では不要  
    
②releaseビルドによって作成された実行体とファイルをまるごと/pj/tprx/apl/フォルダ配下へ配置する  
※/pj/tprx/apl/直下にflutter_pos(.exe)が来るようにする.releaseフォルダやbundleフォルダは不要  
※exe以外にもdataフォルダやdllがあるが全部コピーすること  
< 作成される実行体の場所>  
　windowsは flutter_pos\build\windows\x64\runner\Release/  
 linuxは flutter_pos/build/linux/x64/release/bundle/  
  
#起動アプリケーションを指定する  
2024/10/17現在、以下のアプリケーション起動が指定できます。  
```
①卓上側アプリケーション・・・register  
②①に対する客表アプリケーション(15インチ)・・・customer  
③①に対する客表アプリケーション(7インチ)・・・customer_7_1  
④タワー側アプリケーション・・・register2  
⑤④に対する客表アプリケーション・・・customer_7_2
```
起動コマンドの最後に、  
```
-a register
```
というようにアプリケーションを指定することで対象のアプリケーションを起動できます。  
  
## プロジェクト構成  
フォルダを追加したり、構成を変えたら修正してください.  
既存POSのsrcフォルダ = flutter_pos/lib/appとし、既存POSのソースは同等の階層に配置されるようにします。  
例)src/inc/db/ に入っているファイルは flutter_pos/lib/app/inc/db/ に入れる  
既存POSから移行したソース以外のディレクトリ階層の解説を下記に示します.  

C:.  
├─assets・・・リソース(設定ファイルや画像ファイル)管理  
│  ├─conf・・・設定ファイルの格納先（既存POSのtprx/confと同一構成）  
│  │  ├─aa・・・多言語対応のうち、日本語向け設定ファイルの格納先  
│  │  ├─default・・・.json.defaultの格納先  
│  │  └─func・・・ファンクション用設定ファイルの格納先  
│  ├─images・・・画像ファイル  
│  └─sql・・・初期データ作成用ファイルの格納先
│     ├─copy_ins・・・アークス様向けデータのINSERT文ファイル  
│     ├─crtfunc・・・CREATE FUNCTION文ファイル  
│     ├─crttbl・・・CREATE TABLE文ファイル  
│     └─insert・・・初期データのINSERT文ファイル
├─data・・・実行時にdbが作成されるフォルダ  
├─lib・・・ソースフォルダ  
│  ├─app・・・アプリの動作に関連するファイル (既存POSのsrcフォルダと対応)  
│  │  ├─common・・・アプリのどの画面でも共通で使用するファイル .既存POSにはなかったFlutterで追加した関数など  
│  │  │  └─cls_conf・・・設定ファイル操作クラス  
│  │  ├─drv・・・デバイス関連  
│  │  │  ├─drw・・・ドロアドライバ制御タスク  
│  │  │  ├─mkey・・・メカキードライバ制御タスク  
│  │  │  ├─printer・・・プリンタドライバ制御タスク  
│  │  │  ├─scan・・・スキャナドライバ制御タスク  
│  │  │  ├─ffi・・・外部I/F.so,dllファイル読み込み.  
│  │  │  │  ├─ubuntu・・・ubuntu用  
│  │  │  │  └─windows・・・windows用  
│  │  │  └─lib・・・ドライバ(4月以降にプロジェクト分離予定)  
│  │  │     ├─ffi_debug_app・・・FFIをデバッグするためのFlutterプロジェクト  
│  │  │     ├─Ubuntu・・・Ubuntuのドライバ  
│  │  │     └─Windows・・・windowsのドライバ  
│  │  │         ├─dist・・・DLL, EXE生成場所  
│  │  │         │  ├─SII・・・WinApiで作成したイベント制御プロセス(EXE)  
│  │  │         │  ├─Teraoka・・・寺岡様製のポート制御系のEXE  
│  │  │         │  ├─Win32  
│  │  │         │  │  └─Release・・・DLL, EXE生成場所  
│  │  │         │  └─x64  
│  │  │         │      └─Release・・・DLL, EXE生成場所  
│  │  │         ├─OPOS-CCO-1.16.0・・・OPOS-CCO 参照：https://github.com/kunif/OPOS-CCO  
│  │  │         ├─RegisterBatchs・・・OPOSのOCXをレジストリ登録するバッチ  
│  │  │         └─WinApi・・・windowsAPI  
│  │  │             ├─COpos・・・DLL用ヘッダファイル  
│  │  │             ├─COPOSDrawer・・・イベント制御プロセスプロジェクト(本番用)  
│  │  │             ├─COPOSDrawerIdl・・・RPC通信用MIDL（zCashDrawerと通信）  
│  │  │             ├─COPOSDrawer_debug・・・イベント制御プロセスプロジェクト(デバッグ用)  
│  │  │             ├─COPOSPOSPrinter・・・イベント制御プロセスプロジェクト(本番用)  
│  │  │             ├─COPOSPOSPrinterIdl・・・RPC通信用MIDL（zCashDrawerと通信）  
│  │  │             ├─COPOSPOSPrinter_debugイベント制御プロセスプロジェクト(デバッグ用)  
│  │  │             ├─COPOSScanner・・・イベント制御プロセスプロジェクト(本番用)  
│  │  │             ├─COPOSScannerIdl・・・RPC通信用MIDL（zCashDrawerと通信）  
│  │  │             ├─COPOSScanner_debugイベント制御プロセスプロジェクト(デバッグ用)  
│  │  │             ├─Opos・・・OPOSヘッダファイル  
│  │  │             ├─OposDriver・・・プロセス→OCX→SOの疎通確認プロジェクト  
│  │  │             ├─OposIf32・・・OPOS(32bit）ヘッダファイル  
│  │  │             ├─OposIf64・・・OPOS(64bit）ヘッダファイル  
│  │  │             ├─OposSystem・・・共通システムファイル  
│  │  │             ├─zCashDrawer・・・テストプロジェクト  
│  │  │             ├─zPOSKeyboard・・・テストプロジェクト  
│  │  │             ├─zPOSPrinter・・・テストプロジェクト  
│  │  │             ├─zScanner・・・テストプロジェクト  
│  │  │             ├─z_cash_drawer・・・DLLプロジェクト  
│  │  │             ├─z_mkey・・・DLLプロジェクト  
│  │  │             ├─z_printer・・・DLLプロジェクト  
│  │  │             └─z_scanner・・・DLLプロジェクト  
│  │  ├─if・・・デバドラの操作をmainIsolateから呼び出す時の処理.(既存POSのlib/if_thに該当)  
│  │  │  └─common・・・共通定義のクラス.  
│  │  ├─ui・・・Flutter用のUIコントロールクラス.  
│  │  │  ├─component・・・様々なUIで使えるようなコンポーネント  
│  │  │  ├─controller・・・UIから呼び出されるバックエンドとの接続クラス.  
│  │  │  ├─enum・・・uiで使用しているenum定義.  
│  │  │  ├─language・・・多言語ファイル  
│  │  │  ├─menu・・・メインメニュー  
│  │  │  ├─model・・・ボタンなどウェジットのパラメータークラス.  
│  │  │  ├─page・・・ページ  
│  │  │  ├─service・・・サービス  
│  │  │  └─template・・・UIのテンプレート  
│  │  └─既存POS準拠のディレクトリ  
│  ├─db_library・・・dbアクセスクラス  
│  ├─type_extension・・・POS用にintなどの基本タイプを拡張したクラス  
│  └─webapi・・・webApiとの通信を行うクラス  
└─test・・・単体テスト/結合テスト用のソースなど.  
  
上記のほか、Linuxではrootディレクトリ配下、WindowsではCドライブ直下に下記が必要です。  
C:.  
└─etc・・・機種判別ファイルなどを格納  
   ├─2800_smhd.ini・・・・2800系である（中身無し）  
   ├─itype_smhd.ini・・・・G3 XGA1画面機種である（中身無し）  
   ├─newhappy_smhd.ini・・HappySelfである（中身無し）  
   ├─tprtim_smhd.ini・・・SII製プリンタ CAPM/RP-D/RP-E/RP-F/PT06搭載機種である（中身無し）
   ├─tprtrpd_smhd.json・・SII製プリンタ PT06搭載機種である
   ├─XX5_smhd.ini・・・・・G3である（中身無し）  
   └─52key_desk.ini・・・・52キータイプ（中身無し）  


  

