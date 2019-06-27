//
//  PostsRepository.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 20/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift
import RxCocoa

protocol PostsRepositoryProtocol {

    func fetch() -> Observable<[Post]>
    var networkError: PublishSubject<Error> { get }
}

final class PostsRepository: PostsRepositoryProtocol {

    private let remoteDataSource: PostsRemoteDataSourceProtocol
    private let localDataSource: PostsLocalDataSourceProtocol

    let networkError: PublishSubject<Error> = PublishSubject()

    init(remoteDataSource: PostsRemoteDataSourceProtocol, localDataSource: PostsLocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }

    func fetch() -> Observable<[Post]> {
        let postsDataSource = localDataSource
        return remoteDataSource.fetch()
            .catchError { self.handleNetworkError(with: $0) }
            .flatMap { postsDataSource.save(posts: $0) }
            .flatMap { postsDataSource.fetch() }
            .asObservable()
    }

    private func handleNetworkError(with error: Error) -> Single<[Post]> {
        networkError.onNext(error)
        return localDataSource.fetch()
    }
}
