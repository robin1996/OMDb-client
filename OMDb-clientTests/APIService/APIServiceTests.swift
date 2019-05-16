//
//  APIServiceTests.swift
//  OMDb-clientTests
//
//  Created by Robin Douglas on 16/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import XCTest
@testable import OMDb_client

class APIServiceTests: XCTestCase {

    func testSearchErrors() {
        let testSearch = Search(title: "test", year: "2000", type: .series)
        APIService.performSearch(testSearch) { (_, error) in
            XCTAssert(error == nil)
        }
    }

}
