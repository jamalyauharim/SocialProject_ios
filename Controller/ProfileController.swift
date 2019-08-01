//
//  MentorTimeLineController.swift
//  SocialProject
//
//  Created by Jamal Yauhari on 7/18/19.
//  Copyright © 2019 Jamal Yauhari. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    // components and variables.
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLastName: UILabel!
    var nameForLabel: String = ""
    var lastNameForLabel: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
        userName.text = nameForLabel
        userLastName.text = lastNameForLabel
    }
    
    
    func getUserInfo() {
        RequestSingleton.getUserInfo { (response) in
            self.nameForLabel = response?.name ?? "nothing"
            self.lastNameForLabel = response?.lastName ?? "nothing"
        }
    }
    
}
