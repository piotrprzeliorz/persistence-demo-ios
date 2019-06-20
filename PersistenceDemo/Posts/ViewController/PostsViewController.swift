//
//  PostsViewController.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 19/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import UIKit

final class PostsViewController: UIViewController {

    private let viewModel: PostsViewModelProtocol
    private let tableView: UITableView

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        layoutTableView()
    }

    init(viewModel: PostsViewModelProtocol) {
        self.viewModel = viewModel
        self.tableView = UITableView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Localizable.posts
    }

    private func layoutTableView() {
        view.addSubview(tableView)
        tableView.edges(toMarginOf: view)
    }
}
