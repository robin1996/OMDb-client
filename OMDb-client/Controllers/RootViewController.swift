//
//  ViewController.swift
//  OMDb-client
//
//  Created by Robin Douglas on 15/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import UIKit

protocol SearchDelegate: AnyObject {
    func search(for searchString: Search)
}

class RootViewController: UIViewController {

    enum Mode {
        case results
        case search
    }

    // MARK: - Members

    var mode: Mode = .results
    weak var resultsNavigationController: ResultsNavigationController?
    weak var searchViewController: UIViewController?
    weak var searchDelegate: SearchDelegate?

    // MARK: Outlets

    @IBOutlet var contentView: UIView!
    @IBOutlet var appModeButton: MainAppButton!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupResults()
        setupSearch()
        setMode(to: .results)
    }

    // MARK: - Actions

    @IBAction func appModeButtonPress(_ sender: Any) {
        toggleMode()
    }

    // MARK: - Helper

    func setupResults() {
        let vc = MovieListTableViewController()
        let nc = ResultsNavigationController(rootViewController: vc)
        addChild(nc)
        nc.didMove(toParent: self)
        resultsNavigationController = nc
        searchDelegate = vc
    }

    func setupSearch() {
        guard let vc = UIStoryboard(name: Storyboards.search, bundle: nil)
            .instantiateInitialViewController() as? SearchViewController else {
                fatalError()
        }
        addChild(vc)
        vc.didMove(toParent: self)
        vc.delegate = self
        searchViewController = vc
    }

    func setMode(to mode: Mode) {
        var oldView: UIView?
        var newView: UIView?
        switch mode {
        case .results:
            setMainAppButton(to: .searchButton)
            oldView = searchViewController?.view
            newView = resultsNavigationController?.view
            self.mode = .results
        case .search:
            setMainAppButton(to: .exitButton)
            oldView = resultsNavigationController?.view
            newView = searchViewController?.view
            self.mode = .search
        }
        UIView.transition(with: contentView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            if let oldView = oldView { oldView.removeFromSuperview() }
            if let newView = newView { self.addViewToContentsView(view: newView) }
        }, completion: nil)
    }

    func toggleMode() {
        switch mode {
        case .results:
            setMode(to: .search)
        case .search:
            setMode(to: .results)
        }
    }

    func setMainAppButton(to mode: MainAppButton.Mode) {
        UIView.transition(with: appModeButton, duration: 0.3, options: .transitionFlipFromTop, animations: {
            self.appModeButton.mode = mode
        }, completion: nil)
    }

    func addViewToContentsView(view: UIView) {
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

}

extension RootViewController: SearchDelegate {

    func search(for search: Search) {
        searchDelegate?.search(for: search)
        setMode(to: .results)
    }

}
