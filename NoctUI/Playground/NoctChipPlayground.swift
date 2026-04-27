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
    }
    @State private var isEnabled: Enabled = .on
    
    @State private var isSelected: Bool = false
    
    var body: some View {
        PlaygroundView(height: 40) {
            NoctChip(
                title: "Noct",
                isSelected: isSelected,
                isEnabled: isEnabled == .on,
                style: selectedStyle.noct
            ) {
                isSelected.toggle()
            }
        } config: {
            PlaygroundSection("Style") {
                PlaygroundPicker($selectedStyle)
            }
            PlaygroundSection("Enabled") {
                PlaygroundPicker($isEnabled)
            }
        }
    }
}

#Preview {
    NavigationStack {
        NoctChipPlayground()
    }
}
