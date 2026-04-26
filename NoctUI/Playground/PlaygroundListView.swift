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

// MARK: - Config

extension Playground {
    var id: String { rawValue }

    var title: String {
        switch self {
        case .button: "NoctButton"
        case .card: "NoctCard"
        }
    }

    @ViewBuilder
    var destination: some View {
        switch self {
        case .button: NoctButtonPlayground()
        case .card: NoctCardPlayground()
        }
    }
}
