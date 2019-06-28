//
//  Comment.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 26/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct Comment {

    let id: Int
    let postId: Int
    let body: String
}

extension Comment: AutoEquatable { }
