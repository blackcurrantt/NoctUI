//
//  LunarTheme.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct LunarTheme: NoctTheme {
    public init() {}
    
    // MARK: - Colors
    
    // #5C75BF — moonlight blue
    public var primary: Color { Color(hex: 0x5C75BF) }
    
    // #383D4D — muted slate
    public var secondary: Color { Color(hex: 0x383D4D) }

    // #121318 — deep night
    public var card: Color { Color(hex: 0x121318) }

    // MARK: - Text Colors

    public var textDefault: Color { Color.white }
    
    public var textInverse: Color { Color.white }

    public var textSubtle: Color { Color.white.opacity(0.7) }

    public var textDisabled: Color { Color.white.opacity(0.4) }
}
