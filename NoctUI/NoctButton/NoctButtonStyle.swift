//
//  NoctButtonStyle.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctButtonStyle: ButtonStyle {
    @Environment(\.noctTheme) private var noctTheme
    @Environment(\.isEnabled) private var isEnabled
    
    let dimension: NoctButtonDimension
    let shape: NoctShape?
    let background: Color?
    let foreground: Color?
    let backgroundProvider: (NoctTheme) -> Color
    let foregroundProvider: (NoctTheme) -> Color
    
    public init(
        dimension: NoctButtonDimension = .md,
        shape: NoctShape? = nil,
        background: Color,
        foreground: Color
    ) {
        self.dimension = dimension
        self.shape = shape
        self.background = background
        self.foreground = foreground
        self.backgroundProvider = { $0.primary }
        self.foregroundProvider = { $0.textInverse }
    }
    
    init(
        dimension: NoctButtonDimension = .md,
        shape: NoctShape? = nil,
        backgroundProvider: @escaping (NoctTheme) -> Color,
        foregroundProvider: @escaping (NoctTheme) -> Color
    ) {
        self.dimension = dimension
        self.shape = shape
        self.background = nil
        self.foreground = nil
        self.backgroundProvider = backgroundProvider
        self.foregroundProvider = foregroundProvider
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .noctTextStyle(dimension.typographyStyle, weight: .semibold)
            .frame(maxWidth: .infinity)
            .frame(height: dimension.height)
            .foregroundColor(foregroundColor)
            .padding(.horizontal, dimension.padding)
            .background(backgroundColor)
            .clipShape(
                RoundedRectangle(cornerRadius: cornerRadius)
            )
            .opacity(configuration.isPressed ? 0.85 : 1.0)
    }
}

// MARK: - Styling

private extension NoctButtonStyle {
    var cornerRadius: CGFloat {
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
    
    var foregroundColor: Color {
        guard isEnabled else { return noctTheme.textDisabled }
        return foreground ?? foregroundProvider(noctTheme)
    }
    
    var backgroundColor: Color {
        guard isEnabled else { return noctTheme.muted }
        return background ?? backgroundProvider(noctTheme)
    }
}
