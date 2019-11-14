//
//  ProfileModelTests.swift
//  OkCupidDemoTests
//
//  Created by Paul McGrath on 11/11/19.
//  Copyright © 2019 Paul McGrath. All rights reserved.
//

import Foundation

import XCTest
@testable import OkCupidDemo

class ProfileFactoryTests: XCTestCase {
    
    private var factory: ProfileFactory!
    
    override func setUp() {
        factory = ProfileFactory(requestManager: MockRequestController())
    }

    func testGetProfiles() {
        let profileExpectation = expectation(description: "profiles retrieved")
        factory.getProfiles { (profiles, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(profiles)
            XCTAssertEqual(profiles?.count, 18)
            profileExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFaultyProfiles() {
        factory.requestManager = MockRequestController(filename: "faultyJson")
        let errorExpectation = expectation(description: "faulty profiles retrieved")
        factory.getProfiles { (profiles, error) in
            XCTAssertNil(profiles)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription, "The data couldn’t be read because it is missing.")
            errorExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

}
