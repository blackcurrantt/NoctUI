//
//  NoctTextFieldPlayground.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

struct NoctTextFieldPlayground: View {
    @Environment(\.noctTheme) private var noctTheme
    
    private enum Option: CaseIterable, Equatable {
        case on, off
        var isOn: Bool { self == .on }
    }
    @State private var showsLabel: Option = .on
    @State private var showsPlaceholder: Option = .on
    @State private var showsHint: Option = .on
    @State private var showsIcon: Option = .on
    @State private var capitalize: Option = .off
    @State private var disabled: Option = .off
    @State private var readOnly: Option = .off
    
    private enum Accessory: String, CaseIterable, Equatable {
        case clear, secure
        case secureRevealable = "secure + revealable"
        case chevron, none
        var noct: NoctTextFieldAccessory? {
            switch self {
            case .clear: .clear
            case .secure: .secure(revealable: false)
            case .secureRevealable: .secure()
            case .chevron: .chevron
            case .none: nil
            }
        }
    }
    @State private var selectedAccessory: Accessory = .clear
    
    private enum Field {
        case text
    }
    @FocusState private var focusedField: Field?
    
    @State private var text = "noct@blackcurrantt.com"
    @State private var label: String = "Email"
    @State private var placeholder: String = "example@mail.com"
    @State private var hint: String = "Please enter a valid email"
    @State private var icon: NoctIcon = .system("envelope")
    @State private var errorMessage: String = "Email is required"
    
    private var state: NoctTextFieldState {
        guard !disabled.isOn else { return .disabled }
        guard !readOnly.isOn else { return .readOnly }
        if selectedAccessory == .secure || selectedAccessory == .secureRevealable {
            return text.count < 8 ? .error(errorMessage) : .normal
        }
        return text.isEmpty ? .error(errorMessage) : .normal
    }
    
    var body: some View {
        PlaygroundView(height: 60) {
            NoctTextField(
                text: $text,
                label: showsLabel.isOn ? label : nil,
                placeholder: showsPlaceholder.isOn ? placeholder : "",
                hint: showsHint.isOn ? hint : nil,
                icon: showsIcon.isOn ? icon : nil,
                state: state,
                accessory: selectedAccessory.noct,
                capitalize: capitalize.isOn,
                submitLabel: .done
            )
            .focused($focusedField, equals: .text)
        } config: {
            PlaygroundSection("Label") {
                PlaygroundPicker($showsLabel)
            }
            PlaygroundSection("Placeholder") {
                PlaygroundPicker($showsPlaceholder)
            }
            PlaygroundSection("Hint") {
                PlaygroundPicker($showsHint)
            }
            PlaygroundSection("Icon") {
                PlaygroundPicker($showsIcon)
            }
            PlaygroundSection("Accessory") {
                PlaygroundVariantPicker($selectedAccessory)
            }
            PlaygroundSection("Capitalize") {
                PlaygroundPicker($capitalize)
            }
            PlaygroundSection("Disabled") {
                PlaygroundPicker($disabled)
            }
            PlaygroundSection("Read Only") {
                PlaygroundPicker($readOnly)
            }
        }
        .onTapGesture {
            focusedField = nil
        }
        .onChange(of: capitalize) { _,_ in
            text = ""
            focusedField = nil
        }
        .onChange(of: selectedAccessory) { _, newValue in
            switch newValue {
            case .clear, .none:
                text = "noct@blackcurrantt.com"
                label = "Email"
                placeholder = "example@mail.com"
                hint = "Please enter a valid email"
                icon = .system("envelope")
                errorMessage = "Email is required"

            case .secure, .secureRevealable:
                text = "password"
                label = "Password"
                placeholder = "enter password"
                hint = "Password at least 8 characters"
                icon = .system("key")
                errorMessage = "Invalid password"

            case .chevron:
                text = "ID"
                label = "Country"
                placeholder = "Input country code"
                hint = "Please enter a valid country code"
                icon = .system("globe")
                errorMessage = "Country is required"
            }
        }
    }
}

#Preview {
    NavigationStack {
        NoctTextFieldPlayground()
    }
}
