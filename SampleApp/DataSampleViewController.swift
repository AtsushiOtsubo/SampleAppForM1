//
//  DataSampleViewController.swift
//  SampleApp
//
//  Created by Mercury on 2019/05/26.
//  Copyright © 2019 Rirex. All rights reserved.
//
//  Question1: textViewに保存したテキストを表示してみよう！
//


import UIKit

class DataSampleViewController: UIViewController {

    @IBOutlet weak var textView: UITextView! // TextViewとの関連付け
    
    // 保存を押した時呼ばれる
    @IBAction func saveButtonTapped(_ sender: Any) {
        let writtenText = textView.text!
        UserDefaults.standard.set(writtenText, forKey: "text")
        view.endEditing(true)
    }
    
    // 読み込みボタンを押した時呼ばれる
    @IBAction func readButtonTapped(_ sender: Any) {
        // Question1 ここに実装
        
        
    }
    
}


// 答え
// let value = UserDefaults.standard.string(forKey: "text")
// textView.text = value
