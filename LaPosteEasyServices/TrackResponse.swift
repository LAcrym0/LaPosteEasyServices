//
//  File.swift
//  LaPosteEasyServices
//
//  Created by Rémi on 09/02/2017.
//  Copyright © 2017 Rémi. All rights reserved.
//

import Foundation

public class TrackResponse{
    
    var code: String = String()
    var message: String = String()
    var date: String? = String()
    var status: String? = String()
    var link: String? = String()
    var type: String? = String()
    
    init?(json: [String: Any]) {
        guard let code = json["code"],
            let message = json["message"]
            else {
                return nil
        }
        let date = json["date"]
        let status = json["status"]
        let link = json["link"]
        let type = json["type"]
        
        self.code = code as! String
        self.message = message as! String
        self.date = date as? String
        self.status = status as? String
        self.link = link as? String
        self.type = type as? String
    }
}
