//
//  APIController.swift
//  OMDb-client
//
//  Created by Robin Douglas on 15/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import UIKit

enum APIService {

    private enum ParamKey: String {
        case search = "s"
        case type   = "type"
        case plot   = "plot"
        case year   = "y"
    }

    private typealias Param = (key: ParamKey, value: String)

    private static var baseURL: String {
        return Bundle.main.object(forInfoDictionaryKey: "API") as! String
    }

    private static func url(_ params: [Param]) -> URL {
        var urlString = baseURL
        for param in params {
            urlString.append("&\(param.key.rawValue)=\(param.value)")
        }
        // Always get full plot
        urlString.append("&\(ParamKey.plot.rawValue)=full")
        return URL(string: urlString)!
    }

    static func performSearch(_ searchString: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        URLSession.shared.dataTask(with: url([(.search, searchString)])) { (data, _, _) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            guard let data = data else { return }
            do {
                let items = try JSONDecoder().decode(OMDbSearch.self, from: data)
                print(items)
            } catch {
                print("😅")
            }
        }.resume()
    }

}
