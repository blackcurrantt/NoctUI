//
//  NoctCardPlayground.swift
//  NoctUI
//
//  Created by BlackCurrant on 26/04/26.
//

import SwiftUI

struct NoctCardPlayground: View {
    @Environment(\.noctTheme) private var noctTheme
    @Environment(\.noctTypography) private var noctTypography
    
    private enum Shadow: CaseIterable, Equatable {
        case card, elevated, none
        
        var noct: NoctShadow? {
            switch self {
            case .card: NoctShadow.card
            case .elevated: NoctShadow.elevated
            case .none: nil
            }
        }
    }
    @State private var selectedShadow: Shadow = .card
    
    private enum Border: CaseIterable, Equatable {
        case on, off
    }
    @State private var selectedBorder: Border = .on
    
    private enum Radius: CaseIterable, Equatable {
        case sm, md, lg, none
    }
    @State private var selectedRadius: Radius = .md
    private var selectedRadiusValue: CGFloat {
        switch selectedRadius {
        case .sm: noctTheme.radius.sm
        case .md: noctTheme.radius.md
        case .lg: noctTheme.radius.lg
        case .none: 0
        }
    }
    
    private let width: CGFloat = 390
    private let height: CGFloat = 200
    private let sprintAnimation = Animation.spring(response: 0.35, dampingFraction: 0.8)
    
    var body: some View {
        PlaygroundView(height: height) {
            NoctCard(
                radius: selectedRadiusValue,
                border: selectedBorder == .on ? 1 : nil,
                shadow: selectedShadow.noct
            ) {
                Text("Noct")
                    .frame(maxWidth: width, maxHeight: .infinity)
                    .font(noctTypography.font(for: .title()))
                    .foregroundColor(noctTheme.textDefault)
            }
            .animation(sprintAnimation, value: selectedShadow)
            .animation(sprintAnimation, value: selectedBorder)
            .animation(sprintAnimation, value: selectedRadius)
        } config: {
            PlaygroundSection("Shadow") {
                PlaygroundPicker($selectedShadow)
            }
            PlaygroundSection("Border") {
                PlaygroundPicker($selectedBorder)
            }
            PlaygroundSection("Radius") {
                PlaygroundPicker($selectedRadius)
            }
        }
    }
}

#Preview {
    NavigationStack {
        NoctCardPlayground()
    }
}
