//
//  DependencyContainerRegistrable.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 19/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Dip

protocol DependencyContainerRegistrable {

    func register(in container: DependencyContainer)
}
