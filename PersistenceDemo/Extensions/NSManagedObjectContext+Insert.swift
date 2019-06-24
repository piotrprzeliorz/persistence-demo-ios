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
        guard let object = NSEntityDescription.insertNewObject(forEntityName: T.entityName, into: self) as? T else { fatalError("Could not cast to \(type(of: T.self))")}
        return object
    }

    func saveOrRollback(updateContextAction: @escaping (() -> Void)) -> Single<Void> {
        return Single.create(subscribe: { (single) -> Disposable in
            self.perform {
                updateContextAction()
                do {
                    try self.save()
                    print("ZAPISANOO!!!!")
                     single(.success(()))
                } catch {
                    self.rollback()
                    single(.error(error))
                }
            }
            return Disposables.create()
        })
    }
}
