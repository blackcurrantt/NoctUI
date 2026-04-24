//
//  NoctUIApp.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

@main
struct NoctUIApp: App {
    @State private var appTheme: AppTheme = .lunar

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.appTheme, $appTheme)
                .noctTheme(appTheme.noct)
        }
    }
}
