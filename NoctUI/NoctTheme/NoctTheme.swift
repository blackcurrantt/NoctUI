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
    var card: Color { get }
    
    // MARK: - Text Colors
    var textDefault: Color { get }
    var textInverse: Color { get }
    var textSubtle: Color { get }
    var textDisabled: Color { get }
    
    // MARK: - Shapes
    var buttonShape: NoctShape { get }
}
