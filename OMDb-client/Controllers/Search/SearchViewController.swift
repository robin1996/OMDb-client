//
//  SearchViewController.swift
//  OMDb-client
//
//  Created by Robin Douglas on 15/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {

    // MARK: - Members

    weak var delegate: SearchDelegate?
    var typePicker = UIPickerView()

    // MARK: Outlet

    @IBOutlet var searchButton: UIButton!
    @IBOutlet var titleField: UITextField!
    @IBOutlet var yearField: UITextField!
    @IBOutlet var typeField: UITextField!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTypePicker()
        setupSearchButton()
    }

    // MARK: - Actions

    @IBAction func searchButtonPress(_ sender: Any) {
        let search = getSearch()
        saveSearch(search)
        delegate?.search(for: search)
    }

    // MARK: - Helper

    func getSearch() -> Search {
        var search = Search()
        if titleField.text != "" { search.title = titleField.text }
        if yearField.text  != "" { search.year = yearField.text }
        if let type = typeField.text, type != "" { search.type = Search.SearchType(rawValue: type) }
        return search
    }

    func setupSearchButton() {
        searchButton.layer.cornerRadius = 25
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = searchButton.tintColor.cgColor
    }

    func saveSearch(_ search: Search) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let searchEntity = NSEntityDescription.entity(forEntityName: "PastSearch", in: context)!
        let newSearch = NSManagedObject(entity: searchEntity, insertInto: context)
        newSearch.setValue(search.title, forKeyPath: "title")
        newSearch.setValue(search.year, forKeyPath: "year")
        newSearch.setValue(search.type?.rawValue, forKeyPath: "type")
        try? context.save()
    }

}

// MARK: - Navigation
extension SearchViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.showHistory {
            (segue.destination as! HistoryTableViewController).delegate = delegate
        }
    }

}

// Search type picker
extension SearchViewController {

    private func setupTypePicker() {
        typePicker.dataSource = self
        typePicker.delegate = self
        typeField.inputView = typePicker
        typeField.addTarget(self, action: #selector(setType), for: .editingDidEnd)
    }

    @objc private func setType() {
        let type = Search.SearchType.allCases[typePicker.selectedRow(inComponent: 0)]
        let text = type == .any ? "" : type.rawValue
        typeField.text = text
    }

}

extension SearchViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Search.SearchType.allCases.count
    }

}

extension SearchViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Search.SearchType.allCases[row].rawValue
    }

}
