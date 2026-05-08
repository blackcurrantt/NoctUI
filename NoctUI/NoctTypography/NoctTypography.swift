//
//  NoctTypography.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public enum NoctTypographyScale {
    case sm, md, lg
}

public enum NoctTypographyStyle {
    case title(NoctTypographyScale = .md)
    case body(NoctTypographyScale = .md)
    case caption
}

public protocol NoctTypography {
    func font(for style: NoctTypographyStyle) -> Font
    func fontSize(for style: NoctTypographyStyle) -> CGFloat
    func lineHeight(for style: NoctTypographyStyle) -> CGFloat
    func lineSpacing(for style: NoctTypographyStyle) -> CGFloat
}

// MARK: - Default Implementation

extension NoctTypography {
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
    
    public func lineHeight(for style: NoctTypographyStyle) -> CGFloat {
        let fontSize = fontSize(for: style)
        let lineSpacing = lineSpacing(for: style)
        return fontSize + lineSpacing
    }

    public func lineSpacing(for style: NoctTypographyStyle) -> CGFloat {
        switch style {
        case .title: return 3
        case .body: return 2
        case .caption: return 1
        }
    }
}

public struct NoctLunarTypography: NoctTypography {
    public init() {}
}
