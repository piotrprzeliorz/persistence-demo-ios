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

    var body: Driver<String> { get }
    var title: Driver<String> { get }
    var authorName: Driver<String> { get }
    var commentsCount: Driver<String> { get }
    var error: Driver<Error> { get }
}

final class PostDetailsViewModel: PostDetailsViewModelProtocol {

    private let post: Post

    let body: Driver<String>
    let title: Driver<String>
    let authorName: Driver<String>
    let commentsCount: Driver<String>
    let error: Driver<Error>

    init(post: Post, postDetailsRepository: PostDetailsRepositoryProtocol) {

        let results = postDetailsRepository.fetch(postId: post.id, authorId: post.userId).share()

        self.post = post

        body = .just(post.body)
        title = .just(post.title)

        authorName = results.map { $0.1.name }.asDriver(onErrorJustReturn: Localizable.notAvailable)
        commentsCount = results.map { $0.0.count.description }.asDriver(onErrorJustReturn: Localizable.notAvailable)
        
        error = postDetailsRepository.networkError.asDriver(onErrorJustReturn: PersistenceDemoError.unknown)
    }

}
