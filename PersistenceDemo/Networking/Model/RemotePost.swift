//
//  RemotePost.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 24/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct RemotePost: Decodable {

    let userId: Int
    let id: Int
    let title: String
    let body: String
}

extension RemotePost: Convertible {

    func convert() -> Post {
        return Post(userId: userId, id: id, title: title, body: body)
    }
}
