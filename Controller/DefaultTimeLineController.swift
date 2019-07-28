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
    
    var contentArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPosts()
    }
    
    func getPosts() {
        RequestSingleton.queryPosts { (responseArray) in
            DispatchQueue.main.async {
                guard let responseArray = responseArray else {
                    if self.isViewLoaded && self.view.window != nil {
                        
                    }
                    return
                }
                
                for response in responseArray {
                    self.contentArray.append(response)
                }
                self.tableView.reloadData()
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
        cell.title?.text = "Title Test..."
        cell.content.isEditable = false
        cell.content.text = contentArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
}
