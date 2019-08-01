//
//  comments.swift
//  SocialProject
//
//  Created by Jamal Yauhari on 7/31/19.
//  Copyright © 2019 Jamal Yauhari. All rights reserved.
//

import Foundation

struct commentsResult: Codable {
    var comments: [commentsResult.Info]
    
    struct Info: Codable {
        struct Author: Codable {
            var first_name: String
            var last_name: String
        }
        var id: String
        var body: String
        var author: Author
    }
}

