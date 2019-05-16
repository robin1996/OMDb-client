//
//  ResultsNavigationController.swift
//  OMDb-client
//
//  Created by Robin Douglas on 15/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import UIKit

class SearchNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generalSetup()
    }

    private func generalSetup() {
        interactivePopGestureRecognizer?.delegate = nil
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = #imageLiteral(resourceName: "nav_bar_shadow")
        navigationBar.prefersLargeTitles = true
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        guard viewController != viewControllers[0] else { return }
        let backButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "Image"),
            style: .done,
            target: self,
            action: #selector(popViewController(animated:))
        )
        viewController.navigationItem.leftBarButtonItem = backButtonItem
    }

}
