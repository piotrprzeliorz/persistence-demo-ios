//
//  CommentLocalDataSource.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 26/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift
import CoreData

protocol CommentsLocalDataSourceProtocol {

    func fetch(postId: Int) -> Single<[Comment]>
    func save(comments: [Comment]) -> Single<Void>
}

final class CommentsLocalDataSource: CommentsLocalDataSourceProtocol {

    private let database: Database

    init(database: Database) {
        self.database = database
    }

    func fetch(postId: Int) -> Single<[Comment]> {
        let request = CommentEntity.sortedFetchRequest
        request.predicate = NSPredicate(format: "\(#keyPath(CommentEntity.id)) == %d", postId)
        return database.fetch(request)
    }

    func save(comments: [Comment]) -> Single<Void> {
        return database.save(comments, as: CommentEntity.self)
            .andThen(.just(()))
    }
}
