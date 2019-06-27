//
//  PostsSceenRegistration.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 19/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Dip

struct PostsSceenRegistration: ContainerRegistrable {

    private unowned let connector: PostsSceenConnectable

    init(connector: PostsSceenConnectable) {
        self.connector = connector
    }

    func register(in container: DependencyContainer) {
        
        container.register { PostsViewModel(postsRepository: try! container.resolve() as PostsRepositoryProtocol, connector: self.connector) as PostsViewModelProtocol }
        
        container.register { _ -> PostsViewController in
            let viewModel = try! container.resolve() as PostsViewModelProtocol
            return PostsViewController(viewModel: viewModel)
        }
    }
}
