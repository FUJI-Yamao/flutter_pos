### ローカルPCでのmdファイル確認方法
ブラウザでMarkdownを表示する方法  
https://qiita.com/SUZUKI_Masaya/items/6476dbbcb3e369640c78  
  
  
  
  
# test_library
  
先に共有ライブラリを格納するためのbinフォルダを作成しておく  
```
mkdir bin
```
  
## Windows
**make_dll.bat**  
実行後DLLを生成  
bin/Windows/配下にてtest.dllが生成される  
  
## Android
**make_android_so.bat**  
MSYS2起動  
以下コマンドからシェルスクリプト実行（パスは個人用に設定しておく）  
※Android StudioからNDKをインストールしておくこと  
```
sh ndk.sh
```
bin/Android/配下にて各アーキテクチャのlibtest.soが生成される  
  
## Ubuntu
以下コマンド実行  
```
cmake .
make
```
カレントディレクトリにてlibtest.so.1.0.0が生成される  
