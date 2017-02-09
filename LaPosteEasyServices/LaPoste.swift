//
//  LaPoste.swift
//  LaPosteEasyServices
//
//  Created by Grunt on 02/02/2017.
//  Copyright © 2017 Grunt. All rights reserved.
//

import Foundation
import Alamofire

public class LaPoste {
    
    static let serverKey = "VBOAJGog/9iuodsBEzlQNctU0b4479aR0QV/RlOzTShg6jPxme/dyAY/7gdIa8NZ"
    static let apiUrl = "https://api.laposte.fr/"
    static let apiEndPoint = "tarifenvoi/v1{?"
    
    class func getPackagePrice(type: String, weight: Int, completionHandler: @escaping (Array<PriceResponse>?, Error?) -> ()) {
        let headers: HTTPHeaders = [
            "X-Okapi-Key":LaPoste.serverKey,
            "Accept": "application/json"
        ]
        print("---Request prepared---")
        
        Alamofire.request("https://api.laposte.fr/tarifenvoi/v1?type=\(type)&weight=\(weight)", headers: headers)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                print("---Response received---")
                //print(response)
                switch response.result {
                case .success(let value):
                    let array = value as! Array<Any>
                    var responses: [PriceResponse] = []
                    for i in (0..<array.count) {
                        if let resp = PriceResponse(json: array[i] as! [String : Any]) {
                            responses.append(resp)
                            //print(resp.channel)
                        }
                    }
                    completionHandler(responses, nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
        }
        
    }
    
    class func getTrack(code: String, completionHandler: @escaping (TrackResponse?, Error?) -> ()) {
        let headers: HTTPHeaders = [
            "X-Okapi-Key":LaPoste.serverKey,
            "Accept": "application/json"
        ]
        print("---Request prepared---")
        
        Alamofire.request("https://api.laposte.fr/suivi/v1/?code=\(code)", headers: headers)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                print("---Response received---")
                //print(response)
                switch response.result {
                case .success(let value):
                    print(value)
                    let track = TrackResponse(json: value as! [String : Any])
                    completionHandler(track, nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
        }
        
    }
}
