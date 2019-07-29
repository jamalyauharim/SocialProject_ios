//
//  RequestSingleton.swift
//  SocialProject
//
//  Created by Jamal Yauhari on 7/24/19.
//  Copyright © 2019 Jamal Yauhari. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class RequestSingleton {
    private static let url: String = "http://localhost:5000/"
    
    static func createAccount(name: String, lastName: String, email: String, password: String, mentorAccount: Bool) {
        
        let parameters: [String : Any] = [
            "user" : [
                "email" : email,
                "password" :  password,
                "first_name" : name,
                "last_name" : lastName,
                "is_mentor" : mentorAccount
            ]
        ]
        
        let completeUrl = url + "api/users"

        Alamofire.request(completeUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                    print(response)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    static func authenticateUser(email: String, password: String) {
        let completeUrl = url + "api/users/login"
        let parameters: [String : Any] = [
            "user" : [
                "email" : email,
                "password" : password
            ]
        ]
        
        Alamofire.request(completeUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                    print("User authenticated = \(response)")
                case .failure(let error):
                    print("Not possible to authenticate user = \(error)")
                }
            }
        }
    }
    
    static func queryPosts() {
        let completeUrl = url + "api/posts"
        
        Alamofire.request(completeUrl, method: .get, encoding: JSONEncoding.default).responseString { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                    print(response)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
