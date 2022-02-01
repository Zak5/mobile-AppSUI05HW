//
//  SearchView.swift
//  AppSUI05HW
//
//  Created by Konstantin Zaharev on 28.01.2022.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: ContentViewModel

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search", text: $viewModel.searchText)
        }
        .underlineTextField()
        .padding()
        .onSubmit {
            viewModel.search()
        }
    }
}

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(.blue)
            .padding(10)
    }
}

struct TextView_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchView()
            .environmentObject(ContentViewModel())
    }
}
