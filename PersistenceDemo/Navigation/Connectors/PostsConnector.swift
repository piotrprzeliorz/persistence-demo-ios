//
//  PostsConnector.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 19/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Dip

final class PostsConnector: Connector {

    override func setup(container: DependencyContainer) {
        super.setup(container: container)
        container.apply(registration: DatabaseRegistration())
        container.apply(registration: NetworkingRegistration())
        container.apply(registration: PostsRepositoryRegistration())
        container.apply(registration: PostsSceenRegistration(connector: self))
        container.apply(registration: AuthorRepositoryRegistration())
        container.apply(registration: CommentsRepositoryRegistration())
        container.apply(registration: PostDetailsSceenRegistration())
    }

    override func start() {
        (try! container.resolve() as Database).loadPersistentStore { [weak self] in
            self?.presentPostsViewController()
        }
    }

    private func presentPostsViewController() {
        let postsViewController = try! container.resolve() as PostsViewController
        navigationController?.pushViewController(postsViewController, animated: true)
    }
}

extension PostsConnector: PostsSceenConnectable {

    func didSelectPost(_ post: Post) {
        let postsViewController = try! container.resolve(arguments: post) as PostDetailsViewController
        navigationController?.pushViewController(postsViewController, animated: true)
    }
}
