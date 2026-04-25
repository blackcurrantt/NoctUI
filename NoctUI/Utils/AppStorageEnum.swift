//
//  AppStorageEnum.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

@propertyWrapper
public struct AppStorageEnum<T: RawRepresentable>: DynamicProperty where T.RawValue == String {
    @AppStorage private var storedValue: String

    private let defaultValue: T
    
    public var wrappedValue: T {
        get { T(rawValue: storedValue) ?? defaultValue }
        set { storedValue = newValue.rawValue }
    }
    
    public var projectedValue: Binding<T> {
        Binding(
            get: { T(rawValue: storedValue) ?? defaultValue },
            set: { storedValue = $0.rawValue }
        )
    }

    public init(wrappedValue: T, _ key: String) {
        self.defaultValue = wrappedValue
        self._storedValue = AppStorage(wrappedValue: wrappedValue.rawValue, key)
    }
}
