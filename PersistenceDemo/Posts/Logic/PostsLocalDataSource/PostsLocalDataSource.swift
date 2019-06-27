//
//  PostsLocalDataSource.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 21/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift
import CoreData

protocol PostsLocalDataSourceProtocol {

    func fetch() -> Single<[Post]>
    func save(posts: [Post]) -> Single<Void>

}

final class PostsLocalDataSource: PostsLocalDataSourceProtocol {

    private let database: Database

    init(database: Database) {
        self.database = database
    }

    func fetch() -> Single<[Post]> {
        let request = PostEntity.sortedFetchRequest
        return database.fetch(request)
    }

    func save(posts: [Post]) -> Single<Void> {
        return database.save(posts, as: PostEntity.self)
        .andThen(.just(()))
    }
}
