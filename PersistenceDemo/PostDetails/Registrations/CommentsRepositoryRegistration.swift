//
//  CommentsRepositoryRegistration.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 27/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Dip

struct CommentsRepositoryRegistration: ContainerRegistrable {

    func register(in container: DependencyContainer) {
        
        container.register { CommentsLocalDataSource(database: try! container.resolve() as Database) as CommentsLocalDataSourceProtocol }
        
        container.register { CommentsRemoteDataSource(networking: try! container.resolve() as Networking) as CommentsRemoteDataSourceProtocol }

        container.register {
            CommentsRepository(localDataSource: try! container.resolve() as CommentsLocalDataSourceProtocol,
                               remoteDataSource: try! container.resolve() as CommentsRemoteDataSourceProtocol) as CommentsRepositoryProtocol
        }
    }
}
