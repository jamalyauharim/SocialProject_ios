//
//  CreatePostController.swift
//  SocialProject
//
//  Created by Jamal Yauhari on 7/20/19.
//  Copyright © 2019 Jamal Yauhari. All rights reserved.
//

import Foundation
import UIKit

class CreatePostController: UIViewController {
    
    // view controller components
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var createPostButton: UIButton!
    @IBOutlet weak var categorySelectionTextField: UITextField!
    @IBOutlet weak var postContent: UITextField!
    
    
    var selectedCategory: String = ""
    
    // categories of post
    let categories = [ "Cancer confrontation",
                      "Relationship struglles",
                      "loneliness" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCategoryPicker()
        createToolBar()
    }
    
    func createCategoryPicker() {
        let categoryPicker = UIPickerView()
        categoryPicker.delegate = self
        categorySelectionTextField.inputView = categoryPicker
    }
     
    func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(CreatePostController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        categorySelectionTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func createPost(_ sender: Any) {
        
        if (postTitle.text?.isEmpty == true || postContent.text?.isEmpty == true || categorySelectionTextField.text?.isEmpty == true)
        {
                Alert.displayAlert(on: self, with: "You are missing fields", message: "Please complete your post")
                return
        }
        
        RequestSingleton.createPost(userName: RequestSingleton.getUserId(), title: postTitle.text!, content: postContent.text!, category: categorySelectionTextField.text!)
        
        performSegue(withIdentifier: "backToMainTimeLine", sender: self)
    }

}

extension CreatePostController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
        categorySelectionTextField.text = selectedCategory
    }
}
