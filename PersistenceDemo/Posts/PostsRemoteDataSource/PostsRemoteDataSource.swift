//
//  PostsRemoteDataSource.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 20/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift

protocol PostsDataSource {

    func fetch() -> Single<[Post]>
}

final class PostsRemoteDataSource: PostsDataSource {

    private let networking: Networking

    init(networking: Networking) {
        self.networking = networking
    }

    func fetch() -> Single<[Post]> {
        let resource = Resource<[Post]>(get: .posts)
        return networking.load(resource)
    }
}
