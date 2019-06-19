//
//  RootConnectorRegistration.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 19/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Dip

struct RootConnectorRegistration: DependencyContainerRegistrable {

    func register(in container: DependencyContainer) {
        container.register(.weakSingleton) { (window: UIWindow, container: DependencyContainer) in
            RootConnector(window: window, container: container) as RootConnectable
        }
    }
}

