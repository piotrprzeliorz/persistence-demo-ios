//
//  NetworkingRegistration.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 21/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Dip

struct NetworkingRegistration: ContainerRegistrable {

    func register(in container: DependencyContainer) {
        container.register(.singleton) {
            NetworkingService(urlSession: URLSession.shared) as Networking
        }
    }
}
