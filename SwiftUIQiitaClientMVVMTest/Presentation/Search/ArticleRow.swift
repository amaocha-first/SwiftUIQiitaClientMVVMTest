//
//  SearchViewRow.swift
//  SwiftUIQiitaClientMVVMTest
//
//  Created by Shota Nishizawa on 2020/04/18.
//  Copyright © 2020 Shota Nishizawa. All rights reserved.
//

import SwiftUI

struct ArticleRow: View {
    var article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    var body: some View {
        VStack {
            Text("\(article.title)")
                .padding(.trailing)
                .font(.body)
            Text("\(article.user.name)")
                .padding(.trailing)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.trailing)
    }
}

#if DEBUG
struct ArticleRow_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRow(article: Article.mockedData)
    }
}
#endif
