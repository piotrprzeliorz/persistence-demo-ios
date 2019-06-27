//
//  UITableView+Register.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 25/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import UIKit

extension UITableView {

    func register(cell: UITableViewCell.Type) {
        register(UINib(nibName: cell.identifier, bundle: nil), forCellReuseIdentifier: cell.identifier)
    }
}
