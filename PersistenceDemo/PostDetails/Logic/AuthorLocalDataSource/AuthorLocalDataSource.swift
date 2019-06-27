//
//  AuthorLocalDataSource.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 26/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift
import CoreData

protocol AuthorLocalDataSourceProtocol {

    func fetch(postId: Int) -> Single<Author>
    func save(author: Author) -> Single<Void> 
}

final class AuthorLocalDataSource: AuthorLocalDataSourceProtocol {

    private let database: Database

    init(database: Database) {
        self.database = database
    }

    func fetch(postId: Int) -> Single<Author> {
        let request = NSFetchRequest<AuthorEntity>(entityName: AuthorEntity.name)
        request.predicate = NSPredicate(format: "\(#keyPath(AuthorEntity.id)) == %d", postId)
        request.fetchLimit = 1
        return database.load(request)
            .map({ (results)  in
                guard let author = results.first else { throw PersistenceDemoError.noData }
                return author
            })
    }

    func save(author: Author) -> Single<Void> {
        return database.save([author], as: AuthorEntity.self)
        .andThen(.just(()))
    }
}
