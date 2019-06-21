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

    var url: URL {
        let resourcePath: String
        switch self {
        case .posts:
            resourcePath = "posts"
        }
        return Constants.Server.url.appendingPathComponent(resourcePath)
    }
}
