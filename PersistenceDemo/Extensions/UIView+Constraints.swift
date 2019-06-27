//
//  UIView+Constraints.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 20/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import UIKit

extension UIView {
    
    func edges(toMarginOf otherView: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: otherView.topAnchor, constant: constant),
            bottomAnchor.constraint(equalTo: otherView.bottomAnchor, constant: constant),
            leftAnchor.constraint(equalTo: otherView.leftAnchor, constant: constant),
            rightAnchor.constraint(equalTo: otherView.rightAnchor, constant: constant)
            ])
    }
}
