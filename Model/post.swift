//
//  post.swift
//  SocialProject
//
//  Created by Jamal Yauhari on 7/28/19.
//  Copyright © 2019 Jamal Yauhari. All rights reserved.
//

import Foundation

class Post {

    static let API_QUESTION_PARAMETER_KEY = "question"
    static let API_ANSWER_PARAMETER_KEY = "answer"

//    var userName: String
    var title: String
    var content: String
//    var mentor: Bool

    init(content: String, title: String) {
//        self.userName = userName
        self.title = title
        self.content = content
//        self.mentor = mentor
    }
}

