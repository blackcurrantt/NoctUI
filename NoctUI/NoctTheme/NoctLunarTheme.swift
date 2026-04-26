//
//  NoctLunarTheme.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctLunarTheme: NoctTheme {
    public init() {}
    
    // MARK: - Colors
    
    public var primary: Color { Color(hex: 0x5C75BF) }
    public var secondary: Color { Color(hex: 0x383D4D) }
    public var success: Color { Color(hex: 0x4CAF50) }
    public var warning: Color { Color(hex: 0xD9822B) }
    public var error: Color { Color(hex: 0xEF5350) }
    public var info: Color { Color(hex: 0x2F7EDB) }
    public var card: Color { Color(hex: 0x121318) }
    public var border: Color { Color.white.opacity(0.3) }

    // MARK: - Text Colors

    public var textDefault: Color { Color.white }
    public var textInverse: Color { Color.white }
    public var textSubtle: Color { Color.white.opacity(0.7) }
    public var textDisabled: Color { Color.white.opacity(0.4) }
    
    // MARK: - Radius
    
    public var radius: NoctRadius { NoctRadius(sm: 8, md: 12, lg: 16) }
    
    // MARK: - Shapes
    
    public var buttonShape: NoctShape { .standard }
}
