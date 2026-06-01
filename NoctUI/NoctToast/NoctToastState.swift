//
//  NoctToastState.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import Foundation
import SwiftUI

public enum NoctToastDuration {
    public static let `default`: TimeInterval = 3.0

    static let maximumNanoseconds =
        (UInt64.max / nanosecondsPerSecond) * nanosecondsPerSecond

    private static let nanosecondsPerSecond: UInt64 = 1_000_000_000

    static func nanoseconds(for duration: TimeInterval) -> UInt64 {
        guard duration.isFinite, duration > 0 else { return 0 }

        let maximumSeconds = maximumNanoseconds / nanosecondsPerSecond
        guard duration < TimeInterval(maximumSeconds) else {
            return maximumNanoseconds
        }

        let seconds = UInt64(duration)
        let fractionalNanoseconds = UInt64(
            (duration - TimeInterval(seconds))
                * TimeInterval(nanosecondsPerSecond)
        )

        return seconds * nanosecondsPerSecond + fractionalNanoseconds
    }
}

public enum NoctToastPosition {
    case top, bottom
}

public struct NoctToastState: Identifiable, Equatable {
    public let id = UUID()
    
    let message: String
    let title: String?
    let icon: NoctIcon?
    let duration: TimeInterval
    let position: NoctToastPosition
    let background: Color?
    let foreground: Color?
    let backgroundProvider: ((NoctTheme) -> Color)?
    let foregroundProvider: ((NoctTheme) -> Color)?
    let dismissible: Bool
    let action: NoctToastAction?

    public init(
        _ message: String,
        title: String? = nil,
        icon: NoctIcon? = nil,
        duration: TimeInterval = NoctToastDuration.default,
        position: NoctToastPosition = .top,
        background: Color? = nil,
        foreground: Color? = nil,
        dismissible: Bool = true,
        action: NoctToastAction? = nil
    ) {
        self.message = message
        self.title = title
        self.icon = icon
        self.duration = duration
        self.position = position
        self.background = background
        self.foreground = foreground
        self.backgroundProvider = nil
        self.foregroundProvider = nil
        self.dismissible = dismissible
        self.action = action
    }
    
    init(
        message: String,
        title: String? = nil,
        icon: NoctIcon? = nil,
        duration: TimeInterval = NoctToastDuration.default,
        position: NoctToastPosition = .top,
        backgroundProvider: @escaping (NoctTheme) -> Color,
        foregroundProvider: @escaping (NoctTheme) -> Color,
        dismissible: Bool = true,
        action: NoctToastAction? = nil
    ) {
        self.message = message
        self.title = title
        self.icon = icon
        self.duration = duration
        self.position = position
        self.background = nil
        self.foreground = nil
        self.backgroundProvider = backgroundProvider
        self.foregroundProvider = foregroundProvider
        self.dismissible = dismissible
        self.action = action
    }
    
    public static func == (lhs: NoctToastState, rhs: NoctToastState) -> Bool {
        lhs.id == rhs.id
    }
}
