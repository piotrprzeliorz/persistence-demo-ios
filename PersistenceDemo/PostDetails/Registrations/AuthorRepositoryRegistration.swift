//
//  AuthorRepositoryRegistration.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 26/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Dip

struct AuthorRepositoryRegistration: ContainerRegistrable {

    func register(in container: DependencyContainer) {

        container.register { AuthorLocalDataSource(database: try! container.resolve() as Database) as AuthorLocalDataSourceProtocol }

        container.register { AuthorRemoteDataSource(networking: try! container.resolve() as Networking) as AuthorRemoteDataSourceProtocol }

        container.register {
            AuthorRepository(localDataSource: try! container.resolve() as AuthorLocalDataSourceProtocol,
                             remoteDataSource: try! container.resolve() as AuthorRemoteDataSourceProtocol) as AuthorRepositoryProtocol
        }
    }
}
