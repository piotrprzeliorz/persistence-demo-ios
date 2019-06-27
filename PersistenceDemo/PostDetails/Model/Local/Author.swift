//
//  Author.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 26/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct Author {

    let id: Int
    let name: String
    let username: String
}

extension Author: AutoEquatable { }
