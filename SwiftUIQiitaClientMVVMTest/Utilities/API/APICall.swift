//
//  APICall.swift
//  SwiftUIQiitaClientMVVMTest
//
//  Created by Shota Nishizawa on 2020/04/18.
//  Copyright © 2020 Shota Nishizawa. All rights reserved.
//

import Foundation

protocol APICall {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    func body() throws -> Data?
}

extension APICall {
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL(description: "APIError invalid URL!")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}
