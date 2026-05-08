//
//  NoctIconProvider+Environment.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

private struct NoctIconProviderKey: EnvironmentKey {
    static let defaultValue: NoctIconProvider = .system
}

public extension EnvironmentValues {
    var noctIconProvider: NoctIconProvider {
        get { self[NoctIconProviderKey.self] }
        set { self[NoctIconProviderKey.self] = newValue }
    }
}

public extension View {
    func noctIconProvider(_ iconProvider: NoctIconProvider) -> some View {
        environment(\.noctIconProvider, iconProvider)
    }
}
