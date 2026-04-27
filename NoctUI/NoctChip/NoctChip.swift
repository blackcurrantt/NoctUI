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

public struct NoctChip<Prefix: View, Suffix: View>: View {
    @Environment(\.noctTheme) private var noctTheme
    @Environment(\.noctTypography) private var noctTypography
    @Environment(\.colorScheme) private var scheme
    
    @ViewBuilder let prefix: (_ textColor: Color) -> Prefix?
    @ViewBuilder let suffix: (_ textColor: Color) -> Suffix?
    
    let title: String
    let isSelected: Bool
    let isEnabled: Bool
    let style: NoctChipStyle
    let action: () -> Void
    
    public init(
        title: String,
        isSelected: Bool = false,
        isEnabled: Bool = true,
        style: NoctChipStyle = .filled,
        prefix: @escaping (_ textColor: Color) -> Prefix? = { _ in nil },
        suffix: @escaping (_ textColor: Color) -> Suffix? = { _ in nil },
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isSelected = isSelected
        self.isEnabled = isEnabled
        self.style = style
        self.prefix = prefix
        self.suffix = suffix
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let prefix = prefix(textColor) {
                    prefix
                } else {
                    Spacer().frame(width: 2)
                }
                
                Text(title)
                    .noctTextStyle(.body(), weight: isSelected ? .bold : .regular)
                
                if let suffix = suffix(textColor) {
                    suffix
                } else {
                    Spacer().frame(width: 2)
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

extension NoctChip where Prefix == NoctIcon, Suffix == NoctIcon {
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
        self.action = action
        self.prefix = { textColor in
            guard let prefixIcon else { return nil }
            return NoctIcon(prefixIcon, size: .sm, color: textColor)
        }
        self.suffix = { textColor in
            guard let suffixIcon else { return nil }
            return NoctIcon(suffixIcon, size: .sm, color: textColor)
        }
    }
}

// MARK: - Custom Prefix & Icon Suffix

extension NoctChip where Suffix == NoctIcon {
    public init(
        title: String,
        isSelected: Bool = false,
        isEnabled: Bool = true,
        style: NoctChipStyle = .filled,
        prefix: @escaping (_ textColor: Color) -> Prefix? = { _ in nil },
        suffixIcon: String? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isSelected = isSelected
        self.isEnabled = isEnabled
        self.style = style
        self.action = action
        self.prefix = prefix
        self.suffix = { textColor in
            guard let suffixIcon else { return nil }
            return NoctIcon(suffixIcon, size: .sm, color: textColor)
        }
    }
}

// MARK: - Icon Prefix & Custom Suffix

extension NoctChip where Prefix == NoctIcon {
    public init(
        title: String,
        isSelected: Bool = false,
        isEnabled: Bool = true,
        style: NoctChipStyle = .filled,
        prefixIcon: String? = nil,
        suffix: @escaping (_ textColor: Color) -> Suffix? = { _ in nil },
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isSelected = isSelected
        self.isEnabled = isEnabled
        self.style = style
        self.action = action
        self.prefix = { textColor in
            guard let prefixIcon else { return nil }
            return NoctIcon(prefixIcon, size: .sm, color: textColor)
        }
        self.suffix = suffix
    }
}
