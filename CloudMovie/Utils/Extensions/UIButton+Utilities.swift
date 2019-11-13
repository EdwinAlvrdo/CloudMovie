//
//  UIButton+Utilities.swift
//  CloudMovie
//
//  Created by Edwin Alvarado on 11/12/19.
//  Copyright © 2019 tbx. All rights reserved.
//

import Foundation
import UIKit

//Just for this solution, this need to be inside a declaration of a Own Type Button
var activityIndicator: UIActivityIndicatorView!

extension UIButton {

    func showLoading() {
        self.backgroundColor = UIColor.gray
        self.isUserInteractionEnabled = false
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        showSpinning()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
        self.backgroundColor = UIColor.white
        self.isUserInteractionEnabled = true
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .lightGray
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }

}
