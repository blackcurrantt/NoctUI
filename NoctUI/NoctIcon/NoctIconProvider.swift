//
//  NoctIconProvider.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import Foundation

public struct NoctIconProvider {
    private let resolver: (NoctIconToken) -> NoctIcon?
    private let fallbackResolver: ((NoctIconToken) -> NoctIcon?)?

    public init(
        fallback: NoctIconProvider? = .system,
        _ resolver: @escaping (NoctIconToken) -> NoctIcon?
    ) {
        self.resolver = resolver
        self.fallbackResolver = fallback?.icon(for:)
    }

    public init() {
        self = .system
    }

    public func icon(for token: NoctIconToken) -> NoctIcon? {
        resolver(token) ?? fallbackResolver?(token)
    }
    
    public func fallback(to fallback: NoctIconProvider) -> NoctIconProvider {
        NoctIconProvider(fallback: nil) { token in
            icon(for: token) ?? fallback.icon(for: token)
        }
    }
}

public extension NoctIconProvider {
    static let system = NoctIconProvider(fallback: nil) { token in
        switch token {
        case .success:
            return .system("checkmark.circle.fill")
        case .warning:
            return .system("exclamationmark.triangle.fill")
        case .error:
            return .system("xmark.circle.fill")
        case .info:
            return .system("info.circle.fill")
        case .close:
            return .system("xmark")
        case .clear:
            return .system("xmark.circle.fill")
        case .eye:
            return .system("eye")
        case .eyeOff:
            return .system("eye.slash")
        case .chevronUp:
            return .system("chevron.up")
        case .chevronDown:
            return .system("chevron.down")
        case .chevronLeft:
            return .system("chevron.left")
        case .chevronRight:
            return .system("chevron.right")
        default:
            return nil
        }
    }
}
