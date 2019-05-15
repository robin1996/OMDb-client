//
//  SearchViewController.swift
//  OMDb-client
//
//  Created by Robin Douglas on 15/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Members

    weak var delegate: SearchDelegate?

    // MARK: Outlet

    @IBOutlet var searchButton: UIButton!
    @IBOutlet var titleField: UITextField!

    // MARK: - Actions

    @IBAction func searchButtonPress(_ sender: Any) {
        delegate?.search(for: titleField.text ?? "")
    }

}
