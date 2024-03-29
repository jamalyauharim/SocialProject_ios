//
//  DefaultTimeLineController.swift
//  SocialProject
//
//  Created by Jamal Yauhari on 7/18/19.
//  Copyright © 2019 Jamal Yauhari. All rights reserved.
//

import UIKit

class DefaultTimeLineController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var contentArray: [postResult.Post] = []  {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getPosts()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.contentArray = []
    }
    
    func getPosts() {
        RequestSingleton.queryPosts { (responseArray) in
            guard let responseArray = responseArray else {
                return
            }
            for response in responseArray {
                self.contentArray.append(response)
            }
        }
    }
}

extension DefaultTimeLineController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: DynamicTableViewCell.identifier, for: indexPath) as! DynamicTableViewCell
        cell.content.isEditable = false
        cell.userNameLabel.text = "   " + contentArray[indexPath.row].author.first_name
        cell.title?.text = contentArray[indexPath.row].title
        cell.content.text = contentArray[indexPath.row].body
        cell.slug = contentArray[indexPath.row].slug
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToComments", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let commentsController = segue.destination as? CommentsController,
            let index = tableView.indexPathForSelectedRow?.row
            else {
                return
        }
        commentsController.slug = contentArray[index].slug
    }
}
