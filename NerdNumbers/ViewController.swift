//
//  ViewController.swift
//  NerdNumbers
//
//  Created by Trevor Griffin on 10/7/16.
//  Copyright © 2016 TREVOR E GRIFFIN. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet var myButtons: [UIButton]!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var introImageView: UIImageView!
    
    // Variable for setting up opening annimation
    var introMask : CALayer? = CALayer()
        
    override func viewDidLoad() {
        super.viewDidLoad()
  /*
        // Set up opening animation
        //introMask = CALayer()
        introMask!.contents = UIImage(named: "MiddleOfIcon")?.cgImage
        introMask!.contentsGravity = kCAGravityResizeAspect
        introMask!.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        introMask!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        introMask!.position = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        
        // Add intro picture as mask
        self.introImageView.layer.mask = introMask
        
        // Add surrounding color
        //self.introImageView.backgroundColor = UIColor(red: 0, green: 102/255, blue: 255/255, alpha: 1.0)
        
        // Call function to animate app intro
        animate()
        
 
 */
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
    
    func animate() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        //keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 1
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 1
        
        // Begin the animation
        let firstBounds = NSValue(cgRect:introMask!.bounds)
        
        // These parameters create a zoom out then zoom in effect
        let midBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 90, height: 90))
        let lastBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 1500, height: 1500))
        
        // Add values to key frame animation
        keyFrameAnimation.values = [firstBounds, midBounds, lastBounds]
        keyFrameAnimation.keyTimes = [0, 0.4, 1]
        
        // Define animations
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        
        // Create animation
        self.introMask?.add(keyFrameAnimation, forKey: "bounds")
        
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
        case "menuSegue":

            // Present popover menu
            segue.destination.popoverPresentationController?.sourceRect = CGRect(x: 6.0, y: -10.0, width: 10, height: 0)
            let popoverVC = segue.destination as! MenuViewController

            // Change the size of the popover view
            popoverVC.preferredContentSize = CGSize(width: 100, height: 70)

            let popoverController = popoverVC.popoverPresentationController
            popoverController?.delegate = self
            popoverController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            popoverVC.segueID = "difficultyPage"
        default: break
            
        }
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "menuSegue", sender: self)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

