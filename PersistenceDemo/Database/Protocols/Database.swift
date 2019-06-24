//
//  Database.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 21/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import CoreData
import RxSwift

typealias Database = ReadableDatabase & WritableDatabase

protocol ReadableDatabase {

    func loadPersistentStore(completed: @escaping () -> Void)
    func load<T: NSManagedObject & CDManagable & Convertible>(_ request: NSFetchRequest<T>) -> Single<[T.ResultType]>
}

protocol WritableDatabase {

    func save<T: NSManagedObject & CDManagable>(_ objects: [T.LocalModel], as databaseType: T.Type) -> Single<Void>

}
