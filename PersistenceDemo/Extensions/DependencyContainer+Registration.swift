//
//  sd.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 19/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Dip

extension DependencyContainer {

    func apply(registration: ContainerRegistrable) {
        registration.register(in: self)
    }
}
