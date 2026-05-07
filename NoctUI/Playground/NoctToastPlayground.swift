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
        case text, close, none
    }
    @State private var selectedAction: Action = .text
    
    private enum MessageLength: CaseIterable, Equatable {
        case long, short
    }
    @State private var selectedMessageLength: MessageLength = .long
    
    private enum Option: CaseIterable, Equatable {
        case on, off
        
        var isOn: Bool {
            self == .on
        }
    }
    @State private var showsTitle: Option = .on
    @State private var showsIcon: Option = .on
    @State private var dismissible: Option = .on
    
    private var currentAction: NoctToastAction? {
        switch selectedAction {
        case .text:
            return NoctToastAction.text("Action") { }
        case .close:
            return NoctToastAction.close()
        case .none:
            return nil
        }
    }
    
    private var currentState: NoctToastState {
        let title: String? = showsTitle.isOn ? "Noct" : nil
        let message = selectedMessageLength == .long ? "Noct ipsum dolor sit amet, noctis interface adipiscing elit. Sed do eiusmod tempor incididunt ut labore et nocte magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat." : "The noct toast"
        switch selectedVariant {
        case .normal:
            return NoctToastState(
                message,
                title: title,
                icon: showsIcon.isOn ? NoctIconToken.notification : nil,
                position: selectedPosition.noct,
                dismissible: dismissible.isOn,
                action: currentAction
            )
        case .success:
            return NoctToastState.success(
                message,
                title: title,
                showsIcon: showsIcon.isOn,
                position: selectedPosition.noct,
                dismissible: dismissible.isOn,
                action: currentAction
            )
        case .warning:
            return NoctToastState.warning(
                message,
                title: title,
                showsIcon: showsIcon.isOn,
                position: selectedPosition.noct,
                dismissible: dismissible.isOn,
                action: currentAction
            )
        case .error:
            return NoctToastState.error(
                message,
                title: title,
                showsIcon: showsIcon.isOn,
                position: selectedPosition.noct,
                dismissible: dismissible.isOn,
                action: currentAction
            )
        case .info:
            return NoctToastState.info(
                message,
                title: title,
                showsIcon: showsIcon.isOn,
                position: selectedPosition.noct,
                dismissible: dismissible.isOn,
                action: currentAction
            )
        case .custom:
            return NoctToastState(
                message,
                title: title,
                icon: showsIcon.isOn ? .custom(.system("hourglass")) : nil,
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
            PlaygroundView(height: 116) {
                VStack(spacing: 8) {
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
                PlaygroundSection("Title") {
                    PlaygroundPicker($showsTitle)
                }
                PlaygroundSection("Icon") {
                    PlaygroundPicker($showsIcon)
                }
                PlaygroundSection("Message") {
                    PlaygroundPicker($selectedMessageLength)
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
