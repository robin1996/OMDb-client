//
//  MainAppButton.swift
//  OMDb-client
//
//  Created by Robin Douglas on 15/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import UIKit

class MainAppButton: UIButton {

    enum Mode {
        case exitButton
        case searchButton
    }

    // MARK: - Members

    var mode: Mode = .exitButton {
        didSet {
            switch mode {
            case .exitButton:
                setImage(#imageLiteral(resourceName: "close_icon"), for: .normal)
            case .searchButton:
                setImage(#imageLiteral(resourceName: "search_icon"), for: .normal)
            }
        }
    }

    // MARK: - Life cycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        generalSetup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        generalSetup()
    }

    private func generalSetup() {
        setTitle(nil, for: .normal)
        layer.cornerRadius = 30
        layer.borderWidth = 1
        layer.borderColor = tintColor.cgColor
        backgroundColor = .white
        mode = .searchButton
    }

    // MARK: - Helpers

    func toggle() {
        switch mode {
        case .exitButton:
            mode = .searchButton
        case .searchButton:
            mode = .exitButton
        }
    }

}
