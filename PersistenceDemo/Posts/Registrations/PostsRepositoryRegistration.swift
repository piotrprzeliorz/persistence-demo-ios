//
//  PostsRepositoryRegistration.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 21/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Dip

struct PostsRepositoryRegistration: ContainerRegistrable {

    func register(in container: DependencyContainer) {

        container.register { PostsLocalDataSource(database: try! container.resolve() as Database) as PostsLocalDataSourceProtocol }

        container.register { PostsRemoteDataSource(networking: try! container.resolve() as Networking) as PostsRemoteDataSourceProtocol }

        container.register {
            PostsRepository(remoteDataSource: try! container.resolve() as PostsRemoteDataSourceProtocol, localDataSource: try! container.resolve() as PostsLocalDataSourceProtocol) as PostsRepositoryProtocol
        }
    }
}
