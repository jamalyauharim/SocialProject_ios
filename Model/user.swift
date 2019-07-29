//
//  user.swift
//  SocialProject
//
//  Created by Jamal Yauhari on 7/29/19.
//  Copyright © 2019 Jamal Yauhari. All rights reserved.
//

import Foundation

import Foundation

class Model {
    
    var name: String
    var lastName: String
    var email: String
    var password: String
    var mentor: Bool
    
    init(name: String, lastName: String, email: String, password: String, mentor: Bool) {
        self.name = name
        self.lastName = lastName
        self.email = email
        self.password = password
        self.mentor = mentor
    }
}
