//
//  ApiSampleViewController.swift
//  SampleApp
//
//  Created by Mercury on 2019/05/26.
//  Copyright © 2019 Rirex. All rights reserved.
//
//  Question2: 気温表示しよう
//


import UIKit
import Alamofire
import SwiftyJSON

class ApiSampleViewController: UIViewController {
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    @IBAction func getWeatherButtonTapped(_ sender: Any) {
        getWeather(lat: 34.7326198, lng: 135.73401450000006)
    }
    
    func getWeather(lat: Double, lng: Double) {
        let baseUrl = "http://api.openweathermap.org/data/2.5/forecast"
        let gpsOption = "?lat=\(lat)&lon=\(lng)"
        let modeOption = "&mode=json"
        let cntOption = "&cnt=14"
        let idOption = "&APPID=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" // OpenWeatherMapのAPIキーをセット
        let requestUrl = baseUrl + gpsOption + modeOption + cntOption + idOption
        
        // requestUrlに対してリクエストを送る
        Alamofire.request(requestUrl, method: .get)
            .responseJSON { response in
                if response.result.isSuccess { // リクエストが成功すれば...
                    let json = JSON(response.result.value)
                    print(json)
                    self.weatherLabel.text = "お天気： \(json["list"][0]["weather"][0]["main"])"
                    // Question2 ここに実装
                    
                } else {
                    print("Error")
                }
        }
    }
}

// 答え
// let kelvin = atof(json["list"][0]["main"]["temp"].stringValue)
// self.temperatureLabel.text = "気温： \(kelvin - 273.15)"
