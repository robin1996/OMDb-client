//
//  MovieListTableViewController.swift
//  OMDb-client
//
//  Created by Robin Douglas on 15/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {

    var items: [OMDbItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
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
        return cell
    }

}
