//
//  NoctThemeEnvironment.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

private struct NoctThemeKey: EnvironmentKey {
    static let defaultValue: NoctTheme = LunarTheme()
}

public extension EnvironmentValues {
    var noctTheme: NoctTheme {
        get { self[NoctThemeKey.self] }
        set { self[NoctThemeKey.self] = newValue }
    }
}

public extension View {
    func noctTheme(_ theme: NoctTheme) -> some View {
        environment(\.noctTheme, theme)
    }
}
