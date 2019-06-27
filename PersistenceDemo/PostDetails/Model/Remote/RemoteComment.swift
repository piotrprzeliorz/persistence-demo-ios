//
//  RemoteComment.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 26/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct RemoteComment: Decodable {

    let id: Int
    let postId: Int
    let body: String
}

extension RemoteComment: Convertible {

    func convert() -> Comment {
        return Comment(id: id, postId: postId, body: body)
    }
}
