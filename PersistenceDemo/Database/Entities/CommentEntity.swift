//
//  CommentEntity.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 26/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import CoreData

final class CommentEntity: NSManagedObject {

    @NSManaged fileprivate(set) var id: Int
    @NSManaged fileprivate(set) var postId: Int
    @NSManaged fileprivate(set) var body: String
}

extension CommentEntity: CDManagable {

    func populate(with model: Comment) {
        id = model.id
        postId = model.postId
        body = model.body
    }
}

extension CommentEntity: Convertible {

    func convert() -> Comment {
        return Comment(id: id, postId: postId, body: body)
    }
}
