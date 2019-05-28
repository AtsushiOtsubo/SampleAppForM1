//
//  WeatherClockViewController.swift
//  SampleApp
//
//  Created by Mercury on 2019/05/27.
//  Copyright © 2019 Rirex. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import AVFoundation

class WeatherClockViewController: UIViewController, CLLocationManagerDelegate {

    // 各UIパーツとの関連付け
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var setButton: UIButton!
    
    var isSetAlarm = false  // アラームがセットされているかのフラグ
    var weather = ""        // 天気情報保持用
    var locationManager: CLLocationManager! // 位置情報取得に使用
    var audioPlayer: AVAudioPlayer!         // アラーム再生に使用
    
    // この画面を最初に開いたときに呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    func initialization() {
        loadAlarmTime() // アラームの設定時刻を読み込み
        setupLocationManager() // 位置情報の取得を開始
        startTimer() // タイマーをスタート
    }
    
    // アラームの設定時刻を読み出す
    func loadAlarmTime() {
        // アラーム設定時刻を00:00の形式で読み出す
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        if let dateStr = UserDefaults.standard.string(forKey: "date") {
            // データが存在する場合、アラームをセット
            datePicker.date = formatter.date(from: dateStr)!
            setAlarm()
        }
    }
    
    // 位置情報の取得開始
    func setupLocationManager() {
        locationManager = CLLocationManager() // CLLocationManager: 位置情報に関するサービスを提供
        locationManager.requestWhenInUseAuthorization() // 位置情報の使用権限をユーザにリクエスト
        locationManager.delegate = self // Delegateの対象(位置情報取得後に呼ばれる関数の在りか)をこのクラスにする
        locationManager.startUpdatingLocation() // 位置情報の取得開始
    }
    
    func startTimer() {
        // タイマーをスタート
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WeatherClockViewController.timerUpdate), userInfo: nil, repeats: true)
    }
    
    
    // 1秒ごとに1回呼ばれる
    @objc func timerUpdate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        if (isSetAlarm == true) {
            let alarmTime = formatter.string(from: datePicker.date)
            let now = formatter.string(from: Date())
            if (now == alarmTime) {
                switch (weather) {
                case "Clear":
                    playAlarm(filename: "SunnyVoice")
                case "Clouds":
                    playAlarm(filename: "CloudyVoice")
                case "Rain":
                    playAlarm(filename: "RainyVoice")
                default:
                    playAlarm(filename: "SunnyVoice")
                }
                releaseAlarm()
            }
        }
    }
    
    // セットボタンが押された時に呼ばれる
    @IBAction func setButtonTapped(_ sender: Any) {
        if (isSetAlarm == true) {
            releaseAlarm() // アラーム解除
        } else {
            setAlarm() // アラームセット
        }
    }
    
    // 位置情報の取得完了時に呼ばれる
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first! // 最新の位置情報を使用
        let latitude = round(location.coordinate.latitude * 100000) / 100000 // 緯度経度を四捨五入
        let longitude = round(location.coordinate.longitude * 100000) / 100000
        locationLabel.text = "位置情報 緯度: \(latitude), 経度: \(longitude)" // ラベルに表示
        locationManager.stopUpdatingLocation() // 位置情報取得の終了
        getWeather(lat: latitude, lng: longitude) // 天気情報取得の開始
    }
    
    // 天候の取得
    func getWeather(lat: Double, lng: Double) {
        // requestUrlの作成
        let baseUrl = "http://api.openweathermap.org/data/2.5/forecast"
        let gpsOption = "?lat=\(lat)&lon=\(lng)"
        let modeOption = "&mode=json"
        let cntOption = "&cnt=14"
        let idOption = "&APPID=542ffd081e67f4512b705f89d2a611b2"
        let requestUrl = baseUrl + gpsOption + modeOption + cntOption + idOption
        
        // 指定したURLにリクエストを送信
        Alamofire.request(requestUrl, method: .get)
            .responseJSON { response in
                // JSON形式で結果が返ってくるので、SwiftyJSONを使ってJSON形式を配列に直す(=パース)
                let json = JSON(response.result.value)
                self.weather = json["list"][0]["weather"][0]["main"].string!
                self.weatherLabel.text = "お天気： \(self.weather)"
        }
    }
    
    // アラームをセット
    func setAlarm() {
        // アラーム設定をHH:mmの形で保存
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let alarmTime = formatter.string(from: datePicker.date)
        UserDefaults.standard.set(alarmTime, forKey: "date")
        setButton.setTitle("セット済", for: .normal)
        setButton.setTitleColor(.red, for: .normal)
        isSetAlarm = true
    }
    
    // アラームを解除
    func releaseAlarm() {
        // nilを書き込んで削除
        UserDefaults.standard.set(nil, forKey: "date")
        setButton.setTitle("セット", for: .normal)
        setButton.setTitleColor(.blue, for: .normal)
        isSetAlarm = false
    }
    
    // アラーム音を再生
    func playAlarm(filename: String) {
        let path = Bundle.main.path(forResource: filename, ofType: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
        audioPlayer.play() // 音声の再生
    }
    
}
