//
//  NoctIconSet+Token.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import Foundation

public enum NoctIconToken {
    // MARK: Semantic
    case success
    case warning
    case error
    case info

    // MARK: Utility
    case close
    case clear
    case filter
    case search
    case email
    case notification
    case chevronRight
    
    // MARK: Custom
    case custom(NoctIconContent)
}

public protocol NoctIconSet {
    // MARK: Semantic
    var success: NoctIconContent { get }
    var warning: NoctIconContent { get }
    var error: NoctIconContent { get }
    var info: NoctIconContent { get }

    // MARK: Utility
    var close: NoctIconContent { get }
    var clear: NoctIconContent { get }
    var filter: NoctIconContent { get }
    var search: NoctIconContent { get }
    var email: NoctIconContent { get }
    var notification: NoctIconContent { get }
    var chevronRight: NoctIconContent { get }
}

// MARK: - Default Implementation

extension NoctIconSet {
    // MARK: Semantic
    public var success: NoctIconContent { .system("checkmark.circle.fill") }
    public var warning: NoctIconContent { .system("exclamationmark.triangle.fill") }
    public var error: NoctIconContent { .system("xmark.circle.fill") }
    public var info: NoctIconContent { .system("info.circle.fill") }

    // MARK: Utility
    public var close: NoctIconContent { .system("xmark") }
    public var clear: NoctIconContent { .system("xmark.circle.fill") }
    public var filter: NoctIconContent { .system("line.3.horizontal.decrease") }
    public var search: NoctIconContent { .system("magnifyingglass") }
    public var email: NoctIconContent { .system("envelope") }
    public var notification: NoctIconContent { .system("bell.fill") }
    public var chevronRight: NoctIconContent { .system("chevron.right") }
}

public struct NoctLunarIconSet: NoctIconSet {
    public init() {}
}
