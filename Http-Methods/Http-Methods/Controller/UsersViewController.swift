//
//  ViewController.swift
//  Http-Methods
//
//  Created by Mohan on 13/10/22.
//

import UIKit


class UsersViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var userListViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()
    }
    
    func setUpTableView(){
        tableView.register(UINib(nibName: "UsersInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersInfoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        userListViewModel.postFunc {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}


extension UsersViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListViewModel.usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersInfoTableViewCell") as! UsersInfoTableViewCell
        cell.userDetails = userListViewModel.usersList[indexPath.row]
        return cell
    }
}

//singleton print
extension UIViewController {
    func printLogs(message: Any) {
        //print(message)
    }
}


