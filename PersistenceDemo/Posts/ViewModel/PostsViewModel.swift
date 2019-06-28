//
//  PostsViewModel.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 19/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift
import RxCocoa

protocol PostsSceenConnectable: class {

    func didSelectPost(_ post: Post)
}

protocol PostsViewModelProtocol {

    func transform(input: PostsViewModel.Input) -> PostsViewModel.Output
    func didSelect(post: Post)
}

final class PostsViewModel: PostsViewModelProtocol {

    struct Input {
        let refresh: Observable<Void>
    }

    struct Output {
        let posts: Driver<[Post]>
        let error: Driver<Error>
    }

    private unowned let connector: PostsSceenConnectable
    private let postsRepository: PostsRepositoryProtocol

    init(postsRepository: PostsRepositoryProtocol, connector: PostsSceenConnectable) {
        self.connector = connector
        self.postsRepository = postsRepository
    }

    func transform(input: PostsViewModel.Input) -> PostsViewModel.Output {
        let results = postsRepository.fetch().share()

        let errorInput = input.refresh
            .flatMapLatest { results }
            .map { $0.error }
            .unwrap()
            .asDriver(onErrorJustReturn: PersistenceDemoError.unknown)

        let postsInput = input.refresh
            .flatMapLatest { results }
            .map { $0.posts }
            .asDriver(onErrorJustReturn: [])

        return Output(posts: postsInput, error: errorInput)
    }

    func didSelect(post: Post) {
        connector.didSelectPost(post)
    }

}
