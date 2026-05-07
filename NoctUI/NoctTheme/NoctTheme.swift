//
//  NoctTheme.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public protocol NoctTheme {
    // MARK: - Colors
    var primary: Color { get }
    var secondary: Color { get }
    var success: Color { get }
    var warning: Color { get }
    var error: Color { get }
    var info: Color { get }
    var surface: Color { get }
    var muted: Color { get }
    
    // MARK: - Component Colors
    var card: Color { get }
    var border: Color { get }
    var toast: Color { get }
    
    // MARK: - Text Colors
    var textDefault: Color { get }
    var textInverse: Color { get }
    var textSubtle: Color { get }
    var textDisabled: Color { get }
    
    // MARK: - Radius
    var radius: NoctRadius { get }
    
    // MARK: - Shapes
    var buttonShape: NoctShape { get }
}

extension NoctTheme {
    // MARK: - Colors
    
    public var primary: Color { Color(hex: 0x5C75BF) }
    public var secondary: Color { Color(hex: 0x383D4D) }
    public var success: Color { Color(hex: 0x388E3C) }
    public var warning: Color { Color(hex: 0xD9822B) }
    public var error: Color { Color(hex: 0xEF5350) }
    public var info: Color { Color(hex: 0x2F7EDB) }
    public var surface: Color { Color(hex: 0x181A20) }
    public var muted: Color { Color(hex: 0x6B7280) }
    
    // MARK: - Component Colors
    
    public var card: Color { Color(hex: 0x121318) }
    public var border: Color { Color(hex: 0x343843) }
    public var toast: Color { Color(hex: 0x1F1E1F) }
    
    // MARK: - Text Colors

    public var textDefault: Color { Color(hex: 0xFFFFFF) }
    public var textInverse: Color { Color(hex: 0xFFFFFF) }
    public var textSubtle: Color { Color(hex: 0xB0B3BD) }
    public var textDisabled: Color { Color(hex: 0xB0B3BD) }
    
    // MARK: - Radius
    
    public var radius: NoctRadius { NoctRadius(sm: 8, md: 12, lg: 16) }
    
    // MARK: - Shapes
    
    public var buttonShape: NoctShape { .standard }
}

public struct NoctLunarTheme: NoctTheme {
    public init() {}
}
