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
        let expectations = expectation(description: "\(#function)\(#line)")
        print("------BEGIN------")
        LaPoste.getPackagePrice(type: "colis", weight: 1300) { value, error in
            // use responseObject and error here
            XCTAssert(error == nil, "Prix récupéré")
            //print("value = \(value); error = \(error)")
            if (value != nil) {
                let tab = value! as Array<PriceResponse>
                for i in (0..<tab.count) {
                    print("\(tab[i].product) : \(tab[i].channel)")
                    print("Price : \(tab[i].price)\(tab[i].currency)")
                }
            } else {
                print (error!)
            }
            print("------END------")
            expectations.fulfill()
        }
        self.waitForExpectations(timeout: 15, handler: nil)
    }
    
    func testPriceFailure() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectations = expectation(description: "\(#function)\(#line)")
        print("------BEGIN------")
        LaPoste.getPackagePrice(type: "lettre recommandée", weight: 1300) { value, error in
            // use responseObject and error here
            XCTAssert(error != nil, "Il y a bien une erreur")
            //print("value = \(value); error = \(error)")
            if (value != nil) {
                let tab = value! as Array<PriceResponse>
                for i in (0..<tab.count) {
                    print("\(tab[i].product) : \(tab[i].channel)")
                    print("Price : \(tab[i].price)\(tab[i].currency)")
                }
            } else {
                print (error!)
            }
            print("------END------")
            expectations.fulfill()
        }
        self.waitForExpectations(timeout: 15, handler: nil)
    }
    
    //codes : Valid : 8G00466375322
    //Invalid : 6A06489133413 (too old)
    //Invalid : 8J13257432657
    
    func testTrack() {
        let expectations = expectation(description: "\(#function)\(#line)")
        print("------BEGIN------")
        LaPoste.getTrack(code: "8G00466375322"){ value, error in
            // use responseObject and error here
            XCTAssert(error == nil, "OK")
            //print("value = \(value); error = \(error)")
            if (value != nil) {
                let track = value! as TrackResponse
                if (track.status == nil){
                    print("Erreur. \(track.message)")
                } else {
                    print("\(track.type!) numéro \(track.code). \(track.message) : \(track.status!). \nDernière modification : \(track.date!). Plus d'infos : \(track.link!)")
                }
            }
            print("------END------")
            expectations.fulfill()
        }
        self.waitForExpectations(timeout: 15, handler: nil)
        
    }
    
    /*func testPerformanceExample() {
     // This is an example of a performance test case.
     self.measure {
     // Put the code you want to measure the time of here.
     }
     }*/
    
}
