//
//  MessageView.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 25/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import UIKit

final class MessageView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        return label
    }()

    init(message: String, backgorundColor: UIColor = UIColor.red.withAlphaComponent(0.7)) {
        super.init(frame: .zero)
        titleLabel.text = message
        addSubview(titleLabel)
        titleLabel.edges(toMarginOf: self)
        backgroundColor = backgorundColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
