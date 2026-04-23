//
//  NoctButtonStyle.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctButtonStyle: ButtonStyle {
    let size: NoctButtonSize
    let background: Color
    let foreground: Color

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: size.height)
            .foregroundColor(foreground)
            .padding(.horizontal, size.padding)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: size.radius))
            .opacity(configuration.isPressed ? 0.85 : 1.0)
    }
}
