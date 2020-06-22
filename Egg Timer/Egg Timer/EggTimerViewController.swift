//
//  ViewController.swift
//  Egg Timer
//
//  Created by Hanoudi on 6/22/20.
//  Copyright © 2020 Hanan. All rights reserved.
//


import UIKit
import AVFoundation

class EggTimerViewController: UIViewController {
    
    //  Outlets.
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //  Timer settings and variables.
    //  Average times for cooking are collected from the internet.
    let eggTimes = ["Soft": 180, "Medium": 240, "Hard": 420]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    //  Player variables
    var audioPlayer: AVAudioPlayer!
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        // reset timer, progress bar and seconds passed every time a key is pressed.
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!

        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness + ". Wait patiently till the alarm is set."

        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    
    //  Timer functiom
    //  Checks if seconds passed is less than the total time
    //  Stops timer if seconds passed = total time needed for cooking
    //  Sets an alarm upon completion.
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            // if not add seconds to the current seconds that have passed
            // update progress bar
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)

        } else {
            // secondsPassed = total time needed for cooking
            // Stop timer
            // update label and set alarm
            timer.invalidate()
            titleLabel.text = "Done! Ready to be served."
            
            playSound(fileName: "alarm_sound")
        }
    }
    
    // A function that utilizes the audio player to play sounds from files
    // Takes in file name (in main Bundle i.e project file)
    // with extension .mp3 and plays it
    func playSound(fileName: String) {
        let url = Bundle.main.url(forResource: fileName, withExtension: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: url!)
        audioPlayer.play()
        
    }
    
}
