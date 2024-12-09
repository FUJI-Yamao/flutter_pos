# OPOS Driver
  
## 開発環境
Visual Studio 2022  
  
## ディレクトリツリー
<pre>
[Windows]
    │
    ├── dist
    │      │
    │      ├ Win32, x64
    │      │  WinApiのDLL, OPOS交信プロセス(EXE)の生成場所
    │      │
    │      └ その他
    │          ベンダー提供SoDLL, 外部プロセスなど
    │
    ├── OPOS-CCO-1.16.0
    │      │ OLE for Retail POS Common Control Object Project
    │      │ <a href="https://github.com/kunif/OPOS-CCO">https://github.com/kunif/OPOS-CCO</a>
    │      │
    │      └ OCX
    │          COMコントロール生成場所
    │
    ├── RegisterBatchs
    │      OCX, SoDLL のCOMサーバー登録バッチ
    │
    └── WinApi
           FlutterI/FのためのAPIプロジェクト
           ⇒OPOSコントロール構成のデバイス固有ライブラリ
</pre>