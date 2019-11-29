//
//  API.swift
//  HiraganaApp
//
//  Created by KAZUMA NOHA on 2019/11/29.
//  Copyright © 2019 KAZUMA NOHA. All rights reserved.
//

import UIKit
import Alamofire

class API {
    
    let url = "https://labs.goo.ne.jp/api/hiragana"
    let headers: HTTPHeaders = [
        "Contenttype": "application/json"
    ]
    
    func request(text: String, completed: ((String) -> Void)?){
        
        let parameters:[String: Any] = [
             "app_id": "8174a7e80130a47045408472f936b9cf4fa844a233eafc376ceb92b511226376",
             "sentence": text,
             "output_type": "hiragana"
        ]

         Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
             guard let jsonData = response.data else {
                 print("response err")
                 return
             }
             let hiraganaData = try! JSONDecoder().decode(Rubi.self, from: jsonData)
             print(hiraganaData.converted)
             completed?(hiraganaData.converted)
         }
    }
}
