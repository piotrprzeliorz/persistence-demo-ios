//
//  CommentRemoteDataSource.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 26/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift

protocol CommentsRemoteDataSourceProtocol: AutoMockable {

    func fetch(postId: Int) -> Single<[Comment]> 
}

final class CommentsRemoteDataSource: CommentsRemoteDataSourceProtocol {

    private let networking: Networking

    init(networking: Networking) {
        self.networking = networking
    }

    func fetch(postId: Int) -> Single<[Comment]> {
        let resource = Resource<[RemoteComment]>(get: .comments(postId: postId))
        return networking.load(resource)
            .map({ comments in
                return comments.map { $0.convert() }
            })
    }
}
