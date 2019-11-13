//
//  ProfileFactory.swift
//  OkCupidDemo
//
//  Created by Paul McGrath on 11/12/19.
//  Copyright © 2019 Paul McGrath. All rights reserved.
//

import Foundation

struct ProfileFactory {
    var requestManager: RequestController?
    
    init(requestManager: RequestController = HTTPRequestController()) {
        self.requestManager = requestManager
    }
    
    func getProfiles(completionHandler: @escaping (_ profiles:[Profile]?, _ error:Error?) -> Void) {
        guard let requestManager = self.requestManager else {
            completionHandler(nil, nil)
            return
        }
        var resposneProfiles: [Profile]? = nil
        
        requestManager.getData { (data, error) in
            
            if let apiData = data {
                let jsondecoder = JSONDecoder()
                do {
                    let apiResponse = try jsondecoder.decode(APIResponse.self, from:apiData)
                    resposneProfiles = apiResponse.data
                } catch let jsonError {
                    completionHandler(nil, jsonError)
                }
            }
            completionHandler(resposneProfiles, error)
        }
    }
}
