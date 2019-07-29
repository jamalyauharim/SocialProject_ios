//
//  CreateAccountController.swift
//  SocialProject
//
//  Created by Jamal Yauhari on 7/18/19.
//  Copyright © 2019 Jamal Yauhari. All rights reserved.
//

import UIKit

class CreateAccountController: UIViewController {
    
    // view controller components
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cPasswordTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var switchForMentor: UISwitch!
    var registerAcountForMentor: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createAccountButtonAction(_ sender: Any) {
        
        if (passwordTextField.text != cPasswordTextField.text) {
            // trigger alert: passwords do not match.
            Alert.displayAlert(on: self, with: "Passwords Error", message: "Passwords Dont Match")
            return
        }
        
        if (switchForMentor.isOn) {
            registerAcountForMentor = true
        } else {
            registerAcountForMentor = false
        }
        
        RequestSingleton.createAccount(name: nameTextField.text!,
                                       lastName: lastNameTextField.text!,
                                       email: emailTextField.text!,
                                       password: passwordTextField.text!,
                                       mentorAccount: registerAcountForMentor
                                        )
        
        print(registerAcountForMentor)
    }
    
}
