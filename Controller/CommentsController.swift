//
//  CommentsController.swift
//  SocialProject
//
//  Created by Jamal Yauhari on 7/31/19.
//  Copyright © 2019 Jamal Yauhari. All rights reserved.
//

import Foundation
import UIKit

class CommentsController: UIViewController {
    var slug: String = ""
    var commentsArray: [commentsResult.Info] = []  {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postCommentButton: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getComments(slug: slug)
        commentsArray.reverse()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.commentsArray = []
    }
    
    func getComments(slug: String) {
        RequestSingleton.queryComments(slug: slug) { (responseArray) in
            guard let responseArray = responseArray else {
                return
            }
            
            for response in responseArray {
                self.commentsArray.append(response)
            }
            self.commentsArray.reverse()
        }
    }
    
    func postComment(slug: String) {
        if (commentTextField.text?.isEmpty == true) {
            
        } else {
            RequestSingleton.createComment(content: commentTextField.text!, slug: slug)
        }
    }
    
    @IBAction func postComment(_ sender: Any) {
        postComment(slug: self.slug)
        commentsArray = []
        getComments(slug: self.slug)
    }
    
   
}

extension CommentsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as! CommentTableViewCell
        cell.commentContentLabel.text =  "  " + commentsArray[indexPath.row].body
        cell.authorLabel.text = commentsArray[indexPath.row].author.first_name + " " + commentsArray[indexPath.row].author.last_name
        return cell
        
    }
    
    
}
