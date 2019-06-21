//
//  DatabaseRegistration.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 21/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Dip
import CoreData

struct DatabaseRegistration: ContainerRegistrable {

    func register(in container: DependencyContainer) {
        container.register(.singleton) {
            CoreDataStack(container: NSPersistentContainer(name: Constants.Database.name)) as Database
        }
    }
}
