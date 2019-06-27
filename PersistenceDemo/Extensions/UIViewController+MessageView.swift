//
//  UIViewController+Error.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 25/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import RxSwift
import RxCocoa

extension UIViewController {
    
    func presentMessageView(with message: String) {
        let messageView = MessageView(message: message)
        messageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageView)
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            messageView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            messageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            messageView.topAnchor.constraint(equalTo: guide.topAnchor)
            ])
        
        view.layoutIfNeeded()
        messageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let beginAnimator = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
            self.view.layoutIfNeeded()
        }
        
        let endAnimator = UIViewPropertyAnimator(duration: 0.1, curve: .linear) {
            messageView.alpha = 0
        }
        
        endAnimator.addCompletion { _ in
            messageView.removeFromSuperview()
            self.view.layoutSubviews()
        }
        
        beginAnimator.startAnimation()
        endAnimator.startAnimation(afterDelay: 3.0)
        view.layoutSubviews()
    }
}

extension Reactive where Base: UIViewController {
    
    var showError: AnyObserver<Error> {
        return Binder(base) { controller, error in
            guard controller.view.subviews.first(where: { $0 is MessageView }) == nil else { return }
            controller.presentMessageView(with: error.localizedDescription)
            }.asObserver()
    }
}
