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
import SwiftyJSON

class RequestSingleton {
    private static let url: String = "http://localhost:5000/"
    private static var token: String = ""
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

        Alamofire.request(completeUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
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
    
    static func createPost(title: String, content: String) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Token " + self.token
        ]
        
        let parameters: [String :  Any] = [
            "post": [
                        "title": title,
                        "body": content
                    ]
            ]
        
        let completeUrl = url + "api/posts"
        Alamofire.request(completeUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseString { response in
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
    
    
    static func authenticateUser(email: String, password: String, completion: @escaping (Bool?) -> Void) {
        let completeUrl = url + "api/users/login"
        let parameters: [String : Any] = [
            "user" : [
                "email" : email,
                "password" : password
            ]
        ]
        
        Alamofire.request(completeUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                    print("User authenticated")
                case .failure(let error):
                    print("Not possible to authenticate user = \(error)")
                }
                
                let json = JSON(response.data)
                // Check for correct email & password
                let result = json["errors"]["email or password"]
                if (result == "is invalid") {
                    completion(false)
                } else {
                        let caughtToken = json["user"]["token"]
                        self.token = caughtToken.string!
                }
                completion(true)
            }
        }
    }
    
    static func queryPosts(completion: @escaping ([postResult.Post]?) -> Void){
        let completeUrl = url + "api/posts"
        var postArray: [postResult.Post] = []
        
        Alamofire.request(completeUrl, method: .get, encoding: JSONEncoding.default).responseData { response in
            DispatchQueue.main.async {
                switch response.result {
                    case .success:
                    print("success")
                    case .failure(let error):
                    print("Request failed with error: \(error)")
                }
                
                let parsedData = try? JSONDecoder().decode(postResult.self, from: response.data!)
            
                for data in (parsedData?.posts)! {
                    postArray.append(data)
                }

                completion(postArray)
            }
        }
    }
}
