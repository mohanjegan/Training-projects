//
//  DatePopUpViewController.swift
//  NotificationCenter
//
//  Created by Mohan on 29/10/22.
//

import UIKit

class DatePopUpViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleLbl: UILabel!
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: datePicker.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveDate(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: .saveDate, object: self)
        
        dismiss(animated: true)
    }
}
