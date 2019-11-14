//
//  MockRequestController.swift
//  OkCupidDemoTests
//
//  Created by Paul McGrath on 11/13/19.
//  Copyright © 2019 Paul McGrath. All rights reserved.
//

import Foundation

class MockRequestController: RequestController {
    func getData(completionHandler: @escaping (Data?, Error?) -> Void) {
        let bundle = Bundle(for: type(of: self))
        guard let localJsonURL = bundle.url(forResource: "mockProfiles", withExtension: "json") else {
            fatalError("mockProfiles.json is not found")
        }
        let data = try! Data(contentsOf: localJsonURL)
        completionHandler(data, nil)
    }
}
