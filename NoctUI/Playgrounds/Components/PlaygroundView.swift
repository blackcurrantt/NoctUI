//
//  PlaygroundView.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

struct PlaygroundView<Result: View, Config: View>: View {
    private let height: CGFloat
    private let result: Result
    private let config: Config

    init(
        height: CGFloat,
        @ViewBuilder result: () -> Result,
        @ViewBuilder config: () -> Config
    ) {
        self.height = height
        self.result = result()
        self.config = config()
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Spacer()
                result
                Spacer()
            }
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .padding()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    config
                }
                .padding()
            }
        }
    }
}
