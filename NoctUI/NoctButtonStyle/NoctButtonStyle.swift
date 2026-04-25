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
        switch noctTheme.buttonShape {
        case .standard:
            return dimension.radius
        case .pill:
            return dimension.height / 2
        }
    }
}
