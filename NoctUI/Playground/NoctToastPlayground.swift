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
    
    private enum Action: CaseIterable, Equatable {
        case text, icon, none
    }
    @State private var selectedAction: Action = .text
    
    private enum Option: CaseIterable, Equatable {
        case on, off
        
        var isOn: Bool {
            self == .on
        }
    }
    @State private var dismissible: Option = .on
    
    private var currentAction: NoctToastAction? {
        switch selectedAction {
        case .text:
            return NoctToastAction(.text("Action")) {
                
            }
        case .icon:
            return NoctToastAction(.icon("xmark")) {
                NoctToast.dismiss()
            }
        case .none:
            return nil
        }
    }
    
    private var currentState: NoctToastState {
        let message = "Noct"
        switch selectedVariant {
        case .normal:
            return NoctToastState(
                message,
                position: selectedPosition.noct,
                dismissible: dismissible.isOn,
                action: currentAction
            )
        case .success:
            return NoctToastState.success(
                message,
                position: selectedPosition.noct,
                dismissible: dismissible.isOn,
                action: currentAction
            )
        case .warning:
            return NoctToastState.warning(
                message,
                position: selectedPosition.noct,
                dismissible: dismissible.isOn,
                action: currentAction
            )
        case .error:
            return NoctToastState.error(
                message,
                position: selectedPosition.noct,
                dismissible: dismissible.isOn,
                action: currentAction
            )
        case .info:
            return NoctToastState.info(
                message,
                position: selectedPosition.noct,
                dismissible: dismissible.isOn,
                action: currentAction
            )
        case .custom:
            return NoctToastState(
                message,
                position: selectedPosition.noct,
                background: Color(.label),
                foreground: Color(.systemBackground),
                dismissible: dismissible.isOn,
                action: currentAction
            )
        }
    }
    
    var body: some View {
        NoctToastContainer {
            PlaygroundView(height: 140) {
                VStack {
                    Spacer()
                    Button("Show Toast") {
                        NoctToast.show(currentState)
                    }
                    .buttonStyle(NoctButtonStyle.primary())
                    Button("Dismiss") {
                        NoctToast.dismiss()
                    }
                    .buttonStyle(NoctButtonStyle.secondary())
                }
            } config: {
                PlaygroundSection("Variant") {
                    PlaygroundVariantPicker($selectedVariant)
                }
                PlaygroundSection("Position") {
                    PlaygroundPicker($selectedPosition)
                }
                PlaygroundSection("Action") {
                    PlaygroundPicker($selectedAction)
                }
                PlaygroundSection("Dismissible") {
                    PlaygroundPicker($dismissible)
                }
            }
        }
    }
}
