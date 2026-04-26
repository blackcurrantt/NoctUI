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
    private let useCard: Bool
    private let result: Result
    private let config: Config

    init(
        height: CGFloat,
        useCard: Bool = true,
        @ViewBuilder result: () -> Result,
        @ViewBuilder config: () -> Config
    ) {
        self.height = height
        self.useCard = useCard
        self.result = result()
        self.config = config()
    }

    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                if useCard {
                    NoctCard(padding: .all(24)) {
                        content
                    }
                } else {
                    content
                }
            }
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
    
    private var content: some View {
        ZStack {
            Spacer()
            result
            Spacer()
        }
        .frame(height: height)
        .frame(maxWidth: .infinity)
    }
}
