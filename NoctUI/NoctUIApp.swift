//
//  NoctUIApp.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

@main
struct NoctUIApp: App {
    @AppStorageEnum("app_theme")
    private var appTheme: AppTheme = .lunar

    var body: some Scene {
        WindowGroup {
            RootView()
                .appTheme($appTheme)
                .preferredColorScheme(appTheme.colorScheme)
                .noctTheme(appTheme.noct)
                .noctTypography(NoctLunarTypography())
        }
    }
}
