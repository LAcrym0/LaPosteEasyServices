//
//  CheckAddress.swift
//  LaPosteEasyServices
//
//  Created by Nico on 09/02/2017.
//  Copyright © 2017 Rémi. All rights reserved.
//

import Foundation

public class CheckAddress{
    
    var adresse: String = String()
    var code: String = String()
    
    init?(json: [String: Any]) {
        guard let adresse = json["adresse"] as? String,
            let code = json["code"] as? String
            else {
                return nil
        }
        self.adresse = adresse
        self.code = code
    }
}
