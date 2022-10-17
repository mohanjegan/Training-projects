//
//  UsersInfoTableViewCell.swift
//  Http-Methods
//
//  Created by Mohan on 14/10/22.
//

import UIKit

class UsersInfoTableViewCell: UITableViewCell {

    //@IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    static let cellIdentifier = "UsersInfoTableViewCell"
    var userViewModel: UserViewModel! {
        didSet{
            self.nameLbl.text = userViewModel.name
            self.idLbl.text = userViewModel.id
            self.dateLbl.text = userViewModel.createdAt
//            let urlString = userViewModel.avatar ?? ""
//            let url = URL(string: urlString)
//            
//            imageView.downloaded(from: url!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
