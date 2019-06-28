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
        bindViewModel()
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

    private func bindViewModel() {
        let refresh = refreshControl.rx.controlEvent(.valueChanged).asObservable()
        let output = viewModel.transform(input: PostsViewModel.Input(refresh: refresh))
        bindError(output.error)
        bindReload(output.posts)
        bintTableView(output.posts)
        refreshControl.sendActions(for: .valueChanged)
    }

    private func bindError(_ error: Driver<Error>) {
        error.drive(rx.showError)
            .disposed(by: disposeBag)
    }

    private func bindReload(_ posts: Driver<[Post]>) {
        posts.delay(.milliseconds(250))
            .map { _ in false }
            .asDriver(onErrorJustReturn: false)
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
    }

    private func bintTableView(_ posts: Driver<[Post]>) {
        tableView.rx.modelSelected(Post.self)
            .subscribe(onNext: { [unowned self] (post) in
                self.viewModel.didSelect(post: post)
            })
            .disposed(by: disposeBag)

        posts.drive(tableView.rx.items(cellIdentifier: PostTableViewCell.identifier, cellType: PostTableViewCell.self)) { _, post, cell in
            cell.render(post)
            }
            .disposed(by: disposeBag)
    }
}
