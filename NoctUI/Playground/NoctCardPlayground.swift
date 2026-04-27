//
//  NoctCardPlayground.swift
//  NoctUI
//
//  Created by BlackCurrant on 26/04/26.
//

import SwiftUI

struct NoctCardPlayground: View {
    @Environment(\.noctTheme) private var noctTheme
    
    private enum Shadow: CaseIterable, Equatable {
        case card, elevated, custom
        
        var noct: NoctShadow? {
            switch self {
            case .card: NoctShadow.card
            case .elevated: NoctShadow.elevated
            case .custom: NoctShadow(color: Color(.red), radius: 8, x: 0, y: 2)
            }
        }
    }
    @State private var selectedShadow: Shadow = .card
    
    private enum ColorOption: CaseIterable, Equatable {
        case `default`, custom
    }
    @State private var selectedBackground: ColorOption = .default
    @State private var selectedBorderColor: ColorOption = .default
    
    private enum Border: CaseIterable, Equatable {
        case on, off
    }
    @State private var selectedBorder: Border = .on
    
    private enum Radius: CaseIterable, Equatable {
        case sm, md, lg, custom
    }
    @State private var selectedRadius: Radius = .md
    private var selectedRadiusValue: CGFloat {
        switch selectedRadius {
        case .sm: noctTheme.radius.sm
        case .md: noctTheme.radius.md
        case .lg: noctTheme.radius.lg
        case .custom: 0
        }
    }
    
    private let width: CGFloat = 390
    private let height: CGFloat = 200
    private let springAnimation = Animation.spring(response: 0.35, dampingFraction: 0.8)
    
    var body: some View {
        PlaygroundView(height: height) {
            NoctCard(
                radius: selectedRadiusValue,
                background: selectedBackground == .custom ? Color(.label) : nil,
                border: selectedBorder == .on ? 1 : nil,
                borderColor: selectedBorderColor == .custom ? Color(.red) : nil,
                shadow: selectedShadow.noct
            ) {
                Text("Noct")
                    .frame(maxWidth: width, maxHeight: .infinity)
                    .noctTextStyle(.title())
                    .foregroundColor(selectedBackground == .custom ? Color(.systemBackground) : noctTheme.textDefault)
            }
            .animation(springAnimation, value: selectedShadow)
            .animation(springAnimation, value: selectedBackground)
            .animation(springAnimation, value: selectedBorder)
            .animation(springAnimation, value: selectedBorderColor)
            .animation(springAnimation, value: selectedRadius)
        } config: {
            PlaygroundSection("Shadow") {
                PlaygroundPicker($selectedShadow)
            }
            PlaygroundSection("Background") {
                PlaygroundPicker($selectedBackground)
            }
            PlaygroundSection("Border") {
                PlaygroundPicker($selectedBorder)
            }
            PlaygroundSection("BorderColor") {
                PlaygroundPicker($selectedBorderColor)
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
