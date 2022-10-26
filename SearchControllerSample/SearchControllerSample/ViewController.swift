//
//  ViewController.swift
//  SearchControllerSample
//
//  Created by Mohan on 26/10/22.
//

import UIKit
class ResultVc: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let tableView = UITableView()
    
    var data = ["James", "Prashanth", "Karthick", "Selva", "Ashwin", "Ranjith", "Manoj", "Gopal", "Chandeep", "Arnesh"]
    var searchData = [String]()
    var searching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchData.count
        }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if searching{
            cell.textLabel?.text = searchData[indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.row]
        }
        return cell
    }
}

class ViewController: UIViewController, UISearchResultsUpdating {
    

    let searchController = UISearchController(searchResultsController: ResultVc())
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text,
              !searchText.trimmingCharacters(in: .whitespaces).isEmpty,
              let Vc = searchController.searchResultsController as? ResultVc
        else{
            return
        }
        Vc.searchData = Vc.data.filter({$0.prefix(searchText.count) == searchText})
        Vc.searching = true
        Vc.tableView.reloadData()
    }
}

