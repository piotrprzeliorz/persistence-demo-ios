//
//  PostsRepository.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 20/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift

protocol PostsRepositoryProtocol {

    init(remoteDataSource: PostsRemoteDataSourceProtocol, localDataSource: PostsLocalDataSourceProtocol)
    func fetch() -> Observable<Result<[Post]>>
}

final class PostsRepository: PostsRepositoryProtocol {

    private let remoteDataSource: PostsRemoteDataSourceProtocol
    private let localDataSource: PostsLocalDataSourceProtocol

    init(remoteDataSource: PostsRemoteDataSourceProtocol, localDataSource: PostsLocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }

    func fetch() -> Observable<Result<[Post]>> {
        return remoteDataSource.fetch()
            .flatMap { self.localDataSource.save(posts: $0) }
            .flatMap { self.localDataSource.fetch() }
            .map { Result.succcess($0) }
            .catchError { .just(Result.failure($0)) }
            .asObservable()
    }
}
