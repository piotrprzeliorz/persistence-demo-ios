//
//  PostsViewModel.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 19/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift
import RxCocoa

protocol PostsViewModelProtocol {

    init(postsRepository: PostsRepositoryProtocol)
    var posts: Driver<[Post]> { get }
    var error: Driver<Error> { get }

}

final class PostsViewModel: PostsViewModelProtocol {

    let posts: Driver<[Post]>
    let error: Driver<Error>

    init(postsRepository: PostsRepositoryProtocol) {
        let result = postsRepository.fetch().share()
        error = result.map { $0.error }.unwrap().asDriver(onErrorJustReturn: PersistenceDemoError.unknown)
        posts = result.map { $0.value }.unwrap().asDriver(onErrorJustReturn: [])
    }

}


