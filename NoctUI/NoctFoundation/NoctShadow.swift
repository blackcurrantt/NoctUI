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

// MARK: - Modifiers

struct NoctShadowModifier: ViewModifier {
    let config: NoctShadow?
    
    func body(content: Content) -> some View {
        content.shadow(
            color: config?.color ?? .clear,
            radius: config?.radius ?? 0,
            x: config?.x ?? 0,
            y: config?.y ?? 0
        )
    }
}

// MARK: - View Extensions

extension View {
    public func noctShadow(_ config: NoctShadow?) -> some View {
        modifier(NoctShadowModifier(config: config))
    }
}
