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
    @IBOutlet weak var bioTextField: UILabel!
    @IBOutlet weak var mentorAccountTextField: UILabel!
    var nameForLabel: String = ""
    var lastNameForLabel: String = ""
    var bio: String = "You have no bio!"
    var mentor: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
        userName.text = nameForLabel
        userLastName.text = lastNameForLabel
        bioTextField.text = bio
        if (mentor == "true") {
            mentorAccountTextField.text = "You currently are a mentor of the community!"
        } else {
            mentorAccountTextField.text = mentor
        }
        
    }
    
    
    func getUserInfo() {
        RequestSingleton.getUserInfo { (response) in
            self.nameForLabel = response?.name ?? "nothing"
            self.lastNameForLabel = response?.lastName ?? "nothing"
            self.mentor = "Not a mentor account"
        }
    }
    
}
