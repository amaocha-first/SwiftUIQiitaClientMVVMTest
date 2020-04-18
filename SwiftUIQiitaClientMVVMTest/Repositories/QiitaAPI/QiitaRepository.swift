//
//  QiitaRepository.swift
//  SwiftUIQiitaClientMVVMTest
//
//  Created by Shota Nishizawa on 2020/04/17.
//  Copyright © 2020 Shota Nishizawa. All rights reserved.
//

import Foundation
import Combine

protocol QiitaRepository: APIClient {
    func fetchArticles() -> AnyPublisher<[Article], APIError>
    func fetchArticleDetail(article: Article) -> AnyPublisher<Article, APIError>
}

//MARK: - Impl
struct QiitaRepositoryImpl: QiitaRepository {
    
    let session: URLSession = .shared
    let baseURL: String = "https://qiita.com/api/v2"
    
    func fetchArticles() -> AnyPublisher<[Article], APIError> {
        return call(endPoint: API.allArticles)
    }
    
    func fetchArticleDetail(article: Article) -> AnyPublisher<Article, APIError> {
        return call(endPoint: API.articleDetails(article))
    }
}

//MARK: - Set API Parameters
extension QiitaRepositoryImpl {
    enum API {
        case allArticles
        case articleDetails(Article)
    }
}

extension QiitaRepositoryImpl.API: APICall {
    var path: String {
        switch self {
        case .allArticles:
            return "/items"
        case let .articleDetails(article):
            return "/items/:\(article.id)"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .allArticles, .articleDetails:
            return .GET
        }
    }
    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
    func body() throws -> Data? {
        return nil
    }
}
