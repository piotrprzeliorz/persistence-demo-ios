//
//  AppDelegate.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 19/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import UIKit
import Dip

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private let container = DependencyContainer()
    private var connector: RootConnectable!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        register()
        setupRootConnector()
        return true
    }

    private func register() {
        container.add(registration: RootConnectorRegistration())
    }

    private func setupRootConnector() {
        window = UIWindow()
        guard let `window` = window else { fatalError("Window is not initialized")}
        connector = try! container.resolve(arguments: window, container) as RootConnectable
    }
}
