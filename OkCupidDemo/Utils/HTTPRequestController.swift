//
//  APIController.swift
//  OkCupidDemo
//
//  Created by Paul McGrath on 11/12/19.
//  Copyright © 2019 Paul McGrath. All rights reserved.
//

import Foundation

public class HTTPRequestController: RequestController {
    var endpoint:URL?
    
    init(urlString: String = "https://techblog-static.s3.amazonaws.com/interview/matches.json") {
        self.endpoint = URL(string: urlString)
    }
    
    public func getData(completionHandler:@escaping (_ data:Data?, _ error:Error?) -> Void) {
        
        if let endpointURL = self.endpoint {
            
            let request = URLRequest(url: endpointURL)
            URLSession.shared.dataTask(with: request) {data, response, error in
                var profileData:Data?
                var sessionError:Error?
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode != 200 {
                        sessionError = NSError(domain: "", code: httpResponse.statusCode, userInfo: nil)
                    }
                }
                
                if let apiError = error {
                    print("Error retrieving API data, \(apiError.localizedDescription)")
                    sessionError = apiError
                }
                
                if let result = data {
                    profileData = result
                }
                
                completionHandler(profileData, sessionError)
                return
            }.resume()
        }
    }

}
