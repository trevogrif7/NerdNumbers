//
//  MenuViewController.swift
//  NerdNumbers
//
//  Created by Trevor Griffin on 10/16/16.
//  Copyright © 2016 TREVOR E GRIFFIN. All rights reserved.
//

import UIKit

protocol MyMenuDelegate{
    func button2Pressed()
}


class MenuViewController: UIViewController {

    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var menuButton1: UIButton!
    @IBOutlet weak var menuButton2: UIButton!
    @IBOutlet weak var dividerLabel: UILabel!

    // Identifies which viewcontroller initiated the segue
    var segueID : String = ""

    var delegate : MyMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Format labels and buttons
        menuTitleLabel.font = UIFont (name: "ArialRoundedMTBold", size: 18)
        menuTitleLabel.text = "OPTIONS"
        
        dividerLabel.layer.borderColor = UIColor.white.cgColor
        dividerLabel.layer.borderWidth = 2.0
        
        menuButton1.titleLabel?.font = UIFont (name: "ArialRoundedMTBold", size: 18)
        menuButton1.setTitle("Best Times", for: UIControlState.normal)

        menuButton2.titleLabel?.font = UIFont (name:
            "ArialRoundedMTBold", size: 18)
        menuButton2.setTitle("New Game", for: UIControlState.normal)
 
        // Format menu based on what viewcontroller initiated the segue
        switch segueID {
        case "difficultyPage":
            menuButton2.isHidden = true
            menuButton2.isEnabled = false
        case "gameBoardPage":
            menuButton2.isHidden = false
            menuButton2.isEnabled = true
        case "scoresPage":
            menuButton2.isHidden = false
            menuButton2.isEnabled = true
            menuButton1.setTitle("New Game", for: UIControlState.normal)
            menuButton2.setTitle("Clear Scores", for: UIControlState.normal)

        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    @IBAction func menuButton1Pressed(_ sender: UIButton) {
        
        switch segueID {
        case "difficultyPage":
            performSegue(withIdentifier: "scoresSegue", sender: self)
        case "gameBoardPage":
            performSegue(withIdentifier: "scoresSegue", sender: self)
        case "scoresPage":
            performSegue(withIdentifier: "difficultySegue", sender: self)
        default:
            break
        }
    }

    // This button should only be available on the game board page and should always go to the difficulty menu
    @IBAction func menuButton2Pressed(_ sender: UIButton) {
        switch segueID {
        case "difficultyPage":
            print("ERROR: We should never get here this button should not be available (MenuViewController.menuButton2Pressed")
            break
        case "gameBoardPage":
            // Start a new game
            performSegue(withIdentifier: "difficultySegue", sender: self)
        case "scoresPage":
            
            if self.delegate != nil {
                dismiss(animated: true, completion: nil)
                self.delegate?.button2Pressed()
                // Dismiss the popover
            }

            
            // Reload scores view controller
            //performSegue(withIdentifier: "scoresSegue", sender: self)
 
        default:
            break
        }
    }
}
