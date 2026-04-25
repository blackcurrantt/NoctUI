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

    // #C9A646 — erdtree gold
    public var primary: Color { Color(hex: 0xC9A646) }

    // #F4F1EA — warm light surface
    public var secondary: Color { Color(hex: 0xF4F1EA) }

    // #FAF8F4 — soft parchment background
    public var card: Color { Color(hex: 0xFAF8F4) }

    // MARK: - Text Colors

    // #1C1C1E — near black (slightly warm)
    public var textDefault: Color { Color(hex: 0x1C1C1E) }
    
    public var textInverse: Color { Color.white }

    // #6B6B6B — subtle text
    public var textSubtle: Color { Color(hex: 0x6B6B6B) }

    // #A1A1A1 — disabled
    public var textDisabled: Color { Color(hex: 0xA1A1A1) }
    
    // MARK: - Shapes
    
    public var buttonShape: NoctShape { .pill }
}
