//
//  APIController.swift
//  OMDb-client
//
//  Created by Robin Douglas on 15/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import UIKit

enum APIService {

    private struct Param {
        let key: String
        let value: String
    }

    private static var baseURL: String {
        return Bundle.main.object(forInfoDictionaryKey: "API") as! String
    }

}
