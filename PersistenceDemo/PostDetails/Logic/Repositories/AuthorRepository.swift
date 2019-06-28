//
//  AuthorRepository.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 26/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift

protocol AuthorRepositoryProtocol {

    func fetch(authorId id: Int) -> Observable<(author: Author, error: Error?)>

}

final class AuthorRepository: AuthorRepositoryProtocol {

    private let localDataSource: AuthorLocalDataSourceProtocol
    private let remoteDataSource: AuthorRemoteDataSourceProtocol

    init(localDataSource: AuthorLocalDataSourceProtocol, remoteDataSource: AuthorRemoteDataSourceProtocol) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }

    func fetch(authorId id: Int) -> Observable<(author: Author, error: Error?)> {
        var networkError: Error?
        return remoteDataSource.fetch(postId: id)
            .map { ($0, nil) }
            .catchError({ (error) -> Single<(Author, Error?)> in
                networkError = error
                return self.localDataSource.fetch(postId: id)
                    .map { ($0, error) }
            })
            .flatMap { self.localDataSource.save(author: $0.0) }
            .flatMap { self.localDataSource.fetch(postId: id) }
            .map { ($0, networkError) }
            .do { networkError = nil }
            .asObservable()
    }

}
