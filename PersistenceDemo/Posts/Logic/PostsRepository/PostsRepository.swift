//
//  PostsRepository.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 20/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift
import RxCocoa

protocol PostsRepositoryProtocol: AutoMockable {

    func fetch() -> Observable<(posts: [Post], error: Error?)>
}

final class PostsRepository: PostsRepositoryProtocol {

    private let remoteDataSource: PostsRemoteDataSourceProtocol
    private let localDataSource: PostsLocalDataSourceProtocol

    init(remoteDataSource: PostsRemoteDataSourceProtocol, localDataSource: PostsLocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }

    func fetch() -> Observable<(posts: [Post], error: Error?)> {
        var networkError: Error?
        let postsDataSource = localDataSource
        return remoteDataSource.fetch()
            .map { return ($0, nil) }
            .catchError({ (error) -> Single<([Post], Error?)> in
                networkError = error
                return self.localDataSource.fetch()
                    .map { return ($0, error) }
            })
            .flatMap { postsDataSource.save(posts: $0.0) }
            .flatMap { postsDataSource.fetch() }
            .map { ($0, networkError) }
            .do { networkError = nil }
            .asObservable()
    }
}
