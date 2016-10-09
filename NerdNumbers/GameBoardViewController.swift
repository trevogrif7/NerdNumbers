//
//  GameBoardViewController.swift
//  NerdNumbers
//
//  Created by Trevor Griffin on 10/8/16.
//  Copyright © 2016 TREVOR E GRIFFIN. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController {

    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var binaryLabel: UILabel!
    @IBOutlet weak var whatIsTheBinaryValueLabel: UILabel!
    @IBOutlet weak var decimalLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

//        decimalLabel.layer.borderColor = UIColor.white.cgColor
//        decimalLabel.layer.borderWidth = 1.0

        binaryLabel.layer.borderColor = UIColor.darkGray.cgColor
        binaryLabel.layer.borderWidth = 1.0
        
        zeroButton.layer.shadowColor = UIColor.darkGray.cgColor
        zeroButton.layer.masksToBounds = false
        zeroButton.layer.shadowOpacity = 1.0
        zeroButton.layer.shadowRadius = 0
        zeroButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
        oneButton.layer.shadowColor = UIColor.darkGray.cgColor
        oneButton.layer.masksToBounds = false
        oneButton.layer.shadowOpacity = 1.0
        oneButton.layer.shadowRadius = 0
        oneButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
        clearButton.layer.shadowColor = UIColor.darkGray.cgColor
        clearButton.layer.masksToBounds = false
        clearButton.layer.shadowOpacity = 1.0
        clearButton.layer.shadowRadius = 0
        clearButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
