//
//  UIView+Identifier.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 25/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import UIKit

extension UIView {

    static var identifier: String {
        return String(describing: self)
    }
}
