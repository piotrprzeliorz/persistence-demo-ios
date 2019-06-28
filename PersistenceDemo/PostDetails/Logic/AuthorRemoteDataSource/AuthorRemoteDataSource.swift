//
//  AuthorRemoteDataSource.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 26/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift

protocol AuthorRemoteDataSourceProtocol: AutoMockable {

    func fetch(postId: Int) -> Single<Author>
}

final class AuthorRemoteDataSource: AuthorRemoteDataSourceProtocol {

    let networking: Networking

    init(networking: Networking) {
        self.networking = networking
    }

    func fetch(postId: Int) -> Single<Author> {
        let resource = Resource<RemoteAuthor>(get: .author(postId: postId))
        return networking.load(resource)
            .map { $0.convert() }
    }
    
}
