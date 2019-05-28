//
//  SensorSampleViewController.swift
//  SampleApp
//
//  Created by Mercury on 2019/05/26.
//  Copyright © 2019 Rirex. All rights reserved.
//
//   
// 

import UIKit
import CoreLocation

class SensorSampleViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    @IBOutlet weak var locationLabel: UILabel!
    
    // この画面を開いた時呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager() // LocationManagerを宣言
        locationManager.requestWhenInUseAuthorization() // 位置情報を使用する権限をリクエスト
        locationManager.delegate = self // Delegateの対象(位置情報取得後に呼ばれる関数の在りか)をこのクラスにする
    }
    
    // 位置情報取得を押すと呼ばれる
    @IBAction func getLocationButtonTapped(_ sender: Any) {
        locationManager.startUpdatingLocation() // 位置情報の取得開始
    }
    
    // 位置情報の取得完了時に呼ばれる
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first!
        // 緯度経度を四捨五入
        let latitude = round(location.coordinate.latitude * 100000) / 100000
        let longitude = round(location.coordinate.longitude * 100000) / 100000
        locationLabel.text = "緯度: \(latitude), 経度: \(longitude)" // ラベルに表示
        locationManager.stopUpdatingLocation() // 位置情報取得の終了
    }
    
}
