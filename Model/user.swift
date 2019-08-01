//
//  user.swift
//  SocialProject
//
//  Created by Jamal Yauhari on 7/29/19.
//  Copyright © 2019 Jamal Yauhari. All rights reserved.
//

import Foundation

struct userResult: Codable {
    var user: userResult.Info
    struct Info: Codable {
        var email: String
        var token: String
        var first_name: String
        var last_name: String
//        var is_mentor: String
    }
}
