//
//  AuthorRepository.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 26/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift

protocol AuthorRepositoryProtocol: AutoMockable {

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
        let authorlDataSource = localDataSource
        return remoteDataSource.fetch(postId: id)
            .map { ($0, nil) }
            .catchError({ (error) -> Single<(Author, Error?)> in
                networkError = error
                return authorlDataSource.fetch(postId: id)
                    .map { ($0, error) }
            })
            .flatMap { authorlDataSource.save(author: $0.0) }
            .flatMap { authorlDataSource.fetch(postId: id) }
            .map { ($0, networkError) }
            .do { networkError = nil }
            .asObservable()
    }

}
