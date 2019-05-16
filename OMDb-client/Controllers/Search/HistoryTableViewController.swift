//
//  HistoryTableViewController.swift
//  OMDb-client
//
//  Created by Robin Douglas on 16/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import UIKit
import CoreData

class HistoryTableViewController: UITableViewController {

    var pastSearches: [Search] = []
    weak var delegate: SearchDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let searches = getPastSearches() {
            pastSearches = searches
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pastSearches.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIDs.searchHistoryCell, for: indexPath)
        let search = pastSearches[indexPath.row]
        for property in [search.title, search.year, search.type?.rawValue] {
            if let property = property {
                cell.textLabel?.text?.append("\(property) ")
            }
        }
        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let search = pastSearches[indexPath.row]
        delegate?.search(for: search)
    }

    // MARK: - Helper

    func getSearch(from object: NSManagedObject) -> Search {
        var search = Search()
        search.title = object.value(forKey: "title") as? String
        search.year = object.value(forKey: "year") as? String
        if let type = object.value(forKey: "type") as? String {
            search.type = Search.SearchType(rawValue: type)
        }
        return search
    }

    func getPastSearches() -> [Search]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PastSearch")
        guard let data = try? context.fetch(fetchRequest) else { return nil }
        return data.map({ (object) -> Search in
            getSearch(from: object)
        })
    }

}
