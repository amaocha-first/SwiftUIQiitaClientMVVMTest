//
//  Response.swift
//  SwiftUIQiitaClientMVVMTest
//
//  Created by Shota Nishizawa on 2020/04/18.
//  Copyright © 2020 Shota Nishizawa. All rights reserved.
//

import Foundation

struct Article: Codable, Hashable, Identifiable {
    let id: String
    let title: String
    let user: User
    let body: String
    let likes_count: Int
}

struct User: Codable, Hashable {
    let id: String
    let name: String
    let followees_count: Int
    let followers_count: Int
}

#if DEBUG
extension Article {
    static let mockedData: Article = Article(id: "asdhfj;",
                                             title: "記事タイトル",
                                             user: User(id: "asdfhjkl", name: "Jhon", followees_count: 10, followers_count: 20),
                                             body: "body",
                                             likes_count: 20
    )
}
#endif
