//
//  ViewController.swift
//  OMDb-client
//
//  Created by Robin Douglas on 15/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    // MARK: - Members

    // MARK: Outlets

    @IBOutlet var contentView: UIView!
    @IBOutlet var appModeButton: MainAppButton!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupResults()
    }

    // MARK: - Actions

    @IBAction func appModeButtonPress(_ sender: Any) {
        UIView.transition(with: appModeButton, duration: 0.3, options: .transitionFlipFromTop, animations: {
            self.appModeButton.toggle()
        }, completion: nil)
    }

    // MARK: - Helper

    func setupResults() {
        let vc = MovieListTableViewController()
        let nc = ResultsNavigationController(rootViewController: vc)
        addChild(nc)
        nc.didMove(toParent: self)

        contentView.addSubview(nc.view)
        nc.view.translatesAutoresizingMaskIntoConstraints = false
        nc.view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nc.view.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        nc.view.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        nc.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

}
