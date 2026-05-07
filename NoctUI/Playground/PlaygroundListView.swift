//
//  PlaygroundListView.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

enum Playground: String, CaseIterable, Identifiable {
    case button
    case card
    case chip
    case textfield
    case toast
    
    var id: String { rawValue }

    var title: String {
        String(describing: self.rawValue).capitalized
    }

    @ViewBuilder
    var destination: some View {
        switch self {
        case .button: NoctButtonPlayground()
        case .card: NoctCardPlayground()
        case .chip: NoctChipPlayground()
        case .textfield: NoctTextFieldPlayground()
        case .toast: NoctToastPlayground()
        }
    }
}

// MARK: - PlaygroundListView

struct PlaygroundListView: View {
    var body: some View {
        List {
            ForEach(Playground.allCases) { pg in
                NavigationLink(pg.title) {
                    pg.destination
                        .navigationTitle(pg.title)
                        .appThemeToolbar()
                }
            }
        }
    }
}
