//
//  PostDetailsRepository.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 26/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift

protocol PostDetailsRepositoryProtocol {

    func fetch(postId: Int, authorId: Int) -> Observable<([Comment], Author)>
    var networkError: PublishSubject<Error> { get }

}

final class PostDetailsRepository: PostDetailsRepositoryProtocol {

    private let commentsLocalDataSource: CommentsLocalDataSourceProtocol
    private let authorLocalDataSource: AuthorLocalDataSourceProtocol
    private let commentsRemoteDataSource: CommentsRemoteDataSourceProtocol
    private let authorRemoteDataSource: AuthorRemoteDataSourceProtocol

    var networkError: PublishSubject<Error> = PublishSubject<Error>()

    init(commentsLocalDataSource: CommentsLocalDataSourceProtocol, authorLocalDataSource: AuthorLocalDataSourceProtocol, commentsRemoteDataSource: CommentsRemoteDataSourceProtocol, authorRemoteDataSource: AuthorRemoteDataSourceProtocol) {
        self.commentsLocalDataSource = commentsLocalDataSource
        self.authorLocalDataSource = authorLocalDataSource
        self.commentsRemoteDataSource = commentsRemoteDataSource
        self.authorRemoteDataSource = authorRemoteDataSource
    }

    func fetch(postId: Int, authorId: Int) -> Observable<([Comment], Author)> {
        return Observable.combineLatest(fetchComments(postId: postId), fetchAuthor(authorId: authorId))
    }

    private func fetchComments(postId: Int) -> Observable<[Comment]> {
        return commentsRemoteDataSource.fetch(postId: postId)
            .catchError({ (error) -> PrimitiveSequence<SingleTrait, [Comment]> in
                self.networkError.onNext(error)
                return self.commentsLocalDataSource.fetch(postId: postId)
            })
            .flatMap { self.commentsLocalDataSource.save(comments: $0) }
            .flatMap { self.commentsLocalDataSource.fetch(postId: postId) }
            .asObservable()
    }

    private func fetchAuthor(authorId id: Int) -> Observable<Author> {
        return authorRemoteDataSource.fetch(postId: id)
            .catchError({ (error) -> PrimitiveSequence<SingleTrait, Author> in
                self.networkError.onNext(error)
                return self.authorLocalDataSource.fetch(postId: id)
            })
            .flatMap { self.authorLocalDataSource.save(author: $0) }
            .flatMap { self.authorLocalDataSource.fetch(postId: id) }
            .asObservable()
    }

}
