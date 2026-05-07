//
//  NoctIconSet+Environment.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

private struct NoctIconSetKey: EnvironmentKey {
    static let defaultValue: NoctIconSet = NoctLunarIconSet()
}

public extension EnvironmentValues {
    var noctIconSet: NoctIconSet {
        get { self[NoctIconSetKey.self] }
        set { self[NoctIconSetKey.self] = newValue }
    }
}

public extension View {
    func noctIconSet(_ IconSet: NoctIconSet) -> some View {
        environment(\.noctIconSet, IconSet)
    }
}
