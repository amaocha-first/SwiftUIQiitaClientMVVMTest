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
                self.decode(pair.data)
            }
            .eraseToAnyPublisher()
        } catch {
            let apiError = error as! APIError
            return Fail(error: apiError).eraseToAnyPublisher()
        }
    }
    
    private func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, APIError> {
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .secondsSince1970

      return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
          .parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
    }
}
