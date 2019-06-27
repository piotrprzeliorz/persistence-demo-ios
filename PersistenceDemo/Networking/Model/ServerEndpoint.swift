//
//  ServerEndpoint.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 21/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

enum ServerEndpoint {
    
    case posts
    case author(postId: Int)
    case comments(postId: Int)

    var url: URL {
        let resourcePath: String
        switch self {
        case .posts:
            resourcePath = "posts"
        case .author(let postId):
             resourcePath = "users/\(postId)"
        case .comments(let postId):
             resourcePath = "posts/\(postId)/comments"
        }
        return Constants.Server.url.appendingPathComponent(resourcePath)
    }
}
