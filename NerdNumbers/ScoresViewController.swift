//
//  ScoresViewController.swift
//  NerdNumbers
//
//  Created by Trevor Griffin on 10/15/16.
//  Copyright © 2016 TREVOR E GRIFFIN. All rights reserved.
//

import UIKit

class ScoresViewController: UIViewController {

    @IBOutlet weak var easyTimeLabel: UILabel!
    @IBOutlet weak var mediumTimeLabel: UILabel!
    @IBOutlet weak var hardTimeLabel: UILabel!
    @IBOutlet weak var bestEasyTimeLabel: UILabel!
    @IBOutlet weak var bestMediumTimeLabel: UILabel!
    @IBOutlet weak var bestHardTimeLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var currentTimeScoredLabel: UILabel!
    @IBOutlet weak var nNLogoImageView: UIImageView!
   
    //// Define variables ////
    
    // Variables to regulate the timer used for running score animation
    var scoreTimer = Timer()
    var scoreTimeCounter = 0
    
    // Used to add up score for running score animation
    var scoreAdder = 0.0

    // Most recent time
    var timeScored: Double = 0.0
    
    // Current Difficulty
    var currentDifficulty: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Format Labels
        easyTimeLabel.font = UIFont (name: "ArialMT", size: 20)
        mediumTimeLabel.font = UIFont (name: "ArialMT", size: 20)
        hardTimeLabel.font = UIFont (name: "ArialMT", size: 20)
        bestEasyTimeLabel.font = UIFont (name: "ArialMT", size: 20)
        bestMediumTimeLabel.font = UIFont (name: "ArialMT", size: 20)
        bestHardTimeLabel.font = UIFont (name: "ArialMT", size: 20)
        currentTimeLabel.font = UIFont (name: "Arial-BoldMT", size: 22)
        currentTimeScoredLabel.font = UIFont (name: "Arial-BoldMT", size: 35)
        
        currentTimeScoredLabel.text = "0.0 seconds"
       
        // Begin timer
        scoreTimer = Timer.scheduledTimer(timeInterval: 1/300, target: self, selector: #selector(ScoresViewController.showScore), userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func showScore() {
        
        // Display score with running total
        currentTimeScoredLabel.text = String(format: "%.1f", scoreAdder) + " seconds"
        
        // Add time each time until we run up to the score
        scoreAdder += 0.1
        
        if scoreAdder > timeScored {
            scoreTimer.invalidate()
            
            // Display final score
            currentTimeScoredLabel.text = String(format: "%.1f",timeScored) + " seconds"

        }
    }
    @IBAction func screenWasTapped(_ sender: UITapGestureRecognizer) {
        
        if scoreTimer.isValid {
            scoreTimer.invalidate()
            
            // Display final score
            currentTimeScoredLabel.text = String(format: "%.1f",timeScored) + " seconds"
        }
    }

}
