//
//  NoctTextView.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public enum NoctTextViewState: Equatable {
    case normal
    case error(String)
    case disabled
    case readOnly
}

public struct NoctTextView: View {
    @Environment(\.noctTheme) private var noctTheme
    @Environment(\.noctTypography) private var noctTypography
    @Environment(\.isEnabled) private var environmentIsEnabled

    // MARK: - Properties

    @Binding private var text: String
    private let label: String?
    private let placeholder: String?
    private let hint: String?
    private let icon: NoctIcon?
    private let state: NoctTextViewState
    private let capitalize: Bool
    private let submitLabel: SubmitLabel
    private let onSubmit: (() -> Void)?
    private let height: CGFloat

    @FocusState private var isFocused: Bool

    // MARK: - Init

    public init(
        text: Binding<String>,
        label: String? = nil,
        placeholder: String? = nil,
        hint: String? = nil,
        icon: NoctIcon? = nil,
        state: NoctTextViewState = .normal,
        capitalize: Bool = true,
        submitLabel: SubmitLabel = .return,
        onSubmit: (() -> Void)? = nil,
        height: CGFloat = 120
    ) {
        self._text = text
        self.label = label
        self.placeholder = placeholder
        self.hint = hint
        self.icon = icon
        self.state = state
        self.capitalize = capitalize
        self.submitLabel = submitLabel
        self.onSubmit = onSubmit
        self.height = height
    }

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let label {
                Text(label)
                    .foregroundStyle(noctTheme.textDefault)
                    .noctTextStyle(.caption)
            }

            HStack(alignment: .top, spacing: 8) {
                if let icon {
                    NoctIconView(icon, size: .md, color: iconColor)
                }

                ZStack(alignment: .topLeading) {
                    if let placeholder, text.isEmpty {
                        Text(placeholder)
                            .foregroundStyle(noctTheme.textSubtle)
                            .noctTextStyle(textStyle)
                    }

                    TextEditor(text: $text)
                        .scrollContentBackground(.hidden)
                        .textInputAutocapitalization(
                            capitalize ? .sentences : .never
                        )
                        .disableAutocorrection(true)
                        .submitLabel(submitLabel)
                        .foregroundStyle(textColor)
                        .noctTextStyle(textStyle)
                        .frame(height: height)
                        .focused($isFocused)
                        .disabled(disabled)
                        .padding(.horizontal, -4)
                        .padding(.vertical, -8)
                        .onSubmit {
                            onSubmit?()
                        }
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
}

// MARK: - Styling

private extension NoctTextView {
    var isDisabled: Bool {
        if case .disabled = state { return true }
        return false
    }
    
    var isReadOnly: Bool {
        if case .readOnly = state { return true }
        return false
    }
    
    var disabled: Bool {
        isDisabled || isReadOnly
    }
    
    var textStyle: NoctTypographyStyle {
        .body()
    }

    var iconColor: Color {
        isEffectivelyDisabled ? noctTheme.textDisabled : noctTheme.textSubtle
    }

    var textColor: Color {
        isEffectivelyDisabled ? noctTheme.textDisabled : noctTheme.textDefault
    }

    var backgroundColor: Color {
        isEffectivelyDisabled ? noctTheme.muted : noctTheme.surface
    }

    var borderColor: Color {
        guard !isEffectivelyDisabled else { return noctTheme.border }

        switch state {
        case .error:
            return noctTheme.error
        default:
            return isFocused ? noctTheme.primary : noctTheme.border
        }
    }
    
    var borderWidth: CGFloat {
        isFocused && !isEffectivelyDisabled ? 2 : 1.5
    }

    var isEffectivelyDisabled: Bool {
        isDisabled || !environmentIsEnabled
    }
}
