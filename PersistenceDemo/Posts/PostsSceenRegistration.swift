//
//  PostsSceenRegistration.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 19/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Dip

struct PostsSceenRegistration: ContainerRegistrable {

    func register(in container: DependencyContainer) {

        let viewModel = PostsViewModel()

        container.register() { _ in
            PostsViewController(viewModel: viewModel)
        }
    }
}
