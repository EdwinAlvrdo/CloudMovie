//
//  SplashVC.swift
//  CloudMovie
//
//  Created by Edwin Alvarado on 11/11/19.
//  Copyright © 2019 tbx. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
    }
    
    func setupView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if UserDefaultsManager.getToken().isEmpty {
                self.performSegue(withIdentifier: "showLogin", sender: self)
            }else{
                self.performSegue(withIdentifier: "showHome", sender: self)
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "showLogin":
            _ = segue.destination as! LoginVC
            break
        case "showHome":
            _ = segue.destination as! HomeTableVC
            break
        case .none:
            break
        case .some(_):
            break
        }
    }

}
