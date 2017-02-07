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

    class func getPackagePrice(type: String, weight: Int, completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
        let headers: HTTPHeaders = [
            "X-Okapi-Key":LaPoste.serverKey
        ]
        print("---Request prepared---")
        
        Alamofire.request("https://api.laposte.fr/tarifenvoi/v1?type=\(type)&weight=\(weight)", headers: headers)
            .responseJSON { response in
                print("---Response received---")
                switch response.result {
                case .success(let value):
                    completionHandler(value as? NSDictionary, nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
        }

    }
    
    /*class func getPrice(type: String, weight: Int) {//-> String? {
        let headers: HTTPHeaders = [
            "X-Okapi-Key":serverKey
        ]
        //var returnValue: DataResponse<Any>
        Alamofire.request("https://api.laposte.fr/tarifenvoi/v1{?\(type),\(weight)}", headers: headers).responseJSON { response in
            debugPrint(response)
            //returnValue = response
        }
        //return returnValue.description
    }*/

    
        /*func makeCall(_ url: String, completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
            let headers: HTTPHeaders = [
                "X-Okapi-Key":LaPoste.serverKey
            ]

            
            Alamofire.request(url, headers: headers)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        completionHandler(value as? NSDictionary, nil)
                    case .failure(let error):
                        completionHandler(nil, error)
                    }
            }
        }*/
}

