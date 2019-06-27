//
//  AuthorEntity.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 26/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import CoreData

final class AuthorEntity: NSManagedObject {

    @NSManaged fileprivate(set) var id: Int
    @NSManaged fileprivate(set) var name: String
    @NSManaged fileprivate(set) var username: String
}

extension AuthorEntity: CDManagable {

    func populate(with model: Author) {
        id = model.id
        name = model.name
        username = model.username
    }
}

extension AuthorEntity: Convertible {

    func convert() -> Author {
        return Author(id: id, name: name, username: username)
    }
}
