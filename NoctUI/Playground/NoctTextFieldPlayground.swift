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
    @State private var clearable: Option = .on
    @State private var capitalize: Option = .off
    @State private var disabled: Option = .off
    
    private enum Field {
        case email
    }
    @FocusState private var focusedField: Field?
    @State private var email = "noct@blackcurrantt.com"
    
    private var state: NoctTextFieldState {
        guard !disabled.isOn else { return .disabled }
        return email.isEmpty ? .error("Email is required") : .normal
    }
    
    var body: some View {
        PlaygroundView(height: 60) {
            NoctTextField(
                text: $email,
                label: showsLabel.isOn ? "Email" : nil,
                placeholder: showsPlaceholder.isOn ? "example@mail.com" : "",
                hint: showsHint.isOn ? "Please enter a valid email" : nil,
                icon: showsIcon.isOn ? "envelope" : nil,
                state: state,
                clearable: clearable.isOn,
                capitalize: capitalize.isOn,
                submitLabel: .done
            )
            .focused($focusedField, equals: .email)
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
            PlaygroundSection("Clearable") {
                PlaygroundPicker($clearable)
            }
            PlaygroundSection("Capitalize") {
                PlaygroundPicker($capitalize)
            }
            PlaygroundSection("Disabled") {
                PlaygroundPicker($disabled)
            }
        }
        .onTapGesture {
            focusedField = nil
        }
        .onChange(of: capitalize) { _,_ in
            email = ""
            focusedField = nil
        }
    }
}

#Preview {
    NavigationStack {
        NoctTextFieldPlayground()
    }
}
