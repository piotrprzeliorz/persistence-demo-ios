//
//  Database.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 21/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

typealias Database = ReadableDatabase & WritableDatabase

protocol ReadableDatabase {

    func loadPersistentStore(completed: @escaping () -> Void)
}

protocol WritableDatabase {

}
