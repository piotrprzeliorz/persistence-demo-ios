//
//  PersistenceDemoError.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 21/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

enum PersistenceDemoError: Error {
    case unknown
    case notConnectedToInternet
    case noResults

    init(error: Error) {
        switch error {
        case let error as PersistenceDemoError:
            self = error
        case let `error` as NSError:
            if error.code == NSURLErrorNotConnectedToInternet {
                self = .notConnectedToInternet
            } else {
                fallthrough
            }
        default:
            self = .unknown
        }
    }
}

extension PersistenceDemoError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .unknown:
            return Localizable.somethingWentWrong
        case .notConnectedToInternet:
            return Localizable.noInternetConnection
        case .noResults:
            return Localizable.couldntLoadResource
        }
    }
}

extension PersistenceDemoError: AutoEquatable { }
