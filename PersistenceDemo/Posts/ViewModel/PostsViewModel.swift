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

    var posts: Driver<[Post]> { get }
    var error: Driver<Error> { get }
    
    func refresh() -> Observable<Bool>
    func didSelect(post: Post)
}

final class PostsViewModel: PostsViewModelProtocol {

    let posts: Driver<[Post]>
    let error: Driver<Error>

    private let results: Observable<[Post]>
    private unowned let connector: PostsSceenConnectable

    init(postsRepository: PostsRepositoryProtocol, connector: PostsSceenConnectable) {
        self.connector = connector
        results = postsRepository.fetch().share()
        error = postsRepository.networkError.asDriver(onErrorJustReturn: PersistenceDemoError.unknown)
        posts = results.asDriver(onErrorJustReturn: [])
    }

    func refresh() -> Observable<Bool> {
        return results
            .map { _ in false }
    }

    func didSelect(post: Post) {
        connector.didSelectPost(post)
    }

}
