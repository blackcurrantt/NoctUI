//
//  NoctTypographyModifier.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public extension View {
    func noctTextStyle(_ style: NoctTypographyStyle, weight: Font.Weight? = nil) -> some View {
        modifier(NoctTypographyModifier(style: style, weight: weight))
    }
}

private struct NoctTypographyModifier: ViewModifier {
    @Environment(\.noctTypography) var typography
    
    let style: NoctTypographyStyle
    let weight: Font.Weight?

    func body(content: Content) -> some View {
        let baseFont = typography.font(for: style)

        let finalFont: Font
        if style.allowsWeightOverride, let weight {
            finalFont = baseFont.weight(weight)
        } else {
            finalFont = baseFont
        }
        
        return content
            .font(finalFont)
            .lineSpacing(typography.lineSpacing(for: style))
    }
}

extension NoctTypographyStyle {
    var allowsWeightOverride: Bool {
        switch self {
        case .title:
            return false
        case .body, .caption:
            return true
        }
    }
}
