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
    
    //the key used by the server to authenticate (must subscribe to the service before)
    static let serverKey = "VBOAJGog/9iuodsBEzlQNctU0b4479aR0QV/RlOzTShg6jPxme/dyAY/7gdIa8NZ"
    //the api URL
    static let apiUrl = "https://api.laposte.fr/"
    //the endpoint for the price request
    static let apiEndPointTarif = "tarifenvoi/v1?"
    //the endpoint for the track request
    static let apiEndPointTrack = "suivi/v1/?"
    
    /**
    * Static function that takes 2 parameters and escapes a completionHandler to return the returnValue
    * and the error. Both may be nil.
    * If a request is successful, it will return an array of PriceResponse for the value and nil for the
    * error
    * If a request fails, it will return nil for the value and the error 
    * @param type : String that defines the type of package to send. According to the doc, values can be 
    * “colis”, “chronopost”, or “lettre”. If the value is incorrect the default value will be “lettre”
    * @param weight : Int that corresponds to the weight of the package in milligrams
    **/
    class func getPackagePrice(type: String, weight: Int, completionHandler: @escaping (Array<PriceResponse>?, Error?) -> ()) {
        //format the header to authorize and get correct response format
        let headers: HTTPHeaders = [
            "X-Okapi-Key":LaPoste.serverKey,
            "Accept": "application/json"
        ]
        
        //send the request with headers, format it with apiUrl and correct endpoint, then add the
        //parameters.
        Alamofire.request("\(apiUrl)\(apiEndPointTarif)type=\(type)&weight=\(weight)", headers: headers)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                //test the response to know if it failed or succeeded
                switch response.result {
                case .success(let value):
                    //we get the array of responses
                    let array = value as! Array<Any>
                    //we create a new array to store the formatted objects
                    var responses: [PriceResponse] = []
                    //we loop in the array to populate the formatted array
                    for i in (0..<array.count) {
                        //format the entry
                        if let resp = PriceResponse(json: array[i] as! [String : Any]) {
                            //then add it to the array
                            responses.append(resp)
                        }
                    }
                    //return the response array for the value and nil for the error
                    completionHandler(responses, nil)
                case .failure(let error):
                    //return nil for the value and the error for error
                    completionHandler(nil, error)
                }
        }
        
    }
    
    /**
     * Static function that takes 1 parameter and escapes a completionHandler to return the returnValue
     * and the error. Both may be nil.
     * If a request is successful, it will return a TrackResponse for the value and nil for the
     * error
     * If a request fails, it will return nil for the value and the error
     * @param code : String that defines the code of the package to track. According to the doc, the
     * string size has to be 13 characters to be valid
     **/
    class func getTrack(code: String, completionHandler: @escaping (TrackResponse?, Error?) -> ()) {
        //format the header to authorize and get correct response format
        let headers: HTTPHeaders = [
            "X-Okapi-Key":LaPoste.serverKey,
            "Accept": "application/json"
        ]
        
        //send the request with headers, format it with apiUrl and correct endpoint, then add the
        //parameters.
        Alamofire.request("\(apiUrl)\(apiEndPointTrack)?code=\(code)", headers: headers)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                //test the response to know if it failed or succeeded
                switch response.result {
                case .success(let value):
                    //we get the response and format it in a TrackResponse object
                    let track = TrackResponse(json: value as! [String : Any])
                    //return the value and a nil error
                    completionHandler(track, nil)
                case .failure(let error):
                    //return nil for the value and the error
                    completionHandler(nil, error)
                }
        }
    }
    
    class func getCheckAddress(address: String, completionHandler: @escaping (Array<CheckAddress>?, Error?) -> ()) {
        let headers: HTTPHeaders = [
            "X-Okapi-Key":LaPoste.serverKey,
            "Accept": "application/json"
        ]
        print("---Request prepared---")
        
        Alamofire.request("https://api.laposte.fr/controladresse/v1/addresses?q=\(address)", headers: headers)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                print("---Response received---")
                //print(response)
                switch response.result {
                case .success(let value):
                    let dico = value as! NSDictionary
//                    let array = value as! Array<Any>
                    var responses: [CheckAddress] = []
                    for i in (0..<dico.count) {
                        if let resp = CheckAddress(json: dico[i] as! [String : Any]) {
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
}

