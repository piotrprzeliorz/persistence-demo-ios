//
//  NSManagedObjectContext.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 24/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import CoreData
import RxSwift

extension NSManagedObjectContext {

    func insert<T: NSManagedObject>() -> T where T: CDManagable {
        guard let object = NSEntityDescription.insertNewObject(forEntityName: T.name, into: self) as? T else { fatalError("Could not cast to \(type(of: T.self))")}
        return object
    }

    func saveOrRollback(updateContextAction: @escaping (() -> Void)) -> Completable {
        return Completable.create(subscribe: { (completable) -> Disposable in
            self.perform {
                updateContextAction()
                do {
                    try self.save()
                    print("New data in DB 📄")
                     completable(.completed)
                } catch {
                    self.rollback()
                    completable(.error(error))
                }
            }
            return Disposables.create()
        })
    }
}
