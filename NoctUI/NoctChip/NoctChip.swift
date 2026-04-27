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
    
    @ViewBuilder let prefix: () -> Prefix
    @ViewBuilder let suffix: () -> Suffix
    
    let title: String
    let isSelected: Bool
    let isEnabled: Bool
    let style: NoctChipStyle
    let action: () -> Void
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                prefix()
                Text(title)
                    .noctTextStyle(.body(), weight: isSelected ? .bold : .regular)
                suffix()
            }
            .foregroundStyle(textColor)
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
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

extension NoctChip where Prefix == EmptyView, Suffix == EmptyView {
    public init(
        title: String,
        isSelected: Bool = false,
        isEnabled: Bool = true,
        style: NoctChipStyle = .filled,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isSelected = isSelected
        self.isEnabled = isEnabled
        self.style = style
        self.action = action
        self.prefix = { EmptyView() }
        self.suffix = { EmptyView() }
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
