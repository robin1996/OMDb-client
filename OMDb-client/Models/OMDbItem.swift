//
//  OMDbItem.swift
//  OMDb-client
//
//  Created by Robin Douglas on 15/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import Foundation

struct OMDbItem: Codable {
    let title: String
    let year: String
    let poster: String
    let plot: String

    enum CodingKeys: String, CodingKey {
        case title  = "Title"
        case year   = "Year"
        case poster = "Poster"
        case plot   = "Plot"
    }
}
