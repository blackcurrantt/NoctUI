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
    var background: Color { get }
    
    // MARK: - Text Colors
    var textDefault: Color { get }
    var textSubtle: Color { get }
    var textDisabled: Color { get }
}
