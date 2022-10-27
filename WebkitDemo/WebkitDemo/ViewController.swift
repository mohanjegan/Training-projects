//
//  ViewController.swift
//  WebkitDemo
//
//  Created by Mohan on 27/10/22.
//

import UIKit
import WebKit
class ViewController: UIViewController, UITextFieldDelegate, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var urlField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString: String = "https://www.apple.com"
        let url: URL = URL(string: urlString)!
        let urlRequest:URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
        urlField.text = urlString
        urlField.delegate = self
        webView.navigationDelegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString: String = urlField.text!
        let url: URL = URL(string: urlString)!
        let urlRequest: URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        if webView.canGoBack{
            webView.goBack()
        }
    }
    
    @IBAction func forwardBtnTapped(_ sender: Any) {
        if webView.canGoForward{
            webView.goForward()
        }
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        urlField.text = webView.url?.absoluteString
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backBtn.isEnabled = webView.canGoBack
        forwardBtn.isEnabled = webView.canGoForward
    }
    
}

