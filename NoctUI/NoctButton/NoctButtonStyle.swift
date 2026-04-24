//
//  NoctButtonStyle.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctButtonStyle: ButtonStyle {
    @Environment(\.noctTheme) private var theme
    
    let dimension: NoctButtonDimension
    let backgroundProvider: (NoctTheme) -> Color
    let foregroundProvider: (NoctTheme) -> Color

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: dimension.height)
            .foregroundColor(foregroundProvider(theme))
            .padding(.horizontal, dimension.padding)
            .background(backgroundProvider(theme))
            .clipShape(RoundedRectangle(cornerRadius: dimension.radius))
            .opacity(configuration.isPressed ? 0.85 : 1.0)
    }
}
