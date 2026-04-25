//
//  NoctButtonStyle+Variant.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public extension NoctButtonStyle {
    static func primary(_ dimension: NoctButtonDimension = .md) -> NoctButtonStyle {
        NoctButtonStyle(
            dimension: dimension,
            backgroundProvider: { $0.primary },
            foregroundProvider: { $0.textInverse }
        )
    }

    static func secondary(_ dimension: NoctButtonDimension = .md) -> NoctButtonStyle {
        NoctButtonStyle(
            dimension: dimension,
            backgroundProvider: { $0.secondary },
            foregroundProvider: { $0.textDefault }
        )
    }
}
