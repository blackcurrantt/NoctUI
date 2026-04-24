//
//  NoctButtonPlayground.swift
//  NoctUI
//
//  Created by blackcurrantt
//

import SwiftUI

struct NoctButtonPlayground: View {
    enum Variant: String, CaseIterable {
        case primary, secondary
    }
    @State private var selectedVariant: Variant = .primary
    
    enum Dimension: CaseIterable {
        case sm, md, lg

        var noct: NoctButtonDimension {
            switch self {
            case .sm: .sm
            case .md: .md
            case .lg: .lg
            }
        }
    }
    @State private var selectedDimension: Dimension = .md
    
    private var currentStyle: NoctButtonStyle {
        switch selectedVariant {
        case .primary:
            return .primary(selectedDimension.noct)
        case .secondary:
            return .secondary(selectedDimension.noct)
        }
    }

    var body: some View {
        PlaygroundView(height: NoctButtonDimension.lg.height) {
            Button("Noct") { }
                .buttonStyle(currentStyle)
                .animation(.spring(response: 0.35, dampingFraction: 0.8), value: selectedVariant)
                .animation(.spring(response: 0.35, dampingFraction: 0.8), value: selectedDimension)
        } config: {
            PlaygroundSection("Variant") {
                PlaygroundPicker($selectedVariant)
            }

            PlaygroundSection("Dimension") {
                PlaygroundPicker($selectedDimension)
            }
        }
    }
}

#Preview {
    NavigationStack {
        NoctButtonPlayground()
    }
}
