////
////  UsersViewController.swift
////  Http-Methods
////
////  Created by Mohan on 13/10/22.
////
//
//import UIKit
//
//class UserViewController: UIViewController {
//    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var nameLbl: UILabel!
//    @IBOutlet weak var createdAtLbl: UILabel!
//    @IBOutlet weak var idLbl: UILabel!
//    var user: User?
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        nameLbl.text = user?.name
//        createdAtLbl.text = "\((user?.createdAt)!)"
//        idLbl.text = "\((user?.id)!)"
//        
//        let urlString = "\((user?.avatar)!)"
//        let url = URL(string: urlString)
//        
//        imageView.downloaded(from: url!)
//    }
//}
//extension UIImageView {
//    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
//        contentMode = mode
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//            else { return }
//            DispatchQueue.main.async() { [weak self] in
//                self?.image = image
//            }
//        }.resume()
//    }
//    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
//        guard let url = URL(string: link) else { return }
//        downloaded(from: url, contentMode: mode)
//    }
//}
