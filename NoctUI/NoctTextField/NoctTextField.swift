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
    case readOnly
}

public struct NoctTextField: View {
    @Environment(\.noctTheme) private var noctTheme
    @Environment(\.noctTypography) private var noctTypography
    
    // MARK: - Properties
    
    @Binding private var text: String
    private let label: String?
    private let placeholder: String?
    private let hint: String?
    private let icon: NoctIcon?
    private let state: NoctTextFieldState
    private let accessory: NoctTextFieldAccessory?
    private let capitalize: Bool
    private let submitLabel: SubmitLabel
    
    @FocusState private var isFocused: Bool
    @State private var isRevealed = false
    
    // MARK: - Default Init
    
    public init(
        text: Binding<String>,
        label: String? = nil,
        placeholder: String? = nil,
        hint: String? = nil,
        icon: NoctIcon? = nil,
        state: NoctTextFieldState = .normal,
        accessory: NoctTextFieldAccessory? = nil,
        capitalize: Bool = false,
        submitLabel: SubmitLabel = .done
    ) {
        self._text = text
        self.label = label
        self.placeholder = placeholder
        self.hint = hint
        self.icon = icon
        self.state = state
        self.accessory = accessory
        self.capitalize = capitalize
        self.submitLabel = submitLabel
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
                if let icon {
                    NoctIconView(icon, size: .md, color: iconColor)
                }
                
                ZStack(alignment: .leading) {
                    if let placeholder, text.isEmpty {
                        Text(placeholder)
                            .foregroundStyle(noctTheme.textSubtle)
                            .font(font)
                    }
                    inputField
                }
                
                if let accessory {
                    NoctTextFieldAccessoryView(
                        accessory: accessory,
                        text: $text,
                        state: state,
                        isRevealed: $isRevealed
                    )
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 16)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: noctTheme.radius.md)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .cornerRadius(noctTheme.radius.md)
            .animation(.easeInOut(duration: 0.15), value: isFocused)
            .animation(.easeInOut(duration: 0.15), value: state)
            
            ZStack {
                if case let .error(error) = state {
                    Text(error)
                        .foregroundStyle(noctTheme.error)
                        .noctTextStyle(.caption)
                } else if let hint {
                    Text(hint)
                        .foregroundStyle(noctTheme.textSubtle)
                        .noctTextStyle(.caption)
                }
            }
            .frame(height: noctTypography.lineHeight(for: .caption))
        }
    }
    
    @ViewBuilder
    private var inputField: some View {
        Group {
            if accessory?.isSecure == true && !isRevealed {
                SecureField("", text: $text)
            } else {
                TextField("", text: $text)
            }
        }
        .textInputAutocapitalization(capitalize ? .sentences : .never)
        .disableAutocorrection(true)
        .submitLabel(submitLabel)
        .font(font)
        .foregroundStyle(textColor)
        .focused($isFocused)
        .disabled(state.disabled)
    }
}

// MARK: - Conditions

extension NoctTextFieldState {
    var isDisabled: Bool {
        if case .disabled = self { return true }
        return false
    }
    
    var isReadOnly: Bool {
        if case .readOnly = self { return true }
        return false
    }
    
    var disabled: Bool {
        isDisabled || isReadOnly
    }
}

private extension NoctTextFieldAccessory {
    var isSecure: Bool {
        guard case .secure = self else { return false }
        return true
    }
}

// MARK: - Styling

private extension NoctTextField {
    var font: Font {
        noctTypography.font(for: .body())
    }
    
    var iconColor: Color {
        state.isDisabled ? noctTheme.textDisabled : noctTheme.textSubtle
    }
    
    var textColor: Color {
        state.isDisabled ? noctTheme.textDisabled : noctTheme.textDefault
    }
    
    var backgroundColor: Color {
        state.isDisabled ? noctTheme.muted : noctTheme.surface
    }
    
    var borderColor: Color {
        switch state {
        case .error:
            return noctTheme.error
        case .disabled:
            return noctTheme.border
        default:
            return isFocused ? noctTheme.primary : noctTheme.border
        }
    }
    
    var borderWidth: CGFloat {
        isFocused ? 2 : 1.5
    }
}
