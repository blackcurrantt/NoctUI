//
//  SolarTheme.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct SolarTheme: NoctTheme {
    public init() {}

    // MARK: - Colors

    public var primary: Color { Color(hex: 0xC9A646) }

    public var secondary: Color { Color(hex: 0xF4F1EA) }

    public var card: Color { Color(hex: 0xF3EFE8) }
    
    public var border: Color { Color(hex: 0xD4AF37).opacity(0.3) }

    // MARK: - Text Colors

    public var textDefault: Color { Color(hex: 0x1C1C1E) }
    
    public var textInverse: Color { Color.white }

    public var textSubtle: Color { Color(hex: 0x6B6B6B) }

    public var textDisabled: Color { Color(hex: 0xA1A1A1) }
    
    // MARK: - Radius
    
    public var radius: NoctRadius { NoctRadius(sm: 8, md: 12, lg: 16) }
    
    // MARK: - Shapes
    
    public var buttonShape: NoctShape { .pill }
}
