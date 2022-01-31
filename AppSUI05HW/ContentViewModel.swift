//
//  ContentViewModel.swift
//  AppSUI05HW
//
//  Created by Konstantin Zaharev on 29.01.2022.
//

import SwiftUI
import WidgetKit

@MainActor
final class ContentViewModel: ObservableObject {
    
    @Published var allSuffixes = [(String, Int)]()
    @Published var topSuffixes = [(String, Int)]()
    @Published var searchText = ""
    @Published var userText = """
All human beings are born free and equal in dignity and rights. 
They are endowed with reason and conscience and should act towards one another in a spirit of brotherhood.
"""
    
    var uniqueSuffixes: [String: Int] = [:]
    
    func getSuffixes() async {
        let suffixArray = userText.suffixArray()
        for suffix in suffixArray {
            let occurrences = uniqueSuffixes[suffix.0] ?? 0
            uniqueSuffixes[suffix.0] = occurrences + 1
        }
        allSuffixes = uniqueSuffixes.sorted(by: { $0.0 < $1.0 })
        topSuffixes = Array(uniqueSuffixes.sorted(by: { $0.1 > $1.1 }).prefix(10))
    }
}

