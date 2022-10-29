//
//  ThirdViewController.swift
//  passDataNavigation
//
//  Created by Mohan on 28/10/22.
//

import UIKit

protocol ThirdDelegate: class {
    func textRetrived(text: String?)
}

class ThirdViewController: UIViewController {
    weak var delegate: ThirdDelegate?
    @IBOutlet weak var txtFld: UITextField!
    @IBOutlet weak var shwLbl: UILabel!
    @IBOutlet weak var rtnLbl: UILabel!
    var str1: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shwLbl.text = str1
        title = "ThirdView"
    }
    @IBAction func didTapNext(_ sender: Any) {
        let story: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "FourthViewController")as! FourthViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        delegate?.textRetrived(text: txtFld?.text)
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    func setname(_ name: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.rtnLbl.text = name
            }
        
    }
    
}

