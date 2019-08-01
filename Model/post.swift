//
//  post.swift
//  SocialProject
//
//  Created by Jamal Yauhari on 7/28/19.
//  Copyright © 2019 Jamal Yauhari. All rights reserved.
//

import Foundation

struct postResult: Codable {
    var postsCount: Int
    var posts: [postResult.Post]
    
    struct Post: Codable {
        struct Author: Codable {
            var first_name : String
        }
        var slug : String
        var author : Author
        var title: String
        var body: String
    }
}

