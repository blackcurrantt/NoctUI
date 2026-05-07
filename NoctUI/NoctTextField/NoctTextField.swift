//
//  NoctTextField.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public enum NoctTextFieldState: Equatable {
    case normal
    case error(String)
    case disabled
}

public struct NoctTextField<Icon: View>: View {
    @Environment(\.noctTheme) private var noctTheme
    
    // MARK: - Properties
    
    @Binding private var text: String
    private let label: String?
    private let placeholder: String?
    private let state: NoctTextFieldState
    private let clearable: Bool
    private let capitalize: Bool
    private let submitLabel: SubmitLabel

    private let icon: (_ color: Color) -> Icon?
    
    @FocusState private var isFocused: Bool
    
    // MARK: - Default Init
    
    public init(
        text: Binding<String>,
        label: String? = nil,
        placeholder: String? = nil,
        state: NoctTextFieldState = .normal,
        clearable: Bool = true,
        capitalize: Bool = false,
        submitLabel: SubmitLabel = .done,
        @ViewBuilder icon: @escaping (_ color: Color) -> Icon? = { _ in nil },
    ) {
        self._text = text
        self.label = label
        self.placeholder = placeholder
        self.state = state
        self.clearable = clearable
        self.capitalize = capitalize
        self.submitLabel = submitLabel
        self.icon = icon
    }
    
    // MARK: - NoctIcon init
    
    public init(
        text: Binding<String>,
        label: String? = nil,
        placeholder: String? = nil,
        icon: String? = nil,
        state: NoctTextFieldState = .normal,
        clearable: Bool = true,
        capitalize: Bool = false,
        submitLabel: SubmitLabel = .done,
    ) where Icon == NoctIcon {
        self._text = text
        self.label = label
        self.placeholder = placeholder
        self.state = state
        self.clearable = clearable
        self.capitalize = capitalize
        self.submitLabel = submitLabel
        self.icon = { color in
            guard let icon else { return nil }
            return NoctIcon(icon, size: .lg, color: color)
        }
    }
    
    // MARK: - Body
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let label {
                Text(label)
                    .foregroundStyle(noctTheme.textDefault)
                    .noctTextStyle(.caption)
            }
            
            HStack(spacing: 8) {
                if let icon = icon(iconColor) {
                    icon
                }
                
                ZStack(alignment: .leading) {
                    if let placeholder, text.isEmpty {
                        Text(placeholder)
                            .foregroundStyle(noctTheme.textSubtle)
                    }
                    
                    TextField("", text: $text)
                        .textInputAutocapitalization(capitalize ? .sentences : .never)
                        .disableAutocorrection(true)
                        .submitLabel(submitLabel)
                        .noctTextStyle(.body())
                        .foregroundStyle(textColor)
                        .focused($isFocused)
                        .disabled(isDisabled)
                }
                
                if clearable, !isDisabled {
                    if !text.isEmpty {
                        Button {
                            text = ""
                        } label: {
                            NoctIcon("xmark.circle.fill", size: .lg, color: iconColor)
                        }
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 16)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .cornerRadius(12)
            .animation(.easeInOut(duration: 0.15), value: isFocused)
            .animation(.easeInOut(duration: 0.15), value: state)
            
            ZStack {
                if case let .error(message) = state {
                    Text(message)
                        .foregroundStyle(noctTheme.error)
                        .noctTextStyle(.caption)
                }
            }
            .frame(height: 14)
        }
    }
}

// MARK: - Styling

private extension NoctTextField {
    var isDisabled: Bool {
        if case .disabled = state { return true }
        return false
    }
    
    var iconColor: Color {
        isDisabled ? noctTheme.textDisabled : noctTheme.textSubtle
    }
    
    var textColor: Color {
        isDisabled ? noctTheme.textDisabled : noctTheme.textDefault
    }
    
    var backgroundColor: Color {
        isDisabled ? noctTheme.muted : noctTheme.surface
    }
    
    var borderColor: Color {
        switch state {
        case .error:
            return noctTheme.error
        case .disabled:
            return noctTheme.border
        case .normal:
            return isFocused ? noctTheme.primary : noctTheme.border
        }
    }
    
    var borderWidth: CGFloat {
        isFocused ? 2 : 1.5
    }
}
