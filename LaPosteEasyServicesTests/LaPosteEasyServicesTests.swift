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
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectations = expectation(description: "\(#function)\(#line)")
        print("------BEGIN------")
        LaPoste.getPackagePrice(type: "colis", weight: 1300) { value, error in
            // use responseObject and error here
            XCTAssert(error == nil, "OK")
            print("value = \(value); error = \(error)")
            if (value != nil) {
                print("value = \(value!)")
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
