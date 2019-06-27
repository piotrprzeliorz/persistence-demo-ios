//
//  PostDetailsSceenRegistration.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 26/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Dip

struct PostDetailsSceenRegistration: ContainerRegistrable {

    func register(in container: DependencyContainer) {
        
        container.register { (post: Post) in
            PostDetailsViewModel(post: post, postDetailsRepository: try! container.resolve() as PostDetailsRepositoryProtocol) as PostDetailsViewModelProtocol
        }

        container.register { (post: Post) in
            PostDetailsViewController(viewModel: try! container.resolve(arguments: post) as PostDetailsViewModelProtocol)
        }
    }
}
