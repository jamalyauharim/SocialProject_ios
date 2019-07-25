//
//  DefaultTimeLineController.swift
//  SocialProject
//
//  Created by Jamal Yauhari on 7/18/19.
//  Copyright © 2019 Jamal Yauhari. All rights reserved.
//

import UIKit

class DefaultTimeLineController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension DefaultTimeLineController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DynamicTableViewCell.identifier, for: indexPath) as! DynamicTableViewCell
        cell.title?.text = "Title Test..."
        cell.content.isEditable = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
}
