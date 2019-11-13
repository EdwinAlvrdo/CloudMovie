//
//  Utils.swift
//  CloudMovie
//
//  Created by Edwin Alvarado on 11/12/19.
//  Copyright © 2019 tbx. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    class View {
        static func showMessage(title: String = "", message : String) {
            
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                var alert: UIAlertController!
                if title.isEmpty {
                    alert = UIAlertController(title: message, message: "", preferredStyle: UIAlertController.Style.alert)
                }else{
                    alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
                }
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                        
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                        
                    }}))
                topController.present(alert, animated: true, completion: nil)
            }
        }
    }
}
