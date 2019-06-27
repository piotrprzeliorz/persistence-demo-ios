//
//  AuthorRemote.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 26/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct RemoteAuthor: Decodable {

    let id: Int
    let name: String
    let username: String
}

extension RemoteAuthor: Convertible {

    func convert() -> Author {
        return Author(id: id, name: name, username: username)
    }
}
