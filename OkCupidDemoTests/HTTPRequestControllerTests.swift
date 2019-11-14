//
//  HTTPRequestControllerTests.swift
//  OkCupidDemoTests
//
//  Created by Paul McGrath on 11/14/19.
//  Copyright © 2019 Paul McGrath. All rights reserved.
//

import Foundation

import XCTest
@testable import OkCupidDemo

class HTTPRequestControllerTests: XCTestCase {

    func testValidCall() {
        let requestController: HTTPRequestController = HTTPRequestController()
        let dataExpectation = expectation(description: "getData completed with success")
        requestController.getData { (data, error) in
            XCTAssertNotNil(data)
            XCTAssertNil(error)
            dataExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testInvalidURLCall() {
        let requestController: HTTPRequestController = HTTPRequestController(urlString: "www.dummyURL.com")
        let invalidCallExpectation = expectation(description: "getData completed with data error")
        requestController.getData { (data, error) in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription, "unsupported URL")
            invalidCallExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testAccessDeniedCall() {
        let requestController: HTTPRequestController = HTTPRequestController(urlString: "https://techblog-static.s3.amazonaws.com/interview/")
        let statusCodeExpectation = expectation(description: "getData completed with statuscode error")
        requestController.getData { (data, error) in
            XCTAssertNotNil(data)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription, "The operation couldn’t be completed. ( error 403.)")
            statusCodeExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

}

