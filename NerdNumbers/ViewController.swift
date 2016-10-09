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
    @IBOutlet weak var beginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //beginButton.titleLabel!.font = UIFont (name: "ArchitectsDaughter-Bold", size: 17)
        //beginButton.titleLabel!.textColor = UIColor.white
        //beginButton.titleLabel!.font =
        beginButton.layer.shadowColor = UIColor.darkGray.cgColor
        beginButton.layer.masksToBounds = false
        beginButton.layer.shadowOpacity = 1.0
        beginButton.layer.shadowRadius = 0
        beginButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func beginButtonPressed(_ sender: UIButton) {
    }

}

