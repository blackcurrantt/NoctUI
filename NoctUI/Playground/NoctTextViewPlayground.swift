//
//  NoctTextViewPlayground.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

struct NoctTextViewPlayground: View {
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
    
    private enum Field {
        case text
    }
    @FocusState private var focusedField: Field?
    @State private var text = ""
    
    private var state: NoctTextViewState {
        guard !disabled.isOn else { return .disabled }
        guard !readOnly.isOn else { return .readOnly }
        return text.isEmpty ? .error("Message is required") : .normal
    }
    
    var body: some View {
        PlaygroundView(height: 134) {
            NoctTextView(
                text: $text,
                label: showsLabel.isOn ? "Message" : nil,
                placeholder: showsPlaceholder.isOn ? "Write your message here..." : "",
                hint: showsHint.isOn ? "Share additional details or context here." : nil,
                icon: showsIcon.isOn ? .system("envelope") : nil,
                state: state,
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
    }
}

#Preview {
    NavigationStack {
        NoctTextViewPlayground()
    }
}
