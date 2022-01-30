//
//  SuffixView.swift
//  AppSUI05HW
//
//  Created by Konstantin Zaharev on 28.01.2022.
//

import SwiftUI

struct SuffixView: View {
    @State private var selectedList: ListType = .all

    var body: some View {
        VStack {
            Picker("Choose suffix list type", selection: $selectedList) {
                ForEach(ListType.allCases, id: \.self) { listType in
                    Text(listType.label)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            Group{
                switch selectedList {
                case .all: SuffixAllListView()
                case .top: SuffixTopListView()
                }
            }
            
            Spacer()
        }
    }
}

private enum ListType: CaseIterable {
    case all
    case top

    var label: String {
        get {
            switch self {
            case .all:
                return "All"
            case .top:
                return "Top 10"
            }
        }
    }
}

struct SuffixAllListView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.allSuffixes, id: \.0) { suffixAndOccurrences in
                SuffixCellView(suffixAndOccurrences: suffixAndOccurrences)
            }
        }
    }
}

struct SuffixTopListView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.topSuffixes, id: \.0) { suffixAndOccurrences in
                SuffixCellView(suffixAndOccurrences: suffixAndOccurrences)
            }
        }
    }
}

struct SuffixCellView: View {
    var suffixAndOccurrences: (String, Int)
    
    var body: some View {
        Text(suffixAndOccurrences.1 == 1 ? "\(suffixAndOccurrences.0)" : "\(suffixAndOccurrences.0) - \(suffixAndOccurrences.1)")
    }
}

struct SuffixView_Previews: PreviewProvider {
    static var previews: some View {
        SuffixView()
    }
}
