//
//  CoreDataStack.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 21/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift
import CoreData

final class CoreDataStack: Database {

    private let container: NSPersistentContainer
    private lazy var context: NSManagedObjectContext = container.viewContext
    private lazy var backgorundContext: NSManagedObjectContext = container.newBackgroundContext()

    init(container: NSPersistentContainer) {
        self.container = container
    }

    func loadPersistentStore(completed: @escaping () -> Void) {
        container.loadPersistentStores { [weak self] _, error in
            guard let self = self else { return }
            precondition(error == nil)
            completed()
            self.setup()
        }
    }

    private func setup() {
        Mirror(reflecting: self).children
            .compactMap { $0.value as? NSManagedObjectContext }
            .forEach { $0?.automaticallyMergesChangesFromParent = true }
        backgorundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    }

    func save<T: NSManagedObject & CDManagable>(_ objects: [T.LocalModel], as databaseType: T.Type) -> Single<Void> {
        let update = {
            objects.forEach { [unowned self] object in
                let cdObject: T = self.backgorundContext.insert()
                cdObject.populate(with: object)
            }
        }
        return backgorundContext.saveOrRollback(updateContextAction: update)
    }

    func load<T: NSManagedObject & CDManagable & Convertible>(_ request: NSFetchRequest<T>) -> Single<[T.ResultType]> {
        do {
            let results = try context.fetch(request)
                .map { $0.convert() }
            return .just(results)
        } catch let error {
            return .error(PersistenceDemoError(error: error))
        }
    }
}
