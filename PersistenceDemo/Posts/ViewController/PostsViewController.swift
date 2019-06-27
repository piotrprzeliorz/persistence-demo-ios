//
//  PostsViewController.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 19/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift
import RxCocoa

final class PostsViewController: UIViewController {

    // MARK: - Constants

    private let viewModel: PostsViewModelProtocol
    private let tableView: UITableView
    private let refreshControl: UIRefreshControl

    // MARK: - Variables

    private var disposeBag = DisposeBag()

    // MARK: - VC's life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        bindReload()
        bintTableView()
        bindRefreshControl()
        bindError()
    }

    init(viewModel: PostsViewModelProtocol) {
        self.viewModel = viewModel
        self.tableView = UITableView(frame: .zero)
        self.refreshControl = UIRefreshControl()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupNavigationBar() {
        navigationItem.title = Localizable.posts
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.edges(toMarginOf: view)
        tableView.register(cell: PostTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = UIView()
        refreshControl.beginRefreshing()
    }

    // MARK: - Bindings

    private func bindRefreshControl() {
        refreshControl.rx.controlEvent(.valueChanged)
            .flatMapLatest { [unowned self] in self.viewModel.refresh() }
            .asDriver(onErrorJustReturn: false)
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
    }

    private func bindError() {
        viewModel.error
            .drive(rx.showError)
            .disposed(by: disposeBag)
    }

    private func bindReload() {
        viewModel.posts
            .map { _ in false }
            .asDriver(onErrorJustReturn: false)
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
    }

    private func bintTableView() {
        tableView.rx.modelSelected(Post.self)
            .subscribe(onNext: { [unowned self] (post) in
                self.viewModel.didSelect(post: post)
            })
            .disposed(by: disposeBag)

        viewModel.posts.drive(tableView.rx.items(cellIdentifier: PostTableViewCell.identifier, cellType: PostTableViewCell.self)) { _, post, cell in
            cell.render(post)
            }
            .disposed(by: disposeBag)
    }
}
