//
//  NoctDefaultTypography.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctDefaultTypography: NoctTypography {
    public init() {}

    public func font(for style: NoctTypographyStyle) -> Font {
        switch style {
        case .title(.lg):
            return .system(size: 24, weight: .bold)

        case .title(.md):
            return .system(size: 20, weight: .semibold)

        case .title(.sm):
            return .system(size: 18, weight: .semibold)
            
        case .body(.lg):
            return .system(size: 18)

        case .body(.md):
            return .system(size: 16)

        case .body(.sm):
            return .system(size: 14)

        case .caption:
            return .system(size: 12)
        }
    }

    public func lineSpacing(for style: NoctTypographyStyle) -> CGFloat {
        switch style {
        case .title: return 3
        case .body: return 2
        case .caption: return 1
        }
    }
}
