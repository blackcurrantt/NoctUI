//
//  NoctChipPlayground.swift
//  NoctUI
//
//  Created by blackCurrantt
//

import SwiftUI

struct NoctChipPlayground: View {
    @Environment(\.noctTheme) private var noctTheme
    
    private enum Style: CaseIterable, Equatable {
        case filled, outlined, custom
        
        var noct: NoctChipStyle {
            switch self {
            case .filled:
                return .filled
            case .outlined:
                return .outlined
            case .custom:
                return .custom(NoctChipCustomStyle(
                    backgroundColor: NoctChipColor(normal: Color(.label), selected: Color(.systemBackground)),
                    borderColor: NoctChipColor(normal: Color(.systemBackground), selected: Color(.label)),
                    borderWidth: 2,
                    textColor: NoctChipColor(normal: Color(.systemBackground), selected: Color(.label))
                ))
            }
        }
    }
    @State private var selectedStyle: Style = .outlined
    
    private enum Enabled: CaseIterable, Equatable {
        case on, off
        var isOn: Bool { self == .on }
    }
    @State private var isEnabled: Enabled = .on
    @State private var isPrefixIcon: Enabled = .on
    @State private var isSuffixIcon: Enabled = .on
    
    @State private var title: String = "Noct"
    @State private var isSelected: Bool = false {
        didSet {
            title = isSelected ? "Selected" : "Noct"
        }
    }
    
    private let springAnimation = Animation.spring(response: 0.35, dampingFraction: 0.8)
    
    private var currentPrefixIcon: NoctIcon? {
        guard isPrefixIcon.isOn else { return nil }
        return isSelected ? NoctIcon(.clear) : .system("line.3.horizontal.decrease")
    }
    
    var body: some View {
        PlaygroundView(height: 40) {
            NoctChip(
                title: title,
                style: selectedStyle.noct,
                isSelected: isSelected,
                isEnabled: isEnabled.isOn,
                prefixIcon: currentPrefixIcon,
                suffixIcon: isSuffixIcon.isOn ? NoctIcon(.chevronRight) : nil
            ) {
                isSelected.toggle()
            }
            .animation(springAnimation, value: isPrefixIcon)
            .animation(springAnimation, value: isSuffixIcon)
        } config: {
            PlaygroundSection("Style") {
                PlaygroundPicker($selectedStyle)
            }
            PlaygroundSection("Enabled") {
                PlaygroundPicker($isEnabled)
            }
            PlaygroundSection("Prefix Icon") {
                PlaygroundPicker($isPrefixIcon)
            }
            PlaygroundSection("Suffix Icon") {
                PlaygroundPicker($isSuffixIcon)
            }
        }
    }
}

#Preview {
    NavigationStack {
        NoctChipPlayground()
    }
}
