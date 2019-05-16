//
//  Search.swift
//  OMDb-client
//
//  Created by Robin Douglas on 16/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import Foundation

struct Search {
    enum SearchType: String, CaseIterable {
        case movie, series, episode, any
    }

    var title: String?
    var year: String?
    var type: SearchType?
}
