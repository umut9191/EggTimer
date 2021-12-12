//
//  ViewController.swift
//  EggTimer
//
//  Created by Mac on 8.12.2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var player:AVAudioPlayer?
    let eggTimes=["Soft":5,"Medium":8,"Hard":12]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0
        let hardness = sender.currentTitle!
        titleLabel.text = hardness
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter(){
        if totalTime > secondsPassed {
            secondsPassed+=1
            progressBar.progress = Float(secondsPassed)/Float(totalTime)
            playSound()
        }
        else{
            timer.invalidate()
            titleLabel.text="Done."
            player?.stop()
        }
    }
    
    func playSound(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try!AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
    
}

