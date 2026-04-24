//
//  PlaygroundPicker.swift
//  NoctUI
//
//  Created by blackcurrant
//

import SwiftUI

struct PlaygroundPicker<T: Hashable & CaseIterable>: View where T.AllCases: RandomAccessCollection {
    @Binding private var selection: T

    init(_ selection: Binding<T>) {
        self._selection = selection
    }

    var body: some View {
        Picker("", selection: $selection) {
            ForEach(Array(T.allCases), id: \.self) { value in
                Text(label(for: value))
                    .tag(value)
            }
        }
        .pickerStyle(.segmented)
    }

    private func label(for value: T) -> String {
        if let raw = value as? any RawRepresentable,
           let string = raw.rawValue as? String {
            return string
        }
        return String(describing: value)
    }
}
