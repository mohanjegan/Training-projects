//
//  ViewController.swift
//  AudioRecorder
//
//  Created by Mohan on 12/10/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    
    @IBOutlet weak var recordBtn: UIButton!
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var phoneNo: UITextField!
    
    @IBOutlet weak var callBtn: UIButton!
    var soundRecorder: AVAudioRecorder!
    var soundPlayer: AVAudioPlayer!
    var fileName: String = "audioFile.m4a"
    var time: TimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRecorder()
        playBtn.isEnabled = false
    }
    
    func getDocumentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func setUpRecorder(){
        let audioFileName = getDocumentsDirectory().appendingPathComponent(fileName)
        let recordSetting = [AVFormatIDKey: kAudioFormatAppleLossless,
                             AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
                             AVEncoderBitRateKey: 320000,
                             AVNumberOfChannelsKey: 2,
                             AVSampleRateKey: 44100.2] as [String: Any]
        do{
            soundRecorder = try AVAudioRecorder(url: audioFileName, settings: recordSetting)
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
        }catch{
            print(error)
        }
    }
    
    func setUpPlayer(){
        let audioFileName = getDocumentsDirectory().appendingPathComponent(fileName)
        do{
            soundPlayer = try AVAudioPlayer(contentsOf: audioFileName)
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer .volume = 1.0
        }catch{
            print(error)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        playBtn.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordBtn.isEnabled = true
        playBtn.setTitle("Play", for: .normal)
    }
    
    @IBAction func recordAct(_ sender: Any) {
        if recordBtn.titleLabel?.text == "Record"{
            soundRecorder.record()
            recordBtn.setTitle("Pause", for: .normal)
            playBtn.isEnabled = false
        }else{
            soundRecorder.pause()
            //soundRecorder.stop()
            recordBtn.setTitle("Record", for: .normal)
            playBtn.isEnabled = false
        }
    }
    
    @IBAction func playAct(_ sender: Any) {
        
        if playBtn.titleLabel?.text == "Play"{
            playBtn.setTitle("Pause", for: .normal)
            recordBtn.isEnabled = false
            setUpPlayer()
            soundPlayer.currentTime = time
            soundPlayer.play()
        }else{
            soundPlayer.pause()
            time = soundPlayer.currentTime
            //soundPlayer.stop()
            playBtn.setTitle("Play", for: .normal)
            recordBtn.isEnabled = false
        }
    }
    
    @IBAction func stopAct(_ sender: Any) {
        //stop player
            soundPlayer.stop()
            time = 0
            playBtn.setTitle("Play", for: .normal)
            recordBtn.isEnabled = true
        //stop recorder
            soundRecorder.stop()
            recordBtn.setTitle("Record", for: .normal)
            playBtn.isEnabled = true
    }
    @IBAction func callAct(_ sender: Any) {
        if let url = URL(string: "tel://\(phoneNo.text!)"),
        UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

