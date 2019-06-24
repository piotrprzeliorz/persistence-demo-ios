//
//  Networking.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 21/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift

protocol Networking {

    init(urlSession: URLSession)
    func load<T>(_ resource: Resource<T>) -> Single<T>
}

final class NetworkingService: Networking {

    private let urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    func load<T>(_ resource: Resource<T>) -> Single<T> {
        return Single.create(subscribe: { (single) -> Disposable in
            let task = self.urlSession.dataTask(with: resource.urlRequest) { data, _, error in
                if let error = error {
                    return single(.error(PersistenceDemoError(error: error)))
                } else {
                    guard let payload = data.flatMap(resource.parse) else {
                        return single(.error(PersistenceDemoError.noData))
                    }
                    return single(.success(payload))
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }).observeOn(MainScheduler.instance)
    }
}
