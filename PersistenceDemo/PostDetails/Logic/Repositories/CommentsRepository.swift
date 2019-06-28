//
//  CommentsRepository.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 27/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift

protocol CommentsRepositoryProtocol {
    
    func fetch(postId id: Int) -> Observable<(comments: [Comment], error: Error?)>
    
}

final class CommentsRepository: CommentsRepositoryProtocol {
    
    private let localDataSource: CommentsLocalDataSourceProtocol
    private let remoteDataSource: CommentsRemoteDataSourceProtocol
    
    init(localDataSource: CommentsLocalDataSourceProtocol, remoteDataSource: CommentsRemoteDataSourceProtocol) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
    func fetch(postId id: Int) -> Observable<(comments: [Comment], error: Error?)> {
        var networkError: Error?
        return remoteDataSource.fetch(postId: id)
            .map { ($0, nil) }
            .catchError({ (error) -> Single<([Comment], Error?)> in
                networkError = error
                return self.localDataSource.fetch(postId: id)
                    .map { ($0, error) }
            })
            .flatMap { self.localDataSource.save(comments: $0.0) }
            .flatMap { self.localDataSource.fetch(postId: id) }
            .map { ($0, networkError) }
            .do { networkError = nil }
            .asObservable()
    }
}
