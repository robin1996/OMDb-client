//
//  UIAlertController+ErrorAlert.swift
//  OMDb-client
//
//  Created by Robin Douglas on 16/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import UIKit

extension UIAlertController {

    convenience init(error: Error, message: String? = nil, dismissCompletion: (() -> Void)? = nil) {
        let message = message == nil ?
            error.localizedDescription :
        "\(message!) \(error.localizedDescription)"
        self.init(title: "An error occured!", message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .destructive) { (_) in
            guard let completion = dismissCompletion else { return }
            completion()
        }
        addAction(dismissAction)
    }

}
