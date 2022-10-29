//
//  ViewController.swift
//  passDataNavigation
//
//  Created by Mohan on 19/10/22.
//

import UIKit

class ViewController: UIViewController, SecondDelegate {


    @IBOutlet weak var txtFld: UITextField!
    @IBOutlet weak var shwLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FirstView"
    }

    @IBAction func didTapNext(_ sender: Any) {
        let story: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let new = story.instantiateViewController(withIdentifier: "SecondViewController")as! SecondViewController
        new.str1 = txtFld.text ?? "nil"
        new.delegate = self
        self.navigationController?.pushViewController(new, animated: true)
        //new.modalPresentationStyle = .fullScreen
        //self.present(new, animated: true)
    }
    func textRetrived(text: String?) {
        shwLbl.text = text
    }
    
    
}

class Person {
    
    //creates the instance and guarantees that it's unique
    static let instance = Person()
    
    private init() {
    }
    
    //creates the global variable
    var name = "Mohan"
}

