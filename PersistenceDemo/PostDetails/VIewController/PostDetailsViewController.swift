//
//  PostDetailsViewController.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 26/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift
import RxCocoa

final class PostDetailsViewController: UIViewController {

    // MARK: - Constants

    private let scrollView: UIScrollView
    private let stackView: UIStackView
    private let titleLabel: UILabel
    private let bodyLabel: UILabel
    private let authorLabel: UILabel
    private let commentsNumberLabel: UILabel
    private let refreshControl: UIRefreshControl

    private let viewModel: PostDetailsViewModelProtocol

    // MARK: - Variables

    private var disposeBag = DisposeBag()

    // MARK: - VC's life cycle

    init(viewModel: PostDetailsViewModelProtocol) {
        self.viewModel = viewModel
        self.scrollView = UIScrollView(frame: .zero)
        self.stackView = UIStackView(frame: .zero)
        self.titleLabel = UILabel(frame: .zero)
        self.bodyLabel = UILabel(frame: .zero)
        self.refreshControl = UIRefreshControl(frame: .zero)
        self.authorLabel = UILabel(frame: .zero)
        self.commentsNumberLabel = UILabel(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupStackView()
        bindViewModel()

    }

    private func bindViewModel() {
        let refresh = refreshControl.rx.controlEvent(.valueChanged).asObservable()
        let output = viewModel.tranform(input: PostDetailsViewModel.Input(refresh: refresh))
        bindError(output.error)
        bindPostDetails(body: output.body, title: output.title, authorName: output.authorName, commentsCount: output.commentsCount)
        bindRefreshing(authorName: output.authorName, commentsCount: output.commentsCount)
        refreshControl.sendActions(for: .valueChanged)
    }

    private func setupScrollView() {
        scrollView.refreshControl = refreshControl
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        refreshControl.beginRefreshing()
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 15
        stackView.distribution = .fill
        scrollView.addSubview(stackView)

        stackView.edges(toMarginOf: scrollView)

        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        [titleLabel, bodyLabel, authorLabel, commentsNumberLabel].forEach {
            stackView.addArrangedSubview($0)
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }
    }

    private func bindPostDetails(body: Driver<String>, title: Driver<String>, authorName: Driver<String>, commentsCount: Driver<String>) {
        title.drive(titleLabel.rx.text)
            .disposed(by: disposeBag)

        body.drive(bodyLabel.rx.text)
            .disposed(by: disposeBag)

        commentsCount.drive(commentsNumberLabel.rx.text)
            .disposed(by: disposeBag)

        authorName.drive(authorLabel.rx.text)
            .disposed(by: disposeBag)
    }

    private func bindRefreshing(authorName: Driver<String>, commentsCount: Driver<String>) {
        Observable.zip(authorName.asObservable(), commentsCount.asObservable())
            .map { _ in false }
            .asDriver(onErrorJustReturn: false)
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
    }

    private func bindError(_ error: Driver<Error>) {
        error.delay(.seconds(1))
            .drive(rx.showError)
            .disposed(by: disposeBag)
    }
}
