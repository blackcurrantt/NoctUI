//
//  NoctIcon+Props.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import Foundation

public enum NoctIconContent {
    case system(String)
    case asset(String)
}

public enum NoctIconSize {
    case xs, sm, md, lg, xl
    case custom(CGFloat)
    
    var pointSize: CGFloat {
        switch self {
        case .xs:
            return 12
        case .sm:
            return 14
        case .md:
            return 20
        case .lg:
            return 24
        case .xl:
            return 32
        case let .custom(value):
            return value
        }
    }
}
