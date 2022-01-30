//
//  SearchView.swift
//  AppSUI05HW
//
//  Created by Konstantin Zaharev on 28.01.2022.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search", text: $searchText)
        }
        .underlineTextField()
        .padding()
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
    @State static var searchText: String = ""
    
    static var previews: some View {
        SearchView(searchText: $searchText)
    }
}
