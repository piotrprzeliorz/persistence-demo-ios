//
//  RootConnector.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 19/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Dip

final class RootConnector: Connector {

    convenience init(window: UIWindow, container: DependencyContainer) {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.init(navigationController: navigationController, container: container)
        start()
    }

    override func setup(container: DependencyContainer) {
        super.setup(container: container)
        container.apply(registration: PostsConnectorReigstration())
    }

    override func start() {
        super.start()
        childConnector = try! container.resolve(arguments: navigationController, container) as PostsConnector
        childConnector?.start()
    }
}
