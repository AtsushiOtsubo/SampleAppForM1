# WatherAlarm_SampleApp

## 天気に合わせてアラーム音が変わる目覚まし時計

### 説明
時間になるとBOBが優しく起こしてくれた上で、天気を教えてくれるiOSアプリのサンプルです。以下の3つの機能を実装しており、汎用性を持たせています。
- データの保存 (起床時刻を保存・読出)
- スマホ内蔵センサへのアクセス (GPSデータの取得)
- APIへのアクセス (天気情報へのアクセス)


### 起動方法
1. Terminalを起動
2. 以下のコマンドを実行
```
git clone https://github.com/rirex5/SampleApp.git
cd SampleApp
pod install
open SampleApp.xcworkspace
```
