//
//  UsersInfoTableViewCell.swift
//  Http-Methods
//
//  Created by Mohan on 14/10/22.
//

import UIKit

class UsersInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    static let cellIdentifier = "UsersInfoTableViewCell"
    var userDetails: UserInfo! {
        didSet{
            self.nameLbl.text = userDetails.name
            self.idLbl.text = "ID: \(userDetails.id ?? "")"
            let formatterget = DateFormatter()
            formatterget.dateFormat = "yyyy-mm-ddTHH:mm:ss"
            let formatterSet = DateFormatter()
            formatterSet.dateFormat = "MMM-dd-yyyy HH:mm:ss"
            if let getDate = formatterget.date(from: userDetails.createdAt!){
                self.dateLbl.text = formatterSet.string(from: getDate)
            } else {
                self.dateLbl.text = "NA"
            }
            //print(userDetails.createdAt!)
            let urlString = "\((userDetails?.avatar)!)"
            let url = URL(string: urlString)
            userImageView.downloaded(from: url!)
        }
    }
}

