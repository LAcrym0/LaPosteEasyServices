//
//  LaPosteEasyServicesTests.swift
//  LaPosteEasyServicesTests
//
//  Created by Grunt on 02/02/2017.
//  Copyright © 2017 Grunt. All rights reserved.
//

import XCTest
@testable import LaPosteEasyServices

class LaPosteEasyServicesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPriceSuccess() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //this is necessary to wait the completionHandler, otherwise the test doesn't
        //wait the response
        let expectations = expectation(description: "\(#function)\(#line)")
        
        //webcall with the static method, correct parameters
        LaPoste.getPackagePrice(type: "colis", weight: 1300) { value, error in
            // use value and error here
            
            //the test is passed if the error is nil
            XCTAssert(error == nil, "Prix récupéré")
            
            //display the different prices for each product
            if (value != nil) {
                print(value)
                let tab = value! as Array<PriceResponse>
                for i in (0..<tab.count) {
                    print("\(tab[i].product) : \(tab[i].channel)")
                    print("Price : \(tab[i].price)\(tab[i].currency)")
                }
            } else {
                //display the error
                print (error!)
            }
            
            //stop the timeout before it is raised
            expectations.fulfill()
        }
        
        //start timeout
        self.waitForExpectations(timeout: 15, handler: nil)
    }
    
    func testPriceFailure() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //this is necessary to wait the completionHandler, otherwise the test doesn't
        //wait the response
        let expectations = expectation(description: "\(#function)\(#line)")
        
        //webcall with the static method, incorrect parameters so there must be an error
        LaPoste.getPackagePrice(type: "lettre recommandée", weight: 1300) { value, error in
            // use responseObject and error here
            
            //the test is passed if we have an error
            XCTAssert(error != nil, "Il y a bien une erreur")
            
            //display the different prices for each product
            if (value != nil) {
                let tab = value! as Array<PriceResponse>
                for i in (0..<tab.count) {
                    print("\(tab[i].product) : \(tab[i].channel)")
                    print("Price : \(tab[i].price)\(tab[i].currency)")
                }
            } else {
                //display the error
                print (error!)
            }
            
            //stop the timeout before it is raised
            expectations.fulfill()
        }
        
        //start timeout
        self.waitForExpectations(timeout: 15, handler: nil)
    }
    
    //codes : Valid : 8G00466375322
    //Invalid : 6A06489133413 (too old)
    //Invalid : 8J13257432657
    
    func testTrack() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //this is necessary to wait the completionHandler, otherwise the test doesn't
        //wait the response
        let expectations = expectation(description: "\(#function)\(#line)")
        LaPoste.getTrack(code: "8G00466375322"){ value, error in
            // use responseObject and error here
            
            //the test is passed if the error is nil
            XCTAssert(error == nil, "OK")
            
            //display a formatted track message
            if (value != nil) {
                //if value is nil, we received an error message, display it
                let track = value! as TrackResponse
                if (track.status == nil){
                    print("Erreur. \(track.message)")
                } else {
                    //display a success track message
                    print("\(track.type!) numéro \(track.code). \(track.message) : \(track.status!). \nDernière modification : \(track.date!). Plus d'infos : \(track.link!)")
                }
            }
            //stop the timeout before it is raised
            expectations.fulfill()
        }
        
        //start timeout
        self.waitForExpectations(timeout: 15, handler: nil)
    }
    
    func testCheckAddress() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //this is necessary to wait the completionHandler, otherwise the test doesn't
        //wait the response
        let expectations = expectation(description: "\(#function)\(#line)")
        
        //webcall with the static method, correct parameters
        let str = "remi ollivier 31 allee Sisley montigny"
        LaPoste.getCheckAddress(address: str.replacingOccurrences(of: " ", with: "%20")) { value, error in
            // use value and error here
            
            //the test is passed if the error is nil
            XCTAssert(error == nil, "Adresse checkée")
            
            //display the different prices for each product
            if (value != nil) {
                print("Ville = \(value!.commune)")
            } /*else {
             //display the error
             print ("@@@@@@@@@@@ \(error!)")
             }*/
            
            //stop the timeout before it is raised
            expectations.fulfill()
        }
        
        //start timeout
        self.waitForExpectations(timeout: 15, handler: nil)
    }

    func testAllAddresses() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //this is necessary to wait the completionHandler, otherwise the test doesn't
        //wait the response
        let expectations = expectation(description: "\(#function)\(#line)")
        
        //webcall with the static method, correct parameters
        let str = "remi ollivier 31 allee Sisley montigny"
        LaPoste.getAllAddresses(address: str.replacingOccurrences(of: " ", with: "%20")) { value, error in
            // use value and error here
            
            //the test is passed if the error is nil
            XCTAssert(error == nil, "Adresse checkée")
            
            //display the different prices for each product
            if (value != nil) {
                let tmp: Int = (value?.count)!
                for i in (0..<tmp) {
                    print("Adresse = \(value?[i].adresse)")
                    print("Adresse = \(value?[i].code)")
                }
            } /*else {
             //display the error
             print ("@@@@@@@@@@@ \(error!)")
             }*/
            
            //stop the timeout before it is raised
            expectations.fulfill()
        }
        
        //start timeout
        self.waitForExpectations(timeout: 15, handler: nil)
    }

    func testCheckedAddressWithCode() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //this is necessary to wait the completionHandler, otherwise the test doesn't
        //wait the response
        let expectations = expectation(description: "\(#function)\(#line)")
        
        //webcall with the static method, correct parameters
        let str = "remi ollivier 31 allee Sisley montigny"
        LaPoste.getAllAddresses(address: str.replacingOccurrences(of: " ", with: "%20")) { value, error in
            // use value and error here
            
            //the test is passed if the error is nil
            XCTAssert(error == nil, "Adresse checkée")
            
            //display the different prices for each product
            if (value != nil) {
                let tmp: Int = (value?.count)!
                if (tmp>0) {
                    LaPoste.getCheckedAddressWithCode(code: value![0].code) { value, error in
                        // use value and error here
                        
                        //the test is passed if the error is nil
                        XCTAssert(error == nil, "Adresse checkée")
                        
                        //display the different prices for each product
                        if (value != nil) {
                            print("Ville = \(value!.commune)")
                        }
                    }
                }
            } /*else {
             //display the error
             print ("@@@@@@@@@@@ \(error!)")
             }*/
            
            //stop the timeout before it is raised
            expectations.fulfill()
        }
        
        //start timeout
        self.waitForExpectations(timeout: 15, handler: nil)
    }
}
