//
//  WelcomeViewController.swift
//  Login-CoreData
//
//  Created by Mohan on 20/09/22.
//

import UIKit

class WelcomeViewController: UIViewController {
 
    var name: String = ""
    @IBOutlet weak var txtLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtLbl.text = "Welcome \(name)!"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSignoutClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
