//
//  ViewController.swift
//  HiraganaApp
//
//  Created by KAZUMA NOHA on 2019/11/28.
//  Copyright © 2019 KAZUMA NOHA. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var kanjiTextField: UITextField!
    @IBOutlet weak var hiraganaTextView: UITextView!
    
    let url = "https://labs.goo.ne.jp/api/hiragana"
    let headers: HTTPHeaders = [
        "Contenttype": "application/json"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kanjiTextField.delegate = self
    }
    
    @IBAction func changeButton(_ sender: Any) {
        guard let kanji = kanjiTextField.text else {
            return
        }
        if kanji.isEmpty {
            hiraganaTextView.text = "ぶんしょうをにゅうりょくしてください"
            return
        }
        request()
    }
    
    func request() {
        let parameters:[String: Any] = [
            "app_id": "8174a7e80130a47045408472f936b9cf4fa844a233eafc376ceb92b511226376",
            "sentence": kanjiTextField.text!,
            "output_type": "hiragana"
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            guard let jsonData = response.data else {
                print("response err")
                return
            }
            let responseData = try! JSONDecoder().decode(Rubi.self, from: jsonData)
            print(responseData.converted)
            
            self.hiraganaTextView.text = responseData.converted
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


