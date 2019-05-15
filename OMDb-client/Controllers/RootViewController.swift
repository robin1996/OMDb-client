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
        // Do any additional setup after loading the view.
    }

    // MARK: - Actions

    @IBAction func appModeButtonPress(_ sender: Any) {
        UIView.transition(with: appModeButton, duration: 0.3, options: .transitionFlipFromTop, animations: {
            self.appModeButton.toggle()
        }, completion: nil)
    }

}
