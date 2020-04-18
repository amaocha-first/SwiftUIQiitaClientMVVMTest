//
//  ContentView.swift
//  SwiftUIQiitaClientMVVMTest
//
//  Created by Shota Nishizawa on 2020/04/17.
//  Copyright © 2020 Shota Nishizawa. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State private var text = ""
    @ObservedObject var searchViewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            List {
                searchField
                ForEach(self.searchViewModel.articles, id: \.self) { article in
                    ArticleRow(article: article)
                }
            }.navigationBarTitle(Text("Search Qiita Articles"))
        }
    }
}

private extension SearchView {
    var searchField: some View {
        HStack(alignment: .center) {
            TextField("e.g Repository", text: $text)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
