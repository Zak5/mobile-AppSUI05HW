//
//  EntryView.swift
//  AppWidgetExtension
//
//  Created by Konstantin Zaharev on 31.01.2022.
//

import SwiftUI

struct EntryView: View {
    var entry: Provider.Entry
 
    var body: some View {
        VStack {
            HStack {
                WidgetNavigationLink(destination: "widget://search-view", systemIconName: "text.magnifyingglass")
                WidgetNavigationLink(destination: "widget://suffix-view", systemIconName: "a.magnify")
             }
            if let searchResult = entry.searchResult {
                Text("\(searchResult.suffix) - \(searchResult.occurrences)")
            } else {
                Text("No results")
            }
        }
    }
}

struct WidgetNavigationLink: View {
    let destination: String
    let systemIconName: String
     
    var body: some View {
        Link(destination: URL(string: destination)!) {
            Image(systemName: systemIconName)
                .font(.system(size: 30))
                .foregroundColor(Color(UIColor.secondaryLabel))
                .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 50, height: 50)
        .background(Color(UIColor.secondarySystemFill))
        .cornerRadius(10.0)
    }
}
