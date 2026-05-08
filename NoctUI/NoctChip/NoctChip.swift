//
//  NoctChip.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctChip: View {
    @Environment(\.noctTheme) private var noctTheme
    
    private let title: String
    private let style: NoctChipStyle
    private let isSelected: Bool
    private let isEnabled: Bool
    private let prefixIcon: NoctIcon?
    private let suffixIcon: NoctIcon?
    private let action: () -> Void
    
    // MARK: - Init
    
    public init(
        title: String,
        style: NoctChipStyle = .filled,
        isSelected: Bool = false,
        isEnabled: Bool = true,
        prefixIcon: NoctIcon? = nil,
        suffixIcon: NoctIcon? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isSelected = isSelected
        self.isEnabled = isEnabled
        self.style = style
        self.prefixIcon = prefixIcon
        self.suffixIcon = suffixIcon
        self.action = action
    }

    
    // MARK: - Body
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let prefixIcon {
                    NoctIconView(prefixIcon, size: .xs, color: textColor)
                }
                
                Text(title)
                    .noctTextStyle(.body(), weight: isSelected ? .bold : .regular)
                
                if let suffixIcon {
                    NoctIconView(suffixIcon, size: .xs, color: textColor)
                }
            }
            .foregroundStyle(textColor)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(
                Capsule()
                    .fill(backgroundColor)
            )
            .overlay(
                Capsule()
                    .stroke(borderColor, lineWidth: borderWidth)
            )
        }
        .buttonStyle(NoctChipPressStyle())
        .disabled(!isEnabled)
    }
}

private struct NoctChipPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.7 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

private extension NoctChip {
    var backgroundColor: Color {
        guard isEnabled else { return noctTheme.muted }
        switch style {
        case .filled:
            return isSelected ? noctTheme.primary : noctTheme.secondary
        case .outlined:
            return noctTheme.surface
        case let .custom(custom):
            return isSelected ? custom.backgroundColor.selected : custom.backgroundColor.normal
        }
    }
    
    var borderColor: Color {
        guard isEnabled else { return noctTheme.muted }
        switch style {
        case .outlined:
            return isSelected ? noctTheme.primary : noctTheme.border
        case let .custom(custom):
            return isSelected ? custom.borderColor.selected : custom.borderColor.normal
        default:
            return .clear
        }
    }
    
    var borderWidth: CGFloat {
        switch style {
        case .outlined:
            return 2
        case let .custom(custom):
            return custom.borderWidth
        default:
            return 0
        }
    }
    
    var textColor: Color {
        guard isEnabled else { return noctTheme.textDisabled }
        switch style {
        case .filled:
            return noctTheme.textDefault
        case .outlined:
            return isSelected ? noctTheme.primary : noctTheme.textDefault
        case let .custom(custom):
            return isSelected ? custom.textColor.selected : custom.textColor.normal
        }
    }
}
