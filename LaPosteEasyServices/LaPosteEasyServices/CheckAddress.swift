//
//  CheckAddress.swift
//  LaPosteEasyServices
//
//  Created by Nico on 09/02/2017.
//  Copyright © 2017 Nico. All rights reserved.
//

import Foundation

/**
 * The object that stores a CheckAddress object received by the web call
 * The following attributes can't be nil : code, adresse
 * In case of an error, return nil
 **/
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
