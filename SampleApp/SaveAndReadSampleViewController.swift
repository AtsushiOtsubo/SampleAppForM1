//
//  SaveAndReadSampleViewController.swift
//  SampleApp
//
//  Created by Mercury on 2019/05/26.
//  Copyright © 2019 Rirex. All rights reserved.
//

import UIKit

class SaveAndReadSampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func readButtonTapped(_ sender: Any) {
        let defaults = UserDefaults.standard
        let value = defaults.string(forKey: "text")
        textView.text = value
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let writtenText = textView.text! as NSString
        let defaults = UserDefaults.standard
        defaults.set(writtenText, forKey: "text")
        view.endEditing(true)
    }
    
}
