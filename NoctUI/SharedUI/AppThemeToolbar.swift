//
//  AppThemeToolbar.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct AppThemeToolbar: ViewModifier {
    @Environment(\.appTheme) private var appTheme
    @Environment(\.noctTheme) private var noctTheme

    public func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation(.easeInOut) {
                            appTheme.wrappedValue =
                            appTheme.wrappedValue == .lunar ? .solar : .lunar
                        }
                    } label: {
                        Image(systemName: appTheme.wrappedValue == .lunar
                            ? "moon.fill"
                            : "sun.max.fill"
                        )
                        .foregroundStyle(noctTheme.primary)
                    }
                }
            }
    }
}

extension View {
    public func appThemeToolbar() -> some View {
        modifier(AppThemeToolbar())
    }
}
