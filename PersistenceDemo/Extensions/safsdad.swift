//
//  safsdad.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 24/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift

extension ObservableType {

    public func unwrap<T>() -> Observable<T> where Element == T? {
        return self.compactMap { $0 }
    }
}
