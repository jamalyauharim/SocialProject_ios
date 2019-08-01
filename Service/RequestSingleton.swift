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

struct userInfoForEveryone {
    var name: String
    var lastName: String
    var mentor: String
}

class RequestSingleton {
    private static let url: String = "http://beenthere.ddns.net:5000/"
    private static var token: String = ""
    static var userInfo = userInfoForEveryone(name: "", lastName: "", mentor: "")
    
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
    
    static func getUserInfo(completion: @escaping (userInfoForEveryone?) -> Void) {
        let sendingInformation = userInfoForEveryone.init(name: self.userInfo.name, lastName: self.userInfo.lastName, mentor: self.userInfo.mentor)
        completion(sendingInformation)
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
                case .success(let JSON):
                    print("User authenticated \(JSON)")
                case .failure(let error):
                    print("Not possible to authenticate user = \(error)")
                }
                
                let parsedData = try? JSONDecoder().decode(userResult.self, from: response.data!)

                // Check for correct email & password
                if (parsedData == nil) {
                    completion(false)
                } else {
                    self.token = parsedData!.user.token
                    self.userInfo.name = parsedData!.user.first_name
                    self.userInfo.lastName = parsedData!.user.last_name
//                    self.userInfo.mentor = parsedData!.user.is_mentor
                }
                completion(true)
            }
        }
    }
    
    static func queryPosts(completion: @escaping ([postResult.Post]?) -> Void) {
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
    
    static func queryComments(slug: String, completion: @escaping ([commentsResult.Info]?) -> Void) {
        let completeUrl = url + "api/posts/" + slug + "/comments"
        var commentsArray: [commentsResult.Info] = []
        
        Alamofire.request(completeUrl, method: .get, encoding: JSONEncoding.default).responseData { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                    print("success")
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            
                let parsedData = try? JSONDecoder().decode(commentsResult.self, from: response.data!)

                for data in (parsedData?.comments)! {
                    commentsArray.append(data)
                }

                completion(commentsArray)
            }
        }
    }
    
    static func createComment(content: String, slug: String) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Token " + self.token
        ]
        
        let parameters: [String :  Any] = [
            "comment": [
                "body": content
            ]
        ]
        
        let completeUrl = url + "api/posts/" + slug + "/comments"
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
    
    static func deleteComment(slug: String, commentId: String) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Token " + self.token
        ]
        
        let completeUrl = url + "api/posts/" + slug + "/comments/" + commentId
        
        Alamofire.request(completeUrl, method: .delete, encoding: JSONEncoding.default, headers: headers).responseString { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                    print("success")
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }
        }
    }

}
