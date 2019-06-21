//
//  Resource.swift
//  PersistenceDemo
//
//  Created by Piotr Przeliorz on 21/06/2019.
//  Copyright © 2019 Piotr Przeliorz. All rights reserved.
//

import Foundation

struct Resource<A> {
    var urlRequest: URLRequest
    let parse: (Data) -> A?
}

extension Resource where A: Decodable {

    init(get endpoint: ServerEndpoint) {
        self.urlRequest = URLRequest(url: endpoint.url)
        self.parse = { data in
            try? JSONDecoder().decode(A.self, from: data)
        }
    }
}
