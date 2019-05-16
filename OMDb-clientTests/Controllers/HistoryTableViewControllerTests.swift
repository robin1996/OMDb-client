//
//  HistoryTableViewControllerTests.swift
//  OMDb-clientTests
//
//  Created by Robin Douglas on 17/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import XCTest
@testable import OMDb_client

class HistoryTableViewControllerTests: XCTestCase {

    var vc: HistoryTableViewController!

    override func setUp() {
        vc = HistoryTableViewController()
        _ = vc.view
        vc.viewWillAppear(false)
    }

    func testThatNumberOfSectionsIsOne() {
        XCTAssert(vc.tableView.numberOfSections == 1)
    }

    func testThatPastSearchesAndRowCountsAreEqual() {
        XCTAssert(vc.pastSearches.count == vc?.tableView.numberOfRows(inSection: 0))
    }

    func testThatPastSearchesNotNil() {
        XCTAssert(vc.getPastSearches() != nil)
    }

}
