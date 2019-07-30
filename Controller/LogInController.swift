//
//  LogInController.swift
//  SocialProject
//
//  Created by Jamal Yauhari on 7/18/19.
//  Copyright © 2019 Jamal Yauhari. All rights reserved.
//

import UIKit

class LogInController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func authenticationTrigger(_ sender: Any) {
        
        if (emailTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true) {
            Alert.displayAlert(on: self, with: "You are missing fields!", message: "Please insert all information required.")
            return
        }
        RequestSingleton.authenticateUser(email: emailTextField.text!, password: passwordTextField.text!)        
        performSegue(withIdentifier: "goToTimeLine", sender: self)
    }
    
}
