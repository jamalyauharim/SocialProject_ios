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
    
//    static func createPost(title: String, content: String, category: String) {
//        let parameters: [String :  Any] = [
//            "posts" : [
//                "author" : "something"
//            ]
//        ]
//    }
    
    
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
                    print("User authenticated = \(response)")
                case .failure(let error):
                    print("Not possible to authenticate user = \(error)")
                }
                
                let json = JSON(response.data)
                let result = json["errors"]["email or password"]
                if (result == "is invalid") {
                    completion(false)
                }
                
                completion(true)
            }
        }
    }
    
    static func queryPosts(completion: @escaping ([Post]?) -> Void){
        let completeUrl = url + "api/posts"
        var postArray: [Post] = []
        
        Alamofire.request(completeUrl, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            DispatchQueue.main.async {
                switch response.result {
                    case .success:
                    print("success")
                    case .failure(let error):
                    print("Request failed with error: \(error)")
                }
                
                let json = JSON(response.data)
                let post = Post(content: json["posts"][0]["body"].string!,
                                title: json["posts"][0]["title"].string!,
                                authorName: json["posts"][0]["author"]["first_name"].string!)
                postArray.append(post)
                
                completion(postArray)
            }
        }
    }
}
