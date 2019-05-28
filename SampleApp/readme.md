# WatherAlarm_SampleApp

## 天気に合わせてアラーム音が変わる目覚まし時計

### 起動方法

1. Terminalを起動
```
git clone https://github.com/rirex5/SampleApp.git
cd SampleApp
pod install
open SampleApp.xcworkspace
```

### 説明
以下の3つの要素を含んでいるサンプルです。
- データの保存 (起床時刻を保存・読出)
- スマホ内蔵センサへのアクセス (GPSデータの取得)
- APIへのアクセス (天気情報へのアクセス)
