//
//  PlaygroundListView.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

enum Playground: String, CaseIterable, Identifiable {
    case button
}

// MARK: - PlaygroundListView

struct PlaygroundListView: View {
    var body: some View {
        List {
            ForEach(Playground.allCases) { pg in
                NavigationLink(pg.title) {
                    pg.destination
                        .navigationTitle(pg.title)
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
        }
    }

    @ViewBuilder
    var destination: some View {
        switch self {
        case .button: NoctButtonPlayground()
        }
    }
}
