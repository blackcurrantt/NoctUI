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
            backgroundProvider: { $0.primary },
            foregroundProvider: { $0.textDefault }
        )
    }

    static func secondary(_ size: NoctButtonSize = .md) -> NoctButtonStyle {
        NoctButtonStyle(
            size: size,
            backgroundProvider: { $0.secondary },
            foregroundProvider: { $0.textDefault }
        )
    }
}
