//
//  ViewController.swift
//  TimerSample
//
//  Created by Mohan on 26/10/22.
//

import UIKit

class ViewController: UIViewController {
    let colors: [UIColor] = [
        .systemRed,
        .systemPink,
        .systemTeal,
        .systemGray,
        .systemGreen,
        .systemYellow]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createTimer()
    }
    //without repeat & selector
    
//    func createTimer(){
//        let timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
//        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute:{
//            timer.fire()
//        })
//    }
//    @objc func fireTimer(){
//        view.backgroundColor = .systemGreen
//    }
    
    //with repeat & selector
//    func createTimer(){
//        let timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
//        //amount of time after scheduled fire date that timer may fire
//        timer.tolerance = 200
//    }
//    @objc func fireTimer(){
//        view.backgroundColor = colors.randomElement()
//    }
    
    //with repeat & code block
//    func createTimer(){
//        var ran = 1
//        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
//            print("Executed Timer: \(ran)")
//            if ran >= 10{
//                timer.invalidate()
//                print("Timer Stopped.")
//            }
//            DispatchQueue.main.async {
//                self?.view.backgroundColor = self?.colors.randomElement() ?? .clear
//                ran += 1
//
//            }
//        }
//    }
    //animate a view with on timer
    func createTimer(){
        var isAnimated = false
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.addSubview(myView)
        myView.center = view.center
        myView.backgroundColor = .link
        
        let timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [weak self] timer in
            guard let strongSelf = self else{
                return
            }
            DispatchQueue.main.async {
                self?.view.backgroundColor = self?.colors.randomElement() ?? .clear
                if isAnimated{
                    UIView.animate(withDuration: 1) {
                        myView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
                        myView.center = strongSelf.view.center
                    }
                    isAnimated = false
                } else {
                    UIView.animate(withDuration: 1) {
                        myView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
                        myView.center = strongSelf.view.center
                    }
                 isAnimated = true
                }
            }
        }
        timer.fire()
    }
}

