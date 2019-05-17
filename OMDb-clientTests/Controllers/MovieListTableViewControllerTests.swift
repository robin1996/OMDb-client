//
//  MovieListTableViewControllerTests.swift
//  OMDb-clientTests
//
//  Created by Robin Douglas on 17/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import XCTest
@testable import OMDb_client

class MovieListTableViewControllerTests: XCTestCase {

    var vc: MovieListTableViewController!

    override func setUp() {
        vc = MovieListTableViewController()
        _ = vc.view
    }

    func testThatNumberOfSectionsIsOne() {
        XCTAssert(vc.tableView.numberOfSections == 1)
    }

    func testThatItemsAndRowCountsAreEqual() {
        XCTAssert(vc.items.count == vc?.tableView.numberOfRows(inSection: 0))
    }

    func testThatItemsAndRowCountsAreEqualAfterSearch() {
        vc.items.append(OMDbItem(id: "0", title: nil, year: nil, poster: nil, plot: nil))
        XCTAssert(vc.items.count == vc?.tableView.numberOfRows(inSection: 0))
    }

}
