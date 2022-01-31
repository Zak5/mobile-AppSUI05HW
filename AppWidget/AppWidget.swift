//
//  AppWidget.swift
//  AppWidget
//
//  Created by Konstantin Zaharev on 30.01.2022.
//

import WidgetKit
import SwiftUI

@main
struct AppWidget: Widget {
 
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "AppWidget",
            provider: Provider()
        ){ entry in
            EntryView(entry: entry)
        }
        .configurationDisplayName("AppSUI05HW widget")
        .description("This is an widget for AppSUI05HW.")
    }
}

struct Provider: TimelineProvider {
    
    @AppStorage("searchResult", store: UserDefaults(suiteName: "group.com.zakk.AppSUI05HW"))
    var searchResultData: Data = Data()
    
    func placeholder(in context: Context) -> SearchResultEntry {
        SearchResultEntry(searchResult: nil)
    }
        
    func getSnapshot(in context: Context, completion: @escaping (SearchResultEntry) -> Void) {
        guard let searchResult = try? JSONDecoder().decode(SearchResult.self, from: searchResultData) else { return }
        let entry = SearchResultEntry(searchResult: searchResult)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SearchResultEntry>) -> Void) {
        guard let searchResult = try? JSONDecoder().decode(SearchResult.self, from: searchResultData) else { return }
        let entry = SearchResultEntry(searchResult: searchResult)
        let timeline = Timeline(entries:[entry], policy: .never)
        completion(timeline)
    }
}

struct SearchResultEntry: TimelineEntry {
    let date: Date = Date()
    let searchResult: SearchResult?
}

struct AppWidget_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(entry: SearchResultEntry(searchResult: nil))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
