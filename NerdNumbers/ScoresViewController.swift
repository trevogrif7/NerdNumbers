//
//  ScoresViewController.swift
//  NerdNumbers
//
//  Created by Trevor Griffin on 10/15/16.
//  Copyright © 2016 TREVOR E GRIFFIN. All rights reserved.
//

import UIKit

class ScoresViewController: UIViewController, UIPopoverPresentationControllerDelegate {

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
    
    // Used to add up score for running score animation
    var scoreAdder = 0.0

    // Most recent time
    var timeScored: Double = 0.0
    
    // Current Difficulty
    var currentDifficulty: String = ""
    
    // Keys for storying data with NSUserdefaults
    let EASY_DIFFICULTY_KEY = "easyDifficultyBestTime"
    let MEDIUM_DIFFICULTY_KEY = "mediumDifficultyBestTime"
    let HARD_DIFFICULTY_KEY = "hardDifficultyBestTime"
    
    // Best time for each difficulty
    var easyBestTime : String?
    var mediumBestTime : String?
    var hardBestTime : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Format Labels
        easyTimeLabel.font = UIFont (name: "ArialMT", size: 20)
        mediumTimeLabel.font = UIFont (name: "ArialMT", size: 20)
        hardTimeLabel.font = UIFont (name: "ArialMT", size: 20)

        bestEasyTimeLabel.font = UIFont (name: "ArialMT", size: 20)
        bestEasyTimeLabel.text = "N/A seconds"
        bestMediumTimeLabel.font = UIFont (name: "ArialMT", size: 20)
        bestMediumTimeLabel.text = "N/A seconds"
        bestHardTimeLabel.font = UIFont (name: "ArialMT", size: 20)
        bestHardTimeLabel.text = "N/A seconds"
        
        currentTimeLabel.font = UIFont (name: "Arial-BoldMT", size: 22)
        currentTimeScoredLabel.font = UIFont (name: "Arial-BoldMT", size: 35)
        currentTimeScoredLabel.text = "0.0 seconds"
       
        // Use NSUserDefaults to retrieve top times for each difficulty
        let defaults = UserDefaults.standard
        easyBestTime = defaults.string(forKey: EASY_DIFFICULTY_KEY)
        if (easyBestTime != nil) {
            bestEasyTimeLabel.text = easyBestTime! + " seconds"
        }
        else {
            easyBestTime = "9999.9"
        }

        mediumBestTime = defaults.string(forKey: MEDIUM_DIFFICULTY_KEY)
        if (mediumBestTime != nil) {
            bestMediumTimeLabel.text = mediumBestTime! + " seconds"
        }
        else {
            mediumBestTime = "9999.9"
        }

        hardBestTime = defaults.string(forKey: HARD_DIFFICULTY_KEY)
        if (hardBestTime != nil) {
            bestHardTimeLabel.text = hardBestTime! + " seconds"
        }
        else {
            hardBestTime = "9999.9"
        }

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
            
            // Update all times
            updateTimes()
        }
    }
    @IBAction func screenWasTapped(_ sender: UITapGestureRecognizer) {
        
        if scoreTimer.isValid {
            scoreTimer.invalidate()
            
            // Update all times
            updateTimes()
        }
    }
    
    func updateTimes() {
        // Display final score
        currentTimeScoredLabel.text = String(format: "%.1f", timeScored) + " seconds"
        
        // Check to see if there is a new best time. If so, update the appropriate fields and save the new time
        switch currentDifficulty {
        case "easy":
            if timeScored < Double(easyBestTime!)! {
                easyBestTime = String(timeScored)
                bestEasyTimeLabel.text = easyBestTime! + " seconds"
                
                // Save new best time for easy difficulty
                let defaults = UserDefaults.standard
                defaults.set(easyBestTime, forKey: EASY_DIFFICULTY_KEY)
            }
        case "medium":
            if timeScored < Double(mediumBestTime!)! {
                mediumBestTime = String(timeScored)
                bestMediumTimeLabel.text = mediumBestTime! + " seconds"
                
                // Save new best time for medium difficulty
                let defaults = UserDefaults.standard
                defaults.set(mediumBestTime, forKey: MEDIUM_DIFFICULTY_KEY)
            }
        case "hard":
            if timeScored < Double(hardBestTime!)! {
                hardBestTime = String(timeScored)
                bestHardTimeLabel.text = hardBestTime! + " seconds"
                
                // Save new best time for hard difficulty
                let defaults = UserDefaults.standard
                defaults.set(hardBestTime, forKey: HARD_DIFFICULTY_KEY)
            }
        default:
            break
        }
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "menuSegue", sender: self)
    }


    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "menuSegue":
            
            // Present popover menu
            segue.destination.popoverPresentationController?.sourceRect = CGRect(x: 6.0, y: -10.0, width: 10, height: 0)
            let popoverVC = segue.destination as! MenuViewController
            
            // Change the size of the popover view
            popoverVC.preferredContentSize = CGSize(width: 100, height: 100)
            
            let popoverController = popoverVC.popoverPresentationController
            popoverController?.delegate = self
            popoverController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            popoverVC.segueID = "scoresPage"
        default: break
            
        }
    }
}
