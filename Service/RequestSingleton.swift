//
//  RequestSingleton.swift
//  SocialProject
//
//  Created by Jamal Yauhari on 7/24/19.
//  Copyright © 2019 Jamal Yauhari. All rights reserved.
//

import Foundation
import UIKit
import StitchCore
import StitchCoreRemoteMongoDBService
import StitchRemoteMongoDBService

// access to dataBase components
private var stitchClient = Stitch.defaultAppClient!
private var mongoClient: RemoteMongoClient?
private var itemsCollection: RemoteMongoCollection<Document>?

class RequestSingleton {
    
    static func serviceClient() {
        mongoClient = try! stitchClient.serviceClient(
            fromFactory: remoteMongoClientFactory,
            withName: "mongodb-atlas"
        )
    }
    
    static func createAccount(name: String, lastName: String, email: String, password: String, mentorAccount: Bool) {
        
        let newAccount: Document = [
            "name" : name,
            "lastName" : lastName,
            "email" : email,
            "password" : password,
            "mentorAccount" : mentorAccount
        ]
        
        serviceClient()
        
        itemsCollection = mongoClient?.db("mobileTest").collection("users")
        
        itemsCollection?.insertOne(newAccount) { result in
            switch result {
            case .success(let result):
                print("Successfully inserted item with _id: \(result.insertedId))");
            case .failure(let error):
                print("Failed to insert item: \(error)");
            }
        }
    }
    
    static func createPost(userName: String, title: String, content: String, category: String) {
        
        let newPost: Document = [
            "user_name" : userName,
            "title" : title,
            "category" : category,
            "content" : content
        ]
        
        serviceClient()
        
        itemsCollection = mongoClient?.db("mobileTest").collection("posts")
        
        itemsCollection?.insertOne(newPost) { result in
            switch result {
            case .success(let result):
                print("Successfully inserted item with _id: \(result.insertedId))");
            case .failure(let error):
                print("Failed to insert item: \(error)");
            }
        }
    }
    
    static func getUserId() -> String {
        
        return (stitchClient.auth.currentUser?.id) ?? ""
        
    }
    
    static func queryPosts(completion: @escaping ([Post]?) -> Void) {
        
        let query : Document = ["content": ["$exists": true] as Document];
        serviceClient()
        
        itemsCollection = mongoClient?.db("mobileTest").collection("posts")
        itemsCollection?.find(query, options: nil).toArray({ results in
            
            var array: [Post] = []
            switch results {
            case .success(let results):
                print("Successfully found \(results.count) documents: ")
                results.forEach({item in
                    
                    let data = item.canonicalExtendedJSON.data(using: .utf8)
                    let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                    let dictionaryOfContent = json as? [String: Any]
                    let newPost: Post = Post(
                                                userName: dictionaryOfContent!["user_name"] as! String,
                                                title: dictionaryOfContent!["title"] as! String,
                                                content: dictionaryOfContent!["content"] as! String,
                                                mentor: false
                                            )
                    array.append(newPost)
                })
            case .failure(let error):
                print("Failed to find documents: \(error)")
            }
            completion(array)
        })
    }
}
