//
//  GameBoardViewController.swift
//  NerdNumbers
//
//  Created by Trevor Griffin on 10/8/16.
//  Copyright © 2016 TREVOR E GRIFFIN. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController {

    // Define IB Outlets
    @IBOutlet var myButtons: [UIButton]!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var whatIsTheBinaryValueLabel: UILabel!
    @IBOutlet weak var decimalLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!

    //// Define variables ////
    
    // Variables to regulate the countdown timer
    var countdownTimer = Timer()
    var countdownTimeCounter = 3
    
    // Variables used ot regulate the game timer
    var gameTimer = Timer()
    var gameTimeCounter = 0.0
    
    // Flag to tell us when it's time to end the countdown before the start of the game
    var timeToStartGame = false


    override func viewDidLoad() {
        super.viewDidLoad()

        // Format the labels
        decimalLabel.font = UIFont (name: "ArialMT", size: 80)

        decimalLabel.layer.borderColor = UIColor.darkGray.cgColor
        decimalLabel.layer.borderWidth = 2.0
       
        whatIsTheBinaryValueLabel.font = UIFont (name: "ArialRoundedMTBold", size: 25)
        
        titleLabel.font = UIFont (name: "ArialRoundedMTBold", size: 19)
        
        timerLabel.font = UIFont (name: "Courier-Bold", size: 30)
        timerLabel.text = "0.0"
        
        countdownLabel.font = UIFont (name: "ArialRoundedMTBold", size: 375)
        countdownLabel.alpha = 0.0
        
        counterLabel.font = UIFont (name: "Courier-Bold", size: 13)
        
        // Format the buttons
        for button in myButtons {
            //button.titleLabel?.font = UIFont (name: "ArialRoundedMTBold", size: 30)
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.masksToBounds = false
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 0
            button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        }
        
        enterButton.titleLabel?.font = UIFont (name: "ArialRoundedMTBold", size: 30)
        enterButton.layer.shadowColor = UIColor.darkGray.cgColor
        enterButton.layer.masksToBounds = false
        enterButton.layer.shadowOpacity = 1.0
        enterButton.layer.shadowRadius = 0
        enterButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
        // Begin timer
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameBoardViewController.startGame), userInfo: nil, repeats: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startGame() {
        
        // End countdown and start game
        if countdownTimeCounter == -1 {
            
            //Turn off countdown timer
            countdownTimer.invalidate()
            
            // Begin game timer
            gameTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(GameBoardViewController.incrementTimer), userInfo: nil, repeats: true)
            
            // Exit function
            return
        }
        
        // Display "GO!" for the last second
        if timeToStartGame == true {
            countdownLabel.text = "GO!"
            countdownLabel.font = UIFont (name: "ArialRoundedMTBold", size: 175)
            
            // Display then fade out countdown label
            countdownLabel.alpha = 0.7
            countdownLabel.fadeOutView(duration: 1.0)

            // Decrement countdown timer
            countdownTimeCounter -= 1
            
            // Exit function
            return
        }
        
        // Set, display, and fade out countdown label
        countdownLabel.text = String(countdownTimeCounter)
        countdownLabel.alpha = 0.7
        countdownLabel.fadeOutView(duration: 1.0)
        
        // Decrement countdown timer
        countdownTimeCounter -= 1

        // Set flag to end the countdown
        if countdownTimeCounter == 0 {
            timeToStartGame = true
        }
    }
    
    // Increments the timer
    func incrementTimer () {
        
        // Stop displaying count down label
        countdownLabel.isHidden = true
        
        // Increment the time counter variable
        gameTimeCounter += 0.1
        
        // Put a cap on timeCounter so that it doesn't count forever
        if gameTimeCounter > 120.0 {
            gameTimeCounter = 0.0
            
            timerLabel.text = "TIME'S UP!"
            gameTimer.invalidate()
            return
        }
        
        timerLabel.text = String(format: "%.1f", gameTimeCounter)
    }

    @IBAction func enterButtonPressed(_ sender: UIButton) {
        
        // TODO: If binary value matches decimal value
        // TODO: display message for correct answer (maybe just go to next number?)
        
        if decimalLabel.text != "" {  // TODO: Change comparison to be if the values match correctly
            switch counterLabel.text! {
            case "1/10":
                counterLabel.text = "2/10"
            case "2/10":
                counterLabel.text = "3/10"
            case "3/10":
                counterLabel.text = "4/10"
            case "4/10":
                counterLabel.text = "5/10"
            case "5/10":
                counterLabel.text = "6/10"
            case "6/10":
                counterLabel.text = "7/10"
            case "7/10":
                counterLabel.text = "8/10"
            case "8/10":
                counterLabel.text = "9/10"
            case "9/10":
                counterLabel.text = "10/10"
            case "10/10":
                break
                // Display the score card with your time and your best times for the current difficulty
            default:
                break
            }
            
            // TODO: Check flag to see if this is an easy, medium, or hard game then go to next number
            
            // Easy mode
            let easyRandomNumber = Int(arc4random_uniform(256))
            decimalLabel.text = String(easyRandomNumber)
          
            // Medium mode
            //let mediumRandomNumber = Int(arc4random_uniform(4096))
            //decimalLabel.text = String(easyRandomNumber)
            
            // Hard mode
            //let hardRandomNumber = Int(arc4random_uniform(65536))
            //decimalLabel.text = String(easyRandomNumber)

        }
        
        // Binary value does not match decimal value, try again
        else {

            // Set all binary digits to "0"
            for button in myButtons {
                button.setTitle("0", for: UIControlState.normal)
            }
            
            // TODO: display message for incorrect answer
        }
    }
    
    // Toggle binary digits between "1" and "0"
    @IBAction func binaryDigitButtonPressed(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "0" {
            sender.setTitle("1", for: UIControlState.normal)
        } else {
            sender.setTitle("0", for: UIControlState.normal)

        }
       
    }
    

    
}
