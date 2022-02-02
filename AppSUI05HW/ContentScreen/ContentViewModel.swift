//
//  ContentViewModel.swift
//  AppSUI05HW
//
//  Created by Konstantin Zaharev on 29.01.2022.
//

import SwiftUI
import WidgetKit
import Combine

@MainActor
final class ContentViewModel: ObservableObject {
    
    @Published var allSuffixes = [(String, Int)]()
    @Published var topSuffixes = [(String, Int)]()
    @Published var sortType = SortType.asc
    @Published var searchText = ""
    @Published var userText = """
All human beings are born free and equal in dignity and rights. 
They are endowed with reason and conscience and should act towards one another in a spirit of brotherhood.
"""
    
    @AppStorage("statistics", store: UserDefaults(suiteName: "group.com.zakk.AppSUI05HW"))
    var statisticsData: Data = Data()
    
    var occurrences: Int?

    private var statistics = [SearchResult]()

    private var uniqueSuffixes = [String: Int]()
    
    private var subscriptions = Set<AnyCancellable>()

    init() {
        $searchText
            .debounce(for: .microseconds(500), scheduler: DispatchQueue.main)
            .sink(receiveValue: { value in
                self.search(value)
            } )
            .store(in: &subscriptions)
    }

    func getSuffixes() async {
        let suffixArray = userText.suffixArray(minLength: 3)
        for suffix in suffixArray {
            let occurrences = uniqueSuffixes[suffix.0] ?? 0
            uniqueSuffixes[suffix.0] = occurrences + 1
        }
        topSuffixes = Array(uniqueSuffixes.sorted(by: { $0.1 > $1.1 }).prefix(10))
        await sortAllSuffixes()
    }
    
    private func search(_ value: String) {
        occurrences = uniqueSuffixes[searchText] ?? 0
        let searchResult = SearchResult(suffix: searchText, occurrences: occurrences ?? 0)
        statistics.append(searchResult)
        passDataToWidget()
    }
    
    private func passDataToWidget() {
        let lastStatistics = Array(statistics.suffix(3).reversed())
        guard let statisticsData = try? JSONEncoder().encode(lastStatistics) else { return }
        self.statisticsData = statisticsData
    }
    
    func sortAllSuffixes() async {
        if  sortType == .asc {
            allSuffixes = uniqueSuffixes.sorted(by: { $0.0 < $1.0 })
        } else {
            allSuffixes = uniqueSuffixes.sorted(by: { $0.0 > $1.0 })
        }
    }
}

enum SortType: CaseIterable {
    case asc
    case desc

    var label: String {
        get {
            switch self {
            case .asc:
                return "Ascending"
            case .desc:
                return "Descending"
            }
        }
    }
}
