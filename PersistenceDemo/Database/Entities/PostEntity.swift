//
//  Post.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 24/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import CoreData

final class PostEntity: NSManagedObject {

    @NSManaged fileprivate(set) var userId: Int
    @NSManaged fileprivate(set) var id: Int
    @NSManaged fileprivate(set) var title: String
    @NSManaged fileprivate(set) var body: String
}

extension PostEntity: CDManagable {

    func populate(with model: Post) {
        userId = model.userId
        id = model.id
        title = model.title
        body = model.body
    }

    static var defaultSortDescrptiors: [NSSortDescriptor] {
        return [NSSortDescriptor(keyPath: \PostEntity.id, ascending: false)]
    }
}

extension PostEntity: Convertible {

    func convert() -> Post {
        return Post(userId: userId, id: id, title: title, body: body)
    }
}
