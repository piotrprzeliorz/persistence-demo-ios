//
//  AppDelegate.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 19/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Dip

        import DBDebugToolkit
@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var connector: RootConnector!
    private let container = DependencyContainer()

    // MARK: - App's life cycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                DBDebugToolkit.setup()
        register()
        setupRootConnector()
        return true
    }

    // MARK: - Private

    private func register() {
        container.apply(registration: RootConnectorRegistration())
    }

    private func setupRootConnector() {
        window = UIWindow(backgroundColor: .white)
        guard let `window` = window else { fatalError("Window is not initialized")}
        connector = try! container.resolve(arguments: window, container) as RootConnector
    }
}
