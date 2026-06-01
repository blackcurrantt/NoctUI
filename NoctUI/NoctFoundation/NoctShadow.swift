//
//  NoctShadow.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctShadow {
    public let color: Color
    public let radius: CGFloat
    public let x: CGFloat
    public let y: CGFloat

    public init(color: Color, radius: CGFloat, x: CGFloat, y: CGFloat) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }
}

// MARK: - Variants

extension NoctShadow {
    public static let card = NoctShadow(
        color: Color.black.opacity(0.08),
        radius: 8,
        x: 0,
        y: 2
    )
    
    public static let elevated = NoctShadow(
        color: Color.black.opacity(0.15),
        radius: 16,
        x: 0,
        y: 6
    )
}

// MARK: - View Extensions

extension View {
    @ViewBuilder
    public func noctShadow(_ config: NoctShadow?) -> some View {
        if let config {
            shadow(
                color: config.color,
                radius: config.radius,
                x: config.x,
                y: config.y
            )
        } else {
            self
        }
    }
}
