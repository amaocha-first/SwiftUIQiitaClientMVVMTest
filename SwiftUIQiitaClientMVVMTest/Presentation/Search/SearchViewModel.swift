//
//  SearchViewModel.swift
//  SwiftUIQiitaClientMVVMTest
//
//  Created by Shota Nishizawa on 2020/04/17.
//  Copyright © 2020 Shota Nishizawa. All rights reserved.
//

import SwiftUI
import Combine

final class SearchViewModel: ObservableObject {
    private var disposables = [AnyCancellable]()
    
    //input
    @Published var searchText: String = ""
    //output
    @Published var articles: [Article] = []
    
    private let qiitaRepository = QiitaRepositoryImpl()
    
    init() {
        fetchArticles()
    }
    
    //初回記事一覧を取得
    private func fetchArticles() {
        qiitaRepository.fetchArticles()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (result) in
                switch result {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("error:\(error)")
                }
            }) {[weak self] (articles) in
                guard let self = self else { return }
                self.articles = articles
                
        }
        .store(in: &disposables)
    }
}
