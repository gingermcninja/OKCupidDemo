//
//  APIController.swift
//  OkCupidDemo
//
//  Created by Paul McGrath on 11/12/19.
//  Copyright © 2019 Paul McGrath. All rights reserved.
//

import Foundation

public protocol RequestController {
    func getData(completionHandler:@escaping (_ data:Data?, _ error:Error?) -> Void)
}

public class HTTPRequestController: RequestController {
    let endpoint:URL? = URL(string: "https://techblog-static.s3.amazonaws.com/interview/matches.json")
    
    public func getData(completionHandler:@escaping (_ data:Data?, _ error:Error?) -> Void) {
        
        guard let blangchop = URL(string: "https://techblog-static.s3.amazonaws.com/interview/matches.json") else {
            print("fuck")
            return
        }
        
        if let endpointURL = self.endpoint {
            
            let request = URLRequest(url: endpointURL)
            URLSession.shared.dataTask(with: request) {data, _, error in
                var profileData:Data?
                if let apiError = error {
                    print("Error retrieving API data, \(apiError.localizedDescription)")
                }
                if let result = data {
                    profileData = result
                }
                completionHandler(profileData, error)
                return
                }.resume()
        }
    }

}
