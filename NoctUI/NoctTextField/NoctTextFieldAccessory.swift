//
//  NoctTextFieldAccessory.swift
//  NoctUI
//
//  Created by BlackCurrant on 09/05/26.
//

import SwiftUI

public enum NoctTextFieldAccessory: Equatable {
    case clear
    case secure(revealable: Bool = true)
    case icon(NoctIcon, Color? = nil)
}

struct NoctTextFieldAccessoryView: View {
    @Environment(\.noctTheme) private var noctTheme
    
    let accessory: NoctTextFieldAccessory
    let text: Binding<String>
    let state: NoctTextFieldState
    
    @Binding var isRevealed: Bool
    
    var body: some View {
        VStack {
            switch accessory {
            case .clear:
                if !state.disabled, !text.wrappedValue.isEmpty {
                    Button {
                        text.wrappedValue = ""
                    } label: {
                        NoctIconView(
                            .clear,
                            size: .sm,
                            color: iconColor
                        )
                    }
                }
                
            case let .secure(revealable):
                if !state.disabled, revealable {
                    Button {
                        isRevealed.toggle()
                    } label: {
                        NoctIconView(
                            isRevealed ? .eyeOff : .eye,
                            size: .md,
                            color: iconColor
                        )
                    }
                }
                
            case let .icon(icon, color):
                NoctIconView(
                    icon,
                    size: .sm,
                    color: color ?? iconColor
                )
            }
        }
        .onChange(of: accessory) { _, _ in
            isRevealed = false
        }
    }
}

// MARK: - Styling

private extension NoctTextFieldAccessoryView {
    var iconColor: Color {
        state.isDisabled
            ? noctTheme.textDisabled
            : noctTheme.textSubtle
    }
}
