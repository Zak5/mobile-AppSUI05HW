//
//  ContentView.swift
//  AppSUI05HW
//
//  Created by Konstantin Zaharev on 28.01.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        TabView {
            SearchView(searchText: $viewModel.searchText)
                .tabItem {
                    Label("Search", systemImage: "text.magnifyingglass")
                }
                .tag(0)
            SuffixView()
                .tabItem {
                    Label("Suffix", systemImage: "a.magnify")
                }
                .environmentObject(viewModel)
                .tag(1)
        }.task {
            await viewModel.getSuffixes()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
