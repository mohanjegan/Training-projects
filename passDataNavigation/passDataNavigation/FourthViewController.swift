//
//  FourthViewController.swift
//  passDataNavigation
//
//  Created by Mohan on 29/10/22.
//

import UIKit

class FourthViewController: UIViewController {
    
    @IBOutlet weak var txtFld: UITextField!
    
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name = txtFld.text ?? "nil"
    }
    
//    func getname() -> String {
//        name = txtFld.text ?? "nil"
//        return name
//    }
    @IBAction func didTapBack(_ sender: Any) {
//        dismiss(animated: true, completion:nil)
        
//        if let vc = presentingViewController as? ThirdViewController{
//            dismiss(animated: true, completion: {
//                vc.setname(self.txtFld.text ?? "no name")
//            })
//        }
        
        let vc = ThirdViewController()
        dismiss(animated: true, completion: {
            vc.setname(self.txtFld.text ?? "no name")
        })
    }

}
