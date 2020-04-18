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
    private let disposables = [AnyCancellable]()
    
    //input
    @Published var searchText: String = ""
    //output
    @Published var articles = []
    
    init() {
        let _fetchArticles = PassthroughSubject<String, Never>()
        
        $searchText
            .filter { !$0.isEmpty }
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue(label: "SearchViewModel"))
            .sink(receiveValue: { _fetchRepositories.send($0)})
            .store(in: &disposables)
        
        _fetchArticles
            .map { repositoryName -> AnyPublisher<Result<[DailyWeatherRowViewModel], WeatherError>, Never> in }
    }
}
