//
//  Result.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 24/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

enum Result<T> {
    case succcess(T)
    case failure(Error)

    var value: T? {
        switch self {
        case .succcess(let value):
            return value
        default:
            return nil
        }
    }

    var error: Error? {
        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }
}

