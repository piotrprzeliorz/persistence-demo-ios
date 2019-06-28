//
//  PostDetailsViewModel.swift
//  PersistenceDemoTests
//
//  Created by Piotr Przeliorz on 28/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import PersistenceDemo

final class PostDetailsViewModelTest: XCTestCase {

    private var viewModel: PostDetailsViewModel!
    private var authorRepository: AuthorRepositoryProtocolMock!
    private var commentsRepository: CommentsRepositoryProtocolMock!
    private var post: Post!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!

    override func setUp() {
        authorRepository = AuthorRepositoryProtocolMock()
        commentsRepository = CommentsRepositoryProtocolMock()
        post = Post(userId: 0, id: 0, title: 0.description, body: 0.description)
        viewModel = PostDetailsViewModel(post: post,
                                         authorRepository: authorRepository,
                                         commentsRepository: commentsRepository)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        authorRepository = nil
        commentsRepository = nil
        post = nil
        viewModel = nil
        disposeBag = nil
    }

    func test() {
        let comments = (0...3).map { Comment(id: $0, postId: $0, body: $0.description) }
        let author = Author(id: 0, name: "Łukasz Stanisławowski", username: "Testo")

        let refreshInput = scheduler.createHotObservable([Recorded.next(301, ())]).asObservable()

        authorRepository.fetchAuthorIdReturnValue = Observable.just((author, nil))
        commentsRepository.fetchPostIdReturnValue = Observable.just((comments, nil))

        let input = PostDetailsViewModel.Input(refresh: refreshInput)
        let output = viewModel.tranform(input: input)

        let nameObserver = scheduler.createObserver(String.self)
        let commentsCountObserver = scheduler.createObserver(String.self)

        scheduler.scheduleAt(300) {

            output.authorName.asObservable().observeOn(self.scheduler)
                .bind(to: nameObserver)
                .disposed(by: self.disposeBag)

            output.commentsCount.asObservable().observeOn(self.scheduler)
                .bind(to: commentsCountObserver)
                .disposed(by: self.disposeBag)
        }

        scheduler.start()

        let nameExpectedEvents = [Recorded.next(302, Localizable.author(author.name))]
        let commentsExpectedEvents =  [Recorded.next(302, Localizable.numberOfComments(comments.count))]

        XCTAssertEqual(nameObserver.events, nameExpectedEvents)
        XCTAssertEqual(commentsCountObserver.events, commentsExpectedEvents)
    }
}
