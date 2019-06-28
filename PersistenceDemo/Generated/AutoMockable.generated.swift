// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif
import RxSwift














class AuthorLocalDataSourceProtocolMock: AuthorLocalDataSourceProtocol {

    //MARK: - fetch

    var fetchPostIdCallsCount = 0
    var fetchPostIdCalled: Bool {
        return fetchPostIdCallsCount > 0
    }
    var fetchPostIdReceivedPostId: Int?
    var fetchPostIdReceivedInvocations: [Int] = []
    var fetchPostIdReturnValue: Single<Author>!
    var fetchPostIdClosure: ((Int) -> Single<Author>)?

    func fetch(postId: Int) -> Single<Author> {
        fetchPostIdCallsCount += 1
        fetchPostIdReceivedPostId = postId
        fetchPostIdReceivedInvocations.append(postId)
        return fetchPostIdClosure.map({ $0(postId) }) ?? fetchPostIdReturnValue
    }

    //MARK: - save

    var saveAuthorCallsCount = 0
    var saveAuthorCalled: Bool {
        return saveAuthorCallsCount > 0
    }
    var saveAuthorReceivedAuthor: Author?
    var saveAuthorReceivedInvocations: [Author] = []
    var saveAuthorReturnValue: Single<Void>!
    var saveAuthorClosure: ((Author) -> Single<Void>)?

    func save(author: Author) -> Single<Void> {
        saveAuthorCallsCount += 1
        saveAuthorReceivedAuthor = author
        saveAuthorReceivedInvocations.append(author)
        return saveAuthorClosure.map({ $0(author) }) ?? saveAuthorReturnValue
    }

}
class AuthorRemoteDataSourceProtocolMock: AuthorRemoteDataSourceProtocol {

    //MARK: - fetch

    var fetchPostIdCallsCount = 0
    var fetchPostIdCalled: Bool {
        return fetchPostIdCallsCount > 0
    }
    var fetchPostIdReceivedPostId: Int?
    var fetchPostIdReceivedInvocations: [Int] = []
    var fetchPostIdReturnValue: Single<Author>!
    var fetchPostIdClosure: ((Int) -> Single<Author>)?

    func fetch(postId: Int) -> Single<Author> {
        fetchPostIdCallsCount += 1
        fetchPostIdReceivedPostId = postId
        fetchPostIdReceivedInvocations.append(postId)
        return fetchPostIdClosure.map({ $0(postId) }) ?? fetchPostIdReturnValue
    }

}
class AuthorRepositoryProtocolMock: AuthorRepositoryProtocol {

    //MARK: - fetch

    var fetchAuthorIdCallsCount = 0
    var fetchAuthorIdCalled: Bool {
        return fetchAuthorIdCallsCount > 0
    }
    var fetchAuthorIdReceivedId: Int?
    var fetchAuthorIdReceivedInvocations: [Int] = []
    var fetchAuthorIdReturnValue: Observable<(author: Author, error: Error?)>!
    var fetchAuthorIdClosure: ((Int) -> Observable<(author: Author, error: Error?)>)?

    func fetch(authorId id: Int) -> Observable<(author: Author, error: Error?)> {
        fetchAuthorIdCallsCount += 1
        fetchAuthorIdReceivedId = id
        fetchAuthorIdReceivedInvocations.append(id)
        return fetchAuthorIdClosure.map({ $0(id) }) ?? fetchAuthorIdReturnValue
    }

}
class CommentsLocalDataSourceProtocolMock: CommentsLocalDataSourceProtocol {

    //MARK: - fetch

    var fetchPostIdCallsCount = 0
    var fetchPostIdCalled: Bool {
        return fetchPostIdCallsCount > 0
    }
    var fetchPostIdReceivedPostId: Int?
    var fetchPostIdReceivedInvocations: [Int] = []
    var fetchPostIdReturnValue: Single<[Comment]>!
    var fetchPostIdClosure: ((Int) -> Single<[Comment]>)?

    func fetch(postId: Int) -> Single<[Comment]> {
        fetchPostIdCallsCount += 1
        fetchPostIdReceivedPostId = postId
        fetchPostIdReceivedInvocations.append(postId)
        return fetchPostIdClosure.map({ $0(postId) }) ?? fetchPostIdReturnValue
    }

    //MARK: - save

    var saveCommentsCallsCount = 0
    var saveCommentsCalled: Bool {
        return saveCommentsCallsCount > 0
    }
    var saveCommentsReceivedComments: [Comment]?
    var saveCommentsReceivedInvocations: [[Comment]] = []
    var saveCommentsReturnValue: Single<Void>!
    var saveCommentsClosure: (([Comment]) -> Single<Void>)?

    func save(comments: [Comment]) -> Single<Void> {
        saveCommentsCallsCount += 1
        saveCommentsReceivedComments = comments
        saveCommentsReceivedInvocations.append(comments)
        return saveCommentsClosure.map({ $0(comments) }) ?? saveCommentsReturnValue
    }

}
class CommentsRemoteDataSourceProtocolMock: CommentsRemoteDataSourceProtocol {

    //MARK: - fetch

    var fetchPostIdCallsCount = 0
    var fetchPostIdCalled: Bool {
        return fetchPostIdCallsCount > 0
    }
    var fetchPostIdReceivedPostId: Int?
    var fetchPostIdReceivedInvocations: [Int] = []
    var fetchPostIdReturnValue: Single<[Comment]>!
    var fetchPostIdClosure: ((Int) -> Single<[Comment]>)?

    func fetch(postId: Int) -> Single<[Comment]> {
        fetchPostIdCallsCount += 1
        fetchPostIdReceivedPostId = postId
        fetchPostIdReceivedInvocations.append(postId)
        return fetchPostIdClosure.map({ $0(postId) }) ?? fetchPostIdReturnValue
    }

}
class CommentsRepositoryProtocolMock: CommentsRepositoryProtocol {

    //MARK: - fetch

    var fetchPostIdCallsCount = 0
    var fetchPostIdCalled: Bool {
        return fetchPostIdCallsCount > 0
    }
    var fetchPostIdReceivedId: Int?
    var fetchPostIdReceivedInvocations: [Int] = []
    var fetchPostIdReturnValue: Observable<(comments: [Comment], error: Error?)>!
    var fetchPostIdClosure: ((Int) -> Observable<(comments: [Comment], error: Error?)>)?

    func fetch(postId id: Int) -> Observable<(comments: [Comment], error: Error?)> {
        fetchPostIdCallsCount += 1
        fetchPostIdReceivedId = id
        fetchPostIdReceivedInvocations.append(id)
        return fetchPostIdClosure.map({ $0(id) }) ?? fetchPostIdReturnValue
    }

}
class PostsLocalDataSourceProtocolMock: PostsLocalDataSourceProtocol {

    //MARK: - fetch

    var fetchCallsCount = 0
    var fetchCalled: Bool {
        return fetchCallsCount > 0
    }
    var fetchReturnValue: Single<[Post]>!
    var fetchClosure: (() -> Single<[Post]>)?

    func fetch() -> Single<[Post]> {
        fetchCallsCount += 1
        return fetchClosure.map({ $0() }) ?? fetchReturnValue
    }

    //MARK: - save

    var savePostsCallsCount = 0
    var savePostsCalled: Bool {
        return savePostsCallsCount > 0
    }
    var savePostsReceivedPosts: [Post]?
    var savePostsReceivedInvocations: [[Post]] = []
    var savePostsReturnValue: Single<Void>!
    var savePostsClosure: (([Post]) -> Single<Void>)?

    func save(posts: [Post]) -> Single<Void> {
        savePostsCallsCount += 1
        savePostsReceivedPosts = posts
        savePostsReceivedInvocations.append(posts)
        return savePostsClosure.map({ $0(posts) }) ?? savePostsReturnValue
    }

}
class PostsRemoteDataSourceProtocolMock: PostsRemoteDataSourceProtocol {

    //MARK: - fetch

    var fetchCallsCount = 0
    var fetchCalled: Bool {
        return fetchCallsCount > 0
    }
    var fetchReturnValue: Single<[Post]>!
    var fetchClosure: (() -> Single<[Post]>)?

    func fetch() -> Single<[Post]> {
        fetchCallsCount += 1
        return fetchClosure.map({ $0() }) ?? fetchReturnValue
    }

}
class PostsRepositoryProtocolMock: PostsRepositoryProtocol {

    //MARK: - fetch

    var fetchCallsCount = 0
    var fetchCalled: Bool {
        return fetchCallsCount > 0
    }
    var fetchReturnValue: Observable<(posts: [Post], error: Error?)>!
    var fetchClosure: (() -> Observable<(posts: [Post], error: Error?)>)?

    func fetch() -> Observable<(posts: [Post], error: Error?)> {
        fetchCallsCount += 1
        return fetchClosure.map({ $0() }) ?? fetchReturnValue
    }

}
class PostsSceenConnectableMock: PostsSceenConnectable {

    //MARK: - didSelectPost

    var didSelectPostCallsCount = 0
    var didSelectPostCalled: Bool {
        return didSelectPostCallsCount > 0
    }
    var didSelectPostReceivedPost: Post?
    var didSelectPostReceivedInvocations: [Post] = []
    var didSelectPostClosure: ((Post) -> Void)?

    func didSelectPost(_ post: Post) {
        didSelectPostCallsCount += 1
        didSelectPostReceivedPost = post
        didSelectPostReceivedInvocations.append(post)
        didSelectPostClosure?(post)
    }

}
