//
//  PostTableViewCell.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 25/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import UIKit

final class PostTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: - Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.numberOfLines = 0
        selectionStyle = .none
    }

    // MARK: - API

    func render(_ post: Post) {
        titleLabel.text = post.title
    }
}
