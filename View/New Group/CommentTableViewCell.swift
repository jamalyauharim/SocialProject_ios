//
//  CommentTableViewCell.swift
//  SocialProject
//
//  Created by Jamal Yauhari on 7/31/19.
//  Copyright © 2019 Jamal Yauhari. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    static let identifier: String = "CommentCell"
    var postSlug: String = ""
    var commentId: String = ""
    @IBOutlet weak var commentContentLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var deleteCommentButton: UIButton!
    weak var delegate: CommentTableViewCell?

    
    @IBAction func deleteComment(_ sender: Any) {
        RequestSingleton.deleteComment(slug: postSlug, commentId: commentId)
    }
}
