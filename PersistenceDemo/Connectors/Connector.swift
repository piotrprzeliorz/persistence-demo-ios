//
//  Connector.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 19/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import UIKit
import Dip

internal class Connector {

    weak var navigationController: UINavigationController?
    var childConnectors = [Connector]()
    private let container: DependencyContainer

    required init(navigationController: UINavigationController?, container: DependencyContainer) {
        self.navigationController = navigationController
        self.container = container
        setup(container: container)
    }

    func setup(container: DependencyContainer) { }
}
