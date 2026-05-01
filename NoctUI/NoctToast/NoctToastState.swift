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

public struct NoctToastAction {
    public enum ViewType {
        case text(String)
        case icon(String)
    }
    
    public let view: ViewType
    public let handler: @MainActor () -> Void
    
    public init(
        _ view: ViewType,
        _ handler: @escaping () -> Void
    ) {
        self.view = view
        self.handler = handler
    }
}

public struct NoctToastState: Identifiable, Equatable {
    public let id = UUID()
    
    let message: String
    let title: String?
    let icon: String?
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
        icon: String? = nil,
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
        icon: String? = nil,
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
