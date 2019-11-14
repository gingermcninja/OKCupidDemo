//
//  MockRequestController.swift
//  OkCupidDemoTests
//
//  Created by Paul McGrath on 11/13/19.
//  Copyright © 2019 Paul McGrath. All rights reserved.
//

import Foundation

class MockRequestController: RequestController {
    var fileName: String?
    
    init(filename: String = "mockProfiles") {
        self.fileName = filename
    }
    
    func getData(completionHandler: @escaping (Data?, Error?) -> Void) {
        let bundle = Bundle(for: type(of: self))
        guard let jsonFilename = self.fileName, let localJsonURL = bundle.url(forResource: jsonFilename, withExtension: "json") else {
            fatalError("json file not found")
        }
        let data = try! Data(contentsOf: localJsonURL)
        completionHandler(data, nil)
    }
    
}
