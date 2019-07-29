//
//  POSTJson.swift
//  MobileTest
//
//  Created by Paulo Ricardo on 25/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import Foundation


class POSTJason {
    
    func post(data: Banco) {
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            guard let url = URL(string: "https://raw.githubusercontent.com/PauloRicardo56/JSONs/master/JSON03.json") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            request.httpBody = jsonData
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
