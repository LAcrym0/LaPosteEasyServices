//
//  PriceResponse.swift
//  LaPosteEasyServices
//
//  Created by Grunt on 06/02/2017.
//  Copyright © 2017 Grunt. All rights reserved.
//

import Foundation

public class PriceResponse{

    var channel: String = String()
    var currency: String = String()
    var price: Double = Double()
    var product: String = String()
    
    init?(json: [String: Any]) {
        guard let channel = json["channel"] as? String,
            let currency = json["currency"] as? String,
            let price = json["price"] as? Double,
            let product = json["product"] as? String
            else {
                return nil
        }
        self.channel = channel
        self.currency = currency
        self.price = price
        self.product = product
        
    }
}
