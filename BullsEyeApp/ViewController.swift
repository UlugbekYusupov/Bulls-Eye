//
//  ViewController.swift
//  BullsEyeApp
//
//  Created by Ulugbek Yusupov on 1/22/19.
//  Copyright © 2019 Ulugbek Yusupov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0

    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
        startOverButtonTapped()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
     
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SmallButton")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    // creating action method for Hit Me button
    @IBAction func showAlert() {
        
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        score += points
        
        let message = "You scored \(points) points"
        let title: String
        
        
        if difference == 0 {
            title = "Perfect!"
            points += 100
        }
        else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        }
        else if difference < 10 {
            title = "Pretty Good!"
        }
        else {
            title = "Not even close..."
        }
        
        // create alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //create action button for that alert
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in self.startNewRound()
        })
        
        // adding alert with action
        alert.addAction(action)
        present(alert,animated:true, completion:nil)
    }
    
    @IBAction func sliderValueChanged(_ slider: UISlider) {
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
    }
    
    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
        
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    @IBAction func startOverButtonTapped() {
        score = 0
        round = 0
        startNewRound()
    }
}

