### ローカルPCでのmdファイル確認方法
ブラウザでMarkdownを表示する方法  
https://qiita.com/SUZUKI_Masaya/items/6476dbbcb3e369640c78  
  
  
  
  
# ffi_debug_app
A dart:ffi debug project.  
  
  
  
## Getting Started  
This project is a starting point for a Flutter application.  
  
A few resources to get you started if this is your first Flutter project:  
  
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)  
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)  
  
For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
  
  
  
# dart:ffiプロジェクト
  
エラーについて「'Pub get' has not been run」で Get dependencies をすれば解決  
  
## ffi_debug_appの実行
### ■Windows  
・そのままデバッグ実行可能  
・exeから実行したい場合：  
「ffi_debug_app\test_library\bin\windows\test.dll」を  
「ffi_debug_app\build\windows\runner\Debug\test_library\bin\windows\test.dll」で配置し、  
「ffi_debug_app\build\windows\runner\Debug\ffi_debug_app.exe」を実行  
  
### ■Android
実行したあと赤画面になるので、「ffi_debug_app\test_library\bin\android」内にあるlibtest.soを  
以下のアーキテクチャを作成したAndroidエミュレータに合わせて「data/data/jp.co.fsi.ffi_debug_app/files/libtest.so」とドラッグ&ドロップで配置  
・arm64-v8a  
・armeabi-v7a  
・x86  
・x86_64 ← 「Pixel 3a API 33」ではこれを配置  
  
※アプリからdll,soファイルを認識できない場合は赤画面になる（再度試すときはホットリロードする）  
  
### ■Linux(Ubuntu)
  
※[LINUX.md](../LINUX.md) - Linux(Ubuntu)環境構築の後でやること
  
#### 1. VirtualBoxでマウント状態の共有フォルダからプロジェクトをコピー
Ubuntu内で共有フォルダとは別のフォルダにプロジェクトをコピーする必要がある  
この場合は、Ubuntuの「ファイル」から「/home/fsi/projects」内にある「ffi_debug_app」を「/home/fsi」に Ctrl+c, Ctrl+v でコピー  
  
#### 2. soファイルの生成
端末内で以下のコマンドを入力して移動  
```
cd /home/fsi/ffi_debug_app/test_library
```
  
gccで以下のコマンドを入力してsoファイルを生成  
```
cmake .
make
```
  
以下にsoファイルが生成されます。  
/home/fsi/ffi_debug_app/test_library/libtest.so.1.0.0  
  
プロジェクト直下のディレクトリに戻る  
```
cd ..
```
  
以下のコマンドでデバッグ実行  
```
flutter run -d linux
```