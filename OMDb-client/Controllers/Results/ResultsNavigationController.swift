//
//  ResultsNavigationController.swift
//  OMDb-client
//
//  Created by Robin Douglas on 15/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import UIKit

class ResultsNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generalSetup()
    }

    private func generalSetup() {
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = #imageLiteral(resourceName: "nav_bar_shadow")
    }

}
