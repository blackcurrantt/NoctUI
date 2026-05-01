//
//  NoctToastStatet+Variant.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public extension NoctToastState {
    static func success(
        _ message: String,
        duration: TimeInterval = NoctToastDuration.default,
        position: NoctToastPosition = .top,
    ) -> NoctToastState {
        NoctToastState(
            message: message,
            duration: duration,
            position: position,
            backgroundProvider: { $0.success },
            foregroundProvider: { $0.textInverse }
        )
    }
    
    static func warning(
        _ message: String,
        duration: TimeInterval = NoctToastDuration.default,
        position: NoctToastPosition = .top,
    ) -> NoctToastState {
        NoctToastState(
            message: message,
            duration: duration,
            position: position,
            backgroundProvider: { $0.warning },
            foregroundProvider: { $0.textInverse }
        )
    }
    
    static func error(
        _ message: String,
        duration: TimeInterval = NoctToastDuration.default,
        position: NoctToastPosition = .top,
    ) -> NoctToastState {
        NoctToastState(
            message: message,
            duration: duration,
            position: position,
            backgroundProvider: { $0.error },
            foregroundProvider: { $0.textInverse }
        )
    }
    
    static func info(
        _ message: String,
        duration: TimeInterval = NoctToastDuration.default,
        position: NoctToastPosition = .top,
    ) -> NoctToastState {
        NoctToastState(
            message: message,
            duration: duration,
            position: position,
            backgroundProvider: { $0.info },
            foregroundProvider: { $0.textInverse }
        )
    }
}
