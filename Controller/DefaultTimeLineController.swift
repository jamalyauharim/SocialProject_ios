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
        getPosts()
        tableView.reloadData()
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
}
