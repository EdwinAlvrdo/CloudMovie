//
//  UIImage+Utilities.swift
//  CloudMovie
//
//  Created by Edwin Alvarado on 11/12/19.
//  Copyright © 2019 tbx. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadFrom(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let imgData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imgData) {
                    DispatchQueue.main.async {
                        self?.image = image
                        self?.contentMode = .scaleAspectFit
                    }
                }
            }
        }
    }
    
}
