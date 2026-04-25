//
//  NoctTypography.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public protocol NoctTypography {
    func font(for style: NoctTypographyStyle) -> Font
    func lineSpacing(for style: NoctTypographyStyle) -> CGFloat
}

public enum NoctTypographyScale {
    case sm, md, lg
}

public enum NoctTypographyStyle {
    case title(NoctTypographyScale = .md)
    case body(NoctTypographyScale = .md)
    case caption
}
