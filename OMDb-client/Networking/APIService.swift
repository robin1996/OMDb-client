//
//  APIController.swift
//  OMDb-client
//
//  Created by Robin Douglas on 15/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import UIKit

enum APIError: Error {
    case noData
}

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

    private static var imdbURL: String {
        return Bundle.main.object(forInfoDictionaryKey: "IMDbAddress") as! String
    }

    static func openInSafari(_ item: OMDbItem, completion: ((Bool) -> Void)? = nil) {
        UIApplication.shared.open(
            URL(string: "\(imdbURL)\(item.id)")!,
            options: [:],
            completionHandler: completion
        )
    }

    private static func url(_ params: [Param]) -> URL {
        var urlString = baseURL
        for param in params {
            urlString.append("&\(param.key.rawValue)=\(param.value)")
        }
        return URL(string: urlString)!
    }

    private static func url(_ search: Search) -> URL {
        var params: [Param] = []
        if let title = search.title?.replacingOccurrences(of: " ", with: "") {
            params.append((.search, title))
        }
        if let year = search.year {
            params.append((.year, year))
        }
        if let type = search.type {
            params.append((.type, type.rawValue))
        }
        return url(params)
    }

    static func performSearch(_ search: Search, completion: @escaping ([OMDbItem]?, Error?) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        URLSession.shared.dataTask(with: url(search)) { (data, _, error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            guard let data = data else { completion(nil, error ?? APIError.noData); return }
            do {
                let search = try JSONDecoder().decode(OMDbSearch.self, from: data)
                completion(search.search, error)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }

}
