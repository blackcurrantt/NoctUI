//
//  NoctButtonStyle.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctButtonStyle: ButtonStyle {
    @Environment(\.noctTheme) private var noctTheme
    @Environment(\.noctTypography) private var noctTypography
    
    let dimension: NoctButtonDimension
    let shape: NoctShape?
    let backgroundProvider: (NoctTheme) -> Color
    let foregroundProvider: (NoctTheme) -> Color

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(noctTypography.font(for: dimension.typographyStyle).weight(.semibold))
            .frame(maxWidth: .infinity)
            .frame(height: dimension.height)
            .foregroundColor(foregroundProvider(noctTheme))
            .padding(.horizontal, dimension.padding)
            .background(backgroundProvider(noctTheme))
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
