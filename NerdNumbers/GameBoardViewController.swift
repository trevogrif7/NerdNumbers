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
    @IBOutlet weak var binaryLabel: UILabel!
    @IBOutlet weak var whatIsTheBinaryValueLabel: UILabel!
    @IBOutlet weak var decimalLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!

    // Define variables
    var timer = Timer()
    var timeCounter = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Format the labels
        decimalLabel.font = UIFont (name: "ArialMT", size: 80)

        binaryLabel.layer.borderColor = UIColor.darkGray.cgColor
        binaryLabel.layer.borderWidth = 1.0
        binaryLabel.font = UIFont (name: "ArialMT", size: 38)
        
        whatIsTheBinaryValueLabel.font = UIFont (name: "ArialRoundedMTBold", size: 25)
        
        titleLabel.font = UIFont (name: "ArialRoundedMTBold", size: 19)
        
        timerLabel.font = UIFont (name: "Courier-Bold", size: 30)
        
        // Format the buttons
        for button in myButtons {
            button.titleLabel?.font = UIFont (name: "ArialRoundedMTBold", size: 30)
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.masksToBounds = false
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 0
            button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        }
        
        // Begin timer
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(GameBoardViewController.incrementTimer), userInfo: nil, repeats: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func incrementTimer () {
        
        // Increment the time counter variable
        timeCounter += 0.1
        
        // Put a cap on timeCounter so that it doesn't count forever
        if timeCounter > 10.0 {
            timeCounter = 0.0
            
            timerLabel.text = "TIME'S UP!"
            timer.invalidate()
            return
        }
        
        timerLabel.text = String(format: "%.1f", timeCounter)
    }


    
}
