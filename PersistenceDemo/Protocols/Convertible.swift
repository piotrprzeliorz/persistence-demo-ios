//
//  Convertible.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 24/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

protocol Convertible {

    associatedtype ResultType

    func convert() -> ResultType
}
