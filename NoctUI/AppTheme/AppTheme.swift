//
//  AppTheme.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public enum AppTheme {
    case lunar, solar
    
    public var noct: NoctTheme {
        switch self {
        case .lunar: return LunarTheme()
        case .solar: return SolarTheme()
        }
    }
}

private struct AppThemeKey: EnvironmentKey {
    static let defaultValue: Binding<AppTheme> = .constant(.lunar)
}

public extension EnvironmentValues {
    var appTheme: Binding<AppTheme> {
        get { self[AppThemeKey.self] }
        set { self[AppThemeKey.self] = newValue }
    }
}
