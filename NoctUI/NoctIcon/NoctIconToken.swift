//
//  NoctIconToken.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import Foundation

public struct NoctIconToken: Hashable, Sendable {
    public let rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

public extension NoctIconToken {
    // MARK: Semantic
    static let success = NoctIconToken("success")
    static let warning = NoctIconToken("warning")
    static let error = NoctIconToken("error")
    static let info = NoctIconToken("info")

    // MARK: Utility
    static let close = NoctIconToken("close")
    static let clear = NoctIconToken("clear")
    
    // MARK: Navigation
    static let chevronUp = NoctIconToken("chevronUp")
    static let chevronDown = NoctIconToken("chevronDown")
    static let chevronLeft = NoctIconToken("chevronLeft")
    static let chevronRight = NoctIconToken("chevronRight")
}
