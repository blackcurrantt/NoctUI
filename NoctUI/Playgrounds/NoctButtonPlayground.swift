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
    
    enum Size: CaseIterable {
        case sm, md, lg

        var noct: NoctButtonDimension {
            switch self {
            case .sm: .sm
            case .md: .md
            case .lg: .lg
            }
        }
    }
    @State private var selectedSize: Size = .md
    
    private var currentStyle: NoctButtonStyle {
        switch selectedVariant {
        case .primary:
            return .primary(selectedSize.noct)
        case .secondary:
            return .secondary(selectedSize.noct)
        }
    }

    var body: some View {
        PlaygroundView(height: NoctButtonDimension.lg.height) {
            Button("Noct") { }
                .buttonStyle(currentStyle)
        } config: {
            PlaygroundSection("Variant") {
                PlaygroundPicker($selectedVariant)
            }

            PlaygroundSection("Size") {
                PlaygroundPicker($selectedSize)
            }
        }
    }
}

#Preview {
    NavigationStack {
        NoctButtonPlayground()
    }
}
