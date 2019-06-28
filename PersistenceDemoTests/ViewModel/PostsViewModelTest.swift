//
//  PostsViewModelTest.swift
//  PersistenceDemoTests
//
//  Created by Piotr Przeliorz on 28/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import PersistenceDemo

final class PostsViewModelTest: XCTestCase {
    
    private var viewModel: PostsViewModel!
    private var postRepository: PostsRepositoryProtocolMock!
    private var connector: PostsSceenConnectableMock!
    private var scheduler: TestScheduler!
    
    override func setUp() {
        postRepository = PostsRepositoryProtocolMock()
        connector = PostsSceenConnectableMock()
        viewModel = PostsViewModel(postsRepository: postRepository, connector: connector)
        scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDown() {
        postRepository = nil
        connector = nil
        viewModel = nil
        scheduler = nil
    }
    
    func test() {
        let posts = (0...3)
            .map { RemotePost(userId: $0, id: $0, title: $0.description, body: $0.description) }
            .map { $0.convert() }
        
        postRepository.fetchClosure = {
            return Observable.just((posts, PersistenceDemoError.noResults))
        }
        
        let refreshInput = scheduler.createHotObservable([Recorded.next(201, ())]).asObservable()
        
        let input = PostsViewModel.Input(refresh: refreshInput)
        viewModel.didSelect(post: posts[0])
        
        let output = viewModel.transform(input: input)
        
        let observer = scheduler.start { [unowned self] in
            output.posts.asObservable().observeOn(self.scheduler)
        }
        
        XCTAssertEqual(observer.events, [Recorded.next(202, posts)])
        XCTAssertEqual(1, postRepository.fetchCallsCount)
        XCTAssertEqual(connector.didSelectPostReceivedPost, posts.first)
        XCTAssert(connector.didSelectPostCalled)
    }
}
