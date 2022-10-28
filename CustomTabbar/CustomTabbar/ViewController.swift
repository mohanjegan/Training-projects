//
//  ViewController.swift
//  CustomTabbar
//
//  Created by Mohan on 28/10/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewforTab: UIView!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var homeShadow: UIView!
    @IBOutlet weak var searchShadow: UIView!
    @IBOutlet weak var cameraShadow: UIView!
    @IBOutlet weak var profileShadow: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        designableTabBar()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ (timer) in
            DispatchQueue.main.async {
                self.forHome()
            }
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func forHome(){
        guard let Home = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else { return }
        parentView.addSubview(Home.view)
        Home.didMove(toParent: self)
        homeShadow.backgroundColor = .systemYellow
        searchShadow.backgroundColor = .clear
        cameraShadow.backgroundColor = .clear
        profileShadow.backgroundColor = .clear
    }
    func designableTabBar(){
        viewforTab.layer.cornerRadius = viewforTab.frame.size.height / 2
        viewforTab.clipsToBounds = true
        homeShadow.layer.cornerRadius = homeShadow.frame.size.height / 2
        searchShadow.layer.cornerRadius = searchShadow.frame.size.height / 2
        cameraShadow.layer.cornerRadius = cameraShadow.frame.size.height / 2
        profileShadow.layer.cornerRadius = profileShadow.frame.size.height / 2
    }

    @IBAction func onClickTabbar(_ sender: UIButton) {
        let tag = sender.tag
        if tag == 1{
            forHome()
        } else if tag == 2 {
            guard let Search = self.storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController else { return }
            parentView.addSubview(Search.view)
            Search.didMove(toParent: self)
            homeShadow.backgroundColor = .clear
            searchShadow.backgroundColor = .systemYellow
            cameraShadow.backgroundColor = .clear
            profileShadow.backgroundColor = .clear
        } else if tag == 3 {
            guard let Camera = self.storyboard?.instantiateViewController(identifier: "CameraViewController") as? CameraViewController else { return }
            parentView.addSubview(Camera.view)
            Camera.didMove(toParent: self)
            homeShadow.backgroundColor = .clear
            searchShadow.backgroundColor = .clear
            cameraShadow.backgroundColor = .systemYellow
            profileShadow.backgroundColor = .clear
        } else {
            guard let Profile = self.storyboard?.instantiateViewController(identifier: "ProfileViewController") as? ProfileViewController else { return }
            parentView.addSubview(Profile.view)
            Profile.didMove(toParent: self)
            homeShadow.backgroundColor = .clear
            searchShadow.backgroundColor = .clear
            cameraShadow.backgroundColor = .clear
            profileShadow.backgroundColor = .systemYellow
        }
    }
}

