//
//  ContentView.swift
//  SwiftUIQiitaClientMVVMTest
//
//  Created by Shota Nishizawa on 2020/04/17.
//  Copyright © 2020 Shota Nishizawa. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    let cars = ["Subaru WRX", "Tesla Model 3", "Porsche 911", "Renault Zoe", "DeLorean"]
    @State private var searchText : String = ""
    @State private var text = ""
    
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            List {
                searchField
                ForEach(self.cars, id: \.self) { car in
                    Text(car)
                }
            }.navigationBarTitle(Text("Search Repository"))
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
