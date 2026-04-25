//
//  RootView.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationStack {
            PlaygroundListView()
                .navigationTitle("NoctUI")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RootView()
}
