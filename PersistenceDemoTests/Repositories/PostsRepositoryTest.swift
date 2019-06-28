//
//  PostsRepositoryTest.swift
//  PersistenceDemoTests
//
//  Created by Piotr Przeliorz on 28/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import PersistenceDemo

final class PostsRepositoryTest: XCTestCase {

    private var repository: PostsRepository!
    private var remoteDataSource: PostsRemoteDataSourceProtocolMock!
    private var localDataSource: PostsLocalDataSourceProtocolMock!
    private var scheduler: TestScheduler!

    override func setUp() {
        remoteDataSource = PostsRemoteDataSourceProtocolMock()
        localDataSource = PostsLocalDataSourceProtocolMock()
        repository = PostsRepository(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
        scheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        remoteDataSource = nil
        localDataSource = nil
        repository = nil
        scheduler = nil
    }

    func test() {
        let posts = (0...10).map { Post(userId: $0, id: $0, title: $0.description, body: $0.description) }

        remoteDataSource.fetchReturnValue = Single.error(PersistenceDemoError.notConnectedToInternet)
        localDataSource.fetchReturnValue = Single.just(posts)
        localDataSource.savePostsReturnValue = Single.just(())

        let observer = scheduler.start { [unowned self] in
            self.repository.fetch().map { $0.posts }.observeOn(self.scheduler)
        }

        XCTAssertEqual(observer.events, [Recorded.next(201, (posts)), Recorded.completed(202)])
    }

}
