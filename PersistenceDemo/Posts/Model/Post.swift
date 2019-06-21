//
//  Post.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 21/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct Post: Decodable {

    let userId: Int
    let id: Int
    let title: String
    let body: String
}

extension Post: AutoEquatable { }
