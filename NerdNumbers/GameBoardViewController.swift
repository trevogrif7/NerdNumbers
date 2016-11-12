//
//  GameBoardViewController.swift
//  NerdNumbers
//
//  Created by Trevor Griffin on 10/8/16.
//  Copyright © 2016 TREVOR E GRIFFIN. All rights reserved.
//

import UIKit
import AVFoundation

class GameBoardViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    // Define IB Outlets
    @IBOutlet var myBinaryDigitButtons: [UIButton]!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var whatIsTheBinaryValueLabel: UILabel!
    @IBOutlet weak var decimalLabel: UILabel!
    @IBOutlet weak var decimalRightWrongLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var incorrectAnswerHintLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!

    // Constraints
    @IBOutlet weak var decimalLabelVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var incorrectHintLabelVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var mostSignificantBinaryStackViewContraint: NSLayoutConstraint!
    @IBOutlet weak var topToSecondStackConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondToThirdStackConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdToFourthStackConstraint: NSLayoutConstraint!
    @IBOutlet weak var fifteenthBinaryDigitConstraint: NSLayoutConstraint!
    @IBOutlet weak var fourteenthBinaryDigitConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirteenthBinaryDigitConstraint: NSLayoutConstraint!
    @IBOutlet weak var twelfthBinaryDigitConstraint: NSLayoutConstraint!
    @IBOutlet weak var eleventhBinaryDigitConstraint: NSLayoutConstraint!
    @IBOutlet weak var tenthBinaryDigitConstraint: NSLayoutConstraint!
    @IBOutlet weak var ninthBinaryDigitConstraint: NSLayoutConstraint!
    @IBOutlet weak var eighthBinaryDigitConstraint: NSLayoutConstraint!
    @IBOutlet weak var seventhBinaryDigitConstraint: NSLayoutConstraint!
    @IBOutlet weak var sixthBinaryDigitConstraint: NSLayoutConstraint!
    @IBOutlet weak var fifthBinaryDigitConstraint: NSLayoutConstraint!
    @IBOutlet weak var fourthBinaryDigitConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdBinaryDigitConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondBinaryDigitConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstBinaryDigitConstraint: NSLayoutConstraint!
    @IBOutlet weak var zerothBinaryDigitConstraint: NSLayoutConstraint!

    //// Define variables ////
    
    // Variables to regulate the countdown timer
    var countdownTimer = Timer()
    var countdownTimeCounter = 3
    
    // Variables used ot regulate the game timer
    var gameTimer = Timer()
    var gameTimeCounter = 0.0
    
    // Flag to tell us when it's time to end the countdown before the start of the game
    var timeToStartGame = false

    // Array to hold binary digits in order
    var binaryDigitArray : [String] = ["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]
    
    // Holds given answer in binary format
    var binaryValue : String = ""
    
    // Holds given answer in decimal format
    var decimalValue : Int = 0

    // Identify which difficulty button was used to transition to this viewcontroller
    var difficultySegueID : String = ""

    // Random decimal integer to be converted
    var randomDecimalNumber = 0
    
    // Temporarily hold decimal value when menu is selected or application goes into the background
    var tempDecimalValue = ""
    var countdownTimerIsPaused = false
    var gameTimerIsPaused = false
    
    // Screen size
    let screenSize: CGRect = UIScreen.main.bounds
    
    // Audio Player
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Format the labels and buttons to fit properly based on device size
        if (screenSize.width <= 320) {
            decimalLabelVerticalConstraint.constant = 60.0
            incorrectHintLabelVerticalConstraint.constant = 10.0
            incorrectAnswerHintLabel.font = UIFont (name: "Arial-BoldMT", size: 18)

            whatIsTheBinaryValueLabel.font = UIFont (name: "ArialRoundedMTBold", size: 20)

            countdownLabel.font = UIFont (name: "ArialRoundedMTBold", size: 350)
            
            for button in myBinaryDigitButtons {
                button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 28)
            }
            
            mostSignificantBinaryStackViewContraint.constant = -120.0
            
            topToSecondStackConstraint.constant = 6
            secondToThirdStackConstraint.constant = 6
            thirdToFourthStackConstraint.constant = 6
            
            fifteenthBinaryDigitConstraint.constant = 18
            fourteenthBinaryDigitConstraint.constant = 18
            thirteenthBinaryDigitConstraint.constant = 18
            twelfthBinaryDigitConstraint.constant = 18
            eleventhBinaryDigitConstraint.constant = 18
            tenthBinaryDigitConstraint.constant = 18
            ninthBinaryDigitConstraint.constant = 18
            eighthBinaryDigitConstraint.constant = 18
            seventhBinaryDigitConstraint.constant = 18
            sixthBinaryDigitConstraint.constant = 18
            fifthBinaryDigitConstraint.constant = 18
            fourthBinaryDigitConstraint.constant = 18
            thirdBinaryDigitConstraint.constant = 18
            secondBinaryDigitConstraint.constant = 18
            firstBinaryDigitConstraint.constant = 18
            zerothBinaryDigitConstraint.constant = 18
           
        }
        else if screenSize.width >= 414 {
             decimalLabelVerticalConstraint.constant = 150.0
            incorrectAnswerHintLabel.font = UIFont (name: "Arial-BoldMT", size: 20)

        }
        else {
            incorrectAnswerHintLabel.font = UIFont (name: "Arial-BoldMT", size: 20)
            whatIsTheBinaryValueLabel.font = UIFont (name: "ArialRoundedMTBold", size: 25)
            countdownLabel.font = UIFont (name: "ArialRoundedMTBold", size: 375)
        }
        
        // Continue formating labels and buttons which aren't device specific
        incorrectAnswerHintLabel.alpha = 0.0

        decimalLabel.font = UIFont (name: "ArialMT", size: 80)
        decimalLabel.text = ""
        decimalLabel.layer.borderColor = UIColor.darkGray.cgColor
        decimalLabel.layer.borderWidth = 2.0

        decimalRightWrongLabel.font = UIFont (name: "ArialMT", size: 80)
        decimalRightWrongLabel.text = ""
        decimalRightWrongLabel.layer.borderWidth = 2.0
        decimalRightWrongLabel.alpha = 0.0
        
        titleLabel.font = UIFont (name: "ArialRoundedMTBold", size: 19)
        
        timerLabel.font = UIFont (name: "Courier-Bold", size: 30)
        timerLabel.text = "0.0"
        
        countdownLabel.alpha = 0.0
        
        counterLabel.font = UIFont (name: "Courier-Bold", size: 13)
        
        // Format the binary digit buttons with a loop
        for button in myBinaryDigitButtons {
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.masksToBounds = false
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 0
            button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            button.isEnabled = false
        }
        
        enterButton.titleLabel?.font = UIFont (name: "ArialRoundedMTBold", size: 30)
        enterButton.layer.shadowColor = UIColor.darkGray.cgColor
        enterButton.layer.masksToBounds = false
        enterButton.layer.shadowOpacity = 1.0
        enterButton.layer.shadowRadius = 0
        enterButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        enterButton.isEnabled = false
        
        // Sign up to be notified when application enters and exits the backgrond
        NotificationCenter.default.addObserver(self, selector: #selector(appEnteringBackground), name: NSNotification.Name(rawValue: "PauseApp"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(appHasBecomeActive), name: NSNotification.Name(rawValue: "ResumeApp"), object: nil)
        
        // Begin countdown timer
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startGame), userInfo: nil, repeats: true)
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
            
            // Enable inputs and display first value
            enterButton.isEnabled = true
            
            for button in myBinaryDigitButtons {
                button.isEnabled = true
            }
            
            // Display value to be converted
            displayNextValue()
            
            // Exit function
            return
        }
        
        // Display "GO!" for the last second
        if timeToStartGame == true {
            countdownLabel.text = "GO!"
            countdownLabel.font = UIFont (name: "ArialRoundedMTBold", size: 150)
            
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
    
    // Figure out which segue got us to this viewcontroller and set difficulty based on that
    func displayNextValue() {
        switch difficultySegueID {
        case "easy":
            randomDecimalNumber = Int(arc4random_uniform(255) + 1)
            decimalLabel.text = String(randomDecimalNumber)
            decimalRightWrongLabel.text = decimalLabel.text

        case "medium":
            randomDecimalNumber = Int(arc4random_uniform(4095) + 1)
            decimalLabel.text = String(randomDecimalNumber)
            decimalRightWrongLabel.text = decimalLabel.text

    
        case "hard":
            randomDecimalNumber = Int(arc4random_uniform(65535) + 1)
            decimalLabel.text = String(randomDecimalNumber)
            decimalRightWrongLabel.text = decimalLabel.text
        default:
            break
        }
    }
    
    // Increments the timer
    func incrementTimer () {
        
        // Stop displaying count down label
        //countdownLabel.isHidden = true
        
        // Increment the time counter variable
        gameTimeCounter += 0.1
        
        // Put a cap on timeCounter so that it doesn't count forever
        if gameTimeCounter >= 9999.9 {
            
            gameTimer.invalidate()
            
            // Transition to the score page if the player reaches 9999.9 seconds
            self.performSegue(withIdentifier: "endGameSegue", sender: self)
            
            return
        }
        
        timerLabel.text = String(format: "%.1f", gameTimeCounter)
    }

    @IBAction func enterButtonPressed(_ sender: UIButton) {
        
        // Fill an array, in order (based on the tags set in the Attributes Inspector), with the binary digits
        for button in myBinaryDigitButtons {
            binaryDigitArray[button.tag] = button.titleLabel!.text!
        }
        
        // Reverse order of array to put it in proper binary order
        binaryDigitArray.reverse()
        
        // Join array into one string
        binaryValue = binaryDigitArray.joined()
        
        // Convert binary number to decimal number for comparison
        decimalValue = Int(binaryValue, radix: 2)!
        
        // Correct, binary value matches decimal value, go to next number
        if decimalLabel.text == String(decimalValue) {
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
                endGame()
     
                // Play "youWin" sound effect
                playSoundEffect(soundEffect: "youWin")

                return
            default:
                break
            }
            
            // Play "correctAnswer" sound effect
            playSoundEffect(soundEffect: "correctAnswer")

            // Set all binary digit buttons to zero
            setBinaryDigitsToZero()
            
            // Flash a green background for a correct answer
            decimalRightWrongLabel.alpha = 1.0
            decimalRightWrongLabel.backgroundColor = UIColor(red: 51/255, green: 204/255, blue: 102/255, alpha: 1.0)
            decimalRightWrongLabel.fadeOutView()

            // Display next value
            displayNextValue()
            
        }
        
        // Incorrect, binary value does not match decimal value, try again
        else {

            // Play "wrongAnswer" sound effect
            playSoundEffect(soundEffect: "wrongAnswer")

            // Set all binary digits to "0"
            setBinaryDigitsToZero()
            
            // Flash a red background for an incorrect answer
            decimalRightWrongLabel.alpha = 1.0
            decimalRightWrongLabel.backgroundColor = UIColor(red: 255/255, green: 51/255, blue: 51/255, alpha: 1.0)
            decimalRightWrongLabel.fadeOutView()
            
            // Get offsets in order to display binary value in groupings of four
            let stringIndex1 = binaryValue.index(binaryValue.startIndex, offsetBy: 3)
            let stringIndex2 = binaryValue.index(binaryValue.startIndex, offsetBy: 4)
            let stringIndex3 = binaryValue.index(binaryValue.startIndex, offsetBy: 7)
            let stringIndex4 = binaryValue.index(binaryValue.startIndex, offsetBy: 8)
            let stringIndex5 = binaryValue.index(binaryValue.startIndex, offsetBy: 11)
            let stringIndex6 = binaryValue.index(binaryValue.startIndex, offsetBy: 12)
            let stringIndex7 = binaryValue.index(binaryValue.startIndex, offsetBy: 15)

            incorrectAnswerHintLabel.text = binaryValue[binaryValue.startIndex...stringIndex1] + " " +
                binaryValue[stringIndex2...stringIndex3] + " " +
                binaryValue[stringIndex4...stringIndex5] + " " +
                binaryValue[stringIndex6...stringIndex7] + " = " + String(decimalValue)

            // Flash a label which displays the actual decimal value of your incorrect answered
            incorrectAnswerHintLabel.alpha = 1.0
            incorrectAnswerHintLabel.fadeOutView(duration: 2.5)
        }
    }
    
    func setBinaryDigitsToZero() {
        // Loops through all binary digit buttons and sets them to zero
        for button in myBinaryDigitButtons {
            button.setTitle("0", for: UIControlState.normal)
        }
    }
    
    // Toggle binary digits between "1" and "0"
    @IBAction func binaryDigitButtonPressed(_ sender: UIButton) {
        
        if sender.titleLabel!.text == "0" {
            sender.setTitle("1", for: UIControlState.normal)
        }
        else {
            sender.setTitle("0", for: UIControlState.normal)
        }
        
        // Play "shortTicSound" sound effect
        playSoundEffect(soundEffect: "shortTicSound")
    }
    
    func endGame() {
        // Stop timer
        gameTimer.invalidate()
        
        // Display winner label
        countdownLabel.isHidden = false
        countdownLabel.font = UIFont (name: "ArialRoundedMTBold", size: 110)
        countdownLabel.textColor = UIColor(red: 51/255, green: 204/255, blue: 102/255, alpha: 1.0)
        countdownLabel.text = "You Win!!"
        countdownLabel.alpha = 0.0
        countdownLabel.fadeInView(duration: 0.5)

        // Delay before transitioning to score viewcontroller
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.performSegue(withIdentifier: "endGameSegue", sender: self)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "endGameSegue":
            let  scoresVC = segue.destination as! ScoresViewController
            scoresVC.timeScored = Double(timerLabel.text!)!
            scoresVC.currentDifficulty = difficultySegueID
            
        case "menuSegue":
            // Present popover menu
            segue.destination.popoverPresentationController?.sourceRect = CGRect(x: 6.0, y: -10.0, width: 10, height: 0)
            let popoverVC = segue.destination as! MenuViewController
            
            // Change the size of the popover view
            popoverVC.preferredContentSize = CGSize(width: 120, height: 100)
            
            let popoverController = popoverVC.popoverPresentationController
            popoverController?.delegate = self 
            popoverController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            popoverVC.segueID = "gameBoardPage"

        default:
            break
        }
    }

    @IBAction func menuButtonPressed(_ sender: UIButton) {
        if countdownTimer.isValid {
            countdownTimer.invalidate()
            countdownTimerIsPaused = true
        }
        else if gameTimer.isValid {
            gameTimer.invalidate()
            gameTimerIsPaused = true
        }
        
        tempDecimalValue = decimalLabel.text!
        decimalLabel.text = ""
        
        performSegue(withIdentifier: "menuSegue", sender: self)
        
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
       
        // Resume timers and replace decimal number when the menu is exited
        decimalLabel.text = tempDecimalValue
       
        if countdownTimerIsPaused {
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameBoardViewController.startGame), userInfo: nil, repeats: true)
            countdownTimerIsPaused = false
        }
        
        if gameTimerIsPaused {
            gameTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(GameBoardViewController.incrementTimer), userInfo: nil, repeats: true)
            gameTimerIsPaused = false
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func appEnteringBackground() {
        // Pause timers when entering the background
        if countdownTimer.isValid {
            countdownTimer.invalidate()
            countdownTimerIsPaused = true
        }
        else if gameTimer.isValid {
            gameTimer.invalidate()
            gameTimerIsPaused = true
        }
    }
    
    func appHasBecomeActive() {
        // Unpause timers when entering the foreground
        if countdownTimerIsPaused {
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameBoardViewController.startGame), userInfo: nil, repeats: true)
            countdownTimerIsPaused = false
        }
        
        if gameTimerIsPaused {
            gameTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(GameBoardViewController.incrementTimer), userInfo: nil, repeats: true)
            gameTimerIsPaused = false
        }
    }
    
    func playSoundEffect(soundEffect: String) {
        
        // Set up sound effect
        let newSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: soundEffect, ofType: "aifc")!)
        
        
        // Prepare audio session
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("ERROR: AVAudioSession setup failed")
        }
        
        
        // Play Sound
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: newSound as URL)
        } catch {
            print("ERROR: audioPlayer initialization failed")
        }
        
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
    }
}
