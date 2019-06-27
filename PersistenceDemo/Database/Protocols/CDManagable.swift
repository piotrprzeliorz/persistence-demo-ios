//
//  Managed.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 24/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import CoreData

protocol CDManagable: class, NSFetchRequestResult {

    associatedtype LocalModel

    static var name: String { get }
    static var defaultSortDescrptiors: [NSSortDescriptor] { get }

    func populate(with model: LocalModel)
}

extension CDManagable where Self: NSManagedObject {

    static var name: String {
        return entity().name!
    }
}

extension CDManagable {

    static var defaultSortDescrptiors: [NSSortDescriptor] {
        return []
    }

    static var sortedFetchRequest: NSFetchRequest<Self> {
        let request: NSFetchRequest = NSFetchRequest<Self>(entityName: name)
        request.sortDescriptors = defaultSortDescrptiors
        return request
    }
}
