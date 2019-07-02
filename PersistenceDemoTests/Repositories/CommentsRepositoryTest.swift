//
//  CommentsRepositoryTest.swift
//  PersistenceDemoTests
//
//  Created by Piotr Przeliorz on 28/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import PersistenceDemo

final class CommentsRepositoryTest: XCTestCase {

    private var repository: CommentsRepository!
    private var localDataSource: CommentsLocalDataSourceProtocolMock!
    private var remoteDataSource: CommentsRemoteDataSourceProtocolMock!
    private var scheduler: TestScheduler!

    override func setUp() {
        localDataSource = CommentsLocalDataSourceProtocolMock()
        remoteDataSource = CommentsRemoteDataSourceProtocolMock()
        repository = CommentsRepository(localDataSource: localDataSource,
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
        let comments = (0...10).map { Comment(id: $0, postId: 0, body: $0.description) }

        remoteDataSource.fetchPostIdReturnValue = .error(PersistenceDemoError.notConnectedToInternet)
        localDataSource.fetchPostIdReturnValue = Single.just(comments)
        localDataSource.saveCommentsReturnValue = .just(())

        let observer = scheduler.start { [unowned self] in
            self.repository.fetch(postId: 0).map { $0.comments }.observeOn(self.scheduler)
        }

        XCTAssertEqual(observer.events, [Recorded.next(201, comments), Recorded.completed(202)])
    }
}
