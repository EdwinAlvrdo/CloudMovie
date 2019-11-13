//
//  LoginVC.swift
//  CloudMovie
//
//  Created by Edwin Alvarado on 11/11/19.
//  Copyright © 2019 tbx. All rights reserved.
//

import UIKit
import Moya

class LoginVC: UIViewController {

    @IBOutlet weak var txtFieldAuthKey: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    let authProvider = MoyaProvider<AuthService>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.txtFieldAuthKey.delegate = self
    }
    
    @IBAction func goLogin(_ sender: UIButton) {
        sender.showLoading()
        
        let authKey: String = txtFieldAuthKey.text ?? ""
        
        guard !authKey.isEmpty else {
            Utils.View.showMessage(title: "Hey!", message: "El key no puede estar vacío.")
            sender.hideLoading()
            return
        }
        
        authProvider.request(.login(authKey)) { (moyaResult) in
            let result: Endpoints.internalResponse = Endpoints.proccessResult(result: moyaResult)
            sender.hideLoading()
            
            switch result {
            case .success(let response):
                let responseLogin = try! JSONDecoder().decode(ResponseAuth.self, from: response.data)
                if let token = responseLogin.token, let type = responseLogin.type { //Just check if has token and type
                    UserDefaultsManager.saveToken(token)
                    UserDefaultsManager.saveTypeAuth(type)
                    self.performSegue(withIdentifier: "showHome", sender: self)
                }
            case .error(let response):
                break
            case .logout:
                Utils.View.showMessage(title: "Error", message: "No estas autorizado, para ingresar")
                break
            case .failure:
                break
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
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

extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        goLogin(btnLogin)
        txtFieldAuthKey.resignFirstResponder()
        return true
    }
    
}
