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
    let backgroundProvider: (NoctTheme) -> Color
    let foregroundProvider: (NoctTheme) -> Color

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: dimension.height)
            .foregroundColor(foregroundProvider(noctTheme))
            .padding(.horizontal, dimension.padding)
            .background(backgroundProvider(noctTheme))
            .clipShape(RoundedRectangle(cornerRadius: dimension.radius))
            .opacity(configuration.isPressed ? 0.85 : 1.0)
    }
}
