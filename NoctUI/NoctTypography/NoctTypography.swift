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

extension NoctTypography {
    public func lineHeight(for style: NoctTypographyStyle) -> CGFloat {
        let fontSize = fontSize(for: style)
        let lineSpacing = lineSpacing(for: style)
        return fontSize + lineSpacing
    }
}
