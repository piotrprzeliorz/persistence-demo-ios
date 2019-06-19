//
//  RootConnector.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 19/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import UIKit
import Dip

protocol RootConnectable: class {

    init(window: UIWindow, container: DependencyContainer)

}

final class RootConnector: Connector, RootConnectable {

    convenience init(window: UIWindow, container: DependencyContainer) {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.init(navigationController: navigationController, container: container)
    }

    override func setup(container: DependencyContainer) {
        super.setup(container: container)

    }

    private func connectPosts() {

    }

}
