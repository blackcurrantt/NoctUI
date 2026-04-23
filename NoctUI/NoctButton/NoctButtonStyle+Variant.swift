//
//  NoctButtonStyle+Variant.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public extension NoctButtonStyle {
    static func primary(_ size: NoctButtonSize = .md) -> NoctButtonStyle {
        NoctButtonStyle(
            size: size,
            background: NoctColor.primary,
            foreground: .white
        )
    }

    static func secondary(_ size: NoctButtonSize = .md) -> NoctButtonStyle {
        NoctButtonStyle(
            size: size,
            background: NoctColor.secondary,
            foreground: .white
        )
    }
}
