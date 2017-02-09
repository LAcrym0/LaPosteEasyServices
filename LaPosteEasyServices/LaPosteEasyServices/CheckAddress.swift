//
//  CheckAddress.swift
//  LaPosteEasyServices
//
//  Created by Nico on 09/02/2017.
//  Copyright © 2017 Rémi. All rights reserved.
//

import Foundation

public class CheckAddress {
    //needed attributes
    var address: String = String()
    var code: String = String()
    
    init?(json: [String: Any]) {
        //check if the needed attributes are set, otherwise return a nil object
        guard let address = json["address"],
            let code = json["code"]
            else {
                return nil
        }
        
        //needed attributes
        self.code = code as! String
        self.address = address as! String
        
    }

}
