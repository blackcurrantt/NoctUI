//
//  PlaygroundView.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

struct PlaygroundView<Result: View, Config: View>: View {
    @Environment(\.appTheme) private var appTheme
    @Environment(\.noctTheme) private var noctTheme
    
    private let height: CGFloat
    private let result: Result
    private let config: Config

    init(
        height: CGFloat,
        useCard: Bool = false,
        @ViewBuilder result: () -> Result,
        @ViewBuilder config: () -> Config
    ) {
        self.height = height
        self.result = result()
        self.config = config()
    }

    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                result
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
        .padding(.top, 24)
    }
}
