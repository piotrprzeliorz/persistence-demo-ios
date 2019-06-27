//
//  PostDetailsRepositoryRegistration.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 26/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Dip

struct PostDetailsRepositoryRegistration: ContainerRegistrable {

    func register(in container: DependencyContainer) {

        container.register { AuthorLocalDataSource(database: try! container.resolve() as Database) as AuthorLocalDataSourceProtocol }

        container.register { AuthorRemoteDataSource(networking: try! container.resolve() as Networking) as AuthorRemoteDataSourceProtocol }

        container.register { CommentsLocalDataSource(database: try! container.resolve() as Database) as CommentsLocalDataSourceProtocol }

        container.register { CommentsRemoteDataSource(networking: try! container.resolve() as Networking) as CommentsRemoteDataSourceProtocol }

        container.register {
            PostDetailsRepository(commentsLocalDataSource: try! container.resolve() as CommentsLocalDataSourceProtocol,
                                  authorLocalDataSource: try! container.resolve() as AuthorLocalDataSourceProtocol,
                                  commentsRemoteDataSource: try! container.resolve() as CommentsRemoteDataSourceProtocol,
                                  authorRemoteDataSource: try! container.resolve() as AuthorRemoteDataSourceProtocol) as PostDetailsRepositoryProtocol
        }
    }
}
