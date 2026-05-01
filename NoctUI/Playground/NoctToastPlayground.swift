//
//  NoctToastPlayground.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

struct NoctToastPlayground: View {
    @Environment(\.noctTheme) private var noctTheme
    
    private enum Variant: String, CaseIterable, Equatable {
        case normal, success, warning, error, info, custom
    }
    @State private var selectedVariant: Variant = .normal
    
    private enum Position: CaseIterable, Equatable {
        case top, bottom
        
        var noct: NoctToastPosition {
            switch self {
            case .top: .top
            case .bottom: .bottom
            }
        }
    }
    @State private var selectedPosition: Position = .top
    
    private var currentState: NoctToastState {
        let message = "Noct"
        switch selectedVariant {
        case .normal:
            return NoctToastState(
                message,
                position: selectedPosition.noct
            )
        case .success:
            return NoctToastState.success(
                message,
                position: selectedPosition.noct
            )
        case .warning:
            return NoctToastState.warning(
                message,
                position: selectedPosition.noct
            )
        case .error:
            return NoctToastState.error(
                message,
                position: selectedPosition.noct
            )
        case .info:
            return NoctToastState.info(
                message,
                position: selectedPosition.noct
            )
        case .custom:
            return NoctToastState(
                message,
                position: selectedPosition.noct,
                background: Color(.label),
                foreground: Color(.systemBackground)
            )
        }
    }
    
    var body: some View {
        NoctToastContainer {
            PlaygroundView(height: 90) {
                VStack {
                    Spacer()
                    Button("Show Toast") {
                        NoctToast.show(currentState)
                    }
                    .buttonStyle(NoctButtonStyle.primary())
                }
            } config: {
                PlaygroundSection("Variant") {
                    PlaygroundVariantPicker($selectedVariant)
                }
                PlaygroundSection("Position") {
                    PlaygroundPicker($selectedPosition)
                }
            }
        }
    }
}
