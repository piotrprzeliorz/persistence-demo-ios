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
        container.register { PostsViewModel(postsRepository: try! container.resolve() as PostsRepositoryProtocol) as PostsViewModelProtocol }
        
        container.register { _ -> PostsViewController in
            let viewModel = try! container.resolve() as PostsViewModelProtocol
            return PostsViewController(viewModel: viewModel)
        }
    }
}
