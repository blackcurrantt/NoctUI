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
        dismissible: Bool = true,
        action: NoctToastAction? = nil
    ) -> NoctToastState {
        NoctToastState(
            message: message,
            duration: duration,
            position: position,
            backgroundProvider: { $0.success },
            foregroundProvider: { $0.textInverse },
            dismissible: dismissible,
            action: action
        )
    }
    
    static func warning(
        _ message: String,
        duration: TimeInterval = NoctToastDuration.default,
        position: NoctToastPosition = .top,
        dismissible: Bool = true,
        action: NoctToastAction? = nil
    ) -> NoctToastState {
        NoctToastState(
            message: message,
            duration: duration,
            position: position,
            backgroundProvider: { $0.warning },
            foregroundProvider: { $0.textInverse },
            dismissible: dismissible,
            action: action
        )
    }
    
    static func error(
        _ message: String,
        duration: TimeInterval = NoctToastDuration.default,
        position: NoctToastPosition = .top,
        dismissible: Bool = true,
        action: NoctToastAction? = nil
    ) -> NoctToastState {
        NoctToastState(
            message: message,
            duration: duration,
            position: position,
            backgroundProvider: { $0.error },
            foregroundProvider: { $0.textInverse },
            dismissible: dismissible,
            action: action
        )
    }
    
    static func info(
        _ message: String,
        duration: TimeInterval = NoctToastDuration.default,
        position: NoctToastPosition = .top,
        dismissible: Bool = true,
        action: NoctToastAction? = nil
    ) -> NoctToastState {
        NoctToastState(
            message: message,
            duration: duration,
            position: position,
            backgroundProvider: { $0.info },
            foregroundProvider: { $0.textInverse },
            dismissible: dismissible,
            action: action
        )
    }
}
