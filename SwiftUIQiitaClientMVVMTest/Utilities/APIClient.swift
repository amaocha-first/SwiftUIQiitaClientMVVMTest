//
//  WebRepository.swift
//  SwiftUIQiitaClientMVVMTest
//
//  Created by Shota Nishizawa on 2020/04/17.
//  Copyright © 2020 Shota Nishizawa. All rights reserved.
//

import Foundation
import Combine

protocol APIClient {
    var session: URLSession { get }
    var baseURL: String { get }
}

extension APIClient {
    func call<T>(endPoint: APICall) -> AnyPublisher<T, APIError> where T: Decodable {
        do {
            let request = try endPoint.urlRequest(baseURL: baseURL)
            return session.dataTaskPublisher(for: request)
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
        } catch {
            let apiError = error as! APIError
            return Fail(error: apiError).eraseToAnyPublisher()
        }
    }
}
