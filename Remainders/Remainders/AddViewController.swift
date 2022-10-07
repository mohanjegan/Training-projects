//
//  AddViewController.swift
//  Remainders
//
//  Created by Mohan on 07/10/22.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var bodyField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!

    public var completion: ((String, String, Date) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        bodyField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(didTapSave))
    }
    @objc func didTapSave(){
        if let titleText = titleField.text, !titleText.isEmpty,
           let bodyText = bodyField.text, !bodyText.isEmpty {
            let targetDate = datePicker.date
            datePicker.minimumDate = Date()
            
            completion?(titleText, bodyText, targetDate)
        }

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
