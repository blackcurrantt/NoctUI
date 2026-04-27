//
//  NoctButtonStyle.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctButtonStyle: ButtonStyle {
    @Environment(\.noctTheme) private var noctTheme
    
    let dimension: NoctButtonDimension
    let shape: NoctShape?
    var background: Color?
    var foreground: Color?
    let backgroundProvider: (NoctTheme) -> Color
    let foregroundProvider: (NoctTheme) -> Color

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .noctTextStyle(dimension.typographyStyle, weight: .semibold)
            .frame(maxWidth: .infinity)
            .frame(height: dimension.height)
            .foregroundColor(foreground ?? foregroundProvider(noctTheme))
            .padding(.horizontal, dimension.padding)
            .background(background ?? backgroundProvider(noctTheme))
            .clipShape(
                RoundedRectangle(cornerRadius: cornerRadius)
            )
            .opacity(configuration.isPressed ? 0.85 : 1.0)
    }
    
    private var cornerRadius: CGFloat {
        switch (shape ?? noctTheme.buttonShape) {
        case .standard:
            switch dimension {
            case .sm: return noctTheme.radius.sm
            case .md: return noctTheme.radius.md
            case .lg: return noctTheme.radius.lg
            }
        case .pill:
            return dimension.height / 2
        }
    }
}
