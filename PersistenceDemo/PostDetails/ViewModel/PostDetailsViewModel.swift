//
//  File.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 26/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift
import RxCocoa

protocol PostDetailsViewModelProtocol {

    func tranform(input: PostDetailsViewModel.Input) -> PostDetailsViewModel.Output

}

final class PostDetailsViewModel: PostDetailsViewModelProtocol {

    struct Input {
        let refresh: Observable<Void>
    }

    struct Output {
        let body: Driver<String>
        let title: Driver<String>
        let authorName: Driver<String>
        let commentsCount: Driver<String>
        let error: Driver<Error>
    }

    private let authorRepository: AuthorRepositoryProtocol
    private let commentsRepository: CommentsRepositoryProtocol

    private let post: Post

    init(post: Post, authorRepository: AuthorRepositoryProtocol, commentsRepository: CommentsRepositoryProtocol) {
        self.post = post
        self.authorRepository = authorRepository
        self.commentsRepository = commentsRepository
    }

    func tranform(input: PostDetailsViewModel.Input) -> PostDetailsViewModel.Output {

        let authorResult = authorRepository.fetch(authorId: post.userId).share()
        let commentsResult = commentsRepository.fetch(postId: post.id).share()

        let authorName = input.refresh
        .flatMapLatest { authorResult }
        .map { $0.0.name }
        .asDriver(onErrorJustReturn: Localizable.notAvailable)

        let commentCount = input.refresh
        .flatMapLatest { commentsResult}
        .map { $0.0.count.description }
        .asDriver(onErrorJustReturn: Localizable.notAvailable)

        let error: Driver<Error> = input.refresh
        .flatMap { Observable.combineLatest(authorResult, commentsResult) }
        .map {  (author, comments) in
            return [author.1, comments.1].compactMap { $0 }
        }
        .map { $0.first}
        .unwrap()
        .asDriver(onErrorJustReturn: PersistenceDemoError.unknown)

        return Output(body: .just(post.body), title: .just(post.title), authorName: authorName, commentsCount: commentCount, error: error)
    }

}
