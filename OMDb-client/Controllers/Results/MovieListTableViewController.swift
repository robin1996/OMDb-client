//
//  MovieListTableViewController.swift
//  OMDb-client
//
//  Created by Robin Douglas on 15/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {

    var items: [OMDbItem] = [] {
        didSet {
            posterRecords = items.map({ (item) -> PosterRecord? in
                if let address = item.poster {
                    let record = PosterCache.getRecord(for: address)
                    return record
                }
                return nil
            })
        }
    }
    var posterRecords: [PosterRecord?] = []
    var operations = PendingOperations()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(UINib(nibName: XIBNames.movieCell, bundle: nil), forCellReuseIdentifier: ReuseIDs.movieCell)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIDs.movieCell) as! MovieCell
        cell.setupDescriptionFrom(items[indexPath.row])
        cell.setupPosterFrom(posterRecords[indexPath.row]?.image)
        getPoster(for: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 251.5
    }

}

// MARK: - Poster operations
extension MovieListTableViewController {

    func getPoster(for indexPath: IndexPath) {
        guard operations.downloadsInProgress[indexPath] == nil else { return }
        guard let record = posterRecords[indexPath.row] else { return }
        guard record.downloadState == .start else { return }

        let operation = PosterDownloadOperation(record)
        operation.completionBlock = { [weak self] in
            DispatchQueue.main.async {
                if operation.isCancelled { return }
                self?.operations.downloadsInProgress.removeValue(forKey: indexPath)
                self?.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        operations.downloadsInProgress[indexPath] = operation
        operations.downloadQueue.addOperation(operation)
    }

}

// MARK: - Prefetching posters
extension MovieListTableViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for path in indexPaths {
            getPoster(for: path)
        }
    }

}

extension MovieListTableViewController: SearchDelegate {

    func search(for searchString: String) {
        APIService.performSearch(searchString) { [weak self] (items, _) in
            if let items = items {
                self?.items = items
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }

}
