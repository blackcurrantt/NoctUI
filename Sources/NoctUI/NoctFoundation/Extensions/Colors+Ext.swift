//
//  Colors+Ext.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

extension Color {
    public init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}
