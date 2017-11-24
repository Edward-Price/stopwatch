//
//  ViewController.swift
//  stopwatch
//
//  Created by Edward Price on 10/11/2017.
//  Copyright © 2017 Edward Price. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gradientLayer: CAGradientLayer!

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var timeDisplay: UILabel!
    
    var startTime = TimeInterval()
    var pauseTime = TimeInterval()
    var timer = Timer()
    var isPaused = false
    
    @IBAction func startPressed(_ sender: Any) {
        if startButton.titleLabel?.text == "Start"{
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            startButton.setTitle("Pause",for: .normal)
            startTime = Date.timeIntervalSinceReferenceDate
            isPaused = false
        }
        else if startButton.titleLabel?.text == "Pause"{
            startButton.setTitle("Resume",for: .normal)
            timer.invalidate()
            pauseTime = timer.timeInterval
            isPaused = true
        }
        else if startButton.titleLabel?.text == "Resume"{
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            startButton.setTitle("Pause",for: .normal)
            isPaused = false
        }
    }
    
    @IBAction func stopPressed(_ sender: Any) {
        timer.invalidate()
        timer = Timer()
        timeDisplay.text = "00:00:00"
        startButton.setTitle("Start",for: .normal)
        pauseTime = TimeInterval()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        startButton.layer.borderWidth = 1
        startButton.layer.borderColor = UIColor.white.cgColor
        startButton.layer.cornerRadius = 10
        startButton.clipsToBounds = true
        
        stopButton.layer.borderWidth = 1
        stopButton.layer.borderColor = UIColor.white.cgColor
        stopButton.layer.cornerRadius = 10
        stopButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor(red:0.22, green:0.29, blue:0.73, alpha:1.0).cgColor, UIColor(red:0.69, green:0.68, blue:0.95, alpha:1.0).cgColor]
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc func updateTime() {
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate
        
        var elapsedTime = currentTime - startTime
        
        let minutes = UInt8(elapsedTime / 60.0)
        
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        let seconds = UInt8(elapsedTime)
        
        elapsedTime -= TimeInterval(seconds)
        
        let fraction = UInt8(elapsedTime * 100)
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        timeDisplay.text = "\(strMinutes):\(strSeconds):\(strFraction)"
        
    }

}

