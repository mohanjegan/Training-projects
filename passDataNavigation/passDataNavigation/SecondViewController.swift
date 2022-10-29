//
//  SecondViewController.swift
//  passDataNavigation
//
//  Created by Mohan on 19/10/22.
//

import UIKit

protocol SecondDelegate: class {
    func textRetrived(text: String?)
}

class SecondViewController: UIViewController, ThirdDelegate {
  
    @IBOutlet weak var txtFld: UITextField!
    @IBOutlet weak var shwLbl: UILabel!
    @IBOutlet weak var rtnLbl: UILabel!
    weak var delegate: SecondDelegate?
    var str1: String = ""
    var name1: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SecondView"
        name1 = Person.instance.name
        print(name1)
        Person.instance.name = "Pradeep"
        name1 = Person.instance.name
        print(name1)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        shwLbl.text = str1
    }

    @IBAction func didTapNext(_ sender: Any) {
        let story: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let new = story.instantiateViewController(withIdentifier: "ThirdViewController")as! ThirdViewController
        new.str1 = txtFld.text ?? "nil"
        new.delegate = self
        self.navigationController?.pushViewController(new, animated: true)
       
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        delegate?.textRetrived(text: txtFld.text)
        self.navigationController?.popViewController(animated: true)
    }
    
    func textRetrived(text: String?) {
        rtnLbl.text = text ?? ""
    }
}
