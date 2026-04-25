//
//  NoctButtonDimension.swift
//  NoctUI
//
//  Created by blackcurrantt on 24/04/26.
//

import Foundation

public enum NoctButtonDimension {
    case sm, md, lg
}

public extension NoctButtonDimension {
    var height: CGFloat {
        switch self {
        case .sm: return 32
        case .md: return 44
        case .lg: return 56
        }
    }

    var padding: CGFloat {
        switch self {
        case .sm: return 8
        case .md: return 12
        case .lg: return 16
        }
    }

    var radius: CGFloat {
        switch self {
        case .sm: return NoctRadius.sm
        case .md: return NoctRadius.md
        case .lg: return NoctRadius.lg
        }
    }
    
    var typographyStyle: NoctTypographyStyle {
        switch self {
        case .sm: return .body(.sm)
        case .md: return .body(.md)
        case .lg: return .body(.lg)
        }
    }
}
