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
        let size = fontSize(for: style)
        switch style {
        case .title(.lg):
            return .system(size: size, weight: .bold)
        case .title(.md):
            return .system(size: size, weight: .semibold)
        case .title(.sm):
            return .system(size: size, weight: .semibold)
        default:
            return .system(size: size)
        }
    }
    
    public func fontSize(for style: NoctTypographyStyle) -> CGFloat {
        switch style {
        case .title(.lg):
            return 24
        case .title(.md):
            return 20
        case .title(.sm):
            return 18
        case .body(.lg):
            return 18
        case .body(.md):
            return 16
        case .body(.sm):
            return 14
        case .caption:
            return 12
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
