//
//  ViewController.swift
//  Tabbar
//
//  Created by Mohan on 10/10/22.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    
    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 52))
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.center = view.center
    }
    
    @objc func didTapButton(){
        //create and present tabbar controller
        let tabBarVc = UITabBarController()
        let vc1 = UINavigationController(rootViewController: FirstViewController())
        let vc2 = UINavigationController(rootViewController: SecondViewController())
        let vc3 = UINavigationController(rootViewController: ThirdViewController())
        let vc4 = UINavigationController(rootViewController: FourthViewController())
        
        vc1.title = "Apple"
        vc2.title = "Google"
        vc3.title = "Microsoft"
        vc4.title = "Amazon"
        
        tabBarVc.setViewControllers([vc1, vc2, vc3, vc4], animated: false)
        guard  let items = tabBarVc.tabBar.items else {
            return
        }
        let images = ["applelogo", "g.circle.fill", "m.circle.fill", "a.circle.fill"]
        for x in 0..<items.count{
            items[x].image = UIImage(systemName: images[x])
        }
        
        tabBarVc.modalPresentationStyle = .fullScreen
        present(tabBarVc, animated: true)
    }
}
class FirstViewController: UIViewController, WKNavigationDelegate{
    var webView: WKWebView!
    let url = URL(string: "https://www.apple.com/")!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Apple"
        //guard let url = URL(string: "https://www.apple.com/") else {return}
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        configureButtons()
    }
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    private func configureButtons(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefresh))
    }
    @objc func didTapDone(){
        dismiss(animated: true, completion: nil)
    }
    @objc func didTapRefresh(){
        webView.load(URLRequest(url: url))
    }
}
class SecondViewController: UIViewController, WKNavigationDelegate{
    var webView: WKWebView!
    let url = URL(string: "https://www.google.com/")!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Google"
        //guard let url = URL(string: "https://www.google.com/") else {return}
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        configureButtons()
    }
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    private func configureButtons(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefresh))
    }
    @objc func didTapDone(){
        dismiss(animated: true, completion: nil)
    }
    @objc func didTapRefresh(){
        webView.load(URLRequest(url: url))
    }
}
class ThirdViewController: UIViewController, WKNavigationDelegate{
    var webView: WKWebView!
    let url = URL(string: "https://www.microsoft.com/")!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Microsoft"
        //guard let url = URL(string: "https://www.microsoft.com/") else {return}
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        configureButtons()
    }
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    private func configureButtons(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefresh))
    }
    @objc func didTapDone(){
        dismiss(animated: true, completion: nil)
    }
    @objc func didTapRefresh(){
        webView.load(URLRequest(url: url))
    }
}
class FourthViewController: UIViewController, WKNavigationDelegate
{
    var webView: WKWebView!
    let url = URL(string: "https://www.amazon.com/")!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Amazon"
        //guard let url = URL(string: "https://www.amazon.com/") else {return}
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        configureButtons()
    }
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    private func configureButtons(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefresh))
    }
    @objc func didTapDone(){
        dismiss(animated: true, completion: nil)
    }
    @objc func didTapRefresh(){
        webView.load(URLRequest(url: url))
    }
}



