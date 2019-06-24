//
//  PostsRemoteDataSource.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 20/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift

protocol PostsRemoteDataSourceProtocol {

    func fetch() -> Single<[Post]>
}

final class PostsRemoteDataSource: PostsRemoteDataSourceProtocol {

    private let networking: Networking

    init(networking: Networking) {
        self.networking = networking
    }

    func fetch() -> Single<[Post]> {
        let resource = Resource<[RemotePost]>(get: .posts)
        return networking.load(resource)
            .map { posts in
                posts.map { $0.convert() }
        }
    }
}
