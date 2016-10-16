//
//  ViewController.swift
//  NerdNumbers
//
//  Created by Trevor Griffin on 10/7/16.
//  Copyright © 2016 TREVOR E GRIFFIN. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    @IBOutlet var myButtons: [UIButton]!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Format the labels
        difficultyLabel.font = UIFont (name: "ArialRoundedMTBold", size: 28)
        difficultyLabel.alpha = 0
        
        titleLabel.font = UIFont (name: "ArialRoundedMTBold", size: 19)
        
        // Format the buttons
        for button in myButtons {
            button.titleLabel?.font = UIFont (name: "ArialRoundedMTBold", size: 19)
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.masksToBounds = false
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 0
            button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            //button.alpha = 0
        }
        
        beginApplication()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func beginApplication () {

        // Display contents with animations
        difficultyLabel.fadeInView()
        
//        for button in myButtons {
//            button.fadeInView()
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "easySegue":
            let gameBoardVC = segue.destination as! GameBoardViewController
            gameBoardVC.difficultySegueID = "easy"
        case "mediumSegue":
            let gameBoardVC = segue.destination as! GameBoardViewController
            gameBoardVC.difficultySegueID = "medium"
        case "hardSegue":
            let gameBoardVC = segue.destination as! GameBoardViewController
            gameBoardVC.difficultySegueID = "hard"
        default: break
            
        }
    }
}

