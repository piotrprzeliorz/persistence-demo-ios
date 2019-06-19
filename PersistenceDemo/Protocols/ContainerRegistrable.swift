//
//  ContainerRegistrable.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 19/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Dip

protocol ContainerRegistrable {

    func register(in container: DependencyContainer)
}
