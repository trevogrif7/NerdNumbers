//
//  UIViewExtensions.swift
//  NerdNumbers
//
//  Created by Trevor Griffin on 10/12/16.
//  Copyright © 2016 TREVOR E GRIFFIN. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // Make UIView item fade in
    func fadeInView(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        })
    }
    
    // Make UIView item fade out
    func fadeOutView(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        })
    }
}
