//
//  DynamicTableViewCell.swift
//  SocialProject
//
//  Created by Jamal Yauhari on 7/18/19.
//  Copyright © 2019 Jamal Yauhari. All rights reserved.
//

import UIKit

class DynamicTableViewCell: UITableViewCell {
    static let identifier: String = "PostCell"
    
    // components of cell
    @IBOutlet weak var title: UILabel?
    @IBOutlet weak var content: UITextView!
    
}
