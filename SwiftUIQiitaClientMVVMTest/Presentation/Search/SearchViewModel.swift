//
//  SearchViewModel.swift
//  SwiftUIQiitaClientMVVMTest
//
//  Created by Shota Nishizawa on 2020/04/17.
//  Copyright © 2020 Shota Nishizawa. All rights reserved.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    private var disposables = [AnyCancellable]()
    
    //input
    @Published var searchText: String = ""
    //output
    @Published var articles = []
    
    init() {
        let repo = QiitaRepositoryImpl()
        repo.fetchArticles()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (result) in
                switch result {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("eeeeeeeeeeeeeee:\(error)")
                }
            }) { (articles) in
                print("aaaaaaaaaaaaaaaaaaa:\(articles)")
        }
        .store(in: &disposables)
    }
}
