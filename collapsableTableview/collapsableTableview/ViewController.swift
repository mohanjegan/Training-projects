//
//  ViewController.swift
//  collapsableTableview
//
//  Created by Mohan on 02/11/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblView: UITableView!
    
    let imgArray = ["beach", "mountains", "sun-flower", "sunset"]
    let nameArray = ["Beach", "Mountains", "Sunflower", "Sunset"]
    var selectedIndex = -1
    var isCollapsable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        tblView.estimatedRowHeight = 197
        tblView.rowHeight = UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndex == indexPath.row && isCollapsable == true{
            return 197
        } else {
            return 50
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell") as! ImageTableViewCell
        cell.nameLbl.text = nameArray[indexPath.row]
        cell.imgView.image = UIImage(named: "\(imgArray[indexPath.row])")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedIndex == indexPath.row{
            isCollapsable = isCollapsable ? false : true
//            if isCollapsable == false{
//                isCollapsable = true
//            } else {
//                isCollapsable = false
//            }
        } else {
            isCollapsable = true
        }
        selectedIndex = indexPath.row
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

