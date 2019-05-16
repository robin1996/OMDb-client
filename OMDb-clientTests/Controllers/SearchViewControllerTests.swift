//
//  SearchViewControllerTests.swift
//  OMDb-clientTests
//
//  Created by Robin Douglas on 17/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import XCTest
import CoreData
@testable import OMDb_client

class SearchViewControllerTests: XCTestCase {

    var vc: SearchViewController?

    override func setUp() {
        vc = UIStoryboard(name: Storyboards.search, bundle: nil)
            .instantiateInitialViewController() as? SearchViewController
        _ = vc?.view
        vc?.titleField.text = "test"
        vc?.yearField.text = "2000"
        vc?.typeField.text = Search.SearchType.movie.rawValue
    }

    func testInitiated() {
        XCTAssert(vc != nil)
    }

    func testSearchCreation() {
        let search = vc?.getSearch()
        XCTAssert(search?.title == "test")
        XCTAssert(search?.year == "2000")
        XCTAssert(search?.type == Search.SearchType.movie)
    }

    func testSearchSaved() {
        vc?.searchButtonPress(self)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        XCTAssert(appDelegate != nil)
        let context = appDelegate?.persistentContainer.viewContext
        XCTAssert(context != nil)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PastSearch")
        let data = try? context?.fetch(fetchRequest)
        let search = data?.last
        XCTAssert((search?.value(forKey: "title") as? String) == "test")
        XCTAssert((search?.value(forKey: "year") as? String) == "2000")
        XCTAssert((search?.value(forKey: "type") as? String) == Search.SearchType.movie.rawValue)
    }

}
