//
//  RequestController.swift
//  OkCupidDemo
//
//  Created by Paul McGrath on 11/13/19.
//  Copyright © 2019 Paul McGrath. All rights reserved.
//

import Foundation

public protocol RequestController {
    func getData(completionHandler:@escaping (_ data:Data?, _ error:Error?) -> Void)
}
