//
//  NoctChip.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

public struct NoctChip<Prefix: View, Suffix: View>: View {
    @Environment(\.noctTheme) private var noctTheme
    
    private let prefix: (_ textColor: Color) -> Prefix
    private let suffix: (_ textColor: Color) -> Suffix
    
    private let title: String
    private let style: NoctChipStyle
    private let isSelected: Bool
    private let isEnabled: Bool
    private let action: () -> Void
    
    // MARK: - Default Init
    
    public init(
        title: String,
        style: NoctChipStyle = .filled,
        isSelected: Bool = false,
        isEnabled: Bool = true,
        @ViewBuilder prefix: @escaping (_ textColor: Color) -> Prefix,
        @ViewBuilder suffix: @escaping (_ textColor: Color) -> Suffix,
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
    
    public init(
        title: String,
        style: NoctChipStyle = .filled,
        isSelected: Bool = false,
        isEnabled: Bool = true,
        action: @escaping () -> Void
    ) where Prefix == EmptyView, Suffix == EmptyView {
        self.init(
            title: title,
            style: style,
            isSelected: isSelected,
            isEnabled: isEnabled,
            prefix: { _ in EmptyView() },
            suffix: { _ in EmptyView() },
            action: action
        )
    }
    
    // MARK: - Icon Prefix & Icon Suffix Init
    
    public init(
        title: String,
        style: NoctChipStyle = .filled,
        isSelected: Bool = false,
        isEnabled: Bool = true,
        prefixIcon: NoctIconToken? = nil,
        suffixIcon: NoctIconToken? = nil,
        action: @escaping () -> Void
    ) where Prefix == NoctIcon?, Suffix == NoctIcon? {
        self.title = title
        self.style = style
        self.isSelected = isSelected
        self.isEnabled = isEnabled
        self.action = action
        self.prefix = { textColor in
            guard let prefixIcon else { return nil }
            return NoctIcon(prefixIcon, size: .xs, color: textColor)
        }
        self.suffix = { textColor in
            guard let suffixIcon else { return nil }
            return NoctIcon(suffixIcon, size: .xs, color: textColor)
        }
    }
    
    // MARK: - Custom Prefix & Icon Suffix Init
    
    public init(
        title: String,
        style: NoctChipStyle = .filled,
        isSelected: Bool = false,
        isEnabled: Bool = true,
        @ViewBuilder prefix: @escaping (_ textColor: Color) -> Prefix,
        suffixIcon: NoctIconToken? = nil,
        action: @escaping () -> Void
    ) where Suffix == NoctIcon? {
        self.title = title
        self.style = style
        self.isSelected = isSelected
        self.isEnabled = isEnabled
        self.action = action
        self.prefix = prefix
        self.suffix = { textColor in
            guard let suffixIcon else { return nil }
            return NoctIcon(suffixIcon, size: .xs, color: textColor)
        }
    }
    
    // MARK: - Icon Prefix & Custom Suffix Init
    
    public init(
        title: String,
        style: NoctChipStyle = .filled,
        isSelected: Bool = false,
        isEnabled: Bool = true,
        prefixIcon: NoctIconToken? = nil,
        @ViewBuilder suffix: @escaping (_ textColor: Color) -> Suffix,
        action: @escaping () -> Void
    ) where Prefix == NoctIcon? {
        self.title = title
        self.style = style
        self.isSelected = isSelected
        self.isEnabled = isEnabled
        self.action = action
        self.prefix = { textColor in
            guard let prefixIcon else { return nil }
            return NoctIcon(prefixIcon, size: .xs, color: textColor)
        }
        self.suffix = suffix
    }
    
    // MARK: - Custom Prefix Init
    
    public init(
        title: String,
        style: NoctChipStyle = .filled,
        isSelected: Bool = false,
        isEnabled: Bool = true,
        @ViewBuilder prefix: @escaping (_ textColor: Color) -> Prefix,
        action: @escaping () -> Void
    ) where Suffix == EmptyView {
        self.init(
            title: title,
            style: style,
            isSelected: isSelected,
            isEnabled: isEnabled,
            prefix: prefix,
            suffix: { _ in EmptyView() },
            action: action
        )
    }
    
    // MARK: - Custom Suffix Init
    
    public init(
        title: String,
        style: NoctChipStyle = .filled,
        isSelected: Bool = false,
        isEnabled: Bool = true,
        @ViewBuilder suffix: @escaping (_ textColor: Color) -> Suffix,
        action: @escaping () -> Void
    ) where Prefix == EmptyView {
        self.init(
            title: title,
            style: style,
            isSelected: isSelected,
            isEnabled: isEnabled,
            prefix: { _ in EmptyView() },
            suffix: suffix,
            action: action
        )
    }

    
    // MARK: - Body
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                prefix(textColor)
                
                Text(title)
                    .noctTextStyle(.body(), weight: isSelected ? .bold : .regular)
                
                suffix(textColor)
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
