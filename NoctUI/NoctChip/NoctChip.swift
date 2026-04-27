//
//  NoctChip.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public enum NoctChipStyle {
    case filled, outlined
}

public struct NoctChip: View {
    @Environment(\.noctTheme) private var noctTheme
    @Environment(\.noctTypography) private var noctTypography
    @Environment(\.colorScheme) private var scheme
    
    let title: String
    let isSelected: Bool
    let isEnabled: Bool
    let style: NoctChipStyle
    let prefixIcon: NoctIcon?
    let suffixIcon: NoctIcon?
    let action: () -> Void
    
    public init(
        title: String,
        isSelected: Bool = false,
        isEnabled: Bool = true,
        style: NoctChipStyle = .filled,
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
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let prefixIcon {
                    prefixIcon
                        .color(textColor)
                }
                Text(title)
                    .noctTextStyle(.body(), weight: isSelected ? .bold : .regular)
                if let suffixIcon {
                    suffixIcon
                        .color(textColor)
                }
            }
            .foregroundStyle(textColor)
            .padding(.vertical, 6)
            .padding(.leading, prefixIcon != nil ? 12 : 16)
            .padding(.trailing, suffixIcon != nil ? 12 : 16)
            .background(
                Capsule()
                    .fill(backgroundColor)
            )
            .overlay(
                Capsule()
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .overlay {
                if !isEnabled {
                    Capsule()
                        .fill(Color.black.opacity(scheme == .dark ? 0.5 : 0.2))
                }
            }
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
        switch style {
        case .filled:
            return isSelected ? noctTheme.primary : noctTheme.secondary
        case .outlined:
            return Color(.systemBackground)
        }
    }
    
    var borderColor: Color {
        switch style {
        case .outlined:
            return isSelected ? noctTheme.primary : noctTheme.border
        default:
            return .clear
        }
    }
    
    var borderWidth: CGFloat {
        style == .outlined ? 2 : 0
    }
    
    var textColor: Color {
        switch style {
        case .filled:
            return noctTheme.textDefault
        case .outlined:
            return isSelected ? noctTheme.primary : noctTheme.textDefault
        }
    }
}

// MARK: - Icon Prefix & Icon Suffix

extension NoctChip {
    public init(
        title: String,
        isSelected: Bool = false,
        isEnabled: Bool = true,
        style: NoctChipStyle = .filled,
        prefixIcon: String? = nil,
        suffixIcon: String? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isSelected = isSelected
        self.isEnabled = isEnabled
        self.style = style
        self.prefixIcon = prefixIcon != nil ? NoctIcon(prefixIcon!, size: .sm) : nil
        self.suffixIcon = suffixIcon != nil ? NoctIcon(suffixIcon!, size: .sm) : nil
        self.action = action
    }
}
