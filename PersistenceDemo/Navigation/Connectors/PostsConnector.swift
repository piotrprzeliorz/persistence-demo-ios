//
//  PostsConnector.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 19/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Dip

protocol PostsConnectable {

}

final class PostsConnector: Connector, PostsConnectable {

    override func setup(container: DependencyContainer) {
        super.setup(container: container)
        container.apply(registration: PostsSceenRegistration())
    }

    override func start() {
        let postsViewController = try! container.resolve() as PostsViewController
        navigationController?.pushViewController(postsViewController, animated: true)
    }

}