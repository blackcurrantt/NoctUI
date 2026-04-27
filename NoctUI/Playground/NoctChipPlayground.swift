//
//  NoctChipPlayground.swift
//  NoctUI
//
//  Created by blackCurrantt
//

import SwiftUI

struct NoctChipPlayground: View {
    @Environment(\.noctTheme) private var noctTheme
    @Environment(\.noctTypography) private var noctTypography
    
    private enum Style: CaseIterable, Equatable {
        case filled, outlined
        
        var noct: NoctChipStyle {
            switch self {
            case .filled: .filled
            case .outlined: .outlined
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
    
    var body: some View {
        PlaygroundView(height: 40) {
            NoctChip(
                title: title,
                isSelected: isSelected,
                isEnabled: isEnabled.isOn,
                style: selectedStyle.noct,
                prefixIcon: isPrefixIcon.isOn ? "line.3.horizontal.decrease" : nil,
                suffixIcon: isSuffixIcon.isOn ? "chevron.right" : nil
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
