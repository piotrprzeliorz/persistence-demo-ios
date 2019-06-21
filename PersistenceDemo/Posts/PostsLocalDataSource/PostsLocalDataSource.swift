//
//  PostsLocalDataSource.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 21/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift

final class PostsLocalDataSource: PostsDataSource {

    func fetch() -> Single<[Post]> {
        return Single.just([])
    }
}
