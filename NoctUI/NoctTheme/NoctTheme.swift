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
    var border: Color { get }
    
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
