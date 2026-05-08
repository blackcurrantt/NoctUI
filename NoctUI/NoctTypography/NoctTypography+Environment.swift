//
//  NoctTypography+Environment.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

private struct NoctTypographyKey: EnvironmentKey {
    static let defaultValue: NoctTypography = NoctLunarTypography()
}

public extension EnvironmentValues {
    var noctTypography: NoctTypography {
        get { self[NoctTypographyKey.self] }
        set { self[NoctTypographyKey.self] = newValue }
    }
}

public extension View {
    func noctTypography(_ typography: NoctTypography) -> some View {
        environment(\.noctTypography, typography)
    }
}
