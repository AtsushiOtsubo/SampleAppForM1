//
//  ApiSampleViewController.swift
//  SampleApp
//
//  Created by Mercury on 2019/05/26.
//  Copyright © 2019 Rirex. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ApiSampleViewController: UIViewController {

    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBAction func getWeatherButtonTapped(_ sender: Any) {
        let baseUrl = "http://api.openweathermap.org/data/2.5/forecast"
        let gpsOption = "?lat=34.7326198&lon=135.73401450000006"
        let modeOption = "&mode=json"
        let cntOption = "&cnt=14"
        let idOption = "&APPID=542ffd081e67f4512b705f89d2a611b2"
        let requestUrl = baseUrl + gpsOption + modeOption + cntOption + idOption
        
        Alamofire.request(requestUrl, method: .get)
            .responseJSON { response in
                let json = JSON(response.result.value)
                print(json)
                self.weatherLabel.text = "お天気： \(json["list"][0]["weather"][0]["main"])"
        }
    }
}
