//
//  PostsRepository.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 20/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift

protocol PostsRepositoryProtocol {

    init(remoteDataSource: PostsDataSource, localDataSource: PostsDataSource)
    func fetch() -> Single<[Post]>
}

final class PostsRepository: PostsRepositoryProtocol {

    private let remoteDataSource: PostsDataSource
    private let localDataSource: PostsDataSource

    init(remoteDataSource: PostsDataSource, localDataSource: PostsDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }


    func fetch() -> Single<[Post]> {
        return remoteDataSource.fetch()
    }

    
}
