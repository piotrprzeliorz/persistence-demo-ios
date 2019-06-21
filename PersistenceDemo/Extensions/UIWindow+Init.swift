//
//  UIWindow+Init.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 19/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import UIKit

extension UIWindow {

    convenience init(backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
    }
}
