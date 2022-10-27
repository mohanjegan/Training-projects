//
//  ViewController.swift
//  SafariViewSample
//
//  Created by Mohan on 27/10/22.
//

import UIKit
import SafariServices
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func btnTapped(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "https://www.apple.com")!)
        present(vc, animated: true)
    }
}

