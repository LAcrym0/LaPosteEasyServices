//
//  File.swift
//  LaPosteEasyServices
//
//  Created by Rémi on 09/02/2017.
//  Copyright © 2017 Rémi. All rights reserved.
//

import Foundation

/**
 * The object that stores a TrackResponse object received by the web call
 * The following attributes can be nil : date, status, link, type
 * The following attributes can't be nil : code, message
 * In case of an error, only the needed attributes will be set, the others will be nil
 **/
public class TrackResponse{
    //needed attributes
    var code: String = String()
    var message: String = String()
    
    //nullable attributes
    var date: String? = String()
    var status: String? = String()
    var link: String? = String()
    var type: String? = String()
    
    init?(json: [String: Any]) {
        //check if the needed attributes are set, otherwise return a nil object
        guard let code = json["code"],
            let message = json["message"]
            else {
                return nil
        }
        let date = json["date"]
        let status = json["status"]
        let link = json["link"]
        let type = json["type"]
        
        //needed attributes
        self.code = code as! String
        self.message = message as! String
        
        //nullable attributes
        self.date = date as? String
        self.status = status as? String
        self.link = link as? String
        self.type = type as? String
    }
}
