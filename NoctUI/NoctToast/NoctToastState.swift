//
//  NoctToastState.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import Observation
import SwiftUI

public enum NoctToastDuration {
    public static let `default`: TimeInterval = 3.0
}

public enum NoctToastPosition {
    case top, bottom
}

public struct NoctToastState: Identifiable {
    public let id = UUID()
    
    let message: String
    let duration: TimeInterval
    let position: NoctToastPosition
    let background: Color?
    let foreground: Color?
    let backgroundProvider: ((NoctTheme) -> Color)?
    let foregroundProvider: ((NoctTheme) -> Color)?

    public init(
        _ message: String,
        duration: TimeInterval = NoctToastDuration.default,
        position: NoctToastPosition = .top,
        background: Color? = nil,
        foreground: Color? = nil
    ) {
        self.message = message
        self.duration = duration
        self.position = position
        self.background = background
        self.foreground = foreground
        self.backgroundProvider = nil
        self.foregroundProvider = nil
    }
    
    init(
        message: String,
        duration: TimeInterval = NoctToastDuration.default,
        position: NoctToastPosition = .top,
        backgroundProvider: @escaping (NoctTheme) -> Color,
        foregroundProvider: @escaping (NoctTheme) -> Color
    ) {
        self.message = message
        self.duration = duration
        self.position = position
        self.background = nil
        self.foreground = nil
        self.backgroundProvider = backgroundProvider
        self.foregroundProvider = foregroundProvider
    }
}
