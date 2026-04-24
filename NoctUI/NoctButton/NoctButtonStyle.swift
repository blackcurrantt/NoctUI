//
//  NoctButtonStyle.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctButtonStyle: ButtonStyle {
    @Environment(\.noctTheme) private var theme
    
    let size: NoctButtonSize
    let backgroundProvider: (NoctTheme) -> Color
    let foregroundProvider: (NoctTheme) -> Color

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: size.height)
            .foregroundColor(foregroundProvider(theme))
            .padding(.horizontal, size.padding)
            .background(backgroundProvider(theme))
            .clipShape(RoundedRectangle(cornerRadius: size.radius))
            .opacity(configuration.isPressed ? 0.85 : 1.0)
    }
}
