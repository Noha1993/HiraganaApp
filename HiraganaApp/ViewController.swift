//
//  ViewController.swift
//  HiraganaApp
//
//  Created by KAZUMA NOHA on 2019/11/28.
//  Copyright © 2019 KAZUMA NOHA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var kanjiTextField: UITextField!
    @IBOutlet weak var hiraganaTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kanjiTextField.delegate = self
    }
    
    //変換ボタンが押されたときの動作
    @IBAction func changeButton(_ sender: Any) {
        guard let kanji = kanjiTextField.text else {
            return
        }
        if kanji.isEmpty {
            hiraganaTextView.text = "ぶんしょうをにゅうりょくしてください"
            return
        }
        
        let api = API()
        api.request(text: kanji) { hiraganaData in
            self.hiraganaTextView.text = hiraganaData
        }
        //キーボードを閉じる
        kanjiTextField.endEditing(true)
    }
    
    //Returnが押されたときの動作
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let kanji = kanjiTextField.text else {
            return true
        }
        if kanji.isEmpty {
            hiraganaTextView.text = "ぶんしょうをにゅうりょくしてください"
            return true
        }
        let api = API()
        api.request(text: kanji) { hiraganaData in
            self.hiraganaTextView.text = hiraganaData
        }
        return true
    }
    
    //画面をタップするとキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


