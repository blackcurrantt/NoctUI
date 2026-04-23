//
//  NoctButtonSize.swift
//  NoctUI
//
//  Created by blackcurrantt on 24/04/26.
//

import Foundation

public enum NoctButtonSize {
    case sm, md, lg
}

public extension NoctButtonSize {
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
}
