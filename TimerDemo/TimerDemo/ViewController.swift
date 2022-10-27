//
//  ViewController.swift
//  TimerDemo
//
//  Created by Mohan on 27/10/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    var second = 0
    var timer = Timer()
    var isTimerRunning = false
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLbl.backgroundColor = .systemGray
        pauseButton.isEnabled = false
        resetButton.isEnabled = false
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isTimerRunning == false {
            isTimerRunning = true
            timerLbl.backgroundColor = .systemGreen
            startButton.isEnabled = false
            pauseButton.isEnabled = true
            resetButton.isEnabled = true
            runTimer()
        }
    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01666666, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        second += 1
        timerLbl.text = timeString(time: TimeInterval(second))
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 216000
        let minutes = Int(time) / 3600 % 60
        let seconds = Int(time) / 60 % 60
        let microSeconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i:%02i", hours, minutes, seconds, microSeconds)
    }
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if isTimerRunning == true {
            timerLbl.backgroundColor = .systemYellow
            pauseButton.setTitle("Resume", for: .normal)
            timer.invalidate()
            isTimerRunning = false
        }
        else{
            pauseButton.setTitle("pause", for: .normal)
            timerLbl.backgroundColor = .systemGreen
            runTimer()
            isTimerRunning = true
        }
    }
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        timerLbl.backgroundColor = .systemGray
        timer.invalidate()
        second = 0
        timerLbl.text = timeString(time: TimeInterval(second))
        isTimerRunning = false
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        resetButton.isEnabled = false
    }

}

