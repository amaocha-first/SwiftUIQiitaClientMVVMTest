//
//  APIError.swift
//  SwiftUIQiitaClientMVVMTest
//
//  Created by Shota Nishizawa on 2020/04/18.
//  Copyright © 2020 Shota Nishizawa. All rights reserved.
//

import Foundation

enum APIError: Swift.Error {
    case invalidURL(description: String)
    case network(description: String)
    case parsing(description: String)
}
