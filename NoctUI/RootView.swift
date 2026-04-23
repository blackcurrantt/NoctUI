//
//  RootView.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

enum Playground: String, CaseIterable, Identifiable {
    case button

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

struct RootView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(Playground.allCases) { pg in
                    NavigationLink(pg.title) {
                        pg.destination
                            .navigationTitle(pg.title)
                    }
                }
            }
            .navigationTitle("NoctUI")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RootView()
}
