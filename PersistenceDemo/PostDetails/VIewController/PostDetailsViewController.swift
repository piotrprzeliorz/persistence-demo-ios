//
//  PostDetailsViewController.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 26/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift

final class PostDetailsViewController: UIViewController {

    // MARK: - Constants

    private let scrollView: UIScrollView
    private let stackView: UIStackView
    private let titleLabel: UILabel
    private let bodyLabel: UILabel
    private let authorLabel: UILabel
    private let commentsNumberLabel: UILabel
    private let activityIndicator: UIActivityIndicatorView
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
        self.activityIndicator = UIActivityIndicatorView(style: .gray)
        self.authorLabel = UILabel(frame: .zero)
        self.commentsNumberLabel = UILabel(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupScrollView()
        setupStackView()
        bindPostDetails()
        bindError()
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        activityIndicator.startAnimating()
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.edges(toMarginOf: view)
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
            $0.backgroundColor = .red
            $0.numberOfLines = 0
        }
    }

    private func bindPostDetails() {
        viewModel.title
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.body
        .drive(bodyLabel.rx.text)
        .disposed(by: disposeBag)

        viewModel.commentsCount
            .drive(commentsNumberLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.authorName
            .drive(authorLabel.rx.text)
            .disposed(by: disposeBag)
    }

    private func bindError() {
        viewModel.error
            .delay(.seconds(1))
            .drive(rx.showError)
            .disposed(by: disposeBag)
    }
}
