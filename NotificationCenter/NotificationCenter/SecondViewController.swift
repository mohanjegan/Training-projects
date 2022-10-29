//
//  SecondViewController.swift
//  NotificationCenter
//
//  Created by Mohan on 29/10/22.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var dateLbl: UILabel!
    var observer: NSObjectProtocol?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        observer = NotificationCenter.default.addObserver(forName: .saveDate, object: nil, queue: OperationQueue.main) { (notification) in
            let dateVc = notification.object as? DatePopUpViewController
            self.dateLbl.text = dateVc?.formattedDate
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let observer = observer{
            NotificationCenter.default.removeObserver(observer)
        }
    }

}
