//
//  PostsConnectorReigstration.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 19/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Dip

struct PostsConnectorReigstration: ContainerRegistrable {

    func register(in container: DependencyContainer) {
        container.register() { (navigationController: UINavigationController?, container: DependencyContainer) in
            PostsConnector(navigationController: navigationController, container: container) as PostsConnector
        }
    }
}
