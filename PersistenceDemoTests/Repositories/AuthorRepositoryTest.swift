//
//  AuthorRepositoryTest.swift
//  PersistenceDemoTests
//
//  Created by Piotr Przeliorz on 28/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import PersistenceDemo

final class AuthorRepositoryTest: XCTestCase {

    private var repository: AuthorRepository!
    private var localDataSource: AuthorLocalDataSourceProtocolMock!
    private var remoteDataSource: AuthorRemoteDataSourceProtocolMock!
    private var scheduler: TestScheduler!

    override func setUp() {
        localDataSource = AuthorLocalDataSourceProtocolMock()
        remoteDataSource = AuthorRemoteDataSourceProtocolMock()
        repository = AuthorRepository(localDataSource: localDataSource,
                                      remoteDataSource: remoteDataSource)
        scheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        localDataSource = nil
        remoteDataSource = nil
        repository = nil
        scheduler = nil
    }

    func test() {
         let author = Author(id: 0, name: "Łukasz Stanisławowski", username: "Testo")
        
        remoteDataSource.fetchPostIdReturnValue = Single.error(PersistenceDemoError.noResults)
        localDataSource.fetchPostIdReturnValue = Single.just(author)
        localDataSource.saveAuthorReturnValue = Single.just(())

        let observer = scheduler.start { [unowned self] in
             self.repository.fetch(authorId: author.id).map { $0.author }.observeOn(self.scheduler)
        }

        XCTAssertEqual(observer.events, [Recorded.next(201, (author)), Recorded.completed(202)])
    }
}
