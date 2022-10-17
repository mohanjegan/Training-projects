//
//  ViewController.swift
//  Http-Methods
//
//  Created by Mohan on 13/10/22.
//

import UIKit


class UsersViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var userList: UserList?
    var userListViewModel = [UserViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()
//        postFunc()
//        {
//            self.tableView.reloadData()
//        }

    }
    
    func setUpTableView(){
        tableView.register(UINib(nibName: "UsersInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersInfoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.postFunc()
    }
    //func postFunc(completed: @escaping () -> ())
    func postFunc (){
        let urlString = "https://6347b393db76843976b03c63.mockapi.io/api/registrations"
        guard let postUrl = URL(string: urlString) else{return}
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.setValue("application/JSON", forHTTPHeaderField: "Contenet-Type")
        request.setValue("httpBody", forHTTPHeaderField: "post")
        
        let user1 = UserInfo(createdAt: "\(Date())", name: "Dennis", avatar: "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1013.jpg", id: "10")
        let user2 = UserInfo(createdAt: "\(Date())", name: "Richard", avatar: "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1017.jpg", id: "11")
        do{
            let jsonItem = try JSONEncoder().encode([user1, user2])
            request.httpBody = jsonItem
        }catch{
            print("it's not json")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil{
                //print data
                let str = String(data: data!, encoding: .utf8)
                self.printLogs(message: str!)
                //print(str!)
                //completion
                do{
                    self.userListViewModel = try JSONDecoder().decode([UserViewModel].self, from: data!)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                       // completed()
                    }
                    
                }
                catch{
                    print("json error")
                }
            }
        }.resume()
    }
    
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userListViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersInfoTableViewCell") as! UsersInfoTableViewCell
        cell.userViewModel = self.userListViewModel[indexPath.row]
//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        cell.textLabel?.text = users[indexPath.row].name.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "showdetails", sender: self)
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? UsersViewController{
//            destination.user = users[(tableView.indexPathForSelectedRow?.row)!]
//        }
//    }
    
}

//singleton print
extension UIViewController {
    func printLogs(message: Any) {
        //print(message)
    }
}
//download image foe imageview
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
