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
        tableView.rowHeight = 100
        userListViewModel.postFunc { response in
            DispatchQueue.main.async {
            if response{
                    self.tableView.reloadData()
            }
            else{
                self.showAlert()
            }
            }
        }
    }
    public func showAlert(){
        let alertController = UIAlertController(title:"Alert", message: "No Network Available", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
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


