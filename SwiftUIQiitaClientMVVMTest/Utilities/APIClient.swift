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
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    func body() throws -> Data?
}

extension APIClient {
    func call<T>() -> AnyPublisher<T, APIError> where T: Decodable {
        do {
            let request = try urlRequest(baseURL: baseURL)
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
    
    private func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL(description: "APIError invalid URL!")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}
