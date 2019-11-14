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
        //let factory = ProfileFactory(requestManager: MockRequestController())
        factory.getProfiles { (profiles, error) in
            XCTAssert(error == nil)
            XCTAssertEqual(profiles?.count, 18)
        }
    }

}
